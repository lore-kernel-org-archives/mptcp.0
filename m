Content-Type: multipart/mixed; boundary="===============8439383399262561575=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "[PATCH v3 mptcp-next
 1/6] mptcp: add the outgoing MP_PRIO support"
Date: Fri, 11 Dec 2020 12:17:44 +0800
Message-ID: <0fd70bc3ba98498436cbe98b2104ea70a5159db3.1607660133.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7142

--===============8439383399262561575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Leave OPTION_MPTCP_FASTCLOSE as BIT(9) and set OPTION_MPTCP_PRIO as
BIT(10).

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fda183553422..d6400ad2d615 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -23,8 +23,8 @@
 #define OPTION_MPTCP_ADD_ADDR	BIT(6)
 #define OPTION_MPTCP_ADD_ADDR6	BIT(7)
 #define OPTION_MPTCP_RM_ADDR	BIT(8)
-#define OPTION_MPTCP_PRIO	BIT(9)
-#define OPTION_MPTCP_FASTCLOSE	BIT(10)
+#define OPTION_MPTCP_FASTCLOSE	BIT(9)
+#define OPTION_MPTCP_PRIO	BIT(10)
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
-- =

2.26.2

--===============8439383399262561575==--
