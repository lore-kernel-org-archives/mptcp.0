Content-Type: multipart/mixed; boundary="===============3094727350969247993=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/4] mptcp: Move TCPOLEN #defines to protocol.h
Date: Thu, 13 Jun 2019 15:24:53 -0700
Message-ID: <20190613222454.10728-4-peter.krystad@linux.intel.com>
In-Reply-To: 20190613222454.10728-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1369

--===============3094727350969247993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Implement MTPCP receive path

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/tcp.h    | 2 --
 net/mptcp/protocol.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ca4b799f4604..ef93bb4cb733 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -212,8 +212,6 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOLEN_MD5SIG_ALIGNED		20
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
-#define TCPOLEN_MPTCP_DSS_ACK32		4
-#define TCPOLEN_MPTCP_DSS_MAP32		10
 =

 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f4c69acc3ca5..2393d2194d28 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -25,7 +25,9 @@
 #define TCPOLEN_MPTCP_MPC_SYNACK	20
 #define TCPOLEN_MPTCP_MPC_ACK		20
 #define TCPOLEN_MPTCP_DSS_BASE		4
+#define TCPOLEN_MPTCP_DSS_ACK32		4
 #define TCPOLEN_MPTCP_DSS_ACK64		8
+#define TCPOLEN_MPTCP_DSS_MAP32		10
 #define TCPOLEN_MPTCP_DSS_MAP64		14
 #define TCPOLEN_MPTCP_DSS_CHECKSUM	2
 =

-- =

2.17.2


--===============3094727350969247993==--
