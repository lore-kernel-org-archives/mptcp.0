Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ACB2CA4
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 21:25:53 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id f17so6262514wrx.1
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 13:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIJdu6l+E6obtVQ54RlNg6Nuz6OubW8rzxhcYHfItvU=;
        b=KujLDdfKRkJqSwDEQsM0VkbXKizOUG6qNfJVIeOEpS0hZcmcO6hQIcUqfGj1SPAd6o
         Oq9tR6YfoL/o/59AdQJa0EyGDmM8IfFq5NEft6LPRkllRVUkEAdk7iw4TkdFT0FkVj9z
         14r4XgmGqaTomZqfSqOIOMLF2ufZFINBzRu9q0Zplf4amVB7PD5gDIqyEOzglkAPxOy/
         9yNmSB5oeoioKhGwU/7Z6Q94FcStk9B9agswtiAUPXPiIv9X8pdkJVUKULMkmb6kGzNe
         QN8L3vH4xPD2wTFu8+Mfsxb76MOhcz6v3xN7N3Xyr7GkUrpBcddVaYZQrKSa8ar3Qd10
         dcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIJdu6l+E6obtVQ54RlNg6Nuz6OubW8rzxhcYHfItvU=;
        b=VpdKAQoFF6tQ1TrBp2/Tf1rPG/gwZEhYUkC/ChSjI2vnu8QC/p6/AjOKIhIVt/4Mk/
         25EdObS2SESZAYlES4cwyke6314jDqZWhk2LSz6P5w/YaQR5g/hJqiWyDp2Uo2isG2nB
         Hn6vflRJ+/tt0zA97f1fpcDIRQ0g/l6VPNrdKUuoBjpFIo3tnubc1KrRr8vBwRL/oYV8
         tSj48wHnuxaMndeKlKfgUW0z/2FL4/Psne5Qef7J6s3fzMOYcvYC/D/5giAbfifJZHm8
         0XbgMrNv8tN3ukFVjQG4LWutmtAZG46+9B9k9fBmL30H/2LcGJyAYuudIqE07xJvJUoD
         pg3Q==
X-Gm-Message-State: AOAM532CTFJJwM2HBaWNlRtOEh3v/d8OJ7L9HwgBmmorXlHCTQYJIAYh
	QDPUV6CuDnCXJxZOFWv019HKxITMecxtzyjV
X-Google-Smtp-Source: ABdhPJwVOvC/V09imaefT+47w90uP0MIcnP8xEbidLI4dt3o2TmPrIgfadttw7CafpqhsfMnjOAkCQ==
X-Received: by 2002:a5d:43c6:: with SMTP id v6mr3840287wrr.530.1644441951241;
        Wed, 09 Feb 2022 13:25:51 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p14sm18500730wrr.7.2022.02.09.13.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:25:50 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 9/9] selftests: mptcp: join: make it shellcheck compliant
Date: Wed,  9 Feb 2022 22:25:20 +0100
Message-Id: <20220209212520.2989291-10-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
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

While at it, also fixed two small comments: alignment and missing arg.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 107 +++++++++---------
 1 file changed, 56 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c39d5b4e73cb..368819213205 100755
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
 RET=0
 SIN=""
 SINFAIL=""
@@ -68,7 +73,7 @@ init_partial()
 
 	CHECK_INVERT=0
 
-	#  ns1              ns2
+	#  ns1         ns2
 	# ns1eth1    ns2eth1
 	# ns1eth2    ns2eth2
 	# ns1eth3    ns2eth3
@@ -252,11 +257,10 @@ check_transfer()
 	local in=$1
 	local out=$2
 	local what=$3
+	local i a b
 
-	cmp -l "$in" "$out" | while read line; do
-		local arr=($line)
-
-		let sum=0${arr[1]}+0${arr[2]}
+	cmp -l "$in" "$out" | while read -r i a b; do
+		sum=$((0${a} + 0${b}))
 		if [ $CHECK_INVERT -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			echo "[ FAIL ] $what does not match (in, out):"
 			print_file_err "$in"
@@ -265,7 +269,7 @@ check_transfer()
 
 			return 1
 		else
-			echo "$what has inverted byte at ${arr[0]}"
+			echo "$what has inverted byte at ${i}"
 		fi
 	done
 
@@ -278,8 +282,7 @@ do_ping()
 	local connector_ns="$2"
 	local connect_addr="$3"
 
-	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
-	if [ $? -ne 0 ] ; then
+	if ! ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null; then
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
 		RET=1
 	fi
@@ -370,26 +373,26 @@ pm_nl_add_endpoint()
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
 
 	if [ $IP_MPTCP -eq 1 ]; then
@@ -536,12 +539,13 @@ do_transfer()
 
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
@@ -550,20 +554,20 @@ do_transfer()
 				addr="10.0.$counter.1"
 			fi
 			pm_nl_add_endpoint $NS1 $addr flags signal
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
-			pm_nl_show_endpoints ${listener_ns} | while read line; do
+			pm_nl_show_endpoints ${listener_ns} | while read -r line; do
+				# shellcheck disable=SC2206
 				local arr=($line)
 				local nr=0
 
 				local i
-				for i in ${arr[@]}; do
+				for i in "${arr[@]}"; do
 					if [ $i = "id" ]; then
 						if [ $counter -eq $rm_nr_ns1 ]; then
 							break
@@ -572,9 +576,9 @@ do_transfer()
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
@@ -592,11 +596,10 @@ do_transfer()
 
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
@@ -606,19 +609,20 @@ do_transfer()
 				addr="10.0.$counter.2"
 			fi
 			pm_nl_add_endpoint $NS2 $addr flags $flags
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
-			pm_nl_show_endpoints ${connector_ns} | while read line; do
+			pm_nl_show_endpoints ${connector_ns} | while read -r line; do
+				# shellcheck disable=SC2206
 				local arr=($line)
 				local nr=0
 				local i
 
-				for i in ${arr[@]}; do
+				for i in "${arr[@]}"; do
 					if [ $i = "id" ]; then
 						if [ $counter -eq $rm_nr_ns2 ]; then
 							break
@@ -630,9 +634,9 @@ do_transfer()
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
@@ -648,19 +652,20 @@ do_transfer()
 		fi
 	fi
 
-	if [ ! -z $sflags ]; then
+	if [ -n "${sflags}" ]; then
 		sleep 1
 		for netns in "$NS1" "$NS2"; do
-			pm_nl_show_endpoints $netns | while read line; do
+			pm_nl_show_endpoints $netns | while read -r line; do
+				# shellcheck disable=SC2206
 				local arr=($line)
 				local nr=0
 				local id
 
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
@@ -745,20 +750,20 @@ run_tests()
 
 	# create the input file for the failure test when
 	# the first failure test run
-	if [ "$test_linkfail" -ne 0 -a -z "$CINFAIL" ]; then
+	if [ "$test_linkfail" -ne 0 ] && [ -z "$CINFAIL" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
 		size=$((RANDOM%2))
 		size=$((size+1))
 		size=$((size*8192))
-		size=$((size + ( $RANDOM % 8192) ))
+		size=$((size + ( RANDOM % 8192) ))
 
 		CINFAIL=$(mktemp)
 		make_file "$CINFAIL" "client" $size
 	fi
 
-	if [ "$test_linkfail" -eq 2 -a -z "$SINFAIL" ]; then
+	if [ "$test_linkfail" -eq 2 ] && [ -z "$SINFAIL" ]; then
 		size=$((RANDOM%16))
 		size=$((size+1))
 		size=$((size*2048))
@@ -785,7 +790,7 @@ chk_csum_nr()
 	local count
 	local dump_stats
 
-	if [ ! -z "$msg" ]; then
+	if [ -n "$msg" ]; then
 		printf "%03u" "$TEST_COUNT"
 	else
 		echo -n "   "
@@ -948,8 +953,8 @@ chk_stale_nr()
 	[ -z "$recover_nr" ] && recover_nr=0
 
 	if [ $stale_nr -lt $stale_min ] ||
-	   [ $stale_max -gt 0 -a $stale_nr -gt $stale_max ] ||
-	   [ $((stale_nr - $recover_nr)) -ne $stale_delta ]; then
+	   { [ $stale_max -gt 0 ] && [ $stale_nr -gt $stale_max ]; } ||
+	   [ $((stale_nr - recover_nr)) -ne $stale_delta ]; then
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta "
@@ -988,7 +993,7 @@ chk_add_nr()
 
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
-	if [ "$count" != "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" -lt "$add_nr" ]; then
+	if [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		RET=1
 		dump_stats=1
@@ -1174,13 +1179,13 @@ chk_link_usage()
 
 	local tx_link tx_total
 	tx_link=$(ip netns exec $ns cat /sys/class/net/$link/statistics/tx_bytes)
-	tx_total=$(ls -l $out | awk '{print $5}')
-	local tx_rate=$((tx_link * 100 / $tx_total))
+	tx_total=$(stat --format=%s $out)
+	local tx_rate=$((tx_link * 100 / tx_total))
 	local tolerance=5
 
 	printf "%-${NR_BLANK}s %-18s" " " "link usage"
-	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
-	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
+	if [ $tx_rate -lt $((expected_rate - tolerance)) ] || \
+	   [ $tx_rate -gt $((expected_rate + tolerance)) ]; then
 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
 		RET=1
 	else
@@ -2388,7 +2393,7 @@ usage()
 }
 
 for arg in "$@"; do
-	# check for "capture/checksum" args before launching tests
+	# check for "capture/checksum/ip_mptcp" args before launching tests
 	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"c"[0-9a-zA-Z]*$ ]]; then
 		CAPTURE=1
 	fi
-- 
2.34.1

