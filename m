Content-Type: multipart/mixed; boundary="===============8537070195641493708=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 01/19] tcp: Add MPTCP option number
Date: Tue, 05 Jun 2018 16:40:20 -0700
Message-ID: <20180605234038.28497-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180605234038.28497-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 643

--===============8537070195641493708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

TCP option 30 is allocated for MPTCP by the IANA.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/tcp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 029a51b91742..c8716de4547c 100644
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

2.17.1


--===============8537070195641493708==--
