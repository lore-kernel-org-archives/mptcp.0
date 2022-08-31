Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C192804
	for <mptcp@lists.linux.dev>; Wed, 31 Aug 2022 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661942886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePrArrj9fby6vKG6V04lqMq5VLK8gjAFdlYwfXibIZA=;
	b=JnvMa68oPT/0XXx6wDJQBIMwt+Ykjzw69xE1jgeV5yF3yeJ/P9bL9V8AyzMaRiIGnpT+IB
	oXn8vAetaXTTgAKA3LOW1LBQBX7e336xKjbUwZBGgxlB2OKCpeWah2+USHPfnt6mEI9S4m
	HpiD/OoSghVS8iSbbvRZ1gMjmKgHl0c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-7Mq3i2-bNticxTLwNhyZYQ-1; Wed, 31 Aug 2022 06:48:04 -0400
X-MC-Unique: 7Mq3i2-bNticxTLwNhyZYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8681F80418F
	for <mptcp@lists.linux.dev>; Wed, 31 Aug 2022 10:48:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EAE3640B40C7
	for <mptcp@lists.linux.dev>; Wed, 31 Aug 2022 10:48:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 2/2] mptcp: use fastclose on more edge scenarios.
Date: Wed, 31 Aug 2022 12:47:43 +0200
Message-Id: <3fbf8f18c53284c5aaead02201563ee16096b290.1661942855.git.pabeni@redhat.com>
In-Reply-To: <5e26963328ae04aa375089a713ec40f5eb6adacd.1661942855.git.pabeni@redhat.com>
References: <5e26963328ae04aa375089a713ec40f5eb6adacd.1661942855.git.pabeni@redhat.com>
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

Daire reported a user-space application hang-up when the
peer is forcibly closed before the data transfer completion.

The relevant application expects the peer to either
do an application-level clean shutdown or a transport-level
connection reset.

We can accommodate a such user by extending the fastclose
usage: at fd close time, if the msk socket has some unread
data, and at FIN_WAIT timeout.

Note that at MPTCP close time we must ensure that the TCP
subflows will reset: set the linger socket option to a suitable
value.

The fastclose self-tests are updated accordingly to the above
changes, and a new test-case for client-side fast-close is
introduced.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
--
v1 -> v2:
 - ensure mptcp_do_fastclose will reset all the subflows,
 - update fastclose self-tests
---
 net/mptcp/protocol.c                          | 50 ++++++++---
 .../selftests/net/mptcp/mptcp_connect.c       | 58 +++++++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 86 +++++++++++++++----
 3 files changed, 154 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b04f184695e4..fec542fea02a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2276,8 +2276,14 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
-	if (flags & MPTCP_CF_FASTCLOSE)
+	if (flags & MPTCP_CF_FASTCLOSE) {
+		/* be sure to force the tcp_disconnect() path,
+		 * to generate the egress reset
+		 */
+		ssk->sk_lingertime = 0;
+		sock_set_flag(ssk, SOCK_LINGER);
 		subflow->send_fastclose = 1;
+	}
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
@@ -2540,6 +2546,16 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	mptcp_reset_timeout(msk, 0);
 }
 
+static void mptcp_do_fastclose(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp)
+		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
+				  subflow, MPTCP_CF_FASTCLOSE);
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
@@ -2571,6 +2587,7 @@ static void mptcp_worker(struct work_struct *work)
 	if (sock_flag(sk, SOCK_DEAD) &&
 	    (mptcp_check_close_timeout(sk) || sk->sk_state == TCP_CLOSE)) {
 		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_do_fastclose(sk);
 		__mptcp_destroy_sock(sk);
 		goto unlock;
 	}
@@ -2823,6 +2840,18 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sock_put(sk);
 }
 
+static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
+{
+	/* Concurrent splices from sk_receive_queue into receive_queue will
+	 * always show at least one non-empty queue when checked in this order.
+	 */
+	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue) &&
+	    skb_queue_empty_lockless(&msk->receive_queue))
+		return 0;
+
+	return EPOLLIN | EPOLLRDNORM;
+}
+
 static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2837,8 +2866,13 @@ static void mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_close_state(sk))
+	if (mptcp_check_readable(msk)) {
+		/* the msk has read data, do the MPTCP equivalent of TCP reset */
+		inet_sk_state_store(sk, TCP_CLOSE);
+		mptcp_do_fastclose(sk);
+	} else if (mptcp_close_state(sk)) {
 		__mptcp_wr_shutdown(sk);
+	}
 
 	sk_stream_wait_close(sk, timeout);
 
@@ -3646,18 +3680,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	return err;
 }
 
-static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
-{
-	/* Concurrent splices from sk_receive_queue into receive_queue will
-	 * always show at least one non-empty queue when checked in this order.
-	 */
-	if (skb_queue_empty_lockless(&((struct sock *)msk)->sk_receive_queue) &&
-	    skb_queue_empty_lockless(&msk->receive_queue))
-		return 0;
-
-	return EPOLLIN | EPOLLRDNORM;
-}
-
 static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 24d4e9cb617e..3592a1f51019 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -72,6 +72,7 @@ static int cfg_wait;
 static uint32_t cfg_mark;
 static char *cfg_input;
 static int cfg_repeat = 1;
+static int cfg_truncate = 0;
 
 struct cfg_cmsg_types {
 	unsigned int cmsg_enabled:1;
@@ -381,8 +382,6 @@ static size_t do_rnd_write(const int fd, char *buf, const size_t len)
 		do_w = cfg_do_w;
 
 	bw = write(fd, buf, do_w);
-	if (bw < 0)
-		perror("write");
 
 	/* let the join handshake complete, before going on */
 	if (cfg_join && first) {
@@ -571,7 +570,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 		.fd = peerfd,
 		.events = POLLIN | POLLOUT,
 	};
-	unsigned int woff = 0, wlen = 0;
+	unsigned int woff = 0, wlen = 0, total_wlen = 0, total_rlen = 0;
 	char wbuf[8192];
 
 	set_nonblock(peerfd, true);
@@ -597,7 +596,16 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
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
@@ -612,10 +620,14 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 
 			/* Else, still have data to transmit */
 			} else if (len < 0) {
+				/* ignore errors on I/O operation when the peer is fastclosing */
+				if (cfg_truncate < 0)
+					return 0;
 				perror("read");
 				return 3;
 			}
 
+			total_rlen += len;
 			do_write(outfd, rbuf, len);
 		}
 
@@ -628,12 +640,21 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 			if (wlen > 0) {
 				ssize_t bw;
 
+				/* limit the total amount of written data to the trunc value */
+				if (cfg_truncate > 0 && wlen + total_wlen > cfg_truncate)
+					wlen = cfg_truncate - total_wlen;
+
 				bw = do_rnd_write(peerfd, wbuf + woff, wlen);
-				if (bw < 0)
+				if (bw < 0) {
+					if (cfg_truncate < 0)
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
@@ -652,10 +673,19 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 		}
 
 		if (fds.revents & (POLLERR | POLLNVAL)) {
+			/* when the peer is truncating the file and fastclosing, ignore
+			 * HUP/connection reset errors
+			 */
+			if (cfg_truncate < 0)
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
@@ -1160,11 +1190,13 @@ int main_loop(void)
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
@@ -1176,7 +1208,8 @@ int main_loop(void)
 		if (cfg_input)
 			close(fd_in);
 		goto again;
-	}
+	} else
+		close(fd);
 	return 0;
 }
 
@@ -1262,8 +1295,15 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "6c:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
+	while ((c = getopt(argc, argv, "6c:f:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
 		switch (c) {
+		case 'f':
+			cfg_truncate = atoi(optarg);
+
+			/* when receiving a fastclose, ignore PIPE signals */
+			if (cfg_truncate < 0)
+				signal(SIGPIPE, handle_signal);
+			break;
 		case 'j':
 			cfg_join = true;
 			cfg_mode = CFG_MODE_POLL;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2957fe414639..71eadfa882a9 100755
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
@@ -707,9 +718,29 @@ do_transfer()
 	fi
 
 	local flags="subflow"
+	local extra_cl_args=""
+	local extra_srv_args=""
+	local trunc_size=""
 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+		if [ ${test_link_fail} -le 1 ]; then
+			echo "fastclose tests need test_link_fail argument"
+			return 0
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
+			return 0
+		fi
 		addr_nr_ns2=0
 	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
 		userspace_pm=1
@@ -741,12 +772,12 @@ do_transfer()
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_args ${local_addr} < "$sinfail" > "$sout" &
+					$extra_args $extra_srv_args ${local_addr} < "$sinfail" > "$sout" &
 	else
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					$extra_args ${local_addr} < "$sin" > "$sout" &
+					$extra_args $extra_srv_args ${local_addr} < "$sin" > "$sout" &
 	fi
 	local spid=$!
 
@@ -756,20 +787,20 @@ do_transfer()
 		timeout ${timeout_test} \
 			ip netns exec ${connector_ns} \
 				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$extra_args $connect_addr < "$cin" > "$cout" &
+					$extra_args $extra_cl_args $connect_addr < "$cin" > "$cout" &
 	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$extra_args $connect_addr > "$cout" &
+						$extra_args $extra_cl_args $connect_addr > "$cout" &
 	else
 		tee "$cinsent" < "$cinfail" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$extra_args $connect_addr > "$cout" &
+						$extra_args $extra_cl_args $connect_addr > "$cout" &
 	fi
 	local cpid=$!
 
@@ -971,15 +1002,15 @@ do_transfer()
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
 
@@ -1188,12 +1219,23 @@ chk_fclose_nr()
 {
 	local fclose_tx=$1
 	local fclose_rx=$2
+	local ns_invert=${3:-""}
 	local count
 	local dump_stats
+	local ns_tx=$ns2
+	local ns_rx=$ns1
+	local extra_msg=""
+
+	if [[ $ns_invert = "invert" ]]; then
+		ns_tx=$ns1
+		ns_rx=$ns2
+		extra_msg="   invert"
+	fi
 
 	printf "%-${nr_blank}s %s" " " "ctx"
-	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
+	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
+	[ "$count" != "$fclose_tx" ] && extra_msg="$extra_msg,tx=$count"
 	if [ "$count" != "$fclose_tx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 		fail_test
@@ -1203,17 +1245,20 @@ chk_fclose_nr()
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
@@ -1236,7 +1281,7 @@ chk_rst_nr()
 	printf "%-${nr_blank}s %s" " " "rtx"
 	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
-	if [ "$count" != "$rst_tx" ]; then
+	if [ $count -lt $rst_tx ]; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
 		fail_test
 		dump_stats=1
@@ -1247,7 +1292,7 @@ chk_rst_nr()
 	echo -n " - rstrx "
 	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
-	if [ "$count" != "$rst_rx" ]; then
+	if [ "$count" -lt "$rst_rx" ]; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
 		fail_test
 		dump_stats=1
@@ -2801,11 +2846,18 @@ fullmesh_tests()
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

