Content-Type: multipart/mixed; boundary="===============2049260231372777803=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close"
Date: Thu, 15 Oct 2020 23:28:51 +0200
Message-ID: <fffd74384126974bb9f56303948000f11b0b291f.1602794093.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6321

--===============2049260231372777803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the refactor __mptcp_close_ssk() can be invoked on
orphaned TCP socket, so we can't wait a timeout, or
sk_stream_wait_close() will oops due to NULL waitqueue.

We can simply always use a 0 timeout (and clean-up the
related signature accordingly): the timeout, if any,
is used before by mptcp_close().

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
This should fix issue 100, but I only build test it ;)
---
 net/mptcp/pm_netlink.c |  6 ++----
 net/mptcp/protocol.c   | 19 +++++++++----------
 net/mptcp/protocol.h   |  3 +--
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ed60538df7b2..7599b0f14920 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -417,14 +417,13 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *=
msk)
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
-		long timeout =3D 0;
 =

 		if (msk->pm.rm_id !=3D subflow->remote_id)
 			continue;
 =

 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, how);
-		__mptcp_close_ssk(sk, ssk, subflow, timeout);
+		__mptcp_close_ssk(sk, ssk, subflow);
 		spin_lock_bh(&msk->pm.lock);
 =

 		msk->pm.add_addr_accepted--;
@@ -453,14 +452,13 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_soc=
k *msk, u8 rm_id)
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
-		long timeout =3D 0;
 =

 		if (rm_id !=3D subflow->local_id)
 			continue;
 =

 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, how);
-		__mptcp_close_ssk(sk, ssk, subflow, timeout);
+		__mptcp_close_ssk(sk, ssk, subflow);
 		spin_lock_bh(&msk->pm.lock);
 =

 		msk->pm.local_addr_used--;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0f3dae1dabc9..a6205a940977 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -42,7 +42,7 @@ struct mptcp_skb_cb {
 =

 static struct percpu_counter mptcp_sockets_allocated;
 =

-static void __mptcp_destroy_sock(struct sock *sk, int timeout);
+static void __mptcp_destroy_sock(struct sock *sk);
 =

 /* If msk has an initial subflow socket, and the MP_CAPABLE handshake has =
not
  * completed yet or has failed, return the subflow socket.
@@ -1711,8 +1711,7 @@ static struct sock *mptcp_subflow_get_retrans(const s=
truct mptcp_sock *msk)
  * parent socket.
  */
 void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
-		       struct mptcp_subflow_context *subflow,
-		       long timeout)
+		       struct mptcp_subflow_context *subflow)
 {
 	struct socket *sock =3D READ_ONCE(ssk->sk_socket);
 =

@@ -1733,7 +1732,7 @@ void __mptcp_close_ssk(struct sock *sk, struct sock *=
ssk,
 	} else {
 		/* otherwise ask tcp do dispose of ssk and subflow ctx */
 		subflow->disposable =3D 1;
-		__tcp_close(ssk, timeout);
+		__tcp_close(ssk, 0);
 =

 		/* close acquired an extra ref */
 		__sock_put(ssk);
@@ -1784,7 +1783,7 @@ static void __mptcp_close_subflow(struct mptcp_sock *=
msk)
 		if (inet_sk_state_load(ssk) !=3D TCP_CLOSE)
 			continue;
 =

-		__mptcp_close_ssk((struct sock *)msk, ssk, subflow, 0);
+		__mptcp_close_ssk((struct sock *)msk, ssk, subflow);
 	}
 }
 =

@@ -1850,7 +1849,7 @@ static void mptcp_worker(struct work_struct *work)
 	    (mptcp_check_close_timeout(sk) ||
 	    (state !=3D sk->sk_state && sk->sk_state =3D=3D TCP_CLOSE))) {
 		inet_sk_state_store(sk, TCP_CLOSE);
-		__mptcp_destroy_sock(sk, 0);
+		__mptcp_destroy_sock(sk);
 		goto unlock;
 	}
 =

@@ -2077,13 +2076,13 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 	__mptcp_check_send_data_fin(sk);
 }
 =

-static void __mptcp_destroy_sock(struct sock *sk, int timeout)
+static void __mptcp_destroy_sock(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	LIST_HEAD(conn_list);
 =

-	pr_debug("msk=3D%p timeout=3D%d", msk, timeout);
+	pr_debug("msk=3D%p", msk);
 =

 	/* be sure to always acquire the join list lock, to sync vs
 	 * mptcp_finish_join().
@@ -2099,7 +2098,7 @@ static void __mptcp_destroy_sock(struct sock *sk, int=
 timeout)
 =

 	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		__mptcp_close_ssk(sk, ssk, subflow, timeout);
+		__mptcp_close_ssk(sk, ssk, subflow);
 	}
 =

 	sk->sk_prot->destroy(sk);
@@ -2151,7 +2150,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	sock_hold(sk);
 	pr_debug("msk=3D%p state=3D%d", sk, sk->sk_state);
 	if (sk->sk_state =3D=3D TCP_CLOSE) {
-		__mptcp_destroy_sock(sk, timeout);
+		__mptcp_destroy_sock(sk);
 		do_cancel_work =3D true;
 	} else {
 		sk_reset_timer(sk, &sk->sk_timer, jiffies + TCP_TIMEWAIT_LEN);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 408c212e8e1c..4a434689c63c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -412,8 +412,7 @@ void __init mptcp_subflow_init(void);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
 void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
-		       struct mptcp_subflow_context *subflow,
-		       long timeout);
+		       struct mptcp_subflow_context *subflow);
 =

 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
-- =

2.26.2

--===============2049260231372777803==--
