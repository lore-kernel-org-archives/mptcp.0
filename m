Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455585326B8;
	Tue, 13 Oct 2026 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914226; cv=none; b=Dc/w9KR2whSlXD7+QHA7GiPMY8gTuaCfhKRVnPzR83UcZ6XEleArxKRbvMTYLVkOP/l6FcIiWm6vj1Jmz2Ss/HMd2RiRtgxofl+dj3poY5VCvEMp4/GVm0srp714zYEjspEZgoePsdhd3gIEwpV5pWtYJm1cm8i9RsTZplrCTQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914226; c=relaxed/simple;
	bh=Cgwqg8k87XtQLYdUfKNb5fkZ2rFrep1kyKFtwZd1/jI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+IqVZVjhVcq5fvVBJqNR6eGmSe30Qvx92QKBeTjoySAJpkxRTNuZa59gecl+u4CcOHwJ/BoFg7S2WsfKzRw6klAdwE3yv/ygPyXvEaOVOSUFp9mLbeSTWb7yuvgWixwnkLpkBzVwv3gGWl5IaKFe7s/MvRxdb0yPnW74U+3DLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd7/jOpj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd7/jOpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77B81F000FF;
	Tue, 13 Oct 2026 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791914225;
	bh=xTf7kueW9qPRwT8ws74L3f5EtnyGCz82/LoFMQUYZY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Gd7/jOpjw/JD0O9Qy25KjaznC21xdZqI1HrWcOe4ag9QrC1CSvHurdnCBDdr/Bzql
	 d8niwikvbkh4EZP/2n3ExSAbMcUY6Qg2d2EaeLBXw1VuzDS8iy8pjpeDSqwv8ho/ec
	 x/AB4opSIajIRbEIGmoB/YTzbKXSoaEsBYUuGQGJL8QHGIzsDes/TS42qnqFBEecqC
	 6GWbc9JPSj1VpnkDrwcTHmDZj2Dh8028CFsPQrBucXOnuWFOghQOQIiyaj6RLxHor8
	 TvxukxYn/PhRVwuERWhSye1EfUMBIjZXs9zqgfWAzP3uNOgQPCqhn+KH4Rt5BPNLWL
	 bCxPWYkJwaPhg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Oct 2026 19:56:40 +0200
Subject: [PATCH net-next 3/4] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-3-1181e5d2fda4@kernel.org>
References: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4@kernel.org>
In-Reply-To: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Hangbin Liu <liuhangbin@kylinos.cn>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4443; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gCbPE43kyl+ubgh1kiYXtyHCBCPGJQ1dZeR7jw3idF0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLOFTxVS9nw6bdz37GIQy+/FExc8uHFw8en8/VVPbiFW
 Y/Od1qf3lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRnJMMf+Vc2rVnBDjWxAZw
 9fNd+33lXPePR0z/xX4KVce9/J+nUc3wP81k8/Kc3su2D5juTsuabLb54N6/C6wmTqwoinRQe7L
 zLgsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Hangbin Liu <liuhangbin@kylinos.cn>

During the conversion, we retain the same filter and chain names previously
used by iptables/ip6tables. Counters are not added to accept rules because
the test does not inspect them. The syn mark rule is removed as it is
only for debugging, which could be added easily when needed.

After conversion, the generated output matches the original
iptables/ip6tables behavior.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
v2:
 - Use nft --version + JSON to support old/weird versions. (Clashiko)
 - Remove syn mark rule. (Clashiko)
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  9 +++-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 53 ++++++++++++----------
 2 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index b9d14647f401..20853d0198ff 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -528,7 +528,14 @@ mptcp_lib_check_tools() {
 				exit ${KSFT_SKIP}
 			fi
 			;;
-		"iptables"* | "ip6tables"*)
+		"nft")
+			if ! nft --version &> /dev/null || \
+			   ! nft -j list ruleset &> /dev/null; then
+				mptcp_lib_pr_skip "Could not run all tests without nft -j"
+				exit ${KSFT_SKIP}
+			fi
+			;;
+		"iptables"* | "ip6tables"* | "jq")
 			if ! "${tool}" -V &> /dev/null; then
 				mptcp_lib_pr_skip "Could not run all tests without ${tool}"
 				exit ${KSFT_SKIP}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e850a87429b6..ef2738720e24 100755
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
@@ -49,16 +47,22 @@ add_mark_rules()
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
+			# RST packets might be handled by a internal dummy socket
+			add rule $table filter OUTPUT \
+				tcp flags & rst == rst meta mark 0x0 accept
 
-		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark $m -j ACCEPT
-		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark 0 -j DROP
+			add rule $table filter OUTPUT \
+				meta l4proto tcp meta mark $m accept
+			add rule $table filter OUTPUT \
+				meta l4proto tcp meta mark 0 counter drop
+		EOF
 	done
 }
 
@@ -105,32 +109,31 @@ cleanup()
 
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

