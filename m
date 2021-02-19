Content-Type: multipart/mixed; boundary="===============1718186816784203446=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 2/4] mptcp: fix DATA_FIN generation on early
 shutdown
Date: Fri, 19 Feb 2021 18:35:38 +0100
Message-ID: <e222c171c1f8f7fa72460c7520eb35bd174a9d6b.1613755058.git.pabeni@redhat.com>
In-Reply-To: cover.1613755058.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7864

--===============1718186816784203446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
 net/mptcp/options.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8fec3dabe109..b220121e795a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -401,6 +401,7 @@ static void clear_3rdack_retransmission(struct sock *sk)
 }
 =

 static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *=
skb,
+					 bool snd_data_fin_enable,
 					 unsigned int *size,
 					 unsigned int remaining,
 					 struct mptcp_out_options *opts)
@@ -418,9 +419,10 @@ static bool mptcp_established_options_mp(struct sock *=
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
@@ -492,20 +494,20 @@ static void mptcp_write_data_fin(struct mptcp_subflow=
_context *subflow,
 }
 =

 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff =
*skb,
+					  bool snd_data_fin_enable,
 					  unsigned int *size,
 					  unsigned int remaining,
 					  struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
-	u64 snd_data_fin_enable, ack_seq;
 	unsigned int dss_size =3D 0;
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
 	bool ret =3D false;
+	u64 ack_seq;
 =

 	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
-	snd_data_fin_enable =3D mptcp_data_fin_enabled(msk);
 =

 	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
 		unsigned int map_size;
@@ -684,12 +686,15 @@ bool mptcp_established_options(struct sock *sk, struc=
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
@@ -698,10 +703,10 @@ bool mptcp_established_options(struct sock *sk, struc=
t sk_buff *skb,
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST))
 		return false;
 =

-	if (mptcp_established_options_mp(sk, skb, &opt_size, remaining, opts))
+	snd_data_fin =3D mptcp_data_fin_enabled(msk);
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

2.26.2

--===============1718186816784203446==--
