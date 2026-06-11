Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B43438B0
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197720; cv=none; b=Zfy2DxhDcdszo/EMMf043SDu4wvXwQNP+jrKcBIbOGXKx9IX8OOn+WpABtPZbd3JC9nnOinhjYkvY1oeAi3A2eKxWapa+soQE1iEpwDo3Jx9c9JK87l5SbSHabhoEW9eJMpHDP5H9/dtjSe5Phel+3e8PgCBUzwO2aFQuBC6x84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197720; c=relaxed/simple;
	bh=sIOIYbfnHU8OsBGh4S0mrg+4/jEbLqNaDqrDE2KQ8sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRYJaAytBW3sHf1zT0Sn4w8vKf0GemmK83MEpvWBl+rU9dzUVJl+5jq3eN2Q0U3SR8tzW6a+u0qIT3fjXNYCMgbWEyiFHlaGu6/1qv2FrTSPBDk3NjcqzN0XXHsO1+m6CebUOjSrMEnvzX8otCufbszkX7uh0BamOSV6g2Ah/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qFXb+m4O; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qFXb+m4O"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781197717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H08o38Dqr4IqCIvuvya0WQqq1WwF/V9rHnyWC2WcSL0=;
	b=qFXb+m4OrWKm5DlGsfnOqG1I0YEj5XTUm/jn/Al/mQH6+4oP0rhSoOOVkB33vPKmdyMVoQ
	aiIzasGUuTAj1sLhVdTivC7hNsAcWfUEa0OUKS1NrRxXbxknJrgopyZnGs1DjNi7yBz09b
	qOo6yCHIZXv64Grdx3J2wnU9u+LuzkQ=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-next 9/9] selftests: mptcp: userspace_pm.sh skips v6 paths when MPTCP IPv6 is missing
Date: Fri, 12 Jun 2026 01:07:59 +0800
Message-ID: <b2f0e3c79cc12c87348611fdb5559da8e6a623a9.1781196828.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781196828.git.yangang@kylinos.cn>
References: <cover.1781196828.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Call mptcp_lib_check_ipv6() at script init, then guard every v6
step — the init-time dead:beef:* assignments, the v6 PM sequences
inside test_announce()/test_remove()/test_subflows(), and the
top-level make_connection "v6" / test_subflows_v4_v6_mix() calls —
with mptcp_lib_is_v6_enabled. Each v6-only subtest emits a SKIP TAP
line under its existing name when v6 is unavailable. v4 paths and
the pass/fail behaviour on a full-featured kernel are unchanged.

Assisted-by: GLM:5.1 Z.ai
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 237 ++++++++++--------
 1 file changed, 131 insertions(+), 106 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index e9ae1806ab07..8a20d33b1f03 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -18,6 +18,7 @@ if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 	exit ${KSFT_SKIP}
 fi
 mptcp_lib_check_tools ip
+mptcp_lib_check_ipv6
 
 ANNOUNCED=${MPTCP_LIB_EVENT_ANNOUNCED}
 REMOVED=${MPTCP_LIB_EVENT_REMOVED}
@@ -159,14 +160,18 @@ ip link add ns1eth2 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
 # Add IPv4/v6 addresses to the namespaces
 ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth2
 ip -net "$ns1" addr add 10.0.2.1/24 dev ns1eth2
-ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2 nodad
-ip -net "$ns1" addr add dead:beef:2::1/64 dev ns1eth2 nodad
+if mptcp_lib_is_v6_enabled; then
+	ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2 nodad
+	ip -net "$ns1" addr add dead:beef:2::1/64 dev ns1eth2 nodad
+fi
 ip -net "$ns1" link set ns1eth2 up
 
 ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
 ip -net "$ns2" addr add 10.0.2.2/24 dev ns2eth1
-ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
-ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
+if mptcp_lib_is_v6_enabled; then
+	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
+	ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
+fi
 ip -net "$ns2" link set ns2eth1 up
 
 file=$(mktemp)
@@ -344,13 +349,15 @@ test_announce()
 			      "$client4_port"
 
 	# ADD_ADDR6 from the client to server machine reusing the subflow port
-	:>"$server_evts"
-	ip netns exec "$ns2" ./pm_nl_ctl ann\
-	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1
-	print_test "ADD_ADDR6 id:client dead:beef:2::2 (ns2) => ns1, reuse port"
-	sleep 0.5
-	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
-			      "$client_addr_id" "$client6_port" "v6"
+	if mptcp_lib_is_v6_enabled; then
+		:>"$server_evts"
+		ip netns exec "$ns2" ./pm_nl_ctl ann\
+		   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1
+		print_test "ADD_ADDR6 id:client dead:beef:2::2 (ns2) => ns1, reuse port"
+		sleep 0.5
+		verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
+				      "$client_addr_id" "$client6_port" "v6"
+	fi
 
 	# ADD_ADDR from the client to server machine using a new port
 	:>"$server_evts"
@@ -374,13 +381,15 @@ test_announce()
 			      "$server_addr_id" "$app4_port"
 
 	# ADD_ADDR6 from the server to client machine reusing the subflow port
-	:>"$client_evts"
-	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
-	   $server_addr_id dev ns1eth2
-	print_test "ADD_ADDR6 id:server dead:beef:2::1 (ns1) => ns2, reuse port"
-	sleep 0.5
-	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
-			      "$server_addr_id" "$app6_port" "v6"
+	if mptcp_lib_is_v6_enabled; then
+		:>"$client_evts"
+		ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
+		   $server_addr_id dev ns1eth2
+		print_test "ADD_ADDR6 id:server dead:beef:2::1 (ns1) => ns2, reuse port"
+		sleep 0.5
+		verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
+				      "$server_addr_id" "$app6_port" "v6"
+	fi
 
 	# ADD_ADDR from the server to client machine using a new port
 	:>"$client_evts"
@@ -462,12 +471,14 @@ test_remove()
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
 	# RM_ADDR6 from the client to server machine
-	:>"$server_evts"
-	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client6_token" id\
-	   $client_addr_id
-	print_test "RM_ADDR6 id:client-1 ns2 => ns1"
-	sleep 0.5
-	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
+	if mptcp_lib_is_v6_enabled; then
+		:>"$server_evts"
+		ip netns exec "$ns2" ./pm_nl_ctl rem token "$client6_token" id\
+		   $client_addr_id
+		print_test "RM_ADDR6 id:client-1 ns2 => ns1"
+		sleep 0.5
+		verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
+	fi
 
 	# Capture events on the network namespace running the client
 	:>"$client_evts"
@@ -489,12 +500,14 @@ test_remove()
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
 	# RM_ADDR6 from the server to client machine
-	:>"$client_evts"
-	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server6_token" id\
-	   $server_addr_id
-	print_test "RM_ADDR6 id:server-1 ns1 => ns2"
-	sleep 0.5
-	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
+	if mptcp_lib_is_v6_enabled; then
+		:>"$client_evts"
+		ip netns exec "$ns1" ./pm_nl_ctl rem token "$server6_token" id\
+		   $server_addr_id
+		print_test "RM_ADDR6 id:server-1 ns1 => ns2"
+		sleep 0.5
+		verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
+	fi
 }
 
 verify_subflow_events()
@@ -609,43 +622,45 @@ test_subflows()
 	sleep 0.5
 
 	# Attempt to add a listener at dead:beef:2::2:<subflow-port>
-	ip netns exec "$ns2" ./pm_nl_ctl listen dead:beef:2::2\
-	   "$client6_port" &
-	listener_pid=$!
-
-	# ADD_ADDR6 from client to server machine reusing the subflow port
-	:>"$server_evts"
-	ip netns exec "$ns2" ./pm_nl_ctl ann dead:beef:2::2 token "$client6_token" id\
-	   $client_addr_id
-	sleep 0.5
-
-	# CREATE_SUBFLOW6 from server to client machine
-	:>"$server_evts"
-	ip netns exec "$ns1" ./pm_nl_ctl csf lip dead:beef:2::1 lid 23 rip\
-	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
-	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server6_token" "$AF_INET6"\
-			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
-			      "$client_addr_id" "ns1" "ns2"
-
-	# Delete the listener from the client ns, if one was created
-	mptcp_lib_kill_wait $listener_pid
-
-	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
-
-	# DESTROY_SUBFLOW6 from server to client machine
-	:>"$server_evts"
-	ip netns exec "$ns1" ./pm_nl_ctl dsf lip dead:beef:2::1 lport "$sport" rip\
-	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
-	sleep 0.5
-	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
-			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
-			      "$client_addr_id" "ns1" "ns2"
-
-	# RM_ADDR from client to server machine
-	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
-	   "$client6_token"
-	sleep 0.5
+	if mptcp_lib_is_v6_enabled; then
+		ip netns exec "$ns2" ./pm_nl_ctl listen dead:beef:2::2\
+		   "$client6_port" &
+		listener_pid=$!
+
+		# ADD_ADDR6 from client to server machine reusing the subflow port
+		:>"$server_evts"
+		ip netns exec "$ns2" ./pm_nl_ctl ann dead:beef:2::2 token "$client6_token" id\
+		   $client_addr_id
+		sleep 0.5
+
+		# CREATE_SUBFLOW6 from server to client machine
+		:>"$server_evts"
+		ip netns exec "$ns1" ./pm_nl_ctl csf lip dead:beef:2::1 lid 23 rip\
+		   dead:beef:2::2 rport "$client6_port" token "$server6_token"
+		sleep 0.5
+		verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server6_token" "$AF_INET6"\
+				      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
+				      "$client_addr_id" "ns1" "ns2"
+
+		# Delete the listener from the client ns, if one was created
+		mptcp_lib_kill_wait $listener_pid
+
+		sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
+
+		# DESTROY_SUBFLOW6 from server to client machine
+		:>"$server_evts"
+		ip netns exec "$ns1" ./pm_nl_ctl dsf lip dead:beef:2::1 lport "$sport" rip\
+		   dead:beef:2::2 rport "$client6_port" token "$server6_token"
+		sleep 0.5
+		verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
+				      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
+				      "$client_addr_id" "ns1" "ns2"
+
+		# RM_ADDR from client to server machine
+		ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
+		   "$client6_token"
+		sleep 0.5
+	fi
 
 	# Attempt to add a listener at 10.0.2.2:<new-port>
 	ip netns exec "$ns2" ./pm_nl_ctl listen 10.0.2.2\
@@ -724,43 +739,45 @@ test_subflows()
 	sleep 0.5
 
 	# Attempt to add a listener at dead:beef:2::1:<subflow-port>
-	ip netns exec "$ns1" ./pm_nl_ctl listen dead:beef:2::1\
-	   $app6_port &
-	listener_pid=$!
-
-	# ADD_ADDR6 from server to client machine reusing the subflow port
-	:>"$client_evts"
-	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
-	   $server_addr_id
-	sleep 0.5
-
-	# CREATE_SUBFLOW6 from client to server machine
-	:>"$client_evts"
-	ip netns exec "$ns2" ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip\
-	   dead:beef:2::1 rport $app6_port token "$client6_token"
-	sleep 0.5
-	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
-			      "$AF_INET6" "dead:beef:2::2"\
-			      "dead:beef:2::1" "$app6_port" "23"\
-			      "$server_addr_id" "ns2" "ns1"
-
-	# Delete the listener from the server ns, if one was created
-	mptcp_lib_kill_wait $listener_pid
-
-	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
-
-	# DESTROY_SUBFLOW6 from client to server machine
-	:>"$client_evts"
-	ip netns exec "$ns2" ./pm_nl_ctl dsf lip dead:beef:2::2 lport "$sport" rip\
-	   dead:beef:2::1 rport $app6_port token "$client6_token"
-	sleep 0.5
-	verify_subflow_events $client_evts $SUB_CLOSED $client6_token $AF_INET6 "dead:beef:2::2"\
-			      "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
-
-	# RM_ADDR6 from server to client machine
-	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
-	   "$server6_token"
-	sleep 0.5
+	if mptcp_lib_is_v6_enabled; then
+		ip netns exec "$ns1" ./pm_nl_ctl listen dead:beef:2::1\
+		   $app6_port &
+		listener_pid=$!
+
+		# ADD_ADDR6 from server to client machine reusing the subflow port
+		:>"$client_evts"
+		ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
+		   $server_addr_id
+		sleep 0.5
+
+		# CREATE_SUBFLOW6 from client to server machine
+		:>"$client_evts"
+		ip netns exec "$ns2" ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip\
+		   dead:beef:2::1 rport $app6_port token "$client6_token"
+		sleep 0.5
+		verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
+				      "$AF_INET6" "dead:beef:2::2"\
+				      "dead:beef:2::1" "$app6_port" "23"\
+				      "$server_addr_id" "ns2" "ns1"
+
+		# Delete the listener from the server ns, if one was created
+		mptcp_lib_kill_wait $listener_pid
+
+		sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
+
+		# DESTROY_SUBFLOW6 from client to server machine
+		:>"$client_evts"
+		ip netns exec "$ns2" ./pm_nl_ctl dsf lip dead:beef:2::2 lport "$sport" rip\
+		   dead:beef:2::1 rport $app6_port token "$client6_token"
+		sleep 0.5
+		verify_subflow_events $client_evts $SUB_CLOSED $client6_token $AF_INET6 "dead:beef:2::2"\
+				      "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
+
+		# RM_ADDR6 from server to client machine
+		ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
+		   "$server6_token"
+		sleep 0.5
+	fi
 
 	# Attempt to add a listener at 10.0.2.1:<new-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
@@ -931,13 +948,21 @@ test_listener()
 
 print_title "Make connections"
 make_connection
-make_connection "v6"
+if mptcp_lib_is_v6_enabled; then
+	make_connection "v6"
+else
+	# Track this as a skipped test for TAP output
+	test_name="Established IPv6 MPTCP Connection ns2 => ns1"
+	test_skip
+fi
 print_title "Will be using address IDs ${client_addr_id} (client) and ${server_addr_id} (server)"
 
 test_announce
 test_remove
 test_subflows
-test_subflows_v4_v6_mix
+if mptcp_lib_is_v6_enabled; then
+	test_subflows_v4_v6_mix
+fi
 test_prio
 test_listener
 
-- 
2.43.0

