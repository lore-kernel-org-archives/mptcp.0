Content-Type: multipart/mixed; boundary="===============3032426260678035736=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net] mptcp: fix DATA_FIN generation on early
 shutdown.
Date: Thu, 11 Feb 2021 23:13:12 +0100
Message-ID: <23fa447e02e5b0a342408a2065d15281c223e32b.1613081583.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7758

--===============3032426260678035736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the msk is closed before sending or receiving any data,
no DATA_FIN is generated, instead an MPC ack packet is
crafted out.

In the above scenario, the MPTCP protocol create and send a
pure ack and such packets matches also the criteria for an
MPC ack and the protocol tries first to insert MPC options,
leading the described error.

This change address the issue skipping MPC option for DATA_FIN
packets or if the subflow is not established.

To avoid doing multiple times the same test, fetch the data_fin
flag in a bool variable and pass it to both the interested
helpers.

Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packe=
ts")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
The scenario is tested by a specific pktdrill tested,
already pushed
---
 net/mptcp/options.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b63574d6b812e..444a38681e93e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -411,6 +411,7 @@ static void clear_3rdack_retransmission(struct sock *sk)
 }
 =

 static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *=
skb,
+					 bool snd_data_fin_enable,
 					 unsigned int *size,
 					 unsigned int remaining,
 					 struct mptcp_out_options *opts)
@@ -428,9 +429,10 @@ static bool mptcp_established_options_mp(struct sock *=
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
@@ -502,20 +504,20 @@ static void mptcp_write_data_fin(struct mptcp_subflow=
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
@@ -717,12 +719,15 @@ bool mptcp_established_options(struct sock *sk, struc=
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
@@ -731,10 +736,10 @@ bool mptcp_established_options(struct sock *sk, struc=
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

--===============3032426260678035736==--
