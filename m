Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466251;
	b=cXiHxWG8BgUR/ETHOWcjKUDbVUw8gphg8vhV29SuggR/YijszDpGb6DKbwneMsBTKMo8
	 caOXW5FI5g0JxSwVgF8JCtGjuoiYW3Wkied6B7iuwRv87H0rUuZVJUhLBhV2L5AsYdalu
	 RnQPrp2cPAK18zBxTcMzLbsHEOnTC7L7hQenI9RYi6V0IUreg8VXHKg2KX9tT16MMLR54
	 VvWG8XugdjWlknI1aHRd4zIK66pq9u2VBW26E8iikIqDKBryo8Nhrb/Yhsi3m194QUh99
	 fwiQtIFSnm3z6q1IGKG5TN7dZV/FMf1nXspXI9haCGxJij8LKQlX3eFy3Ykucz24TsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TOQ1WnbEglTpWvbdcoWwCrSBhBL87YO1RnwmmpI4su4=;
	b=Z1FIcQWNeZTazs+lg/dXyw8JA8dRYTr/ZUqCVqaK3uXypDWxS+PrabtBV9Zku+h99obn
	 RlxREMmmnm/0xmy648UKmjvaOi4Argp33swVedHKRIoXnGGoKWm8tRKwtqRs2YJ73FtEX
	 sXqV0fxD/ZfNzyvyOc/izokaCqgoY4KKfL9osqC4C3X2g0xCDSQs1JddO5FgiElrXJl7Z
	 ZAaiVm8LDqHA0MzzVgjnav0oBgAoTvvKU3xkzCVzNTZN5RjI7rRamafKG0ovwUVpMwQym
	 2uUfCxr04SnDLa3IOwktcUnM1yIbH7painB43bQnrZ/JY8KD/WFu7BlPvn2QaHZ/05g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UdXJ19Ih;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22520606A319
	for <mptcp@lists.linux.dev>; Tue, 20 Oct 2026 03:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22520606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UdXJ19Ih
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-366421dc8ebso208067eec.1
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 20:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792466250; x=1793071050; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TOQ1WnbEglTpWvbdcoWwCrSBhBL87YO1RnwmmpI4su4=;
        b=UdXJ19IhG5Bs4KHf0Pot8cfE3uUdAkzy1ye8D6ouhY9ykfDf9dydYgGLwsTHTBp8Q0
         UL0JmJGYS9hCcyt49NsLAlW1Kcw/JpGiLK0uUcvz2xIL37IE+E6QywVkpTDChJ+1aClY
         mOkGsG7pt1qULpyqFBxI4gWIstizgt4hHh0Yj16WE4LYOVADJ1wN2Cg8iJDYpx3VPVeG
         jYa/H+BHRWeiB3SNYhRtHLGXkrOPaL+igKYn/IifcsGuUA75kG7U9bt+cZLwi3ZxbdV4
         HtbWCjCq/z+sQmyMF5vl67317VJ73kklTqMOs77ErK4kF5+sB1MkC12eT31d/PjO4o/Y
         qjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792466250; x=1793071050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TOQ1WnbEglTpWvbdcoWwCrSBhBL87YO1RnwmmpI4su4=;
        b=BiOTDD0Q0OiLdBxFd3fkaZ5ylwXqyiKGv3tusFtaePX8MxVDvx6GxSn7n1Pv3UdXpa
         CBs8b7YTCH7h441THeKrcaa09KYfZFV12f4fn1EgTvOcjKKmQlKVgH6oyr3Kv96Pu0kT
         2RQl3zPyJWtyVq1egcSmMbiEqvf/kspkJgB0m39i+86PdvVevjVObhetFXOuvO1+QHhg
         fS2lv84aN1mjP1/mTGSSwuX5YkvrT6GhEtEIcbGQZs1r0x6zPmP1dlxRVKl9MLyitqZ1
         5qowCe7iBVp8anTMhI5d+Cn7TQUeWBsaGhuHYoUmY1YfTjQYvOZ0yQUFaBjyuOMzh4MS
         mh6Q==
X-Gm-Message-State: AFq9FYKtOHRAiPTtjm2agH6HzAsJvhG4+JvTTFiaj6Pi9qU+TkrUR0X0
	YqMak4BEQqYI9oC0WdA+DawchZY0isHRDyuJ64ilQGrZtCupYsgfzze0ggD8mQ==
X-Gm-Gg: AYBFou0Owx/8pkOuWSXFThFJEMUD5DyZ1B+J7L091bbIC5UxK9Br2cHLgqpMA5cBYi6
	M4BIg8yM+MKzsgCddTM2dXLQqFnP8OCiMExxZbHLbNCp21IC/I3pXDZGCoM78xEqZZlUb26ubvg
	cLW0oV23IXNArm5CPy7BzGjhUlIQpKed4cCLxaPcMocgEPPm2FDoNEZNaUlivKVwPmDSPJ4q3yX
	q5EapaxrRZfF+l8/cDM/s56pTJEIJcGQZaGraCq4KpN+XvHCqMoIWZYjQoHqWbO8CzSXpJEh+ct
	4nj+pzC9nl9CpEccp8cWMM7xUU3LWN/j9+Q5X+6sZohb3MaYvmNLfg1OB2kbWAtYLPK8DELSywm
	yXi/pgIXrzhvdYftdlP8WWbtgd74Ssws5Gek4/cVMAS3T4f8/WhQun+l+1qTF8zrzXKx+33fDZu
	1cp2JK1byN98ciewmMOwu4rNwRFSeHLg0FMwJP9R8CXOcSJv8q/6ECPI2vPMVMkN4iAdEIzA19P
	69YNtWau0dRKH++ferHM0GnqXTw/pvFDFBuU2u4QxeqksoL6svXfufyMapbFv65cyHwS7eNQ5cS
	Lhxz1JR8L14RcCi+k524vXJVJfxdXxqezsGmm2t6FVk=
X-Received: by 2002:a05:7300:ce81:b0:35c:3057:5ff2 with SMTP id 5a478bee46e88-365fa492837mr1058034eec.9.1792466250108;
        Mon, 19 Oct 2026 20:17:30 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm38473608eec.21.2026.10.19.20.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:17:29 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v7 6/6] selftests: mptcp: join: validate subflow retry after link failure
Date: Tue, 20 Oct 2026 03:17:11 +0000
Message-Id: <20261020031711.1896660-7-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
References: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
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

Finally, close the connection while a subflow is being re-created, and
check the netlink events. The big files used for the long connection
are emptied at the end.

The test is skipped if pm_nl_ctl does not show the new limit, or if the
filter rules cannot be set.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
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

 .../testing/selftests/net/mptcp/mptcp_join.sh | 178 +++++++++++++++++-
 1 file changed, 174 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaeda4f..a99cee39da63 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1137,7 +1137,7 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	# create the input file for the failure test when
 	# the first failure test run
-	elif [ "$test_linkfail" -ne 0 ] && [ -z "$cinfail" ]; then
+	elif [ "$test_linkfail" -ne 0 ] && [ ! -s "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -1146,7 +1146,9 @@ run_tests()
 		size=$((size*8192))
 		size=$((size + ( RANDOM % 8192) ))
 
-		cinfail=$(mktemp)
+		if [ -z "$cinfail" ]; then
+			cinfail=$(mktemp)
+		fi
 		make_file "$cinfail" "client" $size
 	fi
 
@@ -1157,12 +1159,14 @@ run_tests()
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
 
@@ -2151,6 +2155,113 @@ wait_attempt_fail()
 	return 1
 }
 
+# $1: timeout in seconds ; $2: ns ; $3: counter ; $4: increment, 1 by default
+wait_counter_inc()
+{
+	slowwait_for_counter "${1}" "${4:-1}" \
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
+	local before ack_rx
+
+	before=$(sf_from "${1}")
+
+	print_check "subflow from ${1}"
+	if [ -z "${before}" ]; then
+		fail_test "no established subflow from ${1} before the block"
+		return
+	fi
+
+	if ! nft_drop_from "${1}"; then
+		fail_test "unable to drop the packets from ${1}"
+		return
+	fi
+	if ! wait_counter_inc "${timeout_poll}" $ns2 "MPTcpExtMPJoinSynTx"; then
+		ip netns exec $ns2 nft flush chain ip filter OUTPUT
+		fail_test "subflow from ${1} not re-created"
+		return
+	fi
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
+	if ! slowwait "${timeout_poll}" until_counter_is ">= $((ack_rx + 1))" \
+	     mptcp_lib_get_counter $ns1 "MPTcpExtMPJoinAckRx" >/dev/null; then
+		fail_test "re-created subflow from ${1} not established"
+		return
+	fi
+
+	if [ -z "$(sf_from "${1}")" ]; then
+		fail_test "no established subflow from ${1}"
+	else
+		print_ok
+	fi
+}
+
+no_sf_connecting()
+{
+	! ip netns exec $ns2 ss -tnH state syn-sent | grep -q .
+}
+
+# $1: result of the wait for the subflow being re-created before the close
+chk_no_sf_connecting()
+{
+	print_check "no subflow connecting after close"
+	if [ "${1}" -ne 0 ]; then
+		fail_test "no subflow re-created before the close"
+	# closed with the MPTCP socket
+	elif slowwait "${timeout_poll}" no_sf_connecting; then
+		print_ok
+	else
+		fail_test "subflow still connecting after close"
+	fi
+}
+
 set_userspace_pm()
 {
 	local ns=$1
@@ -2585,6 +2696,65 @@ link_failure_tests()
 		chk_stale_nr $ns2 1 -1 2
 		chk_link_usage $ns2 ns2eth3 $cinsent 50
 	fi
+
+	# subflows closed after a silent link failure, then re-created: the
+	# additional one, then the initial one. Then close the connection
+	# while a subflow is being re-created.
+	if reset_with_events "subflow retry after link failure" &&
+	   continue_if has_subflow_retries && init_nft_filter; then
+		# slow links, short queues: the transfer lasts the whole test on
+		# any machine, and the blocked subflow always has data in flight
+		local i
+		for i in 1 3; do
+			tc -n $ns1 qdisc add dev ns1eth$i root netem \
+				rate 4mbit limit 30 delay 1ms
+			tc -n $ns2 qdisc add dev ns2eth$i root netem \
+				rate 4mbit limit 30 delay 1ms
+		done
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_linear_timeouts=0
+		pm_nl_set_limits $ns1 0 4
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+		# created here, not in the background job, for cleanup()
+		if [ -z "$cinfail" ]; then
+			cinfail=$(mktemp)
+		fi
+		if [ -z "$sinfail" ]; then
+			sinfail=$(mktemp)
+		fi
+		# killed at the end: the timeout only stops a stuck test
+		{ timeout_test=600 test_linkfail=131072 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		# the 128 MB files are created first, that can take a while
+		wait_counter_inc $((timeout_poll * 4)) \
+			$ns1 "MPTcpExtMPJoinAckRx"
+		sf_retry_after_block 10.0.3.2
+		sf_retry_after_block 10.0.1.2
+
+		local retrying=1
+		if nft_drop_from 10.0.3.2; then
+			wait_counter_inc "${timeout_poll}" \
+				$ns2 "MPTcpExtMPJoinSynTx"
+			retrying=$?
+		fi
+		mptcp_lib_kill_group_wait $tests_pid
+		chk_no_sf_connecting ${retrying}
+		ip netns exec $ns2 nft flush chain ip filter OUTPUT
+		kill_events_pids
+
+		join_syn_tx=4 chk_join_nr 3 3 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3 error 3
+
+		# big files: empty them, the next tests write their own content
+		: > "$cinfail"
+		: > "$sinfail"
+		: > "$cinsent"
+	fi
 }
 
 add_addr_timeout_tests()
-- 
2.25.1

