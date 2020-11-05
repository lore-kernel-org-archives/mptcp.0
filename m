Content-Type: multipart/mixed; boundary="===============8572318009741843222=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 06/12] mptcp: send out dedicated
 packet for ADD_ADDR using port
Date: Thu, 05 Nov 2020 16:01:06 +0800
Message-ID: <74b78decc74c47e196b41b5872d3470d46069c72.1604562475.git.geliangtang@gmail.com>
In-Reply-To: 88cb173acb83efe181b7a1845feabcc316c9a722.1604562475.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6550

--===============8572318009741843222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The process is similar to that of the ADD_ADDR IPv6, this patch also sent
out a pure ack for the ADD_ADDR using port.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    |  3 ++-
 net/mptcp/pm.c         |  3 ++-
 net/mptcp/pm_netlink.c | 14 +++++++++++---
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 156ff4d63ec1..c05db50b4bc1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -589,7 +589,8 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	bool port;
 	int len;
 =

-	if (mptcp_pm_should_add_signal_ipv6(msk) &&
+	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
+	     mptcp_pm_should_add_signal_port(msk)) &&
 	    skb && skb_is_tcp_pure_ack(skb)) {
 		pr_debug("drop other suboptions");
 		opts->suboptions =3D 0;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6d4be02681fa..0c456747893e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -167,7 +167,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 =

 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 {
-	if (!mptcp_pm_should_add_signal_ipv6(msk))
+	if (!mptcp_pm_should_add_signal_ipv6(msk) &&
+	    !mptcp_pm_should_add_signal_port(msk))
 		return;
 =

 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6180a8b39a3f..72d150e45067 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -408,7 +408,8 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *m=
sk)
 {
 	struct mptcp_subflow_context *subflow;
 =

-	if (!mptcp_pm_should_add_signal_ipv6(msk))
+	if (!mptcp_pm_should_add_signal_ipv6(msk) &&
+	    !mptcp_pm_should_add_signal_port(msk))
 		return;
 =

 	__mptcp_flush_join_list(msk);
@@ -418,14 +419,21 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock =
*msk)
 		u8 add_addr;
 =

 		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for add_addr6");
+		if (mptcp_pm_should_add_signal_ipv6(msk))
+			pr_debug("send ack for add_addr6");
+		if (mptcp_pm_should_add_signal_port(msk))
+			pr_debug("send ack for add_addr_port");
+
 		lock_sock(ssk);
 		tcp_send_ack(ssk);
 		release_sock(ssk);
 		spin_lock_bh(&msk->pm.lock);
 =

 		add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
-		add_addr &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
+		if (mptcp_pm_should_add_signal_ipv6(msk))
+			add_addr &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
+		if (mptcp_pm_should_add_signal_port(msk))
+			add_addr &=3D ~BIT(MPTCP_ADD_ADDR_PORT);
 		WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
 	}
 }
-- =

2.26.2

--===============8572318009741843222==--
