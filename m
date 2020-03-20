Content-Type: multipart/mixed; boundary="===============1068296828165143921=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 4/5] Squash-to: "mptcp: Add handling of outgoing
 MP_JOIN requests"
Date: Fri, 20 Mar 2020 19:34:42 +0100
Message-ID: <157da81bbfaf640ccb2304fd0aad703e243b3b6a.1584728932.git.pabeni@redhat.com>
In-Reply-To: cover.1584728931.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4029

--===============1068296828165143921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is just a rebase of existing later patch
"subflow: place further subflows on new 'join_list'".

The original should be update accordingly changing:

"""
When a valid SYN-ACK is received the
new sock is added to the tail of the mptcp sock conn_list
where it will not interfere with data flow on the original
connection.
"""

With something alike:

"""
Passive sockets can't acquire the mptcp socket lock at
subflow creation time, so an additional list protected by
a new spinlock is used to track the MPJ subflows.

Such list is spliced into conn_list tail every time the msk
socket lock is acquired, so that it will not interfere
with data flow on the original connection.
"""

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 31 ++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  |  5 ++++-
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a9a7fac6fb5a..84c28b4326ff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -241,6 +241,16 @@ void mptcp_data_ready(struct sock *sk, struct sock *ss=
k)
 	sk->sk_data_ready(sk);
 }
 =

+static void __mptcp_flush_join_list(struct mptcp_sock *msk)
+{
+	if (likely(list_empty(&msk->join_list)))
+		return;
+
+	spin_lock_bh(&msk->join_list_lock);
+	list_splice_tail_init(&msk->join_list, &msk->conn_list);
+	spin_unlock_bh(&msk->join_list_lock);
+}
+
 static bool mptcp_ext_cache_refill(struct mptcp_sock *msk)
 {
 	if (!msk->cached_ext)
@@ -462,6 +472,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 		return ret >=3D 0 ? ret + copied : (copied ? copied : ret);
 	}
 =

+	__mptcp_flush_join_list(msk);
 	ssk =3D mptcp_subflow_get_send(msk);
 	while (!sk_stream_memory_free(sk) || !ssk) {
 		ret =3D sk_stream_wait_memory(sk, &timeo);
@@ -603,6 +614,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 =

 	len =3D min_t(size_t, len, INT_MAX);
 	target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
+	__mptcp_flush_join_list(msk);
 =

 	while (len > (size_t)copied) {
 		int bytes_read;
@@ -718,6 +730,7 @@ static void mptcp_worker(struct work_struct *work)
 	struct sock *sk =3D &msk->sk.icsk_inet.sk;
 =

 	lock_sock(sk);
+	__mptcp_flush_join_list(msk);
 	__mptcp_move_skbs(msk);
 	release_sock(sk);
 	sock_put(sk);
@@ -727,7 +740,10 @@ static int __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

+	spin_lock_init(&msk->join_list_lock);
+
 	INIT_LIST_HEAD(&msk->conn_list);
+	INIT_LIST_HEAD(&msk->join_list);
 	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 	INIT_WORK(&msk->work, mptcp_worker);
 =

@@ -800,6 +816,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 	mptcp_token_destroy(msk->token);
 	inet_sk_state_store(sk, TCP_CLOSE);
 =

+	__mptcp_flush_join_list(msk);
+
 	list_splice_init(&msk->conn_list, &conn_list);
 =

 	data_fin_tx_seq =3D msk->write_seq;
@@ -1111,6 +1129,7 @@ bool mptcp_finish_join(struct sock *sk)
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct sock *parent =3D (void *)msk;
 	struct socket *parent_sock;
+	bool ret;
 =

 	pr_debug("msk=3D%p, subflow=3D%p", msk, subflow);
 =

@@ -1126,7 +1145,15 @@ bool mptcp_finish_join(struct sock *sk)
 	if (parent_sock && !sk->sk_socket)
 		mptcp_sock_graft(sk, parent_sock);
 =

-	return mptcp_pm_allow_new_subflow(msk);
+	ret =3D mptcp_pm_allow_new_subflow(msk);
+	if (ret) {
+		/* active connections are already on conn_list */
+		spin_lock_bh(&msk->join_list_lock);
+		if (!WARN_ON_ONCE(!list_empty(&subflow->node)))
+			list_add_tail(&subflow->node, &msk->join_list);
+		spin_unlock_bh(&msk->join_list_lock);
+	}
+	return ret;
 }
 =

 bool mptcp_sk_is_subflow(const struct sock *sk)
@@ -1315,6 +1342,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
+		__mptcp_flush_join_list(msk);
 		list_for_each_entry(subflow, &msk->conn_list, node) {
 			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

@@ -1396,6 +1424,7 @@ static int mptcp_shutdown(struct socket *sock, int ho=
w)
 			sock->state =3D SS_CONNECTED;
 	}
 =

+	__mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index abc9da787dd7..df134ac91274 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -150,8 +150,10 @@ struct mptcp_sock {
 	u32		token;
 	unsigned long	flags;
 	bool		can_ack;
+	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct list_head conn_list;
+	struct list_head join_list;
 	struct skb_ext	*cached_ext;	/* for the next sendmsg */
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 740a6b43fad7..bf58b599a820 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -865,10 +865,13 @@ int __mptcp_subflow_connect(struct sock *sk, int ifin=
dex,
 	if (err && err !=3D -EINPROGRESS)
 		goto failed;
 =

+	spin_lock_bh(&msk->join_list_lock);
+	list_add_tail(&subflow->node, &msk->join_list);
+	spin_unlock_bh(&msk->join_list_lock);
+
 	return err;
 =

 failed:
-	list_del_init(&subflow->node);
 	sock_release(sf);
 	return err;
 }
-- =

2.21.1

--===============1068296828165143921==--
