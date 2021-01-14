Content-Type: multipart/mixed; boundary="===============2391400083202139559=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 4/5] mptcp: add urgent status for
 ADD_ADDR
Date: Thu, 14 Jan 2021 13:40:22 +0800
Message-ID: <5c2538ff873c136749b80d2f2999ea13e71fe229.1610602400.git.geliangtang@gmail.com>
In-Reply-To: eb180a799e3650fae10aa3ed9afafb7dc13ddae4.1610602400.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7372

--===============2391400083202139559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new status named MPTCP_ADD_ADDR_URGENT in
mptcp_addr_signal_status. If this status is set, a dedicated ADD_ADDR
packet also needs to be sent out.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         | 2 ++
 net/mptcp/pm_netlink.c | 4 ++++
 net/mptcp/protocol.h   | 9 ++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c22a43b20323..998828990029 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -33,6 +33,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_IPV6);
 	if (port)
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_PORT);
+	if (mptcp_get_add_addr_urgent(sock_net((struct sock *)msk)))
+		add_addr |=3D BIT(MPTCP_ADD_ADDR_URGENT);
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	return 0;
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8f4bd2457a97..7b268f458632 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -508,6 +508,8 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *m=
sk)
 			strcat(buf, "[ipv6]");
 		if (mptcp_pm_should_add_signal_port(msk))
 			strcat(buf, "[port]");
+		if (mptcp_pm_should_add_signal_urgent(msk))
+			strcat(buf, "[urgent]");
 		pr_debug("send ack for add_addr %s", buf);
 =

 		lock_sock(ssk);
@@ -520,6 +522,8 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *m=
sk)
 			add_addr &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
 		if (mptcp_pm_should_add_signal_port(msk))
 			add_addr &=3D ~BIT(MPTCP_ADD_ADDR_PORT);
+		if (mptcp_pm_should_add_signal_urgent(msk))
+			add_addr &=3D ~BIT(MPTCP_ADD_ADDR_URGENT);
 		WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	}
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 030e352bd2d6..0e4ae083b387 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -183,6 +183,7 @@ enum mptcp_addr_signal_status {
 	MPTCP_ADD_ADDR_ECHO,
 	MPTCP_ADD_ADDR_IPV6,
 	MPTCP_ADD_ADDR_PORT,
+	MPTCP_ADD_ADDR_URGENT,
 	MPTCP_RM_ADDR_SIGNAL,
 };
 =

@@ -614,6 +615,11 @@ static inline bool mptcp_pm_should_add_signal_port(str=
uct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_PORT);
 }
 =

+static inline bool mptcp_pm_should_add_signal_urgent(struct mptcp_sock *ms=
k)
+{
+	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_URGENT);
+}
+
 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
@@ -622,7 +628,8 @@ static inline bool mptcp_pm_should_rm_signal(struct mpt=
cp_sock *msk)
 static inline bool mptcp_pm_should_add_signal_send_ack(struct mptcp_sock *=
msk)
 {
 	return mptcp_pm_should_add_signal_ipv6(msk) ||
-	       mptcp_pm_should_add_signal_port(msk);
+	       mptcp_pm_should_add_signal_port(msk) ||
+	       mptcp_pm_should_add_signal_urgent(msk);
 }
 =

 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool =
port)
-- =

2.29.2

--===============2391400083202139559==--
