Content-Type: multipart/mixed; boundary="===============1349979129582205662=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 04/12] mptcp: use adding up size
 to get ADD_ADDR length
Date: Thu, 05 Nov 2020 16:01:04 +0800
Message-ID: <4bc3b1864748e9e5bc54539a283145f2d6d93dda.1604562475.git.geliangtang@gmail.com>
In-Reply-To: ef72f5ac671b690ace2b15d6e3b2781cc8faefa5.1604562475.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6548

--===============1349979129582205662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch uses adding up size to get the ADD_ADDR suboption length rather
than returning the ADD_ADDR size constants.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f303c46bcc29..948992b1615f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -57,6 +57,7 @@
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE	20
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	24
 #define TCPOLEN_MPTCP_PORT_LEN		4
+#define TCPOLEN_MPTCP_ADD_ADDR_HMAC	8
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
 =

 /* MPTCP MP_JOIN flags */
@@ -546,10 +547,14 @@ static inline bool mptcp_pm_should_rm_signal(struct m=
ptcp_sock *msk)
 =

 static inline unsigned int mptcp_add_addr_len(int family, bool echo)
 {
-	if (family =3D=3D AF_INET)
-		return echo ? TCPOLEN_MPTCP_ADD_ADDR_BASE
-			    : TCPOLEN_MPTCP_ADD_ADDR;
-	return echo ? TCPOLEN_MPTCP_ADD_ADDR6_BASE : TCPOLEN_MPTCP_ADD_ADDR6;
+	u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
+
+	if (family =3D=3D AF_INET6)
+		len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+	if (!echo)
+		len +=3D TCPOLEN_MPTCP_ADD_ADDR_HMAC;
+
+	return len;
 }
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
-- =

2.26.2

--===============1349979129582205662==--
