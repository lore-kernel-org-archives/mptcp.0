Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD926D18
	for <mptcp@lists.linux.dev>; Tue, 17 Aug 2021 22:07:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="203357986"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="203357986"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 15:07:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="573058347"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.9.45])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 15:07:33 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/6] selftests: mptcp: add fullmesh testcases
Date: Tue, 17 Aug 2021 15:07:26 -0700
Message-Id: <20210817220727.192198-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210817220727.192198-1-mathew.j.martineau@linux.intel.com>
References: <20210817220727.192198-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the testcases for the fullmesh address flag of the path
manager.

Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 64 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 52762eaa2d8e..b8311f325fac 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -366,6 +366,12 @@ do_transfer()
 		fi
 	fi
 
+	flags="subflow"
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
+	fi
+
 	if [ $addr_nr_ns2 -gt 0 ]; then
 		let add_nr_ns2=addr_nr_ns2
 		counter=3
@@ -377,7 +383,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.2"
 			fi
-			ip netns exec $ns2 ./pm_nl_ctl add $addr flags subflow
+			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
 			let counter+=1
 			let add_nr_ns2-=1
 		done
@@ -1686,6 +1692,55 @@ deny_join_id0_tests()
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
 }
 
+fullmesh_tests()
+{
+	# fullmesh 1
+	# 2 fullmesh addrs in ns2, added before the connection,
+	# 1 non-fullmesh addr in ns1, added during the connection.
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 4
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
+	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+	chk_join_nr "fullmesh test 2x1" 4 4 4
+	chk_add_nr 1 1
+
+	# fullmesh 2
+	# 1 non-fullmesh addr in ns1, added before the connection,
+	# 1 fullmesh addr in ns2, added during the connection.
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
+	chk_join_nr "fullmesh test 1x1" 3 3 3
+	chk_add_nr 1 1
+
+	# fullmesh 3
+	# 1 non-fullmesh addr in ns1, added before the connection,
+	# 2 fullmesh addrs in ns2, added during the connection.
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 5
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 5
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+	chk_join_nr "fullmesh test 1x2" 5 5 5
+	chk_add_nr 1 1
+
+	# fullmesh 4
+	# 1 non-fullmesh addr in ns1, added before the connection,
+	# 2 fullmesh addrs in ns2, added during the connection,
+	# limit max_subflows to 4.
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 4
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
+	chk_add_nr 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1701,6 +1756,7 @@ all_tests()
 	syncookies_tests
 	checksum_tests
 	deny_join_id0_tests
+	fullmesh_tests
 }
 
 usage()
@@ -1719,6 +1775,7 @@ usage()
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
+	echo "  -m fullmesh_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1754,7 +1811,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkdchCS' opt; do
+while getopts 'fsltra64bpkdmchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1795,6 +1852,9 @@ while getopts 'fsltra64bpkdchCS' opt; do
 		d)
 			deny_join_id0_tests
 			;;
+		m)
+			fullmesh_tests
+			;;
 		c)
 			;;
 		C)
-- 
2.33.0

