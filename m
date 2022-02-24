Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03491B62
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:56:51 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id bq11so2980710edb.2
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjEg6dAukF/y+4vJZSobkREbn4j97c5KhvyHsPGTJNQ=;
        b=dUpRVyuqbX3Ambrlm/K8Lqo59kzAdJny7SUrKiR5LN8dZbmd1gBu7dSOunMvEBemwA
         etQ6JuNkj1ZCAHOfk0ra2f1OJRwHH8IIEfp0nN8kiSDevs/EFJedZmy6LUV4U7mWRUCt
         tOUoqG2XSbTa8AXegirC5RKyUVr8fgP14zLBnce2lXweAOrFMwo0aMgoXIDYNrYLcP1V
         y36tcTWm7tcPit4R4WcYNasXXATX/Isz/RsD56oltCJirTVd9tZN8TlRKgf70iqyomRY
         /9TXNceTQfffZ23UuqWWm9yMwrFk4RVrX0nAskZsajbozCOhcbr0LQ8C42434fO8AdkK
         rqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjEg6dAukF/y+4vJZSobkREbn4j97c5KhvyHsPGTJNQ=;
        b=UxGPSCgPUYhOg2nMe4wlsgpEn0j9jVDc7pj5k8j7C2ZY/epqH3LWO/ZgRwKWiL9FeN
         t8UOrnfANglrZwt0DBdhP+rAn/K3DgCWGPIHixaa0+tZZb5LbE+wiR9i5Lob00ULLLrj
         /0/U4x20g/F8rDaiPwv8h+HD5tx8wU+DNiLwHBye0TNrsZF5mN4kUXixt3iTXEnpa8Hj
         sMC1JgPY0JBvx+mmaSHbY3Ndl5EkvZTuv5wKPX7FLGuzoUReJeLLa9Dsqc+5vFeAZwtp
         Z6I/jbQyXVm7NKncg/smOcUP/ibcTsj1zvdmAXv5/2b4QwVjkQIjUT5XJ/HDFgQ5E4hJ
         cj0w==
X-Gm-Message-State: AOAM531yE2QgCr7RUqhWN/JJSLSNYCg9QglSQPzuwdv+n9gr3PcHF1fc
	fk1/dC8mF51YUjS5syz6SsThX5NpBouqNfIrMtY=
X-Google-Smtp-Source: ABdhPJyv/sS0mYpVrvXvSbGEVyBBDYyo69RGARoxBmOzOvAOlJ6To53dIj3eXTV1Kxy09y7jmhQwbg==
X-Received: by 2002:a05:6402:492:b0:404:c4bf:8b7e with SMTP id k18-20020a056402049200b00404c4bf8b7emr2380670edv.318.1645711010043;
        Thu, 24 Feb 2022 05:56:50 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm1360733edw.37.2022.02.24.05.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:49 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v3 08/12] selftests: mptcp: join: list failure at the end
Date: Thu, 24 Feb 2022 14:56:15 +0100
Message-Id: <20220224135619.2523272-9-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
References: <20220224135619.2523272-1-matthieu.baerts@tessares.net>
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
index c12b1baef29e..b07cbf1a80ca 100755
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
 
@@ -588,7 +604,7 @@ pm_nl_check_endpoint()
 		echo "[ ok ]"
 	else
 		echo "[fail] expected '$expected_line' found '$line'"
-		ret=1
+		fail_test
 	fi
 }
 
@@ -842,7 +858,7 @@ do_transfer()
 		cat /tmp/${connector_ns}.out
 
 		cat "$capout"
-		ret=1
+		fail_test
 		return 1
 	fi
 
@@ -974,7 +990,7 @@ chk_csum_nr()
 	if [ "$count" != $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
 	   [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -985,7 +1001,7 @@ chk_csum_nr()
 	if [ "$count" != $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] ||
 	   [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1005,7 +1021,7 @@ chk_fail_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1016,7 +1032,7 @@ chk_fail_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fail_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1037,7 +1053,7 @@ chk_fclose_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fclose_tx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1048,7 +1064,7 @@ chk_fclose_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$fclose_rx" ]; then
 		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1079,7 +1095,7 @@ chk_rst_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rst_tx" ]; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1090,7 +1106,7 @@ chk_rst_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rst_rx" ]; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1113,7 +1129,7 @@ chk_infi_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$infi_tx" ]; then
 		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1124,7 +1140,7 @@ chk_infi_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$infi_rx" ]; then
 		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1158,7 +1174,7 @@ chk_join_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1176,7 +1192,7 @@ chk_join_nr()
 			echo -n "[ ok ]"
 		else
 			echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		fi
 	else
@@ -1188,7 +1204,7 @@ chk_join_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1229,7 +1245,7 @@ chk_stale_nr()
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta "
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1266,7 +1282,7 @@ chk_add_nr()
 	# add addrs options, due to retransmissions
 	if [ "$count" != "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" -lt "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1277,7 +1293,7 @@ chk_add_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1289,7 +1305,7 @@ chk_add_nr()
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1302,7 +1318,7 @@ chk_add_nr()
 		if [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
 				port-number expected $syn_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1315,7 +1331,7 @@ chk_add_nr()
 		if [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
 				port-number expected $syn_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1328,7 +1344,7 @@ chk_add_nr()
 		if [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
 				port-number expected $ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1341,7 +1357,7 @@ chk_add_nr()
 		if [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
 				port-number expected $mis_syn_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1354,7 +1370,7 @@ chk_add_nr()
 		if [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
 				port-number expected $mis_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1399,7 +1415,7 @@ chk_rm_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1422,14 +1438,14 @@ chk_rm_nr()
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
@@ -1452,7 +1468,7 @@ chk_prio_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1463,7 +1479,7 @@ chk_prio_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1487,7 +1503,7 @@ chk_link_usage()
 	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
 	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
-		ret=1
+		fail_test
 	else
 		echo "[ ok ]"
 	fi
@@ -2806,4 +2822,13 @@ for subtests in "${tests[@]}"; do
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

