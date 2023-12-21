Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318AE6BB32
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UItSLzao"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703158414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9ut9cJQNbKGKVZpfP78lF97aON1vyM6866nJZVzKC4=;
	b=UItSLzaoPk17h+RMY+SpzKTjmWDG2OEycYNT6wHNUVQTaCmeSiYkf1aArrXNxxaHQ8vBae
	ewqNQ2IHNxjHWY9C8/RwsHit2D9sojpeoQj5kDgl25K5nhhO5Zl0BTc7aNlpBXNXYGEBLI
	4BuGHWzF5YAurzl9XMMTKVBx2Z3FBt8=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 11/15] selftests: mptcp: add mptcp_lib_ns_* helpers
Date: Thu, 21 Dec 2023 19:31:14 +0800
Message-Id: <629de71b650622d5d55c0615539cccec3504ef4b.1703158128.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703158128.git.geliang.tang@linux.dev>
References: <cover.1703158128.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add helpers mptcp_lib_ns_init() and mptcp_lib_ns_exit() in mptcp_lib.sh to
init all namespaces ns1, ns2, ns3 and ns4. Then every test script can
invoke these helpers and use all namespaces.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/diag.sh     |  8 +--
 .../selftests/net/mptcp/mptcp_connect.sh      | 20 ++----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +-----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 64 +++++++++++++------
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 15 +----
 .../testing/selftests/net/mptcp/pm_netlink.sh |  8 +--
 .../selftests/net/mptcp/simult_flows.sh       | 18 +-----
 .../selftests/net/mptcp/userspace_pm.sh       | 12 +---
 8 files changed, 62 insertions(+), 102 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index edd23f5c757a..984a4f3b359b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -3,9 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+mptcp_lib_ns_init
 ksft_skip=4
 test_cnt=1
 timeout_poll=100
@@ -29,7 +27,7 @@ cleanup()
 {
 	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
-	ip netns del $ns1
+	mptcp_lib_ns_exit
 }
 
 mptcp_lib_check_mptcp
@@ -205,8 +203,6 @@ wait_connected()
 }
 
 trap cleanup EXIT
-ip netns add $ns1
-ip -n $ns1 link set dev lo up
 
 echo "a" | \
 	timeout ${timeout_test} \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index e3f1afa8011b..8a4fda253ee9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -120,12 +120,7 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
-ns4="ns4-$rndh"
+mptcp_lib_ns_init
 
 TEST_COUNT=0
 TEST_GROUP=""
@@ -137,11 +132,7 @@ cleanup()
 	rm -f "$sin" "$sout"
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
-		ip netns del $netns
-		rm -f /tmp/$netns.{nstat,out}
-	done
+	mptcp_lib_ns_exit
 }
 
 mptcp_lib_check_mptcp
@@ -162,11 +153,6 @@ cin_disconnect="$cin".disconnect
 cout_disconnect="$cout".disconnect
 trap cleanup EXIT
 
-for i in "$ns1" "$ns2" "$ns3" "$ns4";do
-	ip netns add $i || exit $ksft_skip
-	ip -net $i link set lo up
-done
-
 #  "$ns1"              ns2                    ns3                     ns4
 # ns1eth2    ns2eth1   ns2eth3      ns3eth2   ns3eth4       ns4eth3
 #                           - drop 1% ->            reorder 25%
@@ -255,6 +241,8 @@ fi
 
 check_mptcp_disabled()
 {
+	: "${rndh:?}"
+
 	local disabled_ns="ns_disabled-$rndh"
 	ip netns add ${disabled_ns} || exit $ksft_skip
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c90c987f8993..50ef210894eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -22,8 +22,6 @@ tmpfile=""
 cout=""
 check_output_err=""
 capout=""
-ns1=""
-ns2=""
 ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
@@ -81,21 +79,12 @@ init_partial()
 {
 	capout=$(mktemp)
 
-	local sec rndh
-	sec=$(date +%s)
-	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-
-	ns1="ns1-$rndh"
-	ns2="ns2-$rndh"
+	mptcp_lib_ns_init
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
-		ip netns add $netns || exit $ksft_skip
-		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
-		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 		if [ $checksum -eq 1 ]; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
@@ -140,11 +129,7 @@ cleanup_partial()
 {
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2"; do
-		ip netns del $netns
-		rm -f /tmp/$netns.{nstat,out}
-	done
+	mptcp_lib_ns_exit
 }
 
 check_tools()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index edf46462c623..2ff69d073a0f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -311,24 +311,6 @@ mptcp_lib_wait_local_port_listen() {
 	done
 }
 
-# $1: ns, $2: cestab nr
-mptcp_lib_chk_cestab_nr() {
-	local ns=$1
-	local cestab=$2
-	local count
-
-	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
-	if [ -z "$count" ]; then
-		mptcp_lib_print_warn "[ SKIP ]"
-	elif [ "$count" != "$cestab" ]; then
-		mptcp_lib_print_err "[ FAIL ] got $count current establish[s] expected $cestab"
-		return 1
-	else
-		mptcp_lib_print_ok "[ OK ]"
-	fi
-	return 0
-}
-
 server_evts=""
 client_evts=""
 server_evts_pid=0
@@ -457,3 +439,49 @@ mptcp_lib_verify_listener_events() {
 
 	mptcp_lib_check_expected "type" "family" "saddr" "sport"
 }
+
+rndh=""
+ns1=""
+ns2=""
+ns3=""
+ns4=""
+
+mptcp_lib_ns_init() {
+	: "${rndh?}"
+	: "${ns1?}"
+	: "${ns2?}"
+	: "${ns3?}"
+	: "${ns4?}"
+
+	local sec
+
+	sec=$(date +%s)
+	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
+
+	ns1="ns1-$rndh"
+	ns2="ns2-$rndh"
+	ns3="ns3-$rndh"
+	ns4="ns4-$rndh"
+
+	local netns
+	for netns in "$ns1" "$ns2" "$ns3" "$ns4"; do
+		ip netns add $netns || exit ${ksft_skip}
+		ip -net $netns link set lo up
+
+		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
+		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
+	done
+}
+
+mptcp_lib_ns_exit() {
+	: "${ns1:?}"
+	: "${ns2:?}"
+	: "${ns3:?}"
+	: "${ns4:?}"
+
+	local netns
+	for netns in "$ns1" "$ns2" "$ns3" "$ns4"; do
+		ip netns del $netns
+		rm -f /tmp/$netns.{nstat,out}
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f4eff7377272..1982078b2b45 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -13,11 +13,7 @@ timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
 ip6tables="ip6tables"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+mptcp_lib_ns_init
 
 add_mark_rules()
 {
@@ -41,11 +37,7 @@ init()
 {
 	local netns
 	for netns in "$ns1" "$ns2" "$ns3";do
-		ip netns add $netns || exit $ksft_skip
-		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
-		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 
 	local i
@@ -78,10 +70,7 @@ init()
 
 cleanup()
 {
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3"; do
-		ip netns del $netns
-	done
+	mptcp_lib_ns_exit
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
 }
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index b2e3ecbc376c..5208492d1f01 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -23,15 +23,13 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+mptcp_lib_ns_init
 err=$(mktemp)
 
 cleanup()
 {
 	rm -f $err
-	ip netns del $ns1
+	mptcp_lib_ns_exit
 }
 
 mptcp_lib_check_mptcp
@@ -44,8 +42,6 @@ fi
 
 trap cleanup EXIT
 
-ip netns add $ns1 || exit $ksft_skip
-ip -net $ns1 link set lo up
 ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index f18dfafb5710..8925d94926ee 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -3,11 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+mptcp_lib_ns_init
 capture=false
 ksft_skip=4
 timeout_poll=30
@@ -29,10 +25,7 @@ cleanup()
 	rm -f "$large" "$small"
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3";do
-		ip netns del $netns
-	done
+	mptcp_lib_ns_exit
 }
 
 mptcp_lib_check_mptcp
@@ -63,13 +56,6 @@ setup()
 
 	trap cleanup EXIT
 
-	for i in "$ns1" "$ns2" "$ns3";do
-		ip netns add $i || exit $ksft_skip
-		ip -net $i link set lo up
-		ip netns exec $i sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $i sysctl -q net.ipv4.conf.default.rp_filter=0
-	done
-
 	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
 	ip link add ns1eth2 netns "$ns1" type veth peer name ns2eth2 netns "$ns2"
 	ip link add ns2eth3 netns "$ns2" type veth peer name ns3eth1 netns "$ns3"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 1e4493363d0b..3a9e2a69eb6d 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -40,10 +40,7 @@ app6_port=50004
 client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
-sec=$(date +%s)
-rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
+mptcp_lib_ns_init
 TEST_NAME=""
 
 _printf() {
@@ -102,10 +99,7 @@ cleanup()
 	done
 	mptcp_lib_evts_kill
 
-	local netns
-	for netns in "$ns1" "$ns2" ;do
-		ip netns del "$netns"
-	done
+	mptcp_lib_ns_exit
 
 	rm -rf $file
 	mptcp_lib_evts_remove
@@ -117,8 +111,6 @@ trap cleanup EXIT
 
 # Create and configure network namespaces for testing
 for i in "$ns1" "$ns2" ;do
-	ip netns add "$i" || exit 1
-	ip -net "$i" link set lo up
 	ip netns exec "$i" sysctl -q net.mptcp.enabled=1
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done
-- 
2.35.3

