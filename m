Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2BDDDA
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866265; cv=none; b=JyOn69xFSVnP8+6Z2VTPUElhVF8y1665OzSLSQ65d3E+QiUlAAxZ5yMtV9dVAAQDa8jtYlrT/re6ZrZMGgjnGeTODndpKlT5OW/EeGGuvGjvWoIdK3TvYjsF+ZVBTgR1FDbWRBm+jWtSaqgTo+8qrzkq0AvGOubxXwSwznkAang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866265; c=relaxed/simple;
	bh=Yxs+ucCitKsQT7IVVM9kRiZKjC6iLc/B9fxGl6+hU4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDqLDrMtgJCAXwaQ/dJVR582lryhfLBas88YNZSbkLygVMTo+bkb9okXZ6wyM3N6kdoLdhXE7Z0VHeTDjSdluwstsMO90UgjzHReSk2pm2GIXdTAljr5M7L4EInoWxRIWK2cyS3SKCvXd0qK+emat7Gs/X1jH+wQxvXZrZl+Wjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAnBG4lu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAnBG4lu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F169C433C7;
	Sun, 25 Feb 2024 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708866265;
	bh=Yxs+ucCitKsQT7IVVM9kRiZKjC6iLc/B9fxGl6+hU4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAnBG4luif5goK/vqSGlFZMjT8gP77dq2k0KAxaSBjreyQXduIX3DdotLMtIeaiVm
	 z0d3ck9qntMkKJjuZttWYXvFE9S7Mcn0hBLN445W22HLc7QKUDanaNCXgG6l//l3t1
	 l/iP5HDGWwhd005SVDjiuw4HMjokR94vRcn6uzVJjciBiQsfNxr+ZwVRhp8yRUGunD
	 lUk7ZOq251b5uQzbvZD42eeUCiaPP3dwAtNjURNR2d7NSYouSsIgWiks/WMe3vDn7u
	 92IGgEuetKuEl7Dh/48xu0XJ5NuTEeZQEQrUWYYk+K6NoK0HB4r8Yj6Qc6Q3PASTpp
	 vIIWFl2AJxdfA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 12/13] selftests: mptcp: add mptcp_lib_verify_listener_events
Date: Sun, 25 Feb 2024 21:04:00 +0800
Message-Id: <7ad28da76354a7cb8ad63e854f8eef8e4bbf37f2.1708866087.git.tanggeliang@kylinos.cn>
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
index 14f79300e1f8..71d345f15209 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2789,16 +2789,12 @@ backup_tests()
 
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
@@ -2815,23 +2811,12 @@ verify_listener_events()
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
index 83175166968b..cc8703dce8c0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -479,3 +479,28 @@ mptcp_lib_check_expected() {
 
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
index 05e0dff5397f..b36c42a55f03 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -842,32 +842,15 @@ test_prio()
 
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
+		mptcp_lib_result_pass "${test_name}"
 	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
+		test_fail
 	fi
-
-	check_expected "type" "family" "saddr" "sport"
 }
 
 test_listener()
@@ -883,6 +866,7 @@ test_listener()
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
+	print_test "Listener event LISTENER_CREATED 10.0.2.2:$client4_port"
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
 		$client4_port &
@@ -902,6 +886,7 @@ test_listener()
 		rport $client4_port token $server4_token
 	sleep 0.5
 
+	print_test "Listener event LISTENER_CLOSED 10.0.2.2:$client4_port"
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-- 
2.40.1

