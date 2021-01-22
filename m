Content-Type: multipart/mixed; boundary="===============6487815594901948827=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next] mptcp: send ack for every
 add_addr
Date: Fri, 22 Jan 2021 19:25:18 +0800
Message-ID: <93f8d1cb4ad54d30539c7a3ec1455afc13388844.1611314528.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7470

--===============6487815594901948827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changes the sending ACK conditions for the ADD_ADDR, send an ACK
packet for any ADD_ADDR, not just when ipv6 addresses or port numbers
are included.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/139
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 v3:
  - drop the duplicate mptcp_pm_should_add_signal(msk) check in v2.
 v2:
  - print out the debug output on one line.
---
 net/mptcp/pm.c         |  3 +--
 net/mptcp/pm_netlink.c | 10 ++++------
 2 files changed, 5 insertions(+), 8 deletions(-)

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
index 39998c521133..37b4c9068f8d 100644
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
@@ -507,10 +506,9 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *=
msk)
 		u8 add_addr;
 =

 		spin_unlock_bh(&msk->pm.lock);
-		if (mptcp_pm_should_add_signal_ipv6(msk))
-			pr_debug("send ack for add_addr6");
-		if (mptcp_pm_should_add_signal_port(msk))
-			pr_debug("send ack for add_addr_port");
+		pr_debug("send ack for add_addr%s%s",
+			 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
+			 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
 =

 		lock_sock(ssk);
 		tcp_send_ack(ssk);
-- =

2.29.2

--===============6487815594901948827==--
