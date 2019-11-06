Content-Type: multipart/mixed; boundary="===============6658968831864301416=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Add DATA_FIN transmission and handling
Date: Tue, 05 Nov 2019 20:50:11 -0800
Message-ID: <20191106045011.10071-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2418

--===============6658968831864301416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Send and process received DATA_FIN options. This requires addition of a
state machine to the MPTCP socket to handle the closing process. DATA_FIN
is sent along with a DSS mapping for the final data transmitted, or on a
bare ACK if there is no data to transmit.

This is still a work in progress, including these areas:

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
 net/mptcp/options.c  | 52 ++++++++++++++++++++++--
 net/mptcp/protocol.c | 96 ++++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  5 ++-
 net/mptcp/subflow.c  | 18 ++++-----
 4 files changed, 149 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1b08e1193991..4f67826a4977 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -384,18 +384,43 @@ static bool mptcp_established_options_mp(struct sock =
*sk, unsigned int *size,
 	return false;
 }
 =

+static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
+				 struct mptcp_ext *ext)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+
+	WARN_ONCE(!subflow->conn, "MPTCP: Missing MPTCP socket information");
+
+	/* Only send DATA_FIN if all data has been sent or this is the last
+	 * mapping.
+	 */
+	if (!ext->use_map) {
+		if (subflow->data_fin_seq =3D=3D msk->write_seq) {
+			ext->use_map =3D 1;
+			ext->dsn64 =3D 1;
+			ext->data_seq =3D subflow->data_fin_seq;
+			ext->subflow_seq =3D 0;
+			ext->data_len =3D 1;
+			ext->data_fin =3D 1;
+		}
+	} else if (subflow->data_fin_seq =3D=3D ext->data_seq + ext->data_len) {
+		ext->data_fin =3D 1;
+	}
+}
+
 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff =
*skb,
 					  unsigned int *size,
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
+	if (!skb || (mpext && mpext->use_map) || subflow->send_data_fin) {
 		unsigned int map_size;
 =

 		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
@@ -405,6 +430,9 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 			dss_size =3D map_size;
 			if (mpext)
 				opts->ext_copy =3D *mpext;
+
+			if (subflow->send_data_fin && skb)
+				mptcp_write_data_fin(subflow, &opts->ext_copy);
 		} else {
 			opts->ext_copy.use_map =3D 0;
 			WARN_ONCE(1, "MPTCP: Map dropped");
@@ -422,7 +450,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 =

 		dss_size +=3D ack_size;
 =

-		msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+		msk =3D mptcp_sk(subflow->conn);
 		if (msk) {
 			opts->ext_copy.data_ack =3D msk->ack_seq;
 		} else {
@@ -441,6 +469,9 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 	if (!dss_size)
 		return false;
 =

+	if (opts->ext_copy.data_fin)
+		subflow->send_data_fin =3D 0;
+
 	*size =3D ALIGN(dss_size, 4);
 	return true;
 }
@@ -632,6 +663,18 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
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
@@ -727,10 +770,11 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_ou=
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
index 696f1d03a61d..6d3b4a0a8dc1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -101,7 +101,7 @@ static struct sock *mptcp_subflow_recv_lookup(const str=
uct mptcp_sock *msk)
 	sock_owned_by_me(sk);
 =

 	mptcp_for_each_subflow(msk, subflow) {
-		if (subflow->data_avail)
+		if (subflow->data_avail || subflow->incoming_data_fin)
 			return mptcp_subflow_tcp_socket(subflow)->sk;
 =

 		receivers +=3D !subflow->rx_eof;
@@ -383,6 +383,13 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
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
@@ -403,6 +410,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 			mptcp_reset_timer(sk);
 	}
 =

+put_out_subflow:
 	release_sock(ssk);
 =

 out:
@@ -464,6 +472,41 @@ static void mptcp_wait_data(struct sock *sk, long *tim=
eo)
 	remove_wait_queue(sk_sleep(sk), &wait);
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
@@ -545,6 +588,20 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 				continue;
 			}
 		}
+
+		if (!subflow->map_valid && subflow->incoming_data_fin) {
+			int newstate;
+
+			// TODO: Send on all subflows?
+			newstate =3D mptcp_close_state(sk->sk_state, true, false);
+			msk->ack_seq++;
+			subflow->incoming_data_fin =3D 0;
+			subflow->send_data_fin =3D 1;
+			subflow->data_fin_seq =3D msk->write_seq;
+			inet_sk_state_store(sk, newstate);
+			tcp_send_ack(ssk);
+		}
+
 		release_sock(ssk);
 		continue;
 =

@@ -747,11 +804,11 @@ static void mptcp_close(struct sock *sk, long timeout)
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
@@ -764,6 +821,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 =

 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		pr_debug("conn_list->subflow=3D%p", subflow);
+		subflow->send_data_fin =3D 1;
+		subflow->data_fin_seq =3D msk->write_seq;
 		sock_release(mptcp_subflow_tcp_socket(subflow));
 	}
 =

@@ -930,6 +989,11 @@ static int mptcp_getsockopt(struct sock *sk, int level=
, int optname,
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
@@ -1055,7 +1119,7 @@ static struct proto mptcp_prot =3D {
 	.accept		=3D mptcp_accept,
 	.setsockopt	=3D mptcp_setsockopt,
 	.getsockopt	=3D mptcp_getsockopt,
-	.shutdown	=3D tcp_shutdown,
+	.shutdown	=3D mptcp_shutdown,
 	.destroy	=3D mptcp_destroy,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
@@ -1199,6 +1263,10 @@ static int mptcp_listen(struct socket *sock, int bac=
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

@@ -1252,7 +1320,7 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 	return ret;
 }
 =

-static int mptcp_shutdown(struct socket *sock, int how)
+static int mptcp_stream_shutdown(struct socket *sock, int how)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct mptcp_subflow_context *subflow;
@@ -1262,6 +1330,18 @@ static int mptcp_shutdown(struct socket *sock, int h=
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
@@ -1276,6 +1356,8 @@ static int mptcp_shutdown(struct socket *sock, int ho=
w)
 =

 		tcp_socket =3D mptcp_subflow_tcp_socket(subflow);
 		pr_debug("conn_list->subflow=3D%p", subflow);
+		subflow->send_data_fin =3D 1;
+		subflow->data_fin_seq =3D msk->write_seq;
 		ret =3D kernel_sock_shutdown(tcp_socket, how);
 	}
 	release_sock(sock->sk);
@@ -1303,7 +1385,7 @@ void mptcp_proto_init(void)
 	mptcp_stream_ops.accept =3D mptcp_stream_accept;
 	mptcp_stream_ops.getname =3D mptcp_getname;
 	mptcp_stream_ops.listen =3D mptcp_listen;
-	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
+	mptcp_stream_ops.shutdown =3D mptcp_stream_shutdown;
 =

 	if (percpu_counter_init(&mptcp_sockets_allocated, 0, GFP_KERNEL))
 		panic("Failed to allocate MPTCP pcpu counter\n");
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8fe5f9383d38..cf90014974ea 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -217,9 +217,12 @@ struct mptcp_subflow_context {
 		map_valid : 1,
 		backup : 1,
 		data_avail : 1,
-		rx_eof : 1;
+		rx_eof : 1,
+		incoming_data_fin : 1,
+		send_data_fin : 1;
 	u32	remote_nonce;
 	u64	thmac;
+	u64	data_fin_seq;
 	u32	local_nonce;
 	u32	remote_token;
 	u8	hmac[MPTCPOPT_HMAC_LEN];
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f08c4b713978..e39b71094b12 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -315,7 +315,7 @@ enum mapping_status {
 	MAPPING_OK,
 	MAPPING_INVALID,
 	MAPPING_EMPTY,
-	MAPPING_DATA_FIN
+	MAPPING_BARE_DATA_FIN
 };
 =

 static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
@@ -406,16 +406,13 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk)
 		pr_err("Infinite mapping not handled");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		return MAPPING_INVALID;
-	} else if (mpext->subflow_seq =3D=3D 0 &&
-		   mpext->data_fin =3D=3D 1) {
-		if (WARN_ON_ONCE(mpext->data_len !=3D 1))
-			return false;
+	}
 =

-		/* do not try hard to handle this any better, till we have
-		 * real data_fin support
-		 */
-		pr_debug("DATA_FIN with no payload");
-		return MAPPING_DATA_FIN;
+	if (mpext->data_fin && mpext->subflow_seq =3D=3D 0 &&
+	    mpext->data_len =3D=3D 1) {
+		subflow->map_valid =3D 0;
+		subflow->incoming_data_fin =3D 1;
+		return MAPPING_BARE_DATA_FIN;
 	}
 =

 	if (!mpext->dsn64) {
@@ -450,6 +447,7 @@ static enum mapping_status get_mapping_status(struct so=
ck *ssk)
 	subflow->map_seq =3D map_seq;
 	subflow->map_subflow_seq =3D mpext->subflow_seq;
 	subflow->map_data_len =3D mpext->data_len;
+	subflow->incoming_data_fin =3D mpext->data_fin;
 	subflow->map_valid =3D 1;
 	pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u",
 		 subflow->map_seq, subflow->map_subflow_seq,
-- =

2.24.0

--===============6658968831864301416==--
