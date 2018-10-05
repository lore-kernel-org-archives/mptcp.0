Content-Type: multipart/mixed; boundary="===============4035969634596960243=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v3 08/16] mptcp: Create SUBFLOW socket for
 incoming connections
Date: Fri, 05 Oct 2018 15:59:10 -0700
Message-ID: <20181005225918.9786-9-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181005225918.9786-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 770

--===============4035969634596960243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Add subflow_request_sock type that extends tcp_request_sock
and add an is_mptcp flag to tcp_request_sock distinguish them.

Override the listen() and accept() methods of the MPTCP
socket proto_ops so they may act on the subflow socket.

Override the conn_request() and syn_recv_sock() handlers
in the inet_connection_sock to handle incoming MPTCP
SYNs and the ACK to the response SYN.

Add handling in tcp_output.c to add MP_CAPABLE to an outgoing
SYN-ACK response for a subflow_request_sock.

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 include/linux/tcp.h   |   1 +
 include/net/mptcp.h   |  27 ++++++++++
 net/ipv4/tcp_input.c  |   1 +
 net/ipv4/tcp_output.c |  14 +++++
 net/mptcp/options.c   |  14 +++++
 net/mptcp/protocol.c  | 102 ++++++++++++++++++++++++++++++++++---
 net/mptcp/subflow.c   | 115 ++++++++++++++++++++++++++++++++++++++++--
 7 files changed, 264 insertions(+), 10 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 7f0dd688376c..b109798482d3 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -148,6 +148,7 @@ struct tcp_request_sock {
 						  * FastOpen it's the seq#
 						  * after data-in-SYN.
 						  */
+	bool				is_mptcp;
 };
 =

 static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *=
req)
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4b08eb4ccc6f..56883a1ee2fe 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -69,11 +69,30 @@ static inline struct subflow_sock *subflow_sk(const str=
uct sock *sk)
 	return (struct subflow_sock *)sk;
 }
 =

+struct subflow_request_sock {
+	struct	tcp_request_sock sk;
+	u8	mp_capable : 1,
+		mp_join : 1,
+		checksum : 1,
+		backup : 1,
+		version : 4;
+	u64	local_key;
+	u64	remote_key;
+};
+
+static inline
+struct subflow_request_sock *subflow_rsk(const struct request_sock *rsk)
+{
+	return (struct subflow_request_sock *)rsk;
+}
+
 #ifdef CONFIG_MPTCP
 =

 void mptcp_parse_option(const unsigned char *ptr, int opsize,
 			struct tcp_options_received *opt_rx);
 unsigned int mptcp_syn_options(struct sock *sk, u64 *local_key);
+unsigned int mptcp_synack_options(struct request_sock *req,
+				  u64 *local_key, u64 *remote_key);
 =

 void mptcp_finish_connect(struct sock *sk, int mp_capable);
 =

@@ -96,6 +115,14 @@ static inline unsigned int mptcp_syn_options(struct soc=
k *sk, u64 *local_key)
 {
 	return 0;
 }
+static inline unsigned int mptcp_synack_options(struct request_sock *sk,
+						u64 *local_key,
+						u64 *remote_key)
+{
+	return 0;
+}
+
+
 =

 #endif /* CONFIG_MPTCP */
 #endif /* __NET_MPTCP_H */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4cb38904bb5f..9a326729637f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6441,6 +6441,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 =

 	tcp_rsk(req)->af_specific =3D af_ops;
 	tcp_rsk(req)->ts_off =3D 0;
+	tcp_rsk(req)->is_mptcp =3D 0;
 =

 	tcp_clear_options(&tmp_opt);
 	tmp_opt.mss_clamp =3D af_ops->mss_clamp;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9919793e293b..780abb11dffd 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -767,6 +767,20 @@ static unsigned int tcp_synack_options(const struct so=
ck *sk,
 			remaining -=3D need;
 		}
 	}
+	if (tcp_rsk(req)->is_mptcp) {
+		u64 local_key;
+		u64 remote_key;
+		if (mptcp_synack_options(req, &local_key, &remote_key)) {
+			if (remaining >=3D TCPOLEN_MPTCP_MPC_SYNACK) {
+				opts->options |=3D OPTION_MPTCP;
+				opts->suboptions |=3D OPTION_MPTCP_MPC_SYNACK;
+				opts->sndr_key =3D local_key;
+				opts->rcvr_key =3D remote_key;
+				remaining -=3D TCPOLEN_MPTCP_MPC_SYNACK;
+			}
+		}
+	}
+
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 =

 	return MAX_TCP_OPTION_SPACE - remaining;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4b1cbc3b3efe..7e48d1d92aac 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -161,3 +161,17 @@ unsigned int mptcp_syn_options(struct sock *sk, u64 *l=
ocal_key)
 	}
 	return subflow->request_mptcp;
 }
+
+unsigned int mptcp_synack_options(struct request_sock *req, u64 *local_key,
+				  u64 *remote_key)
+{
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+
+	if (subflow_req->mp_capable) {
+		*local_key =3D subflow_req->local_key;
+		*remote_key =3D subflow_req->remote_key;
+		pr_debug("local_key=3D%llu", *local_key);
+		pr_debug("remote_key=3D%llu", *remote_key);
+	}
+	return subflow_req->mp_capable;
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1a3412a742ea..9f802f69a528 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -80,6 +80,45 @@ static void mptcp_close(struct sock *sk, long timeout)
 	}
 }
 =

+static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
+				 bool kern)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct socket *listener =3D msk->subflow;
+	struct socket *new_sock;
+	struct socket *mp;
+	struct subflow_sock *subflow;
+
+	pr_debug("msk=3D%p, listener=3D%p", msk, listener->sk);
+	*err =3D kernel_accept(listener, &new_sock, flags);
+	if (*err < 0)
+		return NULL;
+
+	subflow =3D subflow_sk(new_sock->sk);
+	pr_debug("new_sock=3D%p", subflow);
+
+	*err =3D sock_create(PF_INET, SOCK_STREAM, IPPROTO_MPTCP, &mp);
+	if (*err < 0) {
+		kernel_sock_shutdown(new_sock, SHUT_RDWR);
+		sock_release(new_sock);
+		return NULL;
+	}
+
+	msk =3D mptcp_sk(mp->sk);
+	pr_debug("msk=3D%p", msk);
+	subflow->conn =3D mp->sk;
+
+	if (subflow->mp_capable) {
+		msk->remote_key =3D subflow->remote_key;
+		msk->local_key =3D subflow->local_key;
+		msk->connection_list =3D new_sock;
+	} else {
+		msk->subflow =3D new_sock;
+	}
+
+	return mp->sk;
+}
+
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -129,11 +168,16 @@ static int subflow_create(struct sock *sock)
 int mptcp_stream_bind(struct socket *sock, struct sockaddr *uaddr, int add=
r_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
-	struct socket *subflow =3D msk->subflow;
+	int err;
 =

-	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow->sk);
+	pr_debug("msk=3D%p", msk);
 =

-	return inet_bind(subflow, uaddr, addr_len);
+	if (msk->subflow =3D=3D NULL) {
+		err =3D subflow_create(sock->sk);
+		if (err)
+			return err;
+	}
+	return inet_bind(msk->subflow, uaddr, addr_len);
 }
 =

 int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
@@ -153,12 +197,56 @@ int mptcp_stream_connect(struct socket *sock, struct =
sockaddr *uaddr,
 	return inet_stream_connect(msk->subflow, uaddr, addr_len, flags);
 }
 =

+int mptcp_stream_getname(struct socket *sock, struct sockaddr *uaddr, int =
peer)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *subflow;
+	int err =3D -EPERM;
+
+	if (msk->connection_list)
+		subflow =3D msk->connection_list;
+	else
+		subflow =3D msk->subflow;
+
+	err =3D inet_getname(subflow, uaddr, peer);
+
+	return err;
+}
+
+int mptcp_stream_listen(struct socket *sock, int backlog)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	int err;
+
+	pr_debug("msk=3D%p", msk);
+
+	if (msk->subflow =3D=3D NULL) {
+		err =3D subflow_create(sock->sk);
+		if (err)
+			return err;
+	}
+	return inet_listen(msk->subflow, backlog);
+}
+
+int mptcp_stream_accept(struct socket *sock, struct socket *newsock, int f=
lags,
+			bool kern)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+
+	pr_debug("msk=3D%p", msk);
+
+	if (msk->subflow =3D=3D NULL) {
+		return -EINVAL;
+	}
+	return inet_accept(sock, newsock, flags, kern);
+}
+
 static struct proto mptcp_prot =3D {
 	.name		=3D "MPTCP",
 	.owner		=3D THIS_MODULE,
 	.init		=3D mptcp_init_sock,
 	.close		=3D mptcp_close,
-	.accept		=3D inet_csk_accept,
+	.accept		=3D mptcp_accept,
 	.shutdown	=3D tcp_shutdown,
 	.sendmsg	=3D mptcp_sendmsg,
 	.recvmsg	=3D mptcp_recvmsg,
@@ -176,11 +264,11 @@ const struct proto_ops mptcp_stream_ops =3D {
 	.bind		   =3D mptcp_stream_bind,
 	.connect	   =3D mptcp_stream_connect,
 	.socketpair	   =3D sock_no_socketpair,
-	.accept		   =3D inet_accept,
-	.getname	   =3D inet_getname,
+	.accept		   =3D mptcp_stream_accept,
+	.getname	   =3D mptcp_stream_getname,
 	.poll		   =3D tcp_poll,
 	.ioctl		   =3D inet_ioctl,
-	.listen		   =3D inet_listen,
+	.listen		   =3D mptcp_stream_listen,
 	.shutdown	   =3D inet_shutdown,
 	.setsockopt	   =3D sock_common_setsockopt,
 	.getsockopt	   =3D sock_common_getsockopt,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5e5fdcb3175f..89fcc3b746eb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -53,6 +53,40 @@ static int subflow_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 	return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
 }
 =

+static void subflow_v4_init_req(struct request_sock *req,
+				const struct sock *sk_listener,
+				struct sk_buff *skb)
+{
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct subflow_sock *listener =3D subflow_sk(sk_listener);
+	struct tcp_options_received rx_opt;
+
+	tcp_rsk(req)->is_mptcp =3D 1;
+	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listener);
+
+	tcp_request_sock_ipv4_ops.init_req(req, sk_listener, skb);
+
+	rx_opt.mptcp.flags =3D 0;
+	rx_opt.mptcp.mp_capable =3D 0;
+	rx_opt.mptcp.mp_join =3D 0;
+	rx_opt.mptcp.dss =3D 0;
+	mptcp_get_options(skb, &rx_opt);
+
+	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
+		subflow_req->mp_capable =3D 1;
+		if (rx_opt.mptcp.version >=3D listener->version)
+			subflow_req->version =3D listener->version;
+		else
+			subflow_req->version =3D rx_opt.mptcp.version;
+		if ((rx_opt.mptcp.flags & MPTCP_CAP_CHECKSUM_REQD) ||
+		    listener->checksum)
+			subflow_req->checksum =3D 1;
+		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
+	} else {
+		subflow_req->mp_capable =3D 0;
+	}
+}
+
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
 {
 	struct subflow_sock *subflow =3D subflow_sk(sk);
@@ -68,13 +102,66 @@ static void subflow_finish_connect(struct sock *sk, co=
nst struct sk_buff *skb)
 	}
 }
 =

+static struct request_sock_ops subflow_request_sock_ops;
+static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
+
+static int subflow_conn_request(struct sock *sk, struct sk_buff *skb)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+
+	pr_debug("subflow=3D%p", subflow);
+
+	/* Never answer to SYNs sent to broadcast or multicast */
+	if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
+		goto drop;
+
+	return tcp_conn_request(&subflow_request_sock_ops,
+				&subflow_request_sock_ipv4_ops,
+				sk, skb);
+drop:
+	tcp_listendrop(sk);
+	return 0;
+}
+
+static struct sock *subflow_syn_recv_sock(const struct sock *sk,
+					  struct sk_buff *skb,
+					  struct request_sock *req,
+					  struct dst_entry *dst,
+					  struct request_sock *req_unhash,
+					  bool *own_req)
+{
+	struct subflow_sock *listener =3D subflow_sk(sk);
+	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
+	struct sock *child;
+
+	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", sk, req, listener->conn);
+
+	child =3D tcp_v4_syn_recv_sock(sk, skb, req, dst, req_unhash, own_req);
+
+	if (child) {
+		struct subflow_sock *subflow =3D subflow_sk(child);
+
+		pr_debug("child=3D%p", child);
+		if (subflow_req->mp_capable) {
+			subflow->mp_capable =3D 1;
+			subflow->fourth_ack =3D 1;
+			subflow->remote_key =3D subflow_req->remote_key;
+			subflow->local_key =3D subflow_req->local_key;
+		} else {
+			subflow->mp_capable =3D 0;
+		}
+	}
+
+	return child;
+}
+
 const struct inet_connection_sock_af_ops subflow_specific =3D {
 	.queue_xmit	   =3D ip_queue_xmit,
 	.send_check	   =3D tcp_v4_send_check,
 	.rebuild_header	   =3D inet_sk_rebuild_header,
 	.sk_rx_dst_set	   =3D subflow_finish_connect,
-	.conn_request	   =3D tcp_v4_conn_request,
-	.syn_recv_sock	   =3D tcp_v4_syn_recv_sock,
+	.conn_request	   =3D subflow_conn_request,
+	.syn_recv_sock	   =3D subflow_syn_recv_sock,
 	.net_header_len	   =3D sizeof(struct iphdr),
 	.setsockopt	   =3D ip_setsockopt,
 	.getsockopt	   =3D ip_getsockopt,
@@ -112,6 +199,21 @@ static void subflow_close(struct sock *sk, long timeou=
t)
 	tcp_close(sk, timeout);
 }
 =

+static struct sock *subflow_accept(struct sock *sk, int flags, int *err,
+				   bool kern)
+{
+	struct subflow_sock *subflow =3D subflow_sk(sk);
+	struct sock *child;
+
+	pr_debug("subflow=3D%p, conn=3D%p", subflow, subflow->conn);
+
+	child =3D inet_csk_accept(sk, flags, err, kern);
+
+	pr_debug("child=3D%p", child);
+
+	return child;
+}
+
 static void subflow_destroy(struct sock *sk)
 {
 	pr_debug("subflow=3D%p", sk);
@@ -125,7 +227,7 @@ static struct proto subflow_prot =3D {
 	.close		=3D subflow_close,
 	.connect	=3D subflow_connect,
 	.disconnect	=3D tcp_disconnect,
-	.accept		=3D inet_csk_accept,
+	.accept		=3D subflow_accept,
 	.ioctl		=3D tcp_ioctl,
 	.init		=3D subflow_init_sock,
 	.destroy	=3D subflow_destroy,
@@ -169,7 +271,14 @@ int mptcp_subflow_init(void)
 =

 	/* TODO: Register path manager callbacks. */
 =

+	subflow_request_sock_ops =3D tcp_request_sock_ops;
+	subflow_request_sock_ops.obj_size =3D sizeof(struct subflow_request_sock),
+
+	subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
+	subflow_request_sock_ipv4_ops.init_req =3D subflow_v4_init_req;
+
 	subflow_prot.twsk_prot		=3D tcp_prot.twsk_prot;
+	subflow_prot.rsk_prot		=3D &subflow_request_sock_ops;
 	subflow_prot.h.hashinfo		=3D tcp_prot.h.hashinfo;
 	err =3D proto_register(&subflow_prot, 1);
 	if (err)
-- =

2.19.1


--===============4035969634596960243==--
