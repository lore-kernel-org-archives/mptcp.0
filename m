Content-Type: multipart/mixed; boundary="===============7392817367861534858=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 2/9] selftests: mptcp: add accept/getpeer checks
Date: Fri, 25 Oct 2019 14:16:44 +0200
Message-ID: <20191025121651.25946-3-fw@strlen.de>
In-Reply-To: 20191025121651.25946-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2312

--===============7392817367861534858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check that the result coming from accept matches that of getpeername.
For initiator side, check getpeername matches address passed to connect().

At this time, kernel returns the address of the first subflow in the list.
Right now, we do not yet implement fate-sharing, i.e. if the original
subflow goes away, the result of getpeername would change.

There are different ways to fix that.  One would be to copy the quadruple
from the first subflow socket to the mptcp socket.

If we do that, this test should catch a possible bug (such as accidental
reversal of saddr/daddr).

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index 987a8411756e..c9738a8dcc7f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -54,6 +54,21 @@ static const char *getxinfo_strerr(int err)
 	return gai_strerror(err);
 }
 =

+static void xgetnameinfo(const struct sockaddr *addr, socklen_t addrlen,
+			 char *host, socklen_t hostlen,
+			 char *serv, socklen_t servlen)
+{
+	int flags =3D NI_NUMERICHOST | NI_NUMERICSERV;
+	int err =3D getnameinfo(addr, addrlen, host, hostlen, serv, servlen, flag=
s);
+
+	if (err) {
+		const char *errstr =3D getxinfo_strerr(err);
+
+		fprintf(stderr, "Fatal: getnameinfo: %s\n", errstr);
+		exit(1);
+	}
+}
+
 static void xgetaddrinfo(const char *node, const char *service,
 			 const struct addrinfo *hints,
 			 struct addrinfo **res)
@@ -327,6 +342,94 @@ static int copyfd_io(int infd, int peerfd, int outfd)
 	return 0;
 }
 =

+static void check_sockaddr(int pf, struct sockaddr_storage *ss,
+			   socklen_t salen)
+{
+	char addr[INET6_ADDRSTRLEN];
+	char serv[INET6_ADDRSTRLEN];
+	struct sockaddr_in6 *sin6;
+	struct sockaddr_in *sin;
+	int wanted_size =3D 0;
+
+	switch (pf) {
+	case AF_INET:
+		wanted_size =3D sizeof(*sin);
+		sin =3D (void *)ss;
+		if (!sin->sin_port)
+			fprintf(stderr, "accept: something wrong: ip connection from port 0");
+		break;
+	case AF_INET6:
+		wanted_size =3D sizeof(*sin6);
+		sin6 =3D (void *)ss;
+		if (!sin6->sin6_port)
+			fprintf(stderr, "accept: something wrong: ipv6 connection from port 0");
+		break;
+	default:
+		fprintf(stderr, "accept: Unknown pf %d, salen %u\n", pf, salen);
+		return;
+	}
+
+	if (salen !=3D wanted_size)
+		fprintf(stderr, "accept: size mismatch, got %d expected %d\n",
+				(int)salen, wanted_size);
+
+	if (ss->ss_family !=3D pf)
+		fprintf(stderr, "accept: pf mismatch, expect %d, ss_family is %d\n",
+				(int)ss->ss_family, pf);
+}
+
+static void check_getpeername(int fd, struct sockaddr_storage *ss, socklen=
_t salen)
+{
+	struct sockaddr_storage peerss;
+	socklen_t peersalen =3D sizeof(peerss);
+
+	if (getpeername(fd, (struct sockaddr *)&peerss, &peersalen) < 0) {
+		perror("getpeername");
+		return;
+	}
+
+	if (peersalen !=3D salen) {
+		fprintf(stderr, "%s: %d vs %d\n", __func__, peersalen, salen);
+		return;
+	}
+
+	if (memcmp(ss, &peerss, peersalen)) {
+		char a[INET6_ADDRSTRLEN];
+		char b[INET6_ADDRSTRLEN];
+		char c[INET6_ADDRSTRLEN];
+		char d[INET6_ADDRSTRLEN];
+
+		xgetnameinfo((struct sockaddr *)ss, salen,
+			     a, sizeof(a), b, sizeof(b));
+
+		xgetnameinfo((struct sockaddr *)&peerss, peersalen,
+			     c, sizeof(c), d, sizeof(d));
+
+		fprintf(stderr, "%s: memcmp failure: accept %s vs peername %s, %s vs %s =
salen %d vs %d\n",
+			__func__, a, c, b, d, peersalen, salen);
+	}
+}
+
+static void check_getpeername_connect(int fd)
+{
+	struct sockaddr_storage ss;
+	socklen_t salen =3D sizeof(ss);
+	char a[INET6_ADDRSTRLEN];
+	char b[INET6_ADDRSTRLEN];
+
+	if (getpeername(fd, (struct sockaddr *)&ss, &salen) < 0) {
+		perror("getpeername");
+		return;
+	}
+
+	xgetnameinfo((struct sockaddr *)&ss, salen,
+		     a, sizeof(a), b, sizeof(b));
+
+	if (strcmp(cfg_host, a) || strcmp(cfg_port, b))
+		fprintf(stderr, "%s: %s vs %s, %s vs %s\n", __func__,
+			cfg_host, a, cfg_port, b);
+}
+
 int main_loop_s(int listensock)
 {
 	struct sockaddr_storage ss;
@@ -350,6 +453,9 @@ int main_loop_s(int listensock)
 	salen =3D sizeof(ss);
 	remotesock =3D accept(listensock, (struct sockaddr *)&ss, &salen);
 	if (remotesock >=3D 0) {
+		check_sockaddr(pf, &ss, salen);
+		check_getpeername(remotesock, &ss, salen);
+
 		copyfd_io(0, remotesock, 1);
 		return 0;
 	}
@@ -384,6 +490,7 @@ int main_loop(void)
 	if (fd < 0)
 		return 2;
 =

+	check_getpeername_connect(fd);
 	return copyfd_io(0, fd, 1);
 }
 =

-- =

2.23.0

--===============7392817367861534858==--
