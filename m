Content-Type: multipart/mixed; boundary="===============8743058127108612686=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 04/13] mptcp: use adding up size
 to get ADD_ADDR length
Date: Tue, 10 Nov 2020 13:14:52 +0800
Message-ID: <a0bac8194d4dbb934efe4d9bd078c649dcd2f014.1604984546.git.geliangtang@gmail.com>
In-Reply-To: 35189188e680590f632dc40519b8bc176d46dda8.1604984546.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6631

--===============8743058127108612686==
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

--===============8743058127108612686==--
