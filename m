Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B04FDE7C
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166992; cv=none; b=mu/1m6NX9sSj20Cl2E6sl0wtTj9sOS1aXtqWKG896YvHTuGiDU+ImVfjiq2DvwGV05MxSH1GZZ6o1eqCJh7oPsDKi/edCLO1RekXWQTz1PTIskTUkg8cZTuRoAZJ7JzenaR414M3wbwrLG5AHa/190GT7Q6JFS5eeeCYCOA+Odo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166992; c=relaxed/simple;
	bh=p9mBzMUacHVKyLG5PiPbAa2IzLmY/cHQmQaCFfX6ja0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u7GtGRGfF9glhMbT9lPq1JyXYPSguXN2CPUsUEaQh8SiP9pycZB6M41nfcqhK2za7tOJ+HVko3cExVnI9lijctMM94S4eQPFhwgR6nqz871kbyElee+cQFKwKKAZIBRBPgV9Rc+3rFss2TfBK1mnQVO9Hjk8SJYKaCUneICBs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHJfX7ik; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHJfX7ik"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35943f55c06so187461eec.0
        for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166986; x=1792771786; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AxgDQNop4NTqKOJ1VElosCbKkVl+bWG/ZkU9owqsQQg=;
        b=YHJfX7ikKBbSyC9vXRmqWQrHCxDMb2ti0f9XJnB4Gkxv9uIx8TeQ22J9w8Zk9hdKqU
         bl/82GWhJwtj/VR3hG5qfdNciRdbZfXUUwgVTgbkji9S6Q94tOQZMmWAhic66V8V6myW
         XqkVPqcHjTLQ/xPTbk2RDKOC2tefndGtVL+qPDWhIfv9Ht5IyY5MssFV3A4pQPdxVuyD
         A+5rrHUprLj78oq6xKj787gSYDoZ+wbktCHSN5d8y11TgQnNnyWTLyDmGg3e01kwYAfb
         8w7vjaFCrREIYKsaMU2vYD3VbWZz0CnZ4TnU/594uuaLysYAPoCvAG4RWop4hLnmuhKX
         C4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166986; x=1792771786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AxgDQNop4NTqKOJ1VElosCbKkVl+bWG/ZkU9owqsQQg=;
        b=cqYjHpze+ec3bt6r1VqDO1913YMpt2TuM8UhCyfeGNng8csHl4JINkM1yz67ebEQrO
         iVGJO0eJTXEdf+MKV92Ph1w2La6nLsQ7RcoK9SnG6klGpRiEuUyAvsxf6nPrfEmTvUxy
         Kib2uxqfNn95a9wkMzYtHlKtr5qLUGXb+G/uzSXzygI2Pvd1kbbTSUVYPATuU4n9V/1W
         GsbecXjhkTdMuO03ATWZvlxbImt+sjfDlnY0gIWg/l5Fe10hc71WckIRVzp3OfL+h4Nt
         nqehkqMvpkzWiPLz45fCzwodB/AA7vuivxhxJ2FK0FXgAs2ePIq6Ygw6Fde89f80ToWw
         a8Jw==
X-Gm-Message-State: AFq9FYI8hjblVGjO/7xqqwaFt+TYkivAmi4BuQh15Lt5UpgkQxX0dl0K
	Ew8FcaCK/WdjKMJAbYTBaJ4S5aENL5OHDd0IBZBvqjbj7KI/mjNQIAI2JZkZ5A==
X-Gm-Gg: AYBFou3HNI6CmSgpNNTpqz6pZL0u4AGe7QfDpVZDHtA8qeURredLx3W1qHASldwfYyD
	/jNVY7mAln4IW2agiiWu5iCjiPjjmHCRG2lE7y12LzHaaN+cJYLDh7L8oQEvv4ythl0xHDKT+V6
	5JbKfSl3rhzmyRwrmYTaCsG3k5/pYuNeSCfmY+hbgVzLEyx3Ub6AXjR7ckVKszFdNoyu/w2fuzJ
	4ukKVInFV/kpltwLxuyGqsxC+gUdteLxRI8N34Pa6AG65+mwZXXkiW4AzwEQ9sHJ9/Up7f7UmIf
	r6x5IUNHV48JU7bDKdeqWvf7LqyqyJh5tOJnePUYqGxGwmJGcBJrGLT3oFLX4FfG0uNYYMqSbpc
	b9DCzXwxOAWnfA6ZOkrlQJG2EAEvP/PcrZ1myq56GRpt6VuB/cEWuQFTrk4KoCtSYFKQXnKTyvr
	Iw7mNXE09EMyDwnc77FA4btwMW7SYXTOkIsldBJExkKcFs9Pk4FX7mRakFMN+GpZoFiFmtqVhOC
	X/1jKs5OtseRjXuNbCaG15IdNCPyEeE31TmsKZ/lAxTEl1nRFasGlz3fdoTwtO53yG4LHLxuJi9
	xLDgdjLGnEr8wbpTeMMFhBIJvrxirBigGk+pI0VWLig=
X-Received: by 2002:a05:7301:5517:b0:361:2a55:b94e with SMTP id 5a478bee46e88-3612a55c73emr1566807eec.15.1792166985868;
        Fri, 16 Oct 2026 09:09:45 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm9099098eec.6.2026.10.16.09.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:09:45 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v5 7/7] selftests: mptcp: join: validate subflow retry after link failure
Date: Fri, 16 Oct 2026 16:09:26 +0000
Message-Id: <20261016160926.1155262-8-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
References: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
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
are removed at the end.

The test is skipped if pm_nl_ctl does not show the new limit.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
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

 .../testing/selftests/net/mptcp/mptcp_join.sh | 152 ++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaeda4f..521f95d3027f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2151,6 +2151,102 @@ wait_attempt_fail()
 	return 1
 }
 
+# $1: ns ; $2: counter ; $3: expected minimum value
+wait_counter()
+{
+	local cnt
+
+	for _ in $(seq $((timeout_poll * 10))); do
+		cnt=$(mptcp_lib_get_counter "${1}" "${2}")
+		[ "${cnt:-0}" -ge "${3}" ] && return 0
+		sleep 0.1
+	done
+
+	return 1
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
+# $1: client address to block
+#
+# The link stays up, but the client packets from this address are dropped:
+# the subflow using it is closed after a few retransmissions, and re-created.
+# The packets go through again once the SYN has been retransmitted more times
+# than tcp_syn_retries allows: the new subflow still connects thanks to the
+# subflow-retries limit.
+sf_retry_after_block()
+{
+	local syn_tx syn_rtx ack_rx before after
+
+	syn_tx=$(mptcp_lib_get_counter $ns2 "MPTcpExtMPJoinSynTx")
+	syn_rtx=$(mptcp_lib_get_counter $ns2 "TcpExtTCPSynRetrans")
+	ack_rx=$(mptcp_lib_get_counter $ns1 "MPTcpExtMPJoinAckRx")
+	before=$(sf_from "${1}")
+
+	print_check "subflow from ${1}"
+	if [ -z "${before}" ]; then
+		fail_test "no established subflow from ${1} before the block"
+		return
+	fi
+
+	ip netns exec $ns2 nft add rule ip filter OUTPUT ip saddr "${1}" drop
+	if ! wait_counter $ns2 "MPTcpExtMPJoinSynTx" $((${syn_tx:-0} + 1)); then
+		ip netns exec $ns2 nft flush chain ip filter OUTPUT
+		fail_test "subflow from ${1} not re-created"
+		return
+	fi
+	# tcp_syn_retries=1: one more retransmission than allowed
+	if ! wait_counter $ns2 "TcpExtTCPSynRetrans" $((syn_rtx + 2)); then
+		ip netns exec $ns2 nft flush chain ip filter OUTPUT
+		fail_test "SYN from ${1} not retransmitted enough"
+		return
+	fi
+	ip netns exec $ns2 nft flush chain ip filter OUTPUT
+
+	if ! wait_counter $ns1 "MPTcpExtMPJoinAckRx" $((${ack_rx:-0} + 1)); then
+		fail_test "re-created subflow from ${1} not established"
+		return
+	fi
+
+	after=$(sf_from "${1}")
+	if [ -z "${after}" ] || [ "${after}" = "${before}" ]; then
+		fail_test "no new subflow from ${1}: ${before} -> ${after}"
+	else
+		print_ok
+	fi
+}
+
+# $1: result of the wait for the subflow being re-created before the close
+chk_no_sf_connecting()
+{
+	print_check "no subflow connecting after close"
+	if [ "${1}" -ne 0 ]; then
+		fail_test "no subflow re-created before the close"
+		return
+	fi
+
+	# closed with the MPTCP socket
+	for _ in $(seq $((timeout_poll * 10))); do
+		if ! ip netns exec $ns2 ss -tnH state syn-sent | grep -q .; then
+			print_ok
+			return
+		fi
+		sleep 0.1
+	done
+
+	fail_test "subflow still connecting after close"
+}
+
 set_userspace_pm()
 {
 	local ns=$1
@@ -2585,6 +2681,62 @@ link_failure_tests()
 		chk_stale_nr $ns2 1 -1 2
 		chk_link_usage $ns2 ns2eth3 $cinsent 50
 	fi
+
+	# subflows closed after a silent link failure, then re-created: the
+	# additional one, then the initial one. Then close the connection
+	# while a subflow is being re-created.
+	if reset_with_events "subflow retry after link failure" &&
+	   continue_if has_subflow_retries; then
+		init_nftables
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
+		wait_counter $ns1 "MPTcpExtMPJoinAckRx" 1
+		sf_retry_after_block 10.0.3.2
+		sf_retry_after_block 10.0.1.2
+
+		ip netns exec $ns2 nft add rule ip filter OUTPUT \
+			ip saddr 10.0.3.2 drop
+		wait_counter $ns2 "MPTcpExtMPJoinSynTx" 4
+		local retrying=$?
+		mptcp_lib_kill_group_wait $tests_pid
+		chk_no_sf_connecting ${retrying}
+		ip netns exec $ns2 nft flush chain ip filter OUTPUT
+		kill_events_pids
+
+		join_syn_tx=4 chk_join_nr 3 3 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3 error 3
+
+		# big files: do not keep them, the next tests create their own
+		rm -f "$cinfail" "$sinfail"
+		cinfail=""
+		sinfail=""
+	fi
 }
 
 add_addr_timeout_tests()
-- 
2.25.1

