Content-Type: multipart/mixed; boundary="===============5748762706418590987=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/4] mptcp: Move TCPOLEN #defines to protocol.h
Date: Thu, 13 Jun 2019 15:24:52 -0700
Message-ID: <20190613222454.10728-3-peter.krystad@linux.intel.com>
In-Reply-To: 20190613222454.10728-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1368

--===============5748762706418590987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Write MTPCP DSS headers....

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/tcp.h    | 4 ----
 net/mptcp/protocol.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index bea4a8416974..ca4b799f4604 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -212,12 +212,8 @@ void tcp_time_wait(struct sock *sk, int state, int tim=
eo);
 #define TCPOLEN_MD5SIG_ALIGNED		20
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
-#define TCPOLEN_MPTCP_DSS_BASE		4
 #define TCPOLEN_MPTCP_DSS_ACK32		4
-#define TCPOLEN_MPTCP_DSS_ACK64		8
 #define TCPOLEN_MPTCP_DSS_MAP32		10
-#define TCPOLEN_MPTCP_DSS_MAP64		14
-#define TCPOLEN_MPTCP_DSS_CHECKSUM	2
 =

 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 040aaa1011c6..f4c69acc3ca5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -24,6 +24,10 @@
 #define TCPOLEN_MPTCP_MPC_SYN		12
 #define TCPOLEN_MPTCP_MPC_SYNACK	20
 #define TCPOLEN_MPTCP_MPC_ACK		20
+#define TCPOLEN_MPTCP_DSS_BASE		4
+#define TCPOLEN_MPTCP_DSS_ACK64		8
+#define TCPOLEN_MPTCP_DSS_MAP64		14
+#define TCPOLEN_MPTCP_DSS_CHECKSUM	2
 =

 #define MPTCPOPT_VERSION_MASK	0x0F
 =

-- =

2.17.2


--===============5748762706418590987==--
