Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8A6959
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 21:35:04 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id q17so4743907edd.4
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jNrOHL1jtLgS/p1j3Ni2rsfbE859ozdpReKBEN0UcWI=;
        b=xqrLew9Qtp2x1IcYCxDkKw4CbdbEt+30lomyFoJsHqCY2nag10d3SFLbTvKuwYVVOu
         iEOd2k2Q9JNfPOx3I1AERcfiQsU5ifnkcNrQa/mRZatQ4TEoNcxVwdByVbY0NrtcGMjt
         BxQ9IbC9gewr8ZPcGCe+7eOIEoLZafEtNq+tY+WmxUjYpBjLz4+p5Ka47YJa2ujbmNdu
         +l85crl3qlmLWXtc1ZpGcC0NGGwwola0dKIkci5q92ZVg2WohZ4lgoOLeDyUyLMCWaiQ
         w7LxpVs9uDb4QbZzMZh1ycyXDFPwXa63FCqBHmL8wzwYdgdjtNxwj8+gSl8n+CJF4tJr
         3ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNrOHL1jtLgS/p1j3Ni2rsfbE859ozdpReKBEN0UcWI=;
        b=dYj/OF8/k8E6h8Ag7Ddc5gTaU5Ee85oTNi/dO8LSZgqVr+NUqQDkbUFjkrg80XlR65
         2tC6KUs/cB7QOWs3j1inWPsfDeKYNxJJTVLhW/DDerCHHAwQnNGy7JD1Zk82M7mjX33W
         /rrFSe+D+0guJFPdB/+i616VGN4Ld94POEl5okyW7V4SiPrZuSqvcW0o/6Zz7Xm0WN7T
         42qSMBmBAuH0YR3NtThTZUGSznwSqxE4TWuAXgiHY40jFMty/ebh41MVKdfRtEb345Hg
         CIY1c5O6AmzrNR69H0/tE5/28VsBhlqDuTRtw9ncWWSBvk16yfJ1oeLe4lWRqiX7bxiM
         4ikQ==
X-Gm-Message-State: AOAM5300QzN3pkHmx+dtbdv1w4M0pLALbkt7f28WNUD5IHRp4YSmL368
	x43Ui2npAgsb8uo+xVHccvZ28/UoCQ2/TnZk8BA=
X-Google-Smtp-Source: ABdhPJwsdwzHYYPd5nX4Dhk7m3HCmoleCs9bShdQ3l6DT/fQN9Beu8dyo7AN4PgBpf7xXz+isXZsWQ==
X-Received: by 2002:aa7:d499:0:b0:409:4e74:92c6 with SMTP id b25-20020aa7d499000000b004094e7492c6mr4283575edr.124.1645738502956;
        Thu, 24 Feb 2022 13:35:02 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm175195ejp.223.2022.02.24.13.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:35:02 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v4 08/12] selftests: mptcp: join: list failure at the end
Date: Thu, 24 Feb 2022 22:34:02 +0100
Message-Id: <20220224213406.3127061-9-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
References: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With ~100 tests, it helps to have this summary at the end not to scroll
to find which one has failed.

It is especially interseting when looking at the output produced by the
CI where the kernel logs from the serial are mixed together.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 89 ++++++++++++-------
 1 file changed, 57 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index cd21170fa33e..5be9168dd7a5 100755
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
@@ -302,6 +303,21 @@ reset_with_fail()
 		index 100 || exit 1
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
@@ -323,7 +339,7 @@ check_transfer()
 			echo "[ FAIL ] $what does not match (in, out):"
 			print_file_err "$in"
 			print_file_err "$out"
-			ret=1
+			fail_test
 
 			return 1
 		else
@@ -343,7 +359,7 @@ do_ping()
 	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
 	if [ $? -ne 0 ] ; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
-		ret=1
+		fail_test
 	fi
 }
 
@@ -592,7 +608,7 @@ pm_nl_check_endpoint()
 		echo "[ ok ]"
 	else
 		echo "[fail] expected '$expected_line' found '$line'"
-		ret=1
+		fail_test
 	fi
 }
 
@@ -846,7 +862,7 @@ do_transfer()
 		cat /tmp/${connector_ns}.out
 
 		cat "$capout"
-		ret=1
+		fail_test
 		return 1
 	fi
 
@@ -978,7 +994,7 @@ chk_csum_nr()
 	if [ "$count" != $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
 	   [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -989,7 +1005,7 @@ chk_csum_nr()
 	if [ "$count" != $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] ||
 	   [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1009,7 +1025,7 @@ chk_fail_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1020,7 +1036,7 @@ chk_fail_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1041,7 +1057,7 @@ chk_fclose_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fclose_tx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1052,7 +1068,7 @@ chk_fclose_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fclose_rx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1083,7 +1099,7 @@ chk_rst_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rst_tx" ]; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1094,7 +1110,7 @@ chk_rst_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rst_rx" ]; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1117,7 +1133,7 @@ chk_infi_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$infi_tx" ]; then
 		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1128,7 +1144,7 @@ chk_infi_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$infi_rx" ]; then
 		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1162,7 +1178,7 @@ chk_join_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1180,7 +1196,7 @@ chk_join_nr()
 			echo -n "[ ok ]"
 		else
 			echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		fi
 	else
@@ -1192,7 +1208,7 @@ chk_join_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1233,7 +1249,7 @@ chk_stale_nr()
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta "
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1270,7 +1286,7 @@ chk_add_nr()
 	# add addrs options, due to retransmissions
 	if [ "$count" != "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" -lt "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1281,7 +1297,7 @@ chk_add_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1293,7 +1309,7 @@ chk_add_nr()
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1306,7 +1322,7 @@ chk_add_nr()
 		if [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
 				port-number expected $syn_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1319,7 +1335,7 @@ chk_add_nr()
 		if [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
 				port-number expected $syn_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1332,7 +1348,7 @@ chk_add_nr()
 		if [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
 				port-number expected $ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1345,7 +1361,7 @@ chk_add_nr()
 		if [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
 				port-number expected $mis_syn_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1358,7 +1374,7 @@ chk_add_nr()
 		if [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
 				port-number expected $mis_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1403,7 +1419,7 @@ chk_rm_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1426,14 +1442,14 @@ chk_rm_nr()
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
@@ -1456,7 +1472,7 @@ chk_prio_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1467,7 +1483,7 @@ chk_prio_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1491,7 +1507,7 @@ chk_link_usage()
 	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
 	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
-		ret=1
+		fail_test
 	else
 		echo "[ ok ]"
 	fi
@@ -2810,4 +2826,13 @@ for subtests in "${tests[@]}"; do
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
2.34.1

