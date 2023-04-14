Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C920F6
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681481991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+XK6AM42r3xlyaOWrdGldYO/Vaj23WADZwpmnl2T7M=;
	b=Iy0FHB6WoD0inkuq9i1MIQ8I5HeiKP9WAheKJXorDvRv8Q/39mQyrLCMytB9oiT8SyWYIz
	H1pXJsx3Kt6FHiF2yrR7+iZodeVsONA/F1KhkeWKQpIq/IbjXqOl+t7Eso9kHydWXZlblj
	S5/g7rZsQopBoaaKXJbeQuW/Oc3YwHk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-Ns1pLB4mM1uII6bvRBN2cg-1; Fri, 14 Apr 2023 10:19:48 -0400
X-MC-Unique: Ns1pLB4mM1uII6bvRBN2cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6743381496E
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 14:19:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B7082166B29
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 14:19:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 3/3] selftests: mptcp: centralize stats dumping
Date: Fri, 14 Apr 2023 16:19:34 +0200
Message-Id: <291b881c99c9fe75898c0f65a0f6a49c5066a1dd.1681481877.git.pabeni@redhat.com>
In-Reply-To: <cover.1681481877.git.pabeni@redhat.com>
References: <cover.1681481877.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

If a test case fails, the mptcp_join.sh script can dump the
netns MIBs multiple times, leading to confusing output.

Let's dump such info only once per test-case, when needed.
This additionally allow removing some code duplication.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 66 ++-----------------
 1 file changed, 5 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f6ce10130ded..5ae2301407e2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -30,6 +30,7 @@ evts_ns1=""
 evts_ns2=""
 evts_ns1_pid=0
 evts_ns2_pid=0
+stats_dumped=0
 
 declare -A all_tests
 declare -a only_tests_ids
@@ -83,6 +84,7 @@ init_partial()
 		fi
 	done
 
+	stats_dumped=0
 	check_invert=0
 	validate_checksum=$checksum
 	FAILING_LINKS=""
@@ -343,6 +345,9 @@ fail_test()
 {
 	ret=1
 	failed_tests[${TEST_COUNT}]="${TEST_NAME}"
+
+	[ "${stats_dumped}" = 0 ] && dump_stats
+	stats_dumped=1
 }
 
 get_failed_tests_ids()
@@ -1114,7 +1119,6 @@ chk_csum_nr()
 	local csum_ns1=${1:-0}
 	local csum_ns2=${2:-0}
 	local count
-	local dump_stats
 	local extra_msg=""
 	local allow_multi_errors_ns1=0
 	local allow_multi_errors_ns2=0
@@ -1138,7 +1142,6 @@ chk_csum_nr()
 	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
@@ -1152,11 +1155,9 @@ chk_csum_nr()
 	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
-	[ "${dump_stats}" = 1 ] && dump_stats
 
 	echo "$extra_msg"
 }
@@ -1167,7 +1168,6 @@ chk_fail_nr()
 	local fail_rx=$2
 	local ns_invert=${3:-""}
 	local count
-	local dump_stats
 	local ns_tx=$ns1
 	local ns_rx=$ns2
 	local extra_msg=""
@@ -1199,7 +1199,6 @@ chk_fail_nr()
 	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
@@ -1214,13 +1213,10 @@ chk_fail_nr()
 	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
-	[ "${dump_stats}" = 1 ] && dump_stats
-
 	echo "$extra_msg"
 }
 
@@ -1230,7 +1226,6 @@ chk_fclose_nr()
 	local fclose_rx=$2
 	local ns_invert=$3
 	local count
-	local dump_stats
 	local ns_tx=$ns2
 	local ns_rx=$ns1
 	local extra_msg="   "
@@ -1248,7 +1243,6 @@ chk_fclose_nr()
 	if [ "$count" != "$fclose_tx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
@@ -1260,13 +1254,10 @@ chk_fclose_nr()
 	if [ "$count" != "$fclose_rx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
-	[ "${dump_stats}" = 1 ] && dump_stats
-
 	echo "$extra_msg"
 }
 
@@ -1276,7 +1267,6 @@ chk_rst_nr()
 	local rst_rx=$2
 	local ns_invert=${3:-""}
 	local count
-	local dump_stats
 	local ns_tx=$ns1
 	local ns_rx=$ns2
 	local extra_msg=""
@@ -1293,7 +1283,6 @@ chk_rst_nr()
 	if [ $count -lt $rst_tx ]; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
@@ -1304,13 +1293,10 @@ chk_rst_nr()
 	if [ "$count" -lt "$rst_rx" ]; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
-	[ "${dump_stats}" = 1 ] && dump_stats
-
 	echo "$extra_msg"
 }
 
@@ -1319,7 +1305,6 @@ chk_infi_nr()
 	local infi_tx=$1
 	local infi_rx=$2
 	local count
-	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "itx"
 	count=$(ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print $2}')
@@ -1327,7 +1312,6 @@ chk_infi_nr()
 	if [ "$count" != "$infi_tx" ]; then
 		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
@@ -1338,12 +1322,9 @@ chk_infi_nr()
 	if [ "$count" != "$infi_rx" ]; then
 		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
 		fail_test
-		dump_stats=1
 	else
 		echo "[ ok ]"
 	fi
-
-	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
 chk_join_nr()
@@ -1358,7 +1339,6 @@ chk_join_nr()
 	local infi_nr=${8:-0}
 	local corrupted_pkts=${9:-0}
 	local count
-	local dump_stats
 	local with_cookie
 	local title="${TEST_NAME}"
 
@@ -1372,7 +1352,6 @@ chk_join_nr()
 	if [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
@@ -1390,7 +1369,6 @@ chk_join_nr()
 		else
 			echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
 			fail_test
-			dump_stats=1
 		fi
 	else
 		echo -n "[ ok ]"
@@ -1402,11 +1380,9 @@ chk_join_nr()
 	if [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
 		fail_test
-		dump_stats=1
 	else
 		echo "[ ok ]"
 	fi
-	[ "${dump_stats}" = 1 ] && dump_stats
 	if [ $validate_checksum -eq 1 ]; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
@@ -1466,7 +1442,6 @@ chk_add_nr()
 	local mis_syn_nr=${7:-0}
 	local mis_ack_nr=${8:-0}
 	local count
-	local dump_stats
 	local timeout
 
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
@@ -1480,7 +1455,6 @@ chk_add_nr()
 	if [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
@@ -1491,7 +1465,6 @@ chk_add_nr()
 	if [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
@@ -1503,7 +1476,6 @@ chk_add_nr()
 		if [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
 			fail_test
-			dump_stats=1
 		else
 			echo "[ ok ]"
 		fi
@@ -1516,7 +1488,6 @@ chk_add_nr()
 			echo "[fail] got $count JOIN[s] syn with a different \
 				port-number expected $syn_nr"
 			fail_test
-			dump_stats=1
 		else
 			echo -n "[ ok ]"
 		fi
@@ -1529,7 +1500,6 @@ chk_add_nr()
 			echo "[fail] got $count JOIN[s] synack with a different \
 				port-number expected $syn_ack_nr"
 			fail_test
-			dump_stats=1
 		else
 			echo -n "[ ok ]"
 		fi
@@ -1542,7 +1512,6 @@ chk_add_nr()
 			echo "[fail] got $count JOIN[s] ack with a different \
 				port-number expected $ack_nr"
 			fail_test
-			dump_stats=1
 		else
 			echo "[ ok ]"
 		fi
@@ -1555,7 +1524,6 @@ chk_add_nr()
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
 				port-number expected $mis_syn_nr"
 			fail_test
-			dump_stats=1
 		else
 			echo -n "[ ok ]"
 		fi
@@ -1568,22 +1536,18 @@ chk_add_nr()
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
 				port-number expected $mis_ack_nr"
 			fail_test
-			dump_stats=1
 		else
 			echo "[ ok ]"
 		fi
 	else
 		echo ""
 	fi
-
-	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
 chk_add_tx_nr()
 {
 	local add_tx_nr=$1
 	local echo_tx_nr=$2
-	local dump_stats
 	local timeout
 	local count
 
@@ -1598,7 +1562,6 @@ chk_add_tx_nr()
 	if [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] TX, expected $add_tx_nr"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
@@ -1609,12 +1572,9 @@ chk_add_tx_nr()
 	if [ "$count" != "$echo_tx_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] TX, expected $echo_tx_nr"
 		fail_test
-		dump_stats=1
 	else
 		echo "[ ok ]"
 	fi
-
-	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
 chk_rm_nr()
@@ -1624,7 +1584,6 @@ chk_rm_nr()
 	local invert
 	local simult
 	local count
-	local dump_stats
 	local addr_ns=$ns1
 	local subflow_ns=$ns2
 	local extra_msg=""
@@ -1651,7 +1610,6 @@ chk_rm_nr()
 	if [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
@@ -1675,20 +1633,16 @@ chk_rm_nr()
 		else
 			echo "[fail] got $count RM_SUBFLOW[s] expected in range [$rm_subflow_nr:$((rm_subflow_nr*2))]"
 			fail_test
-			dump_stats=1
 		fi
 		return
 	fi
 	if [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
-	[ "${dump_stats}" = 1 ] && dump_stats
-
 	echo "$extra_msg"
 }
 
@@ -1702,13 +1656,10 @@ chk_rm_tx_nr()
 	if [ "$count" != "$rm_addr_tx_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_tx_nr"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
-	[ "${dump_stats}" = 1 ] && dump_stats
-
 	echo "$extra_msg"
 }
 
@@ -1717,7 +1668,6 @@ chk_prio_nr()
 	local mp_prio_nr_tx=$1
 	local mp_prio_nr_rx=$2
 	local count
-	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "ptx"
 	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
@@ -1725,7 +1675,6 @@ chk_prio_nr()
 	if [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
 		fail_test
-		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
@@ -1736,12 +1685,9 @@ chk_prio_nr()
 	if [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
 		fail_test
-		dump_stats=1
 	else
 		echo "[ ok ]"
 	fi
-
-	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
 chk_subflow_nr()
@@ -1773,7 +1719,6 @@ chk_subflow_nr()
 		ss -N $ns1 -tOni
 		ss -N $ns1 -tOni | grep token
 		ip -n $ns1 mptcp endpoint
-		dump_stats
 	fi
 }
 
@@ -1813,7 +1758,6 @@ chk_mptcp_info()
 	if [ "$dump_stats" = 1 ]; then
 		ss -N $ns1 -inmHM
 		ss -N $ns2 -inmHM
-		dump_stats
 	fi
 }
 
-- 
2.39.2

