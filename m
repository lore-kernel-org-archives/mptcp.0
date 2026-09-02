Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6728D3A7193
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332005; cv=none; b=qOY7FXTsR1UvqXc4q8ManQrWP09scFrUsaVaO/o5UC3r+AHPR6vK15ajSnL254hxWHaIMyT+Qee6fAKvxCaFopk6MEAV/1KLfYbe0iY1w6xpFW16M0UcgFnd8HuCS2+NljzMd04Gd10G08Ftzp3W87v/6laNAHklYRWJ/YrEnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332005; c=relaxed/simple;
	bh=tzhagK+5mhsLI1q5ngfc7YTxWnKP6EPrEW2qBYCoKj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rusbQ7gOUEiwg0WQiM/z3CK2a87gcG0AGtnkrOo5JC8ea74OrqrjZvSuhEy1/z9BwvHuddK5COak04c5Zt9LyR64keWxdaffwUqRHtxvzc6DHfBjB8C2owqrEKV2XyChRum4kk/ylQba9Or6joUSG1Q/U9gYy40Ps1t+pCX8LrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LF1ozaMj; arc=none smtp.client-ip=91.218.175.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LF1ozaMj"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=tzhagK+5mhsLI1q5ngfc7YTxWnKP6EPrEW2qBYCoKj0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788331988; v=1; x=1788936788;
 b=LF1ozaMjZ0nd8RsQFRrQp6JvNTVpy3A/kOufTvP/HmQ+/mZLh8y30ya1JgH0qI3QDTp4uIKP
 1ltvXzpxQDfea2AD73KMKWt9AGik6HlOTOMF9rupEHmM0/ReLda9+c6wmRrGIfCXtEL3iF72ngm
 pQkjXkGwyvZJzUktBDbVIFE4=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c90996bd6c406713;
	Wed, 02 Sep 2026 06:53:07 +0000
X-Mizu-Trace-ID: c90996bd6c406713
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Wed, 02 Sep 2026 14:52:36 +0800
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
In-Reply-To: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
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

Replace the per-address-family iptables rules with a single inet table
(mjoin_table) that handles both IPv4 and IPv6. The BPF bytecode for
matching MPTCP add-addr and remove-addr suboptions is replaced with
native nft matching via "tcp option mptcp subtype". Rule handles are
captured via "nft -e --handle" so that rules can be selectively removed
during tests.

The config file adds CONFIG_NFT_NUMGEN (replaces iptables statistic nth),
CONFIG_NFT_REJECT and CONFIG_NFT_REJECT_IPV4 for reject‑related rules.

The iptables/ip6tables check inside mptcp_lib.sh is kept in case any
one still need them.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config        |   3 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 136 +++++++++---------------
 2 files changed, 51 insertions(+), 88 deletions(-)

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
index 18ce7136a2b0..05cbaddb8261 100755
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
@@ -147,6 +110,14 @@ init_partial()
 		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
+
+		ip netns exec "$netns" nft add table inet mjoin_table
+		ip netns exec "$netns" nft add chain inet mjoin_table input \
+			'{ type filter hook input priority filter; policy accept; }'
+		ip netns exec "$netns" nft add chain inet mjoin_table output \
+			'{ type filter hook output priority filter; policy accept; }'
+		ip netns exec "$netns" nft add chain inet mjoin_table mangle \
+			'{ type filter hook output priority mangle; policy accept; }'
 	done
 
 	check_invert=0
@@ -196,7 +167,7 @@ init() {
 
 	mptcp_lib_check_mptcp
 	mptcp_lib_check_kallsyms
-	mptcp_lib_check_tools ip tc ss "${iptables}" "${ip6tables}"
+	mptcp_lib_check_tools ip tc ss nft
 
 	sin=$(mktemp)
 	sout=$(mktemp)
@@ -381,23 +352,18 @@ reset_with_cookies()
 reset_with_add_addr_timeout()
 {
 	local ip="${2:-4}"
-	local tables
 
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
+
+	nft_handle=$(ip netns exec "$ns2" nft -e --handle add rule \
+		inet mjoin_table output meta nfproto ipv${ip} \
+		tcp option mptcp subtype add-addr \
+		drop | head -n1 | awk '{print $NF}')
+	if [ -z "$nft_handle" ]; then
 		mark_as_skipped "unable to set the 'add addr' rule"
 		return 1
 	fi
@@ -450,22 +416,16 @@ setup_fail_rules()
 	validate_checksum=true
 	local i="$1"
 	local ip="${2:-4}"
-	local tables
 
-	tables="${iptables}"
-	if [ $ip -eq 6 ]; then
-		tables="${ip6tables}"
+	nft_handle=$(ip netns exec "$ns2" nft -e --handle add rule \
+		inet mjoin_table mangle oifname ns2eth$i \
+		meta nfproto ipv${ip} meta l4proto tcp \
+		meta length 150-9999 numgen inc mod 99999 == 1 \
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
@@ -515,11 +475,11 @@ reset_with_tcp_filter()
 	local target="${3}"
 	local chain="${4:-INPUT}"
 
-	if ! ip netns exec "${ns}" ${iptables} \
-			-A "${chain}" \
-			-s "${src}" \
-			-p tcp \
-			-j "${target}"; then
+	nft_handle=$(ip netns exec "$ns" nft -e --handle add rule \
+		inet mjoin_table "${chain,,}" \
+		ip saddr "{ ${src} }" meta l4proto tcp "${target,,}" | \
+		head -n1 | awk '{print $NF}')
+	if [ -z "$nft_handle" ]; then
 		mark_as_skipped "unable to set the filter rules"
 		return 1
 	fi
@@ -4315,10 +4275,12 @@ userspace_tests()
 
 		# force quick loss
 		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
-		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
-		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset &&
-		   ip netns exec "${ns2}" ${iptables} -A INPUT -d "10.0.1.2" \
-		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
+		if ip netns exec "${ns1}" nft add rule inet mjoin_table \
+			input ip saddr "10.0.1.2" meta l4proto tcp \
+			tcp option mptcp exists reject with tcp reset &&
+		   ip netns exec "${ns2}" nft add rule inet mjoin_table \
+			input ip daddr "10.0.1.2" meta l4proto tcp \
+			tcp option mptcp exists reject with tcp reset; then
 			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
 			wait_event ns1 MPTCP_LIB_EVENT_SUB_CLOSED 1
 			chk_subflows_total 1 1
@@ -4393,7 +4355,7 @@ endpoint_tests()
 		chk_subflow_nr "after new reject" 2
 		chk_mptcp_info subflows 1 subflows 1
 
-		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		ip netns exec "${ns2}" nft delete rule inet mjoin_table output handle "$nft_handle"
 		pm_nl_del_endpoint $ns2 3 10.0.3.2
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_mpj 3
@@ -4402,12 +4364,10 @@ endpoint_tests()
 
 		# To make sure RM_ADDR are sent over a different subflow, but
 		# allow the rest to quickly and cleanly close the subflow
-		local ipt=1
-		ip netns exec "${ns2}" ${iptables} -I OUTPUT -s "10.0.1.2" \
-			-p tcp -m tcp --tcp-option 30 \
-			-m bpf --bytecode \
-			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
-			-j DROP || ipt=0
+		nft_handle=$(ip netns exec "${ns2}" nft -e --handle insert rule \
+			inet mjoin_table output ip saddr 10.0.1.2 meta l4proto tcp \
+			tcp option mptcp subtype remove-addr \
+			drop | head -n1 | awk '{print $NF}')
 		local i
 		for i in $(seq 3); do
 			pm_nl_del_endpoint $ns2 1 10.0.1.2
@@ -4420,7 +4380,8 @@ endpoint_tests()
 			chk_subflow_nr "after re-add id 0 ($i)" 3
 			chk_mptcp_info subflows 3 subflows 3
 		done
-		[ ${ipt} = 1 ] && ip netns exec "${ns2}" ${iptables} -D OUTPUT 1
+		[ -n "${nft_handle}" ] && ip netns exec "${ns2}" nft delete rule \
+			inet mjoin_table output handle "${nft_handle}"
 
 		mptcp_lib_kill_group_wait $tests_pid
 
@@ -4482,18 +4443,17 @@ endpoint_tests()
 
 		# To make sure RM_ADDR are sent over a different subflow, but
 		# allow the rest to quickly and cleanly close the subflow
-		local ipt=1
-		ip netns exec "${ns1}" ${iptables} -I OUTPUT -s "10.0.1.1" \
-			-p tcp -m tcp --tcp-option 30 \
-			-m bpf --bytecode \
-			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
-			-j DROP || ipt=0
+		nft_handle=$(ip netns exec "${ns1}" nft -e --handle insert rule \
+			inet mjoin_table output ip saddr 10.0.1.1 meta l4proto tcp \
+			tcp option mptcp subtype remove-addr \
+			drop | head -n1 | awk '{print $NF}')
 		pm_nl_del_endpoint $ns1 42 10.0.1.1
 		sleep 0.5
 		chk_subflow_nr "after delete ID 0" 2
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
-		[ ${ipt} = 1 ] && ip netns exec "${ns1}" ${iptables} -D OUTPUT 1
+		[ -n "${nft_handle}" ] && ip netns exec "${ns1}" nft delete rule \
+			inet mjoin_table output handle "${nft_handle}"
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
 		wait_mpj 4
@@ -4555,7 +4515,7 @@ endpoint_tests()
 		pm_nl_flush_endpoint $ns2
 		pm_nl_flush_endpoint $ns1
 		wait_rm_addr $ns2 0
-		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		ip netns exec "${ns2}" nft delete rule inet mjoin_table output handle "$nft_handle"
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		wait_mpj 1
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal

-- 
2.55.0

