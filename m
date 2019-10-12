Content-Type: multipart/mixed; boundary="===============2950089941020583039=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH] mptcp: Add DATA_FIN transmission and handling
Date: Fri, 11 Oct 2019 21:32:21 -0700
Message-ID: <20191012043221.8829-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2099

--===============2950089941020583039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Send and process received DATA_FIN options. This requires addition of a
state machine to the MPTCP socket to handle the closing process.

This is still a work in progress, including these areas:

 * DATA_FIN requires a special DSS mapping when sent without a regular
   data mapping. This is causing self test failures (as noted in
   mptcp_established_options_dss()).

 * Need to finish handling of DSS_ACKs for the state machine.

 * Need to double-check whether it's correct to bypass inet_shutdown
   as the current code does.

 * A DATA_FIN that arrives on a packet without data payload (unless it's
   a TCP FIN) are discarded by tcp_data_queue() and not propagated to
   the MPTCP socket. This is detected in mptcp_incoming_options() but
   not yet handled. The skb with the DATA_FIN could be cloned and
   placed in the subflow error queue, or a workqueue could handle it.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c  |  45 +++++++++++++--
 net/mptcp/protocol.c | 134 ++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |   4 +-
 3 files changed, 156 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4bb3766fce5e..0a104b3ee185 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -388,13 +388,15 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 					  unsigned int remaining,
 					  struct mptcp_out_options *opts)
 {
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	unsigned int dss_size =3D 0;
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
 =

 	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
 =

-	if (!skb || (mpext && mpext->use_map)) {
+	if (!skb || (mpext && mpext->use_map) ||
+	    (subflow->send_data_fin && subflow->conn)) {
 		unsigned int map_size;
 =

 		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
@@ -404,6 +406,21 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 			dss_size =3D map_size;
 			if (mpext)
 				opts->ext_copy =3D *mpext;
+
+			/* This creates self test failures, still tracking
+			 * down the root cause */
+			if (subflow->send_data_fin && !opts->ext_copy.use_map &&
+			    subflow->conn) {
+				struct mptcp_sock *msk;
+
+				/* Required for DATA_FIN without data payload */
+				msk =3D mptcp_sk(subflow->conn);
+				opts->ext_copy.use_map =3D 1;
+				opts->ext_copy.dsn64 =3D 1;
+				opts->ext_copy.data_seq =3D msk->write_seq;
+				opts->ext_copy.subflow_seq =3D 0;
+				opts->ext_copy.data_len =3D 1;
+			}
 		} else {
 			opts->ext_copy.use_map =3D 0;
 			WARN_ONCE(1, "MPTCP: Map dropped");
@@ -421,7 +438,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 =

 		dss_size +=3D ack_size;
 =

-		msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+		msk =3D mptcp_sk(subflow->conn);
 		if (msk) {
 			opts->ext_copy.data_ack =3D msk->ack_seq;
 		} else {
@@ -440,6 +457,13 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 	if (!dss_size)
 		return false;
 =

+	if (subflow->send_data_fin) {
+		opts->ext_copy.data_fin =3D 1;
+		/* Only clear the flag if this affects a real skb */
+		if (skb)
+			subflow->send_data_fin =3D 0;
+	}
+
 	*size =3D ALIGN(dss_size, 4);
 	return true;
 }
@@ -617,6 +641,18 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 =

 	mpext->data_fin =3D mp_opt->data_fin;
 =

+	if (mp_opt->data_fin &&
+	    TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
+		/* The DATA_FIN is on a packet that will be discarded by
+		 * tcp_data_queue() and will not get propagated to the MPTCP
+		 * socket.
+		 *
+		 * Use workqueue or subflow error queue?
+		 */
+		pr_warn("Ignored DATA_FIN");
+	}
+
+
 	if (msk)
 		mptcp_pm_fully_established(msk);
 }
@@ -712,10 +748,11 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_ou=
t_options *opts)
 			 * support for optional 32-bit mappings later.
 			 */
 			flags |=3D MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
-			if (mpext->data_fin)
-				flags |=3D MPTCP_DSS_DATA_FIN;
 		}
 =

+		if (mpext->data_fin)
+			flags |=3D MPTCP_DSS_DATA_FIN;
+
 		*ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
 =

 		if (mpext->use_ack) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index df5455c3719a..4507b259ca3e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -360,6 +360,13 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 	lock_sock(ssk);
 	mptcp_clean_una(sk);
 	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
+
+	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
+		ret =3D sk_stream_wait_connect(sk, &timeo);
+		if (ret !=3D 0)
+			goto put_out_subflow;
+	}
+
 	while (msg_data_left(msg)) {
 		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
 					 &size_goal);
@@ -380,6 +387,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 			mptcp_reset_timer(sk);
 	}
 =

+put_out_subflow:
 	release_sock(ssk);
 =

 out:
@@ -445,14 +453,14 @@ enum mapping_status {
 	MAPPING_ADDED,
 	MAPPING_MISSING,
 	MAPPING_EMPTY,
-	MAPPING_DATA_FIN
+	MAPPING_BARE_DATA_FIN
 };
 =

 static enum mapping_status mptcp_get_mapping(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct mptcp_ext *mpext;
-	enum mapping_status ret;
+	enum mapping_status ret =3D MAPPING_ADDED;
 	struct sk_buff *skb;
 	u64 map_seq;
 =

@@ -482,11 +490,15 @@ static enum mapping_status mptcp_get_mapping(struct s=
ock *ssk)
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		ret =3D MAPPING_MISSING;
 		goto del_out;
-	} else if (mpext->subflow_seq =3D=3D 0 &&
-		   mpext->data_fin =3D=3D 1) {
-		pr_debug("DATA_FIN with no payload");
-		ret =3D MAPPING_DATA_FIN;
-		goto del_out;
+	}
+
+	if (mpext->data_fin) {
+		if (mpext->subflow_seq =3D=3D 0 && mpext->data_len =3D=3D 1) {
+			ret =3D MAPPING_BARE_DATA_FIN;
+			goto del_out;
+		}
+
+		subflow->incoming_data_fin =3D 1;
 	}
 =

 	if (!mpext->dsn64) {
@@ -503,7 +515,8 @@ static enum mapping_status mptcp_get_mapping(struct soc=
k *ssk)
 		 */
 		if (subflow->map_seq !=3D map_seq ||
 		    subflow->map_subflow_seq !=3D mpext->subflow_seq ||
-		    subflow->map_data_len !=3D mpext->data_len) {
+		    subflow->map_data_len !=3D mpext->data_len ||
+		    subflow->incoming_data_fin !=3D mpext->data_fin) {
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
 			pr_warn("Replaced mapping before it was done");
 		}
@@ -513,7 +526,6 @@ static enum mapping_status mptcp_get_mapping(struct soc=
k *ssk)
 	subflow->map_subflow_seq =3D mpext->subflow_seq;
 	subflow->map_data_len =3D mpext->data_len;
 	subflow->map_valid =3D 1;
-	ret =3D MAPPING_ADDED;
 	pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u",
 		 subflow->map_seq, subflow->map_subflow_seq,
 		 subflow->map_data_len);
@@ -554,6 +566,41 @@ static void warn_bad_map(struct mptcp_subflow_context =
*subflow, u32 ssn)
 		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
 }
 =

+static int mptcp_close_state(int oldstate, bool fin, bool ack)
+{
+	switch (oldstate) {
+	case TCP_FIN_WAIT1:
+		if (fin && ack)
+			return TCP_TIME_WAIT;
+		else if (fin)
+			return TCP_FIN_WAIT2;
+		else
+			return TCP_CLOSING;
+	case TCP_FIN_WAIT2:
+		if (fin)
+			return TCP_TIME_WAIT;
+		else
+			return oldstate;
+	case TCP_CLOSING:
+		if (ack)
+			return TCP_TIME_WAIT;
+		else
+			return oldstate;
+	case TCP_TIME_WAIT:
+		return TCP_CLOSE;
+	case TCP_LAST_ACK:
+		if (ack)
+			return TCP_CLOSE;
+		else
+			return oldstate;
+	case TCP_ESTABLISHED:
+		return TCP_CLOSE_WAIT;
+	default:
+		pr_debug("Unexpected state with DATA_FIN: %d", oldstate);
+		return oldstate;
+	}
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {
@@ -636,12 +683,16 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 			}
 		} else if (status =3D=3D MAPPING_EMPTY) {
 			goto wait_for_data;
-		} else if (status =3D=3D MAPPING_DATA_FIN) {
-			/* TODO: Handle according to RFC 6824 */
-			if (!copied) {
-				pr_err("Can't read after DATA_FIN");
-				copied =3D -ENOTCONN;
+		} else if (status =3D=3D MAPPING_BARE_DATA_FIN) {
+			int newstate =3D mptcp_close_state(sk->sk_state, true,
+							 false);
+
+			if (subflow->map_seq =3D=3D msk->ack_seq) {
+				msk->ack_seq++;
+				inet_sk_state_store(sk, newstate);
+				tcp_send_ack(ssk);
 			}
+			/* else fallback to TCP? */
 =

 			break;
 		}
@@ -697,9 +748,25 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 		if (!before(tcp_sk(ssk)->copied_seq - subflow->ssn_offset,
 			    subflow->map_subflow_seq + subflow->map_data_len)) {
 			subflow->map_valid =3D 0;
-			pr_debug("Done with mapping: seq=3D%u data_len=3D%u",
+
+			if (subflow->incoming_data_fin) {
+				int newstate;
+
+				if (subflow->map_seq =3D=3D msk->ack_seq) {
+					newstate =3D mptcp_close_state(
+						sk->sk_state, false, true);
+
+					msk->ack_seq++;
+					inet_sk_state_store(sk, newstate);
+					tcp_send_ack(ssk);
+				}
+				/* else fallback to TCP? */
+			}
+
+			pr_debug("Done with mapping: seq=3D%u data_len=3D%u data_fin=3D%u",
 				 subflow->map_subflow_seq,
-				 subflow->map_data_len);
+				 subflow->map_data_len,
+				 subflow->incoming_data_fin);
 		}
 =

 		if (arg.msg)
@@ -897,11 +964,11 @@ static void mptcp_close(struct sock *sk, long timeout)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct socket *ssk =3D NULL;
 =

-	mptcp_token_destroy(msk->token);
-	inet_sk_state_store(sk, TCP_CLOSE);
-
 	lock_sock(sk);
 =

+	inet_sk_state_store(sk, TCP_CLOSE);
+	mptcp_token_destroy(msk->token);
+
 	if (msk->subflow) {
 		ssk =3D msk->subflow;
 		msk->subflow =3D NULL;
@@ -914,6 +981,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		pr_debug("conn_list->subflow=3D%p", subflow);
+		subflow->send_data_fin =3D 1;
 		sock_release(mptcp_subflow_tcp_socket(subflow));
 	}
 =

@@ -1071,6 +1139,11 @@ static int mptcp_getsockopt(struct sock *sk, int lev=
el, int optname,
 	return -EOPNOTSUPP;
 }
 =

+static void mptcp_shutdown(struct sock *sock, int how)
+{
+	pr_err("Unexpected MPTCP shutdown call sock=3D%p how=3D%d", sock, how);
+}
+
 #define MPTCP_DEFERRED_ALL TCPF_WRITE_TIMER_DEFERRED
 =

 /* this is very alike tcp_release_cb() but we must handle differently a
@@ -1195,7 +1268,7 @@ static struct proto mptcp_prot =3D {
 	.accept		=3D mptcp_accept,
 	.setsockopt	=3D mptcp_setsockopt,
 	.getsockopt	=3D mptcp_getsockopt,
-	.shutdown	=3D tcp_shutdown,
+	.shutdown	=3D mptcp_shutdown,
 	.destroy	=3D mptcp_destroy,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
@@ -1338,6 +1411,10 @@ static int mptcp_listen(struct socket *sock, int bac=
klog)
 =

 	err =3D inet_listen(ssock, backlog);
 	sock_put(ssock->sk);
+
+	if (!err)
+		inet_sk_state_store(sock->sk, TCP_LISTEN);
+
 	return err;
 }
 =

@@ -1389,7 +1466,7 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 	return ret;
 }
 =

-static int mptcp_shutdown(struct socket *sock, int how)
+static int mptcp_stream_shutdown(struct socket *sock, int how)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct mptcp_subflow_context *subflow;
@@ -1399,6 +1476,18 @@ static int mptcp_shutdown(struct socket *sock, int h=
ow)
 	pr_debug("sk=3D%p, how=3D%d", msk, how);
 =

 	lock_sock(sock->sk);
+
+	if (sock->sk->sk_state =3D=3D TCP_ESTABLISHED) {
+		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
+	} else if (sock->sk->sk_state =3D=3D TCP_CLOSE_WAIT) {
+		inet_sk_state_store(sock->sk, TCP_LAST_ACK);
+	} else if (sock->sk->sk_state !=3D TCP_CLOSE) {
+		pr_warn("Shutdown from unexpected state %d",
+			sock->sk->sk_state);
+		release_sock(sock->sk);
+		return -EALREADY;
+	}
+
 	ssock =3D __mptcp_fallback_get_ref(msk);
 	if (ssock) {
 		release_sock(sock->sk);
@@ -1413,6 +1502,7 @@ static int mptcp_shutdown(struct socket *sock, int ho=
w)
 =

 		tcp_socket =3D mptcp_subflow_tcp_socket(subflow);
 		pr_debug("conn_list->subflow=3D%p", subflow);
+		subflow->send_data_fin =3D 1;
 		ret =3D kernel_sock_shutdown(tcp_socket, how);
 	}
 	release_sock(sock->sk);
@@ -1440,7 +1530,7 @@ void mptcp_proto_init(void)
 	mptcp_stream_ops.accept =3D mptcp_stream_accept;
 	mptcp_stream_ops.getname =3D mptcp_getname;
 	mptcp_stream_ops.listen =3D mptcp_listen;
-	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
+	mptcp_stream_ops.shutdown =3D mptcp_stream_shutdown;
 =

 	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
 		panic("Failed to allocate MPTCP pcpu counter\n");
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c66f69a734d..3f185db7da36 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -214,7 +214,9 @@ struct mptcp_subflow_context {
 		fourth_ack : 1,     /* send initial DSS */
 		conn_finished : 1,
 		map_valid : 1,
-		backup : 1;
+		backup : 1,
+		incoming_data_fin : 1,
+		send_data_fin : 1;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
-- =

2.23.0

--===============2950089941020583039==--
