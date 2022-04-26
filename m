Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07933DC
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 21:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651010245; x=1682546245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VHI55fwMmAPMISO8cR9zrQDat9I7YpRVjSu9rkw1vK8=;
  b=l9HGNJ2cRkvQGk34jAh3apQ0RKTrYmqzNMCk6I2KxIFi8f3c7E6E2US1
   LSYLZm+xkMSIJQUEBdsbli9phV8U5uQrhn4gZ810pgBYYeijLp44faYIc
   Sk0Q1QhflMRwBOE22GztZqEQZBYCUHfV7I3MPwlXp9vKqQlAUBKuy34di
   TB9vTQrWEfundzXJC0vJZZ8aygzjpNKoRluHr0F88ei+XBt+jq2yMt9RI
   GqeCc/RJg0fPXQE6AbKu41gz4/HecKvjqCDZu3u+OLqEO9BcB2reZ64u9
   KivLJOjAXAgp4IbCFpEeccf+w6TCbwPcby3Y7Dds4Tx1fRGNwYhMXw9W4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326222710"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326222710"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532878094"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.10.176])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Davide Caratti <dcaratti@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/7] selftests: mptcp: add infinite map testcase
Date: Tue, 26 Apr 2022 14:57:11 -0700
Message-Id: <20220426215717.129506-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
References: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Add the single subflow test case for MP_FAIL, to test the infinite
mapping case. Use the test_linkfail value to make 128KB test files.

Add a new function reset_with_fail(), in it use 'iptables' and 'tc
action pedit' rules to produce the bit flips to trigger the checksum
failures. Set validate_checksum to enable checksums for the MP_FAIL
tests without passing the '-C' argument. Set check_invert flag to
enable the invert bytes check for the output data in check_transfer().
Instead of the file mismatch error, this test prints out the inverted
bytes.

Add a new function pedit_action_pkts() to get the numbers of the packets
edited by the tc pedit actions. Print this numbers to the output.

Also add the needed kernel configures in the selftests config file.

Suggested-by: Davide Caratti <dcaratti@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/config      |  8 +++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 70 ++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index d36b7da5082a..38021a0dd527 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -12,6 +12,9 @@ CONFIG_NF_TABLES=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XT_MATCH_BPF=m
+CONFIG_NETFILTER_XT_MATCH_LENGTH=m
+CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
+CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NFT_TPROXY=m
 CONFIG_NFT_SOCKET=m
@@ -19,3 +22,8 @@ CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_NET_ACT_CSUM=m
+CONFIG_NET_ACT_PEDIT=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_CLS_FW=m
+CONFIG_NET_SCH_INGRESS=m
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9eb4d889a24a..34152a50a3e2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -266,6 +266,58 @@ reset_with_allow_join_id0()
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
 }
 
+# Modify TCP payload without corrupting the TCP packet
+#
+# This rule inverts a 8-bit word at byte offset 148 for the 2nd TCP ACK packets
+# carrying enough data.
+# Once it is done, the TCP Checksum field is updated so the packet is still
+# considered as valid at the TCP level.
+# Because the MPTCP checksum, covering the TCP options and data, has not been
+# updated, the modification will be detected and an MP_FAIL will be emitted:
+# what we want to validate here without corrupting "random" MPTCP options.
+#
+# To avoid having tc producing this pr_info() message for each TCP ACK packets
+# not carrying enough data:
+#
+#     tc action pedit offset 162 out of bounds
+#
+# Netfilter is used to mark packets with enough data.
+reset_with_fail()
+{
+	reset "${1}" || return 1
+
+	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
+	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
+
+	check_invert=1
+	validate_checksum=1
+	local i="$2"
+	local ip="${3:-4}"
+	local tables
+
+	tables="iptables"
+	if [ $ip -eq 6 ]; then
+		tables="ip6tables"
+	fi
+
+	ip netns exec $ns2 $tables \
+		-t mangle \
+		-A OUTPUT \
+		-o ns2eth$i \
+		-p tcp \
+		-m length --length 150:9999 \
+		-m statistic --mode nth --packet 1 --every 99999 \
+		-j MARK --set-mark 42 || exit 1
+
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || exit 1
+	tc -n $ns2 filter add dev ns2eth$i egress \
+		protocol ip prio 1000 \
+		handle 42 fw \
+		action pedit munge offset 148 u8 invert \
+		pipe csum tcp \
+		index 100 || exit 1
+}
+
 fail_test()
 {
 	ret=1
@@ -1199,7 +1251,7 @@ chk_join_nr()
 		echo "[ ok ]"
 	fi
 	[ "${dump_stats}" = 1 ] && dump_stats
-	if [ $checksum -eq 1 ]; then
+	if [ $validate_checksum -eq 1 ]; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -2590,6 +2642,21 @@ fastclose_tests()
 	fi
 }
 
+pedit_action_pkts()
+{
+	tc -n $ns2 -j -s action show action pedit index 100 | \
+		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
+}
+
+fail_tests()
+{
+	# single subflow
+	if reset_with_fail "Infinite map" 1; then
+		run_tests $ns1 $ns2 10.0.1.1 128
+		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
+	fi
+}
+
 implicit_tests()
 {
 	# userspace pm type prevents add_addr
@@ -2658,6 +2725,7 @@ all_tests_sorted=(
 	d@deny_join_id0_tests
 	m@fullmesh_tests
 	z@fastclose_tests
+	F@fail_tests
 	I@implicit_tests
 )
 
-- 
2.36.0

