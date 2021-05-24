Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A72FB1
	for <mptcp@lists.linux.dev>; Mon, 24 May 2021 07:07:38 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id 6so19410175pgk.5
        for <mptcp@lists.linux.dev>; Mon, 24 May 2021 00:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhL4l4bXEl7R0oT3JjOVrtoWSIsA/XWrOPz8BhcuSrY=;
        b=dQuJ5F6WlrpbzmlImRB3wMfdk7PrWA2eqACA5kVaQj67tjBR7BCu7M0u5ldalhoij4
         tmpIBlpmNiTBQ478CG150bbGv43JMqgtBctSCAEN/ykw0PqiDFHWttukFGHSjvdjnhVv
         /38z+HnDKisRaXgcOWGNK3iBfCGYWTqgknqAh8UdcX76f7z5XP1J+9YJGzCFT4NY+YGu
         28XolEB2lsjnA53/LuWZn+nclwjQsl/S+bU3eB0gVkp0vTJyOE4m3UcOhhRtoBAmtEcQ
         p1gkej2XBvC7TvNS4nH7BWRQ38JQ281CwMPtdwDNx0ibw3SUIhfAUsHHRflGnBOkxV+Z
         T+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhL4l4bXEl7R0oT3JjOVrtoWSIsA/XWrOPz8BhcuSrY=;
        b=DVPzt6pEwJoLD8IxCyHEbp9TD4T8qjXYWMMhMjvujWyL6ZM5isJNhIh+LjgJQypk0n
         QLoJ5U2vAEcY6V8P2cIl6WHeYxjPlO8NlwuVDpJfmqCe9R4dZfcczgan8Hug/KksxGeu
         +Hj684VotD9cgq+QNlg7prXnOGsqkY404AXr5oRlAInIDHmJCWby/QF8QVaZqC+CM/60
         D6c4rlqeYyXdqvMVDhz386sW0jQ0e9ppcF9iQcwXCtgkrK2xx0Y9AoXWYbg8Y8Rj7D9E
         jhth2pFuchF5RF0pVx+fweICroRn3Ew6b2+AxQS6aO3iKSceBVFc+mLB41CSE05yN9dr
         ZMgg==
X-Gm-Message-State: AOAM531LysKZ81gG/PIbue1/AITQ33s33M0b/NRrSap0B0QZNmSAWW6s
	TLXMF4539dzESASfi/1lqvr6RR7cYfarWA==
X-Google-Smtp-Source: ABdhPJzZk5cTZ9PlZde7wNA+DvKhDoTVHst9MOMaHeNQT7/UkeHYCJchHQOHIcKGuVs5UiUpHgAIPg==
X-Received: by 2002:a63:3444:: with SMTP id b65mr12052749pga.185.1621840058339;
        Mon, 24 May 2021 00:07:38 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id w206sm9983422pfc.61.2021.05.24.00.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:07:38 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v7 mptcp-next 5/5] selftests: mptcp: add deny_join_id0 testcases
Date: Mon, 24 May 2021 15:07:19 +0800
Message-Id: <9b9f755abe6eb4fc13d14035dc9f10a87536b359.1621839764.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <bf509b3a9206c58444fcb9efa7d7d8b0ba8568dc.1621839764.git.geliangtang@gmail.com>
References: <cover.1621839764.git.geliangtang@gmail.com> <7df5c99cf5336e3c1b0225903c75d01bbcde8daf.1621839764.git.geliangtang@gmail.com> <372e8fb0d481dfed41cf7e01c60b18c55a852f7e.1621839764.git.geliangtang@gmail.com> <c27772875a9bf14dd336526f48676f368758be97.1621839764.git.geliangtang@gmail.com> <bf509b3a9206c58444fcb9efa7d7d8b0ba8568dc.1621839764.git.geliangtang@gmail.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 73 ++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 523c7797f30a..02b934f47f65 100755
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
@@ -1462,6 +1473,61 @@ checksum_tests()
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
+	# signal address allow join id0 ns1
+	reset_with_allow_join_id0 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address allow join id0 ns1" 1 1 1
+	chk_add_nr 1 1
+
+	# signal address allow join id0 ns2
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal address allow join id0 ns2" 1 1 1
+	chk_add_nr 1 1
+
+	# subflow and address allow join id0 ns1
+	reset_with_allow_join_id0 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "subflow and address allow join id0 1" 2 2 2
+
+	# subflow and address allow join id0 ns2
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "subflow and address allow join id0 2" 2 2 2
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1476,6 +1542,7 @@ all_tests()
 	add_addr_ports_tests
 	syncookies_tests
 	checksum_tests
+	deny_join_id0_tests
 }
 
 usage()
@@ -1493,6 +1560,7 @@ usage()
 	echo "  -p add_addr_ports_tests"
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
+	echo "  -d deny_join_id0_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1528,7 +1596,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkchCS' opt; do
+while getopts 'fsltra64bpkdchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1566,6 +1634,9 @@ while getopts 'fsltra64bpkchCS' opt; do
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

