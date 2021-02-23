Content-Type: multipart/mixed; boundary="===============8253754409171600326=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 3/4] selftests: mptcp: add
 cfg_do_w for cfg_remove
Date: Tue, 23 Feb 2021 12:29:57 +0800
Message-ID: <d49a86c112c21d1ea98e0e9572cbda03fad6d8d0.1614053997.git.geliangtang@gmail.com>
In-Reply-To: 437320b247f2edc61b956f7251d903156e87c854.1614053997.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7910

--===============8253754409171600326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In some testcases, we need to slow down the transmitting process. This
patch added a new argument named cfg_do_w for cfg_remove to allow the
caller to pass an argument to cfg_remove.

In do_rnd_write, use this cfg_do_w to control the transmitting speed.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index 77bb62feb872..69d89b5d666f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -55,6 +55,7 @@ static int cfg_sndbuf;
 static int cfg_rcvbuf;
 static bool cfg_join;
 static bool cfg_remove;
+static unsigned int cfg_do_w;
 static int cfg_wait;
 =

 static void die_usage(void)
@@ -272,8 +273,8 @@ static size_t do_rnd_write(const int fd, char *buf, con=
st size_t len)
 	if (cfg_join && first && do_w > 100)
 		do_w =3D 100;
 =

-	if (cfg_remove && do_w > 50)
-		do_w =3D 50;
+	if (cfg_remove && do_w > cfg_do_w)
+		do_w =3D cfg_do_w;
 =

 	bw =3D write(fd, buf, do_w);
 	if (bw < 0)
@@ -829,7 +830,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 =

-	while ((c =3D getopt(argc, argv, "6jrlp:s:hut:m:S:R:w:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:")) !=3D -1) {
 		switch (c) {
 		case 'j':
 			cfg_join =3D true;
@@ -840,6 +841,9 @@ static void parse_opts(int argc, char **argv)
 			cfg_remove =3D true;
 			cfg_mode =3D CFG_MODE_POLL;
 			cfg_wait =3D 400000;
+			cfg_do_w =3D atoi(optarg);
+			if (cfg_do_w <=3D 0)
+				cfg_do_w =3D 50;
 			break;
 		case 'l':
 			listen_mode =3D true;
-- =

2.29.2

--===============8253754409171600326==--
