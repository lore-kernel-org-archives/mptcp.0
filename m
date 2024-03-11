Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40510E3
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121748; cv=none; b=Y4SSHMvcFOJZHPczJ9OOR3zcJcVTdBRNjap9zAStpTZaqhC0qwOLG5e1/Fp2SZB/PhQLvHFlYX4eOEYWhuppWCs5/PDnwb1/75o2FSGuUFTywJfGC2sI7M8ZMEoxcnYyfaoZ2ZITg840BczIBJMYm/CY+x+Sw+qFXv8nsENPnig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121748; c=relaxed/simple;
	bh=RArxbb5BXTREJwSuoub6rEkPGfORJmJLjkhM7QdPPlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKEnlysHNzuHT8WzrE3FThtVe7/t4fp9oqPrkVsqqlIcr6QAO5opyiH40LBPzFfdB5bUB19dm3GGXEUr6crv5OMGynYsB6Tue8XfWNZkqCa3JBby7NptkQ+DiShCS74/UC7x8EHC/xhKuWX7K4AUt1YViS30FtjJuvyUsru5c0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3mfvCDm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3mfvCDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5CBC433F1;
	Mon, 11 Mar 2024 01:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710121747;
	bh=RArxbb5BXTREJwSuoub6rEkPGfORJmJLjkhM7QdPPlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3mfvCDm8NUqFHCh4r+lEM9WeJktQZngvmgmPzsnu4ZQhH9EZgWhdT5zra+HHqoTU
	 RAEkBPJrNrczwzhBUa0MXWFLf4nbW6mgTsm00fU+lWqlt6TwjFfWvDh+AZ6MzOE3Zo
	 Mo6UGjePl4UUaJl3EpurJrgFfch26RjWPXASmGUfG94D13tf0E5Pgm4+beACZsWpeX
	 EHhOVPao/yRG7gGH9d8FherwiB6DywW4Ut0ocF2zg44HN9g0wf89huBvNeAT7Sgm5/
	 F/MRO/SlKqPNwRJWAsq4H/SjEI2PCo1r2pNoXScu+72C8YDrR4j+kg9hPEQHxSTcE1
	 twS6RvG/CEmhw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 08/10] selftests: mptcp: use mptcp_lib_endpoint_ops
Date: Mon, 11 Mar 2024 09:48:45 +0800
Message-Id: <fa7349687343c72e376ccf49eeb2d370b464839e.1710121590.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710121590.git.tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses the newly added mptcp_lib_endpoint_ops() helper with "add",
"del", "flush", "show" or "change" arguments to place 'pm_nl_ctl add/del/
flush/show/get/set' commands in scripts mptcp_join.sh, mptcp_sockopt.sh,
pm_netlink.sh and simult_flows.sh.

        ip netns exec $ns pm_nl_ctl add $addr flags $flags
        ->
        mptcp_lib_endpoint_ops add $ns $addr flags $flags

        ip netns exec $ns pm_nl_ctl del $id
        ->
        mptcp_lib_endpoint_ops del $ns $id

        ip netns exec $ns pm_nl_ctl flush
        ->
        mptcp_lib_endpoint_ops flush $ns

        ip netns exec $ns pm_nl_ctl set id $id flags $flags
        ->
        mptcp_lib_endpoint_ops change $ns id $id $flags

        ip netns exec $ns pm_nl_ctl set $addr flags $flags
        ->
        mptcp_lib_endpoint_ops change $ns $addr $flags

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh |   3 +-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  12 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh | 130 +++++++++---------
 .../selftests/net/mptcp/simult_flows.sh       |   6 +-
 4 files changed, 75 insertions(+), 76 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8e35f875147b..1052b85d8170 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -681,9 +681,9 @@ pm_nl_check_endpoint()
 		return
 	fi
 
+	line=$(mptcp_lib_endpoint_ops show "${ns}" "${_id}")
 	if mptcp_lib_is_ip_mptcp; then
 		# get line and trim trailing whitespace
-		line=$(ip -n $ns mptcp endpoint show $id)
 		line="${line% }"
 		# the dump order is: address id flags port dev
 		[ -n "$addr" ] && expected_line="$addr"
@@ -692,7 +692,6 @@ pm_nl_check_endpoint()
 		[ -n "$dev" ] && expected_line+=" $dev"
 		[ -n "$port" ] && expected_line+=" $port"
 	else
-		line=$(ip netns exec $ns ./pm_nl_ctl get $_id)
 		# the dump order is: id flags dev address port
 		expected_line="$id"
 		[ -n "$flags" ] && expected_line+=" $flags"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e2d70c18786e..84cf00f8bb7f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -58,15 +58,15 @@ init()
 		# let $ns2 reach any $ns1 address from any interface
 		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
 
-		ip netns exec $ns1 ./pm_nl_ctl add 10.0.$i.1 flags signal
-		ip netns exec $ns1 ./pm_nl_ctl add dead:beef:$i::1 flags signal
+		mptcp_lib_endpoint_ops add "${ns1}" "10.0.${i}.1" flags signal
+		mptcp_lib_endpoint_ops add "${ns1}" "dead:beef:${i}::1" flags signal
 
-		ip netns exec $ns2 ./pm_nl_ctl add 10.0.$i.2 flags signal
-		ip netns exec $ns2 ./pm_nl_ctl add dead:beef:$i::2 flags signal
+		mptcp_lib_endpoint_ops add "${ns2}" "10.0.${i}.2" flags signal
+		mptcp_lib_endpoint_ops add "${ns2}" "dead:beef:${i}::2" flags signal
 	done
 
-	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	mptcp_lib_endpoint_ops limits "${ns1}" 8 8
+	mptcp_lib_endpoint_ops limits "${ns2}" 8 8
 
 	add_mark_rules $ns1 1
 	add_mark_rules $ns2 2
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 2096c52b3a4b..183146e58ec2 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -67,21 +67,21 @@ check()
 	fi
 }
 
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
+check "mptcp_lib_endpoint_ops show ${ns1}" "" "defaults addr list"
 
-default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+default_limits="$(mptcp_lib_endpoint_ops limits "${ns1}")"
 if mptcp_lib_expect_all_features; then
 	limits=$'accept 0\nsubflows 2'
 	mptcp_lib_is_ip_mptcp && limits="add_addr_accepted 0 subflows 2 "
-	check "ip netns exec $ns1 ./pm_nl_ctl limits" "${limits}" "defaults limits"
+	check "mptcp_lib_endpoint_ops limits ${ns1}" "${limits}" "defaults limits"
 fi
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.1
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.2 flags subflow dev lo
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.3 flags signal,backup
 endpoint="id 1 flags  10.0.1.1"
 mptcp_lib_is_ip_mptcp && endpoint="10.0.1.1 id 1 "
-check "ip netns exec $ns1 ./pm_nl_ctl get 1" "${endpoint}" "simple add/get addr"
+check "mptcp_lib_endpoint_ops show ${ns1} 1" "${endpoint}" "simple add/get addr"
 
 dump="$(printf '%s\n' \
 	"id 1 flags  10.0.1.1" \
@@ -92,36 +92,36 @@ dump="$(printf '%s\n' \
 	"10.0.1.1 id 1 " \
 	"10.0.1.2 id 2 subflow dev lo " \
 	"10.0.1.3 id 3 signal backup ")"
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "mptcp_lib_endpoint_ops show ${ns1}" \
 	"${dump}" "dump addrs"
 
-ip netns exec $ns1 ./pm_nl_ctl del 2
+mptcp_lib_endpoint_ops del "${ns1}" 2
 dump=$'id 1 flags  10.0.1.1\nid 3 flags signal,backup 10.0.1.3'
 mptcp_lib_is_ip_mptcp && dump=$'10.0.1.1 id 1 \n10.0.1.3 id 3 signal backup '
-check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
-check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+check "mptcp_lib_endpoint_ops show ${ns1} 2" "" "simple del addr"
+check "mptcp_lib_endpoint_ops show ${ns1}" \
 	"${dump}" "dump addrs after del"
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.3 2>/dev/null
+check "mptcp_lib_endpoint_ops show ${ns1} 4" "" "duplicate addr"
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.4 flags signal
 endpoint="id 4 flags signal 10.0.1.4"
 mptcp_lib_is_ip_mptcp && endpoint="10.0.1.4 id 4 signal "
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "${endpoint}" "id addr increment"
+check "mptcp_lib_endpoint_ops show ${ns1} 4" "${endpoint}" "id addr increment"
 
 for i in $(seq 5 9); do
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
+	mptcp_lib_endpoint_ops add "${ns1}" "10.0.1.${i}" flags signal >/dev/null 2>&1
 done
 endpoint="id 9 flags signal 10.0.1.9"
 mptcp_lib_is_ip_mptcp && endpoint="10.0.1.9 id 9 signal "
-check "ip netns exec $ns1 ./pm_nl_ctl get 9" "${endpoint}" "hard addr limit"
-check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
+check "mptcp_lib_endpoint_ops show ${ns1} 9" "${endpoint}" "hard addr limit"
+check "mptcp_lib_endpoint_ops show ${ns1} 10" "" "above hard addr limit"
 
-ip netns exec $ns1 ./pm_nl_ctl del 9
+mptcp_lib_endpoint_ops del "${ns1}" 9
 for i in $(seq 10 255); do
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.9 id $i
-	ip netns exec $ns1 ./pm_nl_ctl del $i
+	mptcp_lib_endpoint_ops add "${ns1}" 10.0.0.9 id "${i}"
+	mptcp_lib_endpoint_ops del "${ns1}" "${i}"
 done
 dump="$(printf '%s\n' \
 	"id 1 flags  10.0.1.1" \
@@ -140,31 +140,31 @@ dump="$(printf '%s\n' \
 	"10.0.1.6 id 6 signal " \
 	"10.0.1.7 id 7 signal " \
 	"10.0.1.8 id 8 signal ")"
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "id limit"
+check "mptcp_lib_endpoint_ops show ${ns1}" "${dump}" "id limit"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
+mptcp_lib_endpoint_ops flush "${ns1}"
+check "mptcp_lib_endpoint_ops show ${ns1}" "" "flush addrs"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 9 1 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
+mptcp_lib_endpoint_ops limits "${ns1}" 9 1 2>/dev/null
+check "mptcp_lib_endpoint_ops limits ${ns1}" "${default_limits}" "rcv addrs above hard limit"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
+mptcp_lib_endpoint_ops limits "${ns1}" 1 9 2>/dev/null
+check "mptcp_lib_endpoint_ops limits ${ns1}" "${default_limits}" "subflows above hard limit"
 
-ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+mptcp_lib_endpoint_ops limits "${ns1}" 8 8
 limits=$'accept 8\nsubflows 8'
 mptcp_lib_is_ip_mptcp && limits="add_addr_accepted 8 subflows 8 "
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "${limits}" "set limits"
-
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 id 100
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.5 id 254
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.6
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.7
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.8
+check "mptcp_lib_endpoint_ops limits ${ns1}" "${limits}" "set limits"
+
+mptcp_lib_endpoint_ops flush "${ns1}"
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.1
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.2
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.3 id 100
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.4
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.5 id 254
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.6
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.7
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.8
 dump="$(printf '%s\n' \
 	"id 1 flags  10.0.1.1" \
 	"id 2 flags  10.0.1.2" \
@@ -184,17 +184,17 @@ dump="$(printf '%s\n' \
 	"10.0.1.4 id 101 " \
 	"10.0.1.5 id 254 " \
 	"10.0.1.6 id 255 ")"
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "set ids"
-
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.2 id 254
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.3
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.4
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.6
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.7
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.8
+check "mptcp_lib_endpoint_ops show ${ns1}" "${dump}" "set ids"
+
+mptcp_lib_endpoint_ops flush "${ns1}"
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.0.1
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.0.2 id 254
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.0.3
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.0.4
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.0.5 id 253
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.0.6
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.0.7
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.0.8
 dump="$(printf '%s\n' \
 	"id 1 flags  10.0.0.1" \
 	"id 2 flags  10.0.0.4" \
@@ -214,34 +214,34 @@ dump="$(printf '%s\n' \
 	"10.0.0.5 id 253 " \
 	"10.0.0.2 id 254 " \
 	"10.0.0.3 id 255 ")"
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "wrap-around ids"
+check "mptcp_lib_endpoint_ops show ${ns1}" "${dump}" "wrap-around ids"
 
-ip netns exec $ns1 ./pm_nl_ctl flush
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
-ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
+mptcp_lib_endpoint_ops flush "${ns1}"
+mptcp_lib_endpoint_ops add "${ns1}" 10.0.1.1 flags subflow
+mptcp_lib_endpoint_ops change "${ns1}" 10.0.1.1 backup
 dump="id 1 flags subflow,backup 10.0.1.1"
 mptcp_lib_is_ip_mptcp && dump="10.0.1.1 id 1 subflow backup "
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "set flags (backup)"
-ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
+check "mptcp_lib_endpoint_ops show ${ns1}" "${dump}" "set flags (backup)"
+mptcp_lib_endpoint_ops change "${ns1}" 10.0.1.1 nobackup
 dump="id 1 flags subflow 10.0.1.1"
 mptcp_lib_is_ip_mptcp && dump="10.0.1.1 id 1 subflow "
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (nobackup)"
+check "mptcp_lib_endpoint_ops show ${ns1}" "${dump}" "          (nobackup)"
 
 # fullmesh support has been added later
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh 2>/dev/null
-if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
+mptcp_lib_endpoint_ops change "${ns1}" 1 fullmesh 2>/dev/null
+if mptcp_lib_endpoint_ops show "${ns1}" | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
 	dump="id 1 flags subflow,fullmesh 10.0.1.1"
 	mptcp_lib_is_ip_mptcp && dump="10.0.1.1 id 1 subflow fullmesh "
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (fullmesh)"
-	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
+	check "mptcp_lib_endpoint_ops show ${ns1}" "${dump}" "          (fullmesh)"
+	mptcp_lib_endpoint_ops change "${ns1}" 1 nofullmesh
 	dump="id 1 flags subflow 10.0.1.1"
 	mptcp_lib_is_ip_mptcp && dump="10.0.1.1 id 1 subflow "
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (nofullmesh)"
-	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
+	check "mptcp_lib_endpoint_ops show ${ns1}" "${dump}" "          (nofullmesh)"
+	mptcp_lib_endpoint_ops change "${ns1}" 1 backup,fullmesh
 	dump="id 1 flags subflow,backup,fullmesh 10.0.1.1"
 	mptcp_lib_is_ip_mptcp && dump="10.0.1.1 id 1 subflow backup fullmesh "
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (backup,fullmesh)"
+	check "mptcp_lib_endpoint_ops show ${ns1}" "${dump}" "          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 68ee92eccccb..2cacd3ed9955 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -85,8 +85,8 @@ setup()
 	ip -net "$ns1" route add default via 10.0.2.2 metric 101
 	ip -net "$ns1" route add default via dead:beef:2::2 metric 101
 
-	ip netns exec "$ns1" ./pm_nl_ctl limits 1 1
-	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
+	mptcp_lib_endpoint_ops limits "${ns1}" 1 1
+	mptcp_lib_endpoint_ops add "${ns1}" 10.0.2.1 dev ns1eth2 flags subflow
 
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
@@ -108,7 +108,7 @@ setup()
 	ip -net "$ns3" route add default via 10.0.3.2
 	ip -net "$ns3" route add default via dead:beef:3::2
 
-	ip netns exec "$ns3" ./pm_nl_ctl limits 1 1
+	mptcp_lib_endpoint_ops limits "${ns3}" 1 1
 
 	# debug build can slow down measurably the test program
 	# we use quite tight time limit on the run-time, to ensure
-- 
2.40.1

