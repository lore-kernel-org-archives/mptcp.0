Content-Type: multipart/mixed; boundary="===============6122697832708167228=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/4] pm: avoid endianness conversion warning
Date: Tue, 10 Sep 2019 01:17:25 +0200
Message-ID: <20190909231725.4952-5-fw@strlen.de>
In-Reply-To: 20190909231725.4952-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1811

--===============6122697832708167228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

pm.c:72:31: warning: incorrect type in assignment (different base types)
pm.c:72:31:    expected restricted __be32 [assigned] [usertype] s_addr
pm.c:72:31:    got unsigned long

squashto: mptcp: Implement path manager interface commands

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 57e13837ee22..c8d6341c9683 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -69,7 +69,7 @@ int pm_create_subflow(u32 token, u8 remote_id)
 =

 	local.sin_family =3D AF_INET;
 	local.sin_port =3D 0;
-	local.sin_addr.s_addr =3D INADDR_ANY;
+	local.sin_addr.s_addr =3D htonl(INADDR_ANY);
 =

 	remote.sin_family =3D msk->pm.remote_family;
 	remote.sin_port =3D htons(msk->dport);
-- =

2.21.0


--===============6122697832708167228==--
