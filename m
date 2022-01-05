Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641632CA0
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 15:57:35 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id k15so829116edk.13
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 07:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmf5Gx8AjygTWcq7F7esM2bVIG4OLuFLdG3P509K/gw=;
        b=nzMji4q5ywrefDWI3YzwDy+c1wekMLJSqDG1W/yQAR2Bcck87TOpTPLmSjDOoLluZ8
         cOfsHPgzjCwcTzsQlBGh3Ot8EZrNWPQvjuEvUorwJH/9k5bXLMyOf6eaEf/Ypcw0tDX8
         j80wNi3vfE7lOy0XCUejnpsm++1JpJBFD0ny+Ke//Y74Ut+zETiUTQZCdGMDVXAQOxwV
         76qhuZe/mYi72vTobhBtR3lZIcseazzADBPJ+RHVbXnEUjoywhqqEBKpxLg7hRQLvYbI
         B17XnWruuSC/VDk1wLzcBlT7qajpHLeyGyyqN7U3YLH6aGCd20PYqEERxY4TiTlzFj7D
         KHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmf5Gx8AjygTWcq7F7esM2bVIG4OLuFLdG3P509K/gw=;
        b=351cl31EyCUdPKvtgzaasoaJbbQRx70CYqsLWLZL1qGJqG6LzAf2rAsHH7Bq7Vne0k
         aRp5GzT05da46pfp33dOk+MJumJra1MobQGdXzlzxgBHaSIRqOPaFCw48WOyUk6QLjW8
         canUmQkS8t/x2sXAFz5ViKjAdaALc2gn0WoU7WXdQaVSgOSbxv3yMkS7fd8uufhvSK1D
         UFBiqXeD0M/u6Um7yikXbz3yFhknrGnMjTMJhkxSC/sH2F+g76eAAjL0NKk8DIFTKrC1
         ROBy1vViIsDjLyCq3QVyj/s+gn4n7Ly60HmENkXNycP3Lv4wHZra65AMWtPgHAAiB9zp
         lM2w==
X-Gm-Message-State: AOAM531kikDyPBEIzJMvUMEnmLLlgFgjgsr+yZhIzOopSeQ8aN9y29Oe
	P0d5hCGcICeexQswE6Dk77EncqQuj68mZh6UWIs=
X-Google-Smtp-Source: ABdhPJwNzyME4/IJpCZbuDmK8lBWz15UoaQjrf329sCv04w7clmeug7riyp+rvNR9ya0SC2NEEseJg==
X-Received: by 2002:a17:907:62a3:: with SMTP id nd35mr44757008ejc.650.1641398253600;
        Wed, 05 Jan 2022 07:57:33 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id c30sm12399684ejj.190.2022.01.05.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:57:33 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 8/8] selftests: mptcp: add mp_fail testcases
Date: Wed,  5 Jan 2022 16:57:02 +0100
Message-Id: <20220105155702.165123-9-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220105155702.165123-1-matthieu.baerts@tessares.net>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Added the test cases for MP_FAIL, use 'tc' command to trigger the
checksum failure.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
 2 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index d36b7da5082a..26955abe49f0 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -19,3 +19,8 @@ CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_NET_ACT_CSUM=m
+CONFIG_NET_ACT_PEDIT=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_SCH_INGRESS=m
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..535baa3c01e7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -16,6 +16,7 @@ mptcp_connect=""
 capture=0
 checksum=0
 do_all_tests=1
+nr_fail=0
 
 TEST_COUNT=0
 
@@ -58,6 +59,8 @@ init()
 		fi
 	done
 
+	validate_checksum=$checksum
+
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
 	# ns1eth2    ns2eth2
@@ -161,6 +164,45 @@ reset_with_allow_join_id0()
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
 }
 
+# Modify TCP payload without corrupting the TCP packet
+#
+# This rule inverts a 32-bit word at byte offset 148 for all TCP ACK
+# packets carrying enough data.
+# Once it is done, the TCP Checksum field is updated so the packet
+# is still considered as valid at the TCP level.
+# But because the MPTCP checksum, covering the TCP options and data,
+# has not been updated, we will detect the modification and emit an
+# MP_FAIL: what we want to validate here.
+#
+# Please note that this rule will produce this pr_info() message for
+# each TCP ACK packets not carrying enough data:
+#
+#     tc action pedit offset 162 out of bounds
+#
+# But this should be limited to a very few numbers of packets as we
+# restrict this rule to outgoing TCP traffic with only the ACK flag
+# + except the 3rd ACK, only packets carrying data should be seen in
+# this direction.
+reset_with_fail()
+{
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
+	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
+
+	validate_checksum=1
+	nr_fail=0
+	i="$1"
+
+	tc -n $ns2 qdisc add dev ns2eth$i clsact
+	tc -n $ns2 filter add dev ns2eth$i egress \
+		protocol ip prio 1000 \
+		flower ip_proto tcp tcp_flags 0x10/0xff \
+		action pedit munge offset 148 u32 invert \
+		pipe csum tcp \
+		index 100
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -179,6 +221,12 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
+jq -V > /dev/null 2>&1
+if [ $? -ne 0 ];then
+	echo "SKIP: Could not run all tests without jq tool"
+	exit $ksft_skip
+fi
+
 print_file_err()
 {
 	ls -l "$1" 1>&2
@@ -233,6 +281,21 @@ link_failure()
 	done
 }
 
+get_nr_fail()
+{
+	i="$1"
+
+	local action=$(tc -n $ns2 -j -s action show action pedit index 100)
+	local packets=$(echo $action | jq '.[1].actions[0].stats.packets')
+	local overlimits=$(echo $action | jq '.[1].actions[0].stats.overlimits')
+
+	let pkt=$packets-$overlimits
+	if [ $pkt -gt 0 ]; then
+		nr_fail=1
+	fi
+	tc -n $ns2 qdisc del dev ns2eth$i clsact
+}
+
 # $1: IP address
 is_v6()
 {
@@ -589,6 +652,8 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=${1:-""}
+	local csum_ns1=${2:-0}
+	local csum_ns2=${3:-0}
 	local count
 	local dump_stats
 
@@ -600,8 +665,8 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
-	if [ "$count" != 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" != $csum_ns1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		ret=1
 		dump_stats=1
 	else
@@ -610,8 +675,8 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
-	if [ "$count" != 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" != $csum_ns2 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		ret=1
 		dump_stats=1
 	else
@@ -690,6 +755,8 @@ chk_join_nr()
 	local syn_nr=$2
 	local syn_ack_nr=$3
 	local ack_nr=$4
+	local fail_nr=${5:-0}
+	local infi_nr=${6:-0}
 	local count
 	local dump_stats
 
@@ -726,10 +793,10 @@ chk_join_nr()
 		echo "[ ok ]"
 	fi
 	[ "${dump_stats}" = 1 ] && dump_stats
-	if [ $checksum -eq 1 ]; then
-		chk_csum_nr
-		chk_fail_nr 0 0
-		chk_infi_nr 0 0
+	if [ $validate_checksum -eq 1 ]; then
+		chk_csum_nr "" $fail_nr
+		chk_fail_nr $fail_nr $fail_nr
+		chk_infi_nr $infi_nr $infi_nr
 	fi
 }
 
@@ -1985,6 +2052,27 @@ userspace_tests()
 	chk_rm_nr 0 0
 }
 
+fail_tests()
+{
+	# multiple subflows
+	reset_with_fail 2
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 2
+	get_nr_fail 2
+	chk_join_nr "$nr_fail MP_FAIL, multiple subflows" 2 2 2 $nr_fail
+
+	# single subflow
+	reset_with_fail 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	run_tests $ns1 $ns2 10.0.1.1 2
+	get_nr_fail 1
+	chk_join_nr "$nr_fail MP_FAIL, single subflow" 0 0 0 $nr_fail $nr_fail
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2003,6 +2091,7 @@ all_tests()
 	deny_join_id0_tests
 	fullmesh_tests
 	userspace_tests
+	fail_tests
 }
 
 usage()
@@ -2024,6 +2113,7 @@ usage()
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
 	echo "  -u userspace_tests"
+	echo "  -F fail_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -2059,7 +2149,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fesltra64bpkdmuchCS' opt; do
+while getopts 'fesltra64bpkdmuchCSF' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2109,6 +2199,9 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
 		u)
 			userspace_tests
 			;;
+		F)
+			fail_tests
+			;;
 		c)
 			;;
 		C)
-- 
2.33.1

