Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2E3BA5F
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657707; cv=none; b=e3Nk/VpYyOkDu2IgseRKrbXtkNmn90NyTqRoZCOwpE1IaEGc5ygg6F6aqrnJ4dYfptfYho+gzlkM0oi+VVO4sVssYTM3swL5PXkP2sEEFGRmIovN6W6Uw8LGNCSxBi3tUhWORofEdj9gbopjZYgL626thBl5um/PoeXK4+XIi0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657707; c=relaxed/simple;
	bh=FgAOGkHS97EX8o+8M1dpx1Lmvpb8a8yADiPJea4pC+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AGvSpzRCQElxoJE1WAr+fHnaAESEpRxjwK8HQIo5lB1+KFigL6o5N73CS22RiXEnIBlWZqpt4AnB3lDcf7fi0qeuJULAXqp+uY3PDkZg9GZaG+6uGpUf/l20vcPHgSPnSVgIO3UyKKIv6mL9gL4dLuROk+WB7wwU388ZPg5vCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP7V/D06; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP7V/D06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B16C433C7;
	Fri, 23 Feb 2024 03:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657707;
	bh=FgAOGkHS97EX8o+8M1dpx1Lmvpb8a8yADiPJea4pC+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EP7V/D06CVUdzplMnVRS1m92HPl8Y1rqWXwPXGowJWwmfXu4SbZSG4aTCB1aNfQNj
	 i/lS5jJ+aj2vYnsKQeNu1k5SY1Mx234rkCTUx6BHcqZ7R2VTn0gMvCoGtY9Pi9PW6l
	 jmYZp5B+dbpfIdIZXzgB0zhw4T+Jr/2OX5IT6DzJkvcCchh93T5mECopbywxyBI2fr
	 S8cpGZZWXMJbOivxp38MNitKSTKlWiw0idM/DGl/brTr50S++3cLxIOZADVVkH5ESC
	 4/BfYvEqz3St6KIa95QNa92/juiW/oRqK1Fu7x57vC+czFLOcfA9Vru2d8PXUuTWMw
	 j1Vj+OljcmGdA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 8/8] selftests: mptcp: add mptcp_lib_verify_listener_events
Date: Fri, 23 Feb 2024 11:08:11 +0800
Message-Id: <5253780363327733ee3ef1b57f56b4c6d8453ea7.1708657487.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708657486.git.tanggeliang@kylinos.cn>
References: <cover.1708657486.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To avoid duplicated code in different MPTCP selftests, we can add and use
helpers defined in mptcp_lib.sh.

The helper verify_listener_events() is defined both in mptcp_join.sh and
userspace_pm.sh, export it into mptcp_lib.sh and rename it with mptcp_lib_
prefix. Use this new helper in both scripts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 25 +++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++--------------
 3 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c9b779510528..fa7d07c51973 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2791,16 +2791,12 @@ backup_tests()
 
 verify_listener_events()
 {
-	local evt=$1
 	local e_type=$2
 	local e_family=$3
 	local e_saddr=$4
 	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
 	local name
+	local rc=0
 
 	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
 		name="LISTENER_CREATED"
@@ -2817,23 +2813,12 @@ verify_listener_events()
 		return
 	fi
 
-	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
-	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
-	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
-	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
-	fi
-
-	if [ $type ] && [ $type = $e_type ] &&
-	   [ $family ] && [ $family = $e_family ] &&
-	   [ $saddr ] && [ $saddr = $e_saddr ] &&
-	   [ $sport ] && [ $sport = $e_sport ]; then
-		print_ok
+	mptcp_lib_verify_listener_events "${@}" || rc="${?}"
+	if [ "${rc}" -eq 0 ]
+	then
 		return 0
 	fi
-	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
+	fail_test "$e_type $e_family $e_saddr $e_sport"
 }
 
 add_addr_ports_tests()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index e6b9fbb51891..0ad66eb2efba 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -468,3 +468,28 @@ mptcp_lib_check_expected() {
 
 	return "${rc}"
 }
+
+mptcp_lib_verify_listener_events() {
+	local evt=$1
+	local e_type=$2
+	local e_family=$3
+	local e_saddr=$4
+	local e_sport=$5
+	local type
+	local family
+	local saddr
+	local sport
+	local rc=0
+
+	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
+	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
+	if [ "$family" ] && [ "$family" = $AF_INET6 ]; then
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
+	else
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
+	fi
+	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
+
+	mptcp_lib_check_expected "type" "family" "saddr" "sport" || rc="${?}"
+	return "${rc}"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 46ea5d8f0da2..600c2400a6db 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -841,32 +841,15 @@ test_prio()
 
 verify_listener_events()
 {
-	local evt=$1
-	local e_type=$2
-	local e_family=$3
-	local e_saddr=$4
-	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
-
-	if [ $e_type = $LISTENER_CREATED ]; then
-		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
-		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
-	fi
+	local rc=0
 
-	type=$(mptcp_lib_evts_get_info type $evt $e_type)
-	family=$(mptcp_lib_evts_get_info family $evt $e_type)
-	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
+	mptcp_lib_verify_listener_events "${@}" || rc="${?}"
+	if [ "${rc}" -eq 0 ]
+	then
+		mptcp_lib_result_pass "${TEST_NAME}"
 	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
+		test_fail
 	fi
-
-	check_expected "type" "family" "saddr" "sport"
 }
 
 test_listener()
@@ -882,6 +865,7 @@ test_listener()
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
+	print_test "Listener event LISTENER_CREATED 10.0.2.2:$client4_port"
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
 		$client4_port &
@@ -901,6 +885,7 @@ test_listener()
 		rport $client4_port token $server4_token
 	sleep 0.5
 
+	print_test "Listener event LISTENER_CLOSED 10.0.2.2:$client4_port"
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-- 
2.40.1

