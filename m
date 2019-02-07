Content-Type: multipart/mixed; boundary="===============2658735928663750667=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC mptcp 3/4] mptcp: add and use mptcp_subflow_hold
Date: Thu, 07 Feb 2019 15:27:10 +0100
Message-ID: <20190207142711.3475-4-fw@strlen.de>
In-Reply-To: 20190207142711.3475-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 992

--===============2658735928663750667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

subflow sockets already have lifetime managed by RCU, so we can
switch to atimic_inc_not_zero and skip/pretend we did not find
such socket in the mptcp subflow list.

This is required to get rid of synchronize_rcu() from mptcp_close().

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 63 ++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 12857eeded8b..91db8a0c222d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -31,14 +31,35 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 }
 #define after64(seq2, seq1)	before64(seq1, seq2)
 =

+static bool mptcp_subflow_hold(struct subflow_sock *sk)
+{
+	struct sock *_sk =3D (struct sock *)sk;
+
+	return refcount_inc_not_zero(&_sk->sk_refcnt);
+}
+
+static struct sock *mptcp_subflow_get_ref(const struct mptcp_sock *msk)
+{
+	struct subflow_sock *subflow;
+
+	rcu_read_lock();
+	mptcp_for_each_subflow(msk, subflow) {
+		if (mptcp_subflow_hold(subflow)) {
+			rcu_read_unlock();
+			return (struct sock *)subflow;
+		}
+	}
+
+	rcu_read_unlock();
+	return NULL;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	int mss_now, size_goal, poffset, ret;
 	struct mptcp_skb_cb *mcb =3D NULL;
-	struct subflow_sock *subflow;
 	struct page *page =3D NULL;
-	struct hlist_node *node;
 	struct sk_buff *skb;
 	struct sock *ssk;
 	size_t psize;
@@ -49,20 +70,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		return sock_sendmsg(msk->subflow, msg);
 	}
 =

-	rcu_read_lock();
-	node =3D rcu_dereference(hlist_first_rcu(&msk->conn_list));
-	subflow =3D hlist_entry(node, struct subflow_sock, node);
-	ssk =3D sock_sk(subflow);
-	sock_hold(ssk);
-	rcu_read_unlock();
+	ssk =3D mptcp_subflow_get_ref(msk);
+	if (!ssk)
+		return -ENOTCONN;
 =

 	if (!msg_data_left(msg)) {
 		pr_debug("empty send");
-		ret =3D sock_sendmsg(sock_sk(subflow)->sk_socket, msg);
+		ret =3D sock_sendmsg(ssk->sk_socket, msg);
 		goto put_out;
 	}
 =

-	pr_debug("conn_list->subflow=3D%p", subflow);
+	pr_debug("conn_list->subflow=3D%p", ssk);
 =

 	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL)) {
 		ret =3D -ENOTSUPP;
@@ -279,7 +297,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct subflow_sock *subflow;
 	struct mptcp_read_arg arg;
-	struct hlist_node *node;
 	read_descriptor_t desc;
 	struct tcp_sock *tp;
 	struct sock *ssk;
@@ -291,13 +308,11 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
 		return sock_recvmsg(msk->subflow, msg, flags);
 	}
 =

-	rcu_read_lock();
-	node =3D rcu_dereference(hlist_first_rcu(&msk->conn_list));
-	subflow =3D hlist_entry(node, struct subflow_sock, node);
-	ssk =3D sock_sk(subflow);
-	sock_hold(ssk);
-	rcu_read_unlock();
+	ssk =3D mptcp_subflow_get_ref(msk);
+	if (!ssk)
+		return -ENOTCONN;
 =

+	subflow =3D subflow_sk(ssk);
 	tp =3D tcp_sk(ssk);
 =

 	desc.arg.data =3D &arg;
@@ -715,8 +730,6 @@ int mptcp_stream_connect(struct socket *sock, struct so=
ckaddr *uaddr,
 int mptcp_stream_getname(struct socket *sock, struct sockaddr *uaddr, int =
peer)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
-	struct subflow_sock *subflow;
-	struct hlist_node *node;
 	struct sock *ssk;
 	int ret;
 =

@@ -731,14 +744,12 @@ int mptcp_stream_getname(struct socket *sock, struct =
sockaddr *uaddr, int peer)
 	 * is connected and there are multiple subflows is not defined.
 	 * For now just use the first subflow on the list.
 	 */
-	rcu_read_lock();
-	node =3D rcu_dereference(hlist_first_rcu(&msk->conn_list));
-	subflow =3D hlist_entry(node, struct subflow_sock, node);
-	ssk =3D sock_sk(subflow);
-	sock_hold(ssk);
-	rcu_read_unlock();
 =

-	ret =3D inet_getname(sock_sk(subflow)->sk_socket, uaddr, peer);
+	ssk =3D mptcp_subflow_get_ref(msk);
+	if (!ssk)
+		return -ENOTCONN;
+
+	ret =3D inet_getname(ssk->sk_socket, uaddr, peer);
 	sock_put(ssk);
 	return ret;
 }
-- =

2.19.2


--===============2658735928663750667==--
