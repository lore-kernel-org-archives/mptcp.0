Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA557F6
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637144; cv=none; b=MxrFezeZNMOCN2Pk3sUxW83c8dhkDBMYxA6KxUvZ1iMJqoVgQCVOdsoajqAqlXOOr0Hl1vWzRzqAi4yl6X5p5MJ663z6khrM0f2QWahv+9PkVJgBBUUWMKCRZq1xQRI0TgruI4jHN0Tk+fWnApWgr61rRomAXQB4gT9cev73SNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637144; c=relaxed/simple;
	bh=VvKPKtECl3rTDnuWOSkzWnzl+UPnUwR5+vcG6ppvdKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KDBSFtKiq7i+su0e23/yqqArtXT3MLlovvYssiOJ4+3J/ITeerLZVYRPqhUM403CkoBlagJsq8JqA1x9E4YMbVQVpxAtfU0a71eFp0ldhFAD4bXuInE6jIcZ7ykbTPv1HSHXaCHWX1LGkWXx29wocWniPBnZcJ5it/vDER/dFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT4Mjr+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT4Mjr+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F61AC433C7;
	Sun, 17 Mar 2024 00:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637144;
	bh=VvKPKtECl3rTDnuWOSkzWnzl+UPnUwR5+vcG6ppvdKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MT4Mjr+ZpahjH+uf3hQsYTk7zo9kESBOtWd+s3pJYe0zQd/bzcgDWHI1cLW0XRwe2
	 S3ncfswNEXzYuAlY2vGlmvLTfC0a+4xwOQhI1ThB3xLnqgb77RasELLEylwrjfvr4j
	 7dgbgtCdQdRYo6l35mCAY8fj6kweFq/cLt78TtQQ89iktalyfb2tmeE4LzS2qYUHkl
	 bLHBl3FIUTLEVUeWCfeHO066Z3L0Uvd0zOPu8Ju2Qbc+8skuWwao4koH+/uojsgbsM
	 THEui71ZO1x9e2x1YMjehv8ppH1plFdftOUatBm0UE9+y0IbC5JNLMNaqdiOZix8GX
	 B/dStMh8fyjfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 06/12] selftests: mptcp: format endpoints outputs
Date: Sun, 17 Mar 2024 08:58:05 +0800
Message-Id: <cdc88da80150d3c9a6ad355795e797bb0663ca0f.1710636726.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710636726.git.tanggeliang@kylinos.cn>
References: <cover.1710636726.git.tanggeliang@kylinos.cn>
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

This is useful for exporting endpoint ops into mptcp_lib.sh

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 23 +++++
 .../testing/selftests/net/mptcp/pm_netlink.sh | 98 +++++++++++--------
 3 files changed, 83 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0bdb631a9ddc..3d0051b57ecd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -704,9 +704,7 @@ pm_nl_check_endpoint()
 	local ns=$2
 	local addr=$3
 	local _flags=""
-	local flags
 	local _port
-	local port
 	local dev
 	local _id
 	local id
@@ -717,10 +715,9 @@ pm_nl_check_endpoint()
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
@@ -728,7 +725,6 @@ pm_nl_check_endpoint()
 			shift
 		elif [ $1 = "port" ]; then
 			_port=$2
-			[ -n "$_port" ]; port=" port $_port"
 			shift
 		fi
 
@@ -741,24 +737,12 @@ pm_nl_check_endpoint()
 	fi
 
 	if mptcp_lib_is_ip_mptcp; then
-		# get line and trim trailing whitespace
 		line=$(ip -n $ns mptcp endpoint show $id)
-		line="${line% }"
-		# the dump order is: address id flags port dev
-		[ -n "$addr" ] && expected_line="$addr"
-		expected_line+=" $id"
-		[ -n "$_flags" ] && expected_line+=" ${_flags//","/" "}"
-		[ -n "$dev" ] && expected_line+=" $dev"
-		[ -n "$port" ] && expected_line+=" $port"
 	else
 		line=$(ip netns exec $ns ./pm_nl_ctl get $_id)
-		# the dump order is: id flags dev address port
-		expected_line="$id"
-		[ -n "$flags" ] && expected_line+=" $flags"
-		[ -n "$dev" ] && expected_line+=" $dev"
-		[ -n "$addr" ] && expected_line+=" $addr"
-		[ -n "$_port" ] && expected_line+=" $_port"
 	fi
+	expected_line=$(mptcp_lib_format_endpoints \
+		"${_id},${addr},${_flags//","/" "},${dev},${_port}")
 	if [ "$line" = "$expected_line" ]; then
 		print_ok
 	else
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d16b82f7e35a..92b89f3a7605 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -554,3 +554,26 @@ mptcp_lib_pm_nl_set_limits() {
 		ip netns exec "${ns}" ./pm_nl_ctl limits "${addrs}" "${subflows}"
 	fi
 }
+
+# format: <id>,<ip>,<flags>,<dev>
+mptcp_lib_format_endpoints() {
+	local entry id ip flags dev port
+
+	for entry in "${@}"; do
+		IFS=, read -r id ip flags dev port <<< "${entry}"
+		if mptcp_lib_is_ip_mptcp; then
+			echo -n "${ip}"
+			[ -n "${port}" ] && echo -n " port ${port}"
+		        echo -n " id ${id}"
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
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index d369096d0df8..95e393c95017 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -78,29 +78,34 @@ fi
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
-check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1" "simple add/get addr"
+check "ip netns exec $ns1 ./pm_nl_ctl get 1" \
+	"$(mptcp_lib_format_endpoints "1,10.0.1.1")" "simple add/get addr"
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 2 flags subflow dev lo 10.0.1.2
-id 3 flags signal,backup 10.0.1.3" "dump addrs"
+	"$(mptcp_lib_format_endpoints "1,10.0.1.1" \
+				      "2,10.0.1.2,subflow,lo" \
+				      "3,10.0.1.3,signal backup")" \
+	"dump addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl del 2
 check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3" "dump addrs after del"
+	"$(mptcp_lib_format_endpoints "1,10.0.1.1" \
+				      "3,10.0.1.3,signal backup")" \
+	"dump addrs after del"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4" "id addr increment"
+check "ip netns exec $ns1 ./pm_nl_ctl get 4" \
+	"$(mptcp_lib_format_endpoints "4,10.0.1.4,signal")" "id addr increment"
 
 for i in $(seq 5 9); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
 done
-check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9" "hard addr limit"
+check "ip netns exec $ns1 ./pm_nl_ctl get 9" \
+	"$(mptcp_lib_format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
 check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
 
 ip netns exec $ns1 ./pm_nl_ctl del 9
@@ -108,13 +113,15 @@ for i in $(seq 10 255); do
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
+	"$(mptcp_lib_format_endpoints "1,10.0.1.1" \
+				      "3,10.0.1.3,signal backup" \
+				      "4,10.0.1.4,signal" \
+				      "5,10.0.1.5,signal" \
+				      "6,10.0.1.6,signal" \
+				      "7,10.0.1.7,signal" \
+				      "8,10.0.1.8,signal")" \
+	"id limit"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
@@ -138,14 +145,16 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.5 id 254
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
+	"$(mptcp_lib_format_endpoints "1,10.0.1.1" \
+				      "2,10.0.1.2" \
+				      "3,10.0.1.7" \
+				      "4,10.0.1.8" \
+				      "100,10.0.1.3" \
+				      "101,10.0.1.4" \
+				      "254,10.0.1.5" \
+				      "255,10.0.1.6")" \
+	"set ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
@@ -156,36 +165,43 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
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
+	"$(mptcp_lib_format_endpoints "1,10.0.0.1" \
+				      "2,10.0.0.4" \
+				      "3,10.0.0.6" \
+				      "4,10.0.0.7" \
+				      "5,10.0.0.8" \
+				      "253,10.0.0.5" \
+				      "254,10.0.0.2" \
+				      "255,10.0.0.3")" \
+	"wrap-around ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup 10.0.1.1" "set flags (backup)"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow backup")" \
+	"set flags (backup)"
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nobackup)"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+	"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow")" \
+	"          (nobackup)"
 
 # fullmesh support has been added later
 ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh 2>/dev/null
 if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,fullmesh 10.0.1.1" "          (fullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow fullmesh")" \
+		"          (fullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nofullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow")" \
+		"          (nofullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+		"$(mptcp_lib_format_endpoints "1,10.0.1.1,subflow backup fullmesh")" \
+		"          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"
-- 
2.40.1

