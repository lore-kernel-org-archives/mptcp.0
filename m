Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA928EF
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573264; cv=none; b=cG9LBesQMN0oD28NdLh5z0kndIsjH9b124J1SbCkwsqQi6yX1S2KuB3ZfBzTsVKMqdiSHMQlZWk1wYbshcKxU7m66Vxt8pGMr8Zp5HkDR5VxDjTqq10U1CtF+Ga39kwRO9D2zet7xin4UCNH9EXXqLBl6hf1b82uKXZiWyO+rJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573264; c=relaxed/simple;
	bh=3fjpydKHWSOu9XgmRtvP8HbM0nxEj7fOfu4BP8gpsyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kbYs+JN87oH96XYY3tTBj3lOBS2Y/qOwo0AEYd0Bimsmil/hJBErDHOyX4Xwjsz7H1RqgwE07J5gnCILSRD0jZDHwn1vjaZrK8WHIB2/uwRvlWK+KpMnKiTNj9qRZ8OPN7LecG+PYm+LSik5AiF9V0ZlqzUvhAQ0eaYmhMtWOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTlLui/8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTlLui/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE35C433C7;
	Thu, 22 Feb 2024 03:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708573264;
	bh=3fjpydKHWSOu9XgmRtvP8HbM0nxEj7fOfu4BP8gpsyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTlLui/8gXrsHiPLaWi3kh2vjn8OKq0enf/NxMRzr/dvd/Zg6Ku093xElHeiExmaN
	 obVXnhIoNfSlJQMzntyyB7Zow+EKueqozef8UkCqIvyxRFeDlutMELezTFAbUYX8sO
	 Zm4/F7eQ7NNOXIlaSEKK5XYwLhNvi+FxzqLLQsMKn1PMJkmGNuNSWgfL960Zt0EwFC
	 mkvbKEgYnCllu+XhbdbNHj7HGts3LIhX0oaBmnr4vWLoibP/DeYL76Rb3Fdh+BbNil
	 fsJOkA2Wotrcd2s9S23QzszJIGeBvCakKFN0mO9g0zocAHXUNkUCC97x3QNVAGSt0B
	 FF5vaCRwb3Zmw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/4] selftests: mptcp: add mptcp_lib_ns_init/exit helpers
Date: Thu, 22 Feb 2024 11:40:34 +0800
Message-Id: <4518f97e63707f493123c76dd36d217a8eb42d35.1708572320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708572320.git.tanggeliang@kylinos.cn>
References: <cover.1708572320.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/diag.sh     |  9 +++-----
 .../selftests/net/mptcp/mptcp_connect.sh      | 23 ++++++++-----------
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 ++-------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 22 ++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 17 +++++---------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  9 +++-----
 .../selftests/net/mptcp/simult_flows.sh       | 16 ++++---------
 .../selftests/net/mptcp/userspace_pm.sh       | 14 ++++-------
 8 files changed, 54 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 60a7009ce1b5..24cffd94baae 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -3,9 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns="ns1-$rndh"
+ns=""
 ksft_skip=4
 test_cnt=1
 timeout_poll=30
@@ -30,7 +28,7 @@ cleanup()
 {
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
-	ip netns del $ns
+	mptcp_lib_ns_exit "${ns}"
 }
 
 mptcp_lib_check_mptcp
@@ -205,8 +203,7 @@ wait_connected()
 }
 
 trap cleanup EXIT
-ip netns add $ns
-ip -n $ns link set dev lo up
+mptcp_lib_ns_init ns
 
 echo "a" | \
 	timeout ${timeout_test} \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b609649311f6..92f6260ba9f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -121,12 +121,10 @@ while getopts "$optstring" option;do
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
 
 TEST_COUNT=0
 TEST_GROUP=""
@@ -140,9 +138,9 @@ cleanup()
 
 	local netns
 	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
-		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
 	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}" "${ns4}"
 }
 
 mptcp_lib_check_mptcp
@@ -158,10 +156,7 @@ cin_disconnect="$cin".disconnect
 cout_disconnect="$cout".disconnect
 trap cleanup EXIT
 
-for i in "$ns1" "$ns2" "$ns3" "$ns4";do
-	ip netns add $i || exit $ksft_skip
-	ip -net $i link set lo up
-done
+mptcp_lib_ns_init ns1 ns2 ns3 ns4
 
 #  "$ns1"              ns2                    ns3                     ns4
 # ns1eth2    ns2eth1   ns2eth3      ns3eth2   ns3eth4       ns4eth3
@@ -251,8 +246,8 @@ fi
 
 check_mptcp_disabled()
 {
-	local disabled_ns="ns_disabled-$rndh"
-	ip netns add ${disabled_ns} || exit $ksft_skip
+	local disabled_ns
+	mptcp_lib_ns_init disabled_ns
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
@@ -266,7 +261,7 @@ check_mptcp_disabled()
 	local err=0
 	LC_ALL=C ip netns exec ${disabled_ns} ./mptcp_connect -p 10000 -s MPTCP 127.0.0.1 < "$cin" 2>&1 | \
 		grep -q "^socket: Protocol not available$" && err=1
-	ip netns delete ${disabled_ns}
+	mptcp_lib_ns_exit "${disabled_ns}"
 
 	if [ ${err} -eq 0 ]; then
 		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[ FAIL ]"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index aedc5698f26a..612470244c58 100755
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
index 556a7d9784d7..fcb3afb4d51f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -373,3 +373,25 @@ mptcp_lib_check_output() {
 		return 1
 	fi
 }
+
+mptcp_lib_ns_init() {
+	local sec rndh
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
index fd7de1b3dc55..5fa5fa8cab71 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -14,11 +14,9 @@ timeout_test=$((timeout_poll * 2 + 1))
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
 
 add_mark_rules()
 {
@@ -40,10 +38,10 @@ add_mark_rules()
 
 init()
 {
+	mptcp_lib_ns_init ns1 ns2 ns_sbox
+
 	local netns
 	for netns in "$ns1" "$ns2" "$ns_sbox";do
-		ip netns add $netns || exit $ksft_skip
-		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
@@ -79,10 +77,7 @@ init()
 
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
index 1ec9d8622fc9..30ec0ec3d68f 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -24,15 +24,13 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+ns1=""
 err=$(mktemp)
 
 cleanup()
 {
 	rm -f $err
-	ip netns del $ns1
+	mptcp_lib_ns_exit "${ns1}"
 }
 
 mptcp_lib_check_mptcp
@@ -40,8 +38,7 @@ mptcp_lib_check_tools ip
 
 trap cleanup EXIT
 
-ip netns add $ns1 || exit $ksft_skip
-ip -net $ns1 link set lo up
+mptcp_lib_ns_init ns1
 ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 8a4520f29601..c5128d690c46 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -3,11 +3,9 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+ns1=""
+ns2=""
+ns3=""
 capture=false
 ksft_skip=4
 timeout_poll=30
@@ -36,10 +34,7 @@ cleanup()
 	rm -f "$large" "$small"
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3";do
-		ip netns del $netns
-	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}"
 }
 
 mptcp_lib_check_mptcp
@@ -65,9 +60,8 @@ setup()
 
 	trap cleanup EXIT
 
+	mptcp_lib_ns_init ns1 ns2 ns3
 	for i in "$ns1" "$ns2" "$ns3";do
-		ip netns add $i || exit $ksft_skip
-		ip -net $i link set lo up
 		ip netns exec $i sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $i sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 629fc5d0ecc5..e3092696d2de 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -50,10 +50,8 @@ app6_port=50004
 client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
-sec=$(date +%s)
-rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
+ns1=""
+ns2=""
 ret=0
 test_name=""
 
@@ -118,10 +116,7 @@ cleanup()
 		mptcp_lib_kill_wait $pid
 	done
 
-	local netns
-	for netns in "$ns1" "$ns2" ;do
-		ip netns del "$netns"
-	done
+	mptcp_lib_ns_exit "${ns1}" "${ns2}"
 
 	rm -rf $file $client_evts $server_evts
 
@@ -131,9 +126,8 @@ cleanup()
 trap cleanup EXIT
 
 # Create and configure network namespaces for testing
+mptcp_lib_ns_init ns1 ns2
 for i in "$ns1" "$ns2" ;do
-	ip netns add "$i" || exit 1
-	ip -net "$i" link set lo up
 	ip netns exec "$i" sysctl -q net.mptcp.enabled=1
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done
-- 
2.40.1

