Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF43B28
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 17:43:55 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so4582384wmq.3
        for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 09:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oldb9DIPIrRQja9ktsBFrWGNXaoqTBE4nbRwLMFvMFQ=;
        b=u6+Wn+C1GaB+6vbfGauxLN0be5SMg/XV8zYgcWPk7koeRM2+fF5tpr4/uUIAhUggTU
         8CtuUe3RfremhSP4kTSBH9WNntRgUjDIaAb42YDDtYuhJiuTMYrjfjQ7DOUUgTUUowY/
         4s1qaYEsXxv8cfLNGXD+eDiuySa9geESfuBdXI4FwL5etDMMTR5qJ3y1IRl5vo83rBQo
         wMpzVArCA73LcMtI5pu/K7ytc+9lsDhHmvvZMcBZJqrvJQoss+lzJ5CQ0JVDlLJSebjW
         8Gas8GhPyT33F5BACEGQqHGEtldZmZXH0xL1L8/eo1OQC6fnitPviolqohaXQeqlchjh
         okKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oldb9DIPIrRQja9ktsBFrWGNXaoqTBE4nbRwLMFvMFQ=;
        b=DmRdpCmmhRZ0vz2bGXEwqQQ1e6HWIHuYQklikyinMJMLFoF99x++1wLWk/4SEf6hRn
         E8tCiYvqdlxjfkXqVubeLgmGSAvtSu7QTiO7n8DDY8Q2sR4KyY+LVqd/hOfR/EoMhTY+
         9glUmYCgExWHiW1agenwgeaRKBuSKDk/HRjj44aLh5/N7IpT1t3eqZ/813V9hxSv5fWN
         Ru2zdZysnojNikFclIYzegkJrIKH39Ez5bFLp3khh2NE6C9Q1UbCuU9M3AriDecmNqgV
         v79JsWn3ceCbJBU6Agq6wD6VmJwZ60iyX6Rzvja/nBUD4DZiJ7IWCdhy2KAjYJmVWpxv
         O/Cw==
X-Gm-Message-State: AOAM5332NKw2j6O59VKSvRr7RcnoCUwrHVnJEExdyPuXRiR5xb+RlZKn
	M7wFpGV223dlFeZzN825rDuoNcAGqJFRdhBu
X-Google-Smtp-Source: ABdhPJxJAJDawdpoIjs2vtl/uC/hxlHBqbe2P4pQRqsXqQNW+zlz5RP+BzjPAKRLqux6aVVBy99kOA==
X-Received: by 2002:a05:600c:1c9a:b0:37b:c3ec:e41a with SMTP id k26-20020a05600c1c9a00b0037bc3ece41amr3745003wms.162.1645119833373;
        Thu, 17 Feb 2022 09:43:53 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm23060203wrb.43.2022.02.17.09.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:43:52 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 9/9] selftests: mptcp: join: make it shellcheck compliant
Date: Thu, 17 Feb 2022 18:43:29 +0100
Message-Id: <20220217174329.826430-10-matthieu.baerts@tessares.net>
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

This fixes a few issues reported by ShellCheck:

- SC2068: Double quote array expansions to avoid re-splitting elements.
- SC2206: Quote to prevent word splitting/globbing, or split robustly
          with mapfile or read -a.
- SC2166: Prefer [ p ] && [ q ] as [ p -a q ] is not well defined.
- SC2155: Declare and assign separately to avoid masking return values.
- SC2162: read without -r will mangle backslashes.
- SC2219: Instead of 'let expr', prefer (( expr )) .
- SC2181: Check exit code directly with e.g. 'if mycmd;', not indirectly
          with $?.
- SC2236: Use -n instead of ! -z.
- SC2004: $/${} is unnecessary on arithmetic variables.
- SC2012: Use find instead of ls to better handle non-alphanumeric
          filenames.

SC2086 (Double quotes to prevent globbing and word splitting) is ignored
because it is controlled for the moment and there are too many to
change.

While at it, also fixed the alignment in one comment.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 104 +++++++++---------
 1 file changed, 55 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 78d8bc1beb25..5ef06a2542f4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1,6 +1,11 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 ret=0
 sin=""
 sinfail=""
@@ -76,7 +81,7 @@ init_partial()
 	check_invert=0
 	FAILING_LINKS=""
 
-	#  ns1              ns2
+	#  ns1         ns2
 	# ns1eth1    ns2eth1
 	# ns1eth2    ns2eth2
 	# ns1eth3    ns2eth3
@@ -286,12 +291,11 @@ check_transfer()
 	local in=$1
 	local out=$2
 	local what=$3
+	local i a b
 
 	local line
-	cmp -l "$in" "$out" | while read line; do
-		local arr=($line)
-
-		let sum=0${arr[1]}+0${arr[2]}
+	cmp -l "$in" "$out" | while read -r i a b; do
+		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			echo "[ FAIL ] $what does not match (in, out):"
 			print_file_err "$in"
@@ -300,7 +304,7 @@ check_transfer()
 
 			return 1
 		else
-			echo "$what has inverted byte at ${arr[0]}"
+			echo "$what has inverted byte at ${i}"
 		fi
 	done
 
@@ -313,8 +317,7 @@ do_ping()
 	local connector_ns="$2"
 	local connect_addr="$3"
 
-	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
-	if [ $? -ne 0 ] ; then
+	if ! ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
 		fail_test
 	fi
@@ -406,26 +409,26 @@ pm_nl_add_endpoint()
 	local nr=2
 
 	local p
-	for p in $@
+	for p in "${@}"
 	do
 		if [ $p = "flags" ]; then
 			eval _flags=\$"$nr"
-			[ ! -z $_flags ]; flags="flags $_flags"
+			[ -n "$_flags" ]; flags="flags $_flags"
 		fi
 		if [ $p = "dev" ]; then
 			eval _dev=\$"$nr"
-			[ ! -z $_dev ]; dev="dev $_dev"
+			[ -n "$_dev" ]; dev="dev $_dev"
 		fi
 		if [ $p = "id" ]; then
 			eval _id=\$"$nr"
-			[ ! -z $_id ]; id="id $_id"
+			[ -n "$_id" ]; id="id $_id"
 		fi
 		if [ $p = "port" ]; then
 			eval _port=\$"$nr"
-			[ ! -z $_port ]; port="port $_port"
+			[ -n "$_port" ]; port="port $_port"
 		fi
 
-		let nr+=1
+		nr=$((nr + 1))
 	done
 
 	if [ $ip_mptcp -eq 1 ]; then
@@ -572,12 +575,13 @@ do_transfer()
 
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
-	[ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 1
+	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
+		sleep 1
+	fi
 
 	if [ $addr_nr_ns1 -gt 0 ]; then
 		local counter=2
-		local add_nr_ns1
-		let add_nr_ns1=addr_nr_ns1
+		local add_nr_ns1=${addr_nr_ns1}
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -586,21 +590,21 @@ do_transfer()
 				addr="10.0.$counter.1"
 			fi
 			pm_nl_add_endpoint $ns1 $addr flags signal
-			let counter+=1
-			let add_nr_ns1-=1
+			counter=$((counter + 1))
+			add_nr_ns1=$((add_nr_ns1 - 1))
 		done
 	elif [ $addr_nr_ns1 -lt 0 ]; then
-		local rm_nr_ns1
-		let rm_nr_ns1=-addr_nr_ns1
+		local rm_nr_ns1=$((-addr_nr_ns1))
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			local counter=0
 			local line
-			pm_nl_show_endpoints ${listener_ns} | while read line; do
+			pm_nl_show_endpoints ${listener_ns} | while read -r line; do
+				# shellcheck disable=SC2206 # we do want to split per word
 				local arr=($line)
 				local nr=0
 
 				local i
-				for i in ${arr[@]}; do
+				for i in "${arr[@]}"; do
 					if [ $i = "id" ]; then
 						if [ $counter -eq $rm_nr_ns1 ]; then
 							break
@@ -609,9 +613,9 @@ do_transfer()
 						rm_addr=$(rm_addr_count ${connector_ns})
 						pm_nl_del_endpoint ${listener_ns} $id
 						wait_rm_addr ${connector_ns} ${rm_addr}
-						let counter+=1
+						counter=$((counter + 1))
 					fi
-					let nr+=1
+					nr=$((nr + 1))
 				done
 			done
 		elif [ $rm_nr_ns1 -eq 8 ]; then
@@ -629,11 +633,10 @@ do_transfer()
 
 	# if newly added endpoints must be deleted, give the background msk
 	# some time to created them
-	[ $addr_nr_ns1 -gt 0 -a $addr_nr_ns2 -lt 0 ] && sleep 1
+	[ $addr_nr_ns1 -gt 0 ] && [ $addr_nr_ns2 -lt 0 ] && sleep 1
 
 	if [ $addr_nr_ns2 -gt 0 ]; then
-		local add_nr_ns2
-		let add_nr_ns2=addr_nr_ns2
+		local add_nr_ns2=${addr_nr_ns2}
 		local counter=3
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
@@ -643,20 +646,21 @@ do_transfer()
 				addr="10.0.$counter.2"
 			fi
 			pm_nl_add_endpoint $ns2 $addr flags $flags
-			let counter+=1
-			let add_nr_ns2-=1
+			counter=$((counter + 1))
+			add_nr_ns2=$((add_nr_ns2 - 1))
 		done
 	elif [ $addr_nr_ns2 -lt 0 ]; then
-		local rm_nr_ns2
+		local rm_nr_ns2=$((-addr_nr_ns2))
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			local counter=0
 			local line
-			pm_nl_show_endpoints ${connector_ns} | while read line; do
+			pm_nl_show_endpoints ${connector_ns} | while read -r line; do
+				# shellcheck disable=SC2206 # we do want to split per word
 				local arr=($line)
 				local nr=0
 
 				local i
-				for i in ${arr[@]}; do
+				for i in "${arr[@]}"; do
 					if [ $i = "id" ]; then
 						if [ $counter -eq $rm_nr_ns2 ]; then
 							break
@@ -668,9 +672,9 @@ do_transfer()
 						rm_addr=$(rm_addr_count ${listener_ns})
 						pm_nl_del_endpoint ${connector_ns} $id
 						wait_rm_addr ${listener_ns} ${rm_addr}
-						let counter+=1
+						counter=$((counter + 1))
 					fi
-					let nr+=1
+					nr=$((nr + 1))
 				done
 			done
 		elif [ $rm_nr_ns2 -eq 8 ]; then
@@ -686,23 +690,25 @@ do_transfer()
 		fi
 	fi
 
-	if [ ! -z $sflags ]; then
+	if [ -n "${sflags}" ]; then
 		sleep 1
 
 		local netns
 		for netns in "$ns1" "$ns2"; do
 			local line
-			pm_nl_show_endpoints $netns | while read line; do
+			pm_nl_show_endpoints $netns | while read -r line; do
+				# shellcheck disable=SC2206 # we do want to split per word
 				local arr=($line)
 				local nr=0
 				local id
+				local i
 
 				local i
-				for i in ${arr[@]}; do
+				for i in "${arr[@]}"; do
 					if [ $i = "id" ]; then
 						id=${arr[$nr+1]}
 					fi
-					let nr+=1
+					nr=$((nr + 1))
 				done
 				pm_nl_change_endpoint $netns $id $sflags
 			done
@@ -787,20 +793,20 @@ run_tests()
 
 	# create the input file for the failure test when
 	# the first failure test run
-	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	if [ "$test_linkfail" -ne 0 ] && [ -z "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
 		size=$((RANDOM%2))
 		size=$((size+1))
 		size=$((size*8192))
-		size=$((size + ( $RANDOM % 8192) ))
+		size=$((size + ( RANDOM % 8192) ))
 
 		cinfail=$(mktemp)
 		make_file "$cinfail" "client" $size
 	fi
 
-	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	if [ "$test_linkfail" -eq 2 ] && [ -z "$sinfail" ]; then
 		size=$((RANDOM%16))
 		size=$((size+1))
 		size=$((size*2048))
@@ -999,8 +1005,8 @@ chk_stale_nr()
 	[ -z "$recover_nr" ] && recover_nr=0
 
 	if [ $stale_nr -lt $stale_min ] ||
-	   [ $stale_max -gt 0 -a $stale_nr -gt $stale_max ] ||
-	   [ $((stale_nr - $recover_nr)) -ne $stale_delta ]; then
+	   { [ $stale_max -gt 0 ] && [ $stale_nr -gt $stale_max ]; } ||
+	   [ $((stale_nr - recover_nr)) -ne $stale_delta ]; then
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta "
@@ -1039,7 +1045,7 @@ chk_add_nr()
 
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
-	if [ "$count" != "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" -lt "$add_nr" ]; then
+	if [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		fail_test
 		dump_stats=1
@@ -1225,13 +1231,13 @@ chk_link_usage()
 
 	local tx_link tx_total
 	tx_link=$(ip netns exec $ns cat /sys/class/net/$link/statistics/tx_bytes)
-	tx_total=$(ls -l $out | awk '{print $5}')
-	local tx_rate=$((tx_link * 100 / $tx_total))
+	tx_total=$(stat --format=%s $out)
+	local tx_rate=$((tx_link * 100 / tx_total))
 	local tolerance=5
 
 	printf "%-${nr_blank}s %-18s" " " "link usage"
-	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
-	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
+	if [ $tx_rate -lt $((expected_rate - tolerance)) ] || \
+	   [ $tx_rate -gt $((expected_rate + tolerance)) ]; then
 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
 		fail_test
 	else
-- 
2.34.1

