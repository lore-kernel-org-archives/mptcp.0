Content-Type: multipart/mixed; boundary="===============1978227626041413266=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: send out
 dedicated ADD_ADDR packet"
Date: Mon, 26 Oct 2020 20:01:02 +0800
Message-ID: <d8f9ce2a82ac8546b9c2c573bdd34b326c67b5d2.1603712391.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6435

--===============1978227626041413266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit message should be rewritten entirely:
"""
When ADD_ADDR suboption includes an IPv6 address, the size is 28 octets.
It will not fit when other MPTCP suboptions are included in this packet,
e.g. DSS. So here we send out an ADD_ADDR dedicated packet to carry only
ADD_ADDR suboption, no other MPTCP suboptions.

In mptcp_pm_announce_addr, we check whether this is an IPv6 ADD_ADDR.
If it is, we set the flag MPTCP_ADD_ADDR_IPV6 to true. Then we call
tcp_send_ack to sent out a new pure ACK packet.

In mptcp_established_options_add_addr, we check whether this is a pure
ACK packet for ADD_ADDR. If it is, we drop all other MPTCP suboptions
in this packet, only put ADD_ADDR suboption in it.
"""

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/102
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
This patch added the socket locks for tcp_send_ack, to fix issues 102.
But we need to use different locks in the different places.

In mptcp_pm_create_subflow_or_signal_addr and mptcp_pm_nl_add_addr_received,
we need to call lock_sock/release_sock. In mptcp_pm_add_timer, we
need to call bh_lock_sock/bh_unlock_sock since it's in interrupt context.
But in mptcp_pm_add_addr_received, we need to use no lock for tcp_send_ack.

So this patch split mptcp_pm_check_send_dedicated_add_addr_packet
function to three parts: mptcp_pm_should_add_signal_ipv6,
mptcp_pm_get_first_subflow_socket and mptcp_pm_clear_add_signal_ipv6. Then
we can use different locks in the different places.
---
 net/mptcp/pm.c         | 16 ++++++---
 net/mptcp/pm_netlink.c | 76 ++++++++++++++++++++++++++++++++----------
 net/mptcp/protocol.h   |  8 ++++-
 3 files changed, 77 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4341e140f1ff..63df1a6b5a3d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -155,14 +155,22 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
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
+
+	if (mptcp_pm_should_add_signal_ipv6(msk)) {
+		struct sock *ssk =3D mptcp_pm_get_first_subflow_socket(msk);
+
+		if (ssk) {
+			pr_debug("send ack for add_addr6");
+			tcp_send_ack(ssk);
+			mptcp_pm_clear_add_signal_ipv6(msk);
+		}
+	}
 }
 =

 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index da545f11745c..64a0e2853a5c 100644
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

@@ -239,6 +238,19 @@ static void mptcp_pm_add_timer(struct timer_list *time=
r)
 =

 	spin_unlock_bh(&msk->pm.lock);
 =

+	if (mptcp_pm_should_add_signal_ipv6(msk)) {
+		struct sock *ssk =3D mptcp_pm_get_first_subflow_socket(msk);
+
+		if (ssk) {
+			pr_debug("send ack for add_addr6");
+			bh_lock_sock(ssk);
+			tcp_send_ack(ssk);
+			bh_unlock_sock(ssk);
+
+			mptcp_pm_clear_add_signal_ipv6(msk);
+		}
+	}
+
 out:
 	__sock_put(sk);
 }
@@ -307,28 +319,30 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 =

-void mptcp_pm_check_send_dedicated_add_addr_packet(struct mptcp_sock *msk)
+struct sock *mptcp_pm_get_first_subflow_socket(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-
-	if (!(READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6)))
-		return;
+	struct sock *ssk =3D NULL;
 =

 	__mptcp_flush_join_list(msk);
 	subflow =3D list_first_entry_or_null(&msk->conn_list, typeof(*subflow), n=
ode);
-	if (subflow) {
-		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
-		u8 add_addr;
+	if (subflow)
+		ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

-		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for add_addr6");
-		tcp_send_ack(ssk);
-		spin_lock_bh(&msk->pm.lock);
+	return ssk;
+}
 =

-		add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
-		add_addr &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
-		WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
-	}
+void mptcp_pm_clear_add_signal_ipv6(struct mptcp_sock *msk)
+{
+	u8 add_addr;
+
+	spin_lock_bh(&msk->pm.lock);
+
+	add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
+	add_addr &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
+	WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
+
+	spin_unlock_bh(&msk->pm.lock);
 }
 =

 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
@@ -354,7 +368,20 @@ static void mptcp_pm_create_subflow_or_signal_addr(str=
uct mptcp_sock *msk)
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
-				mptcp_pm_check_send_dedicated_add_addr_packet(msk);
+
+				spin_unlock_bh(&msk->pm.lock);
+				if (mptcp_pm_should_add_signal_ipv6(msk)) {
+					struct sock *ssk =3D mptcp_pm_get_first_subflow_socket(msk);
+
+					if (ssk) {
+						pr_debug("send ack for add_addr6");
+						lock_sock(ssk);
+						tcp_send_ack(ssk);
+						release_sock(ssk);
+						mptcp_pm_clear_add_signal_ipv6(msk);
+					}
+				}
+				spin_lock_bh(&msk->pm.lock);
 			}
 		} else {
 			/* pick failed, avoid fourther attempts later */
@@ -425,7 +452,20 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *=
msk)
 	spin_lock_bh(&msk->pm.lock);
 =

 	mptcp_pm_announce_addr(msk, &remote, true);
-	mptcp_pm_check_send_dedicated_add_addr_packet(msk);
+
+	spin_unlock_bh(&msk->pm.lock);
+	if (mptcp_pm_should_add_signal_ipv6(msk)) {
+		struct sock *ssk =3D mptcp_pm_get_first_subflow_socket(msk);
+
+		if (ssk) {
+			pr_debug("send ack for add_addr6");
+			lock_sock(ssk);
+			tcp_send_ack(ssk);
+			release_sock(ssk);
+			mptcp_pm_clear_add_signal_ipv6(msk);
+		}
+	}
+	spin_lock_bh(&msk->pm.lock);
 }
 =

 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 817c191ba677..7eb505882a2b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -518,7 +518,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-void mptcp_pm_check_send_dedicated_add_addr_packet(struct mptcp_sock *msk);
+struct sock *mptcp_pm_get_first_subflow_socket(struct mptcp_sock *msk);
+void mptcp_pm_clear_add_signal_ipv6(struct mptcp_sock *msk);
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

--===============1978227626041413266==--
