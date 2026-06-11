Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9B397342
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197712; cv=none; b=QSIHSxAb6nn+kPwNNx0l6HaZcxMEvDrszHI+8UQjk3nH5hjsjahFmDexC32OUN70CBWkErM4/Uy/Ofh1gc7Ry+B9XVWuMQxBC73xLlGm92nbJUfUa1XY3q1Wx2c0XW16Le7nghMAO/xjI+JucDQQKpZ3AWdlfADaTxu3q4z5jWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197712; c=relaxed/simple;
	bh=WST+T0w/BmiA+n8upGwfEYHZpuNJgt98ttaXlxltf8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXGZ9Kjba3rqilvrIlJ2QSLAnOnyBUKlQkMlLng105eu7K3rL/4QWwLBIVwKWLxdJa0Ry3UZhsZnQ8GBv/3YHBCdfSmuu4jvBi8UITEqRVyT3oriP2qmVqoYvLhjkSGKBfvJVC2e7MbhGVlDhRXLHEyLGZecQuqQ4M+JxjW8Kx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uCC3MLhQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uCC3MLhQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781197709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hBThxotl56PXwTPbk3pHl7HOMAqMgO3V4fHa5FMhwA=;
	b=uCC3MLhQcItvnbddMC5w+mzsMzT5v8CHOQfZzzQopGDKRWIruTY/p8gwXTh3VkhP4NfvYk
	pMkfHWKp8yQHOvgZzEcp/KFLhptz3zEidT1HsivIyPW/flbQTn3BPVQliSrBIRL1iSdVzi
	ybIIFCaNQUoFxoYmnv1rh56qs1G4RIA=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-next 5/9] selftests: mptcp: mptcp_sockopt.sh skips v6 paths when MPTCP IPv6 is missing
Date: Fri, 12 Jun 2026 01:07:55 +0800
Message-ID: <34b98971ae0410a819f3a9ebb996872150ac2aa3.1781196828.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781196828.git.yangang@kylinos.cn>
References: <cover.1781196828.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Confine all of ipv6-related commands to mptcp_lib_is_v6_enabled:
  - call mptcp_lib_check_ipv6() once after the existing init-time
    mptcp_lib_check_*() calls to populate the cached flag;
  - guard the ip6tables loop in add_mark_rules() and every v6
    "ip addr add" / mptcp_lib_pm_nl_add_endpoint() in init();
  - in do_mptcp_sockopt_tests(), do_tcpinq_tests() and the top-level
    run_tests dispatcher, emit a SKIP TAP line for each v6 subtest
    instead of running it.

v4 transfers, v4 mark checks and the AF_INET sockopt / TCP_INQ tests
are untouched. In a full-featured kernel the new guards always take
their v6 branch and the test set runs as before.

Assisted-by: GLM:5.1 Z.ai
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 81 ++++++++++++++-----
 1 file changed, 61 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e850a87429b6..63f1ec4604ce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -50,7 +50,7 @@ add_mark_rules()
 	local m=$2
 
 	local t
-	for t in ${iptables} ${ip6tables}; do
+	for t in ${iptables}; do
 		# just to debug: check we have multiple subflows connection requests
 		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
 
@@ -60,6 +60,21 @@ add_mark_rules()
 		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark $m -j ACCEPT
 		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark 0 -j DROP
 	done
+	# ip6tables rules require MPTCP IPv6 support in the kernel, otherwise
+	# ip6tables will reject them (or, in some environments, the binary itself
+	# may behave oddly without IPv6 available).
+	if mptcp_lib_is_v6_enabled; then
+		for t in ${ip6tables}; do
+			# just to debug: check we have multiple subflows connection requests
+			ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
+
+			# RST packets might be handled by a internal dummy socket
+			ip netns exec $ns $t -A OUTPUT -p tcp --tcp-flags RST RST -m mark --mark 0 -j ACCEPT
+
+			ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark $m -j ACCEPT
+			ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark 0 -j DROP
+		done
+	fi
 }
 
 init()
@@ -70,21 +85,29 @@ init()
 	for i in $(seq 1 4); do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
-		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
+		if mptcp_lib_is_v6_enabled; then
+			ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
+		fi
 		ip -net "$ns1" link set ns1eth$i up
 
 		ip -net "$ns2" addr add 10.0.$i.2/24 dev ns2eth$i
-		ip -net "$ns2" addr add dead:beef:$i::2/64 dev ns2eth$i nodad
+		if mptcp_lib_is_v6_enabled; then
+			ip -net "$ns2" addr add dead:beef:$i::2/64 dev ns2eth$i nodad
+		fi
 		ip -net "$ns2" link set ns2eth$i up
 
 		# let $ns2 reach any $ns1 address from any interface
 		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
 
 		mptcp_lib_pm_nl_add_endpoint "${ns1}" "10.0.${i}.1" flags signal
-		mptcp_lib_pm_nl_add_endpoint "${ns1}" "dead:beef:${i}::1" flags signal
+		if mptcp_lib_is_v6_enabled; then
+			mptcp_lib_pm_nl_add_endpoint "${ns1}" "dead:beef:${i}::1" flags signal
+		fi
 
 		mptcp_lib_pm_nl_add_endpoint "${ns2}" "10.0.${i}.2" flags signal
-		mptcp_lib_pm_nl_add_endpoint "${ns2}" "dead:beef:${i}::2" flags signal
+		if mptcp_lib_is_v6_enabled; then
+			mptcp_lib_pm_nl_add_endpoint "${ns2}" "dead:beef:${i}::2" flags signal
+		fi
 	done
 
 	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
@@ -106,6 +129,7 @@ cleanup()
 mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
 mptcp_lib_check_tools ip "${iptables}" "${ip6tables}"
+mptcp_lib_check_ipv6
 
 check_mark()
 {
@@ -274,18 +298,24 @@ do_mptcp_sockopt_tests()
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "sockopt v4"
 
-	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
-	lret=$?
+	if ! mptcp_lib_is_v6_enabled; then
+		print_title "SOL_MPTCP sockopt v6"
+		mptcp_lib_pr_skip "MPTCP IPv6 not available"
+		mptcp_lib_result_skip "sockopt v6"
+	else
+		ip netns exec "$ns_sbox" ./mptcp_sockopt -6
+		lret=$?
 
-	print_title "SOL_MPTCP sockopt v6"
-	if [ $lret -ne 0 ]; then
-		mptcp_lib_pr_fail
-		mptcp_lib_result_fail "sockopt v6"
-		ret=$lret
-		return
+		print_title "SOL_MPTCP sockopt v6"
+		if [ $lret -ne 0 ]; then
+			mptcp_lib_pr_fail
+			mptcp_lib_result_fail "sockopt v6"
+			ret=$lret
+			return
+		fi
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "sockopt v6"
 	fi
-	mptcp_lib_pr_ok
-	mptcp_lib_result_pass "sockopt v6"
 }
 
 run_tests()
@@ -339,10 +369,16 @@ do_tcpinq_tests()
 		if [ $lret -ne 0 ] ; then
 			return $lret
 		fi
-		do_tcpinq_test -6 $args
-		lret=$?
-		if [ $lret -ne 0 ] ; then
-			return $lret
+		if mptcp_lib_is_v6_enabled; then
+			do_tcpinq_test -6 $args
+			lret=$?
+			if [ $lret -ne 0 ] ; then
+				return $lret
+			fi
+		else
+			print_title "TCP_INQ cmsg/ioctl -6 $args"
+			mptcp_lib_pr_skip "MPTCP IPv6 not available"
+			mptcp_lib_result_skip "TCP_INQ: -6 $args"
 		fi
 	done
 
@@ -362,7 +398,12 @@ make_file "$sin" "server" 1
 mptcp_lib_subtests_last_ts_reset
 
 run_tests $ns1 $ns2 10.0.1.1
-run_tests $ns1 $ns2 dead:beef:1::1
+if mptcp_lib_is_v6_enabled; then
+	run_tests $ns1 $ns2 dead:beef:1::1
+else
+	mptcp_lib_result_skip "transfer ipv6"
+	mptcp_lib_result_skip "mark ipv6"
+fi
 
 do_mptcp_sockopt_tests
 do_tcpinq_tests
-- 
2.43.0

