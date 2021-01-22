Content-Type: multipart/mixed; boundary="===============5982183624605788868=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next] mptcp: send ack for every
 add_addr
Date: Fri, 22 Jan 2021 11:18:52 +0800
Message-ID: <e5e3e55c8caf3cba6b07d0a92ff080792949a41a.1611285417.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7466

--===============5982183624605788868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changes the sending ACK conditions for the ADD_ADDR, send an ACK
packet for any ADD_ADDR, not just when ipv6 addresses or port numbers
are included.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/139
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 v2:
  - print out the debug output on one line.
---
 net/mptcp/pm.c         |  3 +--
 net/mptcp/pm_netlink.c | 12 ++++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 01a846b25771..3a22e73220b9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -191,8 +191,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 =

 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 {
-	if (!mptcp_pm_should_add_signal_ipv6(msk) &&
-	    !mptcp_pm_should_add_signal_port(msk))
+	if (!mptcp_pm_should_add_signal(msk))
 		return;
 =

 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 39998c521133..369cb787169f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -496,8 +496,7 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *m=
sk)
 {
 	struct mptcp_subflow_context *subflow;
 =

-	if (!mptcp_pm_should_add_signal_ipv6(msk) &&
-	    !mptcp_pm_should_add_signal_port(msk))
+	if (!mptcp_pm_should_add_signal(msk))
 		return;
 =

 	__mptcp_flush_join_list(msk);
@@ -507,10 +506,11 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock =
*msk)
 		u8 add_addr;
 =

 		spin_unlock_bh(&msk->pm.lock);
-		if (mptcp_pm_should_add_signal_ipv6(msk))
-			pr_debug("send ack for add_addr6");
-		if (mptcp_pm_should_add_signal_port(msk))
-			pr_debug("send ack for add_addr_port");
+		if (mptcp_pm_should_add_signal(msk)) {
+			pr_debug("send ack for add_addr%s%s",
+				 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
+				 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
+		}
 =

 		lock_sock(ssk);
 		tcp_send_ack(ssk);
-- =

2.29.2

--===============5982183624605788868==--
