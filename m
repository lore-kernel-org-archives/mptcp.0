Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D02FB6
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 00:33:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="236907571"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="236907571"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="465835394"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.72.63])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:29 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 6/6] selftests: mptcp: Add tests for userspace PM type
Date: Wed, 15 Dec 2021 16:33:24 -0800
Message-Id: <20211216003324.403195-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
References: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests ensure that the in-kernel path manager is bypassed when
the userspace path manager is configured. Kernel code is still
responsible for ADD_ADDR echo, so also make sure that's working.

Tested-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 70 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8cbff7ce35d6..dfff017a08f6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -50,6 +50,7 @@ init()
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
+		ip netns exec $netns sysctl -q net.mptcp.pm_type=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 		if [ $checksum -eq 1 ]; then
@@ -1911,6 +1912,68 @@ fullmesh_tests()
 	chk_add_nr 1 1
 }
 
+userspace_tests()
+{
+	# userspace pm type prevents add_addr
+	reset
+	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "userspace pm type prevents add_addr" 0 0 0
+	chk_add_nr 0 0
+
+	# userspace pm type echoes add_addr
+	reset
+	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "userspace pm type echoes add_addr" 0 0 0
+	chk_add_nr 1 1
+
+	# userspace pm type rejects join
+	reset
+	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "userspace pm type rejects join" 1 1 0
+
+	# userspace pm type does not send join
+	reset
+	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "userspace pm type does not send join" 0 0 0
+
+	# userspace pm type prevents mp_prio
+	reset
+	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+	chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
+	chk_prio_nr 0 0
+
+	# userspace pm type prevents rm_addr
+	reset
+	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
+	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+	chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
+	chk_rm_nr 0 0
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1928,6 +1991,7 @@ all_tests()
 	checksum_tests
 	deny_join_id0_tests
 	fullmesh_tests
+	userspace_tests
 }
 
 usage()
@@ -1948,6 +2012,7 @@ usage()
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
+	echo "  -u userspace_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1983,7 +2048,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fesltra64bpkdmchCS' opt; do
+while getopts 'fesltra64bpkdmuchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2030,6 +2095,9 @@ while getopts 'fesltra64bpkdmchCS' opt; do
 		m)
 			fullmesh_tests
 			;;
+		u)
+			userspace_tests
+			;;
 		c)
 			;;
 		C)
-- 
2.34.1

