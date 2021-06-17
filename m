Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D046D00
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 23:46:36 +0000 (UTC)
IronPort-SDR: 2otfgfhMRDh0093qz9VJttDxvOET59DbXjF6K2sXv6iFAgCycQllivfzUSS7hHbYIL0SSLMBq1
 USwYPqQZSnQw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270316985"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="270316985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 16:46:35 -0700
IronPort-SDR: /EorIFpkF2Lf+rArighCB3b/3N9NlLQsJ9OZQtLMOGg5g5j903W4+Yop20Wa5087Rh0N8rs4YB
 3C0UhYbhy7JQ==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="452943927"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.250.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 16:46:34 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 16/16] selftests: mptcp: enable checksum in mptcp_join.sh
Date: Thu, 17 Jun 2021 16:46:22 -0700
Message-Id: <20210617234622.472030-17-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617234622.472030-1-mathew.j.martineau@linux.intel.com>
References: <20210617234622.472030-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

This patch added a new argument "-C" for the mptcp_join.sh script to set
the sysctl checksum_enabled to 1 in ns1 and ns2 to enable the data
checksum.

In chk_join_nr, check the counter of the mib for the data checksum.

Also added a new argument "-S" for the mptcp_join.sh script to start the
test cases that verify the checksum handshake:

  * Sender and listener both have checksums off
  * Sender and listener both have checksums on
  * Sender checksums off, listener checksums on
  * Sender checksums on, listener checksums off

The output looks like this:

 01 checksum test 0 0                  sum[ ok ] - csum  [ ok ]
 02 checksum test 1 1                  sum[ ok ] - csum  [ ok ]
 03 checksum test 0 1                  sum[ ok ] - csum  [ ok ]
 04 checksum test 1 0                  sum[ ok ] - csum  [ ok ]
 05 no JOIN                            syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       sum[ ok ] - csum  [ ok ]
 06 single subflow, limited by client  syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       sum[ ok ] - csum  [ ok ]

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 107 +++++++++++++++++-
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fd99485cf2a4..523c7797f30a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,6 +12,7 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
 capture=0
+checksum=0
 do_all_tests=1
 
 TEST_COUNT=0
@@ -49,6 +50,9 @@ init()
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
+		if [ $checksum -eq 1 ]; then
+			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
+		fi
 	done
 
 	#  ns1              ns2
@@ -124,6 +128,17 @@ reset_with_add_addr_timeout()
 		-j DROP
 }
 
+reset_with_checksum()
+{
+	local ns1_enable=$1
+	local ns2_enable=$2
+
+	reset
+
+	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
+	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -476,6 +491,45 @@ run_tests()
 	fi
 }
 
+chk_csum_nr()
+{
+	local msg=${1:-""}
+	local count
+	local dump_stats
+
+	if [ ! -z "$msg" ]; then
+		printf "%02u" "$TEST_COUNT"
+	else
+		echo -n "  "
+	fi
+	printf " %-36s %s" "$msg" "sum"
+	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != 0 ]; then
+		echo "[fail] got $count data checksum error[s] expected 0"
+		ret=1
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+	echo -n " - csum  "
+	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	[ -z "$count" ] && count=0
+	if [ "$count" != 0 ]; then
+		echo "[fail] got $count data checksum error[s] expected 0"
+		ret=1
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+	if [ "${dump_stats}" = 1 ]; then
+		echo Server ns stats
+		ip netns exec $ns1 nstat -as | grep MPTcp
+		echo Client ns stats
+		ip netns exec $ns2 nstat -as | grep MPTcp
+	fi
+}
+
 chk_join_nr()
 {
 	local msg="$1"
@@ -523,6 +577,9 @@ chk_join_nr()
 		echo Client ns stats
 		ip netns exec $ns2 nstat -as | grep MPTcp
 	fi
+	if [ $checksum -eq 1 ]; then
+		chk_csum_nr
+	fi
 }
 
 chk_add_nr()
@@ -1374,6 +1431,37 @@ syncookies_tests()
 	chk_add_nr 1 1
 }
 
+checksum_tests()
+{
+	# checksum test 0 0
+	reset_with_checksum 0 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_csum_nr "checksum test 0 0"
+
+	# checksum test 1 1
+	reset_with_checksum 1 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_csum_nr "checksum test 1 1"
+
+	# checksum test 0 1
+	reset_with_checksum 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_csum_nr "checksum test 0 1"
+
+	# checksum test 1 0
+	reset_with_checksum 1 0
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_csum_nr "checksum test 1 0"
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1387,6 +1475,7 @@ all_tests()
 	backup_tests
 	add_addr_ports_tests
 	syncookies_tests
+	checksum_tests
 }
 
 usage()
@@ -1403,7 +1492,9 @@ usage()
 	echo "  -b backup_tests"
 	echo "  -p add_addr_ports_tests"
 	echo "  -k syncookies_tests"
+	echo "  -S checksum_tests"
 	echo "  -c capture pcap files"
+	echo "  -C enable data checksum"
 	echo "  -h help"
 }
 
@@ -1418,13 +1509,16 @@ make_file "$sin" "server" 1
 trap cleanup EXIT
 
 for arg in "$@"; do
-	# check for "capture" arg before launching tests
+	# check for "capture/checksum" args before launching tests
 	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"c"[0-9a-zA-Z]*$ ]]; then
 		capture=1
 	fi
+	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
+		checksum=1
+	fi
 
-	# exception for the capture option, the rest means: a part of the tests
-	if [ "${arg}" != "-c" ]; then
+	# exception for the capture/checksum options, the rest means: a part of the tests
+	if [ "${arg}" != "-c" ] && [ "${arg}" != "-C" ]; then
 		do_all_tests=0
 	fi
 done
@@ -1434,7 +1528,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkch' opt; do
+while getopts 'fsltra64bpkchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1469,8 +1563,13 @@ while getopts 'fsltra64bpkch' opt; do
 		k)
 			syncookies_tests
 			;;
+		S)
+			checksum_tests
+			;;
 		c)
 			;;
+		C)
+			;;
 		h | *)
 			usage
 			;;
-- 
2.32.0

