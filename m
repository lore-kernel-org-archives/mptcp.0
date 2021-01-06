Content-Type: multipart/mixed; boundary="===============6720978409973948669=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 4/5] mptcp: add urgent status for
 ADD_ADDR
Date: Wed, 06 Jan 2021 18:22:45 +0800
Message-ID: <38d1059450e7277a4183c6f0a37b10d5e16d82f8.1609925558.git.geliangtang@gmail.com>
In-Reply-To: 34f227194451100e1c544ac3285c700eb5d38531.1609925558.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7281

--===============6720978409973948669==
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
index 06c9ec12c538..01cd50646b82 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -509,6 +509,8 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *m=
sk)
 			strcat(buf, "[ipv6]");
 		if (mptcp_pm_should_add_signal_port(msk))
 			strcat(buf, "[port]");
+		if (mptcp_pm_should_add_signal_urgent(msk))
+			strcat(buf, "[urgent]");
 		pr_debug("send ack for add_addr %s", buf);
 =

 		lock_sock(ssk);
@@ -521,6 +523,8 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *m=
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
index 56e200efec01..fd1c785bdcdf 100644
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

@@ -594,6 +595,11 @@ static inline bool mptcp_pm_should_add_signal_port(str=
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
@@ -602,7 +608,8 @@ static inline bool mptcp_pm_should_rm_signal(struct mpt=
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

--===============6720978409973948669==--
