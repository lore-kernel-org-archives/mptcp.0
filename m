Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6320D2C85
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636647719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwZxe52rOthBvfSd6KYvhMJ8WUuYSspU9JmRzdKaAKU=;
	b=Kng5kW8wXtDaQgRoP/GE2WcyseOulS0gU/yQyeJyO69/74hhKHZ3c8MpciYS1lg6oBQ9st
	bYPPxDnkFjkrZKnbkeNj+XV4uNFgUuXycM/S6CbAhPSs+rBd8SEUij/Jd/XsgWiknS8V0B
	rpK0AOUB67lOwP0oQkiKmQwYDKLH2x4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-MJHx_L_xPly7MzozVA7jbw-1; Thu, 11 Nov 2021 11:21:57 -0500
X-MC-Unique: MJHx_L_xPly7MzozVA7jbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E54B481C85E
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:56 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5100F5D6B1
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 7/7] mptcp: add disconnect selftests
Date: Thu, 11 Nov 2021 17:21:42 +0100
Message-Id: <75114dbd18fd261084d7d504103787dd3d9ae255.1636647623.git.pabeni@redhat.com>
In-Reply-To: <cover.1636647623.git.pabeni@redhat.com>
References: <cover.1636647623.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Performs several disconnect/reconnect on the same socket,
ensuring the overall transfer is succesful.

The new test leverages ioctl(SIOCOUTQ) to ensure all the
pending data is acked before disconnecting.

Additionally order alphabetically the test program arguments list
for better maintainability.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
notes:
- v1 -> v2:
  - updated usage, re-ordered args
- this is on top of Florian's patches
---
 .../selftests/net/mptcp/mptcp_connect.c       | 148 +++++++++++++++---
 .../selftests/net/mptcp/mptcp_connect.sh      |  39 ++++-
 2 files changed, 160 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index e3e4338d610f..61abf98e897e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -16,6 +16,7 @@
 #include <unistd.h>
 #include <time.h>
 
+#include <sys/ioctl.h>
 #include <sys/poll.h>
 #include <sys/sendfile.h>
 #include <sys/stat.h>
@@ -28,6 +29,7 @@
 
 #include <linux/tcp.h>
 #include <linux/time_types.h>
+#include <linux/sockios.h>
 
 extern int optind;
 
@@ -69,6 +71,8 @@ static unsigned int cfg_time;
 static unsigned int cfg_do_w;
 static int cfg_wait;
 static uint32_t cfg_mark;
+static char *cfg_input = NULL;
+static int cfg_repeat = 1;
 
 struct cfg_cmsg_types {
 	unsigned int cmsg_enabled:1;
@@ -92,23 +96,32 @@ static struct cfg_sockopt_types cfg_sockopt_types;
 
 static void die_usage(void)
 {
-	fprintf(stderr, "Usage: mptcp_connect [-6] [-u] [-s MPTCP|TCP] [-p port] [-m mode]"
-		"[-l] [-w sec] [-t num] [-T num] connect_address\n");
+	fprintf(stderr, "Usage: mptcp_connect [-6] [-c cmsg] [-i file] [-I num] [-j] [-l] "
+		"[-m mode] [-M mark] [-o option] [-p port] [-P mode] [-j] [-l] [-r num] "
+		"[-s MPTCP|TCP] [-S num] [-r num] [-t num] [-T num] [-u] [-w sec] connect_address\n");
 	fprintf(stderr, "\t-6 use ipv6\n");
+	fprintf(stderr, "\t-c cmsg -- test cmsg type <cmsg>\n");
+	fprintf(stderr, "\t-i file -- read the data to send from the given file instead of stdin");
+	fprintf(stderr, "\t-I num -- repeat the transfer 'num' times. In listen mode accepts num "
+		"incoming connections, in client mode, disconnect and reconnect to the server\n");
+	fprintf(stderr, "\t-j     -- add additional sleep at connection start and tear down"
+		"-- for MPJ tests\n");
+	fprintf(stderr, "\t-l     -- listens mode, accepts incoming connection\n");
+	fprintf(stderr, "\t-m [poll|mmap|sendfile] -- use poll(default)/mmap+write/sendfile\n");
+	fprintf(stderr, "\t-M mark -- set socket packet mark\n");
+	fprintf(stderr, "\t-o option -- test sockopt <option>\n");
+	fprintf(stderr, "\t-p num -- use port num\n");
+	fprintf(stderr,
+		"\t-P [saveWithPeek|saveAfterPeek] -- save data with/after MSG_PEEK form tcp socket\n");
 	fprintf(stderr, "\t-t num -- set poll timeout to num\n");
 	fprintf(stderr, "\t-T num -- set expected runtime to num ms\n");
-	fprintf(stderr, "\t-S num -- set SO_SNDBUF to num\n");
+	fprintf(stderr, "\t-r num -- enable slow mode, limiting each write to num bytes"
+		"- for remove addr tests\n");
 	fprintf(stderr, "\t-R num -- set SO_RCVBUF to num\n");
-	fprintf(stderr, "\t-p num -- use port num\n");
 	fprintf(stderr, "\t-s [MPTCP|TCP] -- use mptcp(default) or tcp sockets\n");
-	fprintf(stderr, "\t-m [poll|mmap|sendfile] -- use poll(default)/mmap+write/sendfile\n");
-	fprintf(stderr, "\t-M mark -- set socket packet mark\n");
+	fprintf(stderr, "\t-S num -- set SO_SNDBUF to num\n");
 	fprintf(stderr, "\t-u -- check mptcp ulp\n");
 	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
-	fprintf(stderr, "\t-c cmsg -- test cmsg type <cmsg>\n");
-	fprintf(stderr, "\t-o option -- test sockopt <option>\n");
-	fprintf(stderr,
-		"\t-P [saveWithPeek|saveAfterPeek] -- save data with/after MSG_PEEK form tcp socket\n");
 	exit(1);
 }
 
@@ -307,7 +320,8 @@ static bool sock_test_tcpulp(const char * const remoteaddr,
 }
 
 static int sock_connect_mptcp(const char * const remoteaddr,
-			      const char * const port, int proto)
+			      const char * const port, int proto,
+			      struct addrinfo **peer)
 {
 	struct addrinfo hints = {
 		.ai_protocol = IPPROTO_TCP,
@@ -329,8 +343,10 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 		if (cfg_mark)
 			set_mark(sock, cfg_mark);
 
-		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0)
+		if (connect(sock, a->ai_addr, a->ai_addrlen) == 0) {
+			*peer = a;
 			break; /* success */
+		}
 
 		perror("connect()");
 		close(sock);
@@ -513,14 +529,17 @@ static ssize_t do_rnd_read(const int fd, char *buf, const size_t len)
 	return ret;
 }
 
-static void set_nonblock(int fd)
+static void set_nonblock(int fd, bool nonblock)
 {
 	int flags = fcntl(fd, F_GETFL);
 
 	if (flags == -1)
 		return;
 
-	fcntl(fd, F_SETFL, flags | O_NONBLOCK);
+	if (nonblock)
+		fcntl(fd, F_SETFL, flags | O_NONBLOCK);
+	else
+		fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);
 }
 
 static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after_out)
@@ -532,7 +551,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 	unsigned int woff = 0, wlen = 0;
 	char wbuf[8192];
 
-	set_nonblock(peerfd);
+	set_nonblock(peerfd, true);
 
 	for (;;) {
 		char rbuf[8192];
@@ -627,7 +646,6 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 	if (cfg_remove)
 		usleep(cfg_wait);
 
-	close(peerfd);
 	return 0;
 }
 
@@ -769,7 +787,7 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 	return err;
 }
 
-static int copyfd_io(int infd, int peerfd, int outfd)
+static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd)
 {
 	bool in_closed_after_out = false;
 	struct timespec start, end;
@@ -808,6 +826,9 @@ static int copyfd_io(int infd, int peerfd, int outfd)
 	if (ret)
 		return ret;
 
+	if (close_peerfd)
+		close(peerfd);
+
 	if (cfg_time) {
 		unsigned int delta_ms;
 
@@ -919,7 +940,7 @@ static void maybe_close(int fd)
 {
 	unsigned int r = rand();
 
-	if (!(cfg_join || cfg_remove) && (r & 1))
+	if (!(cfg_join || cfg_remove || (cfg_repeat > 1)) && (r & 1))
 		close(fd);
 }
 
@@ -929,7 +950,9 @@ int main_loop_s(int listensock)
 	struct pollfd polls;
 	socklen_t salen;
 	int remotesock;
+	int fd = 0;
 
+again:
 	polls.fd = listensock;
 	polls.events = POLLIN;
 
@@ -950,12 +973,25 @@ int main_loop_s(int listensock)
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
-		return copyfd_io(0, remotesock, 1);
+		if (cfg_input) {
+			fd = open(cfg_input, O_RDONLY);
+			if (fd < 0)
+				xerror("can't open %s: %d", cfg_input, errno);
+		}
+
+		copyfd_io(fd, remotesock, 1, true);
+	} else {
+		perror("accept");
+		return 1;
 	}
 
-	perror("accept");
+	if (--cfg_repeat > 0) {
+		if (cfg_input)
+			close(fd);
+		goto again;
+	}
 
-	return 1;
+	return 0;
 }
 
 static void init_rng(void)
@@ -1044,15 +1080,47 @@ static void parse_setsock_options(const char *name)
 	exit(1);
 }
 
+void xdisconnect(int fd, int addrlen)
+{
+	struct sockaddr_storage empty;
+	int msec_sleep = 10;
+	int queued = 1;
+	int i;
+
+	shutdown(fd, SHUT_WR);
+
+	/* while until the pending data is completely flushed, the later
+	 * disconnect will bypass/ingore/drop any pending data.
+	 */
+	for (i = 0; ; i += msec_sleep) {
+		if (ioctl(fd, SIOCOUTQ, &queued) < 0)
+			xerror("can't query out socket queue: %d", errno);
+
+		if (!queued)
+			break;
+
+		if (i > poll_timeout)
+			xerror("timeout while wating for spool to complete");
+		usleep(msec_sleep * 1000);
+	}
+
+	memset(&empty, 0, sizeof(empty));
+	empty.ss_family = AF_UNSPEC;
+	if (connect(fd, (struct sockaddr *)&empty, addrlen) < 0)
+		xerror("can't disconnect: %d", errno);
+}
+
 int main_loop(void)
 {
-	int fd;
+	int fd, ret, fd_in = 0;
+	struct addrinfo *peer;
 
 	/* listener is ready. */
-	fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto);
+	fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer);
 	if (fd < 0)
 		return 2;
 
+again:
 	check_getpeername_connect(fd);
 
 	if (cfg_rcvbuf)
@@ -1062,7 +1130,31 @@ int main_loop(void)
 	if (cfg_cmsg_types.cmsg_enabled)
 		apply_cmsg_types(fd, &cfg_cmsg_types);
 
-	return copyfd_io(0, fd, 1);
+	if (cfg_input) {
+		fd_in = open(cfg_input, O_RDONLY);
+		if (fd < 0)
+			xerror("can't open %s:%d", cfg_input, errno);
+	}
+
+	/* close the client socket open only if we are not going to reconnect */
+	ret = copyfd_io(fd_in, fd, 1, cfg_repeat == 1);
+	if (ret)
+		return ret;
+
+	if (--cfg_repeat > 0) {
+		xdisconnect(fd, peer->ai_addrlen);
+
+		/* the socket could be unblocking at this point, we need the
+		 * connect to be blocking
+		 */
+		set_nonblock(fd, false);
+		if (connect(fd, peer->ai_addr, peer->ai_addrlen))
+			xerror("can't reconnect: %d", errno);
+		if (cfg_input)
+			close(fd_in);
+		goto again;
+	}
+	return 0;
 }
 
 int parse_proto(const char *proto)
@@ -1147,7 +1239,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "6jr:lp:s:hut:T:m:S:R:w:M:P:c:o:")) != -1) {
+	while ((c = getopt(argc, argv, "6c:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:uw:")) != -1) {
 		switch (c) {
 		case 'j':
 			cfg_join = true;
@@ -1161,6 +1253,12 @@ static void parse_opts(int argc, char **argv)
 			if (cfg_do_w <= 0)
 				cfg_do_w = 50;
 			break;
+		case 'i':
+			cfg_input = optarg;
+			break;
+		case 'I':
+			cfg_repeat = atoi(optarg);
+			break;
 		case 'l':
 			listen_mode = true;
 			break;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index a4226b608c68..de6c630a59da 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -7,6 +7,7 @@ optstring="S:R:d:e:l:r:h4cm:f:tC"
 ret=0
 sin=""
 sout=""
+cin_disconnect=""
 cin=""
 cout=""
 ksft_skip=4
@@ -24,6 +25,7 @@ options_log=true
 do_tcp=0
 checksum=false
 filesize=0
+connect_per_transfer=1
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -127,6 +129,7 @@ TEST_COUNT=0
 
 cleanup()
 {
+	rm -f "$cin_disconnect" "$cout_disconnect"
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
 	rm -f "$capout"
@@ -149,6 +152,8 @@ sout=$(mktemp)
 cin=$(mktemp)
 cout=$(mktemp)
 capout=$(mktemp)
+cin_disconnect="$cin".disconnect
+cout_disconnect="$cout".disconnect
 trap cleanup EXIT
 
 for i in "$ns1" "$ns2" "$ns3" "$ns4";do
@@ -518,8 +523,8 @@ do_transfer()
 	cookies=${cookies##*=}
 
 	if [ ${cl_proto} = "MPTCP" ] && [ ${srv_proto} = "MPTCP" ]; then
-		expect_synrx=$((stat_synrx_last_l+1))
-		expect_ackrx=$((stat_ackrx_last_l+1))
+		expect_synrx=$((stat_synrx_last_l+$connect_per_transfer))
+		expect_ackrx=$((stat_ackrx_last_l+$connect_per_transfer))
 	fi
 
 	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
@@ -756,6 +761,33 @@ run_tests_peekmode()
 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
 }
 
+run_tests_disconnect()
+{
+	local peekmode="$1"
+	local old_cin=$cin
+	local old_sin=$sin
+
+	cat $cin $cin $cin > "$cin".disconnect
+
+	# force do_transfer to cope with the multiple tranmissions
+	sin="$cin.disconnect"
+	sin_disconnect=$old_sin
+	cin="$cin.disconnect"
+	cin_disconnect="$old_cin"
+	connect_per_transfer=3
+
+	echo "INFO: disconnect"
+	run_tests_lo "$ns1" "$ns1" 10.0.1.1 1 "-I 3 -i $old_cin"
+	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-I 3 -i $old_cin"
+
+	# restore previous status
+	cout=$old_cout
+	cout_disconnect="$cout".disconnect
+	cin=$old_cin
+	cin_disconnect="$cin".disconnect
+	connect_per_transfer=1
+}
+
 display_time()
 {
 	time_end=$(date +%s)
@@ -873,6 +905,9 @@ stop_if_error "Tests with peek mode have failed"
 # connect to ns4 ip address, ns2 should intercept/proxy
 run_test_transparent 10.0.3.1 "tproxy ipv4"
 run_test_transparent dead:beef:3::1 "tproxy ipv6"
+stop_if_error "Tests with tproxy have failed"
+
+run_tests_disconnect
 
 display_time
 exit $ret
-- 
2.33.1

