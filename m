Received: from mta0.migadu.com (out-24.mta0.migadu.com [91.218.175.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C7387590
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507111; cv=none; b=OuZc6Ejf5124LCY2UW7/kEfE6U0nFfA36YKoXsCVnrSHtSnh5MX8QefRAePIzhGPqkSKNRv9G4bQjPxppIbEqbmpAOzqwMjUgyoOjfyVDgWz6WYKeUyYbsiZX30t18dki3v2ZOwq4ESLLR92l0ayISkg/mWl6qRF0CJwbzGdHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507111; c=relaxed/simple;
	bh=+lO92OrHcWgDX+XMuJSe/7Ve7jUamRR+HCwitMSwB6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdeQ/Ps1dn15/AzDr0Fm6RFq43N3NoyCaNlEdnz9TwXPpvW3ub+FL4z39ZN+u8d9Muh9YwrYraPQJAA0LUFo+hnPrGAn6C5wP6+LHwb98ZIBXJ03O6mI744eTINh8P/ezGAxoGw6KbSOK73jIhR8PAVMMTjMEWe1tO38MsNt7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r87a9R3Y; arc=none smtp.client-ip=91.218.175.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r87a9R3Y"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=+lO92OrHcWgDX+XMuJSe/7Ve7jUamRR+HCwitMSwB6I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788507107; v=1; x=1789111907;
 b=r87a9R3YSACgY/HmTti8BwruJkxAkF+Wkm+hKQ8A4jnMBmjM5qBTeBwIDph0TMHmySxHyKMf
 EQt5RE5paDyyefhv0Q+Yxvc6N+sjJgGHgPmc7DQneAd/oW5owyrq3+6yS8aLtjLcOOkOflfPhR9
 UukYJHg7rSTBFbg8Sr4tt5N0=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id e755e7489f86e25c;
	Fri, 04 Sep 2026 07:31:47 +0000
X-Mizu-Trace-ID: e755e7489f86e25c
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Fri, 04 Sep 2026 15:31:17 +0800
Subject: [PATCH mptcp-next v3 1/2] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-mptcp_nft-v3-1-4abedaf00bf9@kylinos.cn>
References: <20260904-mptcp_nft-v3-0-4abedaf00bf9@kylinos.cn>
In-Reply-To: <20260904-mptcp_nft-v3-0-4abedaf00bf9@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Hangbin Liu <liuhangbin@kylinos.cn>, 
 Hangbin Liu <hangbin.liu@linux.dev>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

During the conversion, we retain the same filter and chain names previously
used by iptables/ip6tables. Counters are not added to accept rules because
the test does not inspect them. After conversion, the generated output
matches the original iptables/ip6tables behavior.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 64 ++++++++++++----------
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index b9d14647f401..e65b4ebee06a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -528,7 +528,7 @@ mptcp_lib_check_tools() {
 				exit ${KSFT_SKIP}
 			fi
 			;;
-		"iptables"* | "ip6tables"*)
+		"iptables"* | "ip6tables"* | "nft" | "jq")
 			if ! "${tool}" -V &> /dev/null; then
 				mptcp_lib_pr_skip "Could not run all tests without ${tool}"
 				exit ${KSFT_SKIP}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e850a87429b6..b4e3eddc9cf2 100755
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
@@ -49,16 +47,27 @@ add_mark_rules()
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
+	local table
+	for table in ip ip6; do
+		ip netns exec "$ns" nft -f - <<-EOF
+			add table $table filter
+			add chain $table filter OUTPUT \
+				{ type filter hook output priority 0; policy accept; }
+
+			# just to debug: check we have multiple subflows connection requests
+			add rule $table filter OUTPUT \
+				tcp flags & (fin | syn | rst | ack) == syn \
+				meta mark $m accept
+
+			# RST packets might be handled by a internal dummy socket
+			add rule $table filter OUTPUT \
+				tcp flags & rst == rst meta mark 0x0 accept
+
+			add rule $table filter OUTPUT \
+				meta l4proto tcp meta mark $m accept
+			add rule $table filter OUTPUT \
+				meta l4proto tcp meta mark 0 counter drop
+		EOF
 	done
 }
 
@@ -105,32 +114,31 @@ cleanup()
 
 mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
-mptcp_lib_check_tools ip "${iptables}" "${ip6tables}"
+mptcp_lib_check_tools ip nft jq
 
 check_mark()
 {
 	local ns=$1
 	local af=$2
 
-	local tables=${iptables}
+	local tables="ip"
 
 	if [ $af -eq 6 ];then
-		tables=${ip6tables}
+		tables="ip6"
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
+	local drops
+	drops=$(ip netns exec "$ns" nft -j list table "$tables" filter | \
+		jq '.nftables[] | select(has("rule")) | .rule |
+			select (.chain=="OUTPUT" and any(.expr[]; has("drop"))) |
+			.expr[] | select(has("counter")) | .counter.packets')
+
+	if [ -z "$drops" ] || [ "$drops" -ne 0 ]; then
+		mptcp_lib_pr_fail "got $tables $drops in ns $ns," \
+				  "not 0 - not all expected packets marked"
+		ret=${KSFT_FAIL}
+		return 1
+	fi
 
 	return 0
 }

-- 
2.55.0

