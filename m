Content-Type: multipart/mixed; boundary="===============7483499856931927126=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v5 17/17] mptcp: Make connection_list a real list
 of subflows
Date: Fri, 14 Dec 2018 14:27:15 -0800
Message-ID: <20181214222715.23766-18-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181214222715.23766-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 918

--===============7483499856931927126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 include/net/mptcp.h  |   9 +-
 net/mptcp/protocol.c | 190 ++++++++++++++++++++++++++++++-------------
 2 files changed, 141 insertions(+), 58 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 7be51b696baf..1af6a621c5db 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -16,6 +16,8 @@
 #ifndef __NET_MPTCP_H
 #define __NET_MPTCP_H
 =

+#include <linux/spinlock.h>
+
 /* MPTCP option subtypes */
 =

 #define MPTCPOPT_MP_CAPABLE	0
@@ -42,10 +44,14 @@ struct mptcp_sock {
 	u64		write_seq;
 	atomic64_t	ack_seq;
 	u32		token;
-	struct socket	*connection_list; /* @@ needs to be a list */
+	spinlock_t	conn_list_lock;
+	struct hlist_head conn_list;
 	struct socket	*subflow; /* outgoing connect, listener or !mp_capable */
 };
 =

+#define mptcp_for_each_subflow(__msk, __subflow)			\
+	hlist_for_each_entry_rcu(__subflow, &((__msk)->conn_list), node)
+
 static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
 {
 	return (struct mptcp_sock *)sk;
@@ -72,6 +78,7 @@ struct mptcp_skb_cb {
 struct subflow_sock {
 	/* tcp_sock must be the first member */
 	struct	tcp_sock sk;
+	struct	hlist_node node;// conn_list of subflows
 	u64	local_key;
 	u64	map_seq;
 	u32	map_subflow_seq;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 55df5fd5f972..12857eeded8b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -36,34 +36,48 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	int mss_now, size_goal, poffset, ret;
 	struct mptcp_skb_cb *mcb =3D NULL;
+	struct subflow_sock *subflow;
 	struct page *page =3D NULL;
+	struct hlist_node *node;
 	struct sk_buff *skb;
 	struct sock *ssk;
 	size_t psize;
 =

 	pr_debug("msk=3D%p", msk);
-	if (!msk->connection_list && msk->subflow) {
+	if (msk->subflow) {
 		pr_debug("fallback passthrough");
 		return sock_sendmsg(msk->subflow, msg);
 	}
 =

+	rcu_read_lock();
+	node =3D rcu_dereference(hlist_first_rcu(&msk->conn_list));
+	subflow =3D hlist_entry(node, struct subflow_sock, node);
+	ssk =3D sock_sk(subflow);
+	sock_hold(ssk);
+	rcu_read_unlock();
+
 	if (!msg_data_left(msg)) {
 		pr_debug("empty send");
-		return sock_sendmsg(msk->connection_list, msg);
+		ret =3D sock_sendmsg(sock_sk(subflow)->sk_socket, msg);
+		goto put_out;
 	}
 =

-	ssk =3D msk->connection_list->sk;
+	pr_debug("conn_list->subflow=3D%p", subflow);
 =

-	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
-		return -ENOTSUPP;
+	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL)) {
+		ret =3D -ENOTSUPP;
+		goto put_out;
+	}
 =

 	/* Initial experiment: new page per send.  Real code will
 	 * maintain list of active pages and DSS mappings, append to the
 	 * end and honor zerocopy
 	 */
 	page =3D alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	if (!page) {
+		ret =3D -ENOMEM;
+		goto put_out;
+	}
 =

 	/* Copy to page */
 	poffset =3D 0;
@@ -74,8 +88,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *=
msg, size_t len)
 	pr_debug("left=3D%zu", msg_data_left(msg));
 =

 	if (!psize) {
-		put_page(page);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto put_out;
 	}
 =

 	lock_sock(sk);
@@ -92,9 +106,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr =
*msg, size_t len)
 =

 	ret =3D do_tcp_sendpages(ssk, page, poffset, min_t(int, size_goal, psize),
 			       msg->msg_flags | MSG_SENDPAGE_NOTLAST);
-	put_page(page);
 	if (ret <=3D 0)
-		goto error_out;
+		goto release_out;
 =

 	if (skb =3D=3D tcp_write_queue_tail(ssk))
 		pr_err("no new skb %p/%p", sk, ssk);
@@ -123,10 +136,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 =

 	tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle, size_goal);
 =

-error_out:
+release_out:
 	release_sock(ssk);
 	release_sock(sk);
 =

+put_out:
+	if (page)
+		put_page(page);
+
+	sock_put(ssk);
 	return ret;
 }
 =

@@ -261,19 +279,25 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct subflow_sock *subflow;
 	struct mptcp_read_arg arg;
+	struct hlist_node *node;
 	read_descriptor_t desc;
 	struct tcp_sock *tp;
 	struct sock *ssk;
 	int copied =3D 0;
 	long timeo;
 =

-	if (!msk->connection_list) {
+	if (msk->subflow) {
 		pr_debug("fallback-read subflow=3D%p", msk->subflow->sk);
 		return sock_recvmsg(msk->subflow, msg, flags);
 	}
 =

-	ssk =3D msk->connection_list->sk;
-	subflow =3D subflow_sk(ssk);
+	rcu_read_lock();
+	node =3D rcu_dereference(hlist_first_rcu(&msk->conn_list));
+	subflow =3D hlist_entry(node, struct subflow_sock, node);
+	ssk =3D sock_sk(subflow);
+	sock_hold(ssk);
+	rcu_read_unlock();
+
 	tp =3D tcp_sk(ssk);
 =

 	desc.arg.data =3D &arg;
@@ -429,6 +453,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	release_sock(ssk);
 	release_sock(sk);
 =

+	sock_put(ssk);
+
 	return copied;
 }
 =

@@ -438,22 +464,50 @@ static int mptcp_init_sock(struct sock *sk)
 =

 	pr_debug("msk=3D%p", msk);
 =

+	INIT_HLIST_HEAD(&msk->conn_list);
+	spin_lock_init(&msk->conn_list_lock);
+
 	return 0;
 }
 =

 static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct hlist_node *node;
+	struct socket *ssk =3D NULL;
+	struct subflow_sock *subflow;
 =

+	spin_lock_bh(&msk->conn_list_lock);
 	if (msk->subflow) {
-		pr_debug("subflow=3D%p", msk->subflow->sk);
-		sock_release(msk->subflow);
+		ssk =3D msk->subflow;
+		msk->subflow =3D NULL;
 	}
-
-	if (msk->connection_list) {
-		pr_debug("conn_list->subflow=3D%p", msk->connection_list->sk);
-		sock_release(msk->connection_list);
+	spin_unlock_bh(&msk->conn_list_lock);
+	if (ssk !=3D NULL) {
+		pr_debug("subflow=3D%p", ssk->sk);
+		sock_release(ssk);
 	}
+
+	do {
+		spin_lock_bh(&msk->conn_list_lock);
+		/* The spin lock was just acquired, so tell
+		 * rcu_dereference_check() this access to the list is properly
+		 * protected even though the rcu_read_lock is not held.
+		 */
+		node =3D rcu_dereference_check(
+			hlist_first_rcu(&msk->conn_list),
+			spin_is_locked(&msk->conn_list_lock) ||
+			!IS_ENABLED(CONFIG_SMP));
+		if (node =3D=3D NULL)
+			break;
+		subflow =3D hlist_entry(node, struct subflow_sock, node);
+		hlist_del_rcu(node);
+		spin_unlock_bh(&msk->conn_list_lock);
+		synchronize_rcu();
+		pr_debug("conn_list->subflow=3D%p", subflow);
+		sock_release(sock_sk(subflow)->sk_socket);
+	} while (1);
+	spin_unlock_bh(&msk->conn_list_lock);
 }
 =

 static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
@@ -492,7 +546,10 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 		msk->token =3D subflow->token;
 		pr_debug("token=3D%u", msk->token);
 		token_update_accept(new_sock->sk, mp->sk);
-		msk->connection_list =3D new_sock;
+		spin_lock_bh(&msk->conn_list_lock);
+		hlist_add_head_rcu(&subflow->node, &msk->conn_list);
+		msk->subflow =3D NULL;
+		spin_unlock_bh(&msk->conn_list_lock);
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
@@ -523,46 +580,44 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 			    char __user *uoptval, unsigned int optlen)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow;
 	char __kernel *optval;
 =

-	pr_debug("msk=3D%p", msk);
-	if (msk->connection_list) {
-		subflow =3D msk->connection_list;
-		pr_debug("conn_list->subflow=3D%p", subflow->sk);
-	} else {
-		subflow =3D msk->subflow;
-		pr_debug("subflow=3D%p", subflow->sk);
-	}
-
 	/* will be treated as __user in subflow_setsockopt */
 	optval =3D (char __kernel __force *) uoptval;
 =

-	return kernel_setsockopt(subflow, level, optname, optval, optlen);
+	pr_debug("msk=3D%p", msk);
+	if (msk->subflow) {
+		pr_debug("subflow=3D%p", msk->subflow->sk);
+		return kernel_setsockopt(msk->subflow, level, optname, optval, optlen);
+	}
+
+	/* @@ the meaning of setsockopt() when the socket is connected and
+	 * there are multiple subflows is not defined.
+	 */
+	return 0;
 }
 =

 static int mptcp_getsockopt(struct sock *sk, int level, int optname,
 			    char __user *uoptval, int __user *uoption)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	struct socket *subflow;
 	char __kernel *optval;
 	int __kernel *option;
 =

-	pr_debug("msk=3D%p", msk);
-	if (msk->connection_list) {
-		subflow =3D msk->connection_list;
-		pr_debug("conn_list->subflow=3D%p", subflow->sk);
-	} else {
-		subflow =3D msk->subflow;
-		pr_debug("subflow=3D%p", subflow->sk);
-	}
-
 	/* will be treated as __user in subflow_getsockopt */
 	optval =3D (char __kernel __force *) uoptval;
 	option =3D (int __kernel __force *) uoption;
 =

-	return kernel_getsockopt(subflow, level, optname, optval, option);
+	pr_debug("msk=3D%p", msk);
+	if (msk->subflow) {
+		pr_debug("subflow=3D%p", msk->subflow->sk);
+		return kernel_getsockopt(msk->subflow, level, optname, optval, option);
+	}
+
+	/* @@ the meaning of setsockopt() when the socket is connected and
+	 * there are multiple subflows is not defined.
+	 */
+	return 0;
 }
 =

 static int mptcp_get_port(struct sock *sk, unsigned short snum)
@@ -589,8 +644,10 @@ void mptcp_finish_connect(struct sock *sk, int mp_capa=
ble)
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
 		pr_debug("token=3D%u", msk->token);
-		msk->connection_list =3D msk->subflow;
+		spin_lock_bh(&msk->conn_list_lock);
+		hlist_add_head_rcu(&subflow->node, &msk->conn_list);
 		msk->subflow =3D NULL;
+		spin_unlock_bh(&msk->conn_list_lock);
 =

 		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
 		msk->write_seq =3D subflow->idsn + 1;
@@ -658,17 +715,32 @@ int mptcp_stream_connect(struct socket *sock, struct =
sockaddr *uaddr,
 int mptcp_stream_getname(struct socket *sock, struct sockaddr *uaddr, int =
peer)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
-	struct socket *subflow;
-	int err =3D -EPERM;
+	struct subflow_sock *subflow;
+	struct hlist_node *node;
+	struct sock *ssk;
+	int ret;
 =

-	if (msk->connection_list)
-		subflow =3D msk->connection_list;
-	else
-		subflow =3D msk->subflow;
+	pr_debug("msk=3D%p", msk);
 =

-	err =3D inet_getname(subflow, uaddr, peer);
+	if (msk->subflow) {
+		pr_debug("subflow=3D%p", msk->subflow->sk);
+		return inet_getname(msk->subflow, uaddr, peer);
+	}
 =

-	return err;
+	/* @@ the meaning of getname() for the remote peer when the socket
+	 * is connected and there are multiple subflows is not defined.
+	 * For now just use the first subflow on the list.
+	 */
+	rcu_read_lock();
+	node =3D rcu_dereference(hlist_first_rcu(&msk->conn_list));
+	subflow =3D hlist_entry(node, struct subflow_sock, node);
+	ssk =3D sock_sk(subflow);
+	sock_hold(ssk);
+	rcu_read_unlock();
+
+	ret =3D inet_getname(sock_sk(subflow)->sk_socket, uaddr, peer);
+	sock_put(ssk);
+	return ret;
 }
 =

 int mptcp_stream_listen(struct socket *sock, int backlog)
@@ -702,18 +774,22 @@ int mptcp_stream_accept(struct socket *sock, struct s=
ocket *newsock, int flags,
 int mptcp_stream_shutdown(struct socket *sock, int how)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
+	struct subflow_sock *subflow;
 	int ret =3D 0;
 =

 	pr_debug("sk=3D%p, how=3D%d", msk, how);
 =

 	if (msk->subflow) {
 		pr_debug("subflow=3D%p", msk->subflow->sk);
-		ret =3D kernel_sock_shutdown(msk->subflow, how);
+		return kernel_sock_shutdown(msk->subflow, how);
 	}
-	if (msk->connection_list) {
-		pr_debug("conn_list->subflow=3D%p", msk->connection_list->sk);
-		ret =3D kernel_sock_shutdown(msk->connection_list, how);
+
+	rcu_read_lock();
+	mptcp_for_each_subflow(msk, subflow) {
+		pr_debug("conn_list->subflow=3D%p", subflow);
+		ret =3D kernel_sock_shutdown(sock_sk(subflow)->sk_socket, how);
 	}
+	rcu_read_unlock();
 =

 	return ret;
 }
-- =

2.20.0


--===============7483499856931927126==--
