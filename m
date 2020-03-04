Content-Type: multipart/mixed; boundary="===============7618943069444228331=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 3/0003] Squash-to: "mptcp: Add handling of incoming
 MP_JOIN requests"
Date: Wed, 04 Mar 2020 16:02:02 +0100
Message-ID: <cb0d1fea8e3791ba648891247f573f1ca3ed6fac.1583334095.git.pabeni@redhat.com>
In-Reply-To: cover.1583334095.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3852

--===============7618943069444228331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Send 4th ack on 3rd acj reception for MP_JOIN pkts and enforce
no data packet before 4th ack.

Let the PM limit the number of per msk subflows.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  | 56 ++++++++++++++++++++++++++++++++------------
 net/mptcp/protocol.c |  7 +++---
 net/mptcp/protocol.h |  1 +
 3 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5e62cb9aafda..04365b8683db 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -553,37 +553,66 @@ bool mptcp_synack_options(const struct request_sock *=
req, unsigned int *size,
 	return false;
 }
 =

-static bool check_fully_established(struct mptcp_subflow_context *subflow,
+static bool check_fully_established(struct mptcp_sock *msk, struct sock *s=
k,
+				    struct mptcp_subflow_context *subflow,
 				    struct sk_buff *skb,
 				    struct mptcp_options_received *mp_opt)
 {
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
-	 * are relevant
+	 * will make the subflow fully established
 	 */
-	if (likely(subflow->fully_established ||
-		   TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1))
-		return true;
+	if (likely(subflow->fully_established)) {
+		/* on passive sockets, check for 3rd ack retransmission
+		 * note that msk is always set by subflow_syn_recv_sock()
+		 * for mp_join subflows
+		 */
+		if (TCP_SKB_CB(skb)->seq =3D=3D subflow->ssn_offset + 1 &&
+		    TCP_SKB_CB(skb)->end_seq =3D=3D TCP_SKB_CB(skb)->seq &&
+		    subflow->mp_join && mp_opt->mp_join &&
+		    READ_ONCE(msk->pm.server_side))
+			tcp_send_ack(sk);
+		goto fully_established;
+	}
+
+	/* we should process OoO packets before the first subflow is fully
+	 * established, but not expected for MP_JOIN subflows
+	 */
+	if (TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1)
+		return subflow->mp_capable;
 =

 	if (mp_opt->use_ack) {
+		/* subflows are fully established as soon as we get any
+		 * additional ack.
+		 */
 		subflow->fully_established =3D 1;
-		if (subflow->mp_join)
-			mptcp_pm_subflow_established(mptcp_sk(subflow->conn),
-						     subflow);
+		goto fully_established;
 	}
 =

-	if (subflow->can_ack)
-		return true;
+	WARN_ON_ONCE(subflow->can_ack);
 =

 	/* If the first established packet does not contain MP_CAPABLE + data
 	 * then fallback to TCP
 	 */
 	if (!mp_opt->mp_capable) {
 		subflow->mp_capable =3D 0;
-		tcp_sk(mptcp_subflow_tcp_sock(subflow))->is_mptcp =3D 0;
+		tcp_sk(sk)->is_mptcp =3D 0;
 		return false;
 	}
+
+	subflow->fully_established =3D 1;
 	subflow->remote_key =3D mp_opt->sndr_key;
 	subflow->can_ack =3D 1;
+
+fully_established:
+	/* msk can be null for MPC subflow on passive socket,  */
+	if (subflow->pm_notified || !msk)
+		return true;
+
+	subflow->pm_notified =3D 1;
+	if (subflow->mp_join)
+		mptcp_pm_subflow_established(msk, subflow);
+	else
+		mptcp_pm_fully_established(msk);
 	return true;
 }
 =

@@ -596,7 +625,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	struct mptcp_ext *mpext;
 =

 	mp_opt =3D &opt_rx->mptcp;
-	if (!check_fully_established(subflow, skb, mp_opt))
+	if (!check_fully_established(msk, sk, subflow, skb, mp_opt))
 		return;
 =

 	if (msk && mp_opt->add_addr) {
@@ -654,9 +683,6 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 	}
 =

 	mpext->data_fin =3D mp_opt->data_fin;
-
-	if (msk)
-		mptcp_pm_fully_established(msk);
 }
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e10879368ab0..6129324d96e7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1088,9 +1088,10 @@ bool mptcp_finish_join(struct sock *sk)
 		return false;
 =

 	parent_sock =3D READ_ONCE(parent->sk_socket);
-	if (parent_sock) {
-		if (!sk->sk_socket)
-			mptcp_sock_graft(sk, parent_sock);
+	if (parent_sock && !sk->sk_socket) {
+		/* passive connection, attach to msk socket */
+		mptcp_sock_graft(sk, parent_sock);
+		return mptcp_pm_allow_new_subflow(msk);
 	}
 	return true;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f2698dfe41f8..4f1c3db26018 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -198,6 +198,7 @@ struct mptcp_subflow_context {
 		mp_capable : 1,	    /* remote is MPTCP capable */
 		mp_join : 1,	    /* remote is JOINing */
 		fully_established : 1,	    /* path validated */
+		pm_notified : 1,    /* PM hook called for */
 		conn_finished : 1,
 		map_valid : 1,
 		mpc_map : 1,
-- =

2.21.1

--===============7618943069444228331==--
