Content-Type: multipart/mixed; boundary="===============6692347069714722963=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] mptcp: fix mistake in path manager interface
Date: Mon, 21 Oct 2019 16:41:50 -0700
Message-ID: <20191021234152.3091-2-peter.krystad@linux.intel.com>
In-Reply-To: 20191021234152.3091-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2244

--===============6692347069714722963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Do not de-reference NULL pointer immediately after confirming it
is NULL.

squashto:  Implement path manager interface commands

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f521bf0c5f69..d45406bc3f6c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -95,7 +95,7 @@ int mptcp_pm_create_subflow(u32 token, u8 remote_id, stru=
ct in_addr *addr)
 =

 	local.sin_family =3D AF_INET;
 	local.sin_port =3D 0;
-	if (!addr)
+	if (addr)
 		local.sin_addr =3D *addr;
 	else
 		local.sin_addr.s_addr =3D htonl(INADDR_ANY);
@@ -133,7 +133,7 @@ int mptcp_pm_create_subflow6(u32 token, u8 remote_id, s=
truct in6_addr *addr)
 =

 	local.sin6_family =3D AF_INET6;
 	local.sin6_port =3D 0;
-	if (!addr)
+	if (addr)
 		local.sin6_addr =3D *addr;
 	else
 		local.sin6_addr =3D in6addr_any;
-- =

2.17.2

--===============6692347069714722963==--
