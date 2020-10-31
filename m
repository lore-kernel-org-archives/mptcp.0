Content-Type: multipart/mixed; boundary="===============5597036533499976706=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 04/10] mptcp: use adding up size
 when get ADD_ADDR length
Date: Sat, 31 Oct 2020 23:24:35 +0800
Message-ID: <a5a8cec61a9f5d072f8d1f212ac5ab0702fbfc57.1604156723.git.geliangtang@gmail.com>
In-Reply-To: 25b16158f8ec8521b79bec9ec20e142ce1623fde.1604156723.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6506

--===============5597036533499976706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch uses adding up size to get the ADD_ADDR suboption length rather
than returning the ADD_ADDR size constants.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f303c46bcc29..ad3fdec98fdc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -546,10 +546,14 @@ static inline bool mptcp_pm_should_rm_signal(struct m=
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
+		len +=3D 8; // Truncated HMAC
+
+	return len;
 }
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
-- =

2.26.2

--===============5597036533499976706==--
