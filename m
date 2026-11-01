Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793517669;
	b=r+Xq2fpIWFLz1Uz/Wg+mKMdGGvRmXzAzOwrhnm3lEl7M2BQrqMmTlulcEc3rXJ2td7bX
	 KYxpk12zzhxQWvsEbAWCR9wqb2CyD21ElQVqadLxU9vp0RGZgtUbp2+siZtuon6yJ1Z4T
	 Ur/9J/Uk4m9Syyy1O3OhNUOnHuDThI2kr9tpRDftBA9hh2XsMUNki3VtpeS8T9gmCkT74
	 FcWGYrpXEBfPK/zF7FmRS64tKu44ardysmmqCXPMga0xNWFctqfJwAFP0Qcood4W5f9La
	 UqicErcrTgE6MQZWdprSQX2QUdMcp516uvh0bAf8TKtA6Ka/beoOKHu3QvA6ZTX+Enw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793517669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vgJuZ5+WTimnOJr1ILDbkJrgX2lQ/uIBZDP16hESEoM=;
	b=Y6JUwGNI0Hy3PXI4e0gh91YKXZ+KAw77+J+Bg0hRkVWSJq2L7TOjufCoNGKkDMpJWikv
	 UYmOX0GmZmQWcSVwLehcl5BuB26iL7NKU9EpZljNHxUgdjzx6YJB2073GypuABriMYOwY
	 3FNy6fbSfUe0p8BTIIA72YDGk5+ZtJpM0biKs26yLGmIvYEC46+BEcbtwXbxAPoEk8AQl
	 d+wc5ymYANPnE05MwA8HjNLC3ymLhG5GNHxfsS48ERYHerPGmda4lNOM8VBLkbztNk0zO
	 aoHbn9lKyryXAFMIYI0/BEpF8ZDyVYyJkXGOjl/sjX6sG8w2JaP8Q8ei6Qlv0FMbYGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DS7bmXpT;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F6606A32D
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 07:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC6F6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DS7bmXpT
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso421121eec.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 00:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793517668; x=1794122468; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vgJuZ5+WTimnOJr1ILDbkJrgX2lQ/uIBZDP16hESEoM=;
        b=DS7bmXpTt+XEnFIHXnilGmQaTyxlLa7PyG0j9TQ1De10Z21dut1OjTDKbwVZTXpLUS
         NwISJLgkKmjU//nZ4w2GYLbwe2EXMQg7RWC8js1RZBFbP8I3QZkuj3uh2B5+3lHmi7tX
         4KdOXL/4HcBnqScEhYfJ2iwHZ1kbveV1mKNLfLBphXpfHdlUtK1TqONatF82Z4qp+2S8
         fnIOx73B+JPEosijUab1HdAxzGrgA21fccY/+nGMtkRUKI9rTI9lJsekO4mhGJcc1S6h
         6dtdz+1+rPcBEuCzPoLeYmfCkK7XH/aONSrahLBhPmshSpy0ph90zAlR8ocIQL/yIs8o
         ND7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793517668; x=1794122468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vgJuZ5+WTimnOJr1ILDbkJrgX2lQ/uIBZDP16hESEoM=;
        b=hI7im36oxR9wl9/U6w5uXcPJErfF0TAR42s8qzTo2IOXbY+Yb3775h6irjwq4Z4N+A
         ThJkzvyLQvNIPtGSNhgPxOV26qudovVFHlJ2YtC8iT7ClLCm9Yl3//yi3Q2tzNEAuuZv
         6KIqsqe11rLPt3kB84wL4cAfDxpL/2VQb/hxbctDlTiLm5XdW+xkGiR2T9EqOOYNHyQP
         nOX5v0UMfqA1lYnOtMsbuh6Qh16FXbeuFrirIPGLBsvlz+unTd2DBDpSNdJgMVy4XLuF
         sIumDleP8SYRPcX/CULIKrgUclVxlrut/0APThxEvWpS5YwuM1FzccbPFT5/jkCxol8D
         f/iA==
X-Gm-Message-State: AFq9FYI4lvb3IRjhtPLvzBiJKJmu0b+g4uH2GxLhnv+V+nPU2arCgqOX
	c4e8EVww9Db1mLyk6iYerkvhuB4vdwLVpKIlIjOR/kkaEVg1bj6r+1xHEyQsRA==
X-Gm-Gg: AYBFou3Sy/3L150+tqPocQkxTCde0khxdWJjim/5+TedI5YzDjxIKWS7wpCbO7dDOK/
	YzoAdKsPYfm/DSVBSrrOAAvgjOGzI9u7H/9PZjIYYRqHSKKrJI/LpFg6E/50RKQVluBzjaXN072
	vN5y//7qXPiFPqjcg1C9ndSDESSmpN5DzuuiSWRS7In8gPQd6STWz9PQ3XzkDz2ZVfSyOKfamcd
	4ojDdRlc0fHQQs4DtYRN3JajlVB7Qj6vatYzv5ShpC9evcpRWqRSIv9272c2NnpT4iCO6poowvp
	7zZoI0XmEwHh7wLeWPNW6BBBUncvJz8ZWlFum+K6X5s8eG3GG1cEaFLZVDEjCllncXk0JOTQo6U
	szlrQl7X1cWDuulOqRXSXvBGBDdxidwmVr1dEbbTNlzItFSfPiWyhA6alXlUADS85b+8Ri1ESwl
	XIy5D1PdB3nWtXesYa78hKalSnP7iNm/HdNEZYUzRVUHDkR+AmxqhCbEqu1/r95ORn02qq+uLMg
	5rglSntDck8Jl5ffRPwRf8VfFUWv5lUU/zZI6U5in6rb+ihMV3tQ7+xZqSgMvsQAX/AFH0OULsC
	rt839xvoaKrmsnEjD/nTqpAe5Av8BqITCrPT7fg5VFwlUA85QWucNceOUtQsxkJDr+NPJ5ALqAC
	QFOqtOWk4gTg4DJHqhaaUVeQ4KVb3fR5XRCXdeggXZmLA6vicy5mo7+h2bC0F+7ctnJCJb1qW7w
	==
X-Received: by 2002:a05:7022:f409:b0:143:26eb:18e9 with SMTP id a92af1059eb24-1ac5d5aae14mr12836923c88.28.1793517667437;
        Sun, 01 Nov 2026 00:21:07 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm29851495c88.6.2026.11.01.00.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 00:21:07 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v14 6/6] selftests: mptcp: join: validate subflow retry after link failure
Date: Sun,  1 Nov 2026 07:20:51 +0000
Message-Id: <20261101072051.3853492-7-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
References: <20261101072051.3853492-1-anilkaushikwireless@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the subflow-retries limit, with its default value, and a long
connection in the background: drop the packets the client sends from
the additional subflow address with netfilter, without bringing the link
down, until the subflow is closed and re-created. Let them through again
once the SYN of the new subflow has been retransmitted more times than
tcp_syn_retries allows, and check the subflow comes back from the same
address. Then do the same with the initial subflow.

A second test closes the connection while a subflow is being re-created,
and checks the netlink events. Only the client sends data: the server
reads it all first, in sendfile mode, and keeps its side open. The
client gets a big MPTCP send buffer compared to its subflows, and both
paths are blocked: the data left in it is never sent, nor the DATA_FIN,
so only the close of the MPTCP socket can stop the subflow being
re-created. Only the client is closed: it has nothing left to read, so
the connection is not closed with a fastclose, which would reset all the
subflows anyway. The check is skipped if a fastclose happens. The big
files used for the long connection are emptied at the end.

A third test checks the only subflow is not re-created: there is no
other subflow to send data.

A fourth test removes the address of the additional subflow while its
packets are dropped: the subflow times out, the new one cannot be
created, bind() fails, and the PM uses the next endpoint instead.

The tests are skipped if pm_nl_ctl does not show the new limit, or if the
filter rules cannot be set.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
    v14:
     - new test: the subflow cannot be re-created, the next endpoint is
       used instead
     - check the join counters before killing the transfer, which can send
       MP_RST, counted with -C (netdev Sashiko)
     - tcp_retries2 is only lowered while a path is blocked in the first
       test, so the other path cannot time out on losses
    v13:
     - wait for the SUB_CLOSED event before stopping the listener
       (netdev Sashiko on v12)
     - the first test stops if no additional subflow got established,
       the third one waits for the SUB_CLOSED event, and say why the
       tcp_wmem min value is above the max
    v12:
     - wait for the client side of a re-created subflow to be fully
       established before going on: the close would close it too
       otherwise (netdev Sashiko)
     - the third test only checks the subflow is not re-created, say
       only that (netdev Sashiko)
    v11:
     - the third test checks the only subflow is not re-created, and the
       path-back test is gone: a subflow is only re-created while another
       one can send data
     - the close test keeps the initial subflow while checking: without the
       fix, it would no longer pass when the initial subflow closes after
       a few retransmissions; a SUB_CLOSED event for the re-created subflow
    v10:
     - new test: the path of the only subflow comes back before the
       close timeout, and the connection stays open (sashiko.dev)
       The path comes back as soon as the subflow is re-created, with a
       30s close timeout, longer than the SYN backoff, and its transfer
       has a longer poll timeout, with no data at all while the only path
       is blocked: both are needed on a slow debug kernel
    v9:
     - wait for absolute counter values, read before blocking the path,
       or 0 and 1 in the new netns: the subflow can be re-created before
       a later read (netdev Sashiko)
     - check that the connection is established before blocking it, in
       the close test and the new one (netdev Sashiko)
     - the close test blocks the other path too, with a big msk send
       buffer: the pending data and the DATA_FIN no longer close the
       subflow being re-created, only the close of the MPTCP socket can.
       Checked: both the close test and the new test fail without their
       fix
     - new test: the only subflow is re-created, and the connection is
       still closed after the close timeout
     - $sinfail as the server input, kill errors ignored, clearer failure
       message, $cout and $sout emptied too
     - the server of the second test reads all the data from the client
       first, in sendfile mode, instead of blocking on a FIFO in poll
       mode: the client always has data in flight (netdev Sashiko)
    v8:
     - comment in run_tests() matching the new condition (netdev Sashiko)
     - a separate test closes the connection while a subflow is
       re-created: the server sends nothing but keeps its side open, and
       only the client is closed, so there is no fastclose, which would
       reset all the subflows anyway; the check is skipped if one happens
       (netdev Sashiko)
    v7 (netdev Sashiko):
     - the test_linkfail=1/2 modes regenerate the shared files when they
       are empty, e.g. when running link_failure_tests() twice
     - read the MP_JOIN ACK counter before letting the packets through,
       and do not compare the ports, they can be reused
    v6 (Sashiko):
     - use the slowwait helpers from net/lib.sh
     - longer first wait, while the 128 MB files are created
     - skip if the filter rules cannot be set, check each drop rule
       (netdev Sashiko)
     - empty the big files at the end, cinsent too, keep the variables
       (netdev Sashiko)
    v5 (Matthieu):
     - skipped if pm_nl_ctl does not show the new limit
     - wait for the SYN retransmissions instead of a sleep, with
       tcp_syn_linear_timeouts=0
     - helper for the check after the close
     - slower links with short queues, so the transfer lasts the whole
       test on any machine, longer timeout (killed at the end)
    v4:
     - default limit, no sysctl or MIB counter
     - more SYN retransmissions than tcp_syn_retries
     - close the connection while a subflow is re-created
     - check the netlink events
     - check the waits and the new subflow port, remove the big files at
       the end (Sashiko)
    v3:
     - check the subflow address, create the files before the background job
    v2:
     - one test, with netfilter

 .../testing/selftests/net/mptcp/mptcp_join.sh | 407 +++++++++++++++++-
 1 file changed, 399 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c3ccce96b45b..b95a96f975cd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -52,6 +52,7 @@ nr_blank=6
 # These var are used only in some tests, make sure they are not already set
 unset FAILING_LINKS
 unset test_linkfail
+unset server_in
 unset addr_nr_ns1
 unset addr_nr_ns2
 unset cestab_ns1
@@ -1038,7 +1039,12 @@ do_transfer()
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
-	if [ "$test_linkfail" -gt 1 ];then
+	if [ -n "${server_in}" ]; then
+		# the server reads all the data from the client before sending
+		# this file: it does not block on its input
+		extra_srv_args="$extra_srv_args -m sendfile"
+		listener_in="${server_in}"
+	elif [ "$test_linkfail" -gt 1 ]; then
 		listener_in="${sinfail}"
 	fi
 	ip netns exec ${listener_ns} \
@@ -1135,9 +1141,9 @@ run_tests()
 			cinfail=$(mktemp)
 		fi
 		make_file "$cinfail" "client" $size
-	# create the input file for the failure test when
-	# the first failure test run
-	elif [ "$test_linkfail" -ne 0 ] && [ -z "$cinfail" ]; then
+	# create the input file for the failure test, when
+	# it is missing or has been emptied
+	elif [ "$test_linkfail" -ne 0 ] && [ ! -s "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -1146,23 +1152,27 @@ run_tests()
 		size=$((size*8192))
 		size=$((size + ( RANDOM % 8192) ))
 
-		cinfail=$(mktemp)
+		if [ -z "$cinfail" ]; then
+			cinfail=$(mktemp)
+		fi
 		make_file "$cinfail" "client" $size
 	fi
 
-	if [ "$test_linkfail" -gt 2 ]; then
+	if [ "$test_linkfail" -gt 2 ] && [ -z "${server_in}" ]; then
 		size=$test_linkfail
 
 		if [ -z "$sinfail" ]; then
 			sinfail=$(mktemp)
 		fi
 		make_file "$sinfail" "server" $size
-	elif [ "$test_linkfail" -eq 2 ] && [ -z "$sinfail" ]; then
+	elif [ "$test_linkfail" -eq 2 ] && [ ! -s "$sinfail" ]; then
 		size=$((RANDOM%16))
 		size=$((size+1))
 		size=$((size*2048))
 
-		sinfail=$(mktemp)
+		if [ -z "$sinfail" ]; then
+			sinfail=$(mktemp)
+		fi
 		make_file "$sinfail" "server" $size
 	fi
 
@@ -2151,6 +2161,208 @@ wait_attempt_fail()
 	return 1
 }
 
+# $1: timeout in seconds ; $2: ns ; $3: counter ; $4: increment, 1 by default
+wait_counter_inc()
+{
+	slowwait_for_counter "${1}" "${4:-1}" \
+		mptcp_lib_get_counter "${2}" "${3}" >/dev/null
+}
+
+# $1: timeout ; $2: ns ; $3: counter ; $4: value to reach
+wait_counter_ge()
+{
+	slowwait "${1}" until_counter_is ">= ${4}" \
+		mptcp_lib_get_counter "${2}" "${3}" >/dev/null
+}
+
+# $1: client address ; prints the local address and port of its subflow
+sf_from()
+{
+	ip netns exec $ns2 ss -tnH state established src "${1}" |
+		awk '{ print $3; exit }'
+}
+
+# the client got the 4th ACK of the MP_JOIN
+sf_fully_established()
+{
+	ip netns exec $ns2 ss -tniH state established src "${1}" |
+		grep -q "tcp-ulp-mptcp flags:[A-Za-z]*e"
+}
+
+has_subflow_retries()
+{
+	ip netns exec $ns2 ./pm_nl_ctl limits | grep -q "^subflow_retries"
+}
+
+# the client packets are dropped with rules in this chain
+init_nft_filter()
+{
+	init_nftables
+	if ! ip netns exec $ns2 nft list chain ip filter OUTPUT \
+	     &>/dev/null; then
+		mark_as_skipped "unable to set the filter rules"
+		return 1
+	fi
+}
+
+# $1: client address
+nft_drop_from()
+{
+	ip netns exec $ns2 nft add rule ip filter OUTPUT ip saddr "${1}" drop
+}
+
+# $1: client address to block
+#
+# The link stays up, but the client packets from this address are dropped:
+# the subflow using it is closed after a few retransmissions, and re-created.
+# The packets go through again once the SYN has been retransmitted more times
+# than tcp_syn_retries allows: the new subflow still connects thanks to the
+# subflow-retries limit.
+sf_retry_after_block()
+{
+	local before ack_rx syn_tx
+
+	before=$(sf_from "${1}")
+
+	print_check "subflow from ${1}"
+	if [ -z "${before}" ]; then
+		fail_test "no established subflow from ${1} before the block"
+		return
+	fi
+
+	# read before the block: the subflow can be re-created right after it
+	syn_tx=$(mptcp_lib_get_counter $ns2 "MPTcpExtMPJoinSynTx")
+	# a short timeout only while the path is blocked: the other one must
+	# not time out on losses
+	ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
+	if ! nft_drop_from "${1}"; then
+		fail_test "unable to drop the packets from ${1}"
+		return
+	fi
+	if ! wait_counter_ge "${timeout_poll}" $ns2 "MPTcpExtMPJoinSynTx" \
+	     $((syn_tx + 1)); then
+		ip netns exec $ns2 nft flush chain ip filter OUTPUT
+		fail_test "subflow from ${1} not re-created"
+		return
+	fi
+	ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=15
+	# tcp_syn_retries=1: one more retransmission than allowed
+	if ! wait_counter_inc "${timeout_poll}" \
+		$ns2 "TcpExtTCPSynRetrans" 2; then
+		ip netns exec $ns2 nft flush chain ip filter OUTPUT
+		fail_test "SYN from ${1} not retransmitted enough"
+		return
+	fi
+	# read before the flush: the next SYN can be sent right after it
+	ack_rx=$(mptcp_lib_get_counter $ns1 "MPTcpExtMPJoinAckRx")
+	ip netns exec $ns2 nft flush chain ip filter OUTPUT
+
+	if ! wait_counter_ge "${timeout_poll}" $ns1 "MPTcpExtMPJoinAckRx" \
+	     $((ack_rx + 1)); then
+		fail_test "re-created subflow from ${1} not established"
+		return
+	fi
+
+	# before a close, which would close it too if not fully established
+	if ! slowwait "${timeout_poll}" sf_fully_established "${1}"; then
+		fail_test "no fully established subflow from ${1}"
+	else
+		print_ok
+	fi
+}
+
+# $1: ns ; prints the number of MP_FASTCLOSE sent and received
+fastclose_nr()
+{
+	local tx rx
+
+	tx=$(mptcp_lib_get_counter "${1}" "MPTcpExtMPFastcloseTx")
+	rx=$(mptcp_lib_get_counter "${1}" "MPTcpExtMPFastcloseRx")
+	echo $((${tx:-0} + ${rx:-0}))
+}
+
+no_sf_connecting()
+{
+	! ip netns exec $ns2 ss -tnH state syn-sent | grep -q .
+}
+
+# The client has nothing left to read: it closes the connection without a
+# fastclose, which would reset all the subflows anyway.
+kill_client()
+{
+	local pid
+
+	for pid in $(ip netns pids $ns2); do
+		if [ "$(cat "/proc/${pid}/comm" 2>/dev/null)" = mptcp_connect ]
+		then
+			kill "${pid}" 2>/dev/null
+		fi
+	done
+}
+
+# $1: why the subflow is not being re-created before the close, if it is not
+# $2: number of MP_FASTCLOSE before the close
+chk_no_sf_connecting()
+{
+	local closed
+
+	print_check "no subflow connecting after close"
+	if [ -n "${1}" ]; then
+		fail_test "${1}"
+		return
+	fi
+
+	# closed with the MPTCP socket
+	slowwait "${timeout_poll}" no_sf_connecting
+	closed=$?
+	if [ "$(fastclose_nr $ns2)" -gt "${2}" ]; then
+		print_skip "closed with a fastclose, resetting all the subflows"
+	elif [ "${closed}" -eq 0 ]; then
+		print_ok
+	else
+		fail_test "subflow still connecting after close"
+	fi
+}
+
+# Slow links with short queues: the transfer lasts the whole test on any
+# machine, and the blocked subflow always has data in flight.
+sf_retry_init()
+{
+	local i
+
+	# link 4: the next endpoint of the "creation error" test
+	for i in 1 3 4; do
+		tc -n $ns1 qdisc add dev ns1eth$i root netem \
+			rate 4mbit limit 30 delay 1ms
+		tc -n $ns2 qdisc add dev ns2eth$i root netem \
+			rate 4mbit limit 30 delay 1ms
+	done
+	ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
+	ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
+	ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_linear_timeouts=0
+	pm_nl_set_limits $ns1 0 4
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	# created here, not in the background job, for cleanup()
+	if [ -z "$cinfail" ]; then
+		cinfail=$(mktemp)
+	fi
+	if [ -z "$sinfail" ]; then
+		sinfail=$(mktemp)
+	fi
+}
+
+sf_retry_cleanup()
+{
+	ip netns exec $ns2 nft flush chain ip filter OUTPUT
+	# big files: empty them, the next tests write their own content
+	: > "$cinfail"
+	: > "$sinfail"
+	: > "$cinsent"
+	: > "$cout"
+	: > "$sout"
+}
+
 set_userspace_pm()
 {
 	local ns=$1
@@ -2585,6 +2797,185 @@ link_failure_tests()
 		chk_stale_nr $ns2 1 -1 2
 		chk_link_usage $ns2 ns2eth3 $cinsent 50
 	fi
+
+	# subflows closed after a silent link failure, then re-created: the
+	# additional one, then the initial one
+	if reset_with_events "subflow retry after link failure" &&
+	   continue_if has_subflow_retries && init_nft_filter; then
+		sf_retry_init
+		# killed at the end: the timeout only stops a stuck test
+		{ timeout_test=600 test_linkfail=131072 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		# the 128 MB files are created first, that can take a while
+		if wait_counter_ge $((timeout_poll * 4)) \
+		   $ns1 "MPTcpExtMPJoinAckRx" 1; then
+			sf_retry_after_block 10.0.3.2
+			sf_retry_after_block 10.0.1.2
+		else
+			print_check "additional subflow"
+			fail_test "no additional subflow before the blocks"
+		fi
+		# before the kill, which can send MP_RST (checked with -C)
+		join_syn_tx=3 chk_join_nr 3 3 3
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2
+		sf_retry_cleanup
+	fi
+
+	# close the connection while a subflow is being re-created
+	if reset_with_events "subflow retry, close while connecting" &&
+	   continue_if has_subflow_retries && init_nft_filter; then
+		sf_retry_init
+		# A big msk send buffer, compared to the subflow ones: when the
+		# client is closed, some data is not given to any subflow yet,
+		# so the DATA_FIN, which would also close the subflow being
+		# re-created, is not sent. The min value is above the max on
+		# purpose: __mptcp_sync_sndbuf() adds it to the subflow ones.
+		ip netns exec $ns2 sysctl -q \
+			net.ipv4.tcp_wmem="1048576 65536 262144"
+		# The server reads until the client closes, and sends nothing:
+		# the client has nothing to read, and the connection stays
+		# established. The transfer is stopped on purpose, its result
+		# is not checked.
+		: > "$sinfail"
+		{ timeout_test=600 test_linkfail=131072 server_in="$sinfail" \
+			run_tests $ns1 $ns2 10.0.1.1 >/dev/null & } 2>/dev/null
+		local tests_pid=$!
+
+		local not_ready="" syn_tx
+		if ! wait_counter_ge $((timeout_poll * 4)) \
+		     $ns1 "MPTcpExtMPJoinAckRx" 1; then
+			not_ready="no additional subflow before the block"
+		else
+			# read before the block: the subflow can be re-created
+			# right after it
+			syn_tx=$(mptcp_lib_get_counter $ns2 \
+				"MPTcpExtMPJoinSynTx")
+			if ! nft_drop_from 10.0.3.2; then
+				not_ready="unable to drop the packets"
+			elif ! wait_counter_ge "${timeout_poll}" \
+			     $ns2 "MPTcpExtMPJoinSynTx" $((syn_tx + 1)); then
+				not_ready="no subflow re-created before close"
+			fi
+		fi
+		# Block the other path too, so this data is never sent: only
+		# the close of the MPTCP socket can then stop the subflow being
+		# re-created. The initial subflow is no longer closed after a
+		# few retransmissions: that would close it too.
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=15
+		if [ -z "${not_ready}" ] && ! nft_drop_from 10.0.1.2; then
+			not_ready="unable to drop the packets"
+		fi
+		local fc_before
+		fc_before=$(fastclose_nr $ns2)
+		# before the kill, which can send MP_RST (checked with -C)
+		join_syn_tx=2 chk_join_nr 1 1 1
+		kill_client
+		chk_no_sf_connecting "${not_ready}" "${fc_before}"
+		mptcp_lib_kill_group_wait $tests_pid
+		# the listener could be stopped before it got the last event
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		kill_events_pids
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
+		# the re-created subflow, closed with the MPTCP socket
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 1
+		sf_retry_cleanup
+	fi
+
+	# the only subflow is not re-created
+	if reset_with_events "subflow retry, no other subflow" &&
+	   continue_if has_subflow_retries && init_nft_filter; then
+		sf_retry_init
+		pm_nl_flush_endpoint $ns2
+		{ timeout_test=600 test_linkfail=131072 \
+			run_tests $ns1 $ns2 10.0.1.1 >/dev/null & } 2>/dev/null
+		local tests_pid=$!
+
+		print_check "not re-created"
+		if ! wait_counter_ge $((timeout_poll * 4)) \
+		     $ns1 "MPTcpExtMPCapableACKRX" 1; then
+			fail_test "connection not established"
+		elif ! nft_drop_from 10.0.1.2; then
+			fail_test "unable to drop the packets"
+		elif ! wait_counter_ge "${timeout_poll}" \
+		     $ns2 "TcpExtTCPAbortOnTimeout" 1; then
+			fail_test "subflow not closed"
+		else
+			# the worker decides right after it reports the close
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			sleep 1
+			local syn_tx
+			syn_tx=$(mptcp_lib_get_counter $ns2 \
+				 "MPTcpExtMPJoinSynTx")
+			if [ "${syn_tx}" != 0 ]; then
+				fail_test "subflow re-created"
+			else
+				print_ok
+			fi
+		fi
+		# before the kill, which can send MP_RST (checked with -C)
+		join_syn_tx=0 chk_join_nr 0 0 0
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+		sf_retry_cleanup
+	fi
+
+	# the subflow cannot be re-created: the next endpoint takes its place
+	if reset_with_events "subflow retry, creation error" &&
+	   continue_if has_subflow_retries && init_nft_filter; then
+		sf_retry_init
+		pm_nl_set_limits $ns2 0 1
+		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=15
+		{ timeout_test=600 test_linkfail=131072 \
+			run_tests $ns1 $ns2 10.0.1.1 >/dev/null & } 2>/dev/null
+		local tests_pid=$!
+
+		print_check "next endpoint used"
+		if ! wait_counter_ge $((timeout_poll * 4)) \
+		     $ns1 "MPTcpExtMPJoinAckRx" 1; then
+			fail_test "no additional subflow before the block"
+		elif [ -z "$(sf_from 10.0.3.2)" ]; then
+			fail_test "no subflow from 10.0.3.2 before the block"
+		else
+			# The subflow times out, then the new one cannot be
+			# created: its address is gone, bind() fails.
+			ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
+			if ! nft_drop_from 10.0.3.2; then
+				fail_test "unable to drop the packets"
+			elif ! ip -n $ns2 addr del 10.0.3.2/24 dev ns2eth3; then
+				fail_test "unable to remove 10.0.3.2"
+			elif ! wait_counter_ge "${timeout_poll}" $ns2 \
+			     "MPTcpExtMPJoinSynTxBindErr" 1; then
+				fail_test "subflow from 10.0.3.2 not re-created"
+			elif ! wait_counter_ge "${timeout_poll}" $ns1 \
+			     "MPTcpExtMPJoinAckRx" 2; then
+				fail_test "next endpoint not used"
+			elif ! slowwait "${timeout_poll}" \
+			     sf_fully_established 10.0.4.2; then
+				fail_test "10.0.4.2 not fully established"
+			else
+				print_ok
+			fi
+			ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=15
+		fi
+		# before the kill, which can send MP_RST (checked with -C)
+		join_syn_tx=2 join_bind_err=1 chk_join_nr 2 2 2
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 2
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+		sf_retry_cleanup
+	fi
 }
 
 add_addr_timeout_tests()
-- 
2.25.1

