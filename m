Content-Type: multipart/mixed; boundary="===============8946083415343346476=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 05/15] mptcp: Create SUBFLOW socket for incoming
 connections
Date: Fri, 13 Dec 2019 21:50:56 +0100
Message-ID: <20191213205106.2467313-6-matthieu.baerts@tessares.net>
In-Reply-To: 20191213205106.2467313-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2998

--===============8946083415343346476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)linux.intel.com>

Add subflow_request_sock type that extends tcp_request_sock
and add an is_mptcp flag to tcp_request_sock distinguish them.

Override the listen() and accept() methods of the MPTCP
socket proto_ops so they may act on the subflow socket.

Override the conn_request() and syn_recv_sock() handlers
in the inet_connection_sock to handle incoming MPTCP
SYNs and the ACK to the response SYN.

Add handling in tcp_output.c to add MP_CAPABLE to an outgoing
SYN-ACK response for a subflow_request_sock.

Co-developed-by: Davide Caratti <dcaratti(a)redhat.com>
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
Co-developed-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Co-developed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 238 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 233 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5458fec59c38..147a3a9fdc0a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -14,6 +14,9 @@
 #include <net/inet_hashtables.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+#include <net/transp_v6.h>
+#endif
 #include <net/mptcp.h>
 #include "protocol.h"
 =

@@ -210,6 +213,92 @@ static void mptcp_close(struct sock *sk, long timeout)
 	sk_common_release(sk);
 }
 =

+static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
+{
+	const struct ipv6_pinfo *ssk6 =3D inet6_sk(ssk);
+	struct ipv6_pinfo *msk6 =3D inet6_sk(msk);
+
+	inet_sk(msk)->inet_num =3D inet_sk(ssk)->inet_num;
+	inet_sk(msk)->inet_dport =3D inet_sk(ssk)->inet_dport;
+	inet_sk(msk)->inet_sport =3D inet_sk(ssk)->inet_sport;
+	inet_sk(msk)->inet_daddr =3D inet_sk(ssk)->inet_daddr;
+	inet_sk(msk)->inet_saddr =3D inet_sk(ssk)->inet_saddr;
+	inet_sk(msk)->inet_rcv_saddr =3D inet_sk(ssk)->inet_rcv_saddr;
+
+#if IS_ENABLED(CONFIG_IPV6)
+	msk->sk_v6_daddr =3D ssk->sk_v6_daddr;
+	msk->sk_v6_rcv_saddr =3D ssk->sk_v6_rcv_saddr;
+
+	if (msk6 && ssk6) {
+		msk6->saddr =3D ssk6->saddr;
+		msk6->flow_label =3D ssk6->flow_label;
+	}
+#endif
+}
+
+static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
+				 bool kern)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct socket *listener;
+	struct sock *newsk;
+
+	listener =3D __mptcp_nmpc_socket(msk);
+	if (WARN_ON_ONCE(!listener)) {
+		*err =3D -EINVAL;
+		return NULL;
+	}
+
+	pr_debug("msk=3D%p, listener=3D%p", msk, mptcp_subflow_ctx(listener->sk));
+	newsk =3D inet_csk_accept(listener->sk, flags, err, kern);
+	if (!newsk)
+		return NULL;
+
+	subflow =3D mptcp_subflow_ctx(newsk);
+	pr_debug("msk=3D%p, new subflow=3D%p, ", msk, subflow);
+
+	if (subflow->mp_capable) {
+		struct sock *new_mptcp_sock;
+		struct sock *ssk =3D newsk;
+
+		lock_sock(sk);
+
+		local_bh_disable();
+		new_mptcp_sock =3D sk_clone_lock(sk, GFP_ATOMIC);
+		if (!new_mptcp_sock) {
+			*err =3D -ENOBUFS;
+			local_bh_enable();
+			release_sock(sk);
+			tcp_close(newsk, 0);
+			return NULL;
+		}
+
+		mptcp_init_sock(new_mptcp_sock);
+
+		msk =3D mptcp_sk(new_mptcp_sock);
+		msk->remote_key =3D subflow->remote_key;
+		msk->local_key =3D subflow->local_key;
+		msk->subflow =3D NULL;
+
+		newsk =3D new_mptcp_sock;
+		mptcp_copy_inaddrs(newsk, ssk);
+		list_add(&subflow->node, &msk->conn_list);
+
+		/* will be fully established at mptcp_stream_accept()
+		 * completion.
+		 */
+		inet_sk_state_store(new_mptcp_sock, TCP_SYN_RECV);
+		bh_unlock_sock(new_mptcp_sock);
+		local_bh_enable();
+		release_sock(sk);
+	} else {
+		tcp_sk(newsk)->is_mptcp =3D 0;
+	}
+
+	return newsk;
+}
+
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -244,12 +333,21 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->local_key, subflow->local_key);
 }
 =

+static void mptcp_sock_graft(struct sock *sk, struct socket *parent)
+{
+	write_lock_bh(&sk->sk_callback_lock);
+	rcu_assign_pointer(sk->sk_wq, &parent->wq);
+	sk_set_socket(sk, parent);
+	sk->sk_uid =3D SOCK_INODE(parent)->i_uid;
+	write_unlock_bh(&sk->sk_callback_lock);
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
@@ -264,10 +362,7 @@ static int mptcp_bind(struct socket *sock, struct sock=
addr *uaddr, int addr_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
 	struct socket *ssock;
-	int err =3D -ENOTSUPP;
-
-	if (uaddr->sa_family !=3D AF_INET) // @@ allow only IPv4 for now
-		return err;
+	int err;
 =

 	lock_sock(sock->sk);
 	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
@@ -277,6 +372,8 @@ static int mptcp_bind(struct socket *sock, struct socka=
ddr *uaddr, int addr_len)
 	}
 =

 	err =3D ssock->ops->bind(ssock, uaddr, addr_len);
+	if (!err)
+		mptcp_copy_inaddrs(sock->sk, ssock->sk);
 =

 unlock:
 	release_sock(sock->sk);
@@ -297,14 +394,139 @@ static int mptcp_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
 		goto unlock;
 	}
 =

+#ifdef CONFIG_TCP_MD5SIG
+	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
+	 * TCP option space.
+	 */
+	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
+		mptcp_subflow_ctx(ssock->sk)->request_mptcp =3D 0;
+#endif
+
 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
 	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
+	mptcp_copy_inaddrs(sock->sk, ssock->sk);
+
+unlock:
+	release_sock(sock->sk);
+	return err;
+}
+
+static int mptcp_v4_getname(struct socket *sock, struct sockaddr *uaddr,
+			    int peer)
+{
+	if (sock->sk->sk_prot =3D=3D &tcp_prot) {
+		/* we are being invoked from __sys_accept4, after
+		 * mptcp_accept() has just accepted a non-mp-capable
+		 * flow: sk is a tcp_sk, not an mptcp one.
+		 *
+		 * Hand the socket over to tcp so all further socket ops
+		 * bypass mptcp.
+		 */
+		sock->ops =3D &inet_stream_ops;
+	}
+
+	return inet_getname(sock, uaddr, peer);
+}
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static int mptcp_v6_getname(struct socket *sock, struct sockaddr *uaddr,
+			    int peer)
+{
+	if (sock->sk->sk_prot =3D=3D &tcpv6_prot) {
+		/* we are being invoked from __sys_accept4 after
+		 * mptcp_accept() has accepted a non-mp-capable
+		 * subflow: sk is a tcp_sk, not mptcp.
+		 *
+		 * Hand the socket over to tcp so all further
+		 * socket ops bypass mptcp.
+		 */
+		sock->ops =3D &inet6_stream_ops;
+	}
+
+	return inet6_getname(sock, uaddr, peer);
+}
+#endif
+
+static int mptcp_listen(struct socket *sock, int backlog)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *ssock;
+	int err;
+
+	pr_debug("msk=3D%p", msk);
+
+	lock_sock(sock->sk);
+	ssock =3D __mptcp_socket_create(msk, TCP_LISTEN);
+	if (IS_ERR(ssock)) {
+		err =3D PTR_ERR(ssock);
+		goto unlock;
+	}
+
+	err =3D ssock->ops->listen(ssock, backlog);
+	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
+	if (!err)
+		mptcp_copy_inaddrs(sock->sk, ssock->sk);
 =

 unlock:
 	release_sock(sock->sk);
 	return err;
 }
 =

+static bool is_tcp_proto(const struct proto *p)
+{
+#ifdef CONFIG_MPTCP_IPV6
+	return p =3D=3D &tcp_prot || p =3D=3D &tcpv6_prot;
+#else
+	return p =3D=3D &tcp_prot;
+#endif
+}
+
+static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
+			       int flags, bool kern)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct socket *ssock;
+	int err;
+
+	pr_debug("msk=3D%p", msk);
+
+	lock_sock(sock->sk);
+	if (sock->sk->sk_state !=3D TCP_LISTEN)
+		goto unlock_fail;
+
+	ssock =3D __mptcp_nmpc_socket(msk);
+	if (!ssock)
+		goto unlock_fail;
+
+	sock_hold(ssock->sk);
+	release_sock(sock->sk);
+
+	err =3D ssock->ops->accept(sock, newsock, flags, kern);
+	if (err =3D=3D 0 && !is_tcp_proto(newsock->sk->sk_prot)) {
+		struct mptcp_sock *msk =3D mptcp_sk(newsock->sk);
+		struct mptcp_subflow_context *subflow;
+
+		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
+		 * This is needed so NOSPACE flag can be set from tcp stack.
+		 */
+		list_for_each_entry(subflow, &msk->conn_list, node) {
+			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+			if (!ssk->sk_socket)
+				mptcp_sock_graft(ssk, newsock);
+		}
+
+		inet_sk_state_store(newsock->sk, TCP_ESTABLISHED);
+	}
+
+	sock_put(ssock->sk);
+	return err;
+
+unlock_fail:
+	release_sock(sock->sk);
+	return -EINVAL;
+}
+
 static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait)
 {
@@ -330,6 +552,9 @@ void __init mptcp_init(void)
 	mptcp_stream_ops.bind =3D mptcp_bind;
 	mptcp_stream_ops.connect =3D mptcp_stream_connect;
 	mptcp_stream_ops.poll =3D mptcp_poll;
+	mptcp_stream_ops.accept =3D mptcp_stream_accept;
+	mptcp_stream_ops.getname =3D mptcp_v4_getname;
+	mptcp_stream_ops.listen =3D mptcp_listen;
 =

 	mptcp_subflow_init();
 =

@@ -369,6 +594,9 @@ int mptcpv6_init(void)
 	mptcp_v6_stream_ops.bind =3D mptcp_bind;
 	mptcp_v6_stream_ops.connect =3D mptcp_stream_connect;
 	mptcp_v6_stream_ops.poll =3D mptcp_poll;
+	mptcp_v6_stream_ops.accept =3D mptcp_stream_accept;
+	mptcp_v6_stream_ops.getname =3D mptcp_v6_getname;
+	mptcp_v6_stream_ops.listen =3D mptcp_listen;
 =

 	err =3D inet6_register_protosw(&mptcp_v6_protosw);
 	if (err)
-- =

2.24.0

--===============8946083415343346476==--
