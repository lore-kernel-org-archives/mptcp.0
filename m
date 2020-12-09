Content-Type: multipart/mixed; boundary="===============4178686433649144039=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 06/11] mptcp: send out dedicated packet for
 ADD_ADDR using port
Date: Wed, 09 Dec 2020 15:51:23 -0800
Message-ID: <20201209235128.175473-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201209235128.175473-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7112

--===============4178686433649144039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

The process is similar to that of the ADD_ADDR IPv6, this patch also sent
out a pure ack for the ADD_ADDR using port.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c    |  3 ++-
 net/mptcp/pm.c         |  3 ++-
 net/mptcp/pm_netlink.c | 14 +++++++++++---
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9d3b49254d38..6a290c622ccf 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -590,7 +590,8 @@ static bool mptcp_established_options_add_addr(struct s=
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
index 2c517046e2b5..d20637860851 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -173,7 +173,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
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
index 03f2c28f11f5..7a0f700e34bb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -407,7 +407,8 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *m=
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
@@ -417,14 +418,21 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock =
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

2.29.2

--===============4178686433649144039==--
