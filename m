Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248691B7F4
	for <mptcp@lists.linux.dev>; Wed,  2 Apr 2025 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562400; cv=none; b=Z+eu+NzIoiBUBawVQWtYsO8p+zemGFiSNq4SoFT5xx+vgXVK2JNHE0Trp5ZlQ/SnCTO+9KEdYVn6zrvpKlaMQSktyCMWJa1z2NUb9fAGk0zKDEZZq48JVG2Jdftx63MTddHQIkJZAzOvnDMZz2suzHB09a0QgtSo4QLBCo19SM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562400; c=relaxed/simple;
	bh=X4dT8D1hIN7DnSRAzJ8z0FXhAaUlQJmFiZ4YWZfnzGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCf5QW8EezHjHp9+tUDai2RpZudpnZn2TZh01lY4ZOjqYa4g9RUc87lpj1/TuMLnJoR86568C35j082NPgaGlbmGFugADmDIbHX2HHnRxGPmGKSBuDvSVYc6eTt2ztElWiK5mlnOePruWL1o3x7pFI/CTCN2ELjFF8nEXAvyVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSU9EgQU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSU9EgQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA855C4CEE8;
	Wed,  2 Apr 2025 02:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743562400;
	bh=X4dT8D1hIN7DnSRAzJ8z0FXhAaUlQJmFiZ4YWZfnzGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RSU9EgQUZEtWjObRAVoh5sLj7CGPQr7ChOS6bjg0ySI2bzt/SREnQfYP5E4GzyWvG
	 XLSTI8rAUJ41u41LvBDeORKCzsaCSu/Ddus1FJoRyP+xwEgyNjY9Jem2Qg7PhddJrg
	 fkR0Fm5dWZPL7Aj0nH8SQRPs5u4MDxkr+G3+bITLmdt6uebW2AqfWeSzVoK8gj4jor
	 lLBGCZOPqVMKv+O6TLv6SVQHxj+PDmexrvlAmcurzSGj1qUBWaA4JheO97zya1ax6W
	 DZmnjln6vJmMFrN4athEEbPazTW5454I85rBb+vLpQLEJ1I/DrrXYb9totaGiGwwFb
	 9fLcnyhmsxNOA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: send REMOVE_ADDR after subflow is deleted
Date: Wed,  2 Apr 2025 10:53:09 +0800
Message-ID: <6e9b7365c7b951d9addc8e9f208eeb9739fab28e.1743562290.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743562290.git.tanggeliang@kylinos.cn>
References: <cover.1743562290.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now address entries only be removed from local_addr_list when sending a
REMOVE_ADDR by the userspace PM, they're no longer removed when a subflow
is deleted.

To make the original userspace PM selftests pass, this patch always sends
a REMOVE_ADDR when a subflow is deleted.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 4 +++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b8af65373b3a..c138b4913ad8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3624,11 +3624,12 @@ userspace_tests()
 		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_EVENT_SUB_ESTABLISHED
+		userspace_pm_rm_addr $ns1 10
 		userspace_pm_chk_dump_addr "${ns1}" \
 			"id 20 flags signal 10.0.3.1" "after rm_sf 10"
 		userspace_pm_rm_addr $ns1 20
 		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
-		chk_rm_nr 1 1 invert
+		chk_rm_nr 2 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		kill_events_pids
@@ -3653,6 +3654,7 @@ userspace_tests()
 			"subflow"
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
+		userspace_pm_rm_addr $ns2 20
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"" \
 			"after rm_sf 20"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 333064b0b5ac..c16465c9c2ca 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -628,6 +628,7 @@ test_subflows()
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip dead:beef:2::1 lport "$sport" rip\
 	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server6_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
@@ -667,6 +668,7 @@ test_subflows()
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
 	   $new4_port token "$server4_token"
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server4_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
@@ -705,6 +707,7 @@ test_subflows()
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
 	   $app4_port token "$client4_token"
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client4_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
@@ -744,6 +747,7 @@ test_subflows()
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip dead:beef:2::2 lport "$sport" rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token"
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token"
 	sleep 0.5
 	verify_subflow_events $client_evts $SUB_CLOSED $client6_token $AF_INET6 "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
@@ -781,6 +785,7 @@ test_subflows()
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
 	   $new4_port token "$client4_token"
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client4_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
 			      "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
@@ -827,6 +832,7 @@ test_subflows_v4_v6_mix()
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
 	   $app6_port token "$client6_token"
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client6_token" \
 			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
-- 
2.43.0

