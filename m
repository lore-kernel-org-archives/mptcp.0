Content-Type: multipart/mixed; boundary="===============8234676698783368360=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 10/16] mptcp: add RM_ADDR related mibs
Date: Thu, 24 Sep 2020 08:29:56 +0800
Message-ID: <644420f22ba6f0b9f9f3509c081d8d639ff4bbf3.1600853093.git.geliangtang@gmail.com>
In-Reply-To: cover.1600853093.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6006

--===============8234676698783368360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added two new mibs for RM_ADDR, named MPTCP_MIB_RMADDR and
MPTCP_MIB_RMSUBFLOW, when the RM_ADDR suboption is received, increase
the first mib counter, when the local subflow is removed, increase the
second mib counter.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/mib.c        | 2 ++
 net/mptcp/mib.h        | 2 ++
 net/mptcp/pm_netlink.c | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index a33bf719ce6f..84d119436b22 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -29,6 +29,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
 	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
 	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
+	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
+	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_SENTINEL
 };
 =

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index cdeea3732ddf..47bcecce1106 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -22,6 +22,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
 	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=3D0 */
 	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=3D1 */
+	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
+	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	__MPTCP_MIB_MAX
 };
 =

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9064c8098521..b33aebd85bd5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -15,6 +15,7 @@
 #include <uapi/linux/mptcp.h>
 =

 #include "protocol.h"
+#include "mib.h"
 =

 /* forward declaration */
 static struct genl_family mptcp_genl_family;
@@ -346,6 +347,8 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *ms=
k)
 		msk->pm.subflows--;
 		WRITE_ONCE(msk->pm.accept_addr, true);
 =

+		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
+
 		break;
 	}
 }
@@ -379,6 +382,8 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock =
*msk, u8 rm_id)
 		msk->pm.local_addr_used--;
 		msk->pm.subflows--;
 =

+		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+
 		break;
 	}
 }
-- =

2.17.1

--===============8234676698783368360==--
