Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B47C2D9
	for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 14:49:41 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-312826ffedbso6299645f8f.0
        for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687963780; x=1690555780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vfqrk20+al3BKWquPZbL6s2RUFQmQa2YhpP8cy1OoQs=;
        b=to+MX3wUJbULJraESb5E1hKkFRDvQEdeKu46dEMdYHNDXCDtPcW0134P+4fOzmj3Gg
         85JcKRtYiTZZ+dbVhoAE1DCJFDNacL1ol6P54x+9NjuioEd3kyyu3Awn3LankJQahPzK
         UJOPW+shctLvsGfi9jFXsnooqtZEnPM2KU7xvLHLOhjiocDFF7/E6KmtaeLGrpHwUKD6
         EH8XSDbcoMKXLEHiLZ8zHX8ONiR1ePUrsOkfnTI6ucrm12fULvxRxgkCnaonliMYkRJr
         LnuHYtS6hWrlfxaheSicfUGb3pAlhRFm0CQnaMIsHrmtO7HLyQpuFT5I3XlwjPql9uwv
         6KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687963780; x=1690555780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vfqrk20+al3BKWquPZbL6s2RUFQmQa2YhpP8cy1OoQs=;
        b=JPlhL6eiIQh1DqHB/nKWMPCbfWQEoKMKk9zo8g/XczfmodxEmHgON3DvkWjKNYQR3d
         GGNuRluppK0oeLBx8X1fFkM1FAKuRfdYH42Ak5khHKUBzdZ19/WNShr8gj+QyCzNmR8y
         Ss6T3t0Fg9aw1NkuyTrtaIW4DQiMdftklbuDPqLYufe4WcGSlHXNQKccGicD5MHhpSFg
         ph/TNI2jY8S3chuWxdr5YawwWXaH1QXsXDnAA2b3/Cxb+0Fs1p67B0tF2yDpGetemnFX
         zB2Vd2nFP23TEfaF0pA0Mvomx/FwbRM9Vx1VJlPcMFeW+eEOrFs3qG+GckdKC3cVk/Ut
         EmhA==
X-Gm-Message-State: AC+VfDxsHu7rMiEf4n46vtxCbhQZfrzEAsgVbqtPFKn+LsuTwD5KhJfI
	fP2vmZhGY9gscJqypy6eIMeVcMx+RgnPs8cUhnMN2kzX
X-Google-Smtp-Source: ACHHUZ4Sa3a0zlrK+vPw0h9z1zecpOvAWhXwjYp2294s+EChsPXN29OoFivA2L3sXzXFNw8C90ovTg==
X-Received: by 2002:adf:dc88:0:b0:313:ee3e:50c5 with SMTP id r8-20020adfdc88000000b00313ee3e50c5mr8656857wrj.20.1687963779251;
        Wed, 28 Jun 2023 07:49:39 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id a10-20020adfdd0a000000b0030af15d7e41sm13713300wrm.4.2023.06.28.07.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:49:39 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 1/2] selftests: mptcp: join: rework detailed report
Date: Wed, 28 Jun 2023 16:49:26 +0200
Message-Id: <20230628144927.828117-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230628144927.828117-1-matthieu.baerts@tessares.net>
References: <20230628144927.828117-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=29567; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=NmomtAw7myYlnRiz9cfdDXAk9QjYedXyrh6PmSKj2OY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBknEh31EN/lTqsYqkPtV4Y4PAIKV+zVI4kSSb8s
 hfRWAbxgteJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJxIdwAKCRD2t4JPQmmg
 c8S9EACiKtGIBtT4EKSjoDHwJjK7SY+J8A6tDnLqiGGpMeBtVAyTrYOpjLS4PNrv42hDnrh5tb1
 hmw0Z60UT6w94SCutc1YpXxAVX2ahJ1QYqgOtolw3WXHEbP6rVNCGtC0UbkvBtvcD7ttKj4Gbpw
 zZwL8YWI8cgmiYQ5z/VskLinrRym+B88i5veieWRNVlatyfcri2fubQeT3rVH/sDO80VcI7c6BX
 fiXFM67FPFyP0qbbyMwdw47WNtp+zSIktpfaA+l/nnqwPa7LOFDSkgDhMONSm0OVgFiwH3Ipn2C
 EN32TTMvkEor8CTyCSChYix50gHT/Lc0PUMpdOTFh2Shk3ZLz+9F6tP7MSLWVuTWhSzVg+fj41q
 NJRAra9bIuNl/a65vKBFinOCxARjDdsFUV+ZQcYPNt+8CUgPjnU0FgG2mukYz0JrD9z3QhA63gv
 e3Sx78c2h5zB5Et1Ub5RHQlAUzjihBJnLieI/LLeuhY2Zu3JDGwTpvh1oQ9c0cOXeGpFlCPmYIR
 wfQxSd1P68izblP6hWIDH/TjKi5OI9R7+fMaInywyzOASEXaIzbYpBC1/AHVOS+Livrs3879ypI
 t7+RZEQReFjcVCqR42xsErA12OXekbiOFNbU2IMbshsJ1TO9L9/37f1gTKe9tlADuJtzbto+OQ8 vzCHQ7JJk9sb6Mw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This patch modifies how the detailed results are printed, mainly to
improve what is displayed in case of issue:

- Now the test name (title) is printed earlier, when starting the test
  if it is not intentionally skipped: by doing that, errors linked to
  a test will be printed after having written the test name and then
  avoid confusions.

- Due of the previous item, it is required to add a new line after
  having printed the test name because in case of error with a command,
  it is better not to have the output in the middle of the screen.

- Each check is printed on a dedicated line with aligned status (ok,
  skip, fail): it is easier to spot which one has failed, simpler to
  manage in the code not having to deal with alignment case by case and
  helpers can be used to uniform what is done. These helpers can also be
  useful later to do more actions depending on the results or change in
  one place what is printed.

- Info messages have been reduced and aligned as well. And info about
  the creation of the default test files of 1 KB is no longer printed.

Example:

  001 no JOIN
        syn                                 [ ok ]
        synack                              [ ok ]
        ack                                 [ ok ]

Or with a skip and a failure:

  001 no JOIN
        syn                                 [ ok ]
        synack                              [fail] got 42 JOIN[s] synack expected 0
  Server ns stats
  (...)
  Client ns stats
  (...)
        ack                                 [skip]

Or with info:

  104 Infinite map
        Test file (size 128 KB) for client
        Test file (size 128 KB) for server
        file received by server has inverted byte at 169
        5 corrupted pkts
        syn                                 [ ok ]
        synack                              [ ok ]

While at it, verify_listener_events() now also print more info in case
of failure and in pm_nl_check_endpoint(), the test is marked as failed
instead of skipped if no ID has been given (internal selftest issue).

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 457 +++++++++---------
 1 file changed, 221 insertions(+), 236 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5c5c8b5e068f..3a0e2fa7754b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -49,7 +49,7 @@ declare -a only_tests_names
 declare -A failed_tests
 TEST_COUNT=0
 TEST_NAME=""
-nr_blank=40
+nr_blank=6
 
 export FAILING_LINKS=""
 export test_linkfail=0
@@ -184,8 +184,8 @@ init() {
 
 	trap cleanup EXIT
 
-	make_file "$cin" "client" 1
-	make_file "$sin" "server" 1
+	make_file "$cin" "client" 1 >/dev/null
+	make_file "$sin" "server" 1 >/dev/null
 }
 
 cleanup()
@@ -197,10 +197,34 @@ cleanup()
 	cleanup_partial
 }
 
-# $1: msg
 print_title()
 {
-	printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${1}"
+	printf "%03u %s\n" "${TEST_COUNT}" "${TEST_NAME}"
+}
+
+print_check()
+{
+	printf "%-${nr_blank}s%-36s" " " "${*}"
+}
+
+print_info()
+{
+	printf "%-${nr_blank}sInfo: %s\n" " " "${*}"
+}
+
+print_ok()
+{
+	echo "[ ok ]${1:+ ${*}}"
+}
+
+print_fail()
+{
+	echo "[fail]${1:+ ${*}}"
+}
+
+print_skip()
+{
+	echo "[skip]${1:+ ${*}}"
 }
 
 # [ $1: fail msg ]
@@ -210,8 +234,8 @@ mark_as_skipped()
 
 	mptcp_lib_fail_if_expected_feature "${msg}"
 
-	print_title "[ skip ] ${msg}"
-	printf "\n"
+	print_check "${msg}"
+	print_skip
 
 	last_test_skipped=1
 }
@@ -275,6 +299,8 @@ reset()
 		return 1
 	fi
 
+	print_title
+
 	if [ "${init}" != "1" ]; then
 		init
 	else
@@ -455,10 +481,13 @@ reset_with_tcp_filter()
 	fi
 }
 
+# $1: err msg
 fail_test()
 {
 	ret=1
 
+	print_fail "${@}"
+
 	# just in case a test is marked twice as failed
 	if [ ${last_test_failed} -eq 0 ]; then
 		failed_tests[${TEST_COUNT}]="${TEST_NAME}"
@@ -479,7 +508,7 @@ get_failed_tests_ids()
 print_file_err()
 {
 	ls -l "$1" 1>&2
-	echo "Trailing bytes are: "
+	echo -n "Trailing bytes are: "
 	tail -c 27 "$1"
 }
 
@@ -497,8 +526,7 @@ check_transfer()
 		# when truncating we must check the size explicitly
 		out_size=$(wc -c $out | awk '{print $1}')
 		if [ $out_size -ne $bytes ]; then
-			echo "[ FAIL ] $what output file has wrong size ($out_size, $bytes)"
-			fail_test
+			fail_test "$what output file has wrong size ($out_size, $bytes)"
 			return 1
 		fi
 
@@ -513,14 +541,13 @@ check_transfer()
 	cmp -l "$in" "$out" | while read -r i a b; do
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
-			echo "[ FAIL ] $what does not match (in, out):"
+			fail_test "$what does not match (in, out):"
 			print_file_err "$in"
 			print_file_err "$out"
-			fail_test
 
 			return 1
 		else
-			echo "$what has inverted byte at ${i}"
+			print_info "$what has inverted byte at ${i}"
 		fi
 	done
 
@@ -534,8 +561,7 @@ do_ping()
 	local connect_addr="$3"
 
 	if ! ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null; then
-		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
-		fail_test
+		fail_test "$listener_ns -> $connect_addr connectivity"
 	fi
 }
 
@@ -773,10 +799,9 @@ pm_nl_change_endpoint()
 pm_nl_check_endpoint()
 {
 	local line expected_line
-	local need_title=$1
-	local msg="$2"
-	local ns=$3
-	local addr=$4
+	local msg="$1"
+	local ns=$2
+	local addr=$3
 	local _flags=""
 	local flags
 	local _port
@@ -785,13 +810,9 @@ pm_nl_check_endpoint()
 	local _id
 	local id
 
-	if [ "${need_title}" = 1 ]; then
-		printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${msg}"
-	else
-		printf "%-${nr_blank}s %s" " " "${msg}"
-	fi
+	print_check "${msg}"
 
-	shift 4
+	shift 3
 	while [ -n "$1" ]; do
 		if [ $1 = "flags" ]; then
 			_flags=$2
@@ -814,7 +835,7 @@ pm_nl_check_endpoint()
 	done
 
 	if [ -z "$id" ]; then
-		echo "[skip] bad test - missing endpoint id"
+		test_fail "bad test - missing endpoint id"
 		return
 	fi
 
@@ -837,10 +858,9 @@ pm_nl_check_endpoint()
 		[ -n "$_port" ] && expected_line="$expected_line $_port"
 	fi
 	if [ "$line" = "$expected_line" ]; then
-		echo "[ ok ]"
+		print_ok
 	else
-		echo "[fail] expected '$expected_line' found '$line'"
-		fail_test
+		fail_test "expected '$expected_line' found '$line'"
 	fi
 }
 
@@ -1043,8 +1063,7 @@ do_transfer()
 	local trunc_size=""
 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
 		if [ ${test_linkfail} -le 1 ]; then
-			echo "fastclose tests need test_linkfail argument"
-			fail_test
+			fail_test "fastclose tests need test_linkfail argument"
 			return 1
 		fi
 
@@ -1059,8 +1078,7 @@ do_transfer()
 			extra_srv_args="-f ${test_linkfail}"
 			extra_cl_args="-f -1"
 		else
-			echo "wrong/unknown fastclose spec ${side}"
-			fail_test
+			fail_test "wrong/unknown fastclose spec ${side}"
 			return 1
 		fi
 		addr_nr_ns2=0
@@ -1125,7 +1143,7 @@ do_transfer()
 		nstat | grep Tcp > /tmp/${connector_ns}.out
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
-		echo " client exit code $retc, server $rets" 1>&2
+		fail_test "client exit code $retc, server $rets"
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${listener_ns} ss -Menita 1>&2 -o "sport = :$port"
 		cat /tmp/${listener_ns}.out
@@ -1134,7 +1152,6 @@ do_transfer()
 		cat /tmp/${connector_ns}.out
 
 		cat "$capout"
-		fail_test
 		return 1
 	fi
 
@@ -1169,7 +1186,7 @@ make_file()
 	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 
-	echo "Created $name (size $size KB) containing data sent by $who"
+	print_info "Test file (size $size KB) for $who"
 }
 
 run_tests()
@@ -1250,36 +1267,36 @@ chk_csum_nr()
 		csum_ns2=${csum_ns2:1}
 	fi
 
-	printf "%-${nr_blank}s %s" " " "sum"
+	print_check "sum"
 	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns1" ]; then
 		extra_msg="$extra_msg ns1=$count"
 	fi
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
 	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
-		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
-		fail_test
+		fail_test "got $count data checksum error[s] expected $csum_ns1"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
-	echo -n " - csum  "
+	print_check "csum"
 	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns2" ]; then
 		extra_msg="$extra_msg ns2=$count"
 	fi
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
 	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
-		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
-		fail_test
+		fail_test "got $count data checksum error[s] expected $csum_ns2"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo "$extra_msg"
+	if [ -n "$extra_msg" ]; then
+		print_info "$extra_msg"
+	fi
 }
 
 chk_fail_nr()
@@ -1297,7 +1314,7 @@ chk_fail_nr()
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns2
 		ns_rx=$ns1
-		extra_msg=" invert"
+		extra_msg="invert"
 	fi
 
 	if [[ "${fail_tx}" = "-"* ]]; then
@@ -1309,37 +1326,37 @@ chk_fail_nr()
 		fail_rx=${fail_rx:1}
 	fi
 
-	printf "%-${nr_blank}s %s" " " "ftx"
+	print_check "ftx"
 	count=$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ "$count" != "$fail_tx" ]; then
 		extra_msg="$extra_msg,tx=$count"
 	fi
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
 	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
-		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
-		fail_test
+		fail_test "got $count MP_FAIL[s] TX expected $fail_tx"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo -n " - failrx"
+	print_check "failrx"
 	count=$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ "$count" != "$fail_rx" ]; then
 		extra_msg="$extra_msg,rx=$count"
 	fi
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
 	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
-		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
-		fail_test
+		fail_test "got $count MP_FAIL[s] RX expected $fail_rx"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo "$extra_msg"
+	if [ -n "$extra_msg" ]; then
+		print_info "$extra_msg"
+	fi
 }
 
 chk_fclose_nr()
@@ -1350,39 +1367,39 @@ chk_fclose_nr()
 	local count
 	local ns_tx=$ns2
 	local ns_rx=$ns1
-	local extra_msg="   "
+	local extra_msg=""
 
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns1
 		ns_rx=$ns2
-		extra_msg=${extra_msg}"invert"
+		extra_msg="invert"
 	fi
 
-	printf "%-${nr_blank}s %s" " " "ctx"
+	print_check "ctx"
 	count=$(get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif [ "$count" != "$fclose_tx" ]; then
 		extra_msg="$extra_msg,tx=$count"
-		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
-		fail_test
+		fail_test "got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo -n " - fclzrx"
+	print_check "fclzrx"
 	count=$(get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif [ "$count" != "$fclose_rx" ]; then
 		extra_msg="$extra_msg,rx=$count"
-		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
-		fail_test
+		fail_test "got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo "$extra_msg"
+	if [ -n "$extra_msg" ]; then
+		print_info "$extra_msg"
+	fi
 }
 
 chk_rst_nr()
@@ -1398,32 +1415,32 @@ chk_rst_nr()
 	if [[ $ns_invert = "invert" ]]; then
 		ns_tx=$ns2
 		ns_rx=$ns1
-		extra_msg="   invert"
+		extra_msg="invert"
 	fi
 
-	printf "%-${nr_blank}s %s" " " "rtx"
+	print_check "rtx"
 	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif [ $count -lt $rst_tx ]; then
-		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
-		fail_test
+		fail_test "got $count MP_RST[s] TX expected $rst_tx"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo -n " - rstrx "
+	print_check "rstrx"
 	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif [ "$count" -lt "$rst_rx" ]; then
-		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
-		fail_test
+		fail_test "got $count MP_RST[s] RX expected $rst_rx"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo "$extra_msg"
+	if [ -n "$extra_msg" ]; then
+		print_info "$extra_msg"
+	fi
 }
 
 chk_infi_nr()
@@ -1432,26 +1449,24 @@ chk_infi_nr()
 	local infi_rx=$2
 	local count
 
-	printf "%-${nr_blank}s %s" " " "itx"
+	print_check "itx"
 	count=$(get_counter ${ns2} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif [ "$count" != "$infi_tx" ]; then
-		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
-		fail_test
+		fail_test "got $count infinite map[s] TX expected $infi_tx"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo -n " - infirx"
+	print_check "infirx"
 	count=$(get_counter ${ns1} "MPTcpExtInfiniteMapRx")
 	if [ -z "$count" ]; then
-		echo "[skip]"
+		print_skip
 	elif [ "$count" != "$infi_rx" ]; then
-		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
-		fail_test
+		fail_test "got $count infinite map[s] RX expected $infi_rx"
 	else
-		echo "[ ok ]"
+		print_ok
 	fi
 }
 
@@ -1468,51 +1483,47 @@ chk_join_nr()
 	local corrupted_pkts=${9:-0}
 	local count
 	local with_cookie
-	local title="${TEST_NAME}"
 
 	if [ "${corrupted_pkts}" -gt 0 ]; then
-		title+=": ${corrupted_pkts} corrupted pkts"
+		print_info "${corrupted_pkts} corrupted pkts"
 	fi
 
-	printf "%03u %-36s %s" "${TEST_COUNT}" "${title}" "syn"
+	print_check "syn"
 	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynRx")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif [ "$count" != "$syn_nr" ]; then
-		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
-		fail_test
+		fail_test "got $count JOIN[s] syn expected $syn_nr"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo -n " - synack"
+	print_check "synack"
 	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
 	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif [ "$count" != "$syn_ack_nr" ]; then
 		# simult connections exceeding the limit with cookie enabled could go up to
 		# synack validation as the conn limit can be enforced reliably only after
 		# the subflow creation
 		if [ "$with_cookie" = 2 ] && [ "$count" -gt "$syn_ack_nr" ] && [ "$count" -le "$syn_nr" ]; then
-			echo -n "[ ok ]"
+			print_ok
 		else
-			echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
-			fail_test
+			fail_test "got $count JOIN[s] synack expected $syn_ack_nr"
 		fi
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo -n " - ack"
+	print_check "ack"
 	count=$(get_counter ${ns1} "MPTcpExtMPJoinAckRx")
 	if [ -z "$count" ]; then
-		echo "[skip]"
+		print_skip
 	elif [ "$count" != "$ack_nr" ]; then
-		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
-		fail_test
+		fail_test "got $count JOIN[s] ack expected $ack_nr"
 	else
-		echo "[ ok ]"
+		print_ok
 	fi
 	if [ $validate_checksum -eq 1 ]; then
 		chk_csum_nr $csum_ns1 $csum_ns2
@@ -1537,22 +1548,21 @@ chk_stale_nr()
 	local stale_nr
 	local recover_nr
 
-	printf "%-${nr_blank}s %-18s" " " "stale"
+	print_check "stale"
 
 	stale_nr=$(get_counter ${ns} "MPTcpExtSubflowStale")
 	recover_nr=$(get_counter ${ns} "MPTcpExtSubflowRecover")
 	if [ -z "$stale_nr" ] || [ -z "$recover_nr" ]; then
-		echo "[skip]"
+		print_skip
 	elif [ $stale_nr -lt $stale_min ] ||
 	   { [ $stale_max -gt 0 ] && [ $stale_nr -gt $stale_max ]; } ||
 	   [ $((stale_nr - recover_nr)) -ne $stale_delta ]; then
-		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
+		fail_test "got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
-		     " stale-recover delta $stale_delta "
-		fail_test
+		     " stale-recover delta $stale_delta"
 		dump_stats=1
 	else
-		echo "[ ok ]"
+		print_ok
 	fi
 
 	if [ "${dump_stats}" = 1 ]; then
@@ -1577,103 +1587,93 @@ chk_add_nr()
 
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
-	printf "%-${nr_blank}s %s" " " "add"
+	print_check "add"
 	count=$(get_counter ${ns2} "MPTcpExtAddAddr")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
 	elif [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
-		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
-		fail_test
+		fail_test "got $count ADD_ADDR[s] expected $add_nr"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo -n " - echo  "
+	print_check "echo"
 	count=$(get_counter ${ns1} "MPTcpExtEchoAdd")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif [ "$count" != "$echo_nr" ]; then
-		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
-		fail_test
+		fail_test "got $count ADD_ADDR echo[s] expected $echo_nr"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
 	if [ $port_nr -gt 0 ]; then
-		echo -n " - pt "
+		print_check "pt"
 		count=$(get_counter ${ns2} "MPTcpExtPortAdd")
 		if [ -z "$count" ]; then
-			echo "[skip]"
+			print_skip
 		elif [ "$count" != "$port_nr" ]; then
-			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
-			fail_test
+			fail_test "got $count ADD_ADDR[s] with a port-number expected $port_nr"
 		else
-			echo "[ ok ]"
+			print_ok
 		fi
 
-		printf "%-${nr_blank}s %s" " " "syn"
+		print_check "syn"
 		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
 		if [ -z "$count" ]; then
-			echo -n "[skip]"
+			print_skip
 		elif [ "$count" != "$syn_nr" ]; then
-			echo "[fail] got $count JOIN[s] syn with a different \
-				port-number expected $syn_nr"
-			fail_test
+			fail_test "got $count JOIN[s] syn with a different \
+				   port-number expected $syn_nr"
 		else
-			echo -n "[ ok ]"
+			print_ok
 		fi
 
-		echo -n " - synack"
+		print_check "synack"
 		count=$(get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
 		if [ -z "$count" ]; then
-			echo -n "[skip]"
+			print_skip
 		elif [ "$count" != "$syn_ack_nr" ]; then
-			echo "[fail] got $count JOIN[s] synack with a different \
-				port-number expected $syn_ack_nr"
-			fail_test
+			fail_test "got $count JOIN[s] synack with a different \
+				   port-number expected $syn_ack_nr"
 		else
-			echo -n "[ ok ]"
+			print_ok
 		fi
 
-		echo -n " - ack"
+		print_check "ack"
 		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
 		if [ -z "$count" ]; then
-			echo "[skip]"
+			print_skip
 		elif [ "$count" != "$ack_nr" ]; then
-			echo "[fail] got $count JOIN[s] ack with a different \
-				port-number expected $ack_nr"
-			fail_test
+			fail_test "got $count JOIN[s] ack with a different \
+				   port-number expected $ack_nr"
 		else
-			echo "[ ok ]"
+			print_ok
 		fi
 
-		printf "%-${nr_blank}s %s" " " "syn"
+		print_check "syn"
 		count=$(get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
 		if [ -z "$count" ]; then
-			echo -n "[skip]"
+			print_skip
 		elif [ "$count" != "$mis_syn_nr" ]; then
-			echo "[fail] got $count JOIN[s] syn with a mismatched \
-				port-number expected $mis_syn_nr"
-			fail_test
+			fail_test "got $count JOIN[s] syn with a mismatched \
+				   port-number expected $mis_syn_nr"
 		else
-			echo -n "[ ok ]"
+			print_ok
 		fi
 
-		echo -n " - ack   "
+		print_check "ack"
 		count=$(get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
 		if [ -z "$count" ]; then
-			echo "[skip]"
+			print_skip
 		elif [ "$count" != "$mis_ack_nr" ]; then
-			echo "[fail] got $count JOIN[s] ack with a mismatched \
-				port-number expected $mis_ack_nr"
-			fail_test
+			fail_test "got $count JOIN[s] ack with a mismatched \
+				   port-number expected $mis_ack_nr"
 		else
-			echo "[ ok ]"
+			print_ok
 		fi
-	else
-		echo ""
 	fi
 }
 
@@ -1686,28 +1686,26 @@ chk_add_tx_nr()
 
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
-	printf "%-${nr_blank}s %s" " " "add TX"
+	print_check "add TX"
 	count=$(get_counter ${ns1} "MPTcpExtAddAddrTx")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
 	elif [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
-		echo "[fail] got $count ADD_ADDR[s] TX, expected $add_tx_nr"
-		fail_test
+		fail_test "got $count ADD_ADDR[s] TX, expected $add_tx_nr"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo -n " - echo TX "
+	print_check "echo TX"
 	count=$(get_counter ${ns2} "MPTcpExtEchoAddTx")
 	if [ -z "$count" ]; then
-		echo "[skip]"
+		print_skip
 	elif [ "$count" != "$echo_tx_nr" ]; then
-		echo "[fail] got $count ADD_ADDR echo[s] TX, expected $echo_tx_nr"
-		fail_test
+		fail_test "got $count ADD_ADDR echo[s] TX, expected $echo_tx_nr"
 	else
-		echo "[ ok ]"
+		print_ok
 	fi
 }
 
@@ -1735,24 +1733,23 @@ chk_rm_nr()
 	elif [ $invert = "true" ]; then
 		addr_ns=$ns2
 		subflow_ns=$ns1
-		extra_msg="   invert"
+		extra_msg="invert"
 	fi
 
-	printf "%-${nr_blank}s %s" " " "rm "
+	print_check "rm"
 	count=$(get_counter ${addr_ns} "MPTcpExtRmAddr")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif [ "$count" != "$rm_addr_nr" ]; then
-		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
-		fail_test
+		fail_test "got $count RM_ADDR[s] expected $rm_addr_nr"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo -n " - rmsf  "
+	print_check "rmsf"
 	count=$(get_counter ${subflow_ns} "MPTcpExtRmSubflow")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif [ -n "$simult" ]; then
 		local cnt suffix
 
@@ -1764,34 +1761,33 @@ chk_rm_nr()
 		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
-			echo -n "[ ok ] $suffix"
+			print_ok "$suffix"
 		else
-			echo "[fail] got $count RM_SUBFLOW[s] expected in range [$rm_subflow_nr:$((rm_subflow_nr*2))]"
-			fail_test
+			fail_test "got $count RM_SUBFLOW[s] expected in range [$rm_subflow_nr:$((rm_subflow_nr*2))]"
 		fi
 	elif [ "$count" != "$rm_subflow_nr" ]; then
-		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
-		fail_test
+		fail_test "got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo "$extra_msg"
+	if [ -n "$extra_msg" ]; then
+		print_info "$extra_msg"
+	fi
 }
 
 chk_rm_tx_nr()
 {
 	local rm_addr_tx_nr=$1
 
-	printf "%-${nr_blank}s %s" " " "rm TX "
+	print_check "rm TX"
 	count=$(get_counter ${ns2} "MPTcpExtRmAddrTx")
 	if [ -z "$count" ]; then
-		echo "[skip]"
+		print_skip
 	elif [ "$count" != "$rm_addr_tx_nr" ]; then
-		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_tx_nr"
-		fail_test
+		fail_test "got $count RM_ADDR[s] expected $rm_addr_tx_nr"
 	else
-		echo "[ ok ]"
+		print_ok
 	fi
 }
 
@@ -1801,52 +1797,44 @@ chk_prio_nr()
 	local mp_prio_nr_rx=$2
 	local count
 
-	printf "%-${nr_blank}s %s" " " "ptx"
+	print_check "ptx"
 	count=$(get_counter ${ns1} "MPTcpExtMPPrioTx")
 	if [ -z "$count" ]; then
-		echo -n "[skip]"
+		print_skip
 	elif [ "$count" != "$mp_prio_nr_tx" ]; then
-		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
-		fail_test
+		fail_test "got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
 	else
-		echo -n "[ ok ]"
+		print_ok
 	fi
 
-	echo -n " - prx   "
+	print_check "prx"
 	count=$(get_counter ${ns1} "MPTcpExtMPPrioRx")
 	if [ -z "$count" ]; then
-		echo "[skip]"
+		print_skip
 	elif [ "$count" != "$mp_prio_nr_rx" ]; then
-		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
-		fail_test
+		fail_test "got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
 	else
-		echo "[ ok ]"
+		print_ok
 	fi
 }
 
 chk_subflow_nr()
 {
-	local need_title="$1"
-	local msg="$2"
-	local subflow_nr=$3
+	local msg="$1"
+	local subflow_nr=$2
 	local cnt1
 	local cnt2
 	local dump_stats
 
-	if [ -n "${need_title}" ]; then
-		printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${msg}"
-	else
-		printf "%-${nr_blank}s %s" " " "${msg}"
-	fi
+	print_check "${msg}"
 
 	cnt1=$(ss -N $ns1 -tOni | grep -c token)
 	cnt2=$(ss -N $ns2 -tOni | grep -c token)
 	if [ "$cnt1" != "$subflow_nr" ] || [ "$cnt2" != "$subflow_nr" ]; then
-		echo "[fail] got $cnt1:$cnt2 subflows expected $subflow_nr"
-		fail_test
+		fail_test "got $cnt1:$cnt2 subflows expected $subflow_nr"
 		dump_stats=1
 	else
-		echo "[ ok ]"
+		print_ok
 	fi
 
 	if [ "${dump_stats}" = 1 ]; then
@@ -1866,7 +1854,7 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$exp1:$exp2"
+	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
 	       sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
@@ -1877,11 +1865,10 @@ chk_mptcp_info()
 	[ -z "$cnt2" ] && cnt2=0
 
 	if [ "$cnt1" != "$exp1" ] || [ "$cnt2" != "$exp2" ]; then
-		echo "[fail] got $cnt1:$cnt2 $info1:$info2 expected $exp1:$exp2"
-		fail_test
+		fail_test "got $cnt1:$cnt2 $info1:$info2 expected $exp1:$exp2"
 		dump_stats=1
 	else
-		echo "[ ok ]"
+		print_ok
 	fi
 
 	if [ "$dump_stats" = 1 ]; then
@@ -1903,13 +1890,12 @@ chk_link_usage()
 	local tx_rate=$((tx_link * 100 / tx_total))
 	local tolerance=5
 
-	printf "%-${nr_blank}s %-18s" " " "link usage"
+	print_check "link usage"
 	if [ $tx_rate -lt $((expected_rate - tolerance)) ] || \
 	   [ $tx_rate -gt $((expected_rate + tolerance)) ]; then
-		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
-		fail_test
+		fail_test "got $tx_rate% usage, expected $expected_rate%"
 	else
-		echo "[ ok ]"
+		print_ok
 	fi
 }
 
@@ -2807,15 +2793,15 @@ verify_listener_events()
 	if [ $e_type = $LISTENER_CREATED ]; then
 		name="LISTENER_CREATED"
 	elif [ $e_type = $LISTENER_CLOSED ]; then
-		name="LISTENER_CLOSED"
+		name="LISTENER_CLOSED "
 	else
 		name="$e_type"
 	fi
 
-	printf "%-${nr_blank}s %s %s:%s " " " "$name" "$e_saddr" "$e_sport"
+	print_check "$name $e_saddr:$e_sport"
 
 	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
-		printf "[skip]: event not supported\n"
+		print_skip "event not supported"
 		return
 	fi
 
@@ -2832,11 +2818,10 @@ verify_listener_events()
 	   [ $family ] && [ $family = $e_family ] &&
 	   [ $saddr ] && [ $saddr = $e_saddr ] &&
 	   [ $sport ] && [ $sport = $e_sport ]; then
-		echo "[ ok ]"
+		print_ok
 		return 0
 	fi
-	fail_test
-	echo "[fail]"
+	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
 }
 
 add_addr_ports_tests()
@@ -3438,17 +3423,17 @@ endpoint_tests()
 		run_tests $ns1 $ns2 10.0.1.1 slow 2>/dev/null &
 
 		wait_mpj $ns1
-		pm_nl_check_endpoint 1 "creation" \
+		pm_nl_check_endpoint "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows 1 subflows 1
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
-		pm_nl_check_endpoint 0 "ID change is prevented" \
+		pm_nl_check_endpoint "ID change is prevented" \
 			$ns2 10.0.2.2 id 1 flags implicit
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
-		pm_nl_check_endpoint 0 "modif is allowed" \
+		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
 		kill_tests_wait
 	fi
@@ -3462,17 +3447,17 @@ endpoint_tests()
 			run_tests $ns1 $ns2 10.0.1.1 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
-		chk_subflow_nr needtitle "before delete" 2
+		chk_subflow_nr "before delete" 2
 		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
-		chk_subflow_nr "" "after delete" 1
+		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add" 2
+		chk_subflow_nr "after re-add" 2
 		chk_mptcp_info subflows 1 subflows 1
 		kill_tests_wait
 	fi
-- 
2.40.1

