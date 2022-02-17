Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F1A3B28
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 17:43:52 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id k1so10324662wrd.8
        for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 09:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tp0ppQ2P9aUNhzzsbxlLIWxenYcpVipfI5uEcYVcBrU=;
        b=GIMuL9YVMdaq6gH7eiUZ/GQXJ2hfgX0zVPqCd9WOVLdjDqbeMHuoBBLO71VMrPhDcl
         Xi1HGCUDSOOKCPUfANS50yBcyNROGEB0srZzqFF3U8vq/1kZBOUkeioKYffoOOh4JFze
         oCtO2YmN59PLrZNBDT/xJPiJqXb6rA5KPCsR04nyom3aMeyD3GWek/K7p86BdDJXWhZv
         uUSNl1A3joSLI5F/ds+FMuw28Y/Y7SXSNX4OHnMowKHpkEjn10uzIPjPDdfn5yyj7V+h
         dXihuDVGk9j7dRrAV1f0OGZfGkPiGPrA9+H1QkmkC5qjYdRGsOapvQLBYUAf0Mi7LVzE
         B+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tp0ppQ2P9aUNhzzsbxlLIWxenYcpVipfI5uEcYVcBrU=;
        b=IJ8uWkSLHyBAc3ArjWI1sfeiEApQ1OPnZJdv7zUWazqxb546GPOSC8tZzANtGMLw7O
         EzIT8wmGqna1qht4mXimcMhGDH2y/i2v3ebaG1+Xhc2v7fDXWAwJ15CTBCbuPwF6SU/Z
         vO7yqmnZ9uGsxcS8E1CQO6Jpf8NiDMC+8fhFAVtB55mk2TKtfAsgLVQvC52IFa/gn22t
         T3lsRfsD4z3Bhxr6h2ZZ2bFm2AEFOyNelM6mpFcM0B3Oy5KqUo9U4Fnd3wPq442NXaoP
         B9xMqS04JM3kkPizfN2yMd7JLlvq79epHYV9XfJEIC7s1SVUoo21QPmEQEm7X3h4boZ6
         HYNw==
X-Gm-Message-State: AOAM53165XL7GF/XVM3tnCG01U6YQ5Xm3NLtdni0dFQMUv/OCk/6Eotw
	VfG/0OMzsA9ok9N1DxiyAUyQgrrrGSpheoFu
X-Google-Smtp-Source: ABdhPJwP6BdxTmmSkMk1dsDH/oOqGLmjBBRSVVpKEbA63Vz4q2O9jSLu9wOvwCm6eVCCKi67Dgh/Bw==
X-Received: by 2002:adf:eb81:0:b0:1e3:2bf5:132 with SMTP id t1-20020adfeb81000000b001e32bf50132mr3185109wrn.246.1645119830351;
        Thu, 17 Feb 2022 09:43:50 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm23060203wrb.43.2022.02.17.09.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:43:49 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 6/9] selftests: mptcp: join: list failure at the end
Date: Thu, 17 Feb 2022 18:43:26 +0100
Message-Id: <20220217174329.826430-7-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217174329.826430-1-matthieu.baerts@tessares.net>
References: <20220217174329.826430-1-matthieu.baerts@tessares.net>
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

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 77 ++++++++++++-------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index de701de19219..346fdae1f876 100755
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
@@ -249,6 +250,21 @@ reset_with_allow_join_id0()
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
@@ -270,7 +286,7 @@ check_transfer()
 			echo "[ FAIL ] $what does not match (in, out):"
 			print_file_err "$in"
 			print_file_err "$out"
-			ret=1
+			fail_test
 
 			return 1
 		else
@@ -290,7 +306,7 @@ do_ping()
 	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
 	if [ $? -ne 0 ] ; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
-		ret=1
+		fail_test
 	fi
 }
 
@@ -691,7 +707,7 @@ do_transfer()
 		cat /tmp/${connector_ns}.out
 
 		cat "$capout"
-		ret=1
+		fail_test
 		return 1
 	fi
 
@@ -793,7 +809,7 @@ chk_csum_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -803,7 +819,7 @@ chk_csum_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -823,7 +839,7 @@ chk_fail_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_fail_nr_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -834,7 +850,7 @@ chk_fail_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_fail_nr_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -855,7 +871,7 @@ chk_infi_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_infi_nr_tx" ]; then
 		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -866,7 +882,7 @@ chk_infi_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_infi_nr_rx" ]; then
 		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -889,7 +905,7 @@ chk_join_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -907,7 +923,7 @@ chk_join_nr()
 			echo -n "[ ok ]"
 		else
 			echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		fi
 	else
@@ -919,7 +935,7 @@ chk_join_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -959,7 +975,7 @@ chk_stale_nr()
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta "
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -996,7 +1012,7 @@ chk_add_nr()
 	# add addrs options, due to retransmissions
 	if [ "$count" != "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" -lt "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1007,7 +1023,7 @@ chk_add_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1019,7 +1035,7 @@ chk_add_nr()
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1032,7 +1048,7 @@ chk_add_nr()
 		if [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
 				port-number expected $syn_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1045,7 +1061,7 @@ chk_add_nr()
 		if [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
 				port-number expected $syn_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1058,7 +1074,7 @@ chk_add_nr()
 		if [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
 				port-number expected $ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1071,7 +1087,7 @@ chk_add_nr()
 		if [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
 				port-number expected $mis_syn_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
@@ -1084,7 +1100,7 @@ chk_add_nr()
 		if [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
 				port-number expected $mis_ack_nr"
-			ret=1
+			fail_test
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1119,7 +1135,7 @@ chk_rm_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1130,7 +1146,7 @@ chk_rm_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1151,7 +1167,7 @@ chk_prio_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1162,7 +1178,7 @@ chk_prio_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
-		ret=1
+		fail_test
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1186,7 +1202,7 @@ chk_link_usage()
 	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
 	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
-		ret=1
+		fail_test
 	else
 		echo "[ ok ]"
 	fi
@@ -2436,4 +2452,13 @@ for subtests in "${tests[@]}"; do
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

