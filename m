Content-Type: multipart/mixed; boundary="===============8357402546300658254=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 2/5] mptcp: add RM_ADDR mib
Date: Thu, 13 Aug 2020 18:37:16 +0800
Message-ID: <6bd113a13fe9b4c3c31fd1b5a764bfc6f1f69a50.1597314634.git.geliangtang@gmail.com>
In-Reply-To: cover.1597314634.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5546

--===============8357402546300658254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new mib for RM_ADDR, named MPTCP_MIB_RMADDR, when the
RM_ADDR suboption is received, increase this mib counter.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/mib.c     | 1 +
 net/mptcp/mib.h     | 1 +
 net/mptcp/options.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 056986c7a228..e71d3eebd924 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -27,6 +27,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("OFOMerge", MPTCP_MIB_OFOMERGE),
 	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
+	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
 	SNMP_MIB_SENTINEL
 };
 =

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 937a177729f1..6d73818bbf7b 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -20,6 +20,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_OFOMERGE,		/* Segments merged in OoO queue */
 	MPTCP_MIB_NODSSWINDOW,		/* Segments not in MPTCP windows */
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
+	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
 	__MPTCP_MIB_MAX
 };
 =

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a52a05effac9..a5ecf004a152 100644
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
@@ -890,6 +891,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 =

 	if (mp_opt.rm_addr) {
 		mptcp_pm_rm_addr_received(msk, mp_opt.rm_id);
+		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
 		mp_opt.rm_addr =3D 0;
 	}
 =

-- =

2.17.1

--===============8357402546300658254==--
