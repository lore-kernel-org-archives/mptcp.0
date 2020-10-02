Content-Type: multipart/mixed; boundary="===============1099771058597925146=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 08/13] mptcp: refactor shutdown and close
Date: Fri, 02 Oct 2020 11:26:18 +0200
Message-ID: <1c9bb82bf7a032b0cfbec054e5160bcf6f01b513.1601630384.git.pabeni@redhat.com>
In-Reply-To: cover.1601630384.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6158

--===============1099771058597925146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We must not close the subflows before all the MPTCP level
data, comprising the DATA_FIN has been acked at the MPTCP
level, otherwise we could be unable to retransmit as needed.

__mptcp_wr_shutdown() shutdown is responsible to check for the
correct status and close all subflows. Is called by the output
path after spooling any data and at shutdown/close time.

In a similar way, __mptcp_destroy_sock() is responsible to clean-up
the MPTCP level status, and is called when the msk transition
to TCP_CLOSE.

The protocol level close() does not force anymore the TCP_CLOSE
status, but orphan the msk socket and all the subflows.
Orphaned msk sockets are forciby closed after a timeout or
when all MPTCP-level data is acked.

There is a caveat about keeping the orphaned subflows around:
the TCP stack can asynchronusly call tcp_cleanup_ulp() on them via
tcp_close(). To prevent accessing freed memory on later MPTCP
level operations, the msk acquires a reference to each subflow
socket and prevent subflow_ulp_release() from releasing the
subflow context before __mptcp_destroy_sock().

The additional subflow references are released by __mptcp_done()
and the async ULP release is detected checking ULP ops. If such
field has been already cleared by the ULP release path, the
dangling context is freed directly by __mptcp_done().

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - drop legacy comment
 - fix oops ->ops typo
 - fix deadlock on shutdown: we can't call mptcp_cancel_work() with
   the socket lock held, and we don't need to call it when
   __mptcp_destroy_sock() is invoked from the workqueue

RFC -> v1:
 - drop TCP_TIME_WAIT status, we can't use it or will foul sk_fullsock()
 - refactor wr_shutdown, now split in 2 parts. DATA_FIN is sent
   by __mptcp_check_send_data_fin() when snd_nxt + 1 =3D=3D write_seq
 - drop mptcp_wr_eof(), simply check for TCP_CLOSE state - Mat
 - do send data fin ack in TCP_FIN_WAIT2 state  (return; -> break; in
   switch statement)
---
 net/mptcp/options.c  |   2 +-
 net/mptcp/protocol.c | 269 ++++++++++++++++++++++++++++++-------------
 net/mptcp/protocol.h |  10 +-
 net/mptcp/subflow.c  |  21 +++-
 4 files changed, 216 insertions(+), 86 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3a4d12935b82..b992d8d45c52 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -491,7 +491,7 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 	bool ret =3D false;
 =

 	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
-	snd_data_fin_enable =3D READ_ONCE(msk->snd_data_fin_enable);
+	snd_data_fin_enable =3D mptcp_data_fin_enabled(msk);
 =

 	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
 		unsigned int map_size;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e9d9b5c0de1c..91cc090855e7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -21,6 +21,7 @@
 #include <net/transp_v6.h>
 #endif
 #include <net/mptcp.h>
+#include <net/xfrm.h>
 #include "protocol.h"
 #include "mib.h"
 =

@@ -41,6 +42,8 @@ struct mptcp_skb_cb {
 =

 static struct percpu_counter mptcp_sockets_allocated;
 =

+static void __mptcp_destroy_sock(struct sock *sk, int timeout);
+
 /* If msk has an initial subflow socket, and the MP_CAPABLE handshake has =
not
  * completed yet or has failed, return the subflow socket.
  * Otherwise return NULL.
@@ -102,6 +105,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	msk->subflow =3D ssock;
 	subflow =3D mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
+	sock_hold(ssock->sk);
 	subflow->request_mptcp =3D 1;
 =

 	/* accept() will wait on first subflow sk_wq, and we always wakes up
@@ -331,15 +335,20 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 		switch (sk->sk_state) {
 		case TCP_FIN_WAIT1:
 			inet_sk_state_store(sk, TCP_FIN_WAIT2);
-			sk->sk_state_change(sk);
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
 			inet_sk_state_store(sk, TCP_CLOSE);
-			sk->sk_state_change(sk);
 			break;
 		}
 =

+		/* if the socket is detached from user-space there is no point
+		 * in keeping it around after spooling all the data
+		 */
+		if (sock_flag(sk, SOCK_DEAD))
+			return;
+
+		sk->sk_state_change(sk);
 		if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
 		    sk->sk_state =3D=3D TCP_CLOSE)
 			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
@@ -418,7 +427,6 @@ static void mptcp_check_data_fin(struct sock *sk)
 			break;
 		case TCP_FIN_WAIT2:
 			inet_sk_state_store(sk, TCP_CLOSE);
-			// @@ Close subflows now?
 			break;
 		default:
 			/* Other states not expected */
@@ -435,8 +443,10 @@ static void mptcp_check_data_fin(struct sock *sk)
 			release_sock(ssk);
 		}
 =

-		sk->sk_state_change(sk);
+		if (sock_flag(sk, SOCK_DEAD))
+			return;
 =

+		sk->sk_state_change(sk);
 		if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
 		    sk->sk_state =3D=3D TCP_CLOSE)
 			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
@@ -674,6 +684,10 @@ static void mptcp_reset_timer(struct sock *sk)
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
 	unsigned long tout;
 =

+	/* prevent rescheduling on close */
+	if (unlikely(inet_sk_state_load(sk) =3D=3D TCP_CLOSE))
+		return;
+
 	/* should never be called with mptcp level timer cleared */
 	tout =3D READ_ONCE(mptcp_sk(sk)->timer_ival);
 	if (WARN_ON_ONCE(!tout))
@@ -1699,13 +1713,28 @@ void __mptcp_close_ssk(struct sock *sk, struct sock=
 *ssk,
 =

 	list_del(&subflow->node);
 =

-	if (sock && sock !=3D sk->sk_socket) {
-		/* outgoing subflow */
-		sock_release(sock);
+	/* outgoing subflow */
+	if (sock && sock !=3D sk->sk_socket)
+		iput(SOCK_INODE(sock));
+
+	lock_sock(ssk);
+
+	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
+	 * the ssk has been already destroyed, we just need to release the
+	 * reference owned by msk;
+	 */
+	if (!inet_csk(ssk)->icsk_ulp_ops) {
+		kfree_rcu(subflow, rcu);
 	} else {
-		/* incoming subflow */
-		tcp_close(ssk, timeout);
+		/* otherwise ask tcp do dispose of ssk and subflow ctx */
+		subflow->disposable =3D 1;
+		__tcp_close(ssk, timeout);
+
+		/* close acquired an extra ref */
+		__sock_put(ssk);
 	}
+	release_sock(ssk);
+	sock_put(ssk);
 }
 =

 static unsigned int mptcp_sync_mss(struct sock *sk, u32 pmtu)
@@ -1740,6 +1769,25 @@ static void pm_work(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 =

+static bool mptcp_check_close_timeout(const struct sock *sk)
+{
+	s32 delta =3D tcp_jiffies32 - inet_csk(sk)->icsk_mtup.probe_timestamp;
+	struct mptcp_subflow_context *subflow;
+
+	if (delta > TCP_TIMEWAIT_LEN)
+		return true;
+
+	/* if all subflows are in closed status don't bother with additional
+	 * timeout
+	 */
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		if (inet_sk_state_load(mptcp_subflow_tcp_sock(subflow)) !=3D
+		    TCP_CLOSE)
+			return false;
+	}
+	return true;
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
@@ -1752,9 +1800,14 @@ static void mptcp_worker(struct work_struct *work)
 	struct msghdr msg =3D {
 		.msg_flags =3D MSG_DONTWAIT,
 	};
-	int ret;
+	int state, ret;
 =

 	lock_sock(sk);
+	set_bit(MPTCP_WORKER_RUNNING, &msk->flags);
+	state =3D sk->sk_state;
+	if (unlikely(state =3D=3D TCP_CLOSE))
+		goto unlock;
+
 	mptcp_clean_una_wakeup(sk);
 	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
@@ -1768,6 +1821,17 @@ static void mptcp_worker(struct work_struct *work)
 =

 	mptcp_check_data_fin(sk);
 =

+	/* if the msk data is completely acked, or the socket timedout,
+	 * there is no point in keeping around an orphaned sk
+	 */
+	if (sock_flag(sk, SOCK_DEAD) &&
+	    (mptcp_check_close_timeout(sk) ||
+	    (state !=3D sk->sk_state && sk->sk_state =3D=3D TCP_CLOSE))) {
+		inet_sk_state_store(sk, TCP_CLOSE);
+		__mptcp_destroy_sock(sk, 0);
+		goto unlock;
+	}
+
 	if (!test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
 		goto unlock;
 =

@@ -1816,6 +1880,7 @@ static void mptcp_worker(struct work_struct *work)
 		mptcp_reset_timer(sk);
 =

 unlock:
+	clear_bit(MPTCP_WORKER_RUNNING, &msk->flags);
 	release_sock(sk);
 	sock_put(sk);
 }
@@ -1889,8 +1954,12 @@ static void mptcp_cancel_work(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (cancel_work_sync(&msk->work))
-		sock_put(sk);
+	/* if called by the work itself, do not try to cancel the work, or
+	 * we will hang.
+	 */
+	if (!test_bit(MPTCP_WORKER_RUNNING, &msk->flags) &&
+	    cancel_work_sync(&msk->work))
+		__sock_put(sk);
 }
 =

 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
@@ -1948,42 +2017,55 @@ static int mptcp_close_state(struct sock *sk)
 	return next & TCP_ACTION_FIN;
 }
 =

-static void mptcp_close(struct sock *sk, long timeout)
+static void __mptcp_check_send_data_fin(struct sock *sk)
 {
-	struct mptcp_subflow_context *subflow, *tmp;
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	LIST_HEAD(conn_list);
 =

-	lock_sock(sk);
-	sk->sk_shutdown =3D SHUTDOWN_MASK;
+	pr_debug("msk=3D%p snd_data_fin_enable=3D%d pending=3D%d snd_nxt=3D%lld w=
rite_seq=3D%llx",
+		 msk, msk->snd_data_fin_enable, !!mptcp_send_head(sk),
+		 msk->snd_nxt, msk->write_seq);
 =

-	if (sk->sk_state =3D=3D TCP_LISTEN) {
-		inet_sk_state_store(sk, TCP_CLOSE);
-		goto cleanup;
-	} else if (sk->sk_state =3D=3D TCP_CLOSE) {
-		goto cleanup;
-	}
+	/* we still need to enqueue subflows or not really shutting down,
+	 * skip this
+	 */
+	if (!msk->snd_data_fin_enable || msk->snd_nxt + 1 !=3D msk->write_seq ||
+	    mptcp_send_head(sk))
+		return;
 =

-	if (__mptcp_check_fallback(msk)) {
-		goto update_state;
-	} else if (mptcp_close_state(sk)) {
-		pr_debug("Sending DATA_FIN sk=3D%p", sk);
-		WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
-		WRITE_ONCE(msk->snd_data_fin_enable, 1);
+	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 =

-		mptcp_for_each_subflow(msk, subflow) {
-			struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
+	__mptcp_flush_join_list(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
 =

-			mptcp_subflow_shutdown(sk, tcp_sk, SHUTDOWN_MASK);
-		}
+		mptcp_subflow_shutdown(sk, tcp_sk, SEND_SHUTDOWN);
 	}
+}
 =

-	sk_stream_wait_close(sk, timeout);
+static void __mptcp_wr_shutdown(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-update_state:
-	inet_sk_state_store(sk, TCP_CLOSE);
+	pr_debug("msk=3D%p snd_data_fin_enable=3D%d shutdown=3D%x state=3D%d pend=
ing=3D%d",
+		 msk, msk->snd_data_fin_enable, sk->sk_shutdown, sk->sk_state,
+		 !!mptcp_send_head(sk));
+
+	/* will be ignored by fallback sockets */
+	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
+	WRITE_ONCE(msk->snd_data_fin_enable, 1);
+
+	__mptcp_check_send_data_fin(sk);
+}
+
+static void __mptcp_destroy_sock(struct sock *sk, int timeout)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	LIST_HEAD(conn_list);
+
+	pr_debug("msk=3D%p timeout=3D%d", msk, timeout);
 =

-cleanup:
 	/* be sure to always acquire the join list lock, to sync vs
 	 * mptcp_finish_join().
 	 */
@@ -1993,19 +2075,68 @@ static void mptcp_close(struct sock *sk, long timeo=
ut)
 	list_splice_init(&msk->conn_list, &conn_list);
 =

 	__mptcp_clear_xmit(sk);
-
-	release_sock(sk);
+	msk->pm.status =3D 0;
 =

 	list_for_each_entry_safe(subflow, tmp, &conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 		__mptcp_close_ssk(sk, ssk, subflow, timeout);
 	}
 =

-	mptcp_cancel_work(sk);
+	sk->sk_prot->destroy(sk);
 =

-	__skb_queue_purge(&sk->sk_receive_queue);
+	sk_stream_kill_queues(sk);
+	xfrm_sk_free_policy(sk);
+	sk_refcnt_debug_release(sk);
+	sock_put(sk);
+}
+
+static void mptcp_close(struct sock *sk, long timeout)
+{
+	struct mptcp_subflow_context *subflow;
+	bool do_cancel_work =3D false;
+
+	lock_sock(sk);
+	sk->sk_shutdown =3D SHUTDOWN_MASK;
+
+	if (sk->sk_state =3D=3D TCP_LISTEN) {
+		inet_sk_state_store(sk, TCP_CLOSE);
+		goto cleanup;
+	} else if (sk->sk_state =3D=3D TCP_CLOSE) {
+		goto cleanup;
+	}
+
+	if (mptcp_close_state(sk))
+		__mptcp_wr_shutdown(sk);
+
+	sk_stream_wait_close(sk, timeout);
 =

-	sk_common_release(sk);
+cleanup:
+	/* orphan all the subflows */
+	inet_csk(sk)->icsk_mtup.probe_timestamp =3D tcp_jiffies32;
+	list_for_each_entry(subflow, &mptcp_sk(sk)->conn_list, node) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		struct socket *sock =3D READ_ONCE(ssk->sk_socket);
+		bool slow;
+
+		if (sock && sock !=3D sk->sk_socket)
+			iput(SOCK_INODE(sock));
+
+		slow =3D lock_sock_fast(ssk);
+		sock_orphan(ssk);
+		unlock_sock_fast(ssk, slow);
+	}
+	sock_orphan(sk);
+
+	sock_hold(sk);
+	pr_debug("msk=3D%p state=3D%d", sk, sk->sk_state);
+	if (sk->sk_state =3D=3D TCP_CLOSE) {
+		__mptcp_destroy_sock(sk, timeout);
+		do_cancel_work =3D true;
+	}
+	release_sock(sk);
+	if (do_cancel_work)
+		mptcp_cancel_work(sk);
+	sock_put(sk);
 }
 =

 static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
@@ -2160,6 +2291,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		newsk =3D new_mptcp_sock;
 		mptcp_copy_inaddrs(newsk, ssk);
 		list_add(&subflow->node, &msk->conn_list);
+		sock_hold(ssk);
 =

 		mptcp_rcv_space_init(msk, ssk);
 		bh_unlock_sock(new_mptcp_sock);
@@ -2407,9 +2539,9 @@ static void mptcp_sock_graft(struct sock *sk, struct =
socket *parent)
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 =

-bool mptcp_finish_join(struct sock *sk)
+bool mptcp_finish_join(struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct sock *parent =3D (void *)msk;
 	struct socket *parent_sock;
@@ -2430,12 +2562,14 @@ bool mptcp_finish_join(struct sock *sk)
 	/* active connections are already on conn_list, and we can't acquire
 	 * msk lock here.
 	 * use the join list lock as synchronization point and double-check
-	 * msk status to avoid racing with mptcp_close()
+	 * msk status to avoid racing with __mptcp_destroy_sock()
 	 */
 	spin_lock_bh(&msk->join_list_lock);
 	ret =3D inet_sk_state_load(parent) =3D=3D TCP_ESTABLISHED;
-	if (ret && !WARN_ON_ONCE(!list_empty(&subflow->node)))
+	if (ret && !WARN_ON_ONCE(!list_empty(&subflow->node))) {
 		list_add_tail(&subflow->node, &msk->join_list);
+		sock_hold(ssk);
+	}
 	spin_unlock_bh(&msk->join_list_lock);
 	if (!ret)
 		return false;
@@ -2444,8 +2578,8 @@ bool mptcp_finish_join(struct sock *sk)
 	 * at close time
 	 */
 	parent_sock =3D READ_ONCE(parent->sk_socket);
-	if (parent_sock && !sk->sk_socket)
-		mptcp_sock_graft(sk, parent_sock);
+	if (parent_sock && !ssk->sk_socket)
+		mptcp_sock_graft(ssk, parent_sock);
 	subflow->map_seq =3D READ_ONCE(msk->ack_seq);
 	return true;
 }
@@ -2680,12 +2814,12 @@ static __poll_t mptcp_poll(struct file *file, struc=
t socket *sock,
 static int mptcp_shutdown(struct socket *sock, int how)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
-	struct mptcp_subflow_context *subflow;
+	struct sock *sk =3D sock->sk;
 	int ret =3D 0;
 =

 	pr_debug("sk=3D%p, how=3D%d", msk, how);
 =

-	lock_sock(sock->sk);
+	lock_sock(sk);
 =

 	how++;
 	if ((how & ~SHUTDOWN_MASK) || !how) {
@@ -2694,45 +2828,22 @@ static int mptcp_shutdown(struct socket *sock, int =
how)
 	}
 =

 	if (sock->state =3D=3D SS_CONNECTING) {
-		if ((1 << sock->sk->sk_state) &
+		if ((1 << sk->sk_state) &
 		    (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_CLOSE))
 			sock->state =3D SS_DISCONNECTING;
 		else
 			sock->state =3D SS_CONNECTED;
 	}
 =

-	/* If we've already sent a FIN, or it's a closed state, skip this. */
-	if (__mptcp_check_fallback(msk)) {
-		if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
-			inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
-
-		mptcp_for_each_subflow(msk, subflow) {
-			struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
-
-			mptcp_subflow_shutdown(sock->sk, tcp_sk, how);
-		}
-	} else if ((how & SEND_SHUTDOWN) &&
-		   ((1 << sock->sk->sk_state) &
-		    (TCPF_ESTABLISHED | TCPF_SYN_SENT |
-		     TCPF_SYN_RECV | TCPF_CLOSE_WAIT)) &&
-		   mptcp_close_state(sock->sk)) {
-		__mptcp_flush_join_list(msk);
-
-		WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
-		WRITE_ONCE(msk->snd_data_fin_enable, 1);
-
-		mptcp_for_each_subflow(msk, subflow) {
-			struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
-
-			mptcp_subflow_shutdown(sock->sk, tcp_sk, how);
-		}
-	}
+	sk->sk_shutdown |=3D how;
+	if ((how & SEND_SHUTDOWN) && mptcp_close_state(sk))
+		__mptcp_wr_shutdown(sk);
 =

 	/* Wake up anyone sleeping in poll. */
-	sock->sk->sk_state_change(sock->sk);
+	sk->sk_state_change(sk);
 =

 out_unlock:
-	release_sock(sock->sk);
+	release_sock(sk);
 =

 	return ret;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f7ffed685640..bdcb46d1adae 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -90,6 +90,7 @@
 #define MPTCP_WORK_RTX		2
 #define MPTCP_WORK_EOF		3
 #define MPTCP_FALLBACK_DONE	4
+#define MPTCP_WORKER_RUNNING	5
 =

 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -351,7 +352,8 @@ struct mptcp_subflow_context {
 		backup : 1,
 		rx_eof : 1,
 		use_64bit_ack : 1, /* Set when we received a 64-bit DSN */
-		can_ack : 1;	    /* only after processing the remote a key */
+		can_ack : 1,        /* only after processing the remote a key */
+		disposable : 1;	    /* ctx can be free at ulp release time */
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
@@ -449,6 +451,12 @@ bool mptcp_schedule_work(struct sock *sk);
 void mptcp_data_acked(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, b=
ool use_64bit);
+static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->snd_data_fin_enable) &&
+	       READ_ONCE(msk->write_seq) =3D=3D READ_ONCE(msk->snd_nxt);
+}
+
 void mptcp_destroy_common(struct mptcp_sock *msk);
 =

 void __init mptcp_token_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d04a9bb9448f..dff4ae087233 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1114,6 +1114,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	if (err && err !=3D -EINPROGRESS)
 		goto failed;
 =

+	sock_hold(ssk);
 	spin_lock_bh(&msk->join_list_lock);
 	list_add_tail(&subflow->node, &msk->join_list);
 	spin_unlock_bh(&msk->join_list_lock);
@@ -1121,6 +1122,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	return err;
 =

 failed:
+	subflow->disposable =3D 1;
 	sock_release(sf);
 	return err;
 }
@@ -1313,17 +1315,26 @@ static int subflow_ulp_init(struct sock *sk)
 	return err;
 }
 =

-static void subflow_ulp_release(struct sock *sk)
+static void subflow_ulp_release(struct sock *ssk)
 {
-	struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(sk);
+	struct mptcp_subflow_context *ctx =3D mptcp_subflow_ctx(ssk);
+	bool release =3D true;
+	struct sock *sk;
 =

 	if (!ctx)
 		return;
 =

-	if (ctx->conn)
-		sock_put(ctx->conn);
+	sk =3D ctx->conn;
+	if (sk) {
+		/* if the msk has been orphaned, keep the ctx
+		 * alive, will be freed by mptcp_done()
+		 */
+		release =3D ctx->disposable;
+		sock_put(sk);
+	}
 =

-	kfree_rcu(ctx, rcu);
+	if (release)
+		kfree_rcu(ctx, rcu);
 }
 =

 static void subflow_ulp_clone(const struct request_sock *req,
-- =

2.26.2

--===============1099771058597925146==--
