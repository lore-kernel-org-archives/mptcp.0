Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762EAEBE
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121742; cv=none; b=nDoWC8A2l0ELVWo8696axZJiZu1RcIk02UzRwyl7ONPYHtl/ji4GA0EdwK9SqWdt18AjV/5sEHOi85a9bgQ2pAliVJkKHeygsWGT79fdUbjrgUstdOXJAIvGz23XMmuFY5AifBvjvL4aFNuVVcm8cdQZwhHdYyZLTfEAsW6t9/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121742; c=relaxed/simple;
	bh=KC/thU0UQ2wY5+D2u09wAwOLulJr5/1TOD+wEsAOTuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFeEwvt/CxneIdjeiLFu8OHqC7LxAO0Ghw06i0Gg9gqTBv6DjfPKSQWj8XlpWi+LxWCGAo0tOMJRL0kyNM1AMFIDWGsALOGIZXSiYknQILlNc8XW9asL/ezMSMNx4czmBpubkuarF9HjGjm277cWuh7MndQ235vIzCQ44WnK94Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0Cx5mjv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0Cx5mjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C0AC43390;
	Mon, 11 Mar 2024 01:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710121742;
	bh=KC/thU0UQ2wY5+D2u09wAwOLulJr5/1TOD+wEsAOTuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0Cx5mjvhK7ZHENYxVV9qnSDDIczp6M/2e8PMRC7b4WeRTePQ8UNm7zctgLgv6Wgk
	 UZlZCeIrK8tBdBlGXyaL8RXsPmkkJXo2lecTRiNzdsZJgfMPX+i9XMENU3EZr8MLxF
	 iZetFiR9gpTTWmC0W19oeQNpmS1rwdqiNLDVrV7xVi9iNslJBHUu7L/gzwVix83+eV
	 Ah+2h8ikePfCFtkOk2Si2N8WwnW1XA2MyqHJMYjVAREgHRXRYReYBYNDTwZy1jdIwp
	 ecaUodfxz2mrjgWGricCzxAPsFg8SWWbc7IfWJpbFoAigjyGnSjFRN5f5gkJi2A/P1
	 jgTPtjz0+MR/g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 05/10] selftests: mptcp: netlink: fix positions of newline
Date: Mon, 11 Mar 2024 09:48:42 +0800
Message-Id: <ba8a1b4c1435f0bb6f086beba5d8e42b4658bac5.1710121590.git.tanggeliang@kylinos.cn>
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

Some positions of the new line are arranged a bit strangely in script
pm_netlink.sh. For example, the output of 'pm_nl_ctl limits':

                                                     "accept 0
subflows 2" "defaults limits"

This one can be refactored using $'...\n...':

        $'accept 0\nsubflows 2' "defaults limits"

For longer output results, such as the output of 'pm_nl_ctl dump':

                                        "id 1 flags  10.0.1.1
id 3 flags signal,backup 10.0.1.3
id 4 flags signal 10.0.1.4
id 5 flags signal 10.0.1.5
id 6 flags signal 10.0.1.6
id 7 flags signal 10.0.1.7
id 8 flags signal 10.0.1.8" "id limit"

This one can be refactored using "$(printf '%s\n' "..." "...")":

        "$(printf '%s\n' \
	"id 1 flags  10.0.1.1" \
        "id 3 flags signal,backup 10.0.1.3" \
        "id 4 flags signal 10.0.1.4" \
	"id 5 flags signal 10.0.1.5" \
        "id 6 flags signal 10.0.1.6" \
        "id 7 flags signal 10.0.1.7" \
	"id 8 flags signal 10.0.1.8")" \
        "id limit"

This patch uses such methods to rearrange the outputs into different lines.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh | 101 ++++++++++--------
 1 file changed, 56 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 6ab8c5d36340..00949f73153a 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -71,36 +71,41 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
 
 default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
 if mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "defaults limits"
+	limits=$'accept 0\nsubflows 2'
+	check "ip netns exec $ns1 ./pm_nl_ctl limits" "${limits}" "defaults limits"
 fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
-check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1" "simple add/get addr"
+endpoint="id 1 flags  10.0.1.1"
+check "ip netns exec $ns1 ./pm_nl_ctl get 1" "${endpoint}" "simple add/get addr"
 
+dump="$(printf '%s\n' \
+	"id 1 flags  10.0.1.1" \
+	"id 2 flags subflow dev lo 10.0.1.2" \
+	"id 3 flags signal,backup 10.0.1.3")"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 2 flags subflow dev lo 10.0.1.2
-id 3 flags signal,backup 10.0.1.3" "dump addrs"
+	"${dump}" "dump addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl del 2
+dump=$'id 1 flags  10.0.1.1\nid 3 flags signal,backup 10.0.1.3'
 check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
-"id 1 flags  10.0.1.1
-id 3 flags signal,backup 10.0.1.3" "dump addrs after del"
+	"${dump}" "dump addrs after del"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
-check "ip netns exec $ns1 ./pm_nl_ctl get 4" "id 4 flags signal 10.0.1.4" "id addr increment"
+endpoint="id 4 flags signal 10.0.1.4"
+check "ip netns exec $ns1 ./pm_nl_ctl get 4" "${endpoint}" "id addr increment"
 
 for i in $(seq 5 9); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
 done
-check "ip netns exec $ns1 ./pm_nl_ctl get 9" "id 9 flags signal 10.0.1.9" "hard addr limit"
+endpoint="id 9 flags signal 10.0.1.9"
+check "ip netns exec $ns1 ./pm_nl_ctl get 9" "${endpoint}" "hard addr limit"
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
+dump="$(printf '%s\n' \
+	"id 1 flags  10.0.1.1" \
+	"id 3 flags signal,backup 10.0.1.3" \
+	"id 4 flags signal 10.0.1.4" \
+	"id 5 flags signal 10.0.1.5" \
+	"id 6 flags signal 10.0.1.6" \
+	"id 7 flags signal 10.0.1.7" \
+	"id 8 flags signal 10.0.1.8")"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "id limit"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
@@ -126,8 +133,8 @@ ip netns exec $ns1 ./pm_nl_ctl limits 1 9 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
-subflows 8" "set limits"
+limits=$'accept 8\nsubflows 8'
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "${limits}" "set limits"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
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
+dump="$(printf '%s\n' \
+	"id 1 flags  10.0.1.1" \
+	"id 2 flags  10.0.1.2" \
+	"id 3 flags  10.0.1.7" \
+	"id 4 flags  10.0.1.8" \
+	"id 100 flags  10.0.1.3" \
+	"id 101 flags  10.0.1.4" \
+	"id 254 flags  10.0.1.5" \
+	"id 255 flags  10.0.1.6")"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "set ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.1
@@ -156,36 +165,38 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.0.5 id 253
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
+dump="$(printf '%s\n' \
+	"id 1 flags  10.0.0.1" \
+	"id 2 flags  10.0.0.4" \
+	"id 3 flags  10.0.0.6" \
+	"id 4 flags  10.0.0.7" \
+	"id 5 flags  10.0.0.8" \
+	"id 253 flags  10.0.0.5" \
+	"id 254 flags  10.0.0.2" \
+	"id 255 flags  10.0.0.3")"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "wrap-around ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup 10.0.1.1" "set flags (backup)"
+dump="id 1 flags subflow,backup 10.0.1.1"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "set flags (backup)"
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nobackup)"
+dump="id 1 flags subflow 10.0.1.1"
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (nobackup)"
 
 # fullmesh support has been added later
 ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh 2>/dev/null
 if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,fullmesh 10.0.1.1" "          (fullmesh)"
+	dump="id 1 flags subflow,fullmesh 10.0.1.1"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (fullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow 10.0.1.1" "          (nofullmesh)"
+	dump="id 1 flags subflow 10.0.1.1"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (nofullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
-subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+	dump="id 1 flags subflow,backup,fullmesh 10.0.1.1"
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
 		st="          (${st})"
-- 
2.40.1

