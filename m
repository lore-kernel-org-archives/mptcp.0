Received: from mta1.migadu.com (out-232.mta1.migadu.com [95.215.58.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845152F7EE3
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397977; cv=none; b=hqNRIFz4lcOX/Qzgm4JHcHr57zjmd5PRP0V/9Ow1bGaRASED5V8EMggoqgNQ7PlfZIU2WCaUxzOG7N2a6ghBnr3m0kMk5l2kXteDnbAUbK1BFYn8EC5Oebu9/LSZadBAfSRg/a04kJCG1TsA50mEqAO9TR+CLWLQ9L4RdXe8YMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397977; c=relaxed/simple;
	bh=SoCjmJDRTGL4GPTeItrahykbmnY8odwSPEzVpIL1zAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Of/fjUa3MysoLTMlHOWFclYe3HEmdzrUSPe3TQSpQP2d85DA4dD3FyUyZOBNUvBQaiSX+ceoI53I8iofmUSZZuH4GFbodK4gAN/FdIxDEHJnXGWh4f7NSbSM3mTAimXFFmuTcnKnk4fFGygdd/aI+JfinuVvGTsmG5Nu/KdBpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nlnRHlPM; arc=none smtp.client-ip=95.215.58.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nlnRHlPM"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=SoCjmJDRTGL4GPTeItrahykbmnY8odwSPEzVpIL1zAI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788397972; v=1; x=1789002772;
 b=nlnRHlPM2g/PaiahFZx5JmUWN8jKL0YpCA8rSuQ45x4hBCL0k6Yv9cFx62izhD8iO/gGEugt
 e6pMd1QyTMCF0pM8uajzmsnyuaqnEwSz9lvwA9WDyJRR0U01n7U2umDAJHuo5VXibCdlYfPG0Bf
 uuqOWvSNrGqd1pnlRK55wsns=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 468a22590f8604bb;
	Thu, 03 Sep 2026 01:12:52 +0000
X-Mizu-Trace-ID: 468a22590f8604bb
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 03 Sep 2026 09:12:21 +0800
Subject: [PATCH mptcp-next v2 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-mptcp_nft-v2-2-66283e4b9c3b@kylinos.cn>
References: <20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn>
In-Reply-To: <20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

During conversion, we retain the same table and chain names used by the
original iptables/ip6tables setup, so rule output is identical to the
former iptables/ip6tables output.

The BPF bytecode matching MPTCP add‑addr and remove‑addr suboptions
is replaced with native nft matching using "tcp option mptcp subtype".

Unlike iptables, nftables cannot match rules based on their full
specification. Rule handles are captured via "nft -e --handle" so rules
can be selectively removed during tests.

The config file adds CONFIG_NFT_NUMGEN (replaces iptables statistic nth),
CONFIG_NFT_REJECT and CONFIG_NFT_REJECT_IPV4 for reject‑related rules.

The iptables/ip6tables check within mptcp_lib.sh is preserved in case
some users still require it.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config        |   3 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 142 +++++++++---------------
 2 files changed, 55 insertions(+), 90 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..0d0a744c4ca8 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -30,6 +30,9 @@ CONFIG_NET_SCH_NETEM=m
 CONFIG_NF_TABLES=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_NFT_COMPAT=m
+CONFIG_NFT_NUMGEN=y
+CONFIG_NFT_REJECT=m
+CONFIG_NFT_REJECT_IPV4=m
 CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a2b0..7c56680cc422 100755
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
@@ -50,6 +48,7 @@ declare -A failed_tests
 MPTCP_LIB_TEST_FORMAT="%03u %s\n"
 TEST_NAME=""
 nr_blank=6
+nft_handle=""
 
 # These var are used only in some tests, make sure they are not already set
 unset FAILING_LINKS
@@ -99,42 +98,6 @@ unset add_addr_tx_nr
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
-
 init_partial()
 {
 	capout=$(mktemp)
@@ -147,6 +110,18 @@ init_partial()
 		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
+
+		for t in ip ip6; do
+			ip netns exec "$netns" nft add table "$t" filter
+			ip netns exec "$netns" nft add chain "$t" filter INPUT \
+				'{ type filter hook input priority filter; policy accept; }'
+			ip netns exec "$netns" nft add chain "$t" filter OUTPUT \
+				'{ type filter hook output priority filter; policy accept; }'
+
+			ip netns exec "$netns" nft add table "$t" mangle
+			ip netns exec "$netns" nft add chain "$t" mangle OUTPUT \
+				'{ type route hook output priority mangle; policy accept; }'
+		done
 	done
 
 	check_invert=0
@@ -196,7 +171,7 @@ init() {
 
 	mptcp_lib_check_mptcp
 	mptcp_lib_check_kallsyms
-	mptcp_lib_check_tools ip tc ss "${iptables}" "${ip6tables}"
+	mptcp_lib_check_tools ip tc ss nft
 
 	sin=$(mktemp)
 	sout=$(mktemp)
@@ -380,24 +355,18 @@ reset_with_cookies()
 # $1: test name
 reset_with_add_addr_timeout()
 {
-	local ip="${2:-4}"
-	local tables
+	local ip="${2:-}"
 
 	reset "${1}" || return 1
 
-	tables="${iptables}"
-	if [ $ip -eq 6 ]; then
-		tables="${ip6tables}"
-	fi
-
 	# set a maximum, to avoid too long timeout with exponential backoff
 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 
-	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
-			-m tcp --tcp-option 30 \
-			-m bpf --bytecode \
-			"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
-			-j DROP; then
+	nft_handle=$(ip netns exec "$ns2" nft -e --handle add rule \
+		ip"$ip" filter OUTPUT meta l4proto tcp \
+		tcp option mptcp subtype add-addr \
+		drop | head -n1 | awk '{print $NF}')
+	if [ -z "$nft_handle" ]; then
 		mark_as_skipped "unable to set the 'add addr' rule"
 		return 1
 	fi
@@ -449,23 +418,17 @@ setup_fail_rules()
 	check_invert=1
 	validate_checksum=true
 	local i="$1"
-	local ip="${2:-4}"
-	local tables
+	local ip="${2:-}"
 
-	tables="${iptables}"
-	if [ $ip -eq 6 ]; then
-		tables="${ip6tables}"
+	nft_handle=$(ip netns exec "$ns2" nft -e --handle add rule \
+		ip"$ip" mangle OUTPUT oifname ns2eth$i \
+		meta l4proto tcp \
+		meta length 150-9999 numgen inc mod 99999 1 \
+		meta mark set 42 | head -n1 | awk '{print $NF}')
+	if [ -z "$nft_handle" ]; then
+		return ${KSFT_SKIP}
 	fi
 
-	ip netns exec $ns2 $tables \
-		-t mangle \
-		-A OUTPUT \
-		-o ns2eth$i \
-		-p tcp \
-		-m length --length 150:9999 \
-		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42 || return ${KSFT_SKIP}
-
 	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${KSFT_SKIP}
 	tc -n $ns2 filter add dev ns2eth$i egress \
 		protocol ip prio 1000 \
@@ -515,11 +478,10 @@ reset_with_tcp_filter()
 	local target="${3}"
 	local chain="${4:-INPUT}"
 
-	if ! ip netns exec "${ns}" ${iptables} \
-			-A "${chain}" \
-			-s "${src}" \
-			-p tcp \
-			-j "${target}"; then
+	nft_handle=$(ip netns exec "$ns" nft -e --handle add rule \
+		ip filter "${chain}" ip saddr "{ ${src} }" \
+		meta l4proto tcp "${target,,}" | head -n1 | awk '{print $NF}')
+	if [ -z "$nft_handle" ]; then
 		mark_as_skipped "unable to set the filter rules"
 		return 1
 	fi
@@ -4315,10 +4277,12 @@ userspace_tests()
 
 		# force quick loss
 		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
-		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
-		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset &&
-		   ip netns exec "${ns2}" ${iptables} -A INPUT -d "10.0.1.2" \
-		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
+		if ip netns exec "${ns1}" nft add rule ip filter INPUT \
+			ip saddr "10.0.1.2" meta l4proto tcp \
+			tcp option mptcp exists reject with tcp reset &&
+		   ip netns exec "${ns2}" nft add rule ip filter INPUT \
+			ip daddr "10.0.1.2" meta l4proto tcp \
+			tcp option mptcp exists reject with tcp reset; then
 			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
 			wait_event ns1 MPTCP_LIB_EVENT_SUB_CLOSED 1
 			chk_subflows_total 1 1
@@ -4393,7 +4357,7 @@ endpoint_tests()
 		chk_subflow_nr "after new reject" 2
 		chk_mptcp_info subflows 1 subflows 1
 
-		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		ip netns exec "${ns2}" nft delete rule ip filter OUTPUT handle "$nft_handle"
 		pm_nl_del_endpoint $ns2 3 10.0.3.2
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_mpj 3
@@ -4402,12 +4366,10 @@ endpoint_tests()
 
 		# To make sure RM_ADDR are sent over a different subflow, but
 		# allow the rest to quickly and cleanly close the subflow
-		local ipt=1
-		ip netns exec "${ns2}" ${iptables} -I OUTPUT -s "10.0.1.2" \
-			-p tcp -m tcp --tcp-option 30 \
-			-m bpf --bytecode \
-			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
-			-j DROP || ipt=0
+		nft_handle=$(ip netns exec "${ns2}" nft -e --handle insert rule \
+			ip filter OUTPUT ip saddr 10.0.1.2 meta l4proto tcp \
+			tcp option mptcp subtype remove-addr \
+			drop | head -n1 | awk '{print $NF}')
 		local i
 		for i in $(seq 3); do
 			pm_nl_del_endpoint $ns2 1 10.0.1.2
@@ -4420,7 +4382,8 @@ endpoint_tests()
 			chk_subflow_nr "after re-add id 0 ($i)" 3
 			chk_mptcp_info subflows 3 subflows 3
 		done
-		[ ${ipt} = 1 ] && ip netns exec "${ns2}" ${iptables} -D OUTPUT 1
+		[ -n "${nft_handle}" ] && ip netns exec "${ns2}" nft delete rule \
+			ip filter OUTPUT handle "${nft_handle}"
 
 		mptcp_lib_kill_group_wait $tests_pid
 
@@ -4482,18 +4445,17 @@ endpoint_tests()
 
 		# To make sure RM_ADDR are sent over a different subflow, but
 		# allow the rest to quickly and cleanly close the subflow
-		local ipt=1
-		ip netns exec "${ns1}" ${iptables} -I OUTPUT -s "10.0.1.1" \
-			-p tcp -m tcp --tcp-option 30 \
-			-m bpf --bytecode \
-			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
-			-j DROP || ipt=0
+		nft_handle=$(ip netns exec "${ns1}" nft -e --handle insert rule \
+			ip filter OUTPUT ip saddr 10.0.1.1 meta l4proto tcp \
+			tcp option mptcp subtype remove-addr \
+			drop | head -n1 | awk '{print $NF}')
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
-		[ ${ipt} = 1 ] && ip netns exec "${ns1}" ${iptables} -D OUTPUT 1
+		[ -n "${nft_handle}" ] && ip netns exec "${ns1}" nft delete rule \
+			ip filter OUTPUT handle "${nft_handle}"
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
 		wait_mpj 4
@@ -4555,7 +4517,7 @@ endpoint_tests()
 		pm_nl_flush_endpoint $ns2
 		pm_nl_flush_endpoint $ns1
 		wait_rm_addr $ns2 0
-		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		ip netns exec "${ns2}" nft delete rule ip filter OUTPUT handle "$nft_handle"
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_mpj 1
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal

-- 
2.55.0

