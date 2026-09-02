Received: from mta0.migadu.com (out-81.mta0.migadu.com [91.218.175.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF83A9612
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331989; cv=none; b=pLHh5bDZLzjr/cmarsBZM+rzrGigghvJSp1vYkBJhmt/UY697M3ZIGGYjLWEXShX4U3ea17aJBfvrI04Sqoq+FZ0HPh1e41rHdJNPPA4dEjSiiYrWyygpaD6GfFm8+nhw4uzioqinNo/P8qONSa4m6q0F5qKouPCoSTaTO9yjqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331989; c=relaxed/simple;
	bh=CjE4pZlt4icFEu9bJ6HEckDv3cSAsyek8ZM9GiMyKls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YmG4eB+pVJ7LkxZAh/snhG+7JIVbKwm3aQ6rHar9IcsFpTvwzGKggTce0awCvFQh1mWEaXkuAuCYdE0e3UOw8GXIEGgtKn6Y6VWXrteR+QYnMB6jxhb/5UtW+C34xZbdDl2S6Vof5dxV0Jx748I2WV471wEFpj2k1rCoQyst/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TqInTpfx; arc=none smtp.client-ip=91.218.175.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TqInTpfx"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=CjE4pZlt4icFEu9bJ6HEckDv3cSAsyek8ZM9GiMyKls=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788331980; v=1; x=1788936780;
 b=TqInTpfx+dkE6luF7kaMDpmqjMRqzAb0A7KPuYDEcDPT3C/rspbKgaJlqLWuIhU3xTiJLJbi
 tik4RRLzf9rnzFhqtlpea0ShGNgBJh4i3+2W667dD0uzxjEU3Kjeq/bUyYCN+HB5CfVhs6WdHur
 /XlRHh5LklUXv6n9Gp8DOeww=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 8cd489d4159e8300;
	Wed, 02 Sep 2026 06:53:00 +0000
X-Mizu-Trace-ID: 8cd489d4159e8300
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Wed, 02 Sep 2026 14:52:35 +0800
Subject: [PATCH mptcp-next 1/2] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-mptcp_nft-v1-1-559caa16f410@kylinos.cn>
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

The per-AF iptables mark rules are replaced with an inet table
(msock_table) with separate per-AF counter drop rules for IPv4
and IPv6 drop counting.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 56 ++++++++++------------
 2 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index b9d14647f401..41febb1bbbc7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -528,7 +528,7 @@ mptcp_lib_check_tools() {
 				exit ${KSFT_SKIP}
 			fi
 			;;
-		"iptables"* | "ip6tables"*)
+		"iptables"* | "ip6tables"* | "nft"*)
 			if ! "${tool}" -V &> /dev/null; then
 				mptcp_lib_pr_skip "Could not run all tests without ${tool}"
 				exit ${KSFT_SKIP}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e850a87429b6..4d0af2bf9484 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -15,8 +15,6 @@ cin=""
 cout=""
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-iptables="iptables"
-ip6tables="ip6tables"
 
 ns1=""
 ns2=""
@@ -49,17 +47,23 @@ add_mark_rules()
 	local ns=$1
 	local m=$2
 
-	local t
-	for t in ${iptables} ${ip6tables}; do
-		# just to debug: check we have multiple subflows connection requests
-		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
-
-		# RST packets might be handled by a internal dummy socket
-		ip netns exec $ns $t -A OUTPUT -p tcp --tcp-flags RST RST -m mark --mark 0 -j ACCEPT
-
-		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark $m -j ACCEPT
-		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark 0 -j DROP
-	done
+	ip netns exec "$ns" nft add table inet msock_table
+	ip netns exec "$ns" nft add chain inet msock_table output \
+		'{ type filter hook output priority 0; policy accept; }'
+
+	# just to debug: check we have multiple subflows connection requests
+	ip netns exec "$ns" nft add rule inet msock_table output \
+		 meta mark "$m" tcp flags syn accept
+	# RST packets might be handled by a internal dummy socket
+	ip netns exec "$ns" nft add rule inet msock_table output \
+		meta mark 0 tcp flags rst accept
+	ip netns exec "$ns" nft add rule inet msock_table output \
+		meta mark "$m" meta l4proto tcp accept
+
+	ip netns exec "$ns" nft add rule inet msock_table output \
+		meta nfproto ipv4 meta mark 0 meta l4proto tcp counter drop
+	ip netns exec "$ns" nft add rule inet msock_table output \
+		meta nfproto ipv6 meta mark 0 meta l4proto tcp counter drop
 }
 
 init()
@@ -105,33 +109,23 @@ cleanup()
 
 mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
-mptcp_lib_check_tools ip "${iptables}" "${ip6tables}"
+mptcp_lib_check_tools ip nft
 
 check_mark()
 {
 	local ns=$1
 	local af=$2
 
-	local tables=${iptables}
+	drop=$(ip netns exec "$ns" nft list table inet msock_table | \
+		grep "ipv$af.*packets.*drop" | awk '{print $(NF-3)}')
 
-	if [ $af -eq 6 ];then
-		tables=${ip6tables}
+	if [ "$drop" -ne 0 ]; then
+		mptcp_lib_pr_fail "got $drop pkt drops in ns $ns IPv{$af} tables," \
+				  "not 0 - not all expected packets marked"
+		ret=${KSFT_FAIL}
+		return 1
 	fi
 
-	local counters values
-	counters=$(ip netns exec $ns $tables -v -L OUTPUT | grep DROP)
-	values=${counters%DROP*}
-
-	local v
-	for v in $values; do
-		if [ $v -ne 0 ]; then
-			mptcp_lib_pr_fail "got $tables $values in ns $ns," \
-					  "not 0 - not all expected packets marked"
-			ret=${KSFT_FAIL}
-			return 1
-		fi
-	done
-
 	return 0
 }
 

-- 
2.55.0

