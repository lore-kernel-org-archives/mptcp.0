Content-Type: multipart/mixed; boundary="===============5100403776294750658=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 8/9] subflow: place further subflows on new 'join_list'
Date: Sat, 30 Nov 2019 23:48:59 +0100
Message-ID: <20191130224900.8694-9-fw@strlen.de>
In-Reply-To: 20191130224900.8694-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2721

--===============5100403776294750658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the pm worker queue establishes a new subflow in addition to an
existing one, we never place this socket on any list, ie. if such a request
would time out/never complete we can't clean it up.

Place them on a new join_list. When the connection completes, the
subflow is moved to the conn_list.
If it never completes, the socket gets closed at mptcp_shutdown time.

Not done yet:
1. extend mptcp worker to collect timed-out entries
2. prevent arbitrary growth of pending ssks.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 14 +++++++++++++-
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 16 +++++++++++-----
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0c61487a587d..36097008dd4a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -859,6 +859,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	INIT_LIST_HEAD(&msk->conn_list);
+	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
 =

 	INIT_WORK(&msk->rtx_work, mptcp_worker);
@@ -948,6 +949,12 @@ static void mptcp_close(struct sock *sk, long timeout)
 		msk->subflow =3D NULL;
 	}
 =

+	list_for_each_entry_safe(subflow, tmp, &msk->join_list, node) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		__mptcp_close_ssk(sk, ssk, subflow, timeout);
+	}
+
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

@@ -1223,7 +1230,7 @@ void mptcp_finish_connect(struct sock *ssk)
 		subflow->map_seq =3D ack_seq;
 		subflow->map_subflow_seq =3D 1;
 		subflow->rel_write_seq =3D 1;
-		list_add(&subflow->node, &msk->conn_list);
+		list_move(&subflow->node, &msk->conn_list);
 		msk->subflow =3D NULL;
 		bh_unlock_sock(sk);
 		local_bh_enable();
@@ -1260,6 +1267,11 @@ bool mptcp_finish_join(struct sock *sk)
 	if (parent->sk_state !=3D TCP_ESTABLISHED)
 		goto out;
 =

+	/* unlink from join_list; caller must free ssk if
+	 * we return false below.
+	 */
+	list_del_init(&subflow->node);
+
 	parent_sock =3D READ_ONCE(parent->sk_socket);
 	if (parent_sock) {
 		if (!sk->sk_socket)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 90af5a84f16c..990da61fa51b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -137,6 +137,7 @@ struct mptcp_sock {
 	struct work_struct rtx_work;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
+	struct list_head join_list;
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct mptcp_pm_data	pm;
 	u8		addr_signal;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a89513210ea1..8c13e9a145d5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -700,6 +700,11 @@ int mptcp_subflow_connect(struct sock *sk, struct sock=
addr *local,
 	int err;
 =

 	lock_sock(sk);
+	if (sk->sk_state !=3D TCP_ESTABLISHED) {
+		release_sock(sk);
+		return -ENOTCONN;
+	}
+
 	err =3D mptcp_subflow_create_socket(sk, &sf);
 	if (err) {
 		release_sock(sk);
@@ -711,9 +716,6 @@ int mptcp_subflow_connect(struct sock *sk, struct socka=
ddr *local,
 	subflow->local_key =3D msk->local_key;
 	subflow->token =3D msk->token;
 =

-	sock_hold(sf->sk);
-	release_sock(sk);
-
 	addrlen =3D sizeof(struct sockaddr_in);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (local->sa_family =3D=3D AF_INET6)
@@ -730,15 +732,18 @@ int mptcp_subflow_connect(struct sock *sk, struct soc=
kaddr *local,
 	subflow->request_join =3D 1;
 	subflow->request_bkup =3D 1;
 =

+	list_add(&subflow->node, &msk->join_list);
+
 	err =3D kernel_connect(sf, remote, addrlen, O_NONBLOCK);
 	if (err && err !=3D -EINPROGRESS)
 		goto failed;
 =

-	sock_put(sf->sk);
+	release_sock(sk);
 	return err;
 =

 failed:
-	sock_put(sf->sk);
+	list_del_init(&subflow->node);
+	release_sock(sk);
 	sock_release(sf);
 	return err;
 }
@@ -782,6 +787,7 @@ static struct mptcp_subflow_context *subflow_create_ctx=
(struct sock *sk,
 	if (!ctx)
 		return NULL;
 	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
+	INIT_LIST_HEAD(&ctx->node);
 =

 	pr_debug("subflow=3D%p", ctx);
 =

-- =

2.23.0

--===============5100403776294750658==--
