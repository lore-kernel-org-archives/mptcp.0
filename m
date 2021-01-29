Content-Type: multipart/mixed; boundary="===============3794328780063536202=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 04/16] mptcp: send ack for every add_addr
Date: Thu, 28 Jan 2021 17:11:03 -0800
Message-ID: <20210129011115.133953-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210129011115.133953-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7510

--===============3794328780063536202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch changes the sending ACK conditions for the ADD_ADDR, send an
ACK packet for any ADD_ADDR, not just when ipv6 addresses or port
numbers are included.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/139
Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
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
index d91ea0316a4f..78a157a30c68 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -474,8 +474,7 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *m=
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
@@ -485,10 +484,9 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *=
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

2.30.0

--===============3794328780063536202==--
