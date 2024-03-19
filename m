Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C950A80
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832594; cv=none; b=f79Z++dwpiM2b86zr5XEsYlhzYJ2hKp/gRJOSEqViRSWEzLIv12qDAdHz5MpAYGcUoe0Kx1M8uBjA0qghmZbMWxjB3fq26gmSKlyhID1K+8iFHgjDyCjwOG4JG5QmBPPS8zByVgqbiIZI9WND0q++WR/8L7q61EolqCG8qah57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832594; c=relaxed/simple;
	bh=yBLBtcHWZ9j5RmHo0Ga69C39K5AYTAc2K294wXI+WCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yh5DTsSHGrkFop0LTXGfoXEUh5yiKubVefJpa2ypCvC7GtlXaI8EppzDr4/nMP2TIUPM4pv+Jm/Ys0BG5T0592mFQHhx2n6owNhO7THzkltqkm6IwN3F9K6hAtg2f6ts6AkoDoHHxfRmh1B7ybyKUAnPHHi+AhjGHCqDvERnD0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfje9Bxn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfje9Bxn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C20BC43394;
	Tue, 19 Mar 2024 07:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710832594;
	bh=yBLBtcHWZ9j5RmHo0Ga69C39K5AYTAc2K294wXI+WCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfje9BxnvBMpXZJu2Ra+HOZgaYOgWomS0xsPhqvX/PIdRmAa/f2CtfvQ7GTbd3OU1
	 o/QBCwimvdjSvQ1zWNqC8gR6F+cnNPXGxR86c4IZ3xx6scdaG3xIXQbwLgmddRe03+
	 KKbjBnoH4VsLEXWJMJ+Bel8+ahkbcF6yNShpqQoT8Bwiwyb78gJ+zA9hr9vcvT+owf
	 uDeYBVVSXvA6/XEzGm+SN37Wge+PIPJLI6cqm6zFuB+F6XdI8ccqr4kzcpNEwyQw0M
	 YKlt4k7uyLuVQ15N5C1W34TFXyGWils0lHho5jhhg0rj7YmGP5aqPOBQFuPlJAfxi9
	 23AtB3xvqQgAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 7/9] selftests: mptcp: use pm_nl endpoint ops
Date: Tue, 19 Mar 2024 15:16:13 +0800
Message-Id: <69cd110c2443af9e499eaa426c8984cc240b1de6.1710832493.git.tanggeliang@kylinos.cn>
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

Use those newly added pm_nl endpoint ops helpers to replace all 'pm_nl_ctl'
commands with 'limits', 'add', 'del', 'flush', 'show' and 'set' arguments
in scripts mptcp_sockopt.sh and simult_flows.sh.

In pm_netlink.sh, add wrappers of there helpers to make the function names
shorter. Then use the wrappers to replace all 'pm_nl_ctl' commands.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  12 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh | 132 +++++++++++-------
 .../selftests/net/mptcp/simult_flows.sh       |   6 +-
 3 files changed, 89 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e2d70c18786e..36e81383f0e2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -58,15 +58,15 @@ init()
 		# let $ns2 reach any $ns1 address from any interface
 		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
 
-		ip netns exec $ns1 ./pm_nl_ctl add 10.0.$i.1 flags signal
-		ip netns exec $ns1 ./pm_nl_ctl add dead:beef:$i::1 flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns1}" "10.0.${i}.1" flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns1}" "dead:beef:${i}::1" flags signal
 
-		ip netns exec $ns2 ./pm_nl_ctl add 10.0.$i.2 flags signal
-		ip netns exec $ns2 ./pm_nl_ctl add dead:beef:$i::2 flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns2}" "10.0.${i}.2" flags signal
+		mptcp_lib_pm_nl_add_endpoint "${ns2}" "dead:beef:${i}::2" flags signal
 	done
 
-	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
+	mptcp_lib_pm_nl_set_limits "${ns2}" 8 8
 
 	add_mark_rules $ns1 1
 	add_mark_rules $ns2 2
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 08b78007e8c1..d648383989d2 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -85,6 +85,36 @@ change_address() {
 	fi
 }
 
+set_limits()
+{
+	mptcp_lib_pm_nl_set_limits "${ns1}" "${@}"
+}
+
+add_endpoint()
+{
+	mptcp_lib_pm_nl_add_endpoint "${ns1}" "${@}"
+}
+
+del_endpoint()
+{
+	mptcp_lib_pm_nl_del_endpoint "${ns1}" "${@}"
+}
+
+flush_endpoint()
+{
+	mptcp_lib_pm_nl_flush_endpoint "${ns1}"
+}
+
+show_endpoints()
+{
+	mptcp_lib_pm_nl_show_endpoints "${ns1}"
+}
+
+change_endpoint()
+{
+	mptcp_lib_pm_nl_change_endpoint "${ns1}" "${@}"
+}
+
 check()
 {
 	local cmd="$1"
@@ -106,47 +136,47 @@ check()
 	fi
 }
 
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
+check "show_endpoints" "" "defaults addr list"
 
 default_limits="$(get_limits)"
 if mptcp_lib_expect_all_features; then
 	check "get_limits" "$(format_limits 0 2)" "defaults limits"
 fi
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
+add_endpoint 10.0.1.1
+add_endpoint 10.0.1.2 flags subflow dev lo
+add_endpoint 10.0.1.3 flags signal,backup
 check "get_endpoint 1" "$(format_endpoints "1,10.0.1.1")" "simple add/get addr"
 
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "2,10.0.1.2,subflow,lo" \
 			    "3,10.0.1.3,signal backup")" "dump addrs"
 
-ip netns exec $ns1 ./pm_nl_ctl del 2
+del_endpoint 2
 check "get_endpoint 2" "" "simple del addr"
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "3,10.0.1.3,signal backup")" "dump addrs after del"
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
+add_endpoint 10.0.1.3 2>/dev/null
 check "get_endpoint 4" "" "duplicate addr"
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
+add_endpoint 10.0.1.4 flags signal
 check "get_endpoint 4" "$(format_endpoints "4,10.0.1.4,signal")" "id addr increment"
 
 for i in $(seq 5 9); do
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
+	add_endpoint "10.0.1.${i}" flags signal >/dev/null 2>&1
 done
 check "get_endpoint 9" "$(format_endpoints "9,10.0.1.9,signal")" "hard addr limit"
 check "get_endpoint 10" "" "above hard addr limit"
 
-ip netns exec $ns1 ./pm_nl_ctl del 9
+del_endpoint 9
 for i in $(seq 10 255); do
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
-	ip netns exec $ns1 ./pm_nl_ctl del $i
+	add_endpoint 10.0.0.9 id "${i}"
+	del_endpoint "${i}"
 done
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "3,10.0.1.3,signal backup" \
 			    "4,10.0.1.4,signal" \
@@ -155,28 +185,28 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 			    "7,10.0.1.7,signal" \
 			    "8,10.0.1.8,signal")" "id limit"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
+flush_endpoint
+check "show_endpoints" "" "flush addrs"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 9 1 2>/dev/null
+set_limits 9 1 2>/dev/null
 check "get_limits" "${default_limits}" "rcv addrs above hard limit"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
+set_limits 1 9 2>/dev/null
 check "get_limits" "${default_limits}" "subflows above hard limit"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+set_limits 8 8
 check "get_limits" "$(format_limits 8 8)" "set limits"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 id 100
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.5 id 254
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.6
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.7
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+flush_endpoint
+add_endpoint 10.0.1.1
+add_endpoint 10.0.1.2
+add_endpoint 10.0.1.3 id 100
+add_endpoint 10.0.1.4
+add_endpoint 10.0.1.5 id 254
+add_endpoint 10.0.1.6
+add_endpoint 10.0.1.7
+add_endpoint 10.0.1.8
+check "show_endpoints" \
 	"$(format_endpoints "1,10.0.1.1" \
 			    "2,10.0.1.2" \
 			    "3,10.0.1.7" \
@@ -186,16 +216,16 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 			    "254,10.0.1.5" \
 			    "255,10.0.1.6")" "set ids"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.2 id 254
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.3
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.4
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.6
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.7
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.8
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+flush_endpoint
+add_endpoint 10.0.0.1
+add_endpoint 10.0.0.2 id 254
+add_endpoint 10.0.0.3
+add_endpoint 10.0.0.4
+add_endpoint 10.0.0.5 id 253
+add_endpoint 10.0.0.6
+add_endpoint 10.0.0.7
+add_endpoint 10.0.0.8
+check "show_endpoints" \
 	"$(format_endpoints "1,10.0.0.1" \
 			    "2,10.0.0.4" \
 			    "3,10.0.0.6" \
@@ -205,28 +235,26 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 			    "254,10.0.0.2" \
 			    "255,10.0.0.3")" "wrap-around ids"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
+flush_endpoint
+add_endpoint 10.0.1.1 flags subflow
 change_address 10.0.1.1 backup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow backup")" \
+check "show_endpoints" "$(format_endpoints "1,10.0.1.1,subflow backup")" \
 	"set flags (backup)"
 change_address 10.0.1.1 nobackup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow")" \
+check "show_endpoints" "$(format_endpoints "1,10.0.1.1,subflow")" \
 	"          (nobackup)"
 
 # fullmesh support has been added later
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh 2>/dev/null
-if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
+change_endpoint 1 fullmesh 2>/dev/null
+if show_endpoints | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-		"$(format_endpoints "1,10.0.1.1,subflow fullmesh")" \
+	check "show_endpoints" "$(format_endpoints "1,10.0.1.1,subflow fullmesh")" \
 		"          (fullmesh)"
-	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow")" \
+	change_endpoint 1 nofullmesh
+	check "show_endpoints" "$(format_endpoints "1,10.0.1.1,subflow")" \
 		"          (nofullmesh)"
-	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-		"$(format_endpoints "1,10.0.1.1,subflow backup fullmesh")" \
+	change_endpoint 1 backup,fullmesh
+	check "show_endpoints" "$(format_endpoints "1,10.0.1.1,subflow backup fullmesh")" \
 		"          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e129fcb5a598..acc49fa652a2 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -85,8 +85,8 @@ setup()
 	ip -net "$ns1" route add default via 10.0.2.2 metric 101
 	ip -net "$ns1" route add default via dead:beef:2::2 metric 101
 
-	ip netns exec "$ns1" ./pm_nl_ctl limits 1 1
-	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
+	mptcp_lib_pm_nl_set_limits "${ns1}" 1 1
+	mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.2.1 dev ns1eth2 flags subflow
 
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
@@ -108,7 +108,7 @@ setup()
 	ip -net "$ns3" route add default via 10.0.3.2
 	ip -net "$ns3" route add default via dead:beef:3::2
 
-	ip netns exec "$ns3" ./pm_nl_ctl limits 1 1
+	mptcp_lib_pm_nl_set_limits "${ns3}" 1 1
 
 	# debug build can slow down measurably the test program
 	# we use quite tight time limit on the run-time, to ensure
-- 
2.40.1

