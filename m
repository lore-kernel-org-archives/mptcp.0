Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786FA47DD70
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825475; cv=none; b=uvpM1CSZ84xI0AIO3Y153MMoS57jVISvEKBOG4r7vKYHv7wDBDvsGp7U2Syb9bjcbyrFLm0GSSCIojNF9UB26Nq7+snZ3AJlPwmSZPTX51iuSeDt7L2nEiay5Xp7bftLBquiyHoLlMLPRa/YHGSV+WiurGdPcBsxcQE8jRAYyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825475; c=relaxed/simple;
	bh=CjyUQUREFs0urTOQRtBMS4fpiMs0X4LeCzdL5mOOTuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqobPZX5lTAST0yhRcSp2qZgPqBqvPF51VTGlkLqu5XuV27ucUlgLI02kEGosudyq1Xg6c9NVnizKmFptgIANAFd7dsX2Q02rBdt/hYlnDzMwTGFy/Ohp+z8ElvM9/9BlmIiyV1VsYPOqvHA7naFxhyJ8qnoMYl4xYtA1DrDbEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqWLZ74x; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqWLZ74x"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30b6dad2382so4938889eec.0
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791825473; x=1792430273; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y7VfU9eKuSoXYcsXbS4ZFh2BTt6/q7+as4FIIO+e73w=;
        b=EqWLZ74xq7wt/QH6ZW+LdNuYxlAVHedwXmyLSPTb2xgjsed0FSNpSD8q+wX9I4LwBH
         zh1amqIVIZXES6kCwKc4Jc9AVMzcMzxQUJVghd0g9dVVdD3/tIKtmbWx9mT7s7UN91pg
         xhyJrRk4z7xQcOlKO2rghpKt4Wdmjxsr9ZbgTQQw1eVlvG2H9Rcl12NnNtADJpUZvz6b
         ypvIYqrLxx04UNdvF7wcjV8C3PW5s4UgJmEIo4p6PORN4cL7OYA+3YIrfMKAqlbcNGCX
         x7nQ/goU4SXYtUVYX/lMgRI1Sc62nBSt4SYEoWN5FhP9wmyGf/M6owikqNWz+730A7U+
         KzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791825473; x=1792430273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y7VfU9eKuSoXYcsXbS4ZFh2BTt6/q7+as4FIIO+e73w=;
        b=r4e4n6fMQC8BZ6B0dYIuFv8yCjSa2QsVAScyd1PoUHT3ak//Pk2Qe0MLzH6uKfR8n0
         la34dCjY66Z2oHj8N+yNRoNlxZrr9Vu+ZyLiD5oIN0Ao2LOCLKdNbfrIY2V3peWB4LVl
         r1Na55yHjTpDzan90QNo3qPZjqbDGgxe6v6wlrtK0nOPkb5zzgNfBQdAyeErF7hJzOI+
         wlwNuqyZcvEvLfOlhMzLlPqy73QeV+VtBLZp+wJYkHjPlww7umquqEkdYvK5ciVFUxMH
         JQvb6QlyZcqSRcrm2ebpmc9vcXzl4xn1nc2URi8/zsJBPD2syVUolKphWDjyXpVrECp7
         LXPA==
X-Gm-Message-State: AFq9FYJBiDR/Vzm/X4kSIkuR6ZbatZGwqn9kp+jkmn57YT1KfrmVUwaH
	CRrbeisjq3UdblUAR2vW3elqHQqK15NWPQ4N2dPcWAf1kMNc8ntW1vLJZlc69A==
X-Gm-Gg: AYBFou04BXPLt2QH1IDcLb6RSQF0AaLjw3XzUMnmiPcNWLxKe5X4Fti6oe/t4TMjlmo
	Rjb8yqp4S8lpiOirSUIzZaNGUzKnqCZ89L18R/W6CLNQJ+HvcGcFt0VLasXwsl7/WIBweSpMZol
	HtTcns1ML6DPFSMndDp0Z4DgSDi2zxNT+fSo+vkdobKHMrKsDvp2vxY2lCWGuOctOgDjzEUlGd/
	IOn6r7Bof6ZhPhvVnUAm32iuI37KrZkoyUKRWpPKxsHIO+91trSi0km59YSGdEElRK5zGU9j5+a
	LYXx8FLhXw+p9zvfPIaXF4g9vspMgUGIOvpzGrEoWAvsrSQQE4xM+bSMgoLjrxRnpF0Dyr5frxp
	udZEEd6THF3ZqLAcnLrwVpW9tTbUpEVlYYedMWEvOmvE5kiAnpRRB3PBmabrxpHxlx3J7wAUtP6
	9cuX/2pn4iMzBa0B0oXBtS6lvqNo7TxzWup6FFhdmFu16RY2Xu/jBoD0jvlwzm9gqRIsLYgH2fv
	YEHTKbZ48YYu+dtOdvy1BhA8nyO4uvriCm3R9IQt7Vo0q1n4jSp5n5FIKq3gE3SlDWrPUh1v2pk
	FHCnGkZGSael1/WYxAvRocNc7ryRgRzQbSQMMtj5Ix0=
X-Received: by 2002:a05:7301:1:b0:35b:9bd:1435 with SMTP id 5a478bee46e88-35b09bd1510mr3520155eec.2.1791825472968;
        Mon, 12 Oct 2026 10:17:52 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm34978099eec.30.2026.10.12.10.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:17:52 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC PATCH mptcp-next 3/3] selftests: mptcp: join: validate subflow retry after link failure
Date: Mon, 12 Oct 2026 17:17:40 +0000
Message-Id: <20261012171740.464517-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
References: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the new sysctl: during a transfer, drop all the packets the client
sends on one link, without bringing it down, until the subflow is closed
and a retry happens. Then restore the link and check the subflow comes
back.

Both an extra (MP_JOIN) subflow and the initial subflow are tested.

Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaeda4f..a4549d8f291e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2151,6 +2151,78 @@ wait_attempt_fail()
 	return 1
 }
 
+# $1: ns
+wait_sf_retry()
+{
+	local ns="${1}"
+	local cnt
+
+	for _ in $(seq $((timeout_poll * 10))); do
+		cnt=$(mptcp_lib_get_counter "${ns}" "MPTcpExtSubflowRetry")
+		[ "${cnt:-0}" -gt 0 ] && return 0
+		sleep 0.1
+	done
+
+	return 1
+}
+
+# $1: ns ; $2: minimum number of retries
+chk_sf_retry_nr()
+{
+	local ns="${1}"
+	local retry_min="${2}"
+	local count
+
+	print_check "subflow retry"
+	count=$(mptcp_lib_get_counter "${ns}" "MPTcpExtSubflowRetry")
+	if [ -z "${count}" ]; then
+		print_skip
+	elif [ "${count}" -lt "${retry_min}" ]; then
+		fail_test "got ${count} subflow retry[s] expected at least ${retry_min}"
+	else
+		print_ok
+	fi
+}
+
+# $1: index of the client link to break
+#
+# The link stays up, but all the packets sent by the client on it are dropped:
+# the subflow using it is closed after a few retransmissions, then re-created
+# by the client once the link is back.
+run_sf_retry()
+{
+	local link="${1}"
+	local retry_nr
+	local tests_pid
+
+	init_shapers
+	ip netns exec $ns2 sysctl -q net.mptcp.subflow_retry_timeout=1
+	ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	test_linkfail=32768 \
+		run_tests $ns1 $ns2 10.0.1.1 &
+	tests_pid=$!
+
+	wait_mpj 1
+	tc -n $ns2 qdisc change dev ns2eth${link} root netem rate 20mbit \
+		delay 1ms loss 100%
+	wait_sf_retry $ns2
+	tc -n $ns2 qdisc change dev ns2eth${link} root netem rate 20mbit \
+		delay 1ms
+	if ! wait ${tests_pid}; then
+		fail_test "transfer failed"
+		return
+	fi
+
+	# one MPJ SYN per attempt, then a single successful re-creation
+	retry_nr=$(mptcp_lib_get_counter $ns2 "MPTcpExtSubflowRetry")
+	join_syn_tx=$((1 + ${retry_nr:-0})) \
+		chk_join_nr 2 2 2
+	chk_sf_retry_nr $ns2 1
+}
+
 set_userspace_pm()
 {
 	local ns=$1
@@ -2585,6 +2657,18 @@ link_failure_tests()
 		chk_stale_nr $ns2 1 -1 2
 		chk_link_usage $ns2 ns2eth3 $cinsent 50
 	fi
+
+	# MPJ subflow closed after a silent link failure, then re-created
+	if reset "subflow retry after link failure" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/subflow_retry_timeout'; then
+		run_sf_retry 3
+	fi
+
+	# same with the initial subflow: re-created with an MPJ using ID 0
+	if reset "initial subflow retry after link failure" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/subflow_retry_timeout'; then
+		run_sf_retry 1
+	fi
 }
 
 add_addr_timeout_tests()
-- 
2.25.1

