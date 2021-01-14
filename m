Content-Type: multipart/mixed; boundary="===============1655998563712284576=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 2/7] mptcp: move pm netlink work into pm_netlink
Date: Thu, 14 Jan 2021 18:36:49 +0100
Message-ID: <20210114173654.7618-3-fw@strlen.de>
In-Reply-To: 20210114173654.7618-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7383

--===============1655998563712284576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

allows to make some functions static and avoids aquire of the pm spinlock
in protocol.c.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/pm_netlink.c | 45 +++++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.c   | 33 +------------------------------
 net/mptcp/protocol.h   |  6 +-----
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fabe431f256e..214b429bf3b8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -55,6 +55,8 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 =

+static void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk);
+
 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    struct mptcp_addr_info *b, bool use_port)
 {
@@ -369,17 +371,17 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
 	}
 }
 =

-void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
+static void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
 {
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 =

-void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
+static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
 {
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 =

-void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
+static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_addr_info remote;
@@ -414,7 +416,7 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	mptcp_pm_nl_add_addr_send_ack(msk);
 }
 =

-void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk)
+static void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 =

@@ -486,7 +488,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 =

-void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
+static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
@@ -523,6 +525,39 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *m=
sk)
 	}
 }
 =

+void mptcp_pm_nl_work(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
+	msk_owned_by_me(msk);
+
+	spin_lock_bh(&msk->pm.lock);
+
+	pr_debug("msk=3D%p status=3D%x", msk, pm->status);
+	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
+		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
+		mptcp_pm_nl_add_addr_received(msk);
+	}
+	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
+		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
+		mptcp_pm_nl_add_addr_send_ack(msk);
+	}
+	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
+		pm->status &=3D ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
+		mptcp_pm_nl_rm_addr_received(msk);
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
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 61d138a571b0..b1e152196057 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2135,37 +2135,6 @@ static unsigned int mptcp_sync_mss(struct sock *sk, =
u32 pmtu)
 	return 0;
 }
 =

-static void pm_work(struct mptcp_sock *msk)
-{
-	struct mptcp_pm_data *pm =3D &msk->pm;
-
-	spin_lock_bh(&msk->pm.lock);
-
-	pr_debug("msk=3D%p status=3D%x", msk, pm->status);
-	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
-		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
-		mptcp_pm_nl_add_addr_received(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
-		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
-		mptcp_pm_nl_add_addr_send_ack(msk);
-	}
-	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
-		pm->status &=3D ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
-		mptcp_pm_nl_rm_addr_received(msk);
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
-}
-
 static void __mptcp_close_subflow(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -2255,7 +2224,7 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_close_subflow(msk);
 =

 	if (msk->pm.status)
-		pm_work(msk);
+		mptcp_pm_nl_work(msk);
 =

 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dfd96b790f43..914722b646b3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -644,13 +644,9 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, stru=
ct sock_common *skc);
 =

 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
-void mptcp_pm_nl_fully_established(struct mptcp_sock *msk);
-void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk);
-void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk);
-void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk);
-void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
+void mptcp_pm_nl_work(struct mptcp_sock *msk);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
-- =

2.26.2

--===============1655998563712284576==--
