Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C272C81
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634310600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d5FslE0B2w8nr945Nxq1/CfKExW3jGIzRv2o6RGTm2Q=;
	b=SoHAyFXol5/8g2JOFecZcYY9v/hmwJaZBtc/IOMLxlH38JB3zcl+SeKYbkEuAaCM7xwywK
	B90M2pcIBG03XpTlRVF/9s0keafq5tL2IjxMy+eQu6KEVjoYnUxmJRUt7+evlsfteBWTEP
	LlTgsiqXYqrmuAwZ/mNYnqx/UJJ8Jb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-NwPMKW5zPzqef_s_52kgvA-1; Fri, 15 Oct 2021 11:09:58 -0400
X-MC-Unique: NwPMKW5zPzqef_s_52kgvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8F5610A8E01;
	Fri, 15 Oct 2021 15:09:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A3B2310016F7;
	Fri, 15 Oct 2021 15:09:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [RFC PATCH v2] selftests: mptcp: more stable simult_flows tests
Date: Fri, 15 Oct 2021 17:09:49 +0200
Message-Id: <9d66028a72b6807d4dc3397bb70f028cbc78161d.1634310418.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Currently the simult_flows.sh self-tests are not very
stables, expecially when running on slow VM.

The tests mesures runtime for transfers on multiple subflows
and check that the time is nearby the theoretical maximum.

The current test infra introduces a bit of jitter in test
runtime, due to multiple explicit delays. Additionally the
runtime is measured by the shell script wrapper. On slow
VM, the script overhead is measurable and subject to relevant
jitter.

One solution to make the test more stable would be adding more
slack to the expected time; that could possibly hide reall
regressions. Instead move the measurement inside the command
doint the transfer, and drop most unneeded sleep.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
@matttbe: could you please double check this makes simult_flows
tests really more stable in your testbed?

Now the slack is really quite tight, I think we can raise it a
little more, without loosing the ability of catching regressions
---
 .../selftests/net/mptcp/mptcp_connect.c       | 72 +++++++++++++++----
 .../selftests/net/mptcp/simult_flows.sh       | 36 ++++------
 2 files changed, 72 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 89c4753c2760..53d267a1e3d7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -14,6 +14,7 @@
 #include <strings.h>
 #include <signal.h>
 #include <unistd.h>
+#include <time.h>
 
 #include <sys/poll.h>
 #include <sys/sendfile.h>
@@ -64,6 +65,7 @@ static int cfg_sndbuf;
 static int cfg_rcvbuf;
 static bool cfg_join;
 static bool cfg_remove;
+static unsigned int cfg_time;
 static unsigned int cfg_do_w;
 static int cfg_wait;
 static uint32_t cfg_mark;
@@ -78,9 +80,10 @@ static struct cfg_cmsg_types cfg_cmsg_types;
 static void die_usage(void)
 {
 	fprintf(stderr, "Usage: mptcp_connect [-6] [-u] [-s MPTCP|TCP] [-p port] [-m mode]"
-		"[-l] [-w sec] connect_address\n");
+		"[-l] [-w sec] [-t num] [-T num] connect_address\n");
 	fprintf(stderr, "\t-6 use ipv6\n");
 	fprintf(stderr, "\t-t num -- set poll timeout to num\n");
+	fprintf(stderr, "\t-T num -- set expected runtime to num ms\n");
 	fprintf(stderr, "\t-S num -- set SO_SNDBUF to num\n");
 	fprintf(stderr, "\t-R num -- set SO_RCVBUF to num\n");
 	fprintf(stderr, "\t-p num -- use port num\n");
@@ -448,7 +451,7 @@ static void set_nonblock(int fd)
 	fcntl(fd, F_SETFL, flags | O_NONBLOCK);
 }
 
-static int copyfd_io_poll(int infd, int peerfd, int outfd)
+static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after_out)
 {
 	struct pollfd fds = {
 		.fd = peerfd,
@@ -487,9 +490,11 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd)
 				 */
 				fds.events &= ~POLLIN;
 
-				if ((fds.events & POLLOUT) == 0)
+				if ((fds.events & POLLOUT) == 0) {
+					*in_closed_after_out = true;
 					/* and nothing more to send */
 					break;
+				}
 
 			/* Else, still have data to transmit */
 			} else if (len < 0) {
@@ -547,7 +552,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd)
 	}
 
 	/* leave some time for late join/announce */
-	if (cfg_join || cfg_remove)
+	if (cfg_remove)
 		usleep(cfg_wait);
 
 	close(peerfd);
@@ -646,7 +651,7 @@ static int do_sendfile(int infd, int outfd, unsigned int count)
 }
 
 static int copyfd_io_mmap(int infd, int peerfd, int outfd,
-			  unsigned int size)
+			  unsigned int size, bool *in_closed_after_out)
 {
 	int err;
 
@@ -664,13 +669,14 @@ static int copyfd_io_mmap(int infd, int peerfd, int outfd,
 		shutdown(peerfd, SHUT_WR);
 
 		err = do_recvfile(peerfd, outfd);
+		*in_closed_after_out = true;
 	}
 
 	return err;
 }
 
 static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
-			      unsigned int size)
+			      unsigned int size, bool *in_closed_after_out)
 {
 	int err;
 
@@ -685,6 +691,7 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 		if (err)
 			return err;
 		err = do_recvfile(peerfd, outfd);
+		*in_closed_after_out = true;
 	}
 
 	return err;
@@ -692,27 +699,62 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 
 static int copyfd_io(int infd, int peerfd, int outfd)
 {
+	bool in_closed_after_out = false;
+	struct timespec start, end;
 	int file_size;
+	int ret;
+
+	if (cfg_time && (clock_gettime(CLOCK_MONOTONIC, &start) < 0))
+		xerror("can not fetch start time %d", errno);
 
 	switch (cfg_mode) {
 	case CFG_MODE_POLL:
-		return copyfd_io_poll(infd, peerfd, outfd);
+		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out);
+		break;
+
 	case CFG_MODE_MMAP:
 		file_size = get_infd_size(infd);
 		if (file_size < 0)
 			return file_size;
-		return copyfd_io_mmap(infd, peerfd, outfd, file_size);
+		ret = copyfd_io_mmap(infd, peerfd, outfd, file_size, &in_closed_after_out);
+		break;
+
 	case CFG_MODE_SENDFILE:
 		file_size = get_infd_size(infd);
 		if (file_size < 0)
 			return file_size;
-		return copyfd_io_sendfile(infd, peerfd, outfd, file_size);
+		ret = copyfd_io_sendfile(infd, peerfd, outfd, file_size, &in_closed_after_out);
+		break;
+
+	default:
+		fprintf(stderr, "Invalid mode %d\n", cfg_mode);
+
+		die_usage();
+		return 1;
 	}
 
-	fprintf(stderr, "Invalid mode %d\n", cfg_mode);
+	if (ret)
+		return ret;
 
-	die_usage();
-	return 1;
+	if (cfg_time) {
+		unsigned int delta_ms;
+
+		if (clock_gettime(CLOCK_MONOTONIC, &end) < 0)
+			xerror("can not fetch end time %d", errno);
+		delta_ms = (end.tv_sec - start.tv_sec) * 1000 + (end.tv_nsec - start.tv_nsec) / 1000000;
+		if (delta_ms > cfg_time) {
+			xerror("transfer slower than expected! runtime %d ms, expected %d ms",
+			       delta_ms, cfg_time);
+		}
+
+		/* show the runtime only if this end shutdown(wr) before receving the EOF,
+		 * (that is, if this end got the longer runtime)
+		 */
+		if (in_closed_after_out)
+			fprintf(stderr, "%d", delta_ms);
+	}
+
+	return 0;
 }
 
 static void check_sockaddr(int pf, struct sockaddr_storage *ss,
@@ -1005,12 +1047,11 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:M:P:c:")) != -1) {
+	while ((c = getopt(argc, argv, "6jr:lp:s:hut:T:m:S:R:w:M:P:c:")) != -1) {
 		switch (c) {
 		case 'j':
 			cfg_join = true;
 			cfg_mode = CFG_MODE_POLL;
-			cfg_wait = 400000;
 			break;
 		case 'r':
 			cfg_remove = true;
@@ -1043,6 +1084,9 @@ static void parse_opts(int argc, char **argv)
 			if (poll_timeout <= 0)
 				poll_timeout = -1;
 			break;
+		case 'T':
+			cfg_time = atoi(optarg);
+			break;
 		case 'm':
 			cfg_mode = parse_mode(optarg);
 			break;
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 910d8126af8f..f441ff7904fc 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -51,7 +51,7 @@ setup()
 	sout=$(mktemp)
 	cout=$(mktemp)
 	capout=$(mktemp)
-	size=$((2048 * 4096))
+	size=$((2 * 2048 * 4096))
 	dd if=/dev/zero of=$small bs=4096 count=20 >/dev/null 2>&1
 	dd if=/dev/zero of=$large bs=4096 count=$((size / 4096)) >/dev/null 2>&1
 
@@ -161,17 +161,15 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${ns3} \
-			./mptcp_connect -jt ${timeout_poll} -l -p $port \
+			./mptcp_connect -jt ${timeout_poll} -l -p $port -T $time \
 				0.0.0.0 < "$sin" > "$sout" &
 	local spid=$!
 
 	wait_local_port_listen "${ns3}" "${port}"
 
-	local start
-	start=$(date +%s%3N)
 	timeout ${timeout_test} \
 		ip netns exec ${ns1} \
-			./mptcp_connect -jt ${timeout_poll} -p $port \
+			./mptcp_connect -jt ${timeout_poll} -p $port -T $time \
 				10.0.3.3 < "$cin" > "$cout" &
 	local cpid=$!
 
@@ -180,27 +178,20 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	local stop
-	stop=$(date +%s%3N)
-
 	if $capture; then
 		sleep 1
 		kill ${cappid_listener}
 		kill ${cappid_connector}
 	fi
 
-	local duration
-	duration=$((stop-start))
-
 	cmp $sin $cout > /dev/null 2>&1
 	local cmps=$?
 	cmp $cin $sout > /dev/null 2>&1
 	local cmpc=$?
 
-	printf "%16s" "$duration max $max_time "
+	printf "%-16s" " max $max_time "
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
-	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ] && \
-	   [ $duration -lt $max_time ]; then
+	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
 		echo "[ OK ]"
 		cat "$capout"
 		return 0
@@ -244,23 +235,24 @@ run_test()
 	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1
 	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2
 
-	# time is measure in ms
-	local time=$((size * 8 * 1000 / (( $rate1 + $rate2) * 1024 *1024) ))
+	# time is measured in ms, account for transfer size, affegated link speed
+	# and header overhead (10%)
+	local time=$((size * 8 * 1000 * 10 / (( $rate1 + $rate2) * 1024 *1024 * 9) ))
 
 	# mptcp_connect will do some sleeps to allow the mp_join handshake
-	# completion
-	time=$((time + 1350))
+	# completion (see mptcp_connect): 200ms on each side, add some slack
+	time=$((time + 450))
 
-	printf "%-50s" "$msg"
-	do_transfer $small $large $((time * 11 / 10))
+	printf "%-60s" "$msg"
+	do_transfer $small $large $time
 	lret=$?
 	if [ $lret -ne 0 ]; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
 
-	printf "%-50s" "$msg - reverse direction"
-	do_transfer $large $small $((time * 11 / 10))
+	printf "%-60s" "$msg - reverse direction"
+	do_transfer $large $small $time
 	lret=$?
 	if [ $lret -ne 0 ]; then
 		ret=$lret
-- 
2.26.3

