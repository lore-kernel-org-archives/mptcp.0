Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795308494;
	b=hYCUxE7kLMna0UkqX6QIpxebr2X5E1kqw/rOubjdyg6YGPViuCVPeYp4hvS7kOSd01If
	 QBEVFv4L1rJP3EZNiQ3/mFlKjMj/hjcmv+biyWiEQrBgkKxVAzcnlUVb9vG7mlmolTVPm
	 rfhEz5FYn9+WZ85+bUCJoEcd58N/X+S45kE8DT2SbFgZKiDxmGEN9UdzfeNeO4mV2o1oo
	 h5fw/NooBQlIizFLvAKyA8S0vzkJeCMDKAoLIxJkuVUouyI1mFyRcUejYXtnY+sqgqOdt
	 yRNV12PVEj5Qe3qWh4EcUo9MwLWgxooTEOYtenVLBMYJDksVjZP2HJ0TK0TA829VguQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795308494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dhnOE4qopn6jNjNMYF0/PWGf7rkg1z6f8VpVTEcyEvU=;
	b=vuj1fNVZuNdcN5xgbdXXnUAWaRwA6LaZneyjkwelanQ7FV7+8LaBwI+qysizAW6tBsmw
	 5CEly8fSgcF7+/nhEEr3EDk4E6nawKtYQPg5l4/vsEdIKenht3rGMbPyZ8lxAzd5uqC/5
	 /22U4TO6GXNB329S21nOV4HtfF6sv7XtpdxacH1vHrnIDOT3azd3sCT/VSu9Hxzk+s/24
	 PHnfqLbfimKh3noIRnDYLL8/6elCQp8gPk+eDftALvjFxAyouteHXzwaOihu+YUxvuYS8
	 uKHKdC1A1+NVmUDi5J0WnC1LWe9GUu4Vy1SyiLB6WvdkOmNgphgo7j9ITa2EuDLfgEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iIBKSfr8;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E7606A333
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 00:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E97E7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iIBKSfr8
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-380b40312e2so4779383eec.1
        for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 16:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795308493; x=1795913293; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhnOE4qopn6jNjNMYF0/PWGf7rkg1z6f8VpVTEcyEvU=;
        b=iIBKSfr8Mdii3d8Qla8gbAYQsPy04Q7HNQ2zmIgFy5uciiMchSnOeHDHdOkpVpzvyL
         chrB6fWeZbHTSEj7blpWW48kengq04aevKb0EK44j0tz68d7JqxeXGAJj3evZBCoQ/Tf
         Wb/5RraUIeuVNJRZhZTPmZMEmdTjk24Rl/Zes8Q5Ia1cBrgkGES4jl3dx+6k1SEp2dxK
         0DAfZ6KmE6fSxy9/jW6CIj3jG64/CY/JH93QozspYVQcMWYvpAj4zwVhFXZHKNCrlr4l
         n8MLar8Gut25qPzPo2hRMhFvSixk4uqqE93lPpsIV+WwsCwBUD16/GF8nv4gygRH/Lt0
         LVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795308493; x=1795913293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dhnOE4qopn6jNjNMYF0/PWGf7rkg1z6f8VpVTEcyEvU=;
        b=RloLeUC1BUG/3dG6jLM5v2rGmHerqG9GTw1GbZgSHvHyhlOlB8eiCanCQERHEuKsFs
         /hIF9G2EjozJ8YVqvMHatsgyqJrkx7RMAxQ0WCI1Pest3f0xHTmxAXLgwWPQl+Av70ya
         KmHoPtKLsga2+/zsgDxzsyUMbYX/wrTHhOPkOqpKKPnEsLZGBpilIW+RXqHELbZeQ7IA
         b1hO/QJc++LrO50YSMwPW1V+b6p8CQifZ4lN8iba1BuxP4SjCz3v4ghJ0UWfsZhMRuYD
         cywD+9F7wVb06CJYmVTk11GTtdeIR8qlZryCtI6I+lI6fWte0fZBxXYFIqrgFCCVQQtb
         SYbw==
X-Gm-Message-State: APuU4Z8ZisWuqaSWqTnIewA/HiiX5eG9l2UytGjOFbMf0f3xMKbPOPRD
	8yUvhZYQwpX5lFVAoMsSRJ4pDHjkan7Glkyd5Tkpe+4lUUPO1fu2KJSCKJHmFg==
X-Gm-Gg: AZFdTZcUZUgud7Pejnl0dqjek7FFub/D7MdPPvK3LgtuOexenhwXLQV+ffXBeGePBEB
	Km8AkcH218vW3XfyAKsQmFIdtv5Mke2usNeO1PW04QLzmfM1UI1mgOJyhDTpzEDy2Eh9nRxSIlt
	KWXWWfb+4h6gtCG0ItdfQ87CK0V8aQtmUYIOhif7reH3sZiaXOcvZzQPvf/WIAmQUTTAyURDtSJ
	ezANo48vTXMJqnHnA1axDq2wKBC+yHfbxt94L4zbkdnKHIlDuFkl1/pm9ES/bAWcGs06rNOWfv/
	9FHPpi7xdmCcRDBQC1eSFQdvPf8KshfuA1Bc76MB45Km6mPDlZxFrUrFvb13igjgN8zGUEGWB30
	DPAbbETDPYEKi7P2dci9E0rxTvXEZOxuLv58Hrh6JhPS9maiQo4pGzt/xwof5NAzJjcsXLNdjmC
	As3uMwRdtn1ZcHpQ6bi/N6h6QSeTEIoaUS4A/n42ZHZ5D8ewLg6WI8fTy9rcd8PD24N2+efvede
	oM/ytR1VTUW4E1EDYlieMgObtfclarckkU1LSbnRxoI9dlPXJsd6OKbrGpif43z9nEDymy3hW2I
	Iu4eZb8/wBoornDz1tiGKmB37VNXSCouxouofEfiV4EGmbUGE3MHH/LLsoEFr9L2Dimops0AzIP
	yvFkXiZAFbQaEhzjILZpuOXwCS3fJLvQQ+pJZXkF7KNVJ5Q0oaCCwXAzsyVx3HEHsyiDXiTJ5iQ
	==
X-Received: by 2002:a05:7300:6018:b0:381:9593:9984 with SMTP id 5a478bee46e88-3857151d6abmr7136350eec.37.1795308492656;
        Sat, 21 Nov 2026 16:48:12 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm20219599eec.16.2026.11.21.16.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:48:12 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: anilkaushikwireless@gmail.com
Subject: [PATCH mptcp-next v16 7/7] selftests: mptcp: join: validate subflow retry after link failure
Date: Sun, 22 Nov 2026 00:47:54 +0000
Message-Id: <20261122004754.2276802-8-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
References: <20261122004754.2276802-1-anilkaushikwireless@gmail.com>
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
filter chain cannot be created.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 420 +++++++++++++++++-
 1 file changed, 412 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c3ccce96b45b..82240addfec4 100755
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
 
@@ -2151,6 +2161,210 @@ wait_attempt_fail()
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
+	# a short timeout only while the path is blocked: it is per netns, so
+	# keep this window short, the other path could time out on losses
+	ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
+	if ! nft_drop_from "${1}"; then
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=15
+		fail_test "unable to drop the packets from ${1}"
+		return
+	fi
+	if ! wait_counter_ge "${timeout_poll}" $ns2 "MPTcpExtMPJoinSynTx" \
+	     $((syn_tx + 1)); then
+		ip netns exec $ns2 nft flush chain ip filter OUTPUT
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=15
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
@@ -2585,6 +2799,196 @@ link_failure_tests()
 		chk_stale_nr $ns2 1 -1 2
 		chk_link_usage $ns2 ns2eth3 $cinsent 50
 	fi
+
+	# subflows closed after a silent link failure, then re-created: the
+	# additional one, then the initial one
+	if reset_with_events "subflow retry after link failure" &&
+	   continue_if has_subflow_retries && init_nft_filter; then
+		sf_retry_init
+		# lowered by sf_retry_after_block() while a path is blocked
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=15
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
+		# the listener could be stopped before it got the last events
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
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
+		# lowered just before the block: both paths are used until then
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=15
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
+			ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
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
+		# the listener could be stopped before it got the last events
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
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

