Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681910;
	b=qMEGjvG6Q+oidpPe4irTgvdC3/auA7/tn5Jk3G4+vdnfgSheWRg57xVCCRFfrDVdVeoa
	 0pJTSlLgrr7mb4zHDccaYWLxzF1eyMr9+k8uyMzXEh6GTrECjvTnSN6pOJzhuReWATez1
	 ayT3akNq2pQJq5tKSYfIHWRuo7jvjKeFa0b8V5BYKCHqD0F91QN5A1q8OLxKo5JzH3Zhe
	 UxCiVoJ2CbupxKB0KpEw3ww/43CbnjqQP8JDcQbN/4+d7OOqwZc2z0ZdntAZnGtLxrKVi
	 fdf9kJY5VNGYPMYCFiXSJ0tHazoaoorM7OTxXL8ixu2jvDupfBED7R/Goz7xLjRm3Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l7wMUrOVYKa1MlJUR1Hai6f3kv1G143G/nH8/kWLSEk=;
	b=L6cQngnGSVfjj4lvIp3DZ9nD1bxfWRGJREYuPSbRBJb57FWTOfGo/L4Y6unGb0+u7JOz
	 DMwx2WX71tsYiVpcrBpuN2tUbb10wDu+Woj8rl2o8wTaSxGdjFdo8Lq+2+x57+DvBZ+70
	 ZB6cXuxsUuaJo0zf9CBJOgDqjJJtIxEizhugcSlmvA3GcX64zVJtLrGDxcWTjGNeAHYob
	 brbcKV6yU8oI3QCLZ9IceWXS8UF6VyPmvq/oy6vduaUN/vldB68R0oh1n5BHDFIOFh1g3
	 47lloxm/zLNyY7+5m3jFRTcqVQ+52eS2fhc1rWzY5EMbN3E/l2SHgA3JYmDaaJv1hZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KR2cQ1ws;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2B60A6F66
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 15:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD2B60A6F66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KR2cQ1ws
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35f036b17easo117076eec.1
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792681909; x=1793286709; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l7wMUrOVYKa1MlJUR1Hai6f3kv1G143G/nH8/kWLSEk=;
        b=KR2cQ1ws2RR1UcUEqqjz1m8tRGn8oUr1K+btFCz+EIiXB+jaMte6jCJH67TEkrTxuM
         oC30BIe3TvqWZvYMD3XH4KZd59An8PtP2k2rpEis9lk+cALLO5/C3k3mIUWnzLAUKbVL
         RUZo8+JHEfJFdLCsnHxmbZmRExOea5O8H3RZoiQ7DaDdlZUgDw/nydnelB/Mhjkinzvf
         M8RDsgU19ARUuZPjvUc2syxbHRkGoRyTYJpfHXlBHF2f3v0Jc81xFdtOa2qS2LRKPaPQ
         A7avoFanAN+k80NtXHlzQCDcv08LeO6u6qHDib97+exj/oSskDzmfl6rV7OQA4ulydWF
         EpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681909; x=1793286709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l7wMUrOVYKa1MlJUR1Hai6f3kv1G143G/nH8/kWLSEk=;
        b=ZifKucz+wA40OfbVK6RCxlxNgVaKtZrjUihJIHeKj6Ia4gwIhxzwPX6yyBDn5A/pDY
         61+GlcGEAUhN3MPpfKWxlAnUFGyYxdSyhyZcAN4kmv+nN2OsSrgYcmM98tzqP9dVIxun
         sFXJ0crOPm2Qx7/40utycOwndXQgCM/sPaZWfMKTzVsjVJLD7VGKvVOsZ6sfsq8TLuYs
         G987P+YrrsNxE+1E6ocV5d0ZwRNaw7p4u1nbg5J+qTVg8iGkcASVnSfRGbqra4HyQEQb
         d+AwLu+2GMNXScZUQLIo2fuqQy1Hb5OxlebCwAryLmBoj9J05Eoi28CoKvoHdeEEnMfG
         i8pw==
X-Gm-Message-State: AFq9FYJdJrF0Uk4CI7IJ7A1hmybQgB27Qep/Fbv8dDh/TMFV8tImCtny
	SrmxyGzl5JOAEapM3PFJSep1EYT6+O65tdKuqwSc3lhip4/WR2e7kZy3TgVmdg==
X-Gm-Gg: AYBFou2v27ZqlqxdjlBl0OxEuoMQvq0zqcPPscPNWO7VL/lGhxsmw/G2q82KRA3jNkG
	A63j9eQGucFaJJuAEGViuCPNGLGCBcGIA0M9Q44Cc/3Wd9cShUt2zsrOBvtMVLbwb4I8+CAUxIl
	dJBVr+zbMcOBirBTWk/WVwlQY3t3UDJsfdDaZb8h9MPnag0KI58ZCXfcODV+VdsGPYyJ+BciWHn
	a++oYdBuf/yM+YfFLAGlZUGUt9pU68p61zYPAkGlPMWw2zwEoSErcFCth+pW34jurgLn6SQFmDz
	Cw+VJ/2B3lrzl7leyhfoZX4DPU37IUOAvliNASsWQMrEOty2DFmo3A0EqNvPsNWaVfs9OU+FkfM
	bq1EiAvaiJPtyy2Uw9+MBWgbx7YO5oDffO0AisDgJdLWgt+LtzOY0m/ipT/3/DsQuNCoPMCoHmp
	8eFP5XPBH8Xf8tR3kaOEt71JiUh+l6ceQsbSENo5msIE7GJbyB3kW5/Ep3wl14TJh3sq7B6HDiH
	dWHsLH143YgTg99PMvlRu35Y97uFQRjoGoGfMM4JQCj0naGGbN1+/cG7YDvaVk/kR9LizoBqQwo
	4jEsJLy1EyWIUCRNHyHQFjjuSXmoWdzTP2ekmw7apr/jUuEmHNMzsLnzFqXn67aDYsJnos6vpP9
	qivPsO66QlX9Gf372FjisIAUk
X-Received: by 2002:a05:693c:88cb:20b0:368:74ca:1c5 with SMTP id 5a478bee46e88-36874ca066dmr4083856eec.37.1792681908571;
        Thu, 22 Oct 2026 08:11:48 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm36327560eec.26.2026.10.22.08.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:11:48 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v8 6/6] selftests: mptcp: join: validate subflow retry after link failure
Date: Thu, 22 Oct 2026 15:11:30 +0000
Message-Id: <20261022151130.2285198-7-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
References: <20261022151130.2285198-1-anilkaushikwireless@gmail.com>
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
and checks the netlink events. Only the client sends data, the server
keeps its side open, and only the client is closed: it has nothing left
to read, so the connection is not closed with a fastclose, which would
reset all the subflows anyway. The check is skipped if a fastclose
happens. The big files used for the long connection are emptied at the
end.

The test is skipped if pm_nl_ctl does not show the new limit, or if the
filter rules cannot be set.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
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

 .../testing/selftests/net/mptcp/mptcp_join.sh | 263 +++++++++++++++++-
 1 file changed, 255 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaeda4f..27cd37347d5d 100755
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
@@ -1038,7 +1039,9 @@ do_transfer()
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
-	if [ "$test_linkfail" -gt 1 ];then
+	if [ -n "${server_in}" ]; then
+		listener_in="${server_in}"
+	elif [ "$test_linkfail" -gt 1 ]; then
 		listener_in="${sinfail}"
 	fi
 	ip netns exec ${listener_ns} \
@@ -1135,9 +1138,9 @@ run_tests()
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
@@ -1146,23 +1149,27 @@ run_tests()
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
 
@@ -2151,6 +2158,183 @@ wait_attempt_fail()
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
+			kill "${pid}"
+		fi
+	done
+}
+
+# $1: result of the wait for the subflow being re-created before the close
+# $2: number of MP_FASTCLOSE before the close
+chk_no_sf_connecting()
+{
+	local closed
+
+	print_check "no subflow connecting after close"
+	if [ "${1}" -ne 0 ]; then
+		fail_test "no subflow re-created before the close"
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
+	for i in 1 3; do
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
+}
+
 set_userspace_pm()
 {
 	local ns=$1
@@ -2585,6 +2769,69 @@ link_failure_tests()
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
+		wait_counter_inc $((timeout_poll * 4)) \
+			$ns1 "MPTcpExtMPJoinAckRx"
+		sf_retry_after_block 10.0.3.2
+		sf_retry_after_block 10.0.1.2
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		join_syn_tx=3 chk_join_nr 3 3 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2
+		sf_retry_cleanup
+	fi
+
+	# close the connection while a subflow is being re-created
+	if reset_with_events "subflow retry, close while connecting" &&
+	   continue_if has_subflow_retries && init_nft_filter; then
+		sf_retry_init
+		# The server sends nothing, but does not close its side: the
+		# client has nothing to read, and the connection stays
+		# established.
+		local srv_in srv_in_pid
+		srv_in=$(mktemp -u)
+		mkfifo "${srv_in}"
+		sleep 600 > "${srv_in}" &
+		srv_in_pid=$!
+		{ timeout_test=600 test_linkfail=131072 server_in="${srv_in}" \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_counter_inc $((timeout_poll * 4)) \
+			$ns1 "MPTcpExtMPJoinAckRx"
+		local retrying=1
+		if nft_drop_from 10.0.3.2; then
+			wait_counter_inc "${timeout_poll}" \
+				$ns2 "MPTcpExtMPJoinSynTx"
+			retrying=$?
+		fi
+		local fastclose
+		fastclose=$(fastclose_nr $ns2)
+		kill_client
+		chk_no_sf_connecting ${retrying} ${fastclose}
+		mptcp_lib_kill_group_wait $tests_pid
+		mptcp_lib_kill_wait ${srv_in_pid}
+		rm -f "${srv_in}"
+		kill_events_pids
+
+		join_syn_tx=2 chk_join_nr 1 1 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+		sf_retry_cleanup
+	fi
 }
 
 add_addr_timeout_tests()
-- 
2.25.1

