Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AA510E5
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121744; cv=none; b=WnmlkQBWfKIFwaRtjKKSdqDxPjk5Y882rj+QopDJB2VhRYNF72XR2DmjUno4DNTM3yONUNDNWdFF50jz2f9aoPfsjXLUkjpmYoyP3IumOPweVFjg6g8Ut4wA+EFjuP1fzDBojejnmjoLOJkRQ8HGnRkSkh0kdChfx5mvbSon19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121744; c=relaxed/simple;
	bh=cfKZgqG+71jJ03Nm3RRRfrygN5SP7gfvrOHpgfXEsS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X1OHG2P/1eDitA88Du0UBwiMSMkacuIJWevbjq2WOCx6wOueqZnFMF7OWigQ4w58Lj3bk6oVQbmiJMMCS9M2//0cVeNqJnZ5TVN5s/ceV/re2Sa0CkjQgAHQxDHC30ekIM/wwGlnVwq59QIWDtTH5q3IcgyKcu/ZeBcZecLADLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0QMlnTi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0QMlnTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00951C433F1;
	Mon, 11 Mar 2024 01:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710121744;
	bh=cfKZgqG+71jJ03Nm3RRRfrygN5SP7gfvrOHpgfXEsS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0QMlnTiUwOr7pOfUBBhXxx5q30hbgeNYu8jpKSvjskfKVxjlj3O/fxrdTt3O/xA8
	 YXg58KcbkSINsRZRdNT0ThmRJuez+EAbIIh3k1ynwMUtvZDA8zjRdeY5OcjOLxOv0W
	 U7uQ2C0MmngUmjEknxgavx4E1tmzAc54M8Qx02NXqL297zAeBZq/aEqdUxG/2Bhcl6
	 i01Z5oDLOLGP95Uz5uUFqkKGos8jBo0E65TXRr0abB+X2dIugV7aMKgFek+Wggnntx
	 /buF9Q4NpWMvurYYY6DoCaQ3feRLx0zegzp1/TN9wTaDAQhZNfBEOawyqzs0UWF+p9
	 EWUKWOJaTUUWg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 06/10] selftests: mptcp: netlink: add outputs for ip_mptcp
Date: Mon, 11 Mar 2024 09:48:43 +0800
Message-Id: <c8bc708a1b492fcbbd370b55983e8575de9baec8.1710121590.git.tanggeliang@kylinos.cn>
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

The outputs of 'ip mptcp' are different from that of 'pm_nl_ctl'. This
patch adds corresponding outputs of 'ip mptcp' together with 'pm_nl_ctl'.
Use mptcp_lib_is_ip_mptcp() helper to test whether ip_mptcp is set. If
it it, use 'ip mptcp' format outputs for check().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/pm_netlink.sh | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 00949f73153a..2096c52b3a4b 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -72,6 +72,7 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
 default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
 if mptcp_lib_expect_all_features; then
 	limits=$'accept 0\nsubflows 2'
+	mptcp_lib_is_ip_mptcp && limits="add_addr_accepted 0 subflows 2 "
 	check "ip netns exec $ns1 ./pm_nl_ctl limits" "${limits}" "defaults limits"
 fi
 
@@ -79,17 +80,24 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
 endpoint="id 1 flags  10.0.1.1"
+mptcp_lib_is_ip_mptcp && endpoint="10.0.1.1 id 1 "
 check "ip netns exec $ns1 ./pm_nl_ctl get 1" "${endpoint}" "simple add/get addr"
 
 dump="$(printf '%s\n' \
 	"id 1 flags  10.0.1.1" \
 	"id 2 flags subflow dev lo 10.0.1.2" \
 	"id 3 flags signal,backup 10.0.1.3")"
+mptcp_lib_is_ip_mptcp && \
+dump="$(printf '%s\n' \
+	"10.0.1.1 id 1 " \
+	"10.0.1.2 id 2 subflow dev lo " \
+	"10.0.1.3 id 3 signal backup ")"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 	"${dump}" "dump addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl del 2
 dump=$'id 1 flags  10.0.1.1\nid 3 flags signal,backup 10.0.1.3'
+mptcp_lib_is_ip_mptcp && dump=$'10.0.1.1 id 1 \n10.0.1.3 id 3 signal backup '
 check "ip netns exec $ns1 ./pm_nl_ctl get 2" "" "simple del addr"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 	"${dump}" "dump addrs after del"
@@ -99,12 +107,14 @@ check "ip netns exec $ns1 ./pm_nl_ctl get 4" "" "duplicate addr"
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.4 flags signal
 endpoint="id 4 flags signal 10.0.1.4"
+mptcp_lib_is_ip_mptcp && endpoint="10.0.1.4 id 4 signal "
 check "ip netns exec $ns1 ./pm_nl_ctl get 4" "${endpoint}" "id addr increment"
 
 for i in $(seq 5 9); do
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.$i flags signal >/dev/null 2>&1
 done
 endpoint="id 9 flags signal 10.0.1.9"
+mptcp_lib_is_ip_mptcp && endpoint="10.0.1.9 id 9 signal "
 check "ip netns exec $ns1 ./pm_nl_ctl get 9" "${endpoint}" "hard addr limit"
 check "ip netns exec $ns1 ./pm_nl_ctl get 10" "" "above hard addr limit"
 
@@ -121,6 +131,15 @@ dump="$(printf '%s\n' \
 	"id 6 flags signal 10.0.1.6" \
 	"id 7 flags signal 10.0.1.7" \
 	"id 8 flags signal 10.0.1.8")"
+mptcp_lib_is_ip_mptcp && \
+dump="$(printf '%s\n' \
+	"10.0.1.1 id 1 " \
+	"10.0.1.3 id 3 signal backup " \
+	"10.0.1.4 id 4 signal " \
+	"10.0.1.5 id 5 signal " \
+	"10.0.1.6 id 6 signal " \
+	"10.0.1.7 id 7 signal " \
+	"10.0.1.8 id 8 signal ")"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "id limit"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
@@ -134,6 +153,7 @@ check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
 limits=$'accept 8\nsubflows 8'
+mptcp_lib_is_ip_mptcp && limits="add_addr_accepted 8 subflows 8 "
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "${limits}" "set limits"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
@@ -154,6 +174,16 @@ dump="$(printf '%s\n' \
 	"id 101 flags  10.0.1.4" \
 	"id 254 flags  10.0.1.5" \
 	"id 255 flags  10.0.1.6")"
+mptcp_lib_is_ip_mptcp && \
+dump="$(printf '%s\n' \
+	"10.0.1.1 id 1 " \
+	"10.0.1.2 id 2 " \
+	"10.0.1.7 id 3 " \
+	"10.0.1.8 id 4 " \
+	"10.0.1.3 id 100 " \
+	"10.0.1.4 id 101 " \
+	"10.0.1.5 id 254 " \
+	"10.0.1.6 id 255 ")"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "set ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
@@ -174,15 +204,27 @@ dump="$(printf '%s\n' \
 	"id 253 flags  10.0.0.5" \
 	"id 254 flags  10.0.0.2" \
 	"id 255 flags  10.0.0.3")"
+mptcp_lib_is_ip_mptcp && \
+dump="$(printf '%s\n' \
+	"10.0.0.1 id 1 " \
+	"10.0.0.4 id 2 " \
+	"10.0.0.6 id 3 " \
+	"10.0.0.7 id 4 " \
+	"10.0.0.8 id 5 " \
+	"10.0.0.5 id 253 " \
+	"10.0.0.2 id 254 " \
+	"10.0.0.3 id 255 ")"
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "wrap-around ids"
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
 dump="id 1 flags subflow,backup 10.0.1.1"
+mptcp_lib_is_ip_mptcp && dump="10.0.1.1 id 1 subflow backup "
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "set flags (backup)"
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
 dump="id 1 flags subflow 10.0.1.1"
+mptcp_lib_is_ip_mptcp && dump="10.0.1.1 id 1 subflow "
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (nobackup)"
 
 # fullmesh support has been added later
@@ -190,12 +232,15 @@ ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh 2>/dev/null
 if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
 	dump="id 1 flags subflow,fullmesh 10.0.1.1"
+	mptcp_lib_is_ip_mptcp && dump="10.0.1.1 id 1 subflow fullmesh "
 	check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (fullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
 	dump="id 1 flags subflow 10.0.1.1"
+	mptcp_lib_is_ip_mptcp && dump="10.0.1.1 id 1 subflow "
 	check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (nofullmesh)"
 	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
 	dump="id 1 flags subflow,backup,fullmesh 10.0.1.1"
+	mptcp_lib_is_ip_mptcp && dump="10.0.1.1 id 1 subflow backup fullmesh "
 	check "ip netns exec $ns1 ./pm_nl_ctl dump" "${dump}" "          (backup,fullmesh)"
 else
 	for st in fullmesh nofullmesh backup,fullmesh; do
-- 
2.40.1

