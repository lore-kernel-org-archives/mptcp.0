Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632027E3
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 08:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662713403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsJydD4uni3Yw/nnD2Ro3cJHkpJu5ADQ0YZwbroRDtY=;
	b=cOxVS5Y1ws1JIhbAE4Jid9DxQ/SzynjU5SZjQYSS99xV+/CbppOZ0rakd8nywh62HL15vO
	PQk9Dp8EuOJAu35qgoUbQfs7X1zpv6jhImiUNeu4wn4Bfpvzc3y+9869WTFHFn2yFCgY7N
	GXg26zRMMu3sUgAmWhhybx+AnftOzxk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-j6LO3JwgPIGjiMk0aRepDg-1; Fri, 09 Sep 2022 04:50:01 -0400
X-MC-Unique: j6LO3JwgPIGjiMk0aRepDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22378802E5D
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 08:50:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9ED6140B40C9
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 08:50:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 3/3] selftests: mptcp: update and extend fastclose test-cases
Date: Fri,  9 Sep 2022 10:49:50 +0200
Message-Id: <ccf2c2fc0f7fdca9742c51b3fdc6bb6c5fabec5f.1662713367.git.pabeni@redhat.com>
In-Reply-To: <904c47ce96fa8d6d4c961a2480bf3aea702c3a9c.1662713367.git.pabeni@redhat.com>
References: <904c47ce96fa8d6d4c961a2480bf3aea702c3a9c.1662713367.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

After the previous patches, the MPTCP protocol can generate
fast-closes on both ends of the connection. Rework the relevant
test-case to carefully trigger the fast-close code-path on a
single end at the time, while ensuring than a predictable amount
of data is spooled on both ends.

Additionally add another test-cases for the passive socket
fast-close.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
 (mptcp_connect)
 - update usage
 - avoid sleep after write error
 - use another conf variable to clarify rcv trunc actions

 (mptcp_join)
 - error out on bad fclose options
 - (mptcbetter output layout

v2 -> v3:
 - splitted out of 2/2
 - fixed a bunch of checkpatch issues
---
 .../selftests/net/mptcp/mptcp_connect.c       | 65 ++++++++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 90 +++++++++++++++----
 2 files changed, 129 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 24d4e9cb617e..7e4ce3caa5ed 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -72,6 +72,8 @@ static int cfg_wait;
 static uint32_t cfg_mark;
 static char *cfg_input;
 static int cfg_repeat = 1;
+static int cfg_truncate;
+static int cfg_rcv_trunc;
 
 struct cfg_cmsg_types {
 	unsigned int cmsg_enabled:1;
@@ -95,11 +97,15 @@ static struct cfg_sockopt_types cfg_sockopt_types;
 
 static void die_usage(void)
 {
-	fprintf(stderr, "Usage: mptcp_connect [-6] [-c cmsg] [-i file] [-I num] [-j] [-l] "
+	fprintf(stderr, "Usage: mptcp_connect [-6] [-c cmsg] [-f offset] [-i file] [-I num] [-j] [-l] "
 		"[-m mode] [-M mark] [-o option] [-p port] [-P mode] [-j] [-l] [-r num] "
 		"[-s MPTCP|TCP] [-S num] [-r num] [-t num] [-T num] [-u] [-w sec] connect_address\n");
 	fprintf(stderr, "\t-6 use ipv6\n");
 	fprintf(stderr, "\t-c cmsg -- test cmsg type <cmsg>\n");
+	fprintf(stderr, "\t-f offset -- stop the I/O after receiving and sending the specified amount "
+		"of bytes. If there are unread bytes in the receive queue, that will cause a MPTCP "
+		"fastclose at close/shutdown. If offset is negative, expect the peer to close before "
+		"all the local data as been sent, thus toleration errors on write and EPIPE signals\n");
 	fprintf(stderr, "\t-i file -- read the data to send from the given file instead of stdin");
 	fprintf(stderr, "\t-I num -- repeat the transfer 'num' times. In listen mode accepts num "
 		"incoming connections, in client mode, disconnect and reconnect to the server\n");
@@ -382,7 +388,7 @@ static size_t do_rnd_write(const int fd, char *buf, const size_t len)
 
 	bw = write(fd, buf, do_w);
 	if (bw < 0)
-		perror("write");
+		return bw;
 
 	/* let the join handshake complete, before going on */
 	if (cfg_join && first) {
@@ -571,7 +577,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 		.fd = peerfd,
 		.events = POLLIN | POLLOUT,
 	};
-	unsigned int woff = 0, wlen = 0;
+	unsigned int woff = 0, wlen = 0, total_wlen = 0, total_rlen = 0;
 	char wbuf[8192];
 
 	set_nonblock(peerfd, true);
@@ -597,7 +603,16 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 		}
 
 		if (fds.revents & POLLIN) {
-			len = do_rnd_read(peerfd, rbuf, sizeof(rbuf));
+			ssize_t rb = sizeof(rbuf);
+
+			/* limit the total amount of read data to the trunc value*/
+			if (cfg_truncate > 0) {
+				if (rb + total_rlen > cfg_truncate)
+					rb = cfg_truncate - total_rlen;
+				len = read(peerfd, rbuf, rb);
+			} else {
+				len = do_rnd_read(peerfd, rbuf, sizeof(rbuf));
+			}
 			if (len == 0) {
 				/* no more data to receive:
 				 * peer has closed its write side
@@ -612,10 +627,13 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 
 			/* Else, still have data to transmit */
 			} else if (len < 0) {
+				if (cfg_rcv_trunc)
+					return 0;
 				perror("read");
 				return 3;
 			}
 
+			total_rlen += len;
 			do_write(outfd, rbuf, len);
 		}
 
@@ -628,12 +646,21 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 			if (wlen > 0) {
 				ssize_t bw;
 
+				/* limit the total amount of written data to the trunc value */
+				if (cfg_truncate > 0 && wlen + total_wlen > cfg_truncate)
+					wlen = cfg_truncate - total_wlen;
+
 				bw = do_rnd_write(peerfd, wbuf + woff, wlen);
-				if (bw < 0)
+				if (bw < 0) {
+					if (cfg_rcv_trunc)
+						return 0;
+					perror("write");
 					return 111;
+				}
 
 				woff += bw;
 				wlen -= bw;
+				total_wlen += bw;
 			} else if (wlen == 0) {
 				/* We have no more data to send. */
 				fds.events &= ~POLLOUT;
@@ -652,10 +679,16 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 		}
 
 		if (fds.revents & (POLLERR | POLLNVAL)) {
+			if (cfg_rcv_trunc)
+				return 0;
 			fprintf(stderr, "Unexpected revents: "
 				"POLLERR/POLLNVAL(%x)\n", fds.revents);
 			return 5;
 		}
+
+		if (cfg_truncate > 0 && total_wlen >= cfg_truncate &&
+		    total_rlen >= cfg_truncate)
+			break;
 	}
 
 	/* leave some time for late join/announce */
@@ -1160,11 +1193,13 @@ int main_loop(void)
 	}
 
 	/* close the client socket open only if we are not going to reconnect */
-	ret = copyfd_io(fd_in, fd, 1, cfg_repeat == 1);
+	ret = copyfd_io(fd_in, fd, 1, 0);
 	if (ret)
 		return ret;
 
-	if (--cfg_repeat > 0) {
+	if (cfg_truncate > 0) {
+		xdisconnect(fd, peer->ai_addrlen);
+	} else if (--cfg_repeat > 0) {
 		xdisconnect(fd, peer->ai_addrlen);
 
 		/* the socket could be unblocking at this point, we need the
@@ -1176,7 +1211,8 @@ int main_loop(void)
 		if (cfg_input)
 			close(fd_in);
 		goto again;
-	}
+	} else
+		close(fd);
 	return 0;
 }
 
@@ -1262,8 +1298,19 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "6c:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
+	while ((c = getopt(argc, argv, "6c:f:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
 		switch (c) {
+		case 'f':
+			cfg_truncate = atoi(optarg);
+
+			/* when receiving a fastclose, ignore PIPE signals and
+			 * all the I/O errors later in the code
+			 */
+			if (cfg_truncate < 0) {
+				cfg_rcv_trunc = true;
+				signal(SIGPIPE, handle_signal);
+			}
+			break;
 		case 'j':
 			cfg_join = true;
 			cfg_mode = CFG_MODE_POLL;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2957fe414639..f3dd5f2a0272 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -346,10 +346,21 @@ check_transfer()
 	local in=$1
 	local out=$2
 	local what=$3
+	local bytes=$4
 	local i a b
 
 	local line
-	cmp -l "$in" "$out" | while read -r i a b; do
+	if [ -n "$bytes" ]; then
+		# when truncating we must check the size explicitly
+		local out_size=$(wc -c $out | awk '{print $1}')
+		if [ $out_size -ne $bytes ]; then
+			echo "[ FAIL ] $what output file has wrong size ($out_size, $bytes)"
+			fail_test
+			return 1
+		fi
+		bytes="--bytes=${bytes}"
+	fi
+	cmp -l "$in" "$out" ${bytes} | while read -r i a b; do
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			echo "[ FAIL ] $what does not match (in, out):"
@@ -707,9 +718,31 @@ do_transfer()
 	fi
 
 	local flags="subflow"
+	local extra_cl_args=""
+	local extra_srv_args=""
+	local trunc_size=""
 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+		if [ ${test_link_fail} -le 1 ]; then
+			echo "fastclose tests need test_link_fail argument"
+			fail_test
+			return 1
+		fi
+
 		# disconnect
-		extra_args="$extra_args -I ${addr_nr_ns2:10}"
+		trunc_size=${test_link_fail}
+		local side=${addr_nr_ns2:10}
+
+		if [ ${side} = "client" ]; then
+			extra_cl_args="-f ${test_link_fail}"
+			extra_srv_args="-f -1"
+		elif [ ${side} = "server" ]; then
+			extra_srv_args="-f ${test_link_fail}"
+			extra_cl_args="-f -1"
+		else
+			echo "wrong/unknown fastclose spec ${side}"
+			fail_test
+			return 1
+		fi
 		addr_nr_ns2=0
 	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
 		userspace_pm=1
@@ -737,39 +770,41 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
+	extra_srv_args="$extra_args $extra_srv_args"
 	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_args ${local_addr} < "$sinfail" > "$sout" &
+					$extra_srv_args ${local_addr} < "$sinfail" > "$sout" &
 	else
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_args ${local_addr} < "$sin" > "$sout" &
+					$extra_srv_args ${local_addr} < "$sin" > "$sout" &
 	fi
 	local spid=$!
 
 	wait_local_port_listen "${listener_ns}" "${port}"
 
+	extra_cl_args="$extra_args $extra_cl_args"
 	if [ "$test_link_fail" -eq 0 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${connector_ns} \
 				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$extra_args $connect_addr < "$cin" > "$cout" &
+					$extra_cl_args $connect_addr < "$cin" > "$cout" &
 	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$extra_args $connect_addr > "$cout" &
+						$extra_cl_args $connect_addr > "$cout" &
 	else
 		tee "$cinsent" < "$cinfail" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$extra_args $connect_addr > "$cout" &
+						$extra_cl_args $connect_addr > "$cout" &
 	fi
 	local cpid=$!
 
@@ -971,15 +1006,15 @@ do_transfer()
 	fi
 
 	if [ "$test_link_fail" -gt 1 ];then
-		check_transfer $sinfail $cout "file received by client"
+		check_transfer $sinfail $cout "file received by client" $trunc_size
 	else
-		check_transfer $sin $cout "file received by client"
+		check_transfer $sin $cout "file received by client" $trunc_size
 	fi
 	retc=$?
 	if [ "$test_link_fail" -eq 0 ];then
-		check_transfer $cin $sout "file received by server"
+		check_transfer $cin $sout "file received by server" $trunc_size
 	else
-		check_transfer $cinsent $sout "file received by server"
+		check_transfer $cinsent $sout "file received by server" $trunc_size
 	fi
 	rets=$?
 
@@ -1188,12 +1223,23 @@ chk_fclose_nr()
 {
 	local fclose_tx=$1
 	local fclose_rx=$2
+	local ns_invert=$3
 	local count
 	local dump_stats
+	local ns_tx=$ns2
+	local ns_rx=$ns1
+	local extra_msg="   "
+
+	if [[ $ns_invert = "invert" ]]; then
+		ns_tx=$ns1
+		ns_rx=$ns2
+		extra_msg=${extra_msg}"invert"
+	fi
 
 	printf "%-${nr_blank}s %s" " " "ctx"
-	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
+	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
+	[ "$count" != "$fclose_tx" ] && extra_msg="$extra_msg,tx=$count"
 	if [ "$count" != "$fclose_tx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 		fail_test
@@ -1203,17 +1249,20 @@ chk_fclose_nr()
 	fi
 
 	echo -n " - fclzrx"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk '{print $2}')
+	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFastcloseRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
+	[ "$count" != "$fclose_rx" ] && extra_msg="$extra_msg,rx=$count"
 	if [ "$count" != "$fclose_rx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 		fail_test
 		dump_stats=1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
 
 	[ "${dump_stats}" = 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
 
 chk_rst_nr()
@@ -1236,7 +1285,7 @@ chk_rst_nr()
 	printf "%-${nr_blank}s %s" " " "rtx"
 	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
-	if [ "$count" != "$rst_tx" ]; then
+	if [ $count -lt $rst_tx ]; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
 		fail_test
 		dump_stats=1
@@ -1247,7 +1296,7 @@ chk_rst_nr()
 	echo -n " - rstrx "
 	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
-	if [ "$count" != "$rst_rx" ]; then
+	if [ "$count" -lt "$rst_rx" ]; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
 		fail_test
 		dump_stats=1
@@ -2801,11 +2850,18 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset "fastclose test"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_2
+		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
+
+	if reset "fastclose server test"; then
+		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
+		chk_join_nr 0 0 0
+		chk_fclose_nr 1 1 invert
+		chk_rst_nr 1 1
+	fi
 }
 
 pedit_action_pkts()
-- 
2.37.2

