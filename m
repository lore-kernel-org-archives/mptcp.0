Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F7DDDA
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866263; cv=none; b=PvKy9NWJ44/zZ9wevV13iwt41g4r5pdWpBNk+kD8ocPvawcL0PisnCQz8CbCEkl2YbCmWow69PwpTulH6JMY/vevXbN9QL8qUCUZam5374mmZRpXQCtlHcaZnJWNOIV4cHzzW4sK7MIJCO3S2gsycxFVmJEXMf50Zs3bOPmK740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866263; c=relaxed/simple;
	bh=0ltaDYn0RNu54rUNYIrHrltvS4f/yMiUhrhzqESauYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5QdI5wPbOkfSUw4vtqyWum/HrpSmAAdWsnypMZeGDYUf+Tvc44AEcYqP7iqc3BxxlgBKYVIPTr/evErNT8J4WG9NeOyefxICV250S6eYll/ytL8YY6H3FQCaCxf7N4axreEKSoWCf8b/aNSUHGgc5ptjIQAEClH5w49gO2xQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrlQ7cic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrlQ7cic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB436C433F1;
	Sun, 25 Feb 2024 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708866263;
	bh=0ltaDYn0RNu54rUNYIrHrltvS4f/yMiUhrhzqESauYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrlQ7cicZtoJ3uzUV9po0d3tInhL24xz7pw5FsKRFPJhicm8BYAs0j51gXX55fa7g
	 giLYF5AVYRvrHVMCkMSQJ3sn4RQd+w35jQRTPLw8NmGN9Pu0U+E0I/5w82OXo22pNm
	 uFvcaEbcKUJQ2og4x9N6jawHeDvWu7187YfCminp8orDeG120X7IildycNEKFQ/Lcl
	 ypoSlnEPd1RAas4sJdhkQ69G0Gym6qaSNhfa6hlQ4UhnK0AJX67TKQdf7Wh7H/79I3
	 qC7Hlpz6ZO9TshwYaoY1QEMCSWGOeNwoFnB/dRpeHIBO7IOhK3tBX0Is8CgmrQrtCI
	 ctm7DirdBXCQQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 11/13] selftests: mptcp: export event macros in mptcp_lib
Date: Sun, 25 Feb 2024 21:03:59 +0800
Message-Id: <f53de2fa7a91667b3d875d95791226daa2708f07.1708866087.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708866087.git.tanggeliang@kylinos.cn>
References: <cover.1708866087.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

SUB_ESTABLISHED, LISTENER_CREATED, LISTENER_CLOSED, AF_INET and AF_INET6
are defined in both mptcp_join.sh and userspace_pm.sh, export all event
macros into mptcp_lib.sh. Add MPTCP_LIB_ prefix for the first three and
add readonly for the last two.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh |  23 ++--
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  11 ++
 .../selftests/net/mptcp/userspace_pm.sh       | 121 +++++++++---------
 3 files changed, 80 insertions(+), 75 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index abd5fb4704d1..14f79300e1f8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2787,13 +2787,6 @@ backup_tests()
 	fi
 }
 
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
-
 verify_listener_events()
 {
 	local evt=$1
@@ -2807,9 +2800,9 @@ verify_listener_events()
 	local sport
 	local name
 
-	if [ $e_type = $LISTENER_CREATED ]; then
+	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
 		name="LISTENER_CREATED"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
+	elif [ $e_type = $MPTCP_LIB_LISTENER_CLOSED ]; then
 		name="LISTENER_CLOSED "
 	else
 		name="$e_type"
@@ -2876,8 +2869,10 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
-		verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
+		verify_listener_events $evts_ns1 $MPTCP_LIB_LISTENER_CREATED \
+				       $AF_INET 10.0.2.1 10100
+		verify_listener_events $evts_ns1 $MPTCP_LIB_LISTENER_CLOSED \
+				       $AF_INET 10.0.2.1 10100
 		kill_events_pids
 	fi
 
@@ -3483,11 +3478,11 @@ userspace_tests()
 		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
 		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" \
 			"id 20 flags signal 10.0.3.1" "after rm_addr 10"
 		userspace_pm_rm_addr $ns1 20
-		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns1 10.0.3.1 $MPTCP_LIB_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
 		chk_rm_nr 2 2 invert
 		chk_mptcp_info subflows 0 subflows 0
@@ -3514,7 +3509,7 @@ userspace_tests()
 			"subflow"
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_addr $ns2 20
-		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"" \
 			"after rm_addr 20"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5dfdb054371d..83175166968b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 # Some variables are used below but indirectly, see check_expected_one()
+# MPTCP_LIB_ANNOUNCED and AF_INET
 #shellcheck disable=SC2034
 
 readonly KSFT_PASS=0
@@ -11,6 +12,16 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
+MPTCP_LIB_ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
+MPTCP_LIB_REMOVED=7          # MPTCP_EVENT_REMOVED
+MPTCP_LIB_SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
+MPTCP_LIB_SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
+MPTCP_LIB_LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+MPTCP_LIB_LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
+
+readonly AF_INET=2
+readonly AF_INET6=10
+
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 702484199dd2..05e0dff5397f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -19,16 +19,6 @@ if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 fi
 mptcp_lib_check_tools ip
 
-ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
-REMOVED=7          # MPTCP_EVENT_REMOVED
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
-SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
-
 file=""
 server_evts=""
 client_evts=""
@@ -309,8 +299,8 @@ test_announce()
 	   ns2eth1
 	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, reuse port"
 	sleep 0.5
-	verify_announce_event $server_evts $ANNOUNCED $server4_token "10.0.2.2" $client_addr_id \
-			      "$client4_port"
+	verify_announce_event $server_evts $MPTCP_LIB_ANNOUNCED $server4_token \
+			      "10.0.2.2" $client_addr_id "$client4_port"
 
 	# ADD_ADDR6 from the client to server machine reusing the subflow port
 	:>"$server_evts"
@@ -318,8 +308,8 @@ test_announce()
 	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1
 	print_test "ADD_ADDR6 id:${client_addr_id} dead:beef:2::2 (ns2) => ns1, reuse port"
 	sleep 0.5
-	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
-			      "$client_addr_id" "$client6_port" "v6"
+	verify_announce_event "$server_evts" "$MPTCP_LIB_ANNOUNCED" "$server6_token" \
+			      "dead:beef:2::2" "$client_addr_id" "$client6_port" "v6"
 
 	# ADD_ADDR from the client to server machine using a new port
 	:>"$server_evts"
@@ -328,7 +318,7 @@ test_announce()
 	   $client_addr_id dev ns2eth1 port $new4_port
 	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, new port"
 	sleep 0.5
-	verify_announce_event "$server_evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
+	verify_announce_event "$server_evts" "$MPTCP_LIB_ANNOUNCED" "$server4_token" "10.0.2.2"\
 			      "$client_addr_id" "$new4_port"
 
 	# Capture events on the network namespace running the client
@@ -339,7 +329,7 @@ test_announce()
 	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
-	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
+	verify_announce_event "$client_evts" "$MPTCP_LIB_ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$app4_port"
 
 	# ADD_ADDR6 from the server to client machine reusing the subflow port
@@ -348,8 +338,8 @@ test_announce()
 	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR6 id:${server_addr_id} dead:beef:2::1 (ns1) => ns2, reuse port"
 	sleep 0.5
-	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
-			      "$server_addr_id" "$app6_port" "v6"
+	verify_announce_event "$client_evts" "$MPTCP_LIB_ANNOUNCED" "$client6_token" \
+			      "dead:beef:2::1" "$server_addr_id" "$app6_port" "v6"
 
 	# ADD_ADDR from the server to client machine using a new port
 	:>"$client_evts"
@@ -358,7 +348,7 @@ test_announce()
 	   $server_addr_id dev ns1eth2 port $new4_port
 	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, new port"
 	sleep 0.5
-	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
+	verify_announce_event "$client_evts" "$MPTCP_LIB_ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$new4_port"
 }
 
@@ -419,7 +409,7 @@ test_remove()
 	   $client_addr_id
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
-	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
+	verify_remove_event "$server_evts" "$MPTCP_LIB_REMOVED" "$server4_token" "$client_addr_id"
 
 	# RM_ADDR from the client to server machine
 	:>"$server_evts"
@@ -428,7 +418,7 @@ test_remove()
 	   $client_addr_id
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
-	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
+	verify_remove_event "$server_evts" "$MPTCP_LIB_REMOVED" "$server4_token" "$client_addr_id"
 
 	# RM_ADDR6 from the client to server machine
 	:>"$server_evts"
@@ -436,7 +426,7 @@ test_remove()
 	   $client_addr_id
 	print_test "RM_ADDR6 id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
-	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
+	verify_remove_event "$server_evts" "$MPTCP_LIB_REMOVED" "$server6_token" "$client_addr_id"
 
 	# Capture events on the network namespace running the client
 	:>"$client_evts"
@@ -446,7 +436,7 @@ test_remove()
 	   $server_addr_id
 	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
-	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
+	verify_remove_event "$client_evts" "$MPTCP_LIB_REMOVED" "$client4_token" "$server_addr_id"
 
 	# RM_ADDR from the server to client machine
 	:>"$client_evts"
@@ -455,7 +445,7 @@ test_remove()
 	   $server_addr_id
 	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
-	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
+	verify_remove_event "$client_evts" "$MPTCP_LIB_REMOVED" "$client4_token" "$server_addr_id"
 
 	# RM_ADDR6 from the server to client machine
 	:>"$client_evts"
@@ -463,7 +453,7 @@ test_remove()
 	   $server_addr_id
 	print_test "RM_ADDR6 id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
-	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
+	verify_remove_event "$client_evts" "$MPTCP_LIB_REMOVED" "$client6_token" "$server_addr_id"
 }
 
 verify_subflow_events()
@@ -492,7 +482,7 @@ verify_subflow_events()
 
 	info="${e_saddr} (${e_from}) => ${e_daddr}:${e_dport} (${e_to})"
 
-	if [ "$e_type" = "$SUB_ESTABLISHED" ]
+	if [ "$e_type" = "$MPTCP_LIB_SUB_ESTABLISHED" ]
 	then
 		if [ "$e_family" = "$AF_INET6" ]
 		then
@@ -549,22 +539,24 @@ test_subflows()
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
 	   rport "$client4_port" token "$server4_token"
 	sleep 0.5
-	verify_subflow_events $server_evts $SUB_ESTABLISHED $server4_token $AF_INET "10.0.2.1" \
-			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
+	verify_subflow_events $server_evts $MPTCP_LIB_SUB_ESTABLISHED $server4_token \
+			      $AF_INET "10.0.2.1" "10.0.2.2" "$client4_port" "23" \
+			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
 	local sport
-	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
 	   "$client4_port" token "$server4_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
-			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_CLOSED" "$server4_token" \
+			      "$AF_INET" "10.0.2.1" "10.0.2.2" "$client4_port" "23" \
+			      "$client_addr_id" "ns1" "ns2"
 
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
@@ -587,21 +579,21 @@ test_subflows()
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip dead:beef:2::1 lid 23 rip\
 	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server6_token" "$AF_INET6"\
-			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
-			      "$client_addr_id" "ns1" "ns2"
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$server6_token" \
+			      "$AF_INET6" "dead:beef:2::1" "dead:beef:2::2" "$client6_port" \
+			      "23" "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip dead:beef:2::1 lport "$sport" rip\
 	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_CLOSED" "$server6_token" "$AF_INET6"\
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
 			      "$client_addr_id" "ns1" "ns2"
 
@@ -626,22 +618,23 @@ test_subflows()
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2 rport\
 	   $new4_port token "$server4_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server4_token" "$AF_INET"\
-			      "10.0.2.1" "10.0.2.2" "$new4_port" "23"\
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$server4_token" \
+			      "$AF_INET" "10.0.2.1" "10.0.2.2" "$new4_port" "23" \
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
 	   $new4_port token "$server4_token"
 	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
-			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
+	verify_subflow_events "$server_evts" "$MPTCP_LIB_SUB_CLOSED" "$server4_token" \
+			      "$AF_INET" "10.0.2.1" "10.0.2.2" "$new4_port" "23" \
+			      "$client_addr_id" "ns1" "ns2"
 
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
@@ -665,21 +658,22 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
 	   $app4_port token "$client4_token"
 	sleep 0.5
-	verify_subflow_events $client_evts $SUB_ESTABLISHED $client4_token $AF_INET "10.0.2.2"\
-			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events $client_evts $MPTCP_LIB_SUB_ESTABLISHED $client4_token $AF_INET \
+			      "10.0.2.2" "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
 	   $app4_port token "$client4_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
-			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_CLOSED" "$client4_token" \
+			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app4_port" "23" \
+			      "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
@@ -702,7 +696,7 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET6" "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
@@ -710,15 +704,16 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip dead:beef:2::2 lport "$sport" rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events $client_evts $SUB_CLOSED $client6_token $AF_INET6 "dead:beef:2::2"\
-			      "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events $client_evts $MPTCP_LIB_SUB_CLOSED $client6_token \
+			      $AF_INET6 "dead:beef:2::2" "dead:beef:2::1" "$app6_port" \
+			      "23" "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR6 from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
@@ -741,21 +736,23 @@ test_subflows()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
 	   $new4_port token "$client4_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client4_token" "$AF_INET"\
-			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client4_token" \
+			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$new4_port" "23" \
+			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
 	   $new4_port token "$client4_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
-			      "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_CLOSED" "$client4_token" \
+			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$new4_port" "23" \
+			      "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
@@ -778,7 +775,7 @@ test_subflows_v4_v6_mix()
 	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR4 id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
-	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "10.0.2.1"\
+	verify_announce_event "$client_evts" "$MPTCP_LIB_ANNOUNCED" "$client6_token" "10.0.2.1"\
 			      "$server_addr_id" "$app6_port"
 
 	# CREATE_SUBFLOW from client to server machine
@@ -786,21 +783,21 @@ test_subflows_v4_v6_mix()
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
 	   $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $MPTCP_LIB_SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
 	   $app6_port token "$client6_token"
 	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client6_token" \
+	verify_subflow_events "$client_evts" "$MPTCP_LIB_SUB_CLOSED" "$client6_token" \
 			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
 			      "$server_addr_id" "ns2" "ns1"
 
@@ -892,7 +889,8 @@ test_listener()
 	local listener_pid=$!
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CREATED \
+			       $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
@@ -908,7 +906,8 @@ test_listener()
 	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
-	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $MPTCP_LIB_LISTENER_CLOSED \
+			       $AF_INET 10.0.2.2 $client4_port
 }
 
 print_title "Make connections"
-- 
2.40.1

