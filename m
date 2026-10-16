Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4B348898
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129822; cv=none; b=ErQdibXjSiJSBT7CwStjcpTiJingWmwGZjLBFYJfvXNxBAg11GKzjyHyjFyaruteFC+wLVFz1DWJoU1tTlbs2naXkp/TF5hRW++r8TRjkuHgPnOnSxej+438omwUHaWaKArGlOrV+UvUljRDJt3OcNrTcSLRtsOBaSWgACvja5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129822; c=relaxed/simple;
	bh=rUu5np4JXykcROt3nkm6iG4eCUYnOTrIg+pLYFHxW7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PysDHbw8AisxTxRVkwMY27ear0phj2EnQu+kmHFUZkTH8tOYHYRpmasdrxG9tAi0dvcF3JSvihH+hLjTKSHYcUgM6y97jDNmgfxiM1pV0/q+IRw01urI45kCrpRW4XXsD8WcX9xdjfLg/tMqwZf2OJnXghtK7Tt5zhrDB3O++bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNNvGx0G; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNNvGx0G"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30b6dad2382so14530121eec.0
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 22:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129820; x=1792734620; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j9jK8yY7aOE6FMRcbCwKNbrELjKrtKzh9llUuPjP+DA=;
        b=SNNvGx0GGGeaI9bJFRbKf+/AL4z7ewnwB0w07FVmYjvvltIY7GCbB9rvopN8sZ6OWt
         ZIL2lZ+5iEhX+moYuKIqFnpfrW4E5pDvlRhKZr6s/nFukTBODAySYQT4JtfRE/0lFpS/
         +6yB5NRg6yavCSfMFcxAmAJ1lQIn5xYh4OdcjprENGHcr4BecZtenKTIKxSnG2K5BtPl
         3zvVRDcaiNRkh1sOsxsndf+1zSNSTa1UejTOSp1fclO/7V7h3COM4M6aOUAsxsBmbmpC
         THy9iclQx1lPDg9Y4JKhTxZCsmHrTHIK0uB1krh6HRIYItTY0iFhF7tdKx+43Hjk3H0t
         q0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129820; x=1792734620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j9jK8yY7aOE6FMRcbCwKNbrELjKrtKzh9llUuPjP+DA=;
        b=L4MiPCSxzwOXQ0TkAOZ27Ho9NsSamoFnU+VwlZz1PUOelKKdz2t6gCcjRkDVbZih8s
         M6p+zS6dx7Q1AM+160c60QJlvVEBs4pE92qf8/Oj4/uf8fmxw4UiSaMTB7LHDe5G5SS0
         Jc3MRVu4PbmAU52vUAi2jFYOGddU4gIZta9rFhZ5qUCi2NPNZ5Nl7r6He7lxFQcmuScq
         s2v3vHI8B3xetobA5R8svAWJgYe6sjbXQZaHanG7Kmu2ClQjGpTTnMsHVocWakj41aBS
         hVCg9wgFC389ki8sZR2JlaDzk6GxAi+142Jppah7t6GgnP/DZKo4q9L++2tWghEwTFjO
         b91w==
X-Gm-Message-State: AFq9FYKvbpaZgs6pGjYCabY6Z2W6Cnx0YC2UJVc0PnGxPn2RCVCAmB3l
	5YrcB8H/3eWdXZWjQzo/GxtkLhy7o2Q+iWqG4Wf1nZOmk4Fvl2VQM1KjE3XULA==
X-Gm-Gg: AYBFou0IKO2tVhIsjjY28A/ywl0c80RIM1Xj3DnzuF1TtWswvl39xaw+2P53Ycx8v3C
	ikzDkHRQAYjU++L2I97MXeVltr3/kZJpNsFW3SnQDNU9VQUHwC9/nBU44+Ebztja/QewsBSan6e
	z4hyIVVg9s+6pdOjCq4WB762HsIQYOFsycFEBeItXsK/8WAi5zWLh3li8CE8fOiXXCM0Bod//wd
	eARq9suGNmdTF4CMCbkAi/g4VTRGRVhLa4SZB0eEddcQkQNacsfu+Qn/hqR/SlSm97KdyCYyg3F
	YX/NuH9z6NWMVmku3c5aBc9kiVJsASBCRjBB06gzyTwvnZAdbncLL0/dbgMnfiroF//ZgudZ5BN
	3sbNotGEa8Pknx/asarhurUk4cBjSe/IYfkjYfX2JQE194JRXPKeb1gM2Nxm6RdO3jdNq1PIemk
	iJJgyt5UPFJCGF9ZGj2l2vJ5Cnz8/ux+DIxfugaMlVTmApm3DzPSIKW7AVnN2sXz/A5GUM3xozO
	Vz5/rzeYCicRN987a+CyuypT3V7liizJLtoWt7+1thMsturVGEDIGY6OvzxZMwHH8oHqCK/YVNY
	5zGKMTGVRpk3+KgCtSMbDbnNTkVtl50AiiVWjphoeDk=
X-Received: by 2002:a05:7300:ec8f:b0:360:b8b4:840a with SMTP id 5a478bee46e88-360b8b48881mr1121103eec.39.1792129820285;
        Thu, 15 Oct 2026 22:50:20 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm3928803eec.6.2026.10.15.22.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:50:19 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v4 3/3] selftests: mptcp: join: validate subflow retry after link failure
Date: Fri, 16 Oct 2026 05:50:10 +0000
Message-Id: <20261016055010.980819-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
References: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
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
later than tcp_syn_retries allows, and check the subflow comes back from
the same address. Then do the same with the initial subflow.

Finally, close the connection while a subflow is being re-created, and
check the netlink events. The big files used for the long connection
are removed at the end.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---

Notes:
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

 .../testing/selftests/net/mptcp/mptcp_join.sh | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaeda4f..bbeff6739c5a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2151,6 +2151,69 @@ wait_attempt_fail()
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
+# $1: client address to block
+#
+# The link stays up, but the client packets from this address are dropped:
+# the subflow using it is closed after a few retransmissions, and re-created.
+# The packets go through again later than tcp_syn_retries allows: the new
+# subflow still connects thanks to the subflow-retries limit.
+sf_retry_after_block()
+{
+	local syn_tx ack_rx before after
+
+	syn_tx=$(mptcp_lib_get_counter $ns2 "MPTcpExtMPJoinSynTx")
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
+	sleep 5
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
 set_userspace_pm()
 {
 	local ns=$1
@@ -2585,6 +2648,67 @@ link_failure_tests()
 		chk_stale_nr $ns2 1 -1 2
 		chk_link_usage $ns2 ns2eth3 $cinsent 50
 	fi
+
+	# subflows closed after a silent link failure, then re-created: the
+	# additional one, then the initial one. Then close the connection
+	# while a subflow is being re-created.
+	if reset_with_events "subflow retry after link failure" &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_kernel_retry$"; then
+		init_nftables
+		init_shapers
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
+		ip netns exec $ns2 sysctl -q net.mptcp.close_timeout=5
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
+		{ timeout_test=120 test_linkfail=131072 \
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
+
+		# stopped at the latest by the close timeout
+		print_check "no subflow connecting after close"
+		for _ in $(seq $((timeout_poll * 10))); do
+			ip netns exec $ns2 ss -tnH state syn-sent | grep -q . ||
+				break
+			sleep 0.1
+		done
+		if [ "${retrying}" -ne 0 ]; then
+			fail_test "no subflow re-created before the close"
+		elif ip netns exec $ns2 ss -tnH state syn-sent | grep -q .; then
+			fail_test "subflow still connecting after close"
+		else
+			print_ok
+		fi
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

