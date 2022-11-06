Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4F28EC
	for <mptcp@lists.linux.dev>; Sun,  6 Nov 2022 15:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1667748274; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZAa/N68Tsi3gP2MtJpLIqPf3e4OxImpOJOJOEJZp9HXfHdAsoAIrjXoO55VMVVVt/9t7wA0VDZ9gNScnvMY8Utx/iqxurwwTMlAz81titANBoIZ2OfYHiCJZQsZC9vQgIjW15HiAqGj/HMg03dKZ/dLGhrYeJYoDeTPZGBAHJDY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1667748274; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=J3HXM8Itg6QZp4idplxxdPXA4VyuWF3eP1i47bCh7rk=; 
	b=fAmwU2V5nLRI/RaA+S9y7jqimlTrs+pMKaOtyA2pNV/sgUQp4Mn43ruPZUeWBZqQ9JfRbL5QAc1P+3Kr8aXBgbrmQM2Y7rjQC2GwA1vOTYNmX2BnjmfxUoXcPUf2e4N1bC5uc+rddXDeDAoPzrlBQsjUhO070EMcbKHfQtDmJ70=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1667748274;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=J3HXM8Itg6QZp4idplxxdPXA4VyuWF3eP1i47bCh7rk=;
	b=MgHEZk9uDvDrjH8buZPFZdShImy51eIw4ILn/DMx7MN5jk6YUBqyjLRSyy02y4bo
	9sHFh3f9iFnrnnpDzcPb/JPEbCk3Q4JbexstiTSjmth94XHvkIhk1Rv0pnIyfpWCh6C
	7/Tt0soFHpKVLe3/TUzM9NCqMCKUEAgW2HBCDt2w=
Received: from localhost.localdomain (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1667748272011923.596557633137; Sun, 6 Nov 2022 16:24:32 +0100 (CET)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221106152411.655-6-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v15 5/5] selftests: mptcp: mptfo Initiator/Listener
Date: Sun,  6 Nov 2022 15:24:11 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106152411.655-1-dmytro@shytyi.net>
References: <20221106152411.655-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

This patch adds the selftests support for mptfo in mptcp_connect.c
We introduce mptfo option, that sets "TCP_FASTOPEN" + "MSG_FASTOPEN"
We call sendto() instead of connect().

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 121 +++++++++++++-----
 .../selftests/net/mptcp/mptcp_connect.sh      |  21 +++
 2 files changed, 113 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index e54653ea2ed4..4bc855159c52 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -26,11 +26,13 @@
=20
 #include <netdb.h>
 #include <netinet/in.h>
+#include <netinet/tcp.h>
=20
-#include <linux/tcp.h>
 #include <linux/time_types.h>
 #include <linux/sockios.h>
=20
+
+
 extern int optind;
=20
 #ifndef IPPROTO_MPTCP
@@ -83,6 +85,7 @@ struct cfg_cmsg_types {
=20
 struct cfg_sockopt_types {
 =09unsigned int transparent:1;
+=09unsigned int mptfo:1;
 };
=20
 struct tcp_inq_state {
@@ -232,6 +235,14 @@ static void set_transparent(int fd, int pf)
 =09}
 }
=20
+static void set_mptfo(int fd, int pf)
+{
+=09int qlen =3D 25;
+
+=09if (setsockopt(fd, SOL_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen)) =3D=3D -=
1)
+=09=09perror("TCP_FASTOPEN");
+}
+
 static int do_ulp_so(int sock, const char *name)
 {
 =09return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
@@ -300,6 +311,9 @@ static int sock_listen_mptcp(const char * const listena=
ddr,
 =09=09if (cfg_sockopt_types.transparent)
 =09=09=09set_transparent(sock, pf);
=20
+=09=09if (cfg_sockopt_types.mptfo)
+=09=09=09set_mptfo(sock, pf);
+
 =09=09if (bind(sock, a->ai_addr, a->ai_addrlen) =3D=3D 0)
 =09=09=09break; /* success */
=20
@@ -330,13 +344,18 @@ static int sock_listen_mptcp(const char * const liste=
naddr,
=20
 static int sock_connect_mptcp(const char * const remoteaddr,
 =09=09=09      const char * const port, int proto,
-=09=09=09      struct addrinfo **peer)
+=09=09=09      struct addrinfo **peer,
+=09=09=09      int infd,
+=09=09=09      unsigned int *woff)
 {
 =09struct addrinfo hints =3D {
 =09=09.ai_protocol =3D IPPROTO_TCP,
 =09=09.ai_socktype =3D SOCK_STREAM,
 =09};
 =09struct addrinfo *a, *addr;
+=09unsigned int wlen =3D 0;
+=09int syn_copied =3D 0;
+=09char wbuf[8192];
 =09int sock =3D -1;
=20
 =09hints.ai_family =3D pf;
@@ -354,14 +373,33 @@ static int sock_connect_mptcp(const char * const remo=
teaddr,
 =09=09if (cfg_mark)
 =09=09=09set_mark(sock, cfg_mark);
=20
-=09=09if (connect(sock, a->ai_addr, a->ai_addrlen) =3D=3D 0) {
-=09=09=09*peer =3D a;
-=09=09=09break; /* success */
-=09=09}
+=09=09if (cfg_sockopt_types.mptfo) {
+=09=09=09if (wlen =3D=3D 0)
+=09=09=09=09wlen =3D read(infd, wbuf, sizeof(wbuf));
=20
-=09=09perror("connect()");
-=09=09close(sock);
-=09=09sock =3D -1;
+=09=09=09syn_copied =3D sendto(sock, wbuf, wlen, MSG_FASTOPEN,
+=09=09=09=09=09    a->ai_addr, a->ai_addrlen);
+=09=09=09if (syn_copied) {
+=09=09=09=09*woff =3D wlen;
+=09=09=09=09*peer =3D a;
+=09=09=09=09break; /* success */
+=09=09=09}
+=09=09} else {
+=09=09=09if (connect(sock, a->ai_addr, a->ai_addrlen) =3D=3D 0) {
+=09=09=09=09*peer =3D a;
+=09=09=09=09break; /* success */
+=09=09=09}
+=09=09}
+=09=09if (cfg_sockopt_types.mptfo) {
+=09=09=09perror("sendto()");
+=09=09=09close(sock);
+=09=09=09sock =3D -1;
+=09=09} else {
+
+=09=09=09perror("connect()");
+=09=09=09close(sock);
+=09=09=09sock =3D -1;
+=09=09}
 =09}
=20
 =09freeaddrinfo(addr);
@@ -571,13 +609,14 @@ static void shut_wr(int fd)
 =09shutdown(fd, SHUT_WR);
 }
=20
-static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed=
_after_out)
+static int copyfd_io_poll(int infd, int peerfd, int outfd,
+=09=09=09  bool *in_closed_after_out, unsigned int woff)
 {
 =09struct pollfd fds =3D {
 =09=09.fd =3D peerfd,
 =09=09.events =3D POLLIN | POLLOUT,
 =09};
-=09unsigned int woff =3D 0, wlen =3D 0, total_wlen =3D 0, total_rlen =3D 0=
;
+=09unsigned int wlen =3D 0, total_wlen =3D 0, total_rlen =3D 0;
 =09char wbuf[8192];
=20
 =09set_nonblock(peerfd, true);
@@ -839,7 +878,7 @@ static int copyfd_io_sendfile(int infd, int peerfd, int=
 outfd,
 =09return err;
 }
=20
-static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
+static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, u=
nsigned int woff)
 {
 =09bool in_closed_after_out =3D false;
 =09struct timespec start, end;
@@ -851,7 +890,7 @@ static int copyfd_io(int infd, int peerfd, int outfd, b=
ool close_peerfd)
=20
 =09switch (cfg_mode) {
 =09case CFG_MODE_POLL:
-=09=09ret =3D copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out);
+=09=09ret =3D copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out, wo=
ff);
 =09=09break;
=20
 =09case CFG_MODE_MMAP:
@@ -1033,7 +1072,7 @@ int main_loop_s(int listensock)
=20
 =09=09SOCK_TEST_TCPULP(remotesock, 0);
=20
-=09=09copyfd_io(fd, remotesock, 1, true);
+=09=09copyfd_io(fd, remotesock, 1, true, 0);
 =09} else {
 =09=09perror("accept");
 =09=09return 1;
@@ -1130,6 +1169,11 @@ static void parse_setsock_options(const char *name)
 =09=09return;
 =09}
=20
+=09if (strncmp(name, "MPTFO", len) =3D=3D 0) {
+=09=09cfg_sockopt_types.mptfo =3D 1;
+=09=09return;
+=09}
+
 =09fprintf(stderr, "Unrecognized setsockopt option %s\n", name);
 =09exit(1);
 }
@@ -1168,23 +1212,25 @@ int main_loop(void)
 {
 =09int fd, ret, fd_in =3D 0;
 =09struct addrinfo *peer;
+=09unsigned int woff =3D 0;
=20
-=09/* listener is ready. */
-=09fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer);
-=09if (fd < 0)
-=09=09return 2;
-
+=09if (!cfg_sockopt_types.mptfo) {
+=09=09/* listener is ready. */
+=09=09fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer,=
 0, 0);
+=09=09if (fd < 0)
+=09=09=09return 2;
 again:
-=09check_getpeername_connect(fd);
+=09=09check_getpeername_connect(fd);
=20
-=09SOCK_TEST_TCPULP(fd, cfg_sock_proto);
+=09=09SOCK_TEST_TCPULP(fd, cfg_sock_proto);
=20
-=09if (cfg_rcvbuf)
-=09=09set_rcvbuf(fd, cfg_rcvbuf);
-=09if (cfg_sndbuf)
-=09=09set_sndbuf(fd, cfg_sndbuf);
-=09if (cfg_cmsg_types.cmsg_enabled)
-=09=09apply_cmsg_types(fd, &cfg_cmsg_types);
+=09=09if (cfg_rcvbuf)
+=09=09=09set_rcvbuf(fd, cfg_rcvbuf);
+=09=09if (cfg_sndbuf)
+=09=09=09set_sndbuf(fd, cfg_sndbuf);
+=09=09if (cfg_cmsg_types.cmsg_enabled)
+=09=09=09apply_cmsg_types(fd, &cfg_cmsg_types);
+=09}
=20
 =09if (cfg_input) {
 =09=09fd_in =3D open(cfg_input, O_RDONLY);
@@ -1192,8 +1238,25 @@ int main_loop(void)
 =09=09=09xerror("can't open %s:%d", cfg_input, errno);
 =09}
=20
-=09/* close the client socket open only if we are not going to reconnect *=
/
-=09ret =3D copyfd_io(fd_in, fd, 1, 0);
+=09if (cfg_sockopt_types.mptfo) {
+=09=09/* sendto() instead of connect */
+=09=09fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer,=
 fd_in, &woff);
+=09=09if (fd < 0)
+=09=09=09return 2;
+
+=09=09check_getpeername_connect(fd);
+
+=09=09SOCK_TEST_TCPULP(fd, cfg_sock_proto);
+
+=09=09if (cfg_rcvbuf)
+=09=09=09set_rcvbuf(fd, cfg_rcvbuf);
+=09=09if (cfg_sndbuf)
+=09=09=09set_sndbuf(fd, cfg_sndbuf);
+=09=09if (cfg_cmsg_types.cmsg_enabled)
+=09=09=09apply_cmsg_types(fd, &cfg_cmsg_types);
+=09}
+
+=09ret =3D copyfd_io(fd_in, fd, 1, 0, 0);
 =09if (ret)
 =09=09return ret;
=20
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 621af6895f4d..60198b91a530 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -762,6 +762,23 @@ run_tests_peekmode()
 =09run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
 }
=20
+run_tests_mptfo()
+{
+=09echo "INFO: with MPTFO start"
+=09ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=3D2
+=09ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=3D1
+
+=09run_tests_lo "$ns1" "$ns2" 10.0.1.1 0 "-o MPTFO"
+=09run_tests_lo "$ns1" "$ns2" 10.0.1.1 0 "-o MPTFO"
+
+=09run_tests_lo "$ns1" "$ns2" dead:beef:1::1 0 "-o MPTFO"
+=09run_tests_lo "$ns1" "$ns2" dead:beef:1::1 0 "-o MPTFO"
+
+=09ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=3D0
+=09ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=3D0
+=09echo "INFO: with MPTFO end"
+}
+
 run_tests_disconnect()
 {
 =09local peekmode=3D"$1"
@@ -901,6 +918,10 @@ run_tests_peekmode "saveWithPeek"
 run_tests_peekmode "saveAfterPeek"
 stop_if_error "Tests with peek mode have failed"
=20
+# MPTFO (MultiPath TCP Fatopen tests)
+run_tests_mptfo
+stop_if_error "Tests with MPTFO have failed"
+
 # connect to ns4 ip address, ns2 should intercept/proxy
 run_test_transparent 10.0.3.1 "tproxy ipv4"
 run_test_transparent dead:beef:3::1 "tproxy ipv6"
--=20
2.34.1


