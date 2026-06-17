Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A544BC82
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707621; cv=none; b=OvCME3uqVkoqrPSCvqvggk5YnasD0Dsm1qyWeoihOeUcpKluoT1cB8MeeLTkJI4/prgpZufvvZx0MnogvSq6wQSxwMMHOoKXanlADziryCxd7m6EobDNfPTp0N14UorrTCACnTm5bibkYr2GHfkhzLHQmL6SirwsA8EA7MHT4BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707621; c=relaxed/simple;
	bh=VyYRpUHaIpvsBj5mdIpC874ih3bjUuaF2bafTYHo3jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ur4pCrM41CvCnWa82X6h+ZzehDLvdKOuoKzjvOTl1rEByPMRF6qw6Y274WG7u+EnVqyLij2d8j0S9pDhZ9PruaX2tgIJKBxB7ZmLdAB6VE46RutqREEuNyEXvZpVifwafs/+xdxsfzsP7tcIPGOxUTkbB6hyaUaxskLDFJWrh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TN3z7iHs; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TN3z7iHs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781707614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OiiFqevuOCRUrCsCr0zChZy/RosJQh8zITH0hfwZ2XA=;
	b=TN3z7iHsBskc3eshkyYfe0KjrLubgpQArGiNi6bqLWiP0AXVFP/cqGJisHxzA4JnNSZ+xW
	gVduK/cFa9yGv3TvAiDYkuNiMYAAvIXvpGl4TN+M+RfBYqYV/yvJMG0sbFcl5+15PkXio2
	iY2FVILrVYCKysCkjEAfTMwRkB3EPGQ=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 8/9] selftests: mptcp: mptcp_join.sh skips v6 subtests when MPTCP IPv6 is missing
Date: Wed, 17 Jun 2026 22:46:15 +0800
Message-ID: <acbcf0efa677685ac782dd6360d191a8d23c6dc2.1781707101.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781707101.git.yangang@kylinos.cn>
References: <cover.1781707101.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

mptcp_join.sh configures dedicated dead:beef:*::1/2 IPv6 addresses
and IPv6 default routes inside init_partial(). A large number of
subtest groups rely on IPv6 or IPv4-mapped IPv6 endpoints:
ipv6_tests, v4mapped_tests, mixed_tests, add_addr_timeout_tests,
laminar_endp_tests, plus one v4-mapped case in userspace_tests.

All these IPv6-related routines fail on kernels built with
CONFIG_IPV6=m, which implicitly disables CONFIG_MPTCP_IPV6.

This patch adds a helper named 'skip_if' which doesn't call
mptcp_lib_fail_if_expected_feature, and can be used for guarding
 the v6 subtests in userspace_tests.

Assisted-by: GLM:5.1 Z.ai
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 102 +++++++++++++-----
 1 file changed, 78 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 26fb5e433384..f8ba4677740a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -154,16 +154,22 @@ init_partial()
 	for i in $(seq 1 "${ifaces_nr:-4}"); do
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
-		ip -net "$ns2" route add default via dead:beef:$i::1 dev ns2eth$i metric 10$i
+		if mptcp_lib_is_v6_enabled; then
+			ip -net "$ns2" route add default via dead:beef:$i::1 dev ns2eth$i metric 10$i
+		fi
 	done
 }
 
@@ -281,6 +287,19 @@ continue_if()
 	fi
 }
 
+# $@: condition
+# Like continue_if(), but the skip is unconditional: it never calls
+# mptcp_lib_fail_if_expected_feature().
+skip_if()
+{
+	if ! "${@}"; then
+		print_check "MPTCP IPv6 support is not available"
+		print_skip
+		last_test_skipped=1
+		return 1
+	fi
+}
+
 skip_test()
 {
 	if [ "${#only_tests_ids[@]}" -eq 0 ] && [ "${#only_tests_names[@]}" -eq 0 ]; then
@@ -379,6 +398,9 @@ reset_with_add_addr_timeout()
 
 	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
+		if ! mptcp_lib_is_v6_enabled; then
+			return 0
+		fi
 		tables="${ip6tables}"
 	fi
 
@@ -2396,6 +2418,7 @@ laminar_endp_tests()
 
 	# laminar endpoints: these endpoints are used
 	if reset_with_tcp_filter "with multiple laminar endpoints" ns1 10.0.2.2 REJECT &&
+	   skip_if mptcp_lib_is_v6_enabled &&
 	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
@@ -2538,7 +2561,8 @@ add_addr_timeout_tests()
 	fi
 
 	# add_addr timeout IPv6
-	if reset_with_add_addr_timeout "signal address, ADD_ADDR6 timeout" 6; then
+	if reset_with_add_addr_timeout "signal address, ADD_ADDR6 timeout" 6 &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
@@ -2818,7 +2842,8 @@ add_tests()
 	fi
 
 	# add multiple subflows IPv6
-	if reset "add multiple subflows IPv6"; then
+	if reset "add multiple subflows IPv6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		addr_nr_ns2=2 speed=slow cestab_ns2=1 \
@@ -2828,7 +2853,8 @@ add_tests()
 	fi
 
 	# add multiple addresses IPv6
-	if reset "add multiple addresses IPv6"; then
+	if reset "add multiple addresses IPv6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		addr_nr_ns1=2 speed=slow cestab_ns1=1 \
@@ -2842,7 +2868,8 @@ add_tests()
 ipv6_tests()
 {
 	# subflow IPv6
-	if reset "single subflow IPv6"; then
+	if reset "single subflow IPv6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
@@ -2852,7 +2879,8 @@ ipv6_tests()
 	fi
 
 	# add_address, unused IPv6
-	if reset "unused signal address IPv6"; then
+	if reset "unused signal address IPv6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		speed=slow \
 			run_tests $ns1 $ns2 dead:beef:1::1
@@ -2861,7 +2889,8 @@ ipv6_tests()
 	fi
 
 	# signal address IPv6
-	if reset "single address IPv6"; then
+	if reset "single address IPv6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
@@ -2872,7 +2901,8 @@ ipv6_tests()
 	fi
 
 	# single address IPv6, remove
-	if reset "remove single address IPv6"; then
+	if reset "remove single address IPv6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
@@ -2884,7 +2914,8 @@ ipv6_tests()
 	fi
 
 	# subflow and signal IPv6, remove
-	if reset "remove subflow and signal IPv6"; then
+	if reset "remove subflow and signal IPv6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
@@ -2900,7 +2931,8 @@ ipv6_tests()
 v4mapped_tests()
 {
 	# subflow IPv4-mapped to IPv4-mapped
-	if reset "single subflow IPv4-mapped"; then
+	if reset "single subflow IPv4-mapped" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
@@ -2909,7 +2941,8 @@ v4mapped_tests()
 	fi
 
 	# signal address IPv4-mapped with IPv4-mapped sk
-	if reset "signal address IPv4-mapped"; then
+	if reset "signal address IPv4-mapped" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
@@ -2919,7 +2952,8 @@ v4mapped_tests()
 	fi
 
 	# subflow v4-map-v6
-	if reset "single subflow v4-map-v6"; then
+	if reset "single subflow v4-map-v6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
@@ -2928,7 +2962,8 @@ v4mapped_tests()
 	fi
 
 	# signal address v4-map-v6
-	if reset "signal address v4-map-v6"; then
+	if reset "signal address v4-map-v6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2938,7 +2973,8 @@ v4mapped_tests()
 	fi
 
 	# subflow v6-map-v4
-	if reset "single subflow v6-map-v4"; then
+	if reset "single subflow v6-map-v4" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
@@ -2947,7 +2983,8 @@ v4mapped_tests()
 	fi
 
 	# signal address v6-map-v4
-	if reset "signal address v6-map-v4"; then
+	if reset "signal address v6-map-v4" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
@@ -2957,7 +2994,8 @@ v4mapped_tests()
 	fi
 
 	# no subflow IPv6 to v4 address
-	if reset "no JOIN with diff families v4-v6"; then
+	if reset "no JOIN with diff families v4-v6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow
@@ -2966,7 +3004,8 @@ v4mapped_tests()
 	fi
 
 	# no subflow IPv6 to v4 address even if v6 has a valid v4 at the end
-	if reset "no JOIN with diff families v4-v6-2"; then
+	if reset "no JOIN with diff families v4-v6-2" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:2::10.0.3.2 flags subflow
@@ -2975,7 +3014,8 @@ v4mapped_tests()
 	fi
 
 	# no subflow IPv4 to v6 address, no need to slow down too then
-	if reset "no JOIN with diff families v6-v4"; then
+	if reset "no JOIN with diff families v6-v4" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
@@ -2987,6 +3027,7 @@ v4mapped_tests()
 mixed_tests()
 {
 	if reset "IPv4 sockets do not use IPv6 addresses" &&
+	   skip_if mptcp_lib_is_v6_enabled &&
 	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
@@ -2998,6 +3039,7 @@ mixed_tests()
 
 	# Need an IPv6 mptcp socket to allow subflows of both families
 	if reset "simult IPv4 and IPv6 subflows" &&
+	   skip_if mptcp_lib_is_v6_enabled &&
 	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
@@ -3009,6 +3051,7 @@ mixed_tests()
 
 	# cross families subflows will not be created even in fullmesh mode
 	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1" &&
+	   skip_if mptcp_lib_is_v6_enabled &&
 	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 1 4
@@ -3026,6 +3069,7 @@ mixed_tests()
 	# fullmesh still tries to create all the possibly subflows with
 	# matching family
 	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2" &&
+	   skip_if mptcp_lib_is_v6_enabled &&
 	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 2 4
@@ -3207,6 +3251,7 @@ add_addr_ports_tests()
 
 	# signal address v6 with port
 	if reset "signal address v6 with port" &&
+	   skip_if mptcp_lib_is_v6_enabled &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/add_addr_v6_port_drop_ts'; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
@@ -3312,7 +3357,8 @@ add_addr_ports_tests()
 	fi
 
 	# first signal address drops, second one still progresses
-	if reset "signal addr list progresses after tx drop"; then
+	if reset "signal addr list progresses after tx drop" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 0
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_v6_port_drop_ts=0 2>/dev/null || true
@@ -3342,7 +3388,8 @@ bind_tests()
 	fi
 
 	# bind to one address should not allow extra subflows to other addresses
-	if reset "bind main address v6, no join v6"; then
+	if reset "bind main address v6, no join v6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
@@ -3376,7 +3423,8 @@ bind_tests()
 	fi
 
 	# multiple binds to allow extra subflows to other addresses
-	if reset "multiple bind to allow joins v6"; then
+	if reset "multiple bind to allow joins v6" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		local extra_bind
 
 		pm_nl_set_limits $ns1 0 2
@@ -3398,7 +3446,8 @@ bind_tests()
 	fi
 
 	# multiple binds to allow extra subflows to other addresses: v6 LL case
-	if reset "multiple bind to allow joins v6 link-local routing"; then
+	if reset "multiple bind to allow joins v6 link-local routing" &&
+	   skip_if mptcp_lib_is_v6_enabled; then
 		local extra_bind ns1ll1 ns1ll2
 
 		ns1ll1="$(get_ll_addr $ns1 ns1eth1)"
@@ -3427,6 +3476,7 @@ bind_tests()
 
 	# multiple binds to allow extra subflows to v6 LL addresses: laminar
 	if reset "multiple bind to allow joins v6 link-local laminar" &&
+	   skip_if mptcp_lib_is_v6_enabled &&
 	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		local extra_bind ns1ll1 ns1ll2 ns2ll2
 
@@ -4072,7 +4122,10 @@ userspace_tests()
 	fi
 
 	# userspace pm add & remove address
+	# The test uses the v4-mapped address "::ffff:10.0.2.1" in
+	# userspace_pm_rm_sf, which requires CONFIG_MPTCP_IPV6=y in the kernel.
 	if reset_with_events "userspace pm add & remove address" &&
+	   skip_if mptcp_lib_is_v6_enabled &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 2 2
@@ -4584,6 +4637,7 @@ if [ ${#tests[@]} -eq 0 ]; then
 	tests=("${all_tests_names[@]}")
 fi
 
+mptcp_lib_check_ipv6
 mptcp_lib_subtests_last_ts_reset
 for subtests in "${tests[@]}"; do
 	"${subtests}"
-- 
2.43.0

