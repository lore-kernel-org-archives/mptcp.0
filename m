Content-Type: multipart/mixed; boundary="===============2404168241724205328=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v9 mptcp-next 7/8] selftests: mptcp: add remove
 cfg in mptcp_connect
Date: Wed, 02 Sep 2020 17:38:29 +0800
Message-ID: <2ddf3bd7faa48f67600ed29f2da26260251bf81d.1599038897.git.geliangtang@gmail.com>
In-Reply-To: cover.1599038897.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5692

--===============2404168241724205328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new cfg, named cfg_remove in mptcp_connect. This new
cfg_remove is copied from cfg_join. The only difference between them is in
the do_rnd_write function. Here we slow down the transfer process of all
data to let the RM_ADDR suboption can be sent and received completely.
Otherwise the remove address and subflow test cases don't work.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../selftests/net/mptcp/mptcp_connect.c        | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index 090620c3e10c..6fee64e153d6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -54,6 +54,7 @@ static int pf =3D AF_INET;
 static int cfg_sndbuf;
 static int cfg_rcvbuf;
 static bool cfg_join;
+static bool cfg_remove;
 static int cfg_wait;
 =

 static void die_usage(void)
@@ -271,6 +272,9 @@ static size_t do_rnd_write(const int fd, char *buf, con=
st size_t len)
 	if (cfg_join && first && do_w > 100)
 		do_w =3D 100;
 =

+	if (cfg_remove && do_w > 50)
+		do_w =3D 50;
+
 	bw =3D write(fd, buf, do_w);
 	if (bw < 0)
 		perror("write");
@@ -281,6 +285,9 @@ static size_t do_rnd_write(const int fd, char *buf, con=
st size_t len)
 		first =3D false;
 	}
 =

+	if (cfg_remove)
+		usleep(200000);
+
 	return bw;
 }
 =

@@ -428,7 +435,7 @@ static int copyfd_io_poll(int infd, int peerfd, int out=
fd)
 	}
 =

 	/* leave some time for late join/announce */
-	if (cfg_join)
+	if (cfg_join || cfg_remove)
 		usleep(cfg_wait);
 =

 	close(peerfd);
@@ -686,7 +693,7 @@ static void maybe_close(int fd)
 {
 	unsigned int r =3D rand();
 =

-	if (!cfg_join && (r & 1))
+	if (!(cfg_join || cfg_remove) && (r & 1))
 		close(fd);
 }
 =

@@ -822,13 +829,18 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 =

-	while ((c =3D getopt(argc, argv, "6jlp:s:hut:m:S:R:w:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "6jrlp:s:hut:m:S:R:w:")) !=3D -1) {
 		switch (c) {
 		case 'j':
 			cfg_join =3D true;
 			cfg_mode =3D CFG_MODE_POLL;
 			cfg_wait =3D 400000;
 			break;
+		case 'r':
+			cfg_remove =3D true;
+			cfg_mode =3D CFG_MODE_POLL;
+			cfg_wait =3D 400000;
+			break;
 		case 'l':
 			listen_mode =3D true;
 			break;
-- =

2.17.1

--===============2404168241724205328==--
