Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159E154A5
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:52 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso18144085e9.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542611; x=1688134611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sopwhu15R4s2fvPKK7V68/k5cDpXpBpTE0VDhniZm6A=;
        b=n4Qgl/EpF6KbaCAJAD1UcHgudqXi7v5jVi3KyaMKPIYPJGpj+MRinzAbNrDm8S3Z0R
         dsfaqvGmmcxODmNAt/Von3GG95sN3UE/ALZCw9varnff6m5OA7qfrc2iBxdHeg9h6W8G
         mc6R8fGqsVCafgkDZmnOdXFst9hkAIlSH6pTtZV4iaXLCALEZrjNi9zAkh9zTSpbbvj0
         k7NE7OKKFIe5TlKpu3v75ZmxyF8Fgmk3VrzBLVluDFg48TUdB0arEUovyHcH7/X5pNYB
         IqEVotb3xXL7OaWlFETwBTvvhJW2CqaoJOZsoMDD0zEhkCrwHjAJNzPkdeB9kWAsig0u
         I2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542611; x=1688134611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sopwhu15R4s2fvPKK7V68/k5cDpXpBpTE0VDhniZm6A=;
        b=Ad9Z7Ct1m9D7IVH+hkMNs+lP/fRJbsLJ1e5QWAYI5V2iVVA2GtnZFm/CbFP1wSxQHe
         CZgn7s5fC3FcipMtP+JzSnQgtKOhOYzHPa9q1wGiNxgTvHSfrrlZoC4YnlG7bbxIzVSV
         wZ+/VdqSo5XDomRvi8+u264ENHsHac4haX2/xm9WbdooGQZqsa24Hz4vnfrLM5ptUOJb
         +5RgkD+2vk08cx9TbE7EcLJ3CRZrlqeMon6UVK5t5Am+VgjgKN4fXolK3ZSTEg/sGW79
         5BjTLSvBDi4v4sIuhwS98VDS1Tu8y5tpbgvyfgxTQS2WVQJmlSU05ed2tB+odNhbUYeG
         /Zlg==
X-Gm-Message-State: AC+VfDzEj95YxyE0HxV7EbFwy1Ow9ciuCbZQiZv2gj1eO0jiktcuFgtt
	vZYLyuBnWAGFliGK5bcGGauj2w==
X-Google-Smtp-Source: ACHHUZ7hKTcSGkr/2u/9gQo3+mFkzt2Oqj69Uh83gYiQgpSQUKtP4+qq7hzFg65Nd5Q7WQqxh5NvsQ==
X-Received: by 2002:a05:600c:283:b0:3f4:fffc:add with SMTP id 3-20020a05600c028300b003f4fffc0addmr4228487wmk.27.1685542610991;
        Wed, 31 May 2023 07:16:50 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:50 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:39 +0200
Subject: [PATCH mptcp-net v3 19/32] selftests: mptcp: join: skip test if
 iptables/tc cmds fail
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-19-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5979;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=kNzCzurBO1+KOIvY3lYxQJ3TnLg66+nqCJXxQdDx7Ec=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDfOpTpiAQO+daOPG3wB/jooDH8fUeVj8fq
 0249//fKQyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 c6VhEAC9PZA2Bgu1QhCtty92KKJreFb0iKMpLVC5oBGRWqw/Zh2VMpyz1vP4LctJJGYYRi15KNw
 AIY3X8TSOiSpD36viBGKM1N7FdYnEBUn1TykDGEPad0rJKGXvutYz6Mu04o4KocV1fs0HoiVj6i
 okhLpPOBwWCuAwosYCJwXz0ZSg5SdL0GGkk71ivCKRQtmrFPBk6sobuzqq80Oam/W+rdnXBN2Xt
 myP9cJkEtLI/6qOU6vX6w+ZWaPbF7xsJHvJlt1WOUx2oCLr+3sxROyXj0H+ErSzRerrsyr2PdCo
 VgYZl+zeLeaQlPzGAuL7M2Y8BTJnch3RnYo/lxVkmsI9K4nE7VDhGWyvWe7Me4obGIK/ggtjO4e
 weU0nwAgWs5kvNBn79UizuTAyWVWZZgZV0qHDpQ9/CjK7HaInSPs77Z2Ft34tIC+wyeIcfhS6sM
 Xwk98ALelUDltyW8AhBFLXemB6sN2HA+hs8PwnAfrpoBx1zQtYcSnDTADoq/7X3t205lvsXYtHr
 A+EjGsilUl5yJ7qC5lGtDNxQsgvElMpRrunpn4ILIgtnQ8sJMUPCshaTt1PKqdwuTu9S1M/i6PW
 qa//kw4QkXl0IQOJQvi37v1IdkEQf0vgkxM+i5B9gT2o8gZKDjDhJLOaWtXBFy5uxn5WWARZhK/
 vMWSF4UAq4NEu3Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

Some tests are using IPTables and/or TC commands to force some
behaviours. If one of these commands fails -- likely because some
features are not available due to missing kernel config -- we should
intercept the error and skip the tests requiring these features.

Note that if we expect to have these features available and if
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set to 1, the tests
will be marked as failed instead of skipped.

This patch also replaces the 'exit 1' by 'return 1' not to stop the
selftest in the middle without the conclusion if there is an issue with
NF or TC.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v3:
  - add a note about the missing kconfig and the exit
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 88 ++++++++++++++++---------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 53178ef00b50..31b7d04a4e1e 100755
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
@@ -1980,23 +2006,23 @@ subflows_error_tests()
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
@@ -2004,11 +2030,11 @@ subflows_error_tests()
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

