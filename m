Content-Type: multipart/mixed; boundary="===============7175569220360822293=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 2/3] mptcp: add ADD_ADDR related
 mibs
Date: Wed, 19 Aug 2020 14:52:17 +0800
Message-ID: <47d4cb7e30803890ec6c70107982a930ed269cbd.1597819482.git.geliangtang@gmail.com>
In-Reply-To: cover.1597819482.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5579

--===============7175569220360822293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added two mibs for ADD_ADDR, MPTCP_MIB_ADDADDR for receiving
of the ADD_ADDR suboption with echo-flag=3D0, and MPTCP_MIB_ECHOADD for
receiving the ADD_ADDR suboption with echo-flag=3D1.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 056986c7a228..a33bf719ce6f 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -27,6 +27,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("OFOMerge", MPTCP_MIB_OFOMERGE),
 	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
+	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
+	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
 	SNMP_MIB_SENTINEL
 };
 =

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 937a177729f1..cdeea3732ddf 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -20,6 +20,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_OFOMERGE,		/* Segments merged in OoO queue */
 	MPTCP_MIB_NODSSWINDOW,		/* Segments not in MPTCP windows */
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
+	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=3D0 */
+	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=3D1 */
 	__MPTCP_MIB_MAX
 };
 =

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f91238ff3200..26a5536363bb 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -11,6 +11,7 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include "protocol.h"
+#include "mib.h"
 =

 static bool mptcp_cap_flag_sha256(u8 flags)
 {
@@ -893,7 +894,10 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 				spin_lock_bh(&msk->pm.lock);
 				mptcp_pm_announce_addr(msk, &addr, true);
 				spin_unlock_bh(&msk->pm.lock);
+				__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			}
+		} else {
+			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
 		mp_opt.add_addr =3D 0;
 	}
-- =

2.17.1

--===============7175569220360822293==--
