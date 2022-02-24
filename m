Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBA6957
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 21:35:07 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id cm8so4753002edb.3
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nUxcc2eH2FOiBwRi+KL6iAhjA9g1CqhP8UubWldtUMo=;
        b=4ZI+PEw6IbnH03NyNXzj92i2o+7HAl7PdgSRLE7XFcs3PQm5b8SAJKq5mDX6uvLMxV
         XobzRgplChjiaGThU2Yqs9/PRoXfa6F2BjTqvS4zor6rK0Ow3qn2mthTxEo8sCQr4GOw
         PAonuuOuIrkU1oAS5j9FyTsy+/DqdRy+WsnYrvC4r19sPDsCafXYqFyi3uZ0mSccgluq
         CRJs4G9MT0VuKP65UQzSj9gQ+M2+ZmcTxd2KHOIZ8j6s/7PNF6sTNbeJjqAIDpBeozzy
         J507ip5LJxpk4Ka103EhPK+VYOPX8dShKNDjb8czQyAfSPEvv5FbxFiWMN+5/Y9EQ6nz
         +q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nUxcc2eH2FOiBwRi+KL6iAhjA9g1CqhP8UubWldtUMo=;
        b=o4ucJJ6+jOXGHrKoyB2t8wRuUiF6HsIydDcBebAulFqSIqr+RR/sXQdkkhkNEdxC4x
         uy5GK0Bov3WijWvNHLIDJZdlYR9l7z8HR5869aHrKQ1tL7ffC6/WaCZaUUCUGT5Y03co
         RmzW0n5pJdjfh6SFJP+FsUg46zwTE4Xy36VyzqzhVu8lEAdBvH1UEfnuowpd/KyEoAzh
         2CjCs7lUSQkshFboeIrPTAQSMEYJlOtBecPml8ayi40pc3rmYKn1w/l1jWReA2Jgcvd5
         uIqwZJ4DvCqekCnsuysNuoO7KRR6aItAFd6tuSS7LoA9RSxu+ZWXnsssZxl7OdUF2ECr
         Somw==
X-Gm-Message-State: AOAM533hKNH2DlwqLjj9lETHLsE3Bu4VUaI1meK88I3t7crZQ7zx7nAY
	s/EiCPN239+u3AIXuCJ8KLrDqn7r59mYy7jx5HI=
X-Google-Smtp-Source: ABdhPJzJVuqgD3dbeZpCVF1V61ys14AnFyEjRGBtk21CfaiAr46KZVZpzQc5Z2P8daVVbIMNtk9KtQ==
X-Received: by 2002:aa7:d3d9:0:b0:410:7a81:c0cf with SMTP id o25-20020aa7d3d9000000b004107a81c0cfmr4217946edr.177.1645738505966;
        Thu, 24 Feb 2022 13:35:05 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm175195ejp.223.2022.02.24.13.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:35:05 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v4 12/12] selftests: mptcp: join: make it shellcheck compliant
Date: Thu, 24 Feb 2022 22:34:06 +0100
Message-Id: <20220224213406.3127061-13-matthieu.baerts@tessares.net>
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
index 9ff5de1098d6..ceca16541d0a 100755
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
@@ -576,18 +579,18 @@ pm_nl_check_endpoint()
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
 
@@ -726,7 +729,7 @@ do_transfer()
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$extra_args $connect_addr > "$cout" &
 	else
-		cat "$cinfail" | tee "$cinsent" | \
+		tee "$cinsent" < "$cinfail" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
@@ -736,12 +739,13 @@ do_transfer()
 
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
@@ -750,21 +754,21 @@ do_transfer()
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
@@ -773,9 +777,9 @@ do_transfer()
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
@@ -793,11 +797,10 @@ do_transfer()
 
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
@@ -807,20 +810,21 @@ do_transfer()
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
@@ -832,9 +836,9 @@ do_transfer()
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
@@ -850,23 +854,24 @@ do_transfer()
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
@@ -960,14 +965,14 @@ run_tests()
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
@@ -980,7 +985,7 @@ run_tests()
 			sinfail=$(mktemp)
 		fi
 		make_file "$sinfail" "server" $size
-	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	elif [ "$test_linkfail" -eq 2 ] && [ -z "$sinfail" ]; then
 		size=$((RANDOM%16))
 		size=$((size+1))
 		size=$((size*2048))
@@ -1029,8 +1034,8 @@ chk_csum_nr()
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
@@ -1040,8 +1045,8 @@ chk_csum_nr()
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
@@ -1282,8 +1287,8 @@ chk_stale_nr()
 	[ -z "$recover_nr" ] && recover_nr=0
 
 	if [ $stale_nr -lt $stale_min ] ||
-	   [ $stale_max -gt 0 -a $stale_nr -gt $stale_max ] ||
-	   [ $((stale_nr - $recover_nr)) -ne $stale_delta ]; then
+	   { [ $stale_max -gt 0 ] && [ $stale_nr -gt $stale_max ]; } ||
+	   [ $((stale_nr - recover_nr)) -ne $stale_delta ]; then
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta "
@@ -1322,7 +1327,7 @@ chk_add_nr()
 
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
-	if [ "$count" != "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" -lt "$add_nr" ]; then
+	if [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		fail_test
 		dump_stats=1
@@ -1467,8 +1472,9 @@ chk_rm_nr()
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
@@ -1539,13 +1545,13 @@ chk_link_usage()
 
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

