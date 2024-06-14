Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76CD2F3E
	for <mptcp@lists.linux.dev>; Fri, 14 Jun 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383974; cv=none; b=X98iPzubyZjAeqYNwjGxIc8Lcxn4VVIcu6w5ghtb/2fx0YIygt4K90KJ/l+8url8sdV6Kj+erYKkOv7N+/UCSu5nYlSCDok9A1JQJlzNYCgOb1zPp9HFaSobZCp/BxhGzsnnaNTHBH8MIkSRD3eso3LZ5iy3pAVG5mX3W5cbyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383974; c=relaxed/simple;
	bh=epir2nYh0znC+A506Vl7B80DA+MLEdvpmCegk/cZWHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NCdooU1mRLGCeUXvAhqkuUEzY0KwsfbXLK8/EtgULGy2wsEJuDXX+H5grT8A8B8GIXW3h70QwCL6vjfKfCaTe0mSmd394AV4poKf4+swnBC7qExwPomVlYiIn+L205bErVr+VEzQnsp9aogrSXuoGhXedTcpgm+EgOpdAnGECIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuRqgcOI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuRqgcOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC8BC2BD10;
	Fri, 14 Jun 2024 16:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718383974;
	bh=epir2nYh0znC+A506Vl7B80DA+MLEdvpmCegk/cZWHA=;
	h=From:Date:Subject:To:Cc:From;
	b=PuRqgcOIK6LT/JDtUsuJI/ExbNzGAPmIHHPyLkjf9MZvyktn/nB8YpxfKQiHgPA48
	 o2qswyMMlIhp5OgWBoJHbF8XaGS+UqZXNIa2TTuj87jOu/4sMFPAJ2CDqzIFkohkll
	 07fyOHDFVWe1n5W1ufg1uDS4yFZxqxtBgW4VQzru1e4UvM8PO2bMA//6cvT50rTXC7
	 pxwcyFhQu39yuYaFb0iaZPSZ6Bv0QDwNniZU1S6E40fOxPIamnbGZ4VHz2iIQ3iqDT
	 Lxjd2w+OS0p7dwapMoifzJP2YCwDMKvb8Ys5oVZD+MmQmDwgDZ/7P5Kjetg56IJw32
	 TMbRMMJzAy65A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Jun 2024 18:52:34 +0200
Subject: [PATCH mptcp-net] selftests: mptcp: userspace_pm: fixed subtest
 names
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-selftests-mptcp-uspace-pm-fixed-test-names-v1-1-b5cb8274627d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFF1bGYC/yWNwQrCMBBEf6Xs2YU0xoL+ingI6UQDJi7ZKELpv
 5vg8THzZjZS1ASly7RRxSdpepUO82Gi8PDlDk5rZ7LGOrPMjhXP2KBNOUsLwm8VH8CSOaYvVh4
 ZF5+hvPgz3BEnE2ykPigVozPOrvS3Cxrd9v0HBF1f5YcAAAA=
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10059; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=epir2nYh0znC+A506Vl7B80DA+MLEdvpmCegk/cZWHA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmbHVldoLlqnu964yACxh8/sDbzn+rT+BcBnSd/
 7foip44OHmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmx1ZQAKCRD2t4JPQmmg
 c17HD/9KtN0RrEsJ5UkO5ukfpVbr7oIudGBcXRQeZsKvygJpsS0qrxLeugz/zZsWrXYKRTToEKU
 msEwDlhfPByg8MoHXs3Ycx7ZN+UOXWhlTxl1Ct8wB6JH3Ecbg4cONVLcyOj4KFc26YhHJFMlwgl
 Hm4Gvu80g3aaoF2bsj5gIsGvW028bvCYrPbMeGugK/43GsVnYvUopPoq0PrNNktaoJI7YFoOTZ9
 ep4u+jYlEhjRZ8bFAHr5Acn7+gpauK0PU6hqWPdIMqNOIx6GOnnAQicjX89SO/07ej1dysVhZzh
 Go9Zlcsmm20u6+590H/mle3picmJ5k6Gp8m7H3aBLr/I7vKrF/FdvoWk9J98EaTTjC286O2/thE
 cQSX+9je1xQhgkHE/02H1FIkIpBhoFTdk2iM0OJSD2M5BA/oBlB7+a0v7WqfH9l+3idQTeqdbNR
 krzjKhAqVpJraDa8IgnFNTjSuBgSacNUOj1zBOSZUH40xWFUyukjbrRTbQjBL2dTGeHxQbvxh26
 sSBB/mJcGboDSimcNVyvs33Reg4n7gJevpH8yDf667+rHkgAAZRru7n0rysHWC3XI4wu2TntymM
 Fnu7e0Cg3cdOKx6bVJBdXYY9n8Z6APTgJsvQk7UB0F9Z+slq975GayO5trQAX5O5KqY+wGdgs0S
 VV+fxI1L5xRvMqw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is important to have a fixed (sub)test names in TAP, because these
names are used to identify them. If they are not fixed, tracking cannot
be done.

Some subtests from the userspace_pm selftest were using random numbers
in their names: address IDs from $RANDOM, and the client port number
randomly picked by the kernel when creating the connection. These values
have been replaced by 'client' and 'server' words: that's even more
helpful than showing random numbers. Note that the addresses IDs are
incremented and decremented in the test: +1 or -1 are then displayed.

Not to loose info that can be useful for debugging in case of issues,
these random numbers are now displayed at the beginning of the test.

Fixes: f589234e1af0 ("selftests: mptcp: userspace_pm: format subtests results in TAP")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - The Netdev CI is parsing MPTCP subtests again. Because it is affected
   by this bug (passed tests are tracked), I suggest to apply and send
   this patch ASAP: it is only modifying the test name, it sounds safe.
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 46 ++++++++++++++---------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 9e2981f2d7f5..9cb05978269d 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -160,10 +160,12 @@ make_connection()
 	local is_v6=$1
 	local app_port=$app4_port
 	local connect_addr="10.0.1.1"
+	local client_addr="10.0.1.2"
 	local listen_addr="0.0.0.0"
 	if [ "$is_v6" = "v6" ]
 	then
 		connect_addr="dead:beef:1::1"
+		client_addr="dead:beef:1::2"
 		listen_addr="::"
 		app_port=$app6_port
 	else
@@ -206,6 +208,7 @@ make_connection()
 		   [ "$server_serverside" = 1 ]
 	then
 		test_pass
+		print_title "Connection info: ${client_addr}:${client_port} -> ${connect_addr}:${app_port}"
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
 		mptcp_lib_result_print_all_tap
@@ -297,7 +300,7 @@ test_announce()
 	ip netns exec "$ns2"\
 	   ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id $client_addr_id dev\
 	   ns2eth1
-	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, reuse port"
+	print_test "ADD_ADDR id:client 10.0.2.2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event $server_evts $ANNOUNCED $server4_token "10.0.2.2" $client_addr_id \
 			      "$client4_port"
@@ -306,7 +309,7 @@ test_announce()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann\
 	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1
-	print_test "ADD_ADDR6 id:${client_addr_id} dead:beef:2::2 (ns2) => ns1, reuse port"
+	print_test "ADD_ADDR6 id:client dead:beef:2::2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
 			      "$client_addr_id" "$client6_port" "v6"
@@ -316,7 +319,7 @@ test_announce()
 	client_addr_id=$((client_addr_id+1))
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
 	   $client_addr_id dev ns2eth1 port $new4_port
-	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, new port"
+	print_test "ADD_ADDR id:client+1 10.0.2.2 (ns2) => ns1, new port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
 			      "$client_addr_id" "$new4_port"
@@ -327,7 +330,7 @@ test_announce()
 	# ADD_ADDR from the server to client machine reusing the subflow port
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR id:server 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$app4_port"
@@ -336,7 +339,7 @@ test_announce()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR6 id:${server_addr_id} dead:beef:2::1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR6 id:server dead:beef:2::1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
 			      "$server_addr_id" "$app6_port" "v6"
@@ -346,7 +349,7 @@ test_announce()
 	server_addr_id=$((server_addr_id+1))
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2 port $new4_port
-	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, new port"
+	print_test "ADD_ADDR id:server+1 10.0.2.1 (ns1) => ns2, new port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$new4_port"
@@ -380,7 +383,7 @@ test_remove()
 	local invalid_token=$(( client4_token - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token $invalid_token id\
 	   $client_addr_id > /dev/null 2>&1
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1, invalid token"
+	print_test "RM_ADDR id:client ns2 => ns1, invalid token"
 	local type
 	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
@@ -394,7 +397,7 @@ test_remove()
 	local invalid_id=$(( client_addr_id + 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $invalid_id > /dev/null 2>&1
-	print_test "RM_ADDR id:${invalid_id} ns2 => ns1, invalid id"
+	print_test "RM_ADDR id:client+1 ns2 => ns1, invalid id"
 	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
@@ -407,7 +410,7 @@ test_remove()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR id:client ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -416,7 +419,7 @@ test_remove()
 	client_addr_id=$(( client_addr_id - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR id:client-1 ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -424,7 +427,7 @@ test_remove()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client6_token" id\
 	   $client_addr_id
-	print_test "RM_ADDR6 id:${client_addr_id} ns2 => ns1"
+	print_test "RM_ADDR6 id:client-1 ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
 
@@ -434,7 +437,7 @@ test_remove()
 	# RM_ADDR from the server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR id:server ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -443,7 +446,7 @@ test_remove()
 	server_addr_id=$(( server_addr_id - 1 ))
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR id:server-1 ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -451,7 +454,7 @@ test_remove()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server6_token" id\
 	   $server_addr_id
-	print_test "RM_ADDR6 id:${server_addr_id} ns1 => ns2"
+	print_test "RM_ADDR6 id:server-1 ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
 }
@@ -479,8 +482,14 @@ verify_subflow_events()
 	local locid
 	local remid
 	local info
+	local e_dport_txt
 
-	info="${e_saddr} (${e_from}) => ${e_daddr}:${e_dport} (${e_to})"
+	# only display the fixed ports
+	if [ "${e_dport}" -ge "${app4_port}" ] && [ "${e_dport}" -le "${app6_port}" ]; then
+		e_dport_txt=":${e_dport}"
+	fi
+
+	info="${e_saddr} (${e_from}) => ${e_daddr}${e_dport_txt} (${e_to})"
 
 	if [ "$e_type" = "$SUB_ESTABLISHED" ]
 	then
@@ -766,7 +775,7 @@ test_subflows_v4_v6_mix()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR4 id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
+	print_test "ADD_ADDR4 id:server 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "10.0.2.1"\
 			      "$server_addr_id" "$app6_port"
@@ -861,7 +870,7 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	print_test "CREATE_LISTENER 10.0.2.2:$client4_port"
+	print_test "CREATE_LISTENER 10.0.2.2 (client port)"
 	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
@@ -878,13 +887,14 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
-	print_test "CLOSE_LISTENER 10.0.2.2:$client4_port"
+	print_test "CLOSE_LISTENER 10.0.2.2 (client port)"
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 }
 
 print_title "Make connections"
 make_connection
 make_connection "v6"
+print_title "Will be using address IDs ${client_addr_id} (client) and ${server_addr_id} (server)"
 
 test_announce
 test_remove

---
base-commit: e0a0b47b386faa313b3afe99ba5d3b439482eb1c
change-id: 20240614-selftests-mptcp-uspace-pm-fixed-test-names-6a9e43e50c2f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

