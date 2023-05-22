Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C814AA3
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:31 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so43364205e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773509; x=1687365509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42HnwqL8CACMjfd5k0LVN3KOk+UVz/nizwfgq7ALM7A=;
        b=GYPiqymdbQTWS/HTOidF2uHMiYSrOHnPXXflclRrSX7sbvS/bhRnu0RhkS/KT0kSa1
         c7fj83uqN6HXBBpPTup/aV4mt8240vLAyWi9LF3vNIC6qKO+mGc4MrgfjjCcwwxb+bKn
         rR8Y/bf2KoWMt6bKCfzEznEbwpaFej2wx6GRCCn37joSIgi3PKgVZxlD3w0erAz5qG0q
         J/xoeUgXsSXtGS5eKiLIgIznVISrE70zu8yLLutTjUcR816hkApfvBqiGeYjT68cAi+L
         TYWHCRR3mWTCpe5sx47QC0SrZIVjj1lYKS1bxUUQPw7EW3VGslRS3WNf6mRWOQhefYvD
         zohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773509; x=1687365509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42HnwqL8CACMjfd5k0LVN3KOk+UVz/nizwfgq7ALM7A=;
        b=aXRlyXcrgwrtHQl77V7W1cTarzrKax2Ktrkkv13GxfvPRtRkBDvDc9V38KMi1PL8Rp
         47yfYJYzqgaP48RNtbF6QPSZvXVaSrXF11nqGNs07XIOxXjMIk6A1h2Yt9AYeO0lBbBH
         0X4KEFuyLNzjSK6esEHEBbN9xeKn572f84vnX5QRCle7xgkf4AePi4dkUWXKXb2t1C50
         EiUPS/tfMZ7JzMHuzget+hTF7RTZDJRTLrTgGWM9iAG+n7pcQ/4idOJXwy+NpVDLQ784
         5y1pBp5mgWfmPqaRQ2SOK8MnZVE1TXtBHCsWz5hCArRLeb11OG/qTHsG6zmNdlN9U7oR
         yCwQ==
X-Gm-Message-State: AC+VfDytvQfi4D8ilfBkKlokhB/3LDUfuaq/jUaP6lX0EFZANxXOUODZ
	gIoEwa4xpjcmbT8MN9xCjOyycG7fKYnTmXBZTXpo4w==
X-Google-Smtp-Source: ACHHUZ63yRMzkcW4e/IWnpyHaIA/BtZN7XHug3TJAHFjMkrezFhi9J0rC7Sdc3+lhMO1pA7TFGg/DQ==
X-Received: by 2002:a7b:cbc8:0:b0:3f4:28fd:83e0 with SMTP id n8-20020a7bcbc8000000b003f428fd83e0mr7969355wmi.31.1684773509113;
        Mon, 22 May 2023 09:38:29 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:28 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:58 +0200
Subject: [PATCH mptcp-net v2 26/37] selftests: mptcp: join: skip test if
 iptables/tc cmds fail
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-26-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5730;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=cy/7PsbQAW3ExoO+MorPGKvjY9VB5SgaKy74NoAWXZc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pxwgNOUxmDt9t3NbaqS2YAgPOU4G/LCuE6m
 4CmI6Ua+rmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacQAKCRD2t4JPQmmg
 c8zND/4lfjlRZO9UZxyOXXqHa0eJh+2R9ZZYdRo3L9zhzACMD2L7MCy/UD2aDlUt3Ef9mNSgANA
 RNstNGWCMIsjqkz9WCQ7ijnW8+tEleOiKzPDGNrByAAYffXv7BQlfLf7eA9l3SVqwu52e4zR4bW
 JT/bxZyMe6kly0Z+15/Xbf6jZcMuFK+LGqjCg5Mh8MNd0fVNDA0V3d8BGtXuNOezdtwUJswWwQ0
 No0MdKY8jBBqjMSv+4kqiZF8TfJCNN5zOWApUy/qq80Rj4o5V6VSNoULQRCLjM2BqEgc3ifx0ST
 YtHMyF7cXPel4+UXvnB4pNmnut/qtwo34RVTszyblpPu7Cd2FDAwsq0KJaAMp+3ScSCFy9c2DBW
 AHMAogkudOl4jEnQeCZoslKesmR7qY4+ugacL7VeQuzTyzIypbY5xEav6aFLUUEPkdMV/rMonxQ
 5xjqQ1Omv20+aKAMYqEk1/jkYOtr1v+GZeN3a3mdgFVi1qGOcvtMHfaJmk1rZqdi6h8Oi+Zac4l
 0KKYy3dPW0tqLtB69KikW193fQdP3eEzGvhTQffNxyVDRxXGmPgnryP6UfWKGvgjcP+oxBTAyEc
 Va1grC0e+kJpd2bLTpTtvPA/abhtOF2nSFUgu63yix0kJGAvYizcD7OX6kLjBkqIOLkOGfuBJIZ
 sxoCuAGLcV6ctIA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

Some tests are using IPTables and/or TC commands to force some
behaviours. If one of these commands fails -- likely because some
features are not available -- we should intercept the error and skip the
tests requiring these features.

Note that if we expect to have these features available and if
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set to 1, the tests
will be marked as failed instead of skipped.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 88 ++++++++++++++++---------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 73c513f1e808..2ae6d99f3eb9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -288,11 +288,15 @@ reset_with_add_addr_timeout()
 	fi
 
 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-	ip netns exec $ns2 $tables -A OUTPUT -p tcp \
-		-m tcp --tcp-option 30 \
-		-m bpf --bytecode \
-		"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
-		-j DROP
+
+	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
+			-m tcp --tcp-option 30 \
+			-m bpf --bytecode \
+			"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
+			-j DROP; then
+		mark_as_skipped "unable to set the 'add addr' rule"
+		return 1
+	fi
 }
 
 # $1: test name
@@ -336,17 +340,12 @@ reset_with_allow_join_id0()
 #     tc action pedit offset 162 out of bounds
 #
 # Netfilter is used to mark packets with enough data.
-reset_with_fail()
+setup_fail_rules()
 {
-	reset "${1}" || return 1
-
-	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
-	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
-
 	check_invert=1
 	validate_checksum=1
-	local i="$2"
-	local ip="${3:-4}"
+	local i="$1"
+	local ip="${2:-4}"
 	local tables
 
 	tables="${iptables}"
@@ -361,15 +360,32 @@ reset_with_fail()
 		-p tcp \
 		-m length --length 150:9999 \
 		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42 || exit 1
+		-j MARK --set-mark 42 || return ${ksft_skip}
 
-	tc -n $ns2 qdisc add dev ns2eth$i clsact || exit 1
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${ksft_skip}
 	tc -n $ns2 filter add dev ns2eth$i egress \
 		protocol ip prio 1000 \
 		handle 42 fw \
 		action pedit munge offset 148 u8 invert \
 		pipe csum tcp \
-		index 100 || exit 1
+		index 100 || return ${ksft_skip}
+}
+
+reset_with_fail()
+{
+	reset "${1}" || return 1
+	shift
+
+	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
+	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
+
+	local rc=0
+	setup_fail_rules "${@}" || rc=$?
+
+	if [ ${rc} -eq ${ksft_skip} ]; then
+		mark_as_skipped "unable to set the 'fail' rules"
+		return 1
+	fi
 }
 
 reset_with_events()
@@ -384,6 +400,25 @@ reset_with_events()
 	evts_ns2_pid=$!
 }
 
+reset_with_tcp_filter()
+{
+	reset "${1}" || return 1
+	shift
+
+	local ns="${!1}"
+	local src="${2}"
+	local target="${3}"
+
+	if ! ip netns exec "${ns}" ${iptables} \
+			-A INPUT \
+			-s "${src}" \
+			-p tcp \
+			-j "${target}"; then
+		mark_as_skipped "unable to set the filter rules"
+		return 1
+	fi
+}
+
 fail_test()
 {
 	ret=1
@@ -750,15 +785,6 @@ pm_nl_check_endpoint()
 	fi
 }
 
-filter_tcp_from()
-{
-	local ns="${1}"
-	local src="${2}"
-	local target="${3}"
-
-	ip netns exec "${ns}" ${iptables} -A INPUT -s "${src}" -p tcp -j "${target}"
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -2029,23 +2055,23 @@ subflows_error_tests()
 	fi
 
 	# multiple subflows, with subflow creation error
-	if reset "multi subflows, with failing subflow"; then
+	if reset_with_tcp_filter "multi subflows, with failing subflow" ns1 10.0.3.2 REJECT &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# multiple subflows, with subflow timeout on MPJ
-	if reset "multi subflows, with subflow timeout"; then
+	if reset_with_tcp_filter "multi subflows, with subflow timeout" ns1 10.0.3.2 DROP &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 DROP
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
@@ -2053,11 +2079,11 @@ subflows_error_tests()
 	# multiple subflows, check that the endpoint corresponding to
 	# closed subflow (due to reset) is not reused if additional
 	# subflows are added later
-	if reset "multi subflows, fair usage on close"; then
+	if reset_with_tcp_filter "multi subflows, fair usage on close" ns1 10.0.3.2 REJECT &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
 
 		# mpj subflow will be in TW after the reset

-- 
2.39.2

