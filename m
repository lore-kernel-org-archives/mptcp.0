Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B251026
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832587; cv=none; b=ofOr+VBCno2hr7xwGGxzqpGJ20FF2Ey9jy1v+j/yleHmhxdTu89DWjHkx02UymGdbEdzsYhjBV01NNdDodsvf0u65+zAeYW9gaUsBKLKt7iWj5gJzI4qLXWd6ey+3mZqPJAgjSu5vIf/DYTOMMmCwvsV8pTdGy3HtseKEwPovYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832587; c=relaxed/simple;
	bh=onBa+QOXGSs8ulfARtzvP8lb9lvbUPk4nh3KTLhgVLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oywKH+g24wrqHoUbV8rgUE73E4x5g+y45pz+igSk6y0Dlsmb65pci/vOunchi8pD1QOTdNCnRl9hhkdjwHPB//KBTjrFTX30M8+EUbq4oi41RNF9oa2T5WSR+9CRTbsSj6kLjsE9ViiePTNMz8I/kSOu1ujKNZnNQ/7R2WLd3ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOGd8Gyu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOGd8Gyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A51C433A6;
	Tue, 19 Mar 2024 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710832587;
	bh=onBa+QOXGSs8ulfARtzvP8lb9lvbUPk4nh3KTLhgVLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOGd8GyuqXhjQP3Cd+9t40Zp2IkNNcFjgnOuP9ri/5LeDD0Wfp1J2WRwdBsC/pLhr
	 ugIlIOwGLto+4ZijP+1d6A0labz7M7Vfd3YI7Yg0p8MZDJ0mG+3+BYVowDvVJSoeF3
	 x2c8RmttXJFZUHbFLNcGU0E4k9N2l2wS0DieiALTwBiwwNi2IGGncDMTKEPiKnAw7N
	 cn/LNBUoicBz7hPT6Q7iZpgpmYFi/HQRADA4yQN3/eoePbDcgUtCv2pt2OuFffFbDO
	 x4VpChOudDQjzRosRs8QoyVq3bYD3GyNsNQl/bgcpiKVpS/Yn5fOaNd4Bo/5HpBZFD
	 8oeQJA9gs/oBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/9] selftests: mptcp: add get_endpoint helper
Date: Tue, 19 Mar 2024 15:16:09 +0800
Message-Id: <95b2607b75ac0225a4bff3d863d786b7a0db999b.1710832493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710832493.git.tanggeliang@kylinos.cn>
References: <cover.1710832493.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The output formats of 'ip mptcp' commands are much different from that
of 'pm_nl_ctl' commands. This patch adds a new helper format_endpoints()
to format the outputs of 'ip mptcp' and 'pm_nl_ctl' with 'endpoints'
arguments to hide these differences.

All endpoints are showed in show_endpoints(). Here add another helper
named get_endpoint() to show a specofic endpoint identified by the given
address ID.

Usage:
	All endpoints - show_endpoints $ns
	One endpoint - get_endpoint $ns $id

Use these two helpers in mptcp_join.sh and pm_netlink.sh to replace all
'pm_nl_ctl get' commands and outputs of 'pm_nl_ctl dump/get'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh |  32 +-----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  34 ++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh | 101 ++++++++++--------
 3 files changed, 96 insertions(+), 71 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 62fcfeaa3430..d48da81daa06 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -712,12 +712,9 @@ pm_nl_check_endpoint()
 	local ns=$2
 	local addr=$3
 	local _flags=""
-	local flags
 	local _port
-	local port
 	local dev
 	local _id
-	local id
 
 	print_check "${msg}"
 
@@ -725,48 +722,29 @@ pm_nl_check_endpoint()
 	while [ -n "$1" ]; do
 		if [ $1 = "flags" ]; then
 			_flags=$2
-			[ -n "$_flags" ]; flags="flags $_flags"
 			shift
 		elif [ $1 = "dev" ]; then
-			[ -n "$2" ]; dev="dev $2"
+			[ -n "$2" ]; dev="$2"
 			shift
 		elif [ $1 = "id" ]; then
 			_id=$2
-			[ -n "$_id" ]; id="id $_id"
 			shift
 		elif [ $1 = "port" ]; then
 			_port=$2
-			[ -n "$_port" ]; port=" port $_port"
 			shift
 		fi
 
 		shift
 	done
 
-	if [ -z "$id" ]; then
+	if [ -z "${_id}" ]; then
 		test_fail "bad test - missing endpoint id"
 		return
 	fi
 
-	if mptcp_lib_is_ip_mptcp; then
-		# get line and trim trailing whitespace
-		line=$(ip -n $ns mptcp endpoint show $id)
-		line="${line% }"
-		# the dump order is: address id flags port dev
-		[ -n "$addr" ] && expected_line="$addr"
-		expected_line+=" $id"
-		[ -n "$_flags" ] && expected_line+=" ${_flags//","/" "}"
-		[ -n "$dev" ] && expected_line+=" $dev"
-		[ -n "$port" ] && expected_line+=" $port"
-	else
-		line=$(ip netns exec $ns ./pm_nl_ctl get $_id)
-		# the dump order is: id flags dev address port
-		expected_line="$id"
-		[ -n "$flags" ] && expected_line+=" $flags"
-		[ -n "$dev" ] && expected_line+=" $dev"
-		[ -n "$addr" ] && expected_line+=" $addr"
-		[ -n "$_port" ] && expected_line+=" $_port"
-	fi
+	line=$(mptcp_lib_pm_nl_get_endpoint "${ns}" "${_id}")
+	expected_line=$(mptcp_lib_pm_nl_format_endpoints \
+		"${_id},${addr},${_flags//","/" "},${dev},${_port}")
 	if [ "$line" = "$expected_line" ]; then
 		print_ok
 	else
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ca01d949fad8..ceb8f272c69d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -520,3 +520,37 @@ mptcp_lib_set_ip_mptcp() {
 mptcp_lib_is_ip_mptcp() {
 	[ "${MPTCP_LIB_IP_MPTCP}" = "1" ]
 }
+
+# format: <id>,<ip>,<flags>,<dev>
+mptcp_lib_pm_nl_format_endpoints() {
+	local entry id ip flags dev port
+
+	for entry in "${@}"; do
+		IFS=, read -r id ip flags dev port <<< "${entry}"
+		if mptcp_lib_is_ip_mptcp; then
+			echo -n "${ip}"
+			[ -n "${port}" ] && echo -n " port ${port}"
+			echo -n " id ${id}"
+			[ -n "${flags}" ] && echo -n " ${flags}"
+			[ -n "${dev}" ] && echo -n " dev ${dev}"
+			echo " " # always a space at the end
+		else
+			echo -n "id ${id}"
+			echo -n " flags ${flags//" "/","}"
+			[ -n "${dev}" ] && echo -n " dev ${dev}"
+			echo -n " ${ip}"
+			[ -n "${port}" ] && echo " ${port}" || echo ""
+		fi
+	done
+}
+
+mptcp_lib_pm_nl_get_endpoint() {
+	local ns=${1}
+	local id=${2}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns}" mptcp endpoint show id "${id}"
+	else
+		ip netns exec "${ns}" ./pm_nl_ctl get "${id}"
+	fi
+}
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index d672d1e5d470..ff4355db03cd 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -66,6 +66,14 @@ get_limits() {
 	fi
 }
 
+format_endpoints() {
+	mptcp_lib_pm_nl_format_endpoints "${@}"
+}
+
+get_endpoint() {
+	mptcp_lib_pm_nl_get_endpoint "${ns1}" "${@}"
+}
+
 check()
 {
 	local cmd="$1"
@@ -97,43 +105,44 @@ fi
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
-check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1" "simple add/get addr"
+check "get_endpoint 1" "$(format_endpoints "1,10.0.1.1")" "simple add/get addr"
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 2 flags subflow dev lo 10.0.1.2
-id 3 flags signal,backup 10.0.1.3" "dump addrs"
+	"$(format_endpoints "1,10.0.1.1" \
+			    "2,10.0.1.2,subflow,lo" \
+			    "3,10.0.1.3,signal backup")" "dump addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl del 2
-check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
+check "get_endpoint 2" "" "simple del addr"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3" "dump addrs after del"
+	"$(format_endpoints "1,10.0.1.1" \
+			    "3,10.0.1.3,signal backup")" "dump addrs after del"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
+check "get_endpoint 4" "" "duplicate addr"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4" "id addr increment"
+check "get_endpoint 4" "$(format_endpoints "4,10.0.1.4,signal")" "id addr increment"
 
 for i in $(seq 5 9); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
 done
-check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9" "hard addr limit"
-check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
+check "get_endpoint 9" "$(format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
+check "get_endpoint 10" "" "above hard addr limit"
 
 ip netns exec $ns1 ./pm_nl_ctl del 9
 for i in $(seq 10 255); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
 	ip netns exec $ns1 ./pm_nl_ctl del $i
 done
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3
-id 4 flags signal 10.0.1.4
-id 5 flags signal 10.0.1.5
-id 6 flags signal 10.0.1.6
-id 7 flags signal 10.0.1.7
-id 8 flags signal 10.0.1.8" "id limit"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(format_endpoints "1,10.0.1.1" \
+			    "3,10.0.1.3,signal backup" \
+			    "4,10.0.1.4,signal" \
+			    "5,10.0.1.5,signal" \
+			    "6,10.0.1.6,signal" \
+			    "7,10.0.1.7,signal" \
+			    "8,10.0.1.8,signal")" "id limit"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
@@ -156,14 +165,15 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.5 id 254
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.6
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.7
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1
-id 2 flags  10.0.1.2
-id 3 flags  10.0.1.7
-id 4 flags  10.0.1.8
-id 100 flags  10.0.1.3
-id 101 flags  10.0.1.4
-id 254 flags  10.0.1.5
-id 255 flags  10.0.1.6" "set ids"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(format_endpoints "1,10.0.1.1" \
+			    "2,10.0.1.2" \
+			    "3,10.0.1.7" \
+			    "4,10.0.1.8" \
+			    "100,10.0.1.3" \
+			    "101,10.0.1.4" \
+			    "254,10.0.1.5" \
+			    "255,10.0.1.6")" "set ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
@@ -174,36 +184,39 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.6
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.7
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.0.1
-id 2 flags  10.0.0.4
-id 3 flags  10.0.0.6
-id 4 flags  10.0.0.7
-id 5 flags  10.0.0.8
-id 253 flags  10.0.0.5
-id 254 flags  10.0.0.2
-id 255 flags  10.0.0.3" "wrap-around ids"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(format_endpoints "1,10.0.0.1" \
+			    "2,10.0.0.4" \
+			    "3,10.0.0.6" \
+			    "4,10.0.0.7" \
+			    "5,10.0.0.8" \
+			    "253,10.0.0.5" \
+			    "254,10.0.0.2" \
+			    "255,10.0.0.3")" "wrap-around ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup 10.0.1.1" "set flags (backup)"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow backup")" \
+	"set flags (backup)"
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nobackup)"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow")" \
+	"          (nobackup)"
 
 # fullmesh support has been added later
 ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh 2>/dev/null
 if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,fullmesh 10.0.1.1" "          (fullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"$(format_endpoints "1,10.0.1.1,subflow fullmesh")" \
+		"          (fullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nofullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow")" \
+		"          (nofullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"$(format_endpoints "1,10.0.1.1,subflow backup fullmesh")" \
+		"          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"
-- 
2.40.1

