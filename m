Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CC72
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626210843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPBautzTOuS5BpwfH1oqp3eSqExqXoxHZoYIlcn3VnU=;
	b=iFAKD/WGYDDS8yPU8WLFJUqfXmTJkzkMNfA9ZhDME58lo4j+s7nB6OKbDO729soW3DmV9t
	QrQwzVYploWxkpTqu3VzdFQ2YoeLkrcm7SvG8iLairdvx50TrhRUv4Da4ONVTiHUF11pwb
	0SknE3Dmf3skJdJdn/H3YpUzoTwPFcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-y67EcRU9P2uLBaMnI4joNg-1; Tue, 13 Jul 2021 17:14:01 -0400
X-MC-Unique: y67EcRU9P2uLBaMnI4joNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16BDC804141
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:14:01 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-114.ams2.redhat.com [10.36.113.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 029AA60C5F
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 8/8] selftests: mptcp: add testcase for active-back
Date: Tue, 13 Jul 2021 23:13:38 +0200
Message-Id: <72c1cfa2b73bcb563f7ccc7f6fba4f8eaf3ac3b6.1626210682.git.pabeni@redhat.com>
In-Reply-To: <cover.1626210682.git.pabeni@redhat.com>
References: <cover.1626210682.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Add more test-case for link failures scenario,
including recovery from link failure using only
backup subflows and bi-directional transfer.

Additionally explicitly check for stale count

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 v1 -> v2:
 -  address recurrent self-tests failures:
    must be less stringent for bidirectionl tests
 -  add shapers, to allow the scheduler using
    all the virtual links
 - reduce the link failure test file size, to
   keep the test run-time almost reasonable
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 215 +++++++++++++++---
 1 file changed, 184 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f02f4de2f3a0..220154cb92a7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3,8 +3,10 @@
 
 ret=0
 sin=""
+sinfail=""
 sout=""
 cin=""
+cinfail=""
 cinsent=""
 cout=""
 ksft_skip=4
@@ -76,6 +78,14 @@ init()
 	done
 }
 
+init_shapers()
+{
+	for i in `seq 1 4`; do
+		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1
+		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1
+	done
+}
+
 cleanup_partial()
 {
 	rm -f "$capout"
@@ -88,8 +98,8 @@ cleanup_partial()
 
 cleanup()
 {
-	rm -f "$cin" "$cout"
-	rm -f "$sin" "$sout" "$cinsent"
+	rm -f "$cin" "$cout" "$sinfail"
+	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	cleanup_partial
 }
 
@@ -211,11 +221,16 @@ link_failure()
 {
 	ns="$1"
 
-	l=$((RANDOM%4))
-	l=$((l+1))
+	if [ -z "$FAILING_LINKS" ]; then
+		l=$((RANDOM%4))
+		FAILING_LINKS=$((l+1))
+	fi
 
-	veth="ns1eth$l"
-	ip -net "$ns" link set "$veth" down
+	for l in $FAILING_LINKS; do
+		veth="ns1eth$l"
+		echo "link $veth down" 1>&2
+		ip -net "$ns" link set "$veth" down
+	done
 }
 
 # $1: IP address
@@ -280,10 +295,17 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
-	timeout ${timeout_test} \
-		ip netns exec ${listener_ns} \
-			$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-				${local_addr} < "$sin" > "$sout" &
+	if [ "$test_link_fail" -eq 2 ];then
+		timeout ${timeout_test} \
+			ip netns exec ${listener_ns} \
+				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${cl_proto} \
+					${local_addr} < "$sinfail" > "$sout" &
+	else
+		timeout ${timeout_test} \
+			ip netns exec ${listener_ns} \
+				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					${local_addr} < "$sin" > "$sout" &
+	fi
 	spid=$!
 
 	sleep 1
@@ -294,7 +316,7 @@ do_transfer()
 				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$connect_addr < "$cin" > "$cout" &
 	else
-		( cat "$cin" ; sleep 2; link_failure $listener_ns ; cat "$cin" ) | \
+		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
@@ -434,7 +456,11 @@ do_transfer()
 		return 1
 	fi
 
-	check_transfer $sin $cout "file received by client"
+	if [ "$test_link_fail" -eq 2 ];then
+		check_transfer $sinfail $cout "file received by client"
+	else
+		check_transfer $sin $cout "file received by client"
+	fi
 	retc=$?
 	if [ "$test_link_fail" -eq 0 ];then
 		check_transfer $cin $sout "file received by server"
@@ -477,29 +503,29 @@ run_tests()
 	lret=0
 	oldin=""
 
-	if [ "$test_linkfail" -eq 1 ];then
-		size=$((RANDOM%1024))
+	# create the input file for the failure test when
+	# the first failure test run
+	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+		size=$((RANDOM%8))
 		size=$((size+1))
-		size=$((size*128))
+		size=$((size*2048))
 
-		oldin=$(mktemp)
-		cp "$cin" "$oldin"
-		make_file "$cin" "client" $size
+		cinfail=$(mktemp)
+		make_file "$cinfail" "client" $size
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${bkup}
-	lret=$?
+	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+		size=$((RANDOM%16))
+		size=$((size+1))
+		size=$((size*2048))
 
-	if [ "$test_linkfail" -eq 1 ];then
-		cp "$oldin" "$cin"
-		rm -f "$oldin"
+		sinfail=$(mktemp)
+		make_file "$sinfail" "server" $size
 	fi
 
-	if [ $lret -ne 0 ]; then
-		ret=$lret
-		return
-	fi
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
+		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${bkup}
+	lret=$?
 }
 
 chk_csum_nr()
@@ -593,6 +619,46 @@ chk_join_nr()
 	fi
 }
 
+# a negative value for 'stale_max' means no upper bound:
+# for bidirectional transfer, if one peer sleep for a while
+# - as these tests do - we can have a quite high number of
+# stale/recover conversions, proportional to
+# sleep duration/ MPTCP-level RTX interval.
+chk_stale_nr()
+{
+	local ns=$1
+	local stale_min=$2
+	local stale_max=$3
+	local stale_delta=$4
+	local dump_stats
+	local stale_nr
+	local recover_nr
+
+	printf "%-39s %s" " " "stale"
+	stale_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}'`
+	[ -z "$stale_nr" ] && stale_nr=0
+	recover_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}'`
+	[ -z "$recover_nr" ] && recover_nr=0
+
+	if [ $stale_nr -lt $stale_min ] ||
+	   [ $stale_max -gt 0 -a $stale_nr -gt $stale_max ] ||
+	   [ $((stale_nr - $recover_nr)) -ne $stale_delta ]; then
+		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
+		     " expected stale in range [$stale_min..$stale_max]," \
+		     " stale-recover delta $stale_delta "
+		ret=1
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
+	if [ "${dump_stats}" = 1 ]; then
+		echo $ns stats
+		ip netns exec $ns ip -s link show
+		ip netns exec $ns nstat -as | grep MPTcp
+	fi
+}
+
 chk_add_nr()
 {
 	local add_nr=$1
@@ -801,6 +867,27 @@ chk_prio_nr()
 	fi
 }
 
+chk_link_usage()
+{
+	local ns=$1
+	local link=$2
+	local out=$3
+	local expected_rate=$4
+	local tx_link=`ip netns exec $ns cat /sys/class/net/$link/statistics/tx_bytes`
+	local tx_total=`ls -l $out | awk '{print $5}'`
+	local tx_rate=$((tx_link * 100 / $tx_total))
+	local tolerance=5
+
+	printf "%-39s %s" " " "link usage "
+	if [ $tx_rate -lt $((expected_rate - $tolerance)) -o \
+	     $tx_rate -gt $((expected_rate + $tolerance)) ]; then
+		echo "[fail] got $tx_rate% usage, expected $expected_rate%"
+		ret=1
+	else
+		echo "[ ok ]"
+	fi
+}
+
 subflows_tests()
 {
 	reset
@@ -924,14 +1011,80 @@ link_failure_tests()
 {
 	# accept and use add_addr with additional subflows and link loss
 	reset
+
+	# without any b/w limit each veth could spool the packets and get
+	# them acked at xmit time, so that the corresponding subflow will
+	# have almost always no outstanding pkts, the scheduler will pick
+	# always the first subflow and we will have hard time testing
+	# active backup and link switch-over.
+	# Let's set some arbitrary (low) virtual link limits.
+	init_shapers
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "multiple flows, signal, link failure" 3 3 3
 	chk_add_nr 1 1
+	chk_stale_nr $ns2 1 5 1
+
+	# accept and use add_addr with additional subflows and link loss
+	# for bidirectional transfer
+	reset
+	init_shapers
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 2
+	chk_join_nr "multiple flows, signal, bidirectional, link failure" 3 3 3
+	chk_add_nr 1 1
+	chk_stale_nr $ns2 1 -1 1
+
+	# 2 subflows plus 1 backup subflow with a lossy link, backup
+	# will never be used
+	reset
+	init_shapers
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	export FAILING_LINKS="1"
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,backup
+	run_tests $ns1 $ns2 10.0.1.1 1
+	chk_join_nr "backup subflow unused with link failure" 2 2 2
+	chk_add_nr 1 1
+	chk_link_usage $ns2 ns2eth3 $cinsent 0
+
+	# 2 lossy links after half transfer, backup will get half of
+	# the traffic
+	reset
+	init_shapers
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,backup
+	export FAILING_LINKS="1 2"
+	run_tests $ns1 $ns2 10.0.1.1 1
+	chk_join_nr "backup subflow used due to multiple links failure" 2 2 2
+	chk_add_nr 1 1
+	chk_stale_nr $ns2 2 4 2
+	chk_link_usage $ns2 ns2eth3 $cinsent 50
+
+	# use a backup subflow with the first subflow on a lossy link
+	# for bidirectional transfer
+	reset
+	init_shapers
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,backup
+	run_tests $ns1 $ns2 10.0.1.1 2
+	chk_join_nr "backup subflow in use, bidirectional, link failure" 2 2 2
+	chk_add_nr 1 1
+	chk_stale_nr $ns2 1 -1 2
+	chk_link_usage $ns2 ns2eth3 $cinsent 50
 }
 
 add_addr_timeout_tests()
-- 
2.26.3

