Content-Type: multipart/mixed; boundary="===============4190994692507210814=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/4] mptcp: Move TCPOLEN #defines to protocol.h
Date: Thu, 13 Jun 2019 15:24:51 -0700
Message-ID: <20190613222454.10728-2-peter.krystad@linux.intel.com>
In-Reply-To: 20190613222454.10728-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1367

--===============4190994692507210814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Handle MPTCP TCP options

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/tcp.h    | 3 ---
 net/mptcp/protocol.h | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 80f6955add88..bea4a8416974 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -212,9 +212,6 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOLEN_MD5SIG_ALIGNED		20
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
-#define TCPOLEN_MPTCP_MPC_SYN		12
-#define TCPOLEN_MPTCP_MPC_SYNACK	20
-#define TCPOLEN_MPTCP_MPC_ACK		20
 #define TCPOLEN_MPTCP_DSS_BASE		4
 #define TCPOLEN_MPTCP_DSS_ACK32		4
 #define TCPOLEN_MPTCP_DSS_ACK64		8
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a4f0e7d3bd62..040aaa1011c6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -20,6 +20,11 @@
 #define MPTCPOPT_MP_FAIL	6
 #define MPTCPOPT_MP_FASTCLOSE	7
 =

+/* MPTCP suboption lengths */
+#define TCPOLEN_MPTCP_MPC_SYN		12
+#define TCPOLEN_MPTCP_MPC_SYNACK	20
+#define TCPOLEN_MPTCP_MPC_ACK		20
+
 #define MPTCPOPT_VERSION_MASK	0x0F
 =

 /* MPTCP handshake flags */
-- =

2.17.2


--===============4190994692507210814==--
