Content-Type: multipart/mixed; boundary="===============5244946299103267979=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 3/5] selftests: mptcp: drop first
 flag in do_rnd_write
Date: Thu, 13 Aug 2020 18:37:17 +0800
Message-ID: <561b16421ac47d37e8bb8fd302682d85648233d7.1597314634.git.geliangtang@gmail.com>
In-Reply-To: cover.1597314634.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5547

--===============5244946299103267979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch dropped the flag "first" in do_rnd_write to make RM_ADDR test
case work. Since we need to slow down not only the transfer process of
the first 100 bytes, but also all the transfer process of all data to let
the RM_ADDR suboption can be sent and received completely.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index 090620c3e10c..e48c00fc117d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -260,7 +260,6 @@ static int sock_connect_mptcp(const char * const remote=
addr,
 =

 static size_t do_rnd_write(const int fd, char *buf, const size_t len)
 {
-	static bool first =3D true;
 	unsigned int do_w;
 	ssize_t bw;
 =

@@ -268,7 +267,7 @@ static size_t do_rnd_write(const int fd, char *buf, con=
st size_t len)
 	if (do_w =3D=3D 0 || do_w > len)
 		do_w =3D len;
 =

-	if (cfg_join && first && do_w > 100)
+	if (cfg_join && do_w > 100)
 		do_w =3D 100;
 =

 	bw =3D write(fd, buf, do_w);
@@ -276,10 +275,8 @@ static size_t do_rnd_write(const int fd, char *buf, co=
nst size_t len)
 		perror("write");
 =

 	/* let the join handshake complete, before going on */
-	if (cfg_join && first) {
+	if (cfg_join)
 		usleep(200000);
-		first =3D false;
-	}
 =

 	return bw;
 }
-- =

2.17.1

--===============5244946299103267979==--
