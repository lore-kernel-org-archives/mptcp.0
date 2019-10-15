Content-Type: multipart/mixed; boundary="===============0036251224900048535=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/5] mptcp: Add missing ADD_ADDR handling
Date: Tue, 15 Oct 2019 16:06:10 -0700
Message-ID: <20191015230613.16981-3-peter.krystad@linux.intel.com>
In-Reply-To: 20191015230613.16981-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2158

--===============0036251224900048535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add missing piece that copies IPv6 address into TCP option

squashto: Add ADD_ADDR handling

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/options.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4bb3766fce5e..a63137b73557 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -463,14 +463,22 @@ static bool mptcp_established_options_addr(struct soc=
k *sk,
 	if (mptcp_pm_addr_signal(msk, &id, &saddr))
 		return false;
 =

-	if (saddr.ss_family =3D=3D AF_INET && remaining < TCPOLEN_MPTCP_ADD_ADDR)
-		return false;
-
-	opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
-	opts->addr_id =3D id;
-	opts->addr.s_addr =3D ((struct sockaddr_in *)&saddr)->sin_addr.s_addr;
-	*size =3D TCPOLEN_MPTCP_ADD_ADDR;
-
+	if (saddr.ss_family =3D=3D AF_INET) {
+		if (remaining < TCPOLEN_MPTCP_ADD_ADDR)
+			return false;
+		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
+		opts->addr_id =3D id;
+		opts->addr =3D ((struct sockaddr_in *)&saddr)->sin_addr;
+		*size =3D TCPOLEN_MPTCP_ADD_ADDR;
+	}
+	if (saddr.ss_family =3D=3D AF_INET6) {
+		if (remaining < TCPOLEN_MPTCP_ADD_ADDR6)
+			return false;
+		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
+		opts->addr_id =3D id;
+		opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
+		*size =3D TCPOLEN_MPTCP_ADD_ADDR6;
+	}
 	msk->addr_signal =3D 0;
 =

 	return true;
-- =

2.17.2

--===============0036251224900048535==--
