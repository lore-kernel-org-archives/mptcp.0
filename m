Content-Type: multipart/mixed; boundary="===============4643129673096253476=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next] Squash to "mptcp: send out
 dedicated ADD_ADDR packet"
Date: Wed, 28 Oct 2020 11:20:21 +0800
Message-ID: <62f113f3c6280a654a89f14f78f64390db4d4da3.1603854745.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6454

--===============4643129673096253476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the function name of sending ack is changed in this patch,
please update the following lines in the commit message:

From

"""
mptcp_pm_check_send_dedicated_add_addr_packet to sent out a new pure
ACK packet.
"""

to

"""
mptcp_pm_nl_add_addr_send_ack to sent out a new pure ACK packet.
"""

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/102
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
v3:
 - add a new function mptcp_pm_add_addr_send_ack to schedule pm_work.
 - rename mptcp_pm_check_send_dedicated_add_addr_packet to
   mptcp_pm_nl_add_addr_send_ack.
 - In mptcp_pm_add_addr_received and mptcp_pm_add_timer, we call
  mptcp_pm_add_addr_send_ack to schedule pm_work.
 - In mptcp_pm_nl_add_addr_received and mptcp_pm_create_subflow_or_signal_a=
ddr,
  we call mptcp_pm_nl_add_addr_send_ack directly.

 v2:
 - Add a new command PTCP_PM_ADD_ADDR_SEND_ACK.
 - call mptcp_pm_nl_send_dedicated_add_addr_packet from pm_work.
---
 net/mptcp/options.c    |  2 +-
 net/mptcp/pm.c         | 10 +++++++-
 net/mptcp/pm_netlink.c | 56 ++++++++++++++++++++++--------------------
 net/mptcp/protocol.c   |  4 +++
 net/mptcp/protocol.h   |  9 ++++++-
 5 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4e02c259134f..248e3930c0cb 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -588,7 +588,7 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	bool echo;
 	int len;
 =

-	if (READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6) &&
+	if (mptcp_pm_should_add_signal_ipv6(msk) &&
 	    skb && skb_is_tcp_pure_ack(skb)) {
 		pr_debug("drop other suboptions");
 		opts->suboptions =3D 0;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4341e140f1ff..83f59a428560 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -157,7 +157,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 =

 	if (!READ_ONCE(pm->accept_addr)) {
 		mptcp_pm_announce_addr(msk, addr, true);
-		mptcp_pm_check_send_dedicated_add_addr_packet(msk);
+		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote =3D *addr;
 	}
@@ -165,6 +165,14 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 =

+void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
+{
+	if (!mptcp_pm_should_add_signal_ipv6(msk))
+		return;
+
+	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
+}
+
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
 {
 	struct mptcp_pm_data *pm =3D &msk->pm;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index da545f11745c..6180a8b39a3f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -229,7 +229,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!mptcp_pm_should_add_signal(msk)) {
 		pr_debug("retransmit ADD_ADDR id=3D%d", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
-		mptcp_pm_check_send_dedicated_add_addr_packet(msk);
+		mptcp_pm_add_addr_send_ack(msk);
 		entry->retrans_times++;
 	}
 =

@@ -307,30 +307,6 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 =

-void mptcp_pm_check_send_dedicated_add_addr_packet(struct mptcp_sock *msk)
-{
-	struct mptcp_subflow_context *subflow;
-
-	if (!(READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6)))
-		return;
-
-	__mptcp_flush_join_list(msk);
-	subflow =3D list_first_entry_or_null(&msk->conn_list, typeof(*subflow), n=
ode);
-	if (subflow) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		u8 add_addr;
-
-		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for add_addr6");
-		tcp_send_ack(ssk);
-		spin_lock_bh(&msk->pm.lock);
-
-		add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
-		add_addr &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
-		WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
-	}
-}
-
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct mptcp_addr_info remote =3D { 0 };
@@ -354,7 +330,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
-				mptcp_pm_check_send_dedicated_add_addr_packet(msk);
+				mptcp_pm_nl_add_addr_send_ack(msk);
 			}
 		} else {
 			/* pick failed, avoid fourther attempts later */
@@ -425,7 +401,33 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *=
msk)
 	spin_lock_bh(&msk->pm.lock);
 =

 	mptcp_pm_announce_addr(msk, &remote, true);
-	mptcp_pm_check_send_dedicated_add_addr_packet(msk);
+	mptcp_pm_nl_add_addr_send_ack(msk);
+}
+
+void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	if (!mptcp_pm_should_add_signal_ipv6(msk))
+		return;
+
+	__mptcp_flush_join_list(msk);
+	subflow =3D list_first_entry_or_null(&msk->conn_list, typeof(*subflow), n=
ode);
+	if (subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		u8 add_addr;
+
+		spin_unlock_bh(&msk->pm.lock);
+		pr_debug("send ack for add_addr6");
+		lock_sock(ssk);
+		tcp_send_ack(ssk);
+		release_sock(ssk);
+		spin_lock_bh(&msk->pm.lock);
+
+		add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
+		add_addr &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
+		WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
+	}
 }
 =

 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 095104629c16..a6bd06c724d5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1796,6 +1796,10 @@ static void pm_work(struct mptcp_sock *msk)
 		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
+		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
+		mptcp_pm_nl_add_addr_send_ack(msk);
+	}
 	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
 		pm->status &=3D ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_nl_rm_addr_received(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5117093a4de4..7a5c16f176c0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -161,6 +161,7 @@ struct mptcp_addr_info {
 =

 enum mptcp_pm_status {
 	MPTCP_PM_ADD_ADDR_RECEIVED,
+	MPTCP_PM_ADD_ADDR_SEND_ACK,
 	MPTCP_PM_RM_ADDR_RECEIVED,
 	MPTCP_PM_ESTABLISHED,
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
@@ -510,6 +511,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *ms=
k,
 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
+void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 struct mptcp_pm_add_entry *
@@ -519,7 +521,6 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-void mptcp_pm_check_send_dedicated_add_addr_packet(struct mptcp_sock *msk);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

@@ -528,6 +529,11 @@ static inline bool mptcp_pm_should_add_signal(struct m=
ptcp_sock *msk)
 	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
 }
 =

+static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6);
+}
+
 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.rm_addr_signal);
@@ -552,6 +558,7 @@ void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_fully_established(struct mptcp_sock *msk);
 void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk);
 void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk);
+void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
-- =

2.26.2

--===============4643129673096253476==--
