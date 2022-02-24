Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F61B66
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:56:54 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id p15so4515830ejc.7
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Troist0GsBmag+oUeXIaegiAu+MCDGFZWMEmGOBlLGM=;
        b=UItuwdSxPCkwT8AKL5ramMVROUHdF8sH+h8sV9GqFyEWSUPMROQVanbbhxqGw1X4IY
         Xu4ohfjwMgrpuKsfUAXHW+gIz1HzaqDKnx3UGS67VeuNhUU6gfULpaXdeY14gIc63QsD
         5KYDtipqax6Sp21zexhdiP6CKMzU1QgJn/9YvGqYvzPnxnrxHwiao2vKg3jxsf4syvMY
         CrDL/i8a/co6FycoiC0lLRHJaw1n923qdw4xb2tQ94Eo2ts3y4ECQKAxhMsFnt7hvAnu
         Wf4SxBTBUZL3zCqZDkFXolNZhXjbnw0KsVVVXz0dy4BivqLSPUd8YPwnPmbbq7IUIw1G
         jKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Troist0GsBmag+oUeXIaegiAu+MCDGFZWMEmGOBlLGM=;
        b=FBplqdjcb0XWde7vwBRIs90+wu1UAqlFJHytGGYJYaD3vp0Pgzo9jZ7gnaZnl5CIir
         lhEv1Wv6/7vAMBt4/4e83SGIvwPICr2sIIIGiIzEw0GfV6xQNxkSUR7hykt3nkXKbgML
         A+CJbNtLzoudLSHnI7iwUMlY5owqNbgm/pMtxSkPd1gqcZvJHUda4UHvevdLfbavuJOK
         Pay++io1hZT58sYdvakePA6aaW1OWAafYCJigvqaLVZb6BfS//OvyIN2Bn34/Avmv2vK
         4mvV2RAZ2oKuvSTWu+DLK0pvzCXMXKYM/93Z+0H8z9SXbSQ/9ysvRna61vfXxgQj9xI7
         GZHg==
X-Gm-Message-State: AOAM53194TXiUKz7OnKOY/d1GF64sWOqF0CX4ZCKa9wRutkgRQ/W/GMj
	oQSoZQXREbMHWFV2GmgC2hgcnQWgbforVdx4dkI=
X-Google-Smtp-Source: ABdhPJzIxovi6Sd7pLlPokcc9GPAn7SwH+SSTIFk6IS7HRx19cOlGPV0Aike1I2NlMUf2ccGmzxCXw==
X-Received: by 2002:a17:906:fb8a:b0:6ce:c3e6:2ac4 with SMTP id lr10-20020a170906fb8a00b006cec3e62ac4mr2325873ejb.40.1645711012519;
        Thu, 24 Feb 2022 05:56:52 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm1360733edw.37.2022.02.24.05.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:51 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v3 11/12] selftests: mptcp: join: make it shellcheck compliant
Date: Thu, 24 Feb 2022 14:56:18 +0100
Message-Id: <20220224135619.2523272-12-matthieu.baerts@tessares.net>
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
- SC2002: Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..'
          instead.

SC2086 (Double quotes to prevent globbing and word splitting) is ignored
because it is controlled for the moment and there are too many to
change.

While at it, also fixed the alignment in one comment.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 126 +++++++++---------
 1 file changed, 66 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f61c3804f5e0..20ec31b05990 100755
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
@@ -77,7 +82,7 @@ init_partial()
 	validate_checksum=$checksum
 	FAILING_LINKS=""
 
-	#  ns1              ns2
+	#  ns1         ns2
 	# ns1eth1    ns2eth1
 	# ns1eth2    ns2eth2
 	# ns1eth3    ns2eth3
@@ -339,12 +344,11 @@ check_transfer()
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
@@ -353,7 +357,7 @@ check_transfer()
 
 			return 1
 		else
-			echo "$what has inverted byte at ${arr[0]}"
+			echo "$what has inverted byte at ${i}"
 		fi
 	done
 
@@ -366,8 +370,7 @@ do_ping()
 	local connector_ns="$2"
 	local connect_addr="$3"
 
-	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
-	if [ $? -ne 0 ] ; then
+	if ! ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
 		fail_test
 	fi
@@ -474,26 +477,26 @@ pm_nl_add_endpoint()
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
@@ -572,18 +575,18 @@ pm_nl_check_endpoint()
 	while [ -n "$1" ]; do
 		if [ $1 = "flags" ]; then
 			_flags=$2
-			[ ! -z $_flags ]; flags="flags $_flags"
+			[ -n "$_flags" ]; flags="flags $_flags"
 			shift
 		elif [ $1 = "dev" ]; then
-			[ ! -z $2 ]; dev="dev $1"
+			[ -n "$2" ]; dev="dev $1"
 			shift
 		elif [ $1 = "id" ]; then
 			_id=$2
-			[ ! -z $_id ]; id="id $_id"
+			[ -n "$_id" ]; id="id $_id"
 			shift
 		elif [ $1 = "port" ]; then
 			_port=$2
-			[ ! -z $_port ]; port=" port $_port"
+			[ -n "$_port" ]; port=" port $_port"
 			shift
 		fi
 
@@ -713,7 +716,7 @@ do_transfer()
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$extra_args $connect_addr > "$cout" &
 	else
-		cat "$cinfail" | tee "$cinsent" | \
+		tee "$cinsent"< "$cinfail" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
@@ -723,12 +726,13 @@ do_transfer()
 
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
@@ -737,21 +741,21 @@ do_transfer()
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
@@ -760,9 +764,9 @@ do_transfer()
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
@@ -780,11 +784,10 @@ do_transfer()
 
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
@@ -794,20 +797,21 @@ do_transfer()
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
@@ -819,9 +823,9 @@ do_transfer()
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
@@ -837,23 +841,24 @@ do_transfer()
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
@@ -947,14 +952,14 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	# create the input file for the failure test when
 	# the first failure test run
-	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	elif [ "$test_linkfail" -ne 0 ] && [ -z "$cinfail" ]; then
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
@@ -967,7 +972,7 @@ run_tests()
 			sinfail=$(mktemp)
 		fi
 		make_file "$sinfail" "server" $size
-	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	elif [ "$test_linkfail" -eq 2 ] && [ -z "$sinfail" ]; then
 		size=$((RANDOM%16))
 		size=$((size+1))
 		size=$((size*2048))
@@ -1016,8 +1021,8 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
-	if [ "$count" != $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
-	   [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; then
+	if { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
+	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		fail_test
 		dump_stats=1
@@ -1027,8 +1032,8 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
-	if [ "$count" != $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] ||
-	   [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; then
+	if { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
+	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		fail_test
 		dump_stats=1
@@ -1269,8 +1274,8 @@ chk_stale_nr()
 	[ -z "$recover_nr" ] && recover_nr=0
 
 	if [ $stale_nr -lt $stale_min ] ||
-	   [ $stale_max -gt 0 -a $stale_nr -gt $stale_max ] ||
-	   [ $((stale_nr - $recover_nr)) -ne $stale_delta ]; then
+	   { [ $stale_max -gt 0 ] && [ $stale_nr -gt $stale_max ]; } ||
+	   [ $((stale_nr - recover_nr)) -ne $stale_delta ]; then
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta "
@@ -1309,7 +1314,7 @@ chk_add_nr()
 
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
-	if [ "$count" != "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" -lt "$add_nr" ]; then
+	if [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		fail_test
 		dump_stats=1
@@ -1454,8 +1459,9 @@ chk_rm_nr()
 	count=$(ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ -n "$simult" ]; then
-		local cnt=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
-		local suffix
+		local cnt suffix
+
+		cnt=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
 
 		# in case of simult flush, the subflow removal count on each side is
 		# unreliable
@@ -1526,13 +1532,13 @@ chk_link_usage()
 
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

