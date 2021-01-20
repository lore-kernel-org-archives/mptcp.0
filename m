Content-Type: multipart/mixed; boundary="===============2502689044893935695=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] mptcp: send ack for every add_addr
Date: Wed, 20 Jan 2021 15:10:38 +0800
Message-ID: <4be0fc0ea68afa7ab32a9132a938b4f6bcd6569b.1611126450.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7432

--===============2502689044893935695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changes the sending ACK conditions for the ADD_ADDR, send an ACK
packet for any ADD_ADDR, not just when ipv6 addresses or port numbers
are included.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/139
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 Obsoletes: "add add_addr_urgent" patchset
---
 net/mptcp/pm.c         | 3 +--
 net/mptcp/pm_netlink.c | 9 +++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

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
index 39998c521133..7e6e99abdd33 100644
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
@@ -507,10 +506,12 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock =
*msk)
 		u8 add_addr;
 =

 		spin_unlock_bh(&msk->pm.lock);
+		if (mptcp_pm_should_add_signal(msk))
+			pr_debug("send ack for add_addr");
 		if (mptcp_pm_should_add_signal_ipv6(msk))
-			pr_debug("send ack for add_addr6");
+			pr_debug("[ipv6]");
 		if (mptcp_pm_should_add_signal_port(msk))
-			pr_debug("send ack for add_addr_port");
+			pr_debug("[port]");
 =

 		lock_sock(ssk);
 		tcp_send_ack(ssk);
-- =

2.29.2

--===============2502689044893935695==--
