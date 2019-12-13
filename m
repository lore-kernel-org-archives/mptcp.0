Content-Type: multipart/mixed; boundary="===============6482595267697228840=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 04/11] tcp: Add MPTCP option number
Date: Fri, 13 Dec 2019 15:00:15 -0800
Message-ID: <20191213230022.28144-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191213230022.28144-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3038

--===============6482595267697228840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

TCP option 30 is allocated for MPTCP by the IANA.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/tcp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 86b9a8766648..d4b6bf2c5d3c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -182,6 +182,7 @@ void tcp_time_wait(struct sock *sk, int state, int time=
o);
 #define TCPOPT_SACK             5       /* SACK Block */
 #define TCPOPT_TIMESTAMP	8	/* Better RTT estimations/PAWS */
 #define TCPOPT_MD5SIG		19	/* MD5 Signature (RFC2385) */
+#define TCPOPT_MPTCP		30	/* Multipath TCP (RFC6824) */
 #define TCPOPT_FASTOPEN		34	/* Fast open (RFC7413) */
 #define TCPOPT_EXP		254	/* Experimental */
 /* Magic number to be after the option value for sharing TCP
-- =

2.24.1

--===============6482595267697228840==--
