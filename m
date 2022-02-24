Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355F1B65
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 13:56:52 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id s24so2954492edr.5
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 05:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=02T14rJi1Rs5Q7HyrNykTziCtVUOiMJeAqh5/oYhA9k=;
        b=ZQfzMwIu9oQ43DBcjTJ8MA06kh9yr86veIbNiKpbMYVAswDLfmwdHISa3GKLA/3CWy
         OKZs5gg3j1Zt+f4w7xDs6tttODvCJWyFqq2deJyOWq8e8WiB2cGcGBtnCyMcDqKsjMMA
         sd1fB+107x1XdSczaFg3o1uZu4Z96GFXvRmCl0bvknJPuEs0FJxmIdKmPkG83g949qu8
         8cBfNjQIiueaZ7yEG6sVWAXWH2hpdic60fP/s2GraReWwEnByI9Uiwv37zrbO1ZnvEFl
         nN7G6SRr/8DQ0iThlmPLld1nNwMP61e9YqOEz5TywWDjBLh3DRh72WyqpSD31J+vG/1s
         tJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=02T14rJi1Rs5Q7HyrNykTziCtVUOiMJeAqh5/oYhA9k=;
        b=QVBusIUBGQfD7f6hN62WdUlNieYvl9+/npLPZUE5zYCKpfhXpXgpr2e2id5vNNBqmI
         06SdBafPhOzdw54yywzWEAz/W3uJl01YVl0XHbttbbKlebtMdN8bP+oRshGiMFsrisId
         AY3g11h5T8jWL1xql8OHspPjnIJOYvIru+JglPjXKlRm8nQng0gqMgnplXCgfNyt+hOu
         Q7HXyGvFvKm65hSwLw6i9qVqX82TNbZddeWoaesBo4hTYYmJqmju1aiCTBqRqAp/ZK3x
         IAyjFEaLU3E6sRvpZTmx2lzepemTlcWavR8seh7WzqSBYTodMidUp1PVAEJiuyMJwLbO
         U6Bw==
X-Gm-Message-State: AOAM533jteV60bNczmOPZcGuAejPkEXhyvVa8DERMJizre/QD0Ixqhn0
	zTiNC4obKcPlzSGA8FmD4mYB0kP1+0axsxaGYWo=
X-Google-Smtp-Source: ABdhPJyUUKK31PbVVw8XFq2xRv6rzgFPpmASglE786vZVqQLEDEOD4VsMjzlJBgbjoy8WSWSQqKJXw==
X-Received: by 2002:a05:6402:c10:b0:40f:33cd:a39 with SMTP id co16-20020a0564020c1000b0040f33cd0a39mr2411862edb.234.1645711010929;
        Thu, 24 Feb 2022 05:56:50 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id 7sm1360733edw.37.2022.02.24.05.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:50 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v3 09/12] selftests: mptcp: join: clarify local/global vars
Date: Thu, 24 Feb 2022 14:56:16 +0100
Message-Id: <20220224135619.2523272-10-matthieu.baerts@tessares.net>
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

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    v2:
      - non local variables no longer have capital letter: this can be useful but
        create a lot of modifications everywhere, making backports harders.
      - add missing local
      - explicitly define a 'local' with the iterator before 'for' and 'while' loops

 .../testing/selftests/net/mptcp/mptcp_join.sh | 133 +++++++++++-------
 1 file changed, 82 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b07cbf1a80ca..f5e17cd2a7df 100755
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
@@ -78,6 +83,7 @@ init_partial()
 	# ns1eth3    ns2eth3
 	# ns1eth4    ns2eth4
 
+	local i
 	for i in `seq 1 4`; do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
@@ -96,6 +102,7 @@ init_partial()
 
 init_shapers()
 {
+	local i
 	for i in `seq 1 4`; do
 		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1
 		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1
@@ -106,6 +113,7 @@ cleanup_partial()
 {
 	rm -f "$capout"
 
+	local netns
 	for netns in "$ns1" "$ns2"; do
 		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
@@ -202,7 +210,8 @@ reset_with_cookies()
 {
 	reset "${1}" || return 1
 
-	for netns in "$ns1" "$ns2";do
+	local netns
+	for netns in "$ns1" "$ns2"; do
 		ip netns exec $netns sysctl -q net.ipv4.tcp_syncookies=2
 	done
 }
@@ -327,10 +336,11 @@ print_file_err()
 
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
 
@@ -352,9 +362,9 @@ check_transfer()
 
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
@@ -365,15 +375,16 @@ do_ping()
 
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
@@ -390,9 +401,10 @@ wait_local_port_listen()
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
@@ -403,7 +415,7 @@ wait_local_port_listen()
 
 rm_addr_count()
 {
-	ns=${1}
+	local ns=${1}
 
 	ip netns exec ${ns} nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'
 }
@@ -414,8 +426,8 @@ wait_rm_addr()
 	local ns="${1}"
 	local old_cnt="${2}"
 	local cnt
-	local i
 
+	local i
 	for i in $(seq 10); do
 		cnt=$(rm_addr_count ${ns})
 		[ "$cnt" = "${old_cnt}" ] || break
@@ -455,12 +467,13 @@ pm_nl_add_endpoint()
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
@@ -610,24 +623,26 @@ pm_nl_check_endpoint()
 
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
 
-	port=$((10000+$TEST_COUNT-1))
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
@@ -681,7 +696,7 @@ do_transfer()
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
 					$extra_args ${local_addr} < "$sin" > "$sout" &
 	fi
-	spid=$!
+	local spid=$!
 
 	wait_local_port_listen "${listener_ns}" "${port}"
 
@@ -704,15 +719,16 @@ do_transfer()
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$extra_args $connect_addr > "$cout" &
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
@@ -725,13 +741,16 @@ do_transfer()
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
@@ -753,7 +772,7 @@ do_transfer()
 		fi
 	fi
 
-	flags="subflow"
+	local flags="subflow"
 	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
@@ -764,8 +783,9 @@ do_transfer()
 	[ $addr_nr_ns1 -gt 0 -a $addr_nr_ns2 -lt 0 ] && sleep 1
 
 	if [ $addr_nr_ns2 -gt 0 ]; then
+		local add_nr_ns2
 		let add_nr_ns2=addr_nr_ns2
-		counter=3
+		local counter=3
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -778,18 +798,21 @@ do_transfer()
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
@@ -816,12 +839,16 @@ do_transfer()
 
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
@@ -834,9 +861,9 @@ do_transfer()
 	fi
 
 	wait $cpid
-	retc=$?
+	local retc=$?
 	wait $spid
-	rets=$?
+	local rets=$?
 
 	if [ $capture -eq 1 ]; then
 	    sleep 1
@@ -886,9 +913,9 @@ do_transfer()
 
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
@@ -898,14 +925,16 @@ make_file()
 
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
 
 	# The values above 2 are reused to make test files
 	# with the given sizes (KB)
@@ -1516,7 +1545,9 @@ wait_attempt_fail()
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

