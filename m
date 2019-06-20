Content-Type: multipart/mixed; boundary="===============1455789785218689924=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] mptcp: move MPTCP option bits to internal header
Date: Thu, 20 Jun 2019 16:13:54 +0200
Message-ID: <20190620141355.17923-3-matthieu.baerts@tessares.net>
In-Reply-To: 20190620141355.17923-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1431

--===============1455789785218689924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OPTION_MPTCP_ADD/RM_* are only used in files from net/mptcp.

Fixes: abb537b13f1a (mptcp: Add ADD_ADDR handling)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    Can be squashed in:
      mptcp: Add ADD_ADDR handling

 include/net/mptcp.h  | 4 ----
 net/mptcp/protocol.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index fcfcb4150711..518f10248754 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -24,10 +24,6 @@ struct mptcp_ext {
 			__unused:2;
 };
 =

-#define OPTION_MPTCP_ADD_ADDR		BIT(6)
-#define OPTION_MPTCP_ADD_ADDR6		BIT(7)
-#define OPTION_MPTCP_RM_ADDR		BIT(8)
-
 struct mptcp_out_options {
 #if IS_ENABLED(CONFIG_MPTCP)
 	u16 suboptions;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b5305ce55480..6e9569a8d556 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -14,6 +14,10 @@
 #define OPTION_MPTCP_MPC_SYN	BIT(0)
 #define OPTION_MPTCP_MPC_SYNACK	BIT(1)
 #define OPTION_MPTCP_MPC_ACK	BIT(2)
+#define OPTION_MPTCP_ADD_ADDR	BIT(6)
+#define OPTION_MPTCP_ADD_ADDR6	BIT(7)
+#define OPTION_MPTCP_RM_ADDR	BIT(8)
+
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
-- =

2.20.1


--===============1455789785218689924==--
