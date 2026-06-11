Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C0397342
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197719; cv=none; b=C90S7MflEknXB3iL9LyBC0B7R2bh3IEXuvwCyBv3aej/pzuB84PdfwpncwSHEmIezN5ptkOXKDGk0Qfs+Sr//V6xEtObqp0ulfbs03lAycMwB4C25ZGjHCqBRWhgBG15E6QPbCvXNsKs+K/TB5x+X7xFxz782FyV5PjMah1HqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197719; c=relaxed/simple;
	bh=DAMauKCq5b81K/zXH87/OQvhge/FiXxf/VTW8eQUGgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZR2MBEOo77OujiIEAhowh+G5liTOZRghtYXxEQEyBQl5GiZtaJmr3tYGk4mvKUmVeQ+Zvur/QYgT4bplEu9PzLgc406z0ASX/YP7EUwMcGVq16Hz6g7G05VdIivQosqT8nq1iVp/nUX6qRVUSiTmlZexw31TFQkinKscrpPA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lDm4lXrf; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lDm4lXrf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781197715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9q26wjDI4vdyqBu0P3Xn7D2phYnQgabzW5Vbg++5twk=;
	b=lDm4lXrfMFzoF2IzscCFmWdHaGXFGbYH7NjFa5tOgCbCKAPo7sCIhuP+EDvcZsTkRBeN3y
	/YCbG8XClNFU9LteWRBjqgkvbSpNlwYDw89SJxbI2YWfPzDaJYPaCdlAaJm3e4axNeGxVy
	GO5ArfY+9wbBf+Q1a7sgpEoAFm5Pq3k=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-next 8/9] selftests: mptcp: mptcp_join.sh skips v6 subtests when MPTCP IPv6 is missing
Date: Fri, 12 Jun 2026 01:07:58 +0800
Message-ID: <80c52b274dfe802a1031eabce6ce9bbc32ee0765.1781196828.git.yangang@kylinos.cn>
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

mptcp_join.sh pre-stages dead:beef:*::1/2 and v6 default routes in
init_partial(), and dozens of v6 subtests under ipv6_tests,
v4mapped_tests, mixed_tests, add_addr_timeout_tests,
signal_address_tests, link_failure_tests, laminar_endp_tests and
one userspace_tests case drive dead:beef:* or ::ffff:* endpoints. On
a CONFIG_IPV6=m kernel (which forces CONFIG_MPTCP_IPV6=n) all of
this fails.

The fix is mechanical: call mptcp_lib_check_ipv6() from init(),
guard the v6 bits in init_partial(), and prepend the standard
"if ! mptcp_lib_is_v6_enabled; then mptcp_lib_result_skip ...; elif
reset ...; then ...; fi" guard to every v6 subtest. v4 subtests and
the pass/fail behaviour on a full-featured kernel are unchanged.

Assisted-by: GLM:5.1 Z.ai
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 145 +++++++++++++-----
 1 file changed, 106 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 26fb5e433384..d3adef18b3c7 100755
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
 
@@ -189,6 +195,7 @@ init() {
 	mptcp_lib_check_mptcp
 	mptcp_lib_check_kallsyms
 	mptcp_lib_check_tools ip tc ss "${iptables}" "${ip6tables}"
+	mptcp_lib_check_ipv6
 
 	sin=$(mktemp)
 	sout=$(mktemp)
@@ -2395,8 +2402,10 @@ laminar_endp_tests()
 	fi
 
 	# laminar endpoints: these endpoints are used
-	if reset_with_tcp_filter "with multiple laminar endpoints" ns1 10.0.2.2 REJECT &&
-	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "with multiple laminar endpoints"
+	elif reset_with_tcp_filter "with multiple laminar endpoints" ns1 10.0.2.2 REJECT &&
+	     continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2538,7 +2547,9 @@ add_addr_timeout_tests()
 	fi
 
 	# add_addr timeout IPv6
-	if reset_with_add_addr_timeout "signal address, ADD_ADDR6 timeout" 6; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "signal address, ADD_ADDR6 timeout"
+	elif reset_with_add_addr_timeout "signal address, ADD_ADDR6 timeout" 6; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
@@ -2818,7 +2829,9 @@ add_tests()
 	fi
 
 	# add multiple subflows IPv6
-	if reset "add multiple subflows IPv6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "add multiple subflows IPv6"
+	elif reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		addr_nr_ns2=2 speed=slow cestab_ns2=1 \
@@ -2828,7 +2841,9 @@ add_tests()
 	fi
 
 	# add multiple addresses IPv6
-	if reset "add multiple addresses IPv6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "add multiple addresses IPv6"
+	elif reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		addr_nr_ns1=2 speed=slow cestab_ns1=1 \
@@ -2842,7 +2857,9 @@ add_tests()
 ipv6_tests()
 {
 	# subflow IPv6
-	if reset "single subflow IPv6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "single subflow IPv6"
+	elif reset "single subflow IPv6"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
@@ -2852,7 +2869,9 @@ ipv6_tests()
 	fi
 
 	# add_address, unused IPv6
-	if reset "unused signal address IPv6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "unused signal address IPv6"
+	elif reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		speed=slow \
 			run_tests $ns1 $ns2 dead:beef:1::1
@@ -2861,7 +2880,9 @@ ipv6_tests()
 	fi
 
 	# signal address IPv6
-	if reset "single address IPv6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "single address IPv6"
+	elif reset "single address IPv6"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
@@ -2872,7 +2893,9 @@ ipv6_tests()
 	fi
 
 	# single address IPv6, remove
-	if reset "remove single address IPv6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "remove single address IPv6"
+	elif reset "remove single address IPv6"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
@@ -2884,7 +2907,9 @@ ipv6_tests()
 	fi
 
 	# subflow and signal IPv6, remove
-	if reset "remove subflow and signal IPv6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "remove subflow and signal IPv6"
+	elif reset "remove subflow and signal IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
@@ -2900,7 +2925,9 @@ ipv6_tests()
 v4mapped_tests()
 {
 	# subflow IPv4-mapped to IPv4-mapped
-	if reset "single subflow IPv4-mapped"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "single subflow IPv4-mapped"
+	elif reset "single subflow IPv4-mapped"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
@@ -2909,7 +2936,9 @@ v4mapped_tests()
 	fi
 
 	# signal address IPv4-mapped with IPv4-mapped sk
-	if reset "signal address IPv4-mapped"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "signal address IPv4-mapped"
+	elif reset "signal address IPv4-mapped"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
@@ -2919,7 +2948,9 @@ v4mapped_tests()
 	fi
 
 	# subflow v4-map-v6
-	if reset "single subflow v4-map-v6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "single subflow v4-map-v6"
+	elif reset "single subflow v4-map-v6"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
@@ -2928,7 +2959,9 @@ v4mapped_tests()
 	fi
 
 	# signal address v4-map-v6
-	if reset "signal address v4-map-v6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "signal address v4-map-v6"
+	elif reset "signal address v4-map-v6"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2938,7 +2971,9 @@ v4mapped_tests()
 	fi
 
 	# subflow v6-map-v4
-	if reset "single subflow v6-map-v4"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "single subflow v6-map-v4"
+	elif reset "single subflow v6-map-v4"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
@@ -2947,7 +2982,9 @@ v4mapped_tests()
 	fi
 
 	# signal address v6-map-v4
-	if reset "signal address v6-map-v4"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "signal address v6-map-v4"
+	elif reset "signal address v6-map-v4"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
@@ -2957,7 +2994,9 @@ v4mapped_tests()
 	fi
 
 	# no subflow IPv6 to v4 address
-	if reset "no JOIN with diff families v4-v6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "no JOIN with diff families v4-v6"
+	elif reset "no JOIN with diff families v4-v6"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow
@@ -2966,7 +3005,9 @@ v4mapped_tests()
 	fi
 
 	# no subflow IPv6 to v4 address even if v6 has a valid v4 at the end
-	if reset "no JOIN with diff families v4-v6-2"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "no JOIN with diff families v4-v6-2"
+	elif reset "no JOIN with diff families v4-v6-2"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:2::10.0.3.2 flags subflow
@@ -2975,7 +3016,9 @@ v4mapped_tests()
 	fi
 
 	# no subflow IPv4 to v6 address, no need to slow down too then
-	if reset "no JOIN with diff families v6-v4"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "no JOIN with diff families v6-v4"
+	elif reset "no JOIN with diff families v6-v4"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
@@ -2986,8 +3029,10 @@ v4mapped_tests()
 
 mixed_tests()
 {
-	if reset "IPv4 sockets do not use IPv6 addresses" &&
-	   continue_if mptcp_lib_kversion_ge 6.3; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "IPv4 sockets do not use IPv6 addresses"
+	elif reset "IPv4 sockets do not use IPv6 addresses" &&
+	     continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
@@ -2997,8 +3042,10 @@ mixed_tests()
 	fi
 
 	# Need an IPv6 mptcp socket to allow subflows of both families
-	if reset "simult IPv4 and IPv6 subflows" &&
-	   continue_if mptcp_lib_kversion_ge 6.3; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "simult IPv4 and IPv6 subflows"
+	elif reset "simult IPv4 and IPv6 subflows" &&
+	     continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
@@ -3008,8 +3055,10 @@ mixed_tests()
 	fi
 
 	# cross families subflows will not be created even in fullmesh mode
-	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1" &&
-	   continue_if mptcp_lib_kversion_ge 6.3; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "simult IPv4 and IPv6 subflows, fullmesh 1x1"
+	elif reset "simult IPv4 and IPv6 subflows, fullmesh 1x1" &&
+	     continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
@@ -3025,8 +3074,10 @@ mixed_tests()
 
 	# fullmesh still tries to create all the possibly subflows with
 	# matching family
-	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2" &&
-	   continue_if mptcp_lib_kversion_ge 6.3; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "simult IPv4 and IPv6 subflows, fullmesh 2x2"
+	elif reset "simult IPv4 and IPv6 subflows, fullmesh 2x2" &&
+	     continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -3206,8 +3257,10 @@ add_addr_ports_tests()
 	fi
 
 	# signal address v6 with port
-	if reset "signal address v6 with port" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/add_addr_v6_port_drop_ts'; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "signal address v6 with port"
+	elif reset "signal address v6 with port" &&
+	     continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/add_addr_v6_port_drop_ts'; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
@@ -3312,7 +3365,9 @@ add_addr_ports_tests()
 	fi
 
 	# first signal address drops, second one still progresses
-	if reset "signal addr list progresses after tx drop"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "signal addr list progresses after tx drop"
+	elif reset "signal addr list progresses after tx drop"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 0
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_v6_port_drop_ts=0 2>/dev/null || true
@@ -3342,7 +3397,9 @@ bind_tests()
 	fi
 
 	# bind to one address should not allow extra subflows to other addresses
-	if reset "bind main address v6, no join v6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "bind main address v6, no join v6"
+	elif reset "bind main address v6, no join v6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
@@ -3376,7 +3433,9 @@ bind_tests()
 	fi
 
 	# multiple binds to allow extra subflows to other addresses
-	if reset "multiple bind to allow joins v6"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "multiple bind to allow joins v6"
+	elif reset "multiple bind to allow joins v6"; then
 		local extra_bind
 
 		pm_nl_set_limits $ns1 0 2
@@ -3398,7 +3457,9 @@ bind_tests()
 	fi
 
 	# multiple binds to allow extra subflows to other addresses: v6 LL case
-	if reset "multiple bind to allow joins v6 link-local routing"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "multiple bind to allow joins v6 link-local routing"
+	elif reset "multiple bind to allow joins v6 link-local routing"; then
 		local extra_bind ns1ll1 ns1ll2
 
 		ns1ll1="$(get_ll_addr $ns1 ns1eth1)"
@@ -3426,8 +3487,10 @@ bind_tests()
 	fi
 
 	# multiple binds to allow extra subflows to v6 LL addresses: laminar
-	if reset "multiple bind to allow joins v6 link-local laminar" &&
-	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "multiple bind to allow joins v6 link-local laminar"
+	elif reset "multiple bind to allow joins v6 link-local laminar" &&
+	     continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		local extra_bind ns1ll1 ns1ll2 ns2ll2
 
 		ns1ll1="$(get_ll_addr $ns1 ns1eth1)"
@@ -4072,7 +4135,11 @@ userspace_tests()
 	fi
 
 	# userspace pm add & remove address
-	if reset_with_events "userspace pm add & remove address" &&
+	# The test uses the v4-mapped address "::ffff:10.0.2.1" in
+	# userspace_pm_rm_sf, which requires CONFIG_MPTCP_IPV6=y in the kernel.
+	if ! mptcp_lib_is_v6_enabled; then
+		mptcp_lib_result_skip "userspace pm add & remove address"
+	elif reset_with_events "userspace pm add & remove address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 2 2
-- 
2.43.0

