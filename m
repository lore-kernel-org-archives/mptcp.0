Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5179D1
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334991; cv=none; b=Jlyau+OVbRLsv9A6UrY7geWw9EiSxfmOQuEnMFWDL5zxek2Jty9Um+wpeJv1x6lrPl8Ku6NLKOI2hpDkE34UtIQJ1qMJzBqNy4d02Mks3bnNg9+f7LGSo5swJLkSYgnfmlllXPJdQsFqF2EQnVcfXkNZ0KKjcV34DWgSkg8hgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334991; c=relaxed/simple;
	bh=MGeJcuVJlSdUeKeXeLlspf+oFqzfqripLHZoNLXDevg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n0Rju/+ucS203C1K2awZJqONuwVQMj8pw57I+U5EJlZ7PDbS02efzqbDvlUxHXYGwLLmPLCec1XAvjhaiXy2XmXZLJUbTibd95HqeIu3BxZs3sRtIwlAQFX9GFbSuYwR2cbFSO1Lh0khKKb8J9A6kBoTeRvIGbb3JAR2WhHjjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXe2TJ8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXe2TJ8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E73C433F1;
	Mon, 19 Feb 2024 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708334991;
	bh=MGeJcuVJlSdUeKeXeLlspf+oFqzfqripLHZoNLXDevg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXe2TJ8TdpOc81+xST47x7ktEBJU1NSMEIb1S/OpHFXa+G1q8MgPaMTBy3WVf3bd8
	 rf6F8FvQAhyVeBt0MoSxsbZTfpx/JuDQGUM+MYocHo0PU0ibexOf4TOKyzixO9XJKt
	 lWMFIPZUFB7TTkYqnrpGtUPZu/RILjdCxva1rDxMJG+4N3r2UQ7dmlpUDrw3k/KUgI
	 mINkU/GY1aQfu2DU1t22vLWOIMY2BEfplYV9qpTF3PhLu5bZout5vP80FPas8j34pA
	 Gvmp0JF8/220CIi65PKXSl8xeF59KkOXc/IMHiVXXshVvVTE3fm6vnOH7H8jly3//n
	 wDupoZZ8FxBKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/5] selftests: mptcp: add mptcp_lib_ns_* helpers
Date: Mon, 19 Feb 2024 17:29:32 +0800
Message-Id: <b231398375e6569da10c36f931be69d161a5e31b.1708334850.git.tanggeliang@kylinos.cn>
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

Add helpers mptcp_lib_ns_init() and mptcp_lib_ns_exit() in mptcp_lib.sh to
init all namespaces ns1, ns2, ns3 and ns4. Then every test script can
invoke these helpers and use all namespaces.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh     |  8 +--
 .../selftests/net/mptcp/mptcp_connect.sh      | 20 ++-----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +-----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 59 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 15 +----
 .../testing/selftests/net/mptcp/pm_netlink.sh |  8 +--
 .../selftests/net/mptcp/simult_flows.sh       | 18 +-----
 .../selftests/net/mptcp/userspace_pm.sh       | 12 +---
 8 files changed, 75 insertions(+), 84 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index e91dde816543..40fc04e8e592 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -3,9 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+mptcp_lib_ns_init 1
 ksft_skip=4
 test_cnt=1
 timeout_poll=30
@@ -30,7 +28,7 @@ cleanup()
 {
 	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
-	ip netns del $ns1
+	mptcp_lib_ns_exit 1
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
index ea52110c3fbc..00527f4c3b98 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -121,12 +121,7 @@ while getopts "$optstring" option;do
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
@@ -138,11 +133,7 @@ cleanup()
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
@@ -158,11 +149,6 @@ cin_disconnect="$cin".disconnect
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
@@ -251,6 +237,8 @@ fi
 
 check_mptcp_disabled()
 {
+	: "${rndh:?}"
+
 	local disabled_ns="ns_disabled-$rndh"
 	ip netns add ${disabled_ns} || exit $ksft_skip
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a8d08554efc9..7e354ff5d717 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -23,8 +23,6 @@ tmpfile=""
 cout=""
 check_output_err=""
 capout=""
-ns1=""
-ns2=""
 ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
@@ -86,21 +84,12 @@ init_partial()
 {
 	capout=$(mktemp)
 
-	local sec rndh
-	sec=$(date +%s)
-	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-
-	ns1="ns1-$rndh"
-	ns2="ns2-$rndh"
+	mptcp_lib_ns_init 2
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
-		ip netns add $netns || exit $ksft_skip
-		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
-		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
@@ -145,11 +134,7 @@ cleanup_partial()
 {
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2"; do
-		ip netns del $netns
-		rm -f /tmp/$netns.{nstat,out}
-	done
+	mptcp_lib_ns_exit 2
 }
 
 init() {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 6d9a2af85a8d..bfc535594675 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -350,3 +350,62 @@ mptcp_lib_check_tools() {
 		esac
 	done
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
+	local nr="${1:-4}"
+	local i=1
+	local sec
+
+	sec=$(date +%s)
+	rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
+
+	ns1="ns1-$rndh"
+	ns2="ns2-$rndh"
+	ns3="ns3-$rndh"
+	ns4="ns4-$rndh"
+
+	local netns
+	for netns in "$ns1" "$ns2" "$ns3" "$ns4"; do
+		if [ "$i" -gt "$nr" ]; then
+			break
+		fi
+		ip netns add "$netns" || exit ${KSFT_SKIP}
+		ip -net "$netns" link set lo up
+
+		ip netns exec "$netns" sysctl -q net.ipv4.conf.all.rp_filter=0
+		ip netns exec "$netns" sysctl -q net.ipv4.conf.default.rp_filter=0
+		i=$((i + 1))
+	done
+}
+
+mptcp_lib_ns_exit() {
+	: "${ns1:?}"
+	: "${ns2:?}"
+	: "${ns3:?}"
+	: "${ns4:?}"
+
+	local nr="${1:-4}"
+	local i=1
+
+	local netns
+	for netns in "$ns1" "$ns2" "$ns3" "$ns4"; do
+		if [ "$i" -gt "$nr" ]; then
+			break
+		fi
+		ip netns del "$netns"
+		rm -f /tmp/"$netns".{nstat,out}
+		i=$((i + 1))
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index eb06c3f6184b..5d8881d11fb0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -14,11 +14,7 @@ timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
 ip6tables="ip6tables"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+mptcp_lib_ns_init 3
 
 add_mark_rules()
 {
@@ -42,11 +38,7 @@ init()
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
@@ -79,10 +71,7 @@ init()
 
 cleanup()
 {
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3"; do
-		ip netns del $netns
-	done
+	mptcp_lib_ns_exit 3
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
 }
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index cb6ea67e688b..2ea80f1b0aee 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -24,15 +24,13 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+mptcp_lib_ns_init 1
 err=$(mktemp)
 
 cleanup()
 {
 	rm -f $err
-	ip netns del $ns1
+	mptcp_lib_ns_exit 1
 }
 
 mptcp_lib_check_mptcp
@@ -40,8 +38,6 @@ mptcp_lib_check_tools ip
 
 trap cleanup EXIT
 
-ip netns add $ns1 || exit $ksft_skip
-ip -net $ns1 link set lo up
 ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 7d8388ecc966..a45b6ad41aea 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -3,11 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+mptcp_lib_ns_init 3
 capture=false
 ksft_skip=4
 timeout_poll=30
@@ -36,10 +32,7 @@ cleanup()
 	rm -f "$large" "$small"
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3";do
-		ip netns del $netns
-	done
+	mptcp_lib_ns_exit 3
 }
 
 mptcp_lib_check_mptcp
@@ -65,13 +58,6 @@ setup()
 
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
index 629fc5d0ecc5..71caa6b449a8 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -50,10 +50,7 @@ app6_port=50004
 client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
-sec=$(date +%s)
-rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
+mptcp_lib_ns_init 2
 ret=0
 test_name=""
 
@@ -118,10 +115,7 @@ cleanup()
 		mptcp_lib_kill_wait $pid
 	done
 
-	local netns
-	for netns in "$ns1" "$ns2" ;do
-		ip netns del "$netns"
-	done
+	mptcp_lib_ns_exit 2
 
 	rm -rf $file $client_evts $server_evts
 
@@ -132,8 +126,6 @@ trap cleanup EXIT
 
 # Create and configure network namespaces for testing
 for i in "$ns1" "$ns2" ;do
-	ip netns add "$i" || exit 1
-	ip -net "$i" link set lo up
 	ip netns exec "$i" sysctl -q net.mptcp.enabled=1
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done
-- 
2.40.1

