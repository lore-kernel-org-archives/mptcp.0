Content-Type: multipart/mixed; boundary="===============5576066510463191551=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 6/8] mptcp: avoid work queue scheduling if
 possible
Date: Tue, 25 Feb 2020 13:05:24 +0100
Message-ID: <20200225120526.2866-7-fw@strlen.de>
In-Reply-To: 20200225120526.2866-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3776

--===============5576066510463191551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We can't grab the mptcp socket lock from the subflow data_ready
callback, it would result in ABBA deadlock.

But we can try to grab the mptcp lock.
If we can't, we can defer to work queue.
If the lock succeeds however we can avoid the schedule_work()
call and move all in-sequence skbs to the mptcp receive queue.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 30 +++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  4 ++--
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c96489c5c875..c28c5cc49d65 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -201,17 +201,45 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
cp_sock *msk,
 	return done;
 }
 =

-void mptcp_data_ready(struct sock *sk)
+/* In most cases we will be able to lock the mptcp socket.  If its already
+ * owned, we need to defer to the work queue to avoid ABBA deadlock.
+ */
+static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct sock *sk =3D (struct sock *)msk;
+	unsigned int moved =3D 0;
+
+	if (sock_owned_by_user_nocheck(sk))
+		return false;
+
+	if (unlikely(!spin_trylock_bh(&sk->sk_lock.slock)))
+		return false;
+
+	/* must re-check after taking the lock */
+	if (!sock_owned_by_user_nocheck(sk))
+		__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+
+	spin_unlock_bh(&sk->sk_lock.slock);
+
+	return skb_queue_empty(&ssk->sk_receive_queue);
+}
+
+void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	set_bit(MPTCP_DATA_READY, &msk->flags);
 	sk->sk_data_ready(sk);
 =

+	if (atomic_read(&sk->sk_rmem_alloc) < READ_ONCE(sk->sk_rcvbuf) &&
+	    move_skbs_to_msk(msk, ssk))
+		return;
+
 	/* don't schedule if mptcp sk is (still) over limit */
 	if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf))
 		return;
 =

+	/* mptcp socket is busy, schedule worker */
 	if (schedule_work(&msk->work))
 		sock_hold((struct sock *)msk);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d06170c5f191..6c0b2c8ab674 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -195,7 +195,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

 void mptcp_finish_connect(struct sock *sk);
-void mptcp_data_ready(struct sock *sk);
+void mptcp_data_ready(struct sock *sk, struct sock *ssk);
 =

 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 37a4767db441..0de2a44bdaa0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -563,7 +563,7 @@ static void subflow_data_ready(struct sock *sk)
 	}
 =

 	if (mptcp_subflow_data_available(sk))
-		mptcp_data_ready(parent);
+		mptcp_data_ready(parent, sk);
 }
 =

 static void subflow_write_space(struct sock *sk)
@@ -696,7 +696,7 @@ static void subflow_state_change(struct sock *sk)
 	 * the data available machinery here.
 	 */
 	if (parent && subflow->mp_capable && mptcp_subflow_data_available(sk))
-		mptcp_data_ready(parent);
+		mptcp_data_ready(parent, sk);
 =

 	if (parent && !(parent->sk_shutdown & RCV_SHUTDOWN) &&
 	    !subflow->rx_eof && subflow_is_done(sk)) {
-- =

2.24.1

--===============5576066510463191551==--
