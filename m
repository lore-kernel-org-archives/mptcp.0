Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9D22098
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334989; cv=none; b=PTYRk/jnykA2JCFcd30cBO0IJlxb/HmulbL1poWjM9CAenRnjps1Z3hK11bxScfto0BHkHjbx7s+prYqK4/0vHORET9u1ou3HE0ci4XgswWcnPUyx/7OEYBbZJmY/1VrAbLRg/wo7GmUWbWGbhmZGrJ8AKUWaz4xYBGDRkSxfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334989; c=relaxed/simple;
	bh=xBJfR4p/erNifF7urg+dlUQATygfDOnlNGHA+M/fUY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A10qEj0diWxEyOCgxFgYvLIs+4mWA4w1jnTPIal7mWL2GgprQxbLoLPzjDNzwtssbIixEyY/+B6r3zq6dlbybi/du6BtsefTUFsPRCi5kis6729E3l9yfY0oUu4UcQS8mAHxJP32AGGuQvtd8kzTx0MSc7vUuPogjJX3hEkXmSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeTrQIXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeTrQIXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03013C433C7;
	Mon, 19 Feb 2024 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334989;
	bh=xBJfR4p/erNifF7urg+dlUQATygfDOnlNGHA+M/fUY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qeTrQIXh+Lcpc18W4pXSfzF0VC6piF5idDzNv01StogKs9KFhtQbpIDW048MQQ/RZ
	 FsSBqCho6CMzbNp90X2saiM+xC+bNr3dIyuwEJ2TB3vCjAm9mN6pvzcRHWkQuxTtRW
	 /wQKEcKMQNaqhZ+OHVagvH5Cpv1cpB0ZR1dzxx1MkbAArv1J3uOHCZomdzNunF5nH3
	 740Bh7PopJE4XuXGSaJTqMJ22H4m4eKMtuJwb8j/8ktxFfoq8vHavE1owR+XUUTOId
	 qtJGvjXPM+lPhTUX6Qn0wUHSN3u5k0ZLEf91+ZgDfoWuoeVwfcMiTmszp/q/gDdHJR
	 hZNraJ6oYhPNw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/5] selftests: mptcp: unify namespace names to ns1/2/3/4
Date: Mon, 19 Feb 2024 17:29:31 +0800
Message-Id: <c25c836349eff4348c67d17a36b779836173a177.1708334850.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708334850.git.tanggeliang@kylinos.cn>
References: <cover.1708334850.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Most scripts use ns1, ns2, ns3 and ns4 as namespace names, but ns and
ns_sbox are used in diag.sh and mptcp_sockopt.sh. To maintain consistency
with other scripts, this patch renames these variables:

    ns        -> ns1         in diag.sh
    ns_sbox   -> ns3         in mptcp_sockopt.sh

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh     | 48 +++++++++----------
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 12 ++---
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 60a7009ce1b5..e91dde816543 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns="ns1-$rndh"
+ns1="ns1-$rndh"
 ksft_skip=4
 test_cnt=1
 timeout_poll=30
@@ -18,19 +18,19 @@ flush_pids()
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
 }
 
 mptcp_lib_check_mptcp
@@ -38,7 +38,7 @@ mptcp_lib_check_tools ip ss
 
 get_msk_inuse()
 {
-	ip netns exec $ns cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
+	ip netns exec $ns1 cat /proc/net/protocols | awk '$1~/^MPTCP$/{print $3}'
 }
 
 __chk_nr()
@@ -73,7 +73,7 @@ __chk_msk_nr()
 	local condition=$1
 	shift 1
 
-	__chk_nr "ss -inmHMN $ns | $condition" "$@"
+	__chk_nr "ss -inmHMN $ns1 | $condition" "$@"
 }
 
 chk_msk_nr()
@@ -94,7 +94,7 @@ wait_msk_nr()
 	msg=$*
 
 	while [ $i -lt $timeout ]; do
-		nr=$(ss -inmHMN $ns | $condition)
+		nr=$(ss -inmHMN $ns1 | $condition)
 		[ $nr == $expected ] && break;
 		[ $nr -gt $max ] && max=$nr
 		i=$((i + 1))
@@ -133,7 +133,7 @@ __chk_listen()
 	local expected=$2
 	local msg="$3"
 
-	__chk_nr "ss -N $ns -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
+	__chk_nr "ss -N $ns1 -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
 }
 
 chk_msk_listen()
@@ -163,7 +163,7 @@ chk_msk_inuse()
 		msg+=" after flush"
 	fi
 
-	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
+	listen_nr=$(ss -N "${ns1}" -Ml | grep -c LISTEN)
 	expected=$((expected + listen_nr))
 
 	for _ in $(seq 10); do
@@ -186,7 +186,7 @@ chk_msk_cestab()
 		msg+=" after flush"
 	fi
 
-	__chk_nr "mptcp_lib_get_counter ${ns} MPTcpExtMPCurrEstab" \
+	__chk_nr "mptcp_lib_get_counter ${ns1} MPTcpExtMPCurrEstab" \
 		 "${expected}" "${msg}" ""
 }
 
@@ -205,24 +205,24 @@ wait_connected()
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
@@ -235,16 +235,16 @@ chk_msk_cestab 0 "2->0"
 
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
 chk_msk_inuse 1
 chk_msk_cestab 1
@@ -257,16 +257,16 @@ NR_CLIENTS=100
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
index fd7de1b3dc55..eb06c3f6184b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -18,7 +18,7 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
-ns_sbox="ns_sbox-$rndh"
+ns3="ns3-$rndh"
 
 add_mark_rules()
 {
@@ -41,7 +41,7 @@ add_mark_rules()
 init()
 {
 	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox";do
+	for netns in "$ns1" "$ns2" "$ns3";do
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
@@ -80,7 +80,7 @@ init()
 cleanup()
 {
 	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox"; do
+	for netns in "$ns1" "$ns2" "$ns3"; do
 		ip netns del $netns
 	done
 	rm -f "$cin" "$cout"
@@ -223,7 +223,7 @@ do_mptcp_sockopt_tests()
 		return
 	fi
 
-	ip netns exec "$ns_sbox" ./mptcp_sockopt
+	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -234,7 +234,7 @@ do_mptcp_sockopt_tests()
 	fi
 	mptcp_lib_result_pass "sockopt v4"
 
-	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
+	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
@@ -265,7 +265,7 @@ run_tests()
 
 do_tcpinq_test()
 {
-	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
+	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
-- 
2.40.1

