Content-Type: multipart/mixed; boundary="===============8917790164670471181=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH] mptcp: explicitly retransmit MP_CAPABLE 3whs ack
Date: Tue, 16 Jul 2019 17:49:55 +0200
Message-ID: <e3893ca9ee345053bda15d7cc19bda9c96977faa.1563291391.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1496

--===============8917790164670471181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the ack concluding the 3way handshake is lost (e.g. due to
lossy network connection), the mptcp listener will hang on accept.
That happens because the client does not provide the required
rcvr_key/sndr_key info via the MP_CAPABLE option in the following
packets.

From client perspective the socket is already into established status:
later pkts will carry a DSS option instead.

This patch addresses the issue, forcing the transmission of a forged,
duplicated, 3way handshake ack with MP_CAPABLE option if the retransmission
of a data packet is detected before the peer send back any MPTCP-related
data packet - demonstrating that the MPTCP handshake is completed
successfully.

This apprently fixes the pending self-tests issue in my setup.

Fixes: af061d2af1c2 ("mptcp: Write MPTCP DSS headers to outgoing data packe=
ts")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
This can possibly looks like a nasty hack and likelly it is ;)

I'd like to share the code to demostrate the issue and discuss possible sol=
utions

Note that the self test failure can be reproduce in a deterministic way add=
ing:

ip netns exec ns2 iptables -I OUTPUT -o ns2eth3 -p tcp --dport 10000 -m con=
nbytes \
        --connbytes-mode packets --connbytes-dir original --connbytes 2:3 -=
j DROP

at setup time.

Other alternative approaches would be:
- let the server reset the connection if detect the lack of MP_CAPABLE in t=
he 3th
  pkts (ack lost, received a later data packet)
- let the server fall back to plain TCP in the above conditions

Both should have a simpler/cleaner implementation but both would make mptcp=
 behavior
less deterministic.

Othewise, is there any other better way to check for the 'this is a 3way HS=
 ack rentransmission'
condition? Any better way to push ack pkts?
---
 net/mptcp/options.c  | 41 ++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  3 +++
 net/mptcp/subflow.c  |  3 +++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 58215f19829a..d3a890e842e1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -316,13 +316,46 @@ void mptcp_rcv_synsent(struct sock *sk)
 	}
 }
 =

-static bool mptcp_established_options_mp(struct sock *sk, unsigned int *si=
ze,
+static bool mptcp_is_twhs_ack(struct sock *sk,
+			      const struct sk_buff *skb)
+{
+	struct subflow_context *subflow =3D subflow_ctx(sk);
+
+	if (!subflow->fourth_ack) {
+		if (skb) {
+			subflow->twhs_seq =3D TCP_SKB_CB(skb)->seq;
+			subflow->twhs_ack =3D TCP_SKB_CB(skb)->ack_seq;
+		}
+		return true;
+	}
+
+	if (!skb)
+		return false;
+
+	if (!subflow->fourth_ack_received &&
+	    subflow->twhs_ack =3D=3D TCP_SKB_CB(skb)->ack_seq &&
+	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(sk)->snd_nxt)) {
+		/* this is a retransmission and no prof MP_CAPABLE landed
+		 * on the peer, force an ack for it
+		 */
+		if (skb->len) {
+			tcp_send_ack(sk);
+			return false;
+		}
+		return true;
+	}
+	return false;
+}
+
+static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *=
skb,
+					 unsigned int *size,
 					 unsigned int remaining,
 					 struct mptcp_out_options *opts)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 =

-	if (!subflow->fourth_ack && remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
+	if (mptcp_is_twhs_ack(sk, skb) &&
+	    remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
 		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key =3D subflow->local_key;
 		opts->rcvr_key =3D subflow->remote_key;
@@ -429,7 +462,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 		return false;
 =

 	opts->suboptions =3D 0;
-	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts)) {
+	if (mptcp_established_options_mp(sk, skb, &opt_size, remaining, opts)) {
 		*size +=3D opt_size;
 		remaining -=3D opt_size;
 		ret =3D true;
@@ -479,6 +512,7 @@ bool mptcp_synack_options(const struct request_sock *re=
q, unsigned int *size,
 void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
 		      struct tcp_options_received *opt_rx)
 {
+	struct subflow_context *subflow =3D subflow_ctx(sk);
 	struct mptcp_options_received *mp_opt;
 	struct mptcp_ext *mpext;
 =

@@ -487,6 +521,7 @@ void mptcp_attach_dss(struct sock *sk, struct sk_buff *=
skb,
 	if (!mp_opt->dss)
 		return;
 =

+	subflow->fourth_ack_received =3D 1;
 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7f15f6aab93d..bd9540515334 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -147,12 +147,15 @@ struct subflow_context {
 	u64	map_seq;
 	u32	map_subflow_seq;
 	u32	ssn_offset;
+	u32	twhs_seq;
+	u32	twhs_ack;
 	u16	map_data_len;
 	u16	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_cksum : 1,
 		mp_capable : 1,     /* remote is MPTCP capable */
 		mp_join : 1,        /* remote is JOINing */
 		fourth_ack : 1,     /* send initial DSS */
+		fourth_ack_received : 1,
 		version : 4,
 		conn_finished : 1,
 		use_checksum : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fdc5aecab897..ccbf77f7a451 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -271,6 +271,7 @@ static int subflow_ulp_init(struct sock *sk)
 	icsk->icsk_af_ops =3D &subflow_specific;
 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
 	ctx->use_checksum =3D 0;
+	ctx->fourth_ack_received =3D 0;
 	sk->sk_data_ready =3D subflow_data_ready;
 out:
 	return err;
@@ -311,6 +312,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	if (subflow_req->mp_capable) {
 		new_ctx->mp_capable =3D 1;
 		new_ctx->fourth_ack =3D 1;
+		new_ctx->fourth_ack_received =3D 1;
 		new_ctx->remote_key =3D subflow_req->remote_key;
 		new_ctx->local_key =3D subflow_req->local_key;
 		new_ctx->token =3D subflow_req->token;
@@ -320,6 +322,7 @@ static void subflow_ulp_clone(const struct request_sock=
 *req,
 	} else if (subflow_req->mp_join) {
 		new_ctx->mp_join =3D 1;
 		new_ctx->fourth_ack =3D 1;
+		new_ctx->fourth_ack_received =3D 1;
 		new_ctx->backup =3D subflow_req->backup;
 		new_ctx->local_id =3D subflow_req->local_id;
 		new_ctx->token =3D subflow_req->token;
-- =

2.20.1


--===============8917790164670471181==--
