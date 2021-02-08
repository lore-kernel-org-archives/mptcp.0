Content-Type: multipart/mixed; boundary="===============7780126207923890797=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 1/4] mptcp: move to next addr
 when subflow creation fail
Date: Mon, 08 Feb 2021 22:44:09 +0800
Message-ID: <a4390f6a44a2f1df91f3fcdfae166ec8a71acd05.1612795124.git.geliangtang@gmail.com>
In-Reply-To: cover.1612795124.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7669

--===============7780126207923890797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When an invalid address was announced, the subflow couldn't be created
for this address. Therefore mptcp_pm_nl_subflow_established couldn't be
invoked. Then the next addresses in the local address list didn't have a
chance to be announced.

This patch invokes the new function mptcp_pm_add_addr_echoed when the
address is echoed. In it, use lookup_subflow_by_saddr to check whether
this address is in the conn_list. If it isn't, PM schedule the new
status MPTCP_PM_NEXT_ADDR to invoke mptcp_pm_nl_next_addr.

In mptcp_pm_nl_next_addr, invoke mptcp_pm_create_subflow_or_signal_addr
to deal with the next address in the local address list.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    |  1 +
 net/mptcp/pm.c         | 15 +++++++++++++++
 net/mptcp/pm_netlink.c | 13 +++++++++++--
 net/mptcp/protocol.h   |  4 ++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bb874c5d663a..1c5c99c06951 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1022,6 +1022,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 			mptcp_pm_add_addr_received(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 		} else {
+			mptcp_pm_add_addr_echoed(msk, &addr);
 			mptcp_pm_del_add_timer(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6fd4b2c1b076..a6d068d801d0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -197,6 +197,21 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 =

+void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk, struct mptcp_addr_in=
fo *addr)
+{
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
+	pr_debug("msk=3D%p", msk);
+
+	spin_lock_bh(&pm->lock);
+
+	__mptcp_flush_join_list(msk);
+	if (!lookup_subflow_by_saddr(&msk->conn_list, addr))
+		mptcp_pm_schedule_work(msk, MPTCP_PM_NEXT_ADDR);
+
+	spin_unlock_bh(&pm->lock);
+}
+
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 {
 	if (!mptcp_pm_should_add_signal(msk))
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8e8e35fa4002..d9eaee2037bd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -122,8 +122,8 @@ static void remote_address(const struct sock_common *sk=
c,
 #endif
 }
 =

-static bool lookup_subflow_by_saddr(const struct list_head *list,
-				    struct mptcp_addr_info *saddr)
+bool lookup_subflow_by_saddr(const struct list_head *list,
+			     struct mptcp_addr_info *saddr)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
@@ -608,6 +608,11 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp_=
sock *msk)
 	}
 }
 =

+static void mptcp_pm_nl_next_addr(struct mptcp_sock *msk)
+{
+	mptcp_pm_create_subflow_or_signal_addr(msk);
+}
+
 void mptcp_pm_nl_work(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
@@ -629,6 +634,10 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 		pm->status &=3D ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_nl_rm_addr_received(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_NEXT_ADDR)) {
+		pm->status &=3D ~BIT(MPTCP_PM_NEXT_ADDR);
+		mptcp_pm_nl_next_addr(msk);
+	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &=3D ~BIT(MPTCP_PM_ESTABLISHED);
 		mptcp_pm_nl_fully_established(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index de488c3a286e..7ad0dfef36bd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -176,6 +176,7 @@ enum mptcp_pm_status {
 	MPTCP_PM_ADD_ADDR_RECEIVED,
 	MPTCP_PM_ADD_ADDR_SEND_ACK,
 	MPTCP_PM_RM_ADDR_RECEIVED,
+	MPTCP_PM_NEXT_ADDR,
 	MPTCP_PM_ESTABLISHED,
 	MPTCP_PM_ALREADY_ESTABLISHED,	/* persistent status, set after ESTABLISHED=
 event */
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
@@ -659,6 +660,9 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup=
);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
+void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk, struct mptcp_addr_in=
fo *addr);
+bool lookup_subflow_by_saddr(const struct list_head *list,
+			     struct mptcp_addr_info *saddr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock=
 *sk);
 struct mptcp_pm_add_entry *
-- =

2.29.2

--===============7780126207923890797==--
