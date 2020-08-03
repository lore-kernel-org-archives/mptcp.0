Content-Type: multipart/mixed; boundary="===============8879201570932750317=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Allow ip mptcp endpoint show
Date: Mon, 03 Aug 2020 10:10:10 -0700
Message-ID: <20200803171010.4375-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 5448

--===============8879201570932750317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The intention was to dump the entire address-list when no ID is given.
However, the condition needs to rather check on argc as argv will always
be !=3D NULL.

Fixes: 7e0767cd862b ("add support for mptcp netlink interface")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 ip/ipmptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index bc12418bd39c..df38754c82b6 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -273,7 +273,7 @@ static int mptcp_addr_show(int argc, char **argv)
 	struct nlmsghdr *answer;
 	int ret;
 =

-	if (!argv)
+	if (argc =3D=3D 0)
 		return mptcp_addr_dump();
 =

 	ret =3D mptcp_parse_opt(argc, argv, &req.n, false);
-- =

2.23.0

--===============8879201570932750317==--
