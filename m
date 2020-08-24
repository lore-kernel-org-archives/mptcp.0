Content-Type: multipart/mixed; boundary="===============4185991957130405009=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v8 mptcp-next 6/8] mptcp: add RM_ADDR related
 mibs
Date: Mon, 24 Aug 2020 19:36:19 +0800
Message-ID: <42134c358fcddf475f6b581d32884d65c50a746e.1598267961.git.geliangtang@gmail.com>
In-Reply-To: cover.1598267961.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5611

--===============4185991957130405009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added two new mibs for RM_ADDR, named MPTCP_MIB_RMADDR and
MPTCP_MIB_RMSUBFLOW, when the RM_ADDR suboption is received, increase
the first mib counter, when the local subflow is removed, increase the
second mib counter.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/mib.c        | 2 ++
 net/mptcp/mib.h        | 2 ++
 net/mptcp/pm_netlink.c | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 056986c7a228..3b076a636228 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -27,6 +27,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("OFOMerge", MPTCP_MIB_OFOMERGE),
 	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
+	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
+	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_SENTINEL
 };
 =

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 937a177729f1..7f2b6685c034 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -20,6 +20,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_OFOMERGE,		/* Segments merged in OoO queue */
 	MPTCP_MIB_NODSSWINDOW,		/* Segments not in MPTCP windows */
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
+	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
+	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	__MPTCP_MIB_MAX
 };
 =

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index cd37d94a30fe..2b286730c98d 100644
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
@@ -301,6 +302,8 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *ms=
k)
 		msk->pm.subflows--;
 		WRITE_ONCE(msk->pm.accept_addr, true);
 =

+		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
+
 		break;
 	}
 }
@@ -334,6 +337,8 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock =
*msk)
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

--===============4185991957130405009==--
