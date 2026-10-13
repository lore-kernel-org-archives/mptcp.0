Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9725751A135;
	Tue, 13 Oct 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914230; cv=none; b=NNuGXeAzXT5NYY8Gub0XSBCKWLHfWs8X6GwvYWEW4+lb2ZUEpqH6Ahm5AVyDFgDsvDjrMHHb6N9qjgpU4QCoxc2TnGGIiMQAF7dkrcpjkyO36Y1cIAgQJCDTD7NNDud/Y76v//RCjAEojvYk/zrv3+pVKSW30PGiRZ9Uyp7Cd8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914230; c=relaxed/simple;
	bh=lybs1dAwbY2sgj6xUu3y4NJZamtFYGNXvwp75VqlUTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qyJ5J/f0SBtQUhY9Ecd8dA2D1BRQjSpuqpCISdppqFNMLD/sZqix9dwZPuTZ80yWNYt9bqgxBZ7QV74oitIIzsS4t+cYYhNPQ6aBXRBxQwfMnTTqWeEOi5qYungr60/9Fwzx414PgGdwQCiwPwQc5ANM4AU9tAH+Xu+78d2FLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLAxm8dr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLAxm8dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7E91F00893;
	Tue, 13 Oct 2026 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791914228;
	bh=QWPl86BnnWgdNeW77g8OTK+3MbbNoQOJ9dGmvrji/fE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TLAxm8drzXyj4fQU+O7fNfKLN1ieGyZSsvf5whT+cl9/lQK1mo6LET9tTpAr0vDAy
	 O39Bi9pRZZjOLDih3vdUbPrS51BDNE4ZjwMEarMi4r/43WF/7o2+K8fAD6PuD1bAZI
	 gSRBlCn+Cz7fCMFXZYUMzmovOkw+qUVi7IYsjzjuBaGEjAYDOWXfOY3K7XLzHnIvkC
	 Q/DantxPY/aEd9+7Jj1KF0eZQYbmtBfN7Axt+x4kwobyl2iN+Y9lz90jdpRmI6K1py
	 cxRollIBxJh/UhEO+8EFgy1WQF0tByBKRs3U9KWpjJFVNqHFgA56BVGk74WC2yrR5v
	 1bi8as9IugnAA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Oct 2026 19:56:41 +0200
Subject: [PATCH net-next 4/4] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-4-1181e5d2fda4@kernel.org>
References: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4@kernel.org>
In-Reply-To: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Hangbin Liu <liuhangbin@kylinos.cn>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12474; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EKSAtJwkMdEMRkn7XXmBnP4n2J6mE5cDkhWz4p88n7M=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLOFTwzc6p4tMXcaIb/5sdviw9VTuN+bvtrqdnk1NeNY
 nyM7lMvd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkbCIjw4uGnLP2whE7eluu
 fuf6bLzmqeTJIvPO++bvWr5NDvY9q8LI8KVXTjz42/67lkqiy8p/PV//QC8sp2iC1C439xPv4ve
 +ZwMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Hangbin Liu <liuhangbin@kylinos.cn>

During conversion, we retain the same table and chain names used by the
original iptables/ip6tables setup, so rule output is identical to the
former iptables/ip6tables output. Add new function init_nftables so we
only do nft table setup when test need set nft rules.

Unlike iptables, nftables cannot match rules based on their full
specification. Since endpoint_tests is the only test that delete rules,
which inserts and deletes rules one by one. Flushing the table
directly is safe and easier than using nft_handle.

The cBPF bytecode matching MPTCP add‑addr is replaced with native nft
matching using "tcp option mptcp subtype add-addr". But the RM_ADDR
suboption is added after the MPTCP DSS option, and nft is unable to
handle this because it stops parsing further TCP options once it matches
the first one. We therefore use hard-coded offsets to match the RM_ADDR
suboption.

The config file adds CONFIG_NFT_NUMGEN (replaces iptables statistic nth),
CONFIG_NFT_REJECT and CONFIG_NFT_REJECT_INET for reject‑related rules.
Remove other unneeded configs.

Remove the iptables/ip6tables check in mptcp_lib.sh since no script use
it now.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org
v2:
 - Remove more unused kconfigs. (Clashiko)
 - Use offset to match RM_ADDR, instead of "mptcp subtype". (Clashiko)
---
 tools/testing/selftests/net/mptcp/config        |  15 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 158 ++++++++++--------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |   2 +-
 3 files changed, 72 insertions(+), 103 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index bb9c4c97c620..6a96cfbbc461 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,12 +1,7 @@
 CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
-CONFIG_IP6_NF_FILTER=m
-CONFIG_IP6_NF_TARGET_REJECT=m
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_NF_FILTER=m
-CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IPV6=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_KALLSYMS=y
@@ -19,17 +14,13 @@ CONFIG_NET_CLS_FW=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=y
-CONFIG_NETFILTER_XTABLES=m
-CONFIG_NETFILTER_XTABLES_LEGACY=y
-CONFIG_NETFILTER_XT_MATCH_BPF=m
-CONFIG_NETFILTER_XT_MATCH_LENGTH=m
-CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
-CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_SCH_NETEM=m
 CONFIG_NF_TABLES=m
 CONFIG_NF_TABLES_INET=y
-CONFIG_NFT_COMPAT=m
+CONFIG_NFT_NUMGEN=m
+CONFIG_NFT_REJECT=m
+CONFIG_NFT_REJECT_INET=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a2b0..f4d8afaeda4f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -26,8 +26,6 @@ capout=""
 cappid=""
 ns1=""
 ns2=""
-iptables="iptables"
-ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 capture=false
@@ -99,41 +97,16 @@ unset add_addr_tx_nr
 unset add_addr_echo_tx_nr
 unset add_addr_drop_tx_nr
 
-# generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
-#				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
-CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
-			       48 0 0 0,
-			       84 0 0 240,
-			       21 0 3 64,
-			       48 0 0 54,
-			       84 0 0 240,
-			       21 6 7 48,
-			       48 0 0 0,
-			       84 0 0 240,
-			       21 0 4 96,
-			       48 0 0 74,
-			       84 0 0 240,
-			       21 0 1 48,
-			       6 0 0 65535,
-			       6 0 0 0"
-
-# IPv4: TCP hdr of 48B, a first suboption of 12B (DACK8), the RM_ADDR suboption
-# generated using "nfbpf_compile '(ip[32] & 0xf0) == 0xc0 && ip[53] == 0x0c &&
-#				  (ip[66] & 0xf0) == 0x40'"
-CBPF_MPTCP_SUBOPTION_RM_ADDR="13,
-			      48 0 0 0,
-			      84 0 0 240,
-			      21 0 9 64,
-			      48 0 0 32,
-			      84 0 0 240,
-			      21 0 6 192,
-			      48 0 0 53,
-			      21 0 4 12,
-			      48 0 0 66,
-			      84 0 0 240,
-			      21 0 1 64,
-			      6 0 0 65535,
-			      6 0 0 0"
+# nft cannot process the RM_ADDR option because it stops parsing after matching
+# the first DSS option. Use hard-coded byte offsets to match RM_ADDR messages.
+# A tcpdump capture of the RM_ADDR message looks like:
+#  [TCP header: 20 bytes] [nop] [nop] [timestamp: 10 bytes]
+#  [MPTCP DSS: 12 bytes] [MPTCP RM_ADDR: 4 bytes]
+#
+# - TCP Data Offset (12 x 4 = 48 bytes)
+# - DSS (TCP[32] x 8) kind (MPTCP 0x1e), length (0x0c) and subtype (2)
+# - RM_ADDR (TCP[44] x 8) kind (MPTCP 0x1e), variable length and subtype (4)
+RM_ADDR_OFFSETS="tcp doff 12 @th,256,20 == 0x1e0c2 @th,352,8 == 0x1e @th,368,4 == 4"
 
 init_partial()
 {
@@ -184,6 +157,26 @@ init_shapers()
 	done
 }
 
+init_nftables()
+{
+	local netns table
+	for netns in "$ns1" "$ns2"; do
+		for table in ip ip6; do
+			ip netns exec "$netns" nft -f - <<-EOF
+				add table $table filter
+				add chain $table filter INPUT \
+					{ type filter hook input priority filter; policy accept; }
+				add chain $table filter OUTPUT \
+					{ type filter hook output priority filter; policy accept; }
+
+				add table $table mangle
+				add chain $table mangle OUTPUT \
+					{ type route hook output priority mangle; policy accept; }
+			EOF
+		done
+	done
+}
+
 cleanup_partial()
 {
 	rm -f "$capout"
@@ -196,7 +189,7 @@ init() {
 
 	mptcp_lib_check_mptcp
 	mptcp_lib_check_kallsyms
-	mptcp_lib_check_tools ip tc ss "${iptables}" "${ip6tables}"
+	mptcp_lib_check_tools ip tc ss nft
 
 	sin=$(mktemp)
 	sout=$(mktemp)
@@ -380,24 +373,18 @@ reset_with_cookies()
 # $1: test name
 reset_with_add_addr_timeout()
 {
-	local ip="${2:-4}"
-	local tables
+	local ip="${2:-}"
 
 	reset "${1}" || return 1
-
-	tables="${iptables}"
-	if [ $ip -eq 6 ]; then
-		tables="${ip6tables}"
-	fi
+	init_nftables
 
 	# set a maximum, to avoid too long timeout with exponential backoff
 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 
-	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
-			-m tcp --tcp-option 30 \
-			-m bpf --bytecode \
-			"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
-			-j DROP; then
+	if ! ip netns exec "$ns2" nft add rule \
+			ip"$ip" filter OUTPUT meta l4proto tcp \
+			tcp option mptcp subtype add-addr \
+			drop; then
 		mark_as_skipped "unable to set the 'add addr' rule"
 		return 1
 	fi
@@ -449,22 +436,14 @@ setup_fail_rules()
 	check_invert=1
 	validate_checksum=true
 	local i="$1"
-	local ip="${2:-4}"
-	local tables
+	local ip="${2:-}"
 
-	tables="${iptables}"
-	if [ $ip -eq 6 ]; then
-		tables="${ip6tables}"
-	fi
-
-	ip netns exec $ns2 $tables \
-		-t mangle \
-		-A OUTPUT \
-		-o ns2eth$i \
-		-p tcp \
-		-m length --length 150:9999 \
-		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42 || return ${KSFT_SKIP}
+	init_nftables
+	ip netns exec "$ns2" nft add rule \
+		ip"$ip" mangle OUTPUT oifname ns2eth$i \
+		meta l4proto tcp \
+		meta length 150-9999 numgen inc mod 99999 1 \
+		meta mark set 42 || return ${KSFT_SKIP}
 
 	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${KSFT_SKIP}
 	tc -n $ns2 filter add dev ns2eth$i egress \
@@ -510,16 +489,15 @@ reset_with_tcp_filter()
 	reset "${1}" || return 1
 	shift
 
+	init_nftables
+
 	local ns="${!1}"
 	local src="${2}"
 	local target="${3}"
 	local chain="${4:-INPUT}"
 
-	if ! ip netns exec "${ns}" ${iptables} \
-			-A "${chain}" \
-			-s "${src}" \
-			-p tcp \
-			-j "${target}"; then
+	if ! ip netns exec "$ns" nft add rule ip filter "${chain}" \
+			ip saddr "${src}" meta l4proto tcp "${target,,}"; then
 		mark_as_skipped "unable to set the filter rules"
 		return 1
 	fi
@@ -4313,12 +4291,15 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 
+		init_nftables
 		# force quick loss
 		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
-		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
-		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset &&
-		   ip netns exec "${ns2}" ${iptables} -A INPUT -d "10.0.1.2" \
-		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
+		if ip netns exec "${ns1}" nft add rule ip filter INPUT \
+				ip saddr "10.0.1.2" meta l4proto tcp \
+				tcp option mptcp exists reject with tcp reset &&
+		   ip netns exec "${ns2}" nft add rule ip filter INPUT \
+				ip daddr "10.0.1.2" meta l4proto tcp \
+				tcp option mptcp exists reject with tcp reset; then
 			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
 			wait_event ns1 MPTCP_LIB_EVENT_SUB_CLOSED 1
 			chk_subflows_total 1 1
@@ -4393,7 +4374,7 @@ endpoint_tests()
 		chk_subflow_nr "after new reject" 2
 		chk_mptcp_info subflows 1 subflows 1
 
-		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		ip netns exec "${ns2}" nft flush chain ip filter OUTPUT
 		pm_nl_del_endpoint $ns2 3 10.0.3.2
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_mpj 3
@@ -4402,12 +4383,10 @@ endpoint_tests()
 
 		# To make sure RM_ADDR are sent over a different subflow, but
 		# allow the rest to quickly and cleanly close the subflow
-		local ipt=1
-		ip netns exec "${ns2}" ${iptables} -I OUTPUT -s "10.0.1.2" \
-			-p tcp -m tcp --tcp-option 30 \
-			-m bpf --bytecode \
-			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
-			-j DROP || ipt=0
+		local nft=1
+		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
+			ip saddr 10.0.1.2 meta l4proto tcp \
+			"${RM_ADDR_OFFSETS}" drop || nft=0
 		local i
 		for i in $(seq 3); do
 			pm_nl_del_endpoint $ns2 1 10.0.1.2
@@ -4420,7 +4399,7 @@ endpoint_tests()
 			chk_subflow_nr "after re-add id 0 ($i)" 3
 			chk_mptcp_info subflows 3 subflows 3
 		done
-		[ ${ipt} = 1 ] && ip netns exec "${ns2}" ${iptables} -D OUTPUT 1
+		[ "${nft}" = 1 ] && ip netns exec "${ns2}" nft flush chain ip filter OUTPUT
 
 		mptcp_lib_kill_group_wait $tests_pid
 
@@ -4480,20 +4459,19 @@ endpoint_tests()
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
+		init_nftables
 		# To make sure RM_ADDR are sent over a different subflow, but
 		# allow the rest to quickly and cleanly close the subflow
-		local ipt=1
-		ip netns exec "${ns1}" ${iptables} -I OUTPUT -s "10.0.1.1" \
-			-p tcp -m tcp --tcp-option 30 \
-			-m bpf --bytecode \
-			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
-			-j DROP || ipt=0
+		local nft=1
+		ip netns exec "${ns1}" nft insert rule ip filter OUTPUT \
+			ip saddr 10.0.1.1 meta l4proto tcp \
+			"${RM_ADDR_OFFSETS}" drop || nft=0
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
-		[ ${ipt} = 1 ] && ip netns exec "${ns1}" ${iptables} -D OUTPUT 1
+		[ "${nft}" = 1 ] && ip netns exec "${ns1}" nft flush chain ip filter OUTPUT
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
 		wait_mpj 4
@@ -4555,7 +4533,7 @@ endpoint_tests()
 		pm_nl_flush_endpoint $ns2
 		pm_nl_flush_endpoint $ns1
 		wait_rm_addr $ns2 0
-		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		ip netns exec "${ns2}" nft flush chain ip filter OUTPUT
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_mpj 1
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 20853d0198ff..e1c8c6fd8820 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -535,7 +535,7 @@ mptcp_lib_check_tools() {
 				exit ${KSFT_SKIP}
 			fi
 			;;
-		"iptables"* | "ip6tables"* | "jq")
+		"jq")
 			if ! "${tool}" -V &> /dev/null; then
 				mptcp_lib_pr_skip "Could not run all tests without ${tool}"
 				exit ${KSFT_SKIP}

-- 
2.55.0

