Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADC41D4F7
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297092; cv=none; b=EOdPV5AYU3d1F5STQVew4W+g8ctd13K05dfmghv94vZYeqW65z9XcaET5sRHZVEFpMCpKrV1wTM10Xrc7bGThx8LOHP7Y47YW+B4HGLqDIIYCvLuBEyaH1sEFkwpjPhlCpyW4lm13BpAFeFcLgH1QMdncdunM0BxIwttQqQwf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297092; c=relaxed/simple;
	bh=YIfRD+f0gqa/OUX+cL7hMgG8OooA1h0+p6FJowO69fU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OqEIbb9KyKfXGjWO2JLyHivMwE/RaIgJCOwfXGDSUzAl/hMVfv1sgLVB9u/46nMeE+t+FzBNBXbLmb6n5yOVMygk8k0s1gEWhN5W2g7IXVeWlInZYU4KG+5O9gqx6s148fHCxeGOS8eD2Z+qY/wJXR1GZIyGQCR/KCu4UGlz/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx2tMJve; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx2tMJve"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3282db206d3so818997eec.0
        for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 21:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297086; x=1792901886; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ceO3qms8C0xIZNt+hT1qfj+OChXUzy7jANCGZQYDp7w=;
        b=Tx2tMJvesv7w/mDj3QUS/8iyNG1Nvr79SZZ0xJiQOGRJpysHhNbbv+P2Qkc76pruU0
         +EXI3xoHP+a7I8e268QfTuD/AxJm9e7L2BgobAFFlI1Xfjw4JWhJlIIVaBc0IBcq/IhA
         IOfjuldbGrkYFo7ahlnAPiNVfMmNje7yx2BYW9E5qfEXaXktJw0vRc8StGfQLGlv8vV0
         1bRSjjm5JosPT8JRGYMhTximwndCfrv9NtdGk2cTfkQk1zk/cYlHr2BAgLrWnM5hcrG2
         YQz4qwI10k/Ajrysifqgb1rxlKU/Ws+eqSJ0PQH9E76mCB+O8gtlk/ifDyRleXqIs29y
         QO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297086; x=1792901886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ceO3qms8C0xIZNt+hT1qfj+OChXUzy7jANCGZQYDp7w=;
        b=F9Z8fIIbGgL8xxQpm6y2icxb3IGinz9RfOuKInZ9LyKWDrl9FF6nanhaHy5Cc5o0sW
         jtefs44j+WFNGtyxqfo9GjVcdSNKvkpZExlLmdFsIqh7okI554Cxls9LkizlrZ4mVFq9
         lmUhuBq5J8syzPaHc92ILunPsjk6sHFG2UzuQtTHDFbHu9Kdb4l444WAE+ywQBuO2Ueg
         /9fFO60aMT+OQgDs17GR58su5wTXhu+raLpbgpxW3xuPPNSWi2uBYRUi3gbiSq7e+lcZ
         1PjeZplvYOf1x84yddeMw23NgrZ2W9DbXtYrKIsWySA1xXE22fLefoh35F29RPEisz4w
         iuLg==
X-Gm-Message-State: AFq9FYIL4KxND9fXCvZS3ynL8vbtIWbQS+jH2tjYsQfnEVgL9SA6apQ7
	Wz1WFMlKZIyussD3ynhDq5p6nu9lBFD5JFLjzyVW2MWlJmANgEHyQ9Ozn84SXQ==
X-Gm-Gg: AYBFou1Jprp0FgFBwPcS5nmTBq6Hqwgrdl/VbBx5BlharVwootR0IEfHFR/M1cWFfD4
	5yZh8h05zMXbVKQFncNIk+iUPPhACAlEbsuK6oJLfBz6SahoL8d0/GAsVQpk5WPRCMJBUGt9EjJ
	jxjyabTGYUNQ3c9YXdUAXSQ3FBlpf82CNqTQE89XuG7cmsXIlPWhZn7vs6HFAuQPSLtf3FbrBEC
	2lXfApoiovbkdVHzDqzL1BDeRxYRROEX3JrtPGb//9npUd/M/ElxNlNn0zY3n4gLuRwsl+EmT14
	LjvhQFXiG92OeCySAtskWkW6fBdDeZsmn4n0ALq5Fba9aNWoBf5t0jD1fwnML5N+CsWJbQf6SSU
	UgrDo9VKl/F7eA5Y13RiQJxZkVNbHQSY51Tjg2ACzPIAxpeYLWEexMgwsCLYGWneZaEa0+FFQRc
	W2xHrlOJ+ZjcmltQSJqUWeJQIko4NFB8D1mXJJ54eLtnEM5w1tt7a0EsrMWKLe7atVIvDbhOPpq
	96cuuOr1+7Lo1xvIXBooBktZTDtAiafX0bcZGXmxzu5rGs9xG4TdAVcXhnG7j+NERaioGFXrJc4
	Ds9yMcwUO3N946gId+3qMybtTa678t6CA0MAXm1wblI=
X-Received: by 2002:a05:701b:4354:b0:16c:4eef:a526 with SMTP id a92af1059eb24-1851238bde2mr6383988c88.15.1792297085519;
        Sat, 17 Oct 2026 21:18:05 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fdfesm17867932c88.7.2026.10.17.21.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:18:05 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v6 6/6] selftests: mptcp: join: validate subflow retry after link failure
Date: Sun, 18 Oct 2026 04:17:48 +0000
Message-Id: <20261018041748.1655711-7-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
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

 .../testing/selftests/net/mptcp/mptcp_join.sh | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaeda4f..d4b4146cbd64 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2151,6 +2151,111 @@ wait_attempt_fail()
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
+	local before after
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
+	ip netns exec $ns2 nft flush chain ip filter OUTPUT
+
+	if ! wait_counter_inc "${timeout_poll}" $ns1 "MPTcpExtMPJoinAckRx"; then
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
@@ -2585,6 +2690,65 @@ link_failure_tests()
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

