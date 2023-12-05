Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ABE15AE0
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VacR5rKy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLWlw9kCStkH55fdtncu2jMZAMEEfZIP3ZEj82wrtro=;
	b=VacR5rKyTMF0uDuUHKRJxLHOKG4vyuErt9TtuW/7d2gAWSfNcfs5o/ZCkr0dyHV+WCLdmg
	ABwOLC8rLQ1+y3CDfEcGiCPbqI504OKoq4mjcQl2I3f3YwgccB+dlbumSVBi6bwXNePC5z
	Q0q2YmTxiFJRIG1iZ13xK53I3STKvUU=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 08/33] selftests: mptcp: unify namespace names
Date: Tue,  5 Dec 2023 15:00:55 +0800
Message-Id: <1fafc3ec9a3561270ee86e75cb0bb140d92890f8.1701759405.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1701759405.git.geliang.tang@linux.dev>
References: <cover.1701759405.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Most scripts use ns1, ns2, ns3 and ns4 as namespace names, but ns and
ns_sbox are used in diag.sh and mptcp_sockopt.sh. To maintain consistency
with other scripts, this patch renames these variables:

    ns        -> ns1         in diag.sh
    ns_sbox   -> ns3         in mptcp_sockopt.sh

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 46 +++++++++----------
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 12 ++---
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 300aec419dd6..bc3f24c454be 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns="ns1-$rndh"
+ns1="ns1-$rndh"
 ksft_skip=4
 test_cnt=1
 timeout_poll=100
@@ -17,19 +17,19 @@ flush_pids()
 	# give it some time
 	sleep 1.1
 
-	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
+	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
 
 	for _ in $(seq 10); do
-		[ -z "$(ip netns pids "${ns}")" ] && break
+		[ -z "$(ip netns pids "${ns1}")" ] && break
 		sleep 0.1
 	done
 }
 
 cleanup()
 {
-	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
+	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
-	ip netns del $ns
+	ip netns del $ns1
 	mptcp_lib_cleanup
 }
 
@@ -48,7 +48,7 @@ fi
 
 get_msk_inuse()
 {
-	ip netns exec $ns cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
+	ip netns exec $ns1 cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
 }
 
 __chk_nr()
@@ -83,7 +83,7 @@ __chk_msk_nr()
 	local condition=$1
 	shift 1
 
-	__chk_nr "ss -inmHMN $ns | $condition" "$@"
+	__chk_nr "ss -inmHMN $ns1 | $condition" "$@"
 }
 
 chk_msk_nr()
@@ -104,7 +104,7 @@ wait_msk_nr()
 	msg=$*
 
 	while [ $i -lt $timeout ]; do
-		nr=$(ss -inmHMN $ns | $condition)
+		nr=$(ss -inmHMN $ns1 | $condition)
 		[ $nr == $expected ] && break;
 		[ $nr -gt $max ] && max=$nr
 		i=$((i + 1))
@@ -143,7 +143,7 @@ __chk_listen()
 	local expected=$2
 	local msg="$3"
 
-	__chk_nr "ss -N $ns -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
+	__chk_nr "ss -N $ns1 -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
 }
 
 chk_msk_listen()
@@ -169,7 +169,7 @@ chk_msk_inuse()
 	local msg="$2"
 	local listen_nr
 
-	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
+	listen_nr=$(ss -N "${ns1}" -Ml | grep -c LISTEN)
 	expected=$((expected + listen_nr))
 
 	for _ in $(seq 10); do
@@ -197,24 +197,24 @@ wait_connected()
 }
 
 trap cleanup EXIT
-ip netns add $ns
-ip -n $ns link set dev lo up
+ip netns add $ns1
+ip -n $ns1 link set dev lo up
 
 echo "a" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10000 -l -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-mptcp_lib_wait_local_port_listen $ns 10000
+mptcp_lib_wait_local_port_listen $ns1 10000
 chk_msk_nr 0 "no msk on netns creation"
 chk_msk_listen 10000
 
 echo "b" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10000 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
-wait_connected $ns 10000
+wait_connected $ns1 10000
 chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
@@ -225,16 +225,16 @@ chk_msk_inuse 0 "....chk 0 msk in use after flush"
 
 echo "a" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10001 -l -s TCP -t ${timeout_poll} -w 20 \
 				0.0.0.0 >/dev/null &
-mptcp_lib_wait_local_port_listen $ns 10001
+mptcp_lib_wait_local_port_listen $ns1 10001
 echo "b" | \
 	timeout ${timeout_test} \
-		ip netns exec $ns \
+		ip netns exec $ns1 \
 			./mptcp_connect -p 10001 -r 0 -t ${timeout_poll} -w 20 \
 				127.0.0.1 >/dev/null &
-wait_connected $ns 10001
+wait_connected $ns1 10001
 chk_msk_fallback_nr 1 "check fallback"
 chk_msk_inuse 1 "....chk 1 msk in use"
 flush_pids
@@ -245,16 +245,16 @@ NR_CLIENTS=100
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "a" | \
 		timeout ${timeout_test} \
-			ip netns exec $ns \
+			ip netns exec $ns1 \
 				./mptcp_connect -p $((I+10001)) -l -w 20 \
 					-t ${timeout_poll} 0.0.0.0 >/dev/null &
 done
-mptcp_lib_wait_local_port_listen $ns $((NR_CLIENTS + 10001))
+mptcp_lib_wait_local_port_listen $ns1 $((NR_CLIENTS + 10001))
 
 for I in `seq 1 $NR_CLIENTS`; do
 	echo "b" | \
 		timeout ${timeout_test} \
-			ip netns exec $ns \
+			ip netns exec $ns1 \
 				./mptcp_connect -p $((I+10001)) -w 20 \
 					-t ${timeout_poll} 127.0.0.1 >/dev/null &
 done
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 45e5b5810a6a..b82f7b0b85bc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -17,7 +17,7 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
-ns_sbox="ns_sbox-$rndh"
+ns3="ns3-$rndh"
 
 add_mark_rules()
 {
@@ -40,7 +40,7 @@ add_mark_rules()
 init()
 {
 	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox";do
+	for netns in "$ns1" "$ns2" "$ns3";do
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
@@ -79,7 +79,7 @@ init()
 cleanup()
 {
 	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox"; do
+	for netns in "$ns1" "$ns2" "$ns3"; do
 		ip netns del $netns
 	done
 	rm -f "$cin" "$cout"
@@ -240,7 +240,7 @@ do_mptcp_sockopt_tests()
 		return
 	fi
 
-	ip netns exec "$ns_sbox" ./mptcp_sockopt
+	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -251,7 +251,7 @@ do_mptcp_sockopt_tests()
 	fi
 	mptcp_lib_result_pass "sockopt v4"
 
-	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
+	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -282,7 +282,7 @@ run_tests()
 
 do_tcpinq_test()
 {
-	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
+	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-- 
2.35.3

