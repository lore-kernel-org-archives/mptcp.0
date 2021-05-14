Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66171
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 14:32:38 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so1722819pjb.2
        for <mptcp@lists.linux.dev>; Fri, 14 May 2021 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCAtB47EYneB9xZ3pqNAlLvPbgQtyyLLAKTR5G44eUA=;
        b=OhtXeNaCf+Qu74jlrpgOfKk9UFHPWPhzPScVF+K73bZB+d3t9CKTeUFakRGuv5o+x1
         o0s1hJphHmbPHB3ONJgFmzko5McCZfi1Tl6Lrz44a+GVpgk0sCtsG1i+CDMWFHs4SaUD
         wHZrmXwHAonKzD8KGzjjmRf1+gr1w/18qssnWREi0O3gsgQNbjJaTMB54/aTKC9Eeu/9
         QPydGKdNv5286qlqGakAQEztApv3VNB2/lBUiYcn8CSA2GNnQLAK4Oiv3O9sNKwzRocy
         YPe2VtqDFx/No4A3pyD3QoJm8y42CJoAx6/qQyCHUQu9dFW4eUKH81nZHLXDWoYvfv0k
         BRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCAtB47EYneB9xZ3pqNAlLvPbgQtyyLLAKTR5G44eUA=;
        b=ZwilKjuaYG64iM9AEiq2jXJNhX/fkHl0APgSkRggPR47kUIuqpOUKFXRrmHOGGqBI1
         6I++Mjlaqo0tvtTnbwm8mmZVTysgLou8DncPatNSP9yPQ4Vk+zE6ZcvYjuS48x6P49L+
         Igc4Z+bfFRAoxGR7eGKHuZzDe/W+0KoY2ALMXeIYdOUyAEkd7OlF+HKujtLyrEF59fU4
         hWX1Hv3FDwmicTEpcJOBbv31wPQc5BE+tApkaHxhd2IUnjaTAF1F1HUJAmupzzM+Vre8
         yeHlWCO7b6Mj3kv+Ia8sG7U9ikfCCCX/y3VinYJKweLrhQYbAOCpVyDJbJicE9wyYe+/
         Dfjg==
X-Gm-Message-State: AOAM531RyGuiUjdpcuUDFSnt0JkqgesvgJfGv8J2afoTDw4DSUEJU/Iy
	MGckVAZUmmU9x7ApAiYlk6mhCg0SAHU=
X-Google-Smtp-Source: ABdhPJxsRfedk+hOeNo24AIJIoveCDLDkyhtlo3nS7T66/yAMHBywbJtFKOSIa1pUeUJFEWsez8JWw==
X-Received: by 2002:a17:902:e007:b029:ef:9dd2:be6 with SMTP id o7-20020a170902e007b02900ef9dd20be6mr8079508plo.12.1621002757676;
        Fri, 14 May 2021 07:32:37 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id r11sm4411441pgl.34.2021.05.14.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:32:37 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v6 mptcp-next 6/6] selftests: mptcp: add deny_join_id0 testcases
Date: Fri, 14 May 2021 22:32:19 +0800
Message-Id: <26460564eb974520c1d7724c25ef08293450af6e.1621002341.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <774cef61ee52ed2c84c9113205b706e24c4d7c48.1621002341.git.geliangtang@gmail.com>
References: <cover.1621002341.git.geliangtang@gmail.com> <d051657e9c51ccb27b32d443777896c6ae519444.1621002341.git.geliangtang@gmail.com> <2a6a925510a7d79f0c2101d5d353f6b74f0e69bb.1621002341.git.geliangtang@gmail.com> <ae0d32922128771f09b230e5718774472a088207.1621002341.git.geliangtang@gmail.com> <850406b0f49fa0a76b4825b36c55426a0d033d52.1621002341.git.geliangtang@gmail.com> <774cef61ee52ed2c84c9113205b706e24c4d7c48.1621002341.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new argument '-d' for mptcp_join.sh script, to invoke
the testcases for the MP_CAPABLE 'C' flag.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 56 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 523c7797f30a..17b385f011d2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -139,6 +139,17 @@ reset_with_checksum()
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
 }
 
+reset_with_allow_join_id0()
+{
+	local ns1_enable=$1
+	local ns2_enable=$2
+
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns1_enable
+	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -1462,6 +1473,44 @@ checksum_tests()
 	chk_csum_nr "checksum test 1 0"
 }
 
+deny_join_id0_tests()
+{
+	# subflow allow join id0 ns1
+	reset_with_allow_join_id0 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "single subflow allow join id0 ns1" 1 1 1
+
+	# subflow allow join id0 ns2
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
+
+	# subflow and address allow join id0
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "subflow and address allow join id0" 2 2 2
+
+	# signal address allow join id0
+	# ADD_ADDRs are not affected by allow_join_id0 value.
+	reset_with_allow_join_id0 0 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address allow join id0" 1 1 1
+	chk_add_nr 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1476,6 +1525,7 @@ all_tests()
 	add_addr_ports_tests
 	syncookies_tests
 	checksum_tests
+	deny_join_id0_tests
 }
 
 usage()
@@ -1493,6 +1543,7 @@ usage()
 	echo "  -p add_addr_ports_tests"
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
+	echo "  -d deny_join_id0_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1528,7 +1579,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkchCS' opt; do
+while getopts 'fsltra64bpkdchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1566,6 +1617,9 @@ while getopts 'fsltra64bpkchCS' opt; do
 		S)
 			checksum_tests
 			;;
+		d)
+			deny_join_id0_tests
+			;;
 		c)
 			;;
 		C)
-- 
2.31.1

