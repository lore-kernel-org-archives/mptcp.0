Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D86BB58
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ib3M3vRP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703158411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niZJ9lbrFac0AQ+yYC4krRKSify8EAx1cuFM73ZwEjw=;
	b=ib3M3vRPvqBrCOKJaYOQAH2NYLHeeK1eOP4+upA9bKM7JDQ9BXcrS7i4uIgUvs3rVJvguJ
	2kxyfa/TWtAKES8pQBkzX/YSqEujGnBwwLjJ8Col5kO6B3g0dwuy8NNvvaF4AQZJeHlGza
	AkS9QCz5AlrQAV7idWmoKuzX+drVT88=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 09/15] selftests: mptcp: add mptcp_lib_verify_listener_events
Date: Thu, 21 Dec 2023 19:31:12 +0800
Message-Id: <9db4d63d30b8ea4bde782753a7870ad0724f4c2c.1703158128.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703158128.git.geliang.tang@linux.dev>
References: <cover.1703158128.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To avoid duplicated code in different MPTCP selftests, we can add and use
helpers defined in mptcp_lib.sh.

The helper verify_listener_events() is defined both in mptcp_join.sh and
userspace_pm.sh, export it into mptcp_lib.sh and rename it with mptcp_lib_
prefix. Use this new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 ++-------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 23 ++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 30 ++++---------------
 3 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1bdf28613494..c90c987f8993 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2818,15 +2818,10 @@ backup_tests()
 
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
 
 	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
@@ -2844,23 +2839,8 @@ verify_listener_events()
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
-		return 0
-	fi
-	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
+	mptcp_lib_verify_listener_events ${*}
+	[ $? -eq 1 ] && fail_test "$e_type $e_family $e_saddr $e_sport"
 }
 
 add_addr_ports_tests()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 872946eb28d3..edf46462c623 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -434,3 +434,26 @@ mptcp_lib_check_expected() {
 
 	return 1
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
+
+	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
+	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
+	if [ $family ] && [ $family = $AF_INET6 ]; then
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
+	else
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
+	fi
+	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
+
+	mptcp_lib_check_expected "type" "family" "saddr" "sport"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 057024bf21a8..1e4493363d0b 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -838,32 +838,12 @@ test_prio()
 
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
-
-	type=$(mptcp_lib_evts_get_info type $evt $e_type)
-	family=$(mptcp_lib_evts_get_info family $evt $e_type)
-	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
+	mptcp_lib_verify_listener_events ${*}
+	if [ $? -eq 0 ]; then
+		mptcp_lib_result_pass "${TEST_NAME}"
 	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
+		test_fail
 	fi
-
-	check_expected "type" "family" "saddr" "sport"
 }
 
 test_listener()
@@ -879,6 +859,7 @@ test_listener()
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
+	print_test "Listener event LISTENER_CREATED 10.0.2.2:$client4_port"
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
 		$client4_port &
@@ -898,6 +879,7 @@ test_listener()
 		rport $client4_port token $server4_token
 	sleep 0.5
 
+	print_test "Listener event LISTENER_CLOSED 10.0.2.2:$client4_port"
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-- 
2.35.3

