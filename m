Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60EB3A1D3
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499193; cv=none; b=ekAKNlgFKsW6x4HkLcLx60p6lFpsMPBxn2z5ocu+4FpzlWRW692cGBWvk24PpmMibx4mOvtkSttpLWF3yXa9TtEs2ejfMAUOkbefoEbzMg3vsP+OdbVhm7r+FALDoLkvFZn8dyhsWezwuOPFxb9L0P3b+Xh8rcaeRpDt9JFNCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499193; c=relaxed/simple;
	bh=1+bu8CRAQZMVbqmN5G+Qb+YVV9j+z6ybq1h6UfJR9l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRRc4MrKZ8BfX9MBuSlcxq5S/gK+AdxnaGTPfjXp665Ic3yam1IIzYOtkyTrs8u/42fnAyPCYZIAWBl66h+X3MxDdXODrFuSQnjp2OjbFdGeyXWtWHuP6GMsXt0TZ9AV/ZNIb91BwjfLh55KVdmocJHOnbNzHMd1SMCs+bxxAZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgxAemsj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgxAemsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C48C433C7;
	Wed, 21 Feb 2024 07:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708499193;
	bh=1+bu8CRAQZMVbqmN5G+Qb+YVV9j+z6ybq1h6UfJR9l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgxAemsj16uWMeroMhsxeitAgkprWm1yl5zxaSW9gLfNPrHkSrFqXEkLjKe7QVIbW
	 fmCdXQWnjp9GoCe50fVWm5fNYA+woTgJTLu3d+BpwtXCWbWEe6iODaQk01axKD2FqI
	 PwtKrUR35Hw0gv5SBSsH5mF+LXCyplHHzXnNBF+cI91uhu8qG+64Bm7+ABuVAHiSci
	 pznLBzarHTdTLaCPipRVxFVjCuCWhZEtS/fWZp1ZYh6BNFdFf3vSksrsFBkk+iVP0h
	 /y526iDq02/F7gAgXTyodXZ89IJ9lP9d4a3eRVyaqy4/o6ZPYkBNqDU6L17V3dQh2I
	 s4QaoZeUmrJrw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/3] selftests: mptcp: add mptcp_lib_ns_* helpers
Date: Wed, 21 Feb 2024 15:06:21 +0800
Message-Id: <fef66a388379bd499df11a08a9492bb583210f47.1708499011.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708499011.git.tanggeliang@kylinos.cn>
References: <cover.1708499011.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add helpers mptcp_lib_ns_init() and mptcp_lib_ns_exit() in mptcp_lib.sh to
initialize and delete the given namespaces. Then every test script can
invoke these helpers and use all namespaces.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh     |  9 +++----
 .../selftests/net/mptcp/mptcp_connect.sh      | 24 +++++++------------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 ++-------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 23 ++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 16 ++++---------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  9 +++----
 .../selftests/net/mptcp/simult_flows.sh       | 16 ++++---------
 .../selftests/net/mptcp/userspace_pm.sh       | 14 ++++-------
 8 files changed, 54 insertions(+), 68 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 60a7009ce1b5..162d7b90c3f5 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -3,9 +3,8 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns="ns1-$rndh"
+ns=""
+mptcp_lib_ns_init ns
 ksft_skip=4
 test_cnt=1
 timeout_poll=30
@@ -30,7 +29,7 @@ cleanup()
 {
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
-	ip netns del $ns
+	mptcp_lib_ns_exit "${ns}"
 }
 
 mptcp_lib_check_mptcp
@@ -205,8 +204,6 @@ wait_connected()
 }
 
 trap cleanup EXIT
-ip netns add $ns
-ip -n $ns link set dev lo up
 
 echo "a" | \
 	timeout ${timeout_test} \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b609649311f6..6900f7f4d88d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -121,12 +121,11 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
-ns4="ns4-$rndh"
+ns1=""
+ns2=""
+ns3=""
+ns4=""
+mptcp_lib_ns_init ns1 ns2 ns3 ns4
 
 TEST_COUNT=0
 TEST_GROUP=""
@@ -140,9 +139,9 @@ cleanup()
 
 	local netns
 	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
-		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
 	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}" "${ns4}"
 }
 
 mptcp_lib_check_mptcp
@@ -158,11 +157,6 @@ cin_disconnect="$cin".disconnect
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
@@ -251,8 +245,8 @@ fi
 
 check_mptcp_disabled()
 {
-	local disabled_ns="ns_disabled-$rndh"
-	ip netns add ${disabled_ns} || exit $ksft_skip
+	local disabled_ns=""
+	mptcp_lib_ns_init disabled_ns
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
@@ -266,7 +260,7 @@ check_mptcp_disabled()
 	local err=0
 	LC_ALL=C ip netns exec ${disabled_ns} ./mptcp_connect -p 10000 -s MPTCP 127.0.0.1 < "$cin" 2>&1 | \
 		grep -q "^socket: Protocol not available$" && err=1
-	ip netns delete ${disabled_ns}
+	mptcp_lib_ns_exit "${disabled_ns}"
 
 	if [ ${err} -eq 0 ]; then
 		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[ FAIL ]"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9f1476f0e2ae..bea7627c7313 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -86,17 +86,10 @@ init_partial()
 {
 	capout=$(mktemp)
 
-	local sec rndh
-	sec=$(date +%s)
-	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-
-	ns1="ns1-$rndh"
-	ns2="ns2-$rndh"
+	mptcp_lib_ns_init ns1 ns2
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
-		ip netns add $netns || exit $ksft_skip
-		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
@@ -147,9 +140,9 @@ cleanup_partial()
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
-		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
 	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}"
 }
 
 init() {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 556a7d9784d7..14c0b97a153e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -373,3 +373,26 @@ mptcp_lib_check_output() {
 		return 1
 	fi
 }
+
+mptcp_lib_ns_init() {
+	local sec
+	local rndh=""
+
+	sec=$(date +%s)
+	rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
+
+	local netns
+	for netns in "${@}"; do
+		eval "${netns}=${netns}-${rndh}"
+
+		ip netns add "${!netns}" || exit ${KSFT_SKIP}
+		ip -net "${!netns}" link set lo up
+	done
+}
+
+mptcp_lib_ns_exit() {
+	local netns
+	for netns in "${@}"; do
+		ip netns del "$netns"
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index fd7de1b3dc55..58bf83d4e7fa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -14,11 +14,10 @@ timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
 ip6tables="ip6tables"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns_sbox="ns_sbox-$rndh"
+ns1=""
+ns2=""
+ns_sbox=""
+mptcp_lib_ns_init ns1 ns2 ns_sbox
 
 add_mark_rules()
 {
@@ -42,8 +41,6 @@ init()
 {
 	local netns
 	for netns in "$ns1" "$ns2" "$ns_sbox";do
-		ip netns add $netns || exit $ksft_skip
-		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
@@ -79,10 +76,7 @@ init()
 
 cleanup()
 {
-	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox"; do
-		ip netns del $netns
-	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns_sbox}"
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
 }
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 1ec9d8622fc9..c117eea92b6a 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -24,15 +24,14 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+ns1=""
+mptcp_lib_ns_init ns1
 err=$(mktemp)
 
 cleanup()
 {
 	rm -f $err
-	ip netns del $ns1
+	mptcp_lib_ns_exit "${ns1}"
 }
 
 mptcp_lib_check_mptcp
@@ -40,8 +39,6 @@ mptcp_lib_check_tools ip
 
 trap cleanup EXIT
 
-ip netns add $ns1 || exit $ksft_skip
-ip -net $ns1 link set lo up
 ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 7d8388ecc966..67cddd40f211 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -3,11 +3,10 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+ns1=""
+ns2=""
+ns3=""
+mptcp_lib_ns_init ns1 ns2 ns3
 capture=false
 ksft_skip=4
 timeout_poll=30
@@ -36,10 +35,7 @@ cleanup()
 	rm -f "$large" "$small"
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3";do
-		ip netns del $netns
-	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}"
 }
 
 mptcp_lib_check_mptcp
@@ -66,8 +62,6 @@ setup()
 	trap cleanup EXIT
 
 	for i in "$ns1" "$ns2" "$ns3";do
-		ip netns add $i || exit $ksft_skip
-		ip -net $i link set lo up
 		ip netns exec $i sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $i sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 629fc5d0ecc5..10074709420a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -50,10 +50,9 @@ app6_port=50004
 client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
-sec=$(date +%s)
-rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
+ns1=""
+ns2=""
+mptcp_lib_ns_init ns1 ns2
 ret=0
 test_name=""
 
@@ -118,10 +117,7 @@ cleanup()
 		mptcp_lib_kill_wait $pid
 	done
 
-	local netns
-	for netns in "$ns1" "$ns2" ;do
-		ip netns del "$netns"
-	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}"
 
 	rm -rf $file $client_evts $server_evts
 
@@ -132,8 +128,6 @@ trap cleanup EXIT
 
 # Create and configure network namespaces for testing
 for i in "$ns1" "$ns2" ;do
-	ip netns add "$i" || exit 1
-	ip -net "$i" link set lo up
 	ip netns exec "$i" sysctl -q net.mptcp.enabled=1
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done
-- 
2.40.1

