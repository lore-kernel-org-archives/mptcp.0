Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514012B76
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rqpODW4+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaeJ2yT48xs+3y+Mavm0D2nSlHX782kkK+qxG0J9r1Y=;
	b=rqpODW4+Kii6tO8QCaJK5qNOwT47/n0SgM98AoY+B5yho9bpCPLY/pQy+N+ljrwsWAn19a
	CV8voeGP8/1x5pkWoMUAq2uZtvu805aKfi3bJtplI415yjcaXZZZSYHi6c/FoCHpx3tW0C
	Q42Y+16YpuyQ3FRLVmOpAD8scTIsNzI=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 32/33] selftests: mptcp: use KSFT_SKIP instead ksft_skip
Date: Tue,  5 Dec 2023 15:01:19 +0800
Message-Id: <0954b8ffdda5c4ea1b170eb194106485e310fe9c.1701759405.git.geliang.tang@linux.dev>
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

This patch uses the public var KSFT_SKIP in mptcp_lib.sh instead of
ksft_skip, and drop every 'ksft_skip=4'.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/diag.sh          |  1 -
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  9 ++++-----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 10 +++++-----
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  2 --
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  2 --
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  1 -
 7 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 1752cf292588..7d6656067cc2 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_ns_init
-ksft_skip=4
 
 flush_pids()
 {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 356cbb2289be..32a979a40a72 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -8,7 +8,6 @@ time_start=$(date +%s)
 optstring="S:R:d:e:l:r:h4cm:f:tC"
 final_ret=0
 cin_disconnect=""
-ksft_skip=4
 ipv6=true
 ethtool_random_on=true
 tc_delay="$((RANDOM%50))"
@@ -224,7 +223,7 @@ check_mptcp_disabled()
 	: "${rndh:?}"
 
 	local disabled_ns="ns_disabled-$rndh"
-	ip netns add ${disabled_ns} || exit $ksft_skip
+	ip netns add ${disabled_ns} || exit ${KSFT_SKIP}
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 824f2a3ed7c2..81521e4760ae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,7 +17,6 @@ cinfail=""
 cinsent=""
 tmpfile=""
 capout=""
-ksft_skip=4
 ip_mptcp=0
 check_invert=0
 validate_checksum=false
@@ -371,15 +370,15 @@ setup_fail_rules()
 		-p tcp \
 		-m length --length 150:9999 \
 		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42 || return ${ksft_skip}
+		-j MARK --set-mark 42 || return ${KSFT_SKIP}
 
-	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${ksft_skip}
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${KSFT_SKIP}
 	tc -n $ns2 filter add dev ns2eth$i egress \
 		protocol ip prio 1000 \
 		handle 42 fw \
 		action pedit munge offset 148 u8 invert \
 		pipe csum tcp \
-		index 100 || return ${ksft_skip}
+		index 100 || return ${KSFT_SKIP}
 }
 
 reset_with_fail()
@@ -393,7 +392,7 @@ reset_with_fail()
 	local rc=0
 	setup_fail_rules "${@}" || rc=$?
 
-	if [ ${rc} -eq ${ksft_skip} ]; then
+	if [ ${rc} -eq ${KSFT_SKIP} ]; then
 		mark_as_skipped "unable to set the 'fail' rules"
 		return 1
 	fi
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1f1e8c5e9540..5d0e3a56e975 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -507,7 +507,7 @@ mptcp_lib_ns_init() {
 
 	local netns
 	for netns in "$ns1" "$ns2" "$ns3" "$ns4"; do
-		ip netns add $netns || exit ${ksft_skip}
+		ip netns add $netns || exit ${KSFT_SKIP}
 		ip -net $netns link set lo up
 
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
@@ -541,7 +541,7 @@ mptcp_lib_check_tools() {
 	if [ "${1:-""}" == "ip" ]; then
 		if ! ip -Version &> /dev/null; then
 			mptcp_lib_print_warn "SKIP: Could not run test without ip tool"
-			exit $ksft_skip
+			exit ${KSFT_SKIP}
 		fi
 	fi
 
@@ -549,7 +549,7 @@ mptcp_lib_check_tools() {
 		ss -h | grep -q MPTCP
 		if [ $? -ne 0 ];then
 			mptcp_lib_print_warn "SKIP: ss tool does not support MPTCP"
-			exit $ksft_skip
+			exit ${KSFT_SKIP}
 		fi
 	fi
 
@@ -560,10 +560,10 @@ mptcp_lib_check_tools() {
 			ip6tables="ip6tables-legacy"
 		elif ! iptables -V &> /dev/null; then
 			mptcp_lib_print_warn "SKIP: Could not run all tests without iptables tool"
-			exit $ksft_skip
+			exit ${KSFT_SKIP}
 		elif ! ip6tables -V &> /dev/null; then
 			mptcp_lib_print_warn "SKIP: Could not run all tests without ip6tables tool"
-			exit $ksft_skip
+			exit ${KSFT_SKIP}
 		fi
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 3305f1a7249b..75b9a6a5b5c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -3,8 +3,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ksft_skip=4
-
 mptcp_lib_ns_init
 
 add_mark_rules()
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 714f69de6fda..6ff0420b7ac1 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -3,8 +3,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ksft_skip=4
-
 usage() {
 	echo "Usage: $0 [ -h ]"
 }
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index dd249ba32cc2..ecf29ce332c5 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_ns_init
-ksft_skip=4
 bail=0
 slack=50
 large=""
-- 
2.35.3

