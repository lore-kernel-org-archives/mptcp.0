Content-Type: multipart/mixed; boundary="===============1770505746840552657=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] mptcp: move MPTCP option bits to internal header
Date: Thu, 20 Jun 2019 16:13:53 +0200
Message-ID: <20190620141355.17923-2-matthieu.baerts@tessares.net>
In-Reply-To: 20190620141355.17923-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1430

--===============1770505746840552657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OPTION_MPTCP_MPC_* are only used in files from net/mptcp.

Fixes: d377be723a8a (mptcp: Handle MPTCP TCP options)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    Can be squashed in:
      mptcp: Handle MPTCP TCP options

 include/net/mptcp.h  | 5 -----
 net/mptcp/protocol.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0d3e02c6c817..eeb2ef902dfd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -8,11 +8,6 @@
 #ifndef __NET_MPTCP_H
 #define __NET_MPTCP_H
 =

-/* MPTCP option subtypes */
-#define OPTION_MPTCP_MPC_SYN	BIT(0)
-#define OPTION_MPTCP_MPC_SYNACK	BIT(1)
-#define OPTION_MPTCP_MPC_ACK	BIT(2)
-
 struct mptcp_out_options {
 	u16 suboptions;
 	u64 sndr_key;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ac57e10ec4ca..74dbc5155ea8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -7,6 +7,11 @@
 #ifndef __MPTCP_PROTOCOL_H
 #define __MPTCP_PROTOCOL_H
 =

+/* MPTCP option bits */
+#define OPTION_MPTCP_MPC_SYN	BIT(0)
+#define OPTION_MPTCP_MPC_SYNACK	BIT(1)
+#define OPTION_MPTCP_MPC_ACK	BIT(2)
+
 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
 #define MPTCPOPT_MP_JOIN	1
-- =

2.20.1


--===============1770505746840552657==--
