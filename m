Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0E14F6F
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sELZIWvt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHE24xN2lZ7YrCQcxEDiBML+o4v8nVVt5oBnBke6S9k=;
	b=sELZIWvtLvhF4D4TBm3I2ajhm9dOy6CXnJr82vMKhFbBF7WIcaBgIjOCva1xuNMsZkgI97
	hrdKO287gj++rk4CTeeCb5okw2EILSmV+Nh5TvbRq2Vp+cXXW7ncNER6Pl3vlKfUP65S4X
	Ura7FaNGx6SwTUjldTZn2vSKf4QrVzA=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 09/33] selftests: mptcp: add mptcp_lib_ns_* helpers
Date: Tue,  5 Dec 2023 15:00:56 +0800
Message-Id: <1380a04f2c8b844f71827bd09bcaef3478d072f7.1701759405.git.geliang.tang@linux.dev>
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

Add helpers mptcp_lib_ns_init() and mptcp_lib_ns_exit() in mptcp_lib.sh to
init all namespaces ns1, ns2, ns3 and ns4. Then every test script can
invoke these helpers and use all namespaces.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/diag.sh     |  8 +---
 .../selftests/net/mptcp/mptcp_connect.sh      | 20 ++------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +-------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 46 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 15 +-----
 .../testing/selftests/net/mptcp/pm_netlink.sh |  8 +---
 .../selftests/net/mptcp/simult_flows.sh       | 18 +-------
 .../selftests/net/mptcp/userspace_pm.sh       | 12 +----
 8 files changed, 62 insertions(+), 84 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index bc3f24c454be..3119811018fc 100755
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
 	mptcp_lib_cleanup
 }
 
@@ -197,8 +195,6 @@ wait_connected()
 }
 
 trap cleanup EXIT
-ip netns add $ns1
-ip -n $ns1 link set dev lo up
 
 echo "a" | \
 	timeout ${timeout_test} \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5e28292e1889..e19b1fe67408 100755
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
 	mptcp_lib_cleanup
 }
 
@@ -163,11 +154,6 @@ cin_disconnect="$cin".disconnect
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
@@ -256,6 +242,8 @@ fi
 
 check_mptcp_disabled()
 {
+	: "${rndh:?}"
+
 	local disabled_ns="ns_disabled-$rndh"
 	ip netns add ${disabled_ns} || exit $ksft_skip
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0fb76e963cfd..7dec65a5ed75 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -21,8 +21,6 @@ cinsent=""
 tmpfile=""
 cout=""
 capout=""
-ns1=""
-ns2=""
 ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
@@ -80,21 +78,12 @@ init_partial()
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
@@ -139,11 +128,7 @@ cleanup_partial()
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
index 198e3b3a8439..e8e1250e5ea6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -468,6 +468,52 @@ mptcp_lib_verify_listener_events() {
 	mptcp_lib_check_expected "type" "family" "saddr" "sport"
 }
 
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
+
 mptcp_lib_cleanup() {
 	: "${check_output_err:?}"
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index b82f7b0b85bc..ff49ee9b9cc2 100755
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
 	mptcp_lib_cleanup
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index c0fc6f82a8c7..8f99b138a59f 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -23,13 +23,11 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+mptcp_lib_ns_init
 
 cleanup()
 {
-	ip netns del $ns1
+	mptcp_lib_ns_exit
 	mptcp_lib_cleanup
 }
 
@@ -43,8 +41,6 @@ fi
 
 trap cleanup EXIT
 
-ip netns add $ns1 || exit $ksft_skip
-ip -net $ns1 link set lo up
 ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 3536c7160ce5..c1a21cd8c076 100755
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
 	mptcp_lib_cleanup
 }
 
@@ -64,13 +57,6 @@ setup()
 
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
index e78a79da3960..93f8b200ce49 100755
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
@@ -118,8 +112,6 @@ trap cleanup EXIT
 
 # Create and configure network namespaces for testing
 for i in "$ns1" "$ns2" ;do
-	ip netns add "$i" || exit 1
-	ip -net "$i" link set lo up
 	ip netns exec "$i" sysctl -q net.mptcp.enabled=1
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done
-- 
2.35.3

