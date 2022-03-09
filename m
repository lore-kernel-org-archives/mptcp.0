Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F3511B
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 19:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646853415; x=1678389415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GkA94p7wyl59EJq6r8G8HvFzyMcVKbG6TA+U8TjG0Sg=;
  b=ITkth2PUVIBTPlCHpssagmS/fRE7PJlj7rluBnq+U0DURI60Gc/0LJzn
   n3Vhc2vvMWI8FxMUeVwSGaPWY3I/5YdKFAWyYQrPMA5vdLn7/F7GghJUU
   wzl2iY0H1oYEnD7ShrsvwwPHMcacwP2ewGFADYg3Ld5cAzPPA1vvl0+aT
   A9DWVaSCLhAEtNoua1F3x67dJxQtX4Et8Kl7knk+USAiukBUyw4Wcqkk0
   FkWrZL4vzT9EYQlLc65wvkRxMsXjX2ojbhVo3rBYX7gXU/x7kZtzvOZSu
   VjgmkTUiBZnVwmwmI22WvN/AzXPhWtVmrinQNiNVmYUDGemdLj2fwiEpW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255011985"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="255011985"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:46 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="495957061"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.194.198])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 11:16:46 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 06/10] selftests: mptcp: join: list failure at the end
Date: Wed,  9 Mar 2022 11:16:32 -0800
Message-Id: <20220309191636.258232-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309191636.258232-1-mathew.j.martineau@linux.intel.com>
References: <20220309191636.258232-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

With ~100 tests, it helps to have this summary at the end not to scroll
to find which one has failed.

It is especially interseting when looking at the output produced by the
CI where the kernel logs from the serial are mixed together.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 85 ++++++++++++-------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 64261c3ca320..d3038922a0d2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -22,6 +22,7 @@ init=0
 declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
+declare -A failed_tests
 TEST_COUNT=0
 TEST_NAME=""
 nr_blank=40
@@ -251,6 +252,21 @@ reset_with_allow_join_id0()
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
 }
 
+fail_test()
+{
+	ret=1
+	failed_tests[${TEST_COUNT}]="${TEST_NAME}"
+}
+
+get_failed_tests_ids()
+{
+	# sorted
+	local i
+	for i in "${!failed_tests[@]}"; do
+		echo "${i}"
+	done | sort -n
+}
+
 print_file_err()
 {
 	ls -l "$1" 1>&2
@@ -272,7 +288,7 @@ check_transfer()
 			echo "[ FAIL ] $what does not match (in, out):"
 			print_file_err "$in"
 			print_file_err "$out"
-			ret=1
+			fail_test
 
 			return 1
 		else
@@ -292,7 +308,7 @@ do_ping()
 	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
 	if [ $? -ne 0 ] ; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
-		ret=1
+		fail_test
 	fi
 }
 
@@ -541,7 +557,7 @@ pm_nl_check_endpoint()
 		echo "[ ok ]"
 	else
 		echo "[fail] expected '$expected_line' found '$line'"
-		ret=1
+		fail_test
 	fi
 }
 
@@ -795,7 +811,7 @@ do_transfer()
 		cat /tmp/${connector_ns}.out
 
 		cat "$capout"
-		ret=1
+		fail_test
 		return 1
 	fi
 
@@ -920,7 +936,7 @@ chk_csum_nr()
 	if [ "$count" != $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
 	   [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -931,7 +947,7 @@ chk_csum_nr()
 	if [ "$count" != $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] ||
 	   [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -951,7 +967,7 @@ chk_fail_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -962,7 +978,7 @@ chk_fail_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -983,7 +999,7 @@ chk_fclose_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fclose_tx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -994,7 +1010,7 @@ chk_fclose_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fclose_rx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1025,7 +1041,7 @@ chk_rst_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rst_tx" ]; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1036,7 +1052,7 @@ chk_rst_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rst_rx" ]; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1071,7 +1087,7 @@ chk_join_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1089,7 +1105,7 @@ chk_join_nr()
 			echo -n "[ ok ]"
 		else
 			echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		fi
 	else
@@ -1101,7 +1117,7 @@ chk_join_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1141,7 +1157,7 @@ chk_stale_nr()
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta "
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1178,7 +1194,7 @@ chk_add_nr()
 	# add addrs options, due to retransmissions
 	if [ "$count" != "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" -lt "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1189,7 +1205,7 @@ chk_add_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1201,7 +1217,7 @@ chk_add_nr()
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1214,7 +1230,7 @@ chk_add_nr()
 		if [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
 				port-number expected $syn_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1227,7 +1243,7 @@ chk_add_nr()
 		if [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
 				port-number expected $syn_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1240,7 +1256,7 @@ chk_add_nr()
 		if [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
 				port-number expected $ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1253,7 +1269,7 @@ chk_add_nr()
 		if [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
 				port-number expected $mis_syn_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1266,7 +1282,7 @@ chk_add_nr()
 		if [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
 				port-number expected $mis_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1311,7 +1327,7 @@ chk_rm_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1334,14 +1350,14 @@ chk_rm_nr()
 			echo "[ ok ] $suffix"
 		else
 			echo "[fail] got $count RM_SUBFLOW[s] expected in range [$rm_subflow_nr:$((rm_subflow_nr*2))]"
-			ret=1
+			fail_test
 			dump_stats=1
 		fi
 		return
 	fi
 	if [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1364,7 +1380,7 @@ chk_prio_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1375,7 +1391,7 @@ chk_prio_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1399,7 +1415,7 @@ chk_link_usage()
 	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
 	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
-		ret=1
+		fail_test
 	else
 		echo "[ ok ]"
 	fi
@@ -2616,4 +2632,13 @@ for subtests in "${tests[@]}"; do
 	"${subtests}"
 done
 
+if [ ${ret} -ne 0 ]; then
+	echo
+	echo "${#failed_tests[@]} failure(s) has(ve) been detected:"
+	for i in $(get_failed_tests_ids); do
+		echo -e "\t- ${i}: ${failed_tests[${i}]}"
+	done
+	echo
+fi
+
 exit $ret
-- 
2.35.1

