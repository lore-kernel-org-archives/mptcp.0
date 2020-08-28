Content-Type: multipart/mixed; boundary="===============2170169722647108953=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 2/4] mptcp: add ADD_ADDR related
 mibs
Date: Fri, 28 Aug 2020 15:16:02 +0800
Message-ID: <2e88ccea2ee01e9ad85cf7b507c1efac6c458905.1598598749.git.geliangtang@gmail.com>
In-Reply-To: cover.1598598749.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5655

--===============2170169722647108953==
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
 net/mptcp/options.c | 7 ++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

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
index a41996e6c6d7..0d1ff621613c 100644
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
@@ -888,8 +889,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 			addr.addr6 =3D mp_opt.addr6;
 		}
 #endif
-		if (!mp_opt.echo)
+		if (!mp_opt.echo) {
 			mptcp_pm_add_addr_received(msk, &addr);
+			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
+		} else {
+			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
+		}
 		mp_opt.add_addr =3D 0;
 	}
 =

-- =

2.17.1

--===============2170169722647108953==--
