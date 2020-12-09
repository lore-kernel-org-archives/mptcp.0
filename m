Content-Type: multipart/mixed; boundary="===============2774713160400767124=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 04/11] mptcp: use adding up size to get
 ADD_ADDR length
Date: Wed, 09 Dec 2020 15:51:21 -0800
Message-ID: <20201209235128.175473-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201209235128.175473-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7110

--===============2774713160400767124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch uses adding up size to get the ADD_ADDR suboption length rather
than returning the ADD_ADDR size constants.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 987046d9d1d4..5c45aabf4c6a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -578,10 +578,14 @@ static inline bool mptcp_pm_should_rm_signal(struct m=
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
+		len +=3D MPTCPOPT_THMAC_LEN;
+
+	return len;
 }
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
-- =

2.29.2

--===============2774713160400767124==--
