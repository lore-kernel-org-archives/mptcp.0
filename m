Content-Type: multipart/mixed; boundary="===============8109615352585738113=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix warnings reported by checkpatch
Date: Thu, 10 Oct 2019 16:27:44 +0200
Message-ID: <20191010142745.6436-4-matthieu.baerts@tessares.net>
In-Reply-To: 20191010142745.6436-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2088

--===============8109615352585738113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

WARNING: Improper SPDX comment style for 'net/mptcp/mib.c', please use '//'=
 instead
+/* SPDX-License-Identifier: GPL-2.0-or-later */

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
+/* SPDX-License-Identifier: GPL-2.0-or-later */

WARNING: line over 80 characters
+       SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFAL=
LBACK),

WARNING: line over 80 characters
+       SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEF=
ALLBACK),

WARNING: line over 80 characters
+       MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3=
-way handshake */

WARNING: line over 80 characters
+       MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3=
-way handshake */

WARNING: line over 80 characters
+       MPTCP_MIB_RETRANSSEGS,          /* Segments retransmitted at the MP=
TCP-level */

WARNING: line over 80 characters
+       MPTCP_MIB_JOINNOTOKEN,          /* Received MP_JOIN but the token w=
as not found */

WARNING: line over 80 characters
+       MPTCP_MIB_DSSNOMATCH,           /* Received a new mapping that did =
not match the previous one */

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add MIB counter infrastructure"

 net/mptcp/mib.c | 32 +++++++++++++++++++++-----------
 net/mptcp/mib.h | 30 ++++++++++++++++++++----------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 4ab627e877d1..1df0a4367532 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+// SPDX-License-Identifier: GPL-2.0-or-later
 =

 #include <linux/seq_file.h>
 #include <net/ip.h>
@@ -9,16 +9,26 @@
 #include "mib.h"
 =

 static const struct snmp_mib mptcp_snmp_list[] =3D {
-	SNMP_MIB_ITEM("MPCapableSYNRX", MPTCP_MIB_MPCAPABLEPASSIVE),
-	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
-	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
-	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBAC=
K),
-	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
-	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
-	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
-	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
-	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
-	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
+	SNMP_MIB_ITEM("MPCapableSYNRX",
+		      MPTCP_MIB_MPCAPABLEPASSIVE),
+	SNMP_MIB_ITEM("MPCapableACKRX",
+		      MPTCP_MIB_MPCAPABLEPASSIVEACK),
+	SNMP_MIB_ITEM("MPCapableFallbackACK",
+		      MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
+	SNMP_MIB_ITEM("MPCapableFallbackSYNACK",
+		      MPTCP_MIB_MPCAPABLEACTIVEFALLBACK),
+	SNMP_MIB_ITEM("MPTCPRetrans",
+		      MPTCP_MIB_RETRANSSEGS),
+	SNMP_MIB_ITEM("MPJoinNoTokenFound",
+		      MPTCP_MIB_JOINNOTOKEN),
+	SNMP_MIB_ITEM("MPJoinSynRx",
+		      MPTCP_MIB_JOINSYNRX),
+	SNMP_MIB_ITEM("MPJoinAckHMacFailure",
+		      MPTCP_MIB_JOINACKMAC),
+	SNMP_MIB_ITEM("DSSNotMatching",
+		      MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("InfiniteMapRx",
+		      MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_SENTINEL
 };
 =

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index d50b53e8209b..71afd62327fb 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -2,16 +2,26 @@
 =

 enum linux_mptcp_mib_field {
 	MPTCP_MIB_NUM =3D 0,
-	MPTCP_MIB_MPCAPABLEPASSIVE,	/* Received SYN with MP_CAPABLE */
-	MPTCP_MIB_MPCAPABLEPASSIVEACK,	/* Received third ACK with MP_CAPABLE */
-	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way h=
andshake */
-	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way h=
andshake */
-	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
-	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
-	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
-	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
-	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the p=
revious one */
-	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
+	/* Received SYN with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEPASSIVE,
+	/* Received third ACK with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEPASSIVEACK,
+	/* Server-side fallback during 3-way handshake */
+	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,
+	/* Client-side fallback during 3-way handshake */
+	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK,
+	/* Segments retransmitted at the MPTCP-level */
+	MPTCP_MIB_RETRANSSEGS,
+	/* Received MP_JOIN but the token was not found */
+	MPTCP_MIB_JOINNOTOKEN,
+	/* Received a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNRX,
+	/* HMAC was wrong on ACK + MP_JOIN */
+	MPTCP_MIB_JOINACKMAC,
+	/* Received a new mapping that did not match the previous one */
+	MPTCP_MIB_DSSNOMATCH,
+	/* Received an infinite mapping */
+	MPTCP_MIB_INFINITEMAPRX,
 	__MPTCP_MIB_MAX
 };
 =

-- =

2.20.1

--===============8109615352585738113==--
