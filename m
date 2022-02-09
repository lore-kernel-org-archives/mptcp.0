Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5A2CA6
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 21:25:53 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so212783wmb.1
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 13:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZFPKgYT5Czqm6ieug/FyEE9Q5Vp2M7NX7lWqc4KoN4=;
        b=DDfAw+fteej89qo1+1StRRSmqec+hHYCSyIMgAHtM48LcWiV/Pz4pE0bD2H+iJ9dnp
         VJx5CQ+loXLKnFlM7L+1n1cq9ZYob058YgwrDsf200FIl6tfoyzQ9g/4JdCfFU8ZKRTX
         VULyNutqImN0KHovbjJHrkeywzrqNLVh7vXOT+ugT6cqRwMRnEKbvSU0H2BIWjn7MSN2
         +VYU1WTrKiYsNY6jiWoy6dpVO+vRmbxZL3W9ynnlowSjr1Q0C1e3zQ5AUTOhSO/ZygP6
         +d/Y5kjDGmkkbhgSE2/Yr9jpxsceHfNtB1ZtNOmPo1SNiZo4EI+zR/Cj6K+GZoisaq1S
         bFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZFPKgYT5Czqm6ieug/FyEE9Q5Vp2M7NX7lWqc4KoN4=;
        b=PbRXLsOGBXGlTA9f4tmAc8k3qxs3oBA4GXOKoDuWU3acsqwcQvSwabY4xVPF4Xwe42
         7OLEWzAhgQs6F83AltxFHsUtaA9Zf5JEAD8hxijeKOAvuiKee2lrvJwpVSGOQ/mirjHz
         8lxSi6K29lWPZzPHEpWuFCbI5W6qQ2g6trio1cG0xQxAQzjIYWV3bVJZnUzSVXkyICT+
         UAHtAOh4YaiHG9l3KOLFkK2ZG7BiQV/c6fBV2b5xjQUuCDkNVg4sGIQsSeWpD3FBF2Gj
         LplKz8XrSZymi6Yedy7/Rsz87P5X690wThMhxWmrg1HmhUqvpZyRphp4TwNqiWxLaTrm
         AHtA==
X-Gm-Message-State: AOAM530KXE2LfghDMExIy/OpERhY7QMyW+jnsItT8/oJ9JVJ96cJHp9k
	l6AMb77Np1dGTcVpwdttw2rQAbdC4a7PwteC
X-Google-Smtp-Source: ABdhPJwcHSz+97/CxMFQmUh/Hcea0olS3yKOeSbre5fsCW4rRf07UqICcFXGkH4/l6RNG7EE2BLCfg==
X-Received: by 2002:a7b:c248:: with SMTP id b8mr4467494wmj.194.1644441950263;
        Wed, 09 Feb 2022 13:25:50 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p14sm18500730wrr.7.2022.02.09.13.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:25:49 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 7/9] selftests: mptcp: join: clarify local/global vars
Date: Wed,  9 Feb 2022 22:25:18 +0100
Message-Id: <20220209212520.2989291-8-matthieu.baerts@tessares.net>
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

Some vars are redefined in different places. Best to avoid this
classical Bash pitfall where variables are accidentally overridden by
other functions.

To distinct between local and non local variables, all non local ones
now have capital letters. The others are now defined with the "local"
keyword.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 1390 +++++++++--------
 1 file changed, 705 insertions(+), 685 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8c1ee51e9cfd..15e642e0fa03 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1,28 +1,29 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ret=0
-sin=""
-sinfail=""
-sout=""
-cin=""
-cinfail=""
-cinsent=""
-cout=""
-ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
-mptcp_connect=""
-capture=0
-checksum=0
-ip_mptcp=0
-check_invert=0
-do_all_tests=1
+RET=0
+SIN=""
+SINFAIL=""
+SOUT=""
+CIN=""
+CINFAIL=""
+CINSENT=""
+COUT=""
+CAPOUT=""
+KSFT_SKIP=4
+TIMEOUT_POLL=30
+TIMEOUT_TEST=$((TIMEOUT_POLL * 2 + 1))
+MPTCP_CONNECT=""
+CAPTURE=0
+CHECKSUM=0
+IP_MPTCP=0
+CHECK_INVERT=0
+DO_ALL_TESTS=1
 INIT=0
 
 TEST_COUNT=0
 ONLY_TESTS=()
-nr_blank=40
+NR_BLANK=40
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -44,26 +45,28 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
 
 init_partial()
 {
-	capout=$(mktemp)
+	CAPOUT=$(mktemp)
 
+	local rndh
 	rndh=$(mktemp -u XXXXXX)
 
-	ns1="ns1-$rndh"
-	ns2="ns2-$rndh"
+	NS1="ns1-$rndh"
+	NS2="ns2-$rndh"
 
-	for netns in "$ns1" "$ns2";do
-		ip netns add $netns || exit $ksft_skip
+	local netns
+	for netns in "$NS1" "$NS2"; do
+		ip netns add $netns || exit $KSFT_SKIP
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
-		if [ $checksum -eq 1 ]; then
+		if [ $CHECKSUM -eq 1 ]; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
 	done
 
-	check_invert=0
+	CHECK_INVERT=0
 
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
@@ -71,35 +74,38 @@ init_partial()
 	# ns1eth3    ns2eth3
 	# ns1eth4    ns2eth4
 
+	local i
 	for i in `seq 1 4`; do
-		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
-		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
-		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
-		ip -net "$ns1" link set ns1eth$i up
-
-		ip -net "$ns2" addr add 10.0.$i.2/24 dev ns2eth$i
-		ip -net "$ns2" addr add dead:beef:$i::2/64 dev ns2eth$i nodad
-		ip -net "$ns2" link set ns2eth$i up
-
-		# let $ns2 reach any $ns1 address from any interface
-		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
-		ip -net "$ns2" route add default via dead:beef:$i::1 dev ns2eth$i metric 10$i
+		ip link add ns1eth$i netns "$NS1" type veth peer name ns2eth$i netns "$NS2"
+		ip -net "$NS1" addr add 10.0.$i.1/24 dev ns1eth$i
+		ip -net "$NS1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
+		ip -net "$NS1" link set ns1eth$i up
+
+		ip -net "$NS2" addr add 10.0.$i.2/24 dev ns2eth$i
+		ip -net "$NS2" addr add dead:beef:$i::2/64 dev ns2eth$i nodad
+		ip -net "$NS2" link set ns2eth$i up
+
+		# let $NS2 reach any $NS1 address from any interface
+		ip -net "$NS2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
+		ip -net "$NS2" route add default via dead:beef:$i::1 dev ns2eth$i metric 10$i
 	done
 }
 
 init_shapers()
 {
+	local i
 	for i in `seq 1 4`; do
-		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1
-		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1
+		tc -n $NS1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1
+		tc -n $NS2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1
 	done
 }
 
 cleanup_partial()
 {
-	rm -f "$capout"
+	rm -f "${CAPOUT}"
 
-	for netns in "$ns1" "$ns2"; do
+	local netns
+	for netns in "$NS1" "$NS2"; do
 		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
 	done
@@ -128,33 +134,32 @@ init() {
 
 	check_tools
 
-	sin=$(mktemp)
-	sout=$(mktemp)
-	cin=$(mktemp)
-	cinsent=$(mktemp)
-	cout=$(mktemp)
+	SIN=$(mktemp)
+	SOUT=$(mktemp)
+	CIN=$(mktemp)
+	CINSENT=$(mktemp)
+	COUT=$(mktemp)
 
 	trap cleanup EXIT
 
-	make_file "$cin" "client" 1
-	make_file "$sin" "server" 1
+	make_file "$CIN" "client" 1
+	make_file "$SIN" "server" 1
 }
 
 cleanup()
 {
-	rm -f "$cin" "$cout" "$sinfail"
-	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
+	rm -f "${CIN}" "${COUT}" "${SINFAIL}"
+	rm -f "${SIN}" "${SOUT}" "${CINSENT}" "${CINFAIL}"
 	cleanup_partial
 }
 
 skip_test()
 {
-	local i
-
 	if [ "${#ONLY_TESTS[@]}" -eq 0 ]; then
 		return 1
 	fi
 
+	local i
 	for i in "${ONLY_TESTS[@]}"; do
 		if [ "${TEST_COUNT}" -eq "${i}" ]; then
 			return 1
@@ -187,7 +192,8 @@ reset_with_cookies()
 {
 	reset || return 1
 
-	for netns in "$ns1" "$ns2";do
+	local netns
+	for netns in "$NS1" "$NS2"; do
 		ip netns exec $netns sysctl -q net.ipv4.tcp_syncookies=2
 	done
 }
@@ -197,15 +203,15 @@ reset_with_add_addr_timeout()
 	local ip="${1:-4}"
 	local tables
 
+	reset || return 1
+
 	tables="iptables"
 	if [ $ip -eq 6 ]; then
 		tables="ip6tables"
 	fi
 
-	reset || return 1
-
-	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-	ip netns exec $ns2 $tables -A OUTPUT -p tcp \
+	ip netns exec $NS1 sysctl -q net.mptcp.add_addr_timeout=1
+	ip netns exec $NS2 $tables -A OUTPUT -p tcp \
 		-m tcp --tcp-option 30 \
 		-m bpf --bytecode \
 		"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
@@ -219,8 +225,8 @@ reset_with_checksum()
 
 	reset || return 1
 
-	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
-	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
+	ip netns exec $NS1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
+	ip netns exec $NS2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
 }
 
 reset_with_allow_join_id0()
@@ -230,8 +236,8 @@ reset_with_allow_join_id0()
 
 	reset || return 1
 
-	ip netns exec $ns1 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns1_enable
-	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
+	ip netns exec $NS1 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns1_enable
+	ip netns exec $NS2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
 }
 
 print_file_err()
@@ -243,19 +249,19 @@ print_file_err()
 
 check_transfer()
 {
-	in=$1
-	out=$2
-	what=$3
+	local in=$1
+	local out=$2
+	local what=$3
 
 	cmp -l "$in" "$out" | while read line; do
 		local arr=($line)
 
 		let sum=0${arr[1]}+0${arr[2]}
-		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
+		if [ $CHECK_INVERT -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			echo "[ FAIL ] $what does not match (in, out):"
 			print_file_err "$in"
 			print_file_err "$out"
-			ret=1
+			RET=1
 
 			return 1
 		else
@@ -268,28 +274,29 @@ check_transfer()
 
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
 		echo "$listener_ns -> $connect_addr connectivity [ FAIL ]" 1>&2
-		ret=1
+		RET=1
 	fi
 }
 
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
@@ -319,7 +326,7 @@ wait_local_port_listen()
 
 rm_addr_count()
 {
-	ns=${1}
+	local ns=${1}
 
 	ip netns exec ${ns} nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'
 }
@@ -345,7 +352,7 @@ pm_nl_set_limits()
 	local addrs=$2
 	local subflows=$3
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if [ $IP_MPTCP -eq 1 ]; then
 		ip -n $ns mptcp limits set add_addr_accepted $addrs subflows $subflows
 	else
 		ip netns exec $ns ./pm_nl_ctl limits $addrs $subflows
@@ -356,11 +363,12 @@ pm_nl_add_endpoint()
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
@@ -384,7 +392,7 @@ pm_nl_add_endpoint()
 		let nr+=1
 	done
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if [ $IP_MPTCP -eq 1 ]; then
 		ip -n $ns mptcp endpoint add $addr ${_flags//","/" "} $dev $id $port
 	else
 		ip netns exec $ns ./pm_nl_ctl add $addr $flags $dev $id $port
@@ -397,7 +405,7 @@ pm_nl_del_endpoint()
 	local id=$2
 	local addr=$3
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if [ $IP_MPTCP -eq 1 ]; then
 		ip -n $ns mptcp endpoint delete id $id $addr
 	else
 		ip netns exec $ns ./pm_nl_ctl del $id $addr
@@ -408,7 +416,7 @@ pm_nl_flush_endpoint()
 {
 	local ns=$1
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if [ $IP_MPTCP -eq 1 ]; then
 		ip -n $ns mptcp endpoint flush
 	else
 		ip netns exec $ns ./pm_nl_ctl flush
@@ -419,7 +427,7 @@ pm_nl_show_endpoints()
 {
 	local ns=$1
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if [ $IP_MPTCP -eq 1 ]; then
 		ip -n $ns mptcp endpoint show
 	else
 		ip netns exec $ns ./pm_nl_ctl dump
@@ -432,7 +440,7 @@ pm_nl_change_endpoint()
 	local id=$2
 	local flags=$3
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if [ $IP_MPTCP -eq 1 ]; then
 		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
 	else
 		ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
@@ -441,24 +449,26 @@ pm_nl_change_endpoint()
 
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
-
-	:> "$cout"
-	:> "$sout"
-	:> "$capout"
-
-	if [ $capture -eq 1 ]; then
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
+
+	:> "$COUT"
+	:> "$SOUT"
+	:> "$CAPOUT"
+
+	if [ $CAPTURE -eq 1 ]; then
+		local capuser
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
 		else
@@ -468,7 +478,7 @@ do_transfer()
 		capfile=$(printf "mp_join-%02u-%s.pcap" "$TEST_COUNT" "${listener_ns}")
 
 		echo "Capturing traffic for test $TEST_COUNT into $capfile"
-		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
+		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -w $capfile > "$CAPOUT" 2>&1 &
 		cappid=$!
 
 		sleep 1
@@ -480,11 +490,11 @@ do_transfer()
 		nstat -n
 
 	if [ $speed = "fast" ]; then
-		mptcp_connect="./mptcp_connect -j"
+		MPTCP_CONNECT="./mptcp_connect -j"
 	elif [ $speed = "slow" ]; then
-		mptcp_connect="./mptcp_connect -r 50"
+		MPTCP_CONNECT="./mptcp_connect -r 50"
 	elif [ $speed = "least" ]; then
-		mptcp_connect="./mptcp_connect -r 10"
+		MPTCP_CONNECT="./mptcp_connect -r 10"
 	fi
 
 	local local_addr
@@ -495,42 +505,43 @@ do_transfer()
 	fi
 
 	if [ "$test_link_fail" -eq 2 ];then
-		timeout ${timeout_test} \
+		timeout ${TIMEOUT_TEST} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sinfail" > "$sout" &
+				$MPTCP_CONNECT -t ${TIMEOUT_POLL} -l -p $port -s ${srv_proto} \
+					${local_addr} < "$SINFAIL" > "$SOUT" &
 	else
-		timeout ${timeout_test} \
+		timeout ${TIMEOUT_TEST} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sin" > "$sout" &
+				$MPTCP_CONNECT -t ${TIMEOUT_POLL} -l -p $port -s ${srv_proto} \
+					${local_addr} < "$SIN" > "$SOUT" &
 	fi
-	spid=$!
+	local spid=$!
 
 	wait_local_port_listen "${listener_ns}" "${port}"
 
 	if [ "$test_link_fail" -eq 0 ];then
-		timeout ${timeout_test} \
+		timeout ${TIMEOUT_TEST} \
 			ip netns exec ${connector_ns} \
-				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$connect_addr < "$cin" > "$cout" &
+				$MPTCP_CONNECT -t ${TIMEOUT_POLL} -p $port -s ${cl_proto} \
+					$connect_addr < "$CIN" > "$COUT" &
 	else
-		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
-			tee "$cinsent" | \
-			timeout ${timeout_test} \
+		( cat "$CINFAIL" ; sleep 2; link_failure $listener_ns ; cat "$CINFAIL" ) | \
+			tee "$CINSENT" | \
+			timeout ${TIMEOUT_TEST} \
 				ip netns exec ${connector_ns} \
-					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$connect_addr > "$cout" &
+					$MPTCP_CONNECT -t ${TIMEOUT_POLL} -p $port -s ${cl_proto} \
+						$connect_addr > "$COUT" &
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
@@ -538,18 +549,20 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			pm_nl_add_endpoint $ns1 $addr flags signal
+			pm_nl_add_endpoint $NS1 $addr flags signal
 			let counter+=1
 			let add_nr_ns1-=1
 		done
 	elif [ $addr_nr_ns1 -lt 0 ]; then
+		local rm_nr_ns1
 		let rm_nr_ns1=-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
-			counter=0
+			local counter=0
 			pm_nl_show_endpoints ${listener_ns} | while read line; do
 				local arr=($line)
 				local nr=0
 
+				local i
 				for i in ${arr[@]}; do
 					if [ $i = "id" ]; then
 						if [ $counter -eq $rm_nr_ns1 ]; then
@@ -571,7 +584,7 @@ do_transfer()
 		fi
 	fi
 
-	flags="subflow"
+	local flags="subflow"
 	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
@@ -582,8 +595,9 @@ do_transfer()
 	[ $addr_nr_ns1 -gt 0 -a $addr_nr_ns2 -lt 0 ] && sleep 1
 
 	if [ $addr_nr_ns2 -gt 0 ]; then
+		local add_nr_ns2
 		let add_nr_ns2=addr_nr_ns2
-		counter=3
+		local counter=3
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -596,18 +610,20 @@ do_transfer()
 			let add_nr_ns2-=1
 		done
 	elif [ $addr_nr_ns2 -lt 0 ]; then
-		let rm_nr_ns2=-addr_nr_ns2
+		local rm_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
-			counter=0
+			local counter=0
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
@@ -634,7 +650,7 @@ do_transfer()
 
 	if [ ! -z $sflags ]; then
 		sleep 1
-		for netns in "$ns1" "$ns2"; do
+		for netns in "$NS1" "$NS2"; do
 			pm_nl_show_endpoints $netns | while read line; do
 				local arr=($line)
 				local nr=0
@@ -652,11 +668,11 @@ do_transfer()
 	fi
 
 	wait $cpid
-	retc=$?
+	local retc=$?
 	wait $spid
-	rets=$?
+	local rets=$?
 
-	if [ $capture -eq 1 ]; then
+	if [ $CAPTURE -eq 1 ]; then
 	    sleep 1
 	    kill $cappid
 	fi
@@ -675,38 +691,38 @@ do_transfer()
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
 		cat /tmp/${connector_ns}.out
 
-		cat "$capout"
-		ret=1
+		cat "$CAPOUT"
+		RET=1
 		return 1
 	fi
 
 	if [ "$test_link_fail" -eq 2 ];then
-		check_transfer $sinfail $cout "file received by client"
+		check_transfer $SINFAIL $COUT "file received by client"
 	else
-		check_transfer $sin $cout "file received by client"
+		check_transfer $SIN $COUT "file received by client"
 	fi
 	retc=$?
 	if [ "$test_link_fail" -eq 0 ];then
-		check_transfer $cin $sout "file received by server"
+		check_transfer $CIN $SOUT "file received by server"
 	else
-		check_transfer $cinsent $sout "file received by server"
+		check_transfer $CINSENT $SOUT "file received by server"
 	fi
 	rets=$?
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
-		cat "$capout"
+		cat "$CAPOUT"
 		return 0
 	fi
 
-	cat "$capout"
+	cat "$CAPOUT"
 	return 1
 }
 
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
@@ -716,18 +732,20 @@ make_file()
 
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
-	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	if [ "$test_linkfail" -ne 0 -a -z "$CINFAIL" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -736,17 +754,17 @@ run_tests()
 		size=$((size*8192))
 		size=$((size + ( $RANDOM % 8192) ))
 
-		cinfail=$(mktemp)
-		make_file "$cinfail" "client" $size
+		CINFAIL=$(mktemp)
+		make_file "$CINFAIL" "client" $size
 	fi
 
-	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	if [ "$test_linkfail" -eq 2 -a -z "$SINFAIL" ]; then
 		size=$((RANDOM%16))
 		size=$((size+1))
 		size=$((size*2048))
 
-		sinfail=$(mktemp)
-		make_file "$sinfail" "server" $size
+		SINFAIL=$(mktemp)
+		make_file "$SINFAIL" "server" $size
 	fi
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
@@ -756,9 +774,9 @@ run_tests()
 dump_stats()
 {
 	echo Server ns stats
-	ip netns exec $ns1 nstat -as | grep Tcp
+	ip netns exec $NS1 nstat -as | grep Tcp
 	echo Client ns stats
-	ip netns exec $ns2 nstat -as | grep Tcp
+	ip netns exec $NS2 nstat -as | grep Tcp
 }
 
 chk_csum_nr()
@@ -773,21 +791,21 @@ chk_csum_nr()
 		echo -n "   "
 	fi
 	printf " %-36s %s" "$msg" "sum"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
+	count=`ip netns exec $NS2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -802,23 +820,23 @@ chk_fail_nr()
 	local count
 	local dump_stats
 
-	printf "%-${nr_blank}s %s" " " "ftx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
+	printf "%-${NR_BLANK}s %s" " " "ftx"
+	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_fail_nr_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
 	echo -n " - frx   "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
+	count=`ip netns exec $NS2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_fail_nr_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -834,23 +852,23 @@ chk_infi_nr()
 	local count
 	local dump_stats
 
-	printf "%-${nr_blank}s %s" " " "itx"
-	count=`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print $2}'`
+	printf "%-${NR_BLANK}s %s" " " "itx"
+	count=`ip netns exec $NS2 nstat -as | grep InfiniteMapTx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_infi_nr_tx" ]; then
 		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
 	echo -n " - irx   "
-	count=`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print $2}'`
+	count=`ip netns exec $NS1 nstat -as | grep InfiniteMapRx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_infi_nr_rx" ]; then
 		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -869,39 +887,39 @@ chk_join_nr()
 	local dump_stats
 
 	printf "%03u %-36s %s" "$TEST_COUNT" "$msg" "syn"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
+	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
 	echo -n " - synack"
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
+	count=`ip netns exec $NS2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
 	echo -n " - ack"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}'`
+	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo "[ ok ]"
 	fi
 	[ "${dump_stats}" = 1 ] && dump_stats
-	if [ $checksum -eq 1 ]; then
+	if [ $CHECKSUM -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
 		chk_infi_nr 0 0
@@ -923,7 +941,7 @@ chk_stale_nr()
 	local stale_nr
 	local recover_nr
 
-	printf "%-${nr_blank}s %-18s" " " "stale"
+	printf "%-${NR_BLANK}s %-18s" " " "stale"
 	stale_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}'`
 	[ -z "$stale_nr" ] && stale_nr=0
 	recover_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}'`
@@ -935,7 +953,7 @@ chk_stale_nr()
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta "
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -962,28 +980,28 @@ chk_add_nr()
 	local dump_stats
 	local timeout
 
-	timeout=`ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout`
+	timeout=`ip netns exec $NS1 sysctl -n net.mptcp.add_addr_timeout`
 
-	printf "%-${nr_blank}s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
+	printf "%-${NR_BLANK}s %s" " " "add"
+	count=`ip netns exec $NS2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
 	if [ "$count" != "$add_nr" ] && [ "$timeout" -gt 1 -o "$count" -lt "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
 	echo -n " - echo  "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}'`
+	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -991,76 +1009,76 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		echo -n " - pt "
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}'`
+		count=`ip netns exec $NS2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}'`
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
-			ret=1
+			RET=1
 			dump_stats=1
 		else
 			echo "[ ok ]"
 		fi
 
-		printf "%-${nr_blank}s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
+		printf "%-${NR_BLANK}s %s" " " "syn"
+		count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
 			awk '{print $2}'`
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
 				port-number expected $syn_nr"
-			ret=1
+			RET=1
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
 		fi
 
 		echo -n " - synack"
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
+		count=`ip netns exec $NS2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
 			awk '{print $2}'`
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
 				port-number expected $syn_ack_nr"
-			ret=1
+			RET=1
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
 		fi
 
 		echo -n " - ack"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
+		count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
 			awk '{print $2}'`
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
 				port-number expected $ack_nr"
-			ret=1
+			RET=1
 			dump_stats=1
 		else
 			echo "[ ok ]"
 		fi
 
-		printf "%-${nr_blank}s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
+		printf "%-${NR_BLANK}s %s" " " "syn"
+		count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMismatchPortSynRx |
 			awk '{print $2}'`
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
 				port-number expected $mis_syn_nr"
-			ret=1
+			RET=1
 			dump_stats=1
 		else
 			echo -n "[ ok ]"
 		fi
 
 		echo -n " - ack   "
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
+		count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMismatchPortAckRx |
 			awk '{print $2}'`
 		[ -z "$count" ] && count=0
 		if [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
 				port-number expected $mis_ack_nr"
-			ret=1
+			RET=1
 			dump_stats=1
 		else
 			echo "[ ok ]"
@@ -1083,19 +1101,19 @@ chk_rm_nr()
 	local subflow_ns
 
 	if [ -z $invert ]; then
-		addr_ns=$ns1
-		subflow_ns=$ns2
+		addr_ns=$NS1
+		subflow_ns=$NS2
 	elif [ $invert = "invert" ]; then
-		addr_ns=$ns2
-		subflow_ns=$ns1
+		addr_ns=$NS2
+		subflow_ns=$NS1
 	fi
 
-	printf "%-${nr_blank}s %s" " " "rm "
+	printf "%-${NR_BLANK}s %s" " " "rm "
 	count=`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
@@ -1106,7 +1124,7 @@ chk_rm_nr()
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1122,23 +1140,23 @@ chk_prio_nr()
 	local count
 	local dump_stats
 
-	printf "%-${nr_blank}s %s" " " "ptx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}'`
+	printf "%-${NR_BLANK}s %s" " " "ptx"
+	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
 	echo -n " - prx   "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}'`
+	count=`ip netns exec $NS1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
-		ret=1
+		RET=1
 		dump_stats=1
 	else
 		echo "[ ok ]"
@@ -1158,11 +1176,11 @@ chk_link_usage()
 	local tx_rate=$((tx_link * 100 / $tx_total))
 	local tolerance=5
 
-	printf "%-${nr_blank}s %-18s" " " "link usage"
+	printf "%-${NR_BLANK}s %-18s" " " "link usage"
 	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
 	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
 		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
-		ret=1
+		RET=1
 	else
 		echo "[ ok ]"
 	fi
@@ -1170,12 +1188,14 @@ chk_link_usage()
 
 wait_attempt_fail()
 {
-	local timeout_ms=$((timeout_poll * 1000))
+	local timeout_ms=$((TIMEOUT_POLL * 1000))
 	local time=0
 	local ns=$1
 
 	while [ $time -lt $timeout_ms ]; do
-		local cnt=$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAttemptFails | awk '{print $2}')
+		local cnt
+
+		cnt=$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAttemptFails | awk '{print $2}')
 
 		[ "$cnt" = 1 ] && return 1
 		time=$((time + 100))
@@ -1187,63 +1207,63 @@ wait_attempt_fail()
 subflows_tests()
 {
 	if reset; then
-		run_tests $ns1 $ns2 10.0.1.1
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "no JOIN" "0" "0" "0"
 	fi
 
 	# subflow limited by client
 	if reset; then
-		pm_nl_set_limits $ns1 0 0
-		pm_nl_set_limits $ns2 0 0
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 0
+		pm_nl_set_limits $NS2 0 0
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "single subflow, limited by client" 0 0 0
 	fi
 
 	# subflow limited by server
 	if reset; then
-		pm_nl_set_limits $ns1 0 0
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 0
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "single subflow, limited by server" 1 1 0
 	fi
 
 	# subflow
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "single subflow" 1 1 1
 	fi
 
 	# multiple subflows
 	if reset; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_set_limits $NS2 0 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "multiple subflows" 2 2 2
 	fi
 
 	# multiple subflows limited by server
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "multiple subflows, limited by server" 2 2 1
 	fi
 
 	# single subflow, dev
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow dev ns2eth3
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow dev ns2eth3
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "single subflow, dev" 1 1 1
 	fi
 }
@@ -1253,32 +1273,32 @@ subflows_error_tests()
 	# If a single subflow is configured, and matches the MPC src
 	# address, no additional subflow should be created
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 10.0.1.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 slow
 		chk_join_nr "no MPC reuse with single endpoint" 0 0 0
 	fi
 
 	# multiple subflows, with subflow creation error
 	if reset; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_set_limits $NS2 0 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags subflow
+		ip netns exec $NS1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 slow
 		chk_join_nr "multi subflows, with failing subflow" 1 1 1
 	fi
 
 	# multiple subflows, with subflow timeout on MPJ
 	if reset; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_set_limits $NS2 0 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags subflow
+		ip netns exec $NS1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 slow
 		chk_join_nr "multi subflows, with subflow timeout" 1 1 1
 	fi
 
@@ -1286,15 +1306,15 @@ subflows_error_tests()
 	# closed subflow (due to reset) is not reused if additional
 	# subflows are added later
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		ip netns exec $NS1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 slow &
 
 		# mpj subflow will be in TW after the reset
-		wait_attempt_fail $ns2
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
+		wait_attempt_fail $NS2
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags subflow
 		wait
 
 		# additional subflow could be created only if the PM select
@@ -1307,18 +1327,18 @@ signal_address_tests()
 {
 	# add_address, unused
 	if reset; then
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "unused signal address" 0 0 0
 		chk_add_nr 1 1
 	fi
 
 	# accept and use add_addr
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "signal address" 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -1328,67 +1348,67 @@ signal_address_tests()
 	# belong to different subnets or one of the listed local address could be
 	# used for 'add_addr' subflow
 	if reset; then
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 1 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_set_limits $NS2 1 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "subflow and signal" 2 2 2
 		chk_add_nr 1 1
 	fi
 
 	# accept and use add_addr with additional subflows
 	if reset; then
-		pm_nl_set_limits $ns1 0 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 3
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_set_limits $NS2 1 3
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.4.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "multiple subflows and signal" 3 3 3
 		chk_add_nr 1 1
 	fi
 
 	# signal addresses
 	if reset; then
-		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
-		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 3 3
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.4.1 flags signal
+		pm_nl_set_limits $NS2 3 3
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "signal addresses" 3 3 3
 		chk_add_nr 3 3
 	fi
 
 	# signal invalid addresses
 	if reset; then
-		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
-		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 3 3
+		pm_nl_add_endpoint $NS1 10.0.12.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.14.1 flags signal
+		pm_nl_set_limits $NS2 3 3
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "signal invalid addresses" 1 1 1
 		chk_add_nr 3 3
 	fi
 
 	# signal addresses race test
 	if reset; then
-		pm_nl_set_limits $ns1 4 4
-		pm_nl_set_limits $ns2 4 4
-		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.1.2 flags signal
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
+		pm_nl_set_limits $NS1 4 4
+		pm_nl_set_limits $NS2 4 4
+		pm_nl_add_endpoint $NS1 10.0.1.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.4.1 flags signal
+		pm_nl_add_endpoint $NS2 10.0.1.2 flags signal
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags signal
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags signal
+		pm_nl_add_endpoint $NS2 10.0.4.2 flags signal
 
 		# the peer could possibly miss some addr notification, allow retransmission
-		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		ip netns exec $NS1 sysctl -q net.mptcp.add_addr_timeout=1
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 slow
 		chk_join_nr "signal addresses race test" 3 3 3
 
 		# the server will not signal the address terminating
@@ -1408,76 +1428,76 @@ link_failure_tests()
 		# active backup and link switch-over.
 		# Let's set some arbitrary (low) virtual link limits.
 		init_shapers
-		pm_nl_set_limits $ns1 0 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
-		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 1
+		pm_nl_set_limits $NS1 0 3
+		pm_nl_add_endpoint $NS1 10.0.2.1 dev ns1eth2 flags signal
+		pm_nl_set_limits $NS2 1 3
+		pm_nl_add_endpoint $NS2 10.0.3.2 dev ns2eth3 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.4.2 dev ns2eth4 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 1
 		chk_join_nr "multiple flows, signal, link failure" 3 3 3
 		chk_add_nr 1 1
-		chk_stale_nr $ns2 1 5 1
+		chk_stale_nr $NS2 1 5 1
 	fi
 
 	# accept and use add_addr with additional subflows and link loss
 	# for bidirectional transfer
 	if reset; then
 		init_shapers
-		pm_nl_set_limits $ns1 0 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
-		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 2
+		pm_nl_set_limits $NS1 0 3
+		pm_nl_add_endpoint $NS1 10.0.2.1 dev ns1eth2 flags signal
+		pm_nl_set_limits $NS2 1 3
+		pm_nl_add_endpoint $NS2 10.0.3.2 dev ns2eth3 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.4.2 dev ns2eth4 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 2
 		chk_join_nr "multi flows, signal, bidi, link fail" 3 3 3
 		chk_add_nr 1 1
-		chk_stale_nr $ns2 1 -1 1
+		chk_stale_nr $NS2 1 -1 1
 	fi
 
 	# 2 subflows plus 1 backup subflow with a lossy link, backup
 	# will never be used
 	if reset; then
 		init_shapers
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
-		pm_nl_set_limits $ns2 1 2
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_add_endpoint $NS1 10.0.2.1 dev ns1eth2 flags signal
+		pm_nl_set_limits $NS2 1 2
 		export FAILING_LINKS="1"
-		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 dev ns2eth3 flags subflow,backup
+		run_tests $NS1 $NS2 10.0.1.1 1
 		chk_join_nr "backup subflow unused, link failure" 2 2 2
 		chk_add_nr 1 1
-		chk_link_usage $ns2 ns2eth3 $cinsent 0
+		chk_link_usage $NS2 ns2eth3 $CINSENT 0
 	fi
 
 	# 2 lossy links after half transfer, backup will get half of
 	# the traffic
 	if reset; then
 		init_shapers
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
-		pm_nl_set_limits $ns2 1 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_add_endpoint $NS1 10.0.2.1 dev ns1eth2 flags signal
+		pm_nl_set_limits $NS2 1 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 dev ns2eth3 flags subflow,backup
 		export FAILING_LINKS="1 2"
-		run_tests $ns1 $ns2 10.0.1.1 1
+		run_tests $NS1 $NS2 10.0.1.1 1
 		chk_join_nr "backup flow used, multi links fail" 2 2 2
 		chk_add_nr 1 1
-		chk_stale_nr $ns2 2 4 2
-		chk_link_usage $ns2 ns2eth3 $cinsent 50
+		chk_stale_nr $NS2 2 4 2
+		chk_link_usage $NS2 ns2eth3 $CINSENT 50
 	fi
 
 	# use a backup subflow with the first subflow on a lossy link
 	# for bidirectional transfer
 	if reset; then
 		init_shapers
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
-		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 2
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_add_endpoint $NS1 10.0.2.1 dev ns1eth2 flags signal
+		pm_nl_set_limits $NS2 1 3
+		pm_nl_add_endpoint $NS2 10.0.3.2 dev ns2eth3 flags subflow,backup
+		run_tests $NS1 $NS2 10.0.1.1 2
 		chk_join_nr "backup flow used, bidi, link failure" 2 2 2
 		chk_add_nr 1 1
-		chk_stale_nr $ns2 1 -1 2
-		chk_link_usage $ns2 ns2eth3 $cinsent 50
+		chk_stale_nr $NS2 1 -1 2
+		chk_link_usage $NS2 ns2eth3 $CINSENT 50
 	fi
 }
 
@@ -1485,42 +1505,42 @@ add_addr_timeout_tests()
 {
 	# add_addr timeout
 	if reset_with_add_addr_timeout; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 slow
 		chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
 		chk_add_nr 4 0
 	fi
 
 	# add_addr timeout IPv6
 	if reset_with_add_addr_timeout 6; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS1 dead:beef:2::1 flags signal
+		run_tests $NS1 $NS2 dead:beef:1::1 0 0 0 slow
 		chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
 		chk_add_nr 4 0
 	fi
 
 	# signal addresses timeout
 	if reset_with_add_addr_timeout; then
-		pm_nl_set_limits $ns1 2 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+		pm_nl_set_limits $NS1 2 2
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.3.1 flags signal
+		pm_nl_set_limits $NS2 2 2
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 least
 		chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
 		chk_add_nr 8 0
 	fi
 
 	# signal invalid addresses timeout
 	if reset_with_add_addr_timeout; then
-		pm_nl_set_limits $ns1 2 2
-		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+		pm_nl_set_limits $NS1 2 2
+		pm_nl_add_endpoint $NS1 10.0.12.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.3.1 flags signal
+		pm_nl_set_limits $NS2 2 2
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 least
 		chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -1530,31 +1550,31 @@ remove_tests()
 {
 	# single subflow, remove
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 0 -1 slow
 		chk_join_nr "remove single subflow" 1 1 1
 		chk_rm_nr 1 1
 	fi
 
 	# multiple subflows, remove
 	if reset; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_set_limits $NS2 0 2
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 0 -2 slow
 		chk_join_nr "remove multiple subflows" 2 2 2
 		chk_rm_nr 2 2
 	fi
 
 	# single address, remove
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_set_limits $NS2 1 1
+		run_tests $NS1 $NS2 10.0.1.1 0 -1 0 slow
 		chk_join_nr "remove single address" 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -1562,11 +1582,11 @@ remove_tests()
 
 	# subflow and signal, remove
 	if reset; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_set_limits $ns2 1 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_set_limits $NS2 1 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 -1 -1 slow
 		chk_join_nr "remove subflow and signal" 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -1574,12 +1594,12 @@ remove_tests()
 
 	# subflows and signal, remove
 	if reset; then
-		pm_nl_set_limits $ns1 0 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
+		pm_nl_set_limits $NS1 0 3
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_set_limits $NS2 1 3
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.4.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 -1 -2 slow
 		chk_join_nr "remove subflows and signal" 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -1587,12 +1607,12 @@ remove_tests()
 
 	# addresses remove
 	if reset; then
-		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
-		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
+		pm_nl_set_limits $NS1 3 3
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal id 250
+		pm_nl_add_endpoint $NS1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.4.1 flags signal
+		pm_nl_set_limits $NS2 3 3
+		run_tests $NS1 $NS2 10.0.1.1 0 -3 0 slow
 		chk_join_nr "remove addresses" 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -1600,12 +1620,12 @@ remove_tests()
 
 	# invalid addresses remove
 	if reset; then
-		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
-		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
+		pm_nl_set_limits $NS1 3 3
+		pm_nl_add_endpoint $NS1 10.0.12.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.14.1 flags signal
+		pm_nl_set_limits $NS2 3 3
+		run_tests $NS1 $NS2 10.0.1.1 0 -3 0 slow
 		chk_join_nr "remove invalid addresses" 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -1613,12 +1633,12 @@ remove_tests()
 
 	# subflows and signal, flush
 	if reset; then
-		pm_nl_set_limits $ns1 0 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		pm_nl_set_limits $NS1 0 3
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_set_limits $NS2 1 3
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.4.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 -8 -8 slow
 		chk_join_nr "flush subflows and signal" 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -1626,24 +1646,24 @@ remove_tests()
 
 	# subflows flush
 	if reset; then
-		pm_nl_set_limits $ns1 3 3
-		pm_nl_set_limits $ns2 3 3
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		pm_nl_set_limits $NS1 3 3
+		pm_nl_set_limits $NS2 3 3
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags subflow id 150
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.4.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 -8 -8 slow
 		chk_join_nr "flush subflows" 3 3 3
 		chk_rm_nr 3 3
 	fi
 
 	# addresses flush
 	if reset; then
-		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
-		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		pm_nl_set_limits $NS1 3 3
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal id 250
+		pm_nl_add_endpoint $NS1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.4.1 flags signal
+		pm_nl_set_limits $NS2 3 3
+		run_tests $NS1 $NS2 10.0.1.1 0 -8 -8 slow
 		chk_join_nr "flush addresses" 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -1651,12 +1671,12 @@ remove_tests()
 
 	# invalid addresses flush
 	if reset; then
-		pm_nl_set_limits $ns1 3 3
-		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
-		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
+		pm_nl_set_limits $NS1 3 3
+		pm_nl_add_endpoint $NS1 10.0.12.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $NS1 10.0.14.1 flags signal
+		pm_nl_set_limits $NS2 3 3
+		run_tests $NS1 $NS2 10.0.1.1 0 -8 0 slow
 		chk_join_nr "flush invalid addresses" 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -1664,20 +1684,20 @@ remove_tests()
 
 	# remove id 0 subflow
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 0 -9 slow
 		chk_join_nr "remove id 0 subflow" 1 1 1
 		chk_rm_nr 1 1
 	fi
 
 	# remove id 0 address
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_set_limits $NS2 1 1
+		run_tests $NS1 $NS2 10.0.1.1 0 -9 0 slow
 		chk_join_nr "remove id 0 address" 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -1688,42 +1708,42 @@ add_tests()
 {
 	# add single subflow
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		run_tests $NS1 $NS2 10.0.1.1 0 0 1 slow
 		chk_join_nr "add single subflow" 1 1 1
 	fi
 
 	# add signal address
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 1 1
+		run_tests $NS1 $NS2 10.0.1.1 0 1 0 slow
 		chk_join_nr "add signal address" 1 1 1
 		chk_add_nr 1 1
 	fi
 
 	# add multiple subflows
 	if reset; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_set_limits $NS2 0 2
+		run_tests $NS1 $NS2 10.0.1.1 0 0 2 slow
 		chk_join_nr "add multiple subflows" 2 2 2
 	fi
 
 	# add multiple subflows IPv6
 	if reset; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_set_limits $NS2 0 2
+		run_tests $NS1 $NS2 dead:beef:1::1 0 0 2 slow
 		chk_join_nr "add multiple subflows IPv6" 2 2 2
 	fi
 
 	# add multiple addresses IPv6
 	if reset; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_set_limits $NS2 2 2
+		run_tests $NS1 $NS2 dead:beef:1::1 0 2 0 slow
 		chk_join_nr "add multiple addresses IPv6" 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -1733,37 +1753,37 @@ ipv6_tests()
 {
 	# subflow IPv6
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 dead:beef:3::2 dev ns2eth3 flags subflow
+		run_tests $NS1 $NS2 dead:beef:1::1 0 0 0 slow
 		chk_join_nr "single subflow IPv6" 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset; then
-		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		pm_nl_add_endpoint $NS1 dead:beef:2::1 flags signal
+		run_tests $NS1 $NS2 dead:beef:1::1 0 0 0 slow
 		chk_join_nr "unused signal address IPv6" 0 0 0
 		chk_add_nr 1 1
 	fi
 
 	# signal address IPv6
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_add_endpoint $NS1 dead:beef:2::1 flags signal
+		pm_nl_set_limits $NS2 1 1
+		run_tests $NS1 $NS2 dead:beef:1::1 0 0 0 slow
 		chk_join_nr "single address IPv6" 1 1 1
 		chk_add_nr 1 1
 	fi
 
 	# single address IPv6, remove
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_add_endpoint $NS1 dead:beef:2::1 flags signal
+		pm_nl_set_limits $NS2 1 1
+		run_tests $NS1 $NS2 dead:beef:1::1 0 -1 0 slow
 		chk_join_nr "remove single address IPv6" 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -1771,11 +1791,11 @@ ipv6_tests()
 
 	# subflow and signal IPv6, remove
 	if reset; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		pm_nl_set_limits $ns2 1 2
-		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_add_endpoint $NS1 dead:beef:2::1 flags signal
+		pm_nl_set_limits $NS2 1 2
+		pm_nl_add_endpoint $NS2 dead:beef:3::2 dev ns2eth3 flags subflow
+		run_tests $NS1 $NS2 dead:beef:1::1 0 -1 -1 slow
 		chk_join_nr "remove subflow and signal IPv6" 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -1786,85 +1806,85 @@ v4mapped_tests()
 {
 	# subflow IPv4-mapped to IPv4-mapped
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
-		run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 "::ffff:10.0.3.2" flags subflow
+		run_tests $NS1 $NS2 "::ffff:10.0.1.1"
 		chk_join_nr "single subflow IPv4-mapped" 1 1 1
 	fi
 
 	# signal address IPv4-mapped with IPv4-mapped sk
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
-		run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS1 "::ffff:10.0.2.1" flags signal
+		run_tests $NS1 $NS2 "::ffff:10.0.1.1"
 		chk_join_nr "signal address IPv4-mapped" 1 1 1
 		chk_add_nr 1 1
 	fi
 
 	# subflow v4-map-v6
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 "::ffff:10.0.1.1"
 		chk_join_nr "single subflow v4-map-v6" 1 1 1
 	fi
 
 	# signal address v4-map-v6
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 "::ffff:10.0.1.1"
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 "::ffff:10.0.1.1"
 		chk_join_nr "signal address v4-map-v6" 1 1 1
 		chk_add_nr 1 1
 	fi
 
 	# subflow v6-map-v4
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 "::ffff:10.0.3.2" flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "single subflow v6-map-v4" 1 1 1
 	fi
 
 	# signal address v6-map-v4
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS1 "::ffff:10.0.2.1" flags signal
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "signal address v6-map-v4" 1 1 1
 		chk_add_nr 1 1
 	fi
 
 	# no subflow IPv6 to v4 address
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 dead:beef:2::2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
 	fi
 
 	# no subflow IPv6 to v4 address even if v6 has a valid v4 at the end
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 dead:beef:2::10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 dead:beef:2::10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "no JOIN with diff families v4-v6-2" 0 0 0
 	fi
 
 	# no subflow IPv4 to v6 address, no need to slow down too then
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 dead:beef:1::1
 		chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
 	fi
 }
@@ -1873,20 +1893,20 @@ backup_tests()
 {
 	# single subflow, backup
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow,backup
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 slow nobackup
 		chk_join_nr "single subflow, backup" 1 1 1
 		chk_prio_nr 0 1
 	fi
 
 	# single address, backup
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_set_limits $NS2 1 1
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr "single address, backup" 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 0
@@ -1894,10 +1914,10 @@ backup_tests()
 
 	# single address with port, backup
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
-		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal port 10100
+		pm_nl_set_limits $NS2 1 1
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr "single address with port, backup" 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 0
@@ -1908,31 +1928,31 @@ add_addr_ports_tests()
 {
 	# signal address with port
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal port 10100
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "signal address with port" 1 1 1
 		chk_add_nr 1 1 1
 	fi
 
 	# subflow and signal with port
 	if reset; then
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 1 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal port 10100
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_set_limits $NS2 1 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "subflow and signal with port" 2 2 2
 		chk_add_nr 1 1 1
 	fi
 
 	# single address with port, remove
 	if reset; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
-		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal port 10100
+		pm_nl_set_limits $NS2 1 1
+		run_tests $NS1 $NS2 10.0.1.1 0 -1 0 slow
 		chk_join_nr "remove single address with port" 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -1940,11 +1960,11 @@ add_addr_ports_tests()
 
 	# subflow and signal with port, remove
 	if reset; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
-		pm_nl_set_limits $ns2 1 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal port 10100
+		pm_nl_set_limits $NS2 1 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 -1 -1 slow
 		chk_join_nr "remove subflow and signal with port" 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
@@ -1952,12 +1972,12 @@ add_addr_ports_tests()
 
 	# subflows and signal with port, flush
 	if reset; then
-		pm_nl_set_limits $ns1 0 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
-		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
+		pm_nl_set_limits $NS1 0 3
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal port 10100
+		pm_nl_set_limits $NS2 1 3
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.4.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 -8 -2 slow
 		chk_join_nr "flush subflows and signal with port" 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -1965,22 +1985,22 @@ add_addr_ports_tests()
 
 	# multiple addresses with port
 	if reset; then
-		pm_nl_set_limits $ns1 2 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10100
-		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 2 2
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal port 10100
+		pm_nl_add_endpoint $NS1 10.0.3.1 flags signal port 10100
+		pm_nl_set_limits $NS2 2 2
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "multiple addresses with port" 2 2 2
 		chk_add_nr 2 2 2
 	fi
 
 	# multiple addresses with ports
 	if reset; then
-		pm_nl_set_limits $ns1 2 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10101
-		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 2 2
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal port 10100
+		pm_nl_add_endpoint $NS1 10.0.3.1 flags signal port 10101
+		pm_nl_set_limits $NS2 2 2
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "multiple addresses with ports" 2 2 2
 		chk_add_nr 2 2 2
 	fi
@@ -1990,62 +2010,62 @@ syncookies_tests()
 {
 	# single subflow, syncookies
 	if reset_with_cookies; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "single subflow with syn cookies" 1 1 1
 	fi
 
 	# multiple subflows with syn cookies
 	if reset_with_cookies; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_set_limits $NS2 0 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "multiple subflows with syn cookies" 2 2 2
 	fi
 
 	# multiple subflows limited by server
 	if reset_with_cookies; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "subflows limited by server w cookies" 2 1 1
 	fi
 
 	# test signal address with cookies
 	if reset_with_cookies; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "signal address with syn cookies" 1 1 1
 		chk_add_nr 1 1
 	fi
 
 	# test cookie with subflow and signal
 	if reset_with_cookies; then
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 1 2
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_set_limits $NS1 0 2
+		pm_nl_set_limits $NS2 1 2
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "subflow and signal w cookies" 2 2 2
 		chk_add_nr 1 1
 	fi
 
 	# accept and use add_addr with additional subflows
 	if reset_with_cookies; then
-		pm_nl_set_limits $ns1 0 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 3
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_set_limits $NS2 1 3
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $NS2 10.0.4.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "subflows and signal w. cookies" 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -2055,33 +2075,33 @@ checksum_tests()
 {
 	# checksum test 0 0
 	if reset_with_checksum 0 0; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_csum_nr "checksum test 0 0"
 	fi
 
 	# checksum test 1 1
 	if reset_with_checksum 1 1; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_csum_nr "checksum test 1 1"
 	fi
 
 	# checksum test 0 1
 	if reset_with_checksum 0 1; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_csum_nr "checksum test 0 1"
 	fi
 
 	# checksum test 1 0
 	if reset_with_checksum 1 0; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 0 1
+		pm_nl_set_limits $NS2 0 1
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_csum_nr "checksum test 1 0"
 	fi
 }
@@ -2090,29 +2110,29 @@ deny_join_id0_tests()
 {
 	# subflow allow join id0 ns1
 	if reset_with_allow_join_id0 1 0; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 1 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "single subflow allow join id0 ns1" 1 1 1
 	fi
 
 	# subflow allow join id0 ns2
 	if reset_with_allow_join_id0 0 1; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 1 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "single subflow allow join id0 ns2" 0 0 0
 	fi
 
 	# signal address allow join id0 ns1
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	if reset_with_allow_join_id0 1 0; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 1 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "signal address allow join id0 ns1" 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2120,31 +2140,31 @@ deny_join_id0_tests()
 	# signal address allow join id0 ns2
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	if reset_with_allow_join_id0 0 1; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 1 1
+		pm_nl_set_limits $NS2 1 1
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "signal address allow join id0 ns2" 1 1 1
 		chk_add_nr 1 1
 	fi
 
 	# subflow and address allow join id0 ns1
 	if reset_with_allow_join_id0 1 0; then
-		pm_nl_set_limits $ns1 2 2
-		pm_nl_set_limits $ns2 2 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 2 2
+		pm_nl_set_limits $NS2 2 2
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "subflow and address allow join id0 1" 2 2 2
 	fi
 
 	# subflow and address allow join id0 ns2
 	if reset_with_allow_join_id0 0 1; then
-		pm_nl_set_limits $ns1 2 2
-		pm_nl_set_limits $ns2 2 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		pm_nl_set_limits $NS1 2 2
+		pm_nl_set_limits $NS2 2 2
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "subflow and address allow join id0 2" 1 1 1
 	fi
 }
@@ -2155,11 +2175,11 @@ fullmesh_tests()
 	# 2 fullmesh addrs in ns2, added before the connection,
 	# 1 non-fullmesh addr in ns1, added during the connection.
 	if reset; then
-		pm_nl_set_limits $ns1 0 4
-		pm_nl_set_limits $ns2 1 4
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		pm_nl_set_limits $NS1 0 4
+		pm_nl_set_limits $NS2 1 4
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags subflow,fullmesh
+		pm_nl_add_endpoint $NS2 10.0.3.2 flags subflow,fullmesh
+		run_tests $NS1 $NS2 10.0.1.1 0 1 0 slow
 		chk_join_nr "fullmesh test 2x1" 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -2168,10 +2188,10 @@ fullmesh_tests()
 	# 1 non-fullmesh addr in ns1, added before the connection,
 	# 1 fullmesh addr in ns2, added during the connection.
 	if reset; then
-		pm_nl_set_limits $ns1 1 3
-		pm_nl_set_limits $ns2 1 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
+		pm_nl_set_limits $NS1 1 3
+		pm_nl_set_limits $NS2 1 3
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 10.0.1.1 0 0 fullmesh_1 slow
 		chk_join_nr "fullmesh test 1x1" 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -2180,10 +2200,10 @@ fullmesh_tests()
 	# 1 non-fullmesh addr in ns1, added before the connection,
 	# 2 fullmesh addrs in ns2, added during the connection.
 	if reset; then
-		pm_nl_set_limits $ns1 2 5
-		pm_nl_set_limits $ns2 1 5
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		pm_nl_set_limits $NS1 2 5
+		pm_nl_set_limits $NS2 1 5
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 10.0.1.1 0 0 fullmesh_2 slow
 		chk_join_nr "fullmesh test 1x2" 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -2193,40 +2213,40 @@ fullmesh_tests()
 	# 2 fullmesh addrs in ns2, added during the connection,
 	# limit max_subflows to 4.
 	if reset; then
-		pm_nl_set_limits $ns1 2 4
-		pm_nl_set_limits $ns2 1 4
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		pm_nl_set_limits $NS1 2 4
+		pm_nl_set_limits $NS2 1 4
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 10.0.1.1 0 0 fullmesh_2 slow
 		chk_join_nr "fullmesh test 1x2, limited" 4 4 4
 		chk_add_nr 1 1
 	fi
 
 	# set fullmesh flag
 	if reset; then
-		pm_nl_set_limits $ns1 4 4
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
-		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+		pm_nl_set_limits $NS1 4 4
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags subflow
+		pm_nl_set_limits $NS2 4 4
+		run_tests $NS1 $NS2 10.0.1.1 0 0 1 slow fullmesh
 		chk_join_nr "set fullmesh flag test" 2 2 2
 		chk_rm_nr 0 1
 	fi
 
 	# set nofullmesh flag
 	if reset; then
-		pm_nl_set_limits $ns1 4 4
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
-		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+		pm_nl_set_limits $NS1 4 4
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags subflow,fullmesh
+		pm_nl_set_limits $NS2 4 4
+		run_tests $NS1 $NS2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
 		chk_join_nr "set nofullmesh flag test" 2 2 2
 		chk_rm_nr 0 1
 	fi
 
 	# set backup,fullmesh flags
 	if reset; then
-		pm_nl_set_limits $ns1 4 4
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
-		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
+		pm_nl_set_limits $NS1 4 4
+		pm_nl_add_endpoint $NS1 10.0.2.1 flags subflow
+		pm_nl_set_limits $NS2 4 4
+		run_tests $NS1 $NS2 10.0.1.1 0 0 1 slow backup,fullmesh
 		chk_join_nr "set backup,fullmesh flags test" 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -2234,10 +2254,10 @@ fullmesh_tests()
 
 	# set nobackup,nofullmesh flags
 	if reset; then
-		pm_nl_set_limits $ns1 4 4
-		pm_nl_set_limits $ns2 4 4
-		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
+		pm_nl_set_limits $NS1 4 4
+		pm_nl_set_limits $NS2 4 4
+		pm_nl_add_endpoint $NS2 10.0.2.2 flags subflow,backup,fullmesh
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
 		chk_join_nr "set nobackup,nofullmesh flags test" 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -2248,65 +2268,65 @@ userspace_tests()
 {
 	# userspace pm type prevents add_addr
 	if reset; then
-		ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
-		ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-		ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-		ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
+		ip netns exec $NS1 sysctl -q net.mptcp.pm_type=1
+		ip netns exec $NS1 ./pm_nl_ctl limits 0 2
+		ip netns exec $NS2 ./pm_nl_ctl limits 0 2
+		ip netns exec $NS1 ./pm_nl_ctl add 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "userspace pm type prevents add_addr" 0 0 0
 		chk_add_nr 0 0
 	fi
 
 	# userspace pm type echoes add_addr
 	if reset; then
-		ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
-		ip netns exec $ns1 ./pm_nl_ctl limits 0 2
-		ip netns exec $ns2 ./pm_nl_ctl limits 0 2
-		ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
+		ip netns exec $NS2 sysctl -q net.mptcp.pm_type=1
+		ip netns exec $NS1 ./pm_nl_ctl limits 0 2
+		ip netns exec $NS2 ./pm_nl_ctl limits 0 2
+		ip netns exec $NS1 ./pm_nl_ctl add 10.0.2.1 flags signal
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "userspace pm type echoes add_addr" 0 0 0
 		chk_add_nr 1 1
 	fi
 
 	# userspace pm type rejects join
 	if reset; then
-		ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
-		ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-		ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-		ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		ip netns exec $NS1 sysctl -q net.mptcp.pm_type=1
+		ip netns exec $NS1 ./pm_nl_ctl limits 1 1
+		ip netns exec $NS2 ./pm_nl_ctl limits 1 1
+		ip netns exec $NS2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "userspace pm type rejects join" 1 1 0
 	fi
 
 	# userspace pm type does not send join
 	if reset; then
-		ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
-		ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-		ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-		ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
+		ip netns exec $NS2 sysctl -q net.mptcp.pm_type=1
+		ip netns exec $NS1 ./pm_nl_ctl limits 1 1
+		ip netns exec $NS2 ./pm_nl_ctl limits 1 1
+		ip netns exec $NS2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1
 		chk_join_nr "userspace pm type does not send join" 0 0 0
 	fi
 
 	# userspace pm type prevents mp_prio
 	if reset; then
-		ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
-		ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-		ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-		ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		ip netns exec $NS1 sysctl -q net.mptcp.pm_type=1
+		ip netns exec $NS1 ./pm_nl_ctl limits 1 1
+		ip netns exec $NS2 ./pm_nl_ctl limits 1 1
+		ip netns exec $NS2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
 		chk_prio_nr 0 0
 	fi
 
 	# userspace pm type prevents rm_addr
 	if reset; then
-		ip netns exec $ns1 sysctl -q net.mptcp.pm_type=1
-		ip netns exec $ns2 sysctl -q net.mptcp.pm_type=1
-		ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-		ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-		ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		ip netns exec $NS1 sysctl -q net.mptcp.pm_type=1
+		ip netns exec $NS2 sysctl -q net.mptcp.pm_type=1
+		ip netns exec $NS1 ./pm_nl_ctl limits 0 1
+		ip netns exec $NS2 ./pm_nl_ctl limits 0 1
+		ip netns exec $NS2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+		run_tests $NS1 $NS2 10.0.1.1 0 0 -1 slow
 		chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
 		chk_rm_nr 0 0
 	fi
@@ -2337,7 +2357,7 @@ usage()
 {
 	if [ -n "${1}" ]; then
 		echo "${1}"
-		ret=1
+		RET=1
 	fi
 
 	echo "mptcp_join usage:"
@@ -2362,19 +2382,19 @@ usage()
 	echo "  -i use ip mptcp"
 	echo "  -h help"
 
-	exit ${ret}
+	exit ${RET}
 }
 
 for arg in "$@"; do
 	# check for "capture/checksum" args before launching tests
 	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"c"[0-9a-zA-Z]*$ ]]; then
-		capture=1
+		CAPTURE=1
 	fi
 	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
-		checksum=1
+		CHECKSUM=1
 	fi
 	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"i"[0-9a-zA-Z]*$ ]]; then
-		ip_mptcp=1
+		IP_MPTCP=1
 	fi
 
 	# exception for the capture/checksum/ip_mptcp options, the rest means: a part of the tests
@@ -2385,13 +2405,13 @@ for arg in "$@"; do
 			usage "Unknown option: ${arg}"
 		fi
 	elif ! [[ "${arg}" =~ ^"-"[cCi]+$ ]]; then
-		do_all_tests=0
+		DO_ALL_TESTS=0
 	fi
 done
 
-if [ $do_all_tests -eq 1 ]; then
+if [ $DO_ALL_TESTS -eq 1 ]; then
 	all_tests
-	exit $ret
+	exit $RET
 fi
 
 while getopts 'fesltra64bpkdmuchCSi' opt; do
@@ -2459,4 +2479,4 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
 	esac
 done
 
-exit $ret
+exit $RET
-- 
2.34.1

