Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8775B3B29
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 17:43:53 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id i14so10316307wrc.10
        for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1dqk/t6utgDLjQJjPX8YYDBHIxrtBtq4d+cdpBzacDw=;
        b=tr6jyj6+aGTXiK5Pe8BBZ9zFCCjKOAvfSGJvogwjmtMvC/xrPj/qln9+1be2W9vuJm
         T1WMMgMZMaFbcjRHPXVu4/UJLyumrJ6c/Zt/7MGbnxaynmeO/r+643aWvXMdmgFf0500
         P7bA0FEunzTwSzDGaE4hiwIEnuJDOCEC4zu6sA7bT+JsJp/pFNKIS65NVGIjyjSyzxQI
         4l3riy/DdJHkvN4vWY00KiRKZD3W0DDZqa0Zk8+edFxO2GTLT2djLAHyx71Cst4gmJqY
         qAVYeVfkf0p65UBB3zYCPy1r+PA19KYoKOS9JR/DN9u6fA+w6Sc9cp/zszLKCmlpwXjT
         dN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dqk/t6utgDLjQJjPX8YYDBHIxrtBtq4d+cdpBzacDw=;
        b=uU0mJAsPAY1tgqFWHtlVaMZWCtClOSObQVZli7zG+H31asHsAEFkYuBPq29YeA8hsp
         WDg28xfXqRKxZR8dFAlA0ls9PVtME811+KBGlk8w4u+CFqIFBBf0AeBe0onif6g6Vs+Q
         f2Gs/rp7bhF64tEfW8zjseoWqx3ghd4bbfGJa4axOkZ1AcSk6K5fYON3uM3W59i2CoHR
         +53u4VG+ateowMXc7+e+x22ptM4vy18U5QR42RUvouLnXxPctamP0/+eD0x6juvcArY2
         OcXm/mllSTd+i8sycA39g5DfZHg935KJdvVoq7KKpGMzTic7vaU7Cs4v1Y32Z64kZtly
         B9Cw==
X-Gm-Message-State: AOAM530GNAUjbSZYWZ4uHzWr8qxg/bo6pRbU3VCLVXsGA1zVCsDu2OGS
	2AE6m8bVYNo2AFRfLkVvsod7rEWLM0dU5E4N
X-Google-Smtp-Source: ABdhPJxhv0hFt+Hr6RmiNvSsIT1a8OZd9EhjSqeaRTST85vh9rvQLJyOeQL7e31opX0yQMQGNEm2pQ==
X-Received: by 2002:a5d:46d2:0:b0:1e4:b261:7e49 with SMTP id g18-20020a5d46d2000000b001e4b2617e49mr3140785wrs.669.1645119831641;
        Thu, 17 Feb 2022 09:43:51 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm23060203wrb.43.2022.02.17.09.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:43:51 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 7/9] selftests: mptcp: join: clarify local/global vars
Date: Thu, 17 Feb 2022 18:43:27 +0100
Message-Id: <20220217174329.826430-8-matthieu.baerts@tessares.net>
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

Some vars are redefined in different places. Best to avoid this
classical Bash pitfall where variables are accidentally overridden by
other functions because the proper scope has not been defined.

Most issues are with loops: typically 'i' is used in for-loops but if it
is not global, calling a function from a for-loop also doing a for-loop
with the same non local 'i' variable causes troubles because the first
'i' will be assigned to another value. To prevent such issues, the
iterator variable is now declared as local just before the loop. If it
is always done like this, issues are avoided.

To distinct between local and non local variables, all non local ones
are defined at the beginning of the script. The others are now defined
with the "local" keyword.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    v2:
      - non local variables no longer have capital letter: this can be useful but
        create a lot of modifications everywhere, making backports harders.
      - add missing local
      - explicitly define a 'local' with the iterator before 'for' and 'while' loops

 .../testing/selftests/net/mptcp/mptcp_join.sh | 135 +++++++++++-------
 1 file changed, 83 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 346fdae1f876..ccd7d900c9f1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -9,6 +9,9 @@ cin=""
 cinfail=""
 cinsent=""
 cout=""
+capout=""
+ns1=""
+ns2=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
@@ -51,12 +54,14 @@ init_partial()
 {
 	capout=$(mktemp)
 
+	local rndh
 	rndh=$(mktemp -u XXXXXX)
 
 	ns1="ns1-$rndh"
 	ns2="ns2-$rndh"
 
-	for netns in "$ns1" "$ns2";do
+	local netns
+	for netns in "$ns1" "$ns2"; do
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
@@ -77,6 +82,7 @@ init_partial()
 	# ns1eth3    ns2eth3
 	# ns1eth4    ns2eth4
 
+	local i
 	for i in `seq 1 4`; do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
@@ -95,6 +101,7 @@ init_partial()
 
 init_shapers()
 {
+	local i
 	for i in `seq 1 4`; do
 		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1
 		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1
@@ -105,6 +112,7 @@ cleanup_partial()
 {
 	rm -f "$capout"
 
+	local netns
 	for netns in "$ns1" "$ns2"; do
 		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
@@ -201,7 +209,8 @@ reset_with_cookies()
 {
 	reset "${1}" || return 1
 
-	for netns in "$ns1" "$ns2";do
+	local netns
+	for netns in "$ns1" "$ns2"; do
 		ip netns exec $netns sysctl -q net.ipv4.tcp_syncookies=2
 	done
 }
@@ -274,10 +283,11 @@ print_file_err()
 
 check_transfer()
 {
-	in=$1
-	out=$2
-	what=$3
+	local in=$1
+	local out=$2
+	local what=$3
 
+	local line
 	cmp -l "$in" "$out" | while read line; do
 		local arr=($line)
 
@@ -299,9 +309,9 @@ check_transfer()
 
 do_ping()
 {
-	listener_ns="$1"
-	connector_ns="$2"
-	connect_addr="$3"
+	local listener_ns="$1"
+	local connector_ns="$2"
+	local connect_addr="$3"
 
 	ip netns exec ${connector_ns} ping -q -c 1 $connect_addr >/dev/null
 	if [ $? -ne 0 ] ; then
@@ -312,15 +322,16 @@ do_ping()
 
 link_failure()
 {
-	ns="$1"
+	local ns="$1"
 
 	if [ -z "$FAILING_LINKS" ]; then
 		l=$((RANDOM%4))
 		FAILING_LINKS=$((l+1))
 	fi
 
+	local l
 	for l in $FAILING_LINKS; do
-		veth="ns1eth$l"
+		local veth="ns1eth$l"
 		ip -net "$ns" link set "$veth" down
 	done
 }
@@ -337,9 +348,10 @@ wait_local_port_listen()
 	local listener_ns="${1}"
 	local port="${2}"
 
-	local port_hex i
-
+	local port_hex
 	port_hex="$(printf "%04X" "${port}")"
+
+	local i
 	for i in $(seq 10); do
 		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
 			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
@@ -350,7 +362,7 @@ wait_local_port_listen()
 
 rm_addr_count()
 {
-	ns=${1}
+	local ns=${1}
 
 	ip netns exec ${ns} nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'
 }
@@ -361,8 +373,8 @@ wait_rm_addr()
 	local ns="${1}"
 	local old_cnt="${2}"
 	local cnt
-	local i
 
+	local i
 	for i in $(seq 10); do
 		cnt=$(rm_addr_count ${ns})
 		[ "$cnt" = "${old_cnt}" ] || break
@@ -387,12 +399,13 @@ pm_nl_add_endpoint()
 {
 	local ns=$1
 	local addr=$2
-	local flags
-	local port
-	local dev
-	local id
+	local flags _flags
+	local port _port
+	local dev _dev
+	local id _id
 	local nr=2
 
+	local p
 	for p in $@
 	do
 		if [ $p = "flags" ]; then
@@ -472,24 +485,26 @@ pm_nl_change_endpoint()
 
 do_transfer()
 {
-	listener_ns="$1"
-	connector_ns="$2"
-	cl_proto="$3"
-	srv_proto="$4"
-	connect_addr="$5"
-	test_link_fail="$6"
-	addr_nr_ns1="$7"
-	addr_nr_ns2="$8"
-	speed="$9"
-	sflags="${10}"
-
-	port=$((10000+$TEST_COUNT-1))
+	local listener_ns="$1"
+	local connector_ns="$2"
+	local cl_proto="$3"
+	local srv_proto="$4"
+	local connect_addr="$5"
+	local test_link_fail="$6"
+	local addr_nr_ns1="$7"
+	local addr_nr_ns2="$8"
+	local speed="$9"
+	local sflags="${10}"
+
+	local port=$((10000 + TEST_COUNT - 1))
+	local cappid
 
 	:> "$cout"
 	:> "$sout"
 	:> "$capout"
 
 	if [ $capture -eq 1 ]; then
+		local capuser
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else
@@ -536,7 +551,7 @@ do_transfer()
 				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
 					${local_addr} < "$sin" > "$sout" &
 	fi
-	spid=$!
+	local spid=$!
 
 	wait_local_port_listen "${listener_ns}" "${port}"
 
@@ -553,15 +568,16 @@ do_transfer()
 					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$connect_addr > "$cout" &
 	fi
-	cpid=$!
+	local cpid=$!
 
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
 	[ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 1
 
 	if [ $addr_nr_ns1 -gt 0 ]; then
+		local counter=2
+		local add_nr_ns1
 		let add_nr_ns1=addr_nr_ns1
-		counter=2
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -574,13 +590,16 @@ do_transfer()
 			let add_nr_ns1-=1
 		done
 	elif [ $addr_nr_ns1 -lt 0 ]; then
+		local rm_nr_ns1
 		let rm_nr_ns1=-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
-			counter=0
+			local counter=0
+			local line
 			pm_nl_show_endpoints ${listener_ns} | while read line; do
 				local arr=($line)
 				local nr=0
 
+				local i
 				for i in ${arr[@]}; do
 					if [ $i = "id" ]; then
 						if [ $counter -eq $rm_nr_ns1 ]; then
@@ -602,7 +621,7 @@ do_transfer()
 		fi
 	fi
 
-	flags="subflow"
+	local flags="subflow"
 	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
@@ -613,8 +632,9 @@ do_transfer()
 	[ $addr_nr_ns1 -gt 0 -a $addr_nr_ns2 -lt 0 ] && sleep 1
 
 	if [ $addr_nr_ns2 -gt 0 ]; then
+		local add_nr_ns2
 		let add_nr_ns2=addr_nr_ns2
-		counter=3
+		local counter=3
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -627,18 +647,21 @@ do_transfer()
 			let add_nr_ns2-=1
 		done
 	elif [ $addr_nr_ns2 -lt 0 ]; then
-		let rm_nr_ns2=-addr_nr_ns2
+		local rm_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
-			counter=0
+			local counter=0
+			local line
 			pm_nl_show_endpoints ${connector_ns} | while read line; do
 				local arr=($line)
 				local nr=0
 
+				local i
 				for i in ${arr[@]}; do
 					if [ $i = "id" ]; then
 						if [ $counter -eq $rm_nr_ns2 ]; then
 							break
 						fi
+						local id rm_addr
 						# rm_addr are serialized, allow the previous one to
 						# complete
 						id=${arr[$nr+1]}
@@ -665,12 +688,16 @@ do_transfer()
 
 	if [ ! -z $sflags ]; then
 		sleep 1
+
+		local netns
 		for netns in "$ns1" "$ns2"; do
+			local line
 			pm_nl_show_endpoints $netns | while read line; do
 				local arr=($line)
 				local nr=0
 				local id
 
+				local i
 				for i in ${arr[@]}; do
 					if [ $i = "id" ]; then
 						id=${arr[$nr+1]}
@@ -683,9 +710,9 @@ do_transfer()
 	fi
 
 	wait $cpid
-	retc=$?
+	local retc=$?
 	wait $spid
-	rets=$?
+	local rets=$?
 
 	if [ $capture -eq 1 ]; then
 	    sleep 1
@@ -735,9 +762,9 @@ do_transfer()
 
 make_file()
 {
-	name=$1
-	who=$2
-	size=$3
+	local name=$1
+	local who=$2
+	local size=$3
 
 	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
@@ -747,14 +774,16 @@ make_file()
 
 run_tests()
 {
-	listener_ns="$1"
-	connector_ns="$2"
-	connect_addr="$3"
-	test_linkfail="${4:-0}"
-	addr_nr_ns1="${5:-0}"
-	addr_nr_ns2="${6:-0}"
-	speed="${7:-fast}"
-	sflags="${8:-""}"
+	local listener_ns="$1"
+	local connector_ns="$2"
+	local connect_addr="$3"
+	local test_linkfail="${4:-0}"
+	local addr_nr_ns1="${5:-0}"
+	local addr_nr_ns2="${6:-0}"
+	local speed="${7:-fast}"
+	local sflags="${8:-""}"
+
+	local size
 
 	# create the input file for the failure test when
 	# the first failure test run
@@ -1215,7 +1244,9 @@ wait_attempt_fail()
 	local ns=$1
 
 	while [ $time -lt $timeout_ms ]; do
-		local cnt=$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAttemptFails | awk '{print $2}')
+		local cnt
+
+		cnt=$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAttemptFails | awk '{print $2}')
 
 		[ "$cnt" = 1 ] && return 1
 		time=$((time + 100))
-- 
2.34.1

