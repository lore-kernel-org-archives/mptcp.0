Content-Type: multipart/mixed; boundary="===============3965529714964350888=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] mptcp: use mptcp worker for path management
Date: Fri, 19 Jun 2020 13:57:10 +0200
Message-ID: <20200619115710.2571-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4748

--===============3965529714964350888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We can re-use the existing work queue to handle path management
instead of a dedicated work queue.  Just move pm_worker to protocol.c,
call it from the mptcp worker and get rid of the msk lock (already held).

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 As a followup one could probably also merge 'status' and msk->flags,
 might also be able to remove the 'pending' boolean.

 I can have a look next week.

 net/mptcp/pm.c       | 44 +-------------------------------------------
 net/mptcp/protocol.c | 27 ++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  3 ---
 3 files changed, 27 insertions(+), 47 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7de09fdd42a3..a8ad20559aaa 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -10,8 +10,6 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

-static struct workqueue_struct *pm_wq;
-
 /* path manager command handlers */
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -78,7 +76,7 @@ static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
 		return false;
 =

 	msk->pm.status |=3D BIT(new_status);
-	if (queue_work(pm_wq, &msk->pm.work))
+	if (schedule_work(&msk->work))
 		sock_hold((struct sock *)msk);
 	return true;
 }
@@ -181,35 +179,6 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, stru=
ct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, skc);
 }
 =

-static void pm_worker(struct work_struct *work)
-{
-	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
-						work);
-	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
-	struct sock *sk =3D (struct sock *)msk;
-
-	lock_sock(sk);
-	spin_lock_bh(&msk->pm.lock);
-
-	pr_debug("msk=3D%p status=3D%x", msk, pm->status);
-	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
-		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
-		mptcp_pm_nl_add_addr_received(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
-		pm->status &=3D ~BIT(MPTCP_PM_ESTABLISHED);
-		mptcp_pm_nl_fully_established(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
-		pm->status &=3D ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
-		mptcp_pm_nl_subflow_established(msk);
-	}
-
-	spin_unlock_bh(&msk->pm.lock);
-	release_sock(sk);
-	sock_put(sk);
-}
-
 void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
 	msk->pm.add_addr_signaled =3D 0;
@@ -223,22 +192,11 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.status =3D 0;
 =

 	spin_lock_init(&msk->pm.lock);
-	INIT_WORK(&msk->pm.work, pm_worker);
 =

 	mptcp_pm_nl_data_init(msk);
 }
 =

-void mptcp_pm_close(struct mptcp_sock *msk)
-{
-	if (cancel_work_sync(&msk->pm.work))
-		sock_put((struct sock *)msk);
-}
-
 void __init mptcp_pm_init(void)
 {
-	pm_wq =3D alloc_workqueue("pm_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 8);
-	if (!pm_wq)
-		panic("Failed to allocate workqueue");
-
 	mptcp_pm_nl_init();
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index faa804f63c81..a349d8f06f20 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1237,6 +1237,29 @@ static unsigned int mptcp_sync_mss(struct sock *sk, =
u32 pmtu)
 	return 0;
 }
 =

+static void pm_work(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
+	spin_lock_bh(&msk->pm.lock);
+
+	pr_debug("msk=3D%p status=3D%x", msk, pm->status);
+	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
+		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
+		mptcp_pm_nl_add_addr_received(msk);
+	}
+	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
+		pm->status &=3D ~BIT(MPTCP_PM_ESTABLISHED);
+		mptcp_pm_nl_fully_established(msk);
+	}
+	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
+		pm->status &=3D ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
+		mptcp_pm_nl_subflow_established(msk);
+	}
+
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
@@ -1253,6 +1276,9 @@ static void mptcp_worker(struct work_struct *work)
 	__mptcp_flush_join_list(msk);
 	__mptcp_move_skbs(msk);
 =

+	if (msk->pm.status)
+		pm_work(msk);
+
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 =

@@ -1444,7 +1470,6 @@ static void mptcp_close(struct sock *sk, long timeout)
 	}
 =

 	mptcp_cancel_work(sk);
-	mptcp_pm_close(msk);
 =

 	__skb_queue_purge(&sk->sk_receive_queue);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2c3deede2469..6d3fff97e3c6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -174,8 +174,6 @@ struct mptcp_pm_data {
 	u8		local_addr_max;
 	u8		subflows_max;
 	u8		status;
-
-	struct		work_struct work;
 };
 =

 struct mptcp_data_frag {
@@ -417,7 +415,6 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg,=
 int len, void *hmac);
 =

 void __init mptcp_pm_init(void);
 void mptcp_pm_data_init(struct mptcp_sock *msk);
-void mptcp_pm_close(struct mptcp_sock *msk);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk);
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
-- =

2.26.2

--===============3965529714964350888==--
