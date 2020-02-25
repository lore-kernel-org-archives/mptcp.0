Content-Type: multipart/mixed; boundary="===============8773122021708504661=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 6/7] mptcp: avoid work queue scheduling if
 possible
Date: Tue, 25 Feb 2020 18:16:58 +0100
Message-ID: <20200225171659.4807-7-fw@strlen.de>
In-Reply-To: 20200225171659.4807-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3798

--===============8773122021708504661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We can't lock_sock() the mptcp socket from the subflow data_ready callback,
it would result in ABBA deadlock with the subflow socket lock.

We can however grab the spinlock: if that succeeds and the mptcp socket
is not owned at the moment, we can process the new skbs right away
without deferring this to the work queue.

This avoids the schedule_work and hence the small delay until the
work item is processed.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 29 ++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  |  4 ++--
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b781498e69b4..70f20c8eddbd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -201,12 +201,39 @@ static bool __mptcp_move_skbs_from_subflow(struct mpt=
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
+	if (READ_ONCE(sk->sk_lock.owned))
+		return false;
+
+	if (unlikely(!spin_trylock_bh(&sk->sk_lock.slock)))
+		return false;
+
+	/* must re-check after taking the lock */
+	if (!READ_ONCE(sk->sk_lock.owned))
+		__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
+
+	spin_unlock_bh(&sk->sk_lock.slock);
+
+	return moved > 0;
+}
+
+void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	set_bit(MPTCP_DATA_READY, &msk->flags);
 =

+	if (atomic_read(&sk->sk_rmem_alloc) < READ_ONCE(sk->sk_rcvbuf) &&
+	    move_skbs_to_msk(msk, ssk))
+		goto wake;
+
 	/* don't schedule if mptcp sk is (still) over limit */
 	if (atomic_read(&sk->sk_rmem_alloc) > READ_ONCE(sk->sk_rcvbuf))
 		goto wake;
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

--===============8773122021708504661==--
