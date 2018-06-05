Content-Type: multipart/mixed; boundary="===============3078310167153338936=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 08/19] mptcp: Create SUBFLOW socket for
 incoming connections
Date: Tue, 05 Jun 2018 16:40:27 -0700
Message-ID: <20180605234038.28497-9-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180605234038.28497-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 651

--===============3078310167153338936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Override the conn_request() and syn_recv_sock() handlers
in the inet_connection_sock to handle incoming MPTCP
SYNs and the ACK to the response SYN.

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 net/mptcp/protocol.c |  52 ++++++++++++++++++-
 net/mptcp/subflow.c  | 115 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 162 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 368854740333..d401c197caf3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -118,6 +118,44 @@ static void mptcp_close(struct sock *sk, long timeout)
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
@@ -167,12 +205,22 @@ int mptcp_stream_connect(struct socket *sock, struct =
sockaddr *uaddr,
 	return err;
 }
 =

+int mptcp_listen(struct socket *sock, int backlog)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *subflow =3D msk->subflow;
+
+	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow->sk);
+
+	return inet_listen(subflow, backlog);
+}
+
 static struct proto mptcp_prot =3D {
 	.name		=3D "MPTCP",
 	.owner		=3D THIS_MODULE,
 	.init		=3D mptcp_init_sock,
 	.close		=3D mptcp_close,
-	.accept		=3D inet_csk_accept,
+	.accept		=3D mptcp_accept,
 	.connect	=3D mptcp_connect,
 	.shutdown	=3D tcp_shutdown,
 	.sendmsg	=3D mptcp_sendmsg,
@@ -195,7 +243,7 @@ const struct proto_ops mptcp_stream_ops =3D {
 	.getname	   =3D inet_getname,
 	.poll		   =3D tcp_poll,
 	.ioctl		   =3D inet_ioctl,
-	.listen		   =3D inet_listen,
+	.listen		   =3D mptcp_listen,
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

2.17.1


--===============3078310167153338936==--
