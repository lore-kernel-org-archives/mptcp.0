Content-Type: multipart/mixed; boundary="===============1014639103001112547=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH mptcp-backport] mptcp: fix DATA_FIN generation on
 early shutdown
Date: Thu, 11 Mar 2021 17:21:46 -0800
Message-ID: <20210312012146.108482-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 8104

--===============1014639103001112547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

If the msk is closed before sending or receiving any data,
no DATA_FIN is generated, instead an MPC ack packet is
crafted out.

In the above scenario, the MPTCP protocol creates and sends a
pure ack and such packets matches also the criteria for an
MPC ack and the protocol tries first to insert MPC options,
leading to the described error.

This change addresses the issue by avoiding the insertion of an
MPC option for DATA_FIN packets or if the sub-flow is not
established.

To avoid doing multiple times the same test, fetch the data_fin
flag in a bool variable and pass it to both the interested
helpers.

Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packe=
ts")
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---

This is a backport of d87903b63e3ce1eafaa701aec5cc1d0ecd0d84dc to the
v5.10-stable tree. Paolo and I got email from Greg KH saying the commit
did not apply cleanly on v5.10.

The main reason for that was a call to mptcp_data_fin_enabled(), which
was added as part of "mptcp: refactor shutdown and close":

static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
{
       return READ_ONCE(msk->snd_data_fin_enable) &&
              READ_ONCE(msk->write_seq) =3D=3D READ_ONCE(msk->snd_nxt);
}

That code depends on the introduction of msk->snd_nxt in the same patch
series for v5.11. In this backport I just used
READ_ONCE(msk->snd_data_fin_enable).

This only changes v5.10 behavior before sending any data, so it *seems*
like this approach to the backport is workable. The self tests are
successful but don't have coverage for this fix.

What do you think Paolo?


Thanks,

Mat



 net/mptcp/options.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a044dd43411d..78f9c7fecbc9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -388,6 +388,7 @@ static void clear_3rdack_retransmission(struct sock *sk)
 }
 =

 static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *=
skb,
+					 bool snd_data_fin_enable,
 					 unsigned int *size,
 					 unsigned int remaining,
 					 struct mptcp_out_options *opts)
@@ -405,9 +406,10 @@ static bool mptcp_established_options_mp(struct sock *=
sk, struct sk_buff *skb,
 	if (!skb)
 		return false;
 =

-	/* MPC/MPJ needed only on 3rd ack packet */
-	if (subflow->fully_established ||
-	    subflow->snd_isn !=3D TCP_SKB_CB(skb)->seq)
+	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown take =
precedence */
+	if (subflow->fully_established || snd_data_fin_enable ||
+	    subflow->snd_isn !=3D TCP_SKB_CB(skb)->seq ||
+	    sk->sk_state !=3D TCP_ESTABLISHED)
 		return false;
 =

 	if (subflow->mp_capable) {
@@ -479,6 +481,7 @@ static void mptcp_write_data_fin(struct mptcp_subflow_c=
ontext *subflow,
 }
 =

 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff =
*skb,
+					  bool snd_data_fin_enable,
 					  unsigned int *size,
 					  unsigned int remaining,
 					  struct mptcp_out_options *opts)
@@ -486,13 +489,11 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	unsigned int dss_size =3D 0;
-	u64 snd_data_fin_enable;
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
 	bool ret =3D false;
 =

 	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
-	snd_data_fin_enable =3D READ_ONCE(msk->snd_data_fin_enable);
 =

 	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
 		unsigned int map_size;
@@ -650,12 +651,15 @@ bool mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
 {
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	unsigned int opt_size =3D 0;
+	bool snd_data_fin;
 	bool ret =3D false;
 =

 	opts->suboptions =3D 0;
 =

-	if (unlikely(mptcp_check_fallback(sk)))
+	if (unlikely(__mptcp_check_fallback(msk)))
 		return false;
 =

 	/* prevent adding of any MPTCP related options on reset packet
@@ -664,10 +668,11 @@ bool mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
 		return false;
 =

-	if (mptcp_established_options_mp(sk, skb, &opt_size, remaining, opts))
+	snd_data_fin =3D READ_ONCE(msk->snd_data_fin_enable);
+
+	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remain=
ing, opts))
 		ret =3D true;
-	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
-					       opts))
+	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, =
remaining, opts))
 		ret =3D true;
 =

 	/* we reserved enough space for the above options, and exceeding the
-- =

2.30.2

--===============1014639103001112547==--
