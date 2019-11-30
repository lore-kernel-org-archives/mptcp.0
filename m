Content-Type: multipart/mixed; boundary="===============7409132515705391465=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 6/9] make accept not allocate kernel socket struct
Date: Sat, 30 Nov 2019 23:48:57 +0100
Message-ID: <20191130224900.8694-7-fw@strlen.de>
In-Reply-To: 20191130224900.8694-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2719

--===============7409132515705391465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Once lower-level accept returns, walk the subflow list (there should
be one subflow) and make sk->sk_socket point to the new mptcp socket.

This is needed to make NOSPACE flag work: tcp stack can't signal
availability of new data unless ->sk_socket points to a "struct socket".

If sk_socket is NULL, then from TCP stack p.o.v.  the socket has been
detached from the userspace program already, so nothing to wake up in
first place.

mptcp_close needs to handle both cases: connect()ing sockets have a
'struct socket' allocated, while incoming ones do not.

v2: clarify sk_prot =3D=3D &mptcp_prot || is_mptcp_v6(newsock) construct,
    prefer a '!=3D tcp_prot' here.
    Add and use helper for subflow closing and add comment as to
    why incoming/outgoing ssk get different treatment.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 83 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 360b04edb895..bca290c05839 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -763,6 +763,32 @@ static struct sock *mptcp_subflow_get_retrans(const st=
ruct mptcp_sock *msk)
 	return backup;
 }
 =

+/* subflow sockets can be either outgoing (connect) or incoming
+ * (accept).
+ *
+ * Outgoing subflows use in-kernel sockets.
+ * Incoming subflows do not have their own 'struct socket' allocated,
+ * so we need to use tcp_close() after detaching them from the mptcp
+ * parent socket.
+ */
+static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
+			      struct mptcp_subflow_context *subflow,
+			      long timeout)
+{
+	struct socket *sock =3D READ_ONCE(ssk->sk_socket);
+
+	list_del(&subflow->node);
+
+	if (sock && sock !=3D sk->sk_socket) {
+		/* outgoing subflow */
+		sock_release(sock);
+	} else {
+		/* incoming subflow */
+		sock_orphan(ssk);
+		tcp_close(ssk, timeout);
+	}
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	int orig_len, orig_offset, ret, mss_now =3D 0, size_goal =3D 0;
@@ -925,9 +951,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

-		pr_debug("conn_list->subflow=3D%p", subflow);
-		list_del(&subflow->node);
-		sock_release(ssk->sk_socket);
+		__mptcp_close_ssk(sk, ssk, subflow, timeout);
 	}
 =

 	__mptcp_clear_xmit(sk);
@@ -975,23 +999,22 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
-	struct socket *new_sock;
 	struct socket *listener;
 	struct sock *newsk;
 =

 	listener =3D msk->subflow;
 =

 	pr_debug("msk=3D%p, listener=3D%p", msk, mptcp_subflow_ctx(listener->sk));
-	*err =3D kernel_accept(listener, &new_sock, flags);
-	if (*err < 0)
+	newsk =3D inet_csk_accept(listener->sk, flags, err, kern);
+	if (!newsk)
 		return NULL;
 =

-	subflow =3D mptcp_subflow_ctx(new_sock->sk);
+	subflow =3D mptcp_subflow_ctx(newsk);
 	pr_debug("msk=3D%p, new subflow=3D%p, ", msk, subflow);
 =

 	if (subflow->mp_capable) {
-		struct sock *ssk =3D new_sock->sk;
 		struct sock *new_mptcp_sock;
+		struct sock *ssk =3D newsk;
 		u64 ack_seq;
 =

 		lock_sock(sk);
@@ -1002,8 +1025,8 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 			*err =3D -ENOBUFS;
 			local_bh_enable();
 			release_sock(sk);
-			kernel_sock_shutdown(new_sock, SHUT_RDWR);
-			sock_release(new_sock);
+			mptcp_subflow_shutdown(newsk, SHUT_RDWR + 1);
+			tcp_close(newsk, 0);
 			return NULL;
 		}
 =

@@ -1014,7 +1037,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		msk->local_key =3D subflow->local_key;
 		msk->token =3D subflow->token;
 =

-		mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
+		mptcp_token_update_accept(newsk, new_mptcp_sock);
 		msk->subflow =3D NULL;
 =

 		mptcp_pm_new_connection(msk, 1);
@@ -1047,10 +1070,7 @@ static struct sock *mptcp_accept(struct sock *sk, in=
t flags, int *err,
 			mptcp_subflow_data_available(ssk);
 		release_sock(ssk);
 	} else {
-		newsk =3D new_sock->sk;
 		tcp_sk(newsk)->is_mptcp =3D 0;
-		new_sock->sk =3D NULL;
-		sock_release(new_sock);
 =

 		MPTCP_INC_STATS(sock_net(sk),
 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
@@ -1213,11 +1233,21 @@ void mptcp_finish_connect(struct sock *sk, int mp_c=
apable)
 	inet_sk_state_store(sk, TCP_ESTABLISHED);
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
 bool mptcp_finish_join(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct sock *parent =3D (void *)msk;
+	struct socket *parent_sock;
 	bool ret =3D false;
 =

 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
@@ -1229,8 +1259,14 @@ bool mptcp_finish_join(struct sock *sk)
 	if (parent->sk_state !=3D TCP_ESTABLISHED)
 		goto out;
 =

-	ret =3D true;
-	list_add_tail(&subflow->node, &msk->conn_list);
+	parent_sock =3D READ_ONCE(parent->sk_socket);
+	if (parent_sock) {
+		if (!sk->sk_socket)
+			mptcp_sock_graft(sk, parent_sock);
+
+		ret =3D true;
+		list_add_tail(&subflow->node, &msk->conn_list);
+	}
 out:
 	bh_unlock_sock(subflow->conn);
 	local_bh_enable();
@@ -1452,6 +1488,21 @@ static int mptcp_stream_accept(struct socket *sock, =
struct socket *newsock,
 		return -EINVAL;
 =

 	err =3D ssock->ops->accept(sock, newsock, flags, kern);
+	if (err =3D=3D 0 && newsock->sk->sk_prot !=3D &tcp_prot) {
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
+	}
+
 	sock_put(ssock->sk);
 	return err;
 }
-- =

2.23.0

--===============7409132515705391465==--
