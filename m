Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0397E5CBE
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 22:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1665441210; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Fcs3FMyJm4S7SYi+NM5gfLlda97ufEXFLtg8mnYGCg4jnUD+SEqVYDE08AG9kmZRwZUyzs7QCvXxxcq9LAw4zyeYDaOC+lJuN04bO3lT+mm/VdV5gkYf5HUrqfN1TxqrLxiSdgt06mWfW+N2dbgyxBbK9b0h5D2YwjwIePuV3W0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1665441210; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=7m8spKlSqCiXNxuznskJITxqVk7gqo7bOtAWvoeCBDU=; 
	b=dOrlEUnY0iapFOxvb/gRHYU0gHjw2mqs2sfW3bbQm9Ms0SZJJa5tdbA1GCpPAHE/tXPakBI9aVouQ6MpuZe2idIX4mKxf7eFoJfT1d31oUvydD/MYDH6IDAOWvpNzM/eDLaIrmc8TfqBBEjcZEEr1PrgO0t27XiTUfGVak04Kqg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665441210;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=7m8spKlSqCiXNxuznskJITxqVk7gqo7bOtAWvoeCBDU=;
	b=RcMfdyM6/wZjk1U5xpqW/91hTEKdXfe8dolHjvz0OPP/gqaMqjsCKWkBicJYePkI
	QnSGJW8a2LpLUAIOqILiaYJADMu1IIHpXJcH1aZQIVncTQCj4LsXyqMPe5WfKhZTBn1
	cfrSpJYew0FaBJfSuwe8vN0rxa3By6TqIbDFEZ+M=
Received: from localhost.localdomain (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1665440307828843.5495417235318; Tue, 11 Oct 2022 00:18:27 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221010221809.1792-6-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v14 5/5] selftests: mptcp: mptfo Initiator/Listener
Date: Mon, 10 Oct 2022 22:18:09 +0000
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010221809.1792-1-dmytro@shytyi.net>
References: <20221010221809.1792-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

This patch adds the selftests support for mptfo in mptcp_connect.c,.sh
We introduce mptfo option, that sets "TCP_FASTOPEN" + "MSG_FASTOPEN"
We call sendto() instead of connect().

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 140 +++++++++++++-----
 .../selftests/net/mptcp/mptcp_connect.sh      |  77 ++++++++++
 2 files changed, 184 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/test=
ing/selftests/net/mptcp/mptcp_connect.c
index e54653ea2ed4..fdb934eb97ec 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -83,6 +83,7 @@ struct cfg_cmsg_types {
=20
 struct cfg_sockopt_types {
 =09unsigned int transparent:1;
+=09unsigned int mptfo:1;
 };
=20
 struct tcp_inq_state {
@@ -90,6 +91,7 @@ struct tcp_inq_state {
 =09bool expect_eof;
 };
=20
+static size_t do_write(const int fd, char *buf, const size_t len);
 static struct tcp_inq_state tcp_inq;
=20
 static struct cfg_cmsg_types cfg_cmsg_types;
@@ -232,6 +234,22 @@ static void set_transparent(int fd, int pf)
 =09}
 }
=20
+static void set_mptfo(int fd, int pf)
+{
+=09int qlen =3D 25;
+
+=09switch (pf) {
+=09case AF_INET:
+=09=09if (-1 =3D=3D setsockopt(fd, 6, TCP_FASTOPEN, &qlen, sizeof(qlen)))
+=09=09=09perror("TCP_FASTOPEN");
+=09=09break;
+=09case AF_INET6:
+=09=09if (-1 =3D=3D setsockopt(fd, 6, TCP_FASTOPEN, &qlen, sizeof(qlen)))
+=09=09=09perror("TCP_FASTOPEN");
+=09=09break;
+=09}
+}
+
 static int do_ulp_so(int sock, const char *name)
 {
 =09return setsockopt(sock, IPPROTO_TCP, TCP_ULP, name, strlen(name));
@@ -300,6 +318,9 @@ static int sock_listen_mptcp(const char * const listena=
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
@@ -330,13 +351,18 @@ static int sock_listen_mptcp(const char * const liste=
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
@@ -354,14 +380,33 @@ static int sock_connect_mptcp(const char * const remo=
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
+=09=09=09=09*woff =3D syn_copied;
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
@@ -571,13 +616,14 @@ static void shut_wr(int fd)
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
@@ -717,9 +763,9 @@ static int do_recvfile(int infd, int outfd)
 =09return (int)r;
 }
=20
-static int do_mmap(int infd, int outfd, unsigned int size)
+static int do_mmap(int infd, int outfd, unsigned int size, unsigned int sy=
n_off)
 {
-=09char *inbuf =3D mmap(NULL, size, PROT_READ, MAP_SHARED, infd, 0);
+=09char *inbuf =3D mmap(NULL, size, PROT_READ, MAP_SHARED, infd, syn_off);
 =09ssize_t ret =3D 0, off =3D 0;
 =09size_t rem;
=20
@@ -790,7 +836,7 @@ static int do_sendfile(int infd, int outfd, unsigned in=
t count)
 }
=20
 static int copyfd_io_mmap(int infd, int peerfd, int outfd,
-=09=09=09  unsigned int size, bool *in_closed_after_out)
+=09=09=09  unsigned int size, bool *in_closed_after_out, unsigned int woff=
)
 {
 =09int err;
=20
@@ -799,9 +845,9 @@ static int copyfd_io_mmap(int infd, int peerfd, int out=
fd,
 =09=09if (err)
 =09=09=09return err;
=20
-=09=09err =3D do_mmap(infd, peerfd, size);
+=09=09err =3D do_mmap(infd, peerfd, size, 0);
 =09} else {
-=09=09err =3D do_mmap(infd, peerfd, size);
+=09=09err =3D do_mmap(infd, peerfd, size - woff, woff);
 =09=09if (err)
 =09=09=09return err;
=20
@@ -839,7 +885,7 @@ static int copyfd_io_sendfile(int infd, int peerfd, int=
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
@@ -851,14 +897,14 @@ static int copyfd_io(int infd, int peerfd, int outfd,=
 bool close_peerfd)
=20
 =09switch (cfg_mode) {
 =09case CFG_MODE_POLL:
-=09=09ret =3D copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out);
+=09=09ret =3D copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out, wo=
ff);
 =09=09break;
=20
 =09case CFG_MODE_MMAP:
 =09=09file_size =3D get_infd_size(infd);
 =09=09if (file_size < 0)
 =09=09=09return file_size;
-=09=09ret =3D copyfd_io_mmap(infd, peerfd, outfd, file_size, &in_closed_af=
ter_out);
+=09=09ret =3D copyfd_io_mmap(infd, peerfd, outfd, file_size, &in_closed_af=
ter_out, woff);
 =09=09break;
=20
 =09case CFG_MODE_SENDFILE:
@@ -1033,7 +1079,7 @@ int main_loop_s(int listensock)
=20
 =09=09SOCK_TEST_TCPULP(remotesock, 0);
=20
-=09=09copyfd_io(fd, remotesock, 1, true);
+=09=09copyfd_io(fd, remotesock, 1, true, 0);
 =09} else {
 =09=09perror("accept");
 =09=09return 1;
@@ -1130,6 +1176,11 @@ static void parse_setsock_options(const char *name)
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
@@ -1168,24 +1219,28 @@ int main_loop(void)
 {
 =09int fd, ret, fd_in =3D 0;
 =09struct addrinfo *peer;
+=09unsigned int woff =3D 0;
=20
-=09/* listener is ready. */
-=09fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer);
-=09if (fd < 0)
-=09=09return 2;
+=09if (!cfg_sockopt_types.mptfo) {
+=09=09/* listener is ready. */
+=09=09fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer,=
 NULL, NULL);
+=09=09if (fd < 0)
+=09=09=09return 2;
+=09}
=20
 again:
-=09check_getpeername_connect(fd);
+=09if (!cfg_sockopt_types.mptfo) {
+=09=09check_getpeername_connect(fd);
=20
-=09SOCK_TEST_TCPULP(fd, cfg_sock_proto);
-
-=09if (cfg_rcvbuf)
-=09=09set_rcvbuf(fd, cfg_rcvbuf);
-=09if (cfg_sndbuf)
-=09=09set_sndbuf(fd, cfg_sndbuf);
-=09if (cfg_cmsg_types.cmsg_enabled)
-=09=09apply_cmsg_types(fd, &cfg_cmsg_types);
+=09=09SOCK_TEST_TCPULP(fd, cfg_sock_proto);
=20
+=09=09if (cfg_rcvbuf)
+=09=09=09set_rcvbuf(fd, cfg_rcvbuf);
+=09=09if (cfg_sndbuf)
+=09=09=09set_sndbuf(fd, cfg_sndbuf);
+=09=09if (cfg_cmsg_types.cmsg_enabled)
+=09=09=09apply_cmsg_types(fd, &cfg_cmsg_types);
+=09}
 =09if (cfg_input) {
 =09=09fd_in =3D open(cfg_input, O_RDONLY);
 =09=09if (fd < 0)
@@ -1193,7 +1248,26 @@ int main_loop(void)
 =09}
=20
 =09/* close the client socket open only if we are not going to reconnect *=
/
-=09ret =3D copyfd_io(fd_in, fd, 1, 0);
+
+=09if (cfg_sockopt_types.mptfo) {
+=09=09/* sendto() instead of connect */
+=09=09fd =3D sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer,=
 fd_in, &woff);
+=09=09if (fd < 0)
+=09=09=09return 2;
+=09}
+=09if (cfg_sockopt_types.mptfo) {
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
+=09ret =3D copyfd_io(fd_in, fd, 1, 0, woff);
 =09if (ret)
 =09=09return ret;
=20
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 621af6895f4d..d2328f94d1df 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -677,6 +677,58 @@ run_tests()
 =09run_tests_lo $1 $2 $3 0
 }
=20
+run_test_mptfo(){
+
+=09local listener_ns=3D"$1"
+=09local connector_ns=3D"$2"
+=09local connect_addr=3D"$3"
+=09local loopback=3D"$4"
+=09local extra_args=3D"$5"
+=09local msg=3D"$6"
+=09local lret=3D0
+
+=09ip netns exec "$listener_ns" sysctl -q net.ipv4.tcp_fastopen=3D2
+=09ip netns exec "$connector_ns" sysctl -q net.ipv4.tcp_fastopen=3D1
+
+=09# skip if test programs are running inside same netns for subsequent ru=
ns.
+=09if [ $loopback -eq 0 ] && [ ${listener_ns} =3D ${connector_ns} ]; then
+=09=09return 0
+=09fi
+
+=09# skip if we don't want v6
+=09if ! $ipv6 && is_v6 "${connect_addr}"; then
+=09=09return 0
+=09fi
+
+=09local local_addr
+=09if is_v6 "${connect_addr}"; then
+=09=09local_addr=3D"::"
+=09else
+=09=09local_addr=3D"0.0.0.0"
+=09fi
+
+
+
+=09TEST_COUNT=3D10000
+=09do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
+=09=09    ${connect_addr} ${local_addr} "${extra_args}"
+=09lret=3D$?
+
+=09if [ $lret -ne 0 ]; then
+=09=09echo "FAIL: $msg, mptcp connection error" 1>&2
+=09=09ret=3D$lret
+=09=09return 1
+=09fi
+
+=09echo "PASS: $msg"
+
+
+=09ip netns exec "$listener_ns" sysctl -q net.ipv4.tcp_fastopen=3D0
+=09ip netns exec "$connector_ns" sysctl -q net.ipv4.tcp_fastopen=3D0
+=09return 0
+
+}
+
 run_test_transparent()
 {
 =09local connect_addr=3D"$1"
@@ -906,6 +958,31 @@ run_test_transparent 10.0.3.1 "tproxy ipv4"
 run_test_transparent dead:beef:3::1 "tproxy ipv6"
 stop_if_error "Tests with tproxy have failed"
=20
+# MPTFO (MultiPath TCP Fatopen tests)
+
+for sender in $ns1 $ns2 $ns3 $ns4;do
+=09run_test_mptfo "$ns1" $sender 10.0.1.1 0 "-o MPTFO" "mptfoIPv4"
+=09run_test_mptfo "$ns1" $sender dead:beef:1::1 0 "-o MPTFO" "mptfoIPv6"
+
+=09run_test_mptfo "$ns2" $sender 10.0.1.2 0 "-o MPTFO" "mptfoIPv4"
+=09run_test_mptfo "$ns2" $sender dead:beef:1::2 0 "-o MPTFO" "mptfoIPv6"
+=09run_test_mptfo "$ns2" $sender 10.0.2.1 0 "-o MPTFO" "mptfoIPv4"
+=09run_test_mptfo "$ns2" $sender dead:beef:2::1 0 "-o MPTFO" "mptfoIPv6"
+
+=09run_test_mptfo "$ns3" $sender 10.0.2.2 0 "-o MPTFO" "mptfoIPv4"
+=09run_test_mptfo "$ns3" $sender dead:beef:2::2 0 "-o MPTFO" "mptfoIPv6"
+=09run_test_mptfo "$ns3" $sender 10.0.3.2 0 "-o MPTFO" "mptfoIPv4"
+=09run_test_mptfo "$ns3" $sender dead:beef:3::2 0 "-o MPTFO" "mptfoIPv6"
+
+=09run_test_mptfo "$ns4" $sender 10.0.3.1 0 "-o MPTFO" "mptfoIPv4"
+=09run_test_mptfo "$ns4" $sender dead:beef:3::1 0 "-o MPTFO" "mptfoIPv6"
+
+=09stop_if_error "Tests with $sender as a sender have failed"
+done
+#run_test_mptfo 10.0.3.1 "mptfoIPv4"
+#run_test_mptfo dead:beef:3::1 "mptfoIPv6"
+#stop_if_error "Tests with MPTFO have failed"
+
 run_tests_disconnect
=20
 display_time
--=20
2.34.1


