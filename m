Content-Type: multipart/mixed; boundary="===============4951639738188919532=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v6 04/11] tcp: Add MPTCP option number
Date: Tue, 07 Jan 2020 17:19:14 -0800
Message-ID: <20200108011921.28942-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200108011921.28942-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3275

--===============4951639738188919532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

TCP option 30 is allocated for MPTCP by the IANA.

Reviewed-by: Eric Dumazet <edumazet(a)google.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/tcp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7df37e2fddca..85f1d7ff6e8b 100644
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

--===============4951639738188919532==--
