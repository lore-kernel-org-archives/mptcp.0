Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D529478E57;
	Sat, 26 Sep 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436665; cv=none; b=HEQBujmsb+Ji/VdTaDMBl/cBgXdsBPgzgw7dzw0HdVvoh18ERGIDey7uoHQd7AAgwKr3yge7Ap6jBqGhymTFd+bNGQqMA+p1aM1TqXgGk+NC6Pw518MGP2NYL8iebjstcsLbzMsAq9Cu2UU9sB9XkxF2nfjwKmXqVYYBX/KrkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436665; c=relaxed/simple;
	bh=b9sNGhnVKusXFjAnMBLQBl1Fe5gHfrtNeHJf/Z5zEwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IKGeyeBX/l+ZEBhbp/GUOw+7XxyvJZ8ZcyOGHUwCMpi9+M2A2Pkdtva1dARorwYydxU2izBCX6EdJ+Pr7Z6tJR2c6BDDVKCWdwrqn9jEKdMdKptPO0NIzgRjFJ0F7ap16kezkcIT0i8FblZ+hjOznYmjX8gFH94NfuzuqiNOSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrQ2CD6e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrQ2CD6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF041F00893;
	Sat, 26 Sep 2026 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790436659;
	bh=+/Bpbjr/84++qbvmxtYkyKTZkI33tXkpSl391AKR3ow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JrQ2CD6e8fwTCzvoehD6idTXgji1UakLn41KHYp5D40h7TQ0nE6/ddnQ2d++QizZZ
	 XfZ6oaFllg4uyutgoBgWsTOa1l3TDE3ZdW2WFEi7haOXZFRmu4ktiq/WNe3T8nUgBi
	 NwoqcUHFeJZRXXJatdL8Do2UumVUBqwS9iTQ76GTYJKKuuRtBEcbnAsvCSF1nmio9d
	 OfKh1KL995Dq0uE0BblzX7Fz7fwp4ULmJCwp8j05GHvRSpuB2bmhz10pSjZgw+YkUl
	 K58+cmb+onKLdfifJ2TBeHL1hyhVI/C0ZpTaoXbnEfn71yHX5+S4A3bAe5zymDcy9a
	 LM18wuMjp3hsw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 26 Sep 2026 17:30:37 +0200
Subject: [PATCH net-next 4/5] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-net-next-mptcp-misc-feat-7-4-v1-4-67af4ab37406@kernel.org>
References: <20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org>
In-Reply-To: <20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Hangbin Liu <liuhangbin@kylinos.cn>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4216; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LVz5Jekfc735dQxf0j6z2k5jINm6tngouczCLtIhQcs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK2P1V7m9QXVZqozLwnpSrkH5OXLIvtsnsP552/ZCe1j
 X362l1KHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABORV2T4Hzhj31Y2k1l83mIP
 L/iePls/XchtnSTfJa6VwlFlBoX/rBgZ5pf9nN7fZq6TznygeH5bioDIv2jTdr4c4ecpp9/N6c5
 mAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Hangbin Liu <liuhangbin@kylinos.cn>

During the conversion, we retain the same filter and chain names previously
used by iptables/ip6tables. Counters are not added to accept rules because
the test does not inspect them. After conversion, the generated output
matches the original iptables/ip6tables behavior.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 58 ++++++++++++----------
 2 files changed, 34 insertions(+), 26 deletions(-)

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
+	local table
+	for table in ip ip6; do
+		ip netns exec "$ns" nft -f - <<-EOF
+			add table $table filter
+			add chain $table filter OUTPUT \
+				{ type filter hook output priority 0; policy accept; }
 
-		# RST packets might be handled by a internal dummy socket
-		ip netns exec $ns $t -A OUTPUT -p tcp --tcp-flags RST RST -m mark --mark 0 -j ACCEPT
+			# just to debug: check we have multiple subflows connection requests
+			add rule $table filter OUTPUT \
+				tcp flags & (fin | syn | rst | ack) == syn \
+				meta mark $m accept
 
-		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark $m -j ACCEPT
-		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark 0 -j DROP
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
+	local drops
+	drops=$(ip netns exec "$ns" nft -j list table "$tables" filter | \
+		jq '.nftables[] | select(has("rule")) | .rule |
+			select (.chain=="OUTPUT" and any(.expr[]; has("drop"))) |
+			.expr[] | select(has("counter")) | .counter.packets')
 
-	local v
-	for v in $values; do
-		if [ $v -ne 0 ]; then
-			mptcp_lib_pr_fail "got $tables $values in ns $ns," \
-					  "not 0 - not all expected packets marked"
-			ret=${KSFT_FAIL}
-			return 1
-		fi
-	done
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

