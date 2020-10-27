Content-Type: multipart/mixed; boundary="===============6111730397541422543=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: send out
 dedicated ADD_ADDR packet"
Date: Tue, 27 Oct 2020 14:58:23 +0800
Message-ID: <e8438a90864f67398b3b3a6cfa7dc94baac7206b.1603781696.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6439

--===============6111730397541422543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Please update the following function name in the commit message:

 mptcp_pm_check_send_dedicated_add_addr_packet
                   ->
 mptcp_pm_nl_send_dedicated_add_addr_packet

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/102
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 v2:
 - Add a new command PTCP_PM_ADD_ADDR_SEND_ACK.
 - call mptcp_pm_nl_send_dedicated_add_addr_packet from pm_work.
---
 net/mptcp/options.c    |  2 +-
 net/mptcp/pm.c         | 13 ++++++++-----
 net/mptcp/pm_netlink.c |  9 ++++-----
 net/mptcp/protocol.c   |  4 ++++
 net/mptcp/protocol.h   |  8 +++++++-
 5 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index fc6a62fbbe4c..d7afffcc87c1 100644
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
index 4341e140f1ff..a5bee01acc26 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -10,6 +10,9 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

+static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
+				   enum mptcp_pm_status new_status);
+
 /* path manager command handlers */
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -24,8 +27,10 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 	add_addr |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
 	if (echo)
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_ECHO);
-	if (addr->family =3D=3D AF_INET6)
+	if (addr->family =3D=3D AF_INET6) {
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_IPV6);
+		mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
+	}
 	WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
 	return 0;
 }
@@ -155,12 +160,10 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
 =

 	spin_lock_bh(&pm->lock);
 =

-	if (!READ_ONCE(pm->accept_addr)) {
+	if (!READ_ONCE(pm->accept_addr))
 		mptcp_pm_announce_addr(msk, addr, true);
-		mptcp_pm_check_send_dedicated_add_addr_packet(msk);
-	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
+	else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
 		pm->remote =3D *addr;
-	}
 =

 	spin_unlock_bh(&pm->lock);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index da545f11745c..cc616614065e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -229,7 +229,6 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!mptcp_pm_should_add_signal(msk)) {
 		pr_debug("retransmit ADD_ADDR id=3D%d", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
-		mptcp_pm_check_send_dedicated_add_addr_packet(msk);
 		entry->retrans_times++;
 	}
 =

@@ -307,11 +306,11 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 =

-void mptcp_pm_check_send_dedicated_add_addr_packet(struct mptcp_sock *msk)
+void mptcp_pm_nl_send_dedicated_add_addr_packet(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 =

-	if (!(READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6)))
+	if (!mptcp_pm_should_add_signal_ipv6(msk))
 		return;
 =

 	__mptcp_flush_join_list(msk);
@@ -322,7 +321,9 @@ void mptcp_pm_check_send_dedicated_add_addr_packet(stru=
ct mptcp_sock *msk)
 =

 		spin_unlock_bh(&msk->pm.lock);
 		pr_debug("send ack for add_addr6");
+		lock_sock(ssk);
 		tcp_send_ack(ssk);
+		release_sock(ssk);
 		spin_lock_bh(&msk->pm.lock);
 =

 		add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
@@ -354,7 +355,6 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
-				mptcp_pm_check_send_dedicated_add_addr_packet(msk);
 			}
 		} else {
 			/* pick failed, avoid fourther attempts later */
@@ -425,7 +425,6 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	spin_lock_bh(&msk->pm.lock);
 =

 	mptcp_pm_announce_addr(msk, &remote, true);
-	mptcp_pm_check_send_dedicated_add_addr_packet(msk);
 }
 =

 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e268a9b04c59..7836e992dbba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1790,6 +1790,10 @@ static void pm_work(struct mptcp_sock *msk)
 		pm->status &=3D ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
 		mptcp_pm_nl_rm_addr_received(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
+		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
+		mptcp_pm_nl_send_dedicated_add_addr_packet(msk);
+	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &=3D ~BIT(MPTCP_PM_ESTABLISHED);
 		mptcp_pm_nl_fully_established(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 817c191ba677..403c40825b04 100644
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
@@ -518,7 +519,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-void mptcp_pm_check_send_dedicated_add_addr_packet(struct mptcp_sock *msk);
+void mptcp_pm_nl_send_dedicated_add_addr_packet(struct mptcp_sock *msk);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

@@ -527,6 +528,11 @@ static inline bool mptcp_pm_should_add_signal(struct m=
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
-- =

2.26.2

--===============6111730397541422543==--
