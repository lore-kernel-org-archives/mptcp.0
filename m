Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631E01E4A4
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709877471; cv=none; b=UHqI21GPzQC3388DKavVQ4Z7xdm2vSsTm9d9fETJkKYfPXKW9OZ92jyyvjUIPNhREQuAOauv5GQ5Z4b9Ur9BgxT/11Fw37XRWrnoQFxc1Ohy4xYMRBHMfZy5Zh3WdMXD7oEwUlpf4l+umx6t3tYfT4gHy6Jc7Ps220MMUwsn+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709877471; c=relaxed/simple;
	bh=OiNh0YszO+yerRwenGf2K9Kp6HVoH8nrbGt9dzasREw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JnKpnSuS3/3Flh8uLBlKTw5XaDqTlQG+ezyn9C/a1R1muY4cPhzHZbyRp/J7T0/VtVWjVX/SN1ip7OMRFYk1r0xawht/dSQNMDzmi21WRRhH6/5bA8sWekH69cB4dhbob7MQQP/QYFg+SvsnUmw3rr+JaDNTIXobn9CZMZIrYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgIMYwg2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgIMYwg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B498C433C7;
	Fri,  8 Mar 2024 05:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709877471;
	bh=OiNh0YszO+yerRwenGf2K9Kp6HVoH8nrbGt9dzasREw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgIMYwg2FunaLqIUsESG4zfdTYgfOUc2NvOghMUKyZtvYUE0IIjXHP2ECxLlc+HIk
	 0yP8YlVB0pevhuopNeH795FFuqNf8Vi8ZRkWwJg3XiBG2mvAYomTlzEq/7JszfIdDB
	 sTq7kdPo1yGwLQPQe8rIzJV8mlgu0qx0RFvhQKpTtW2E3bDOu2M2EwdUls4wm0+X0l
	 uxgIb+K8wNR7KHUxJY503rXrqld6fze2EWS06+uPuoncmA9dGyRiBvYfpJrXOjyQL3
	 sBKKrkVCZ7um43qYxjEmLydxKdaQV28hO4nTX5jppPfuuOV9/u1DjWe2Xc2WcnTLOA
	 uHJ5noTbRxFQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/7] selftests: mptcp: declare event macros in mptcp_lib
Date: Fri,  8 Mar 2024 13:57:38 +0800
Message-Id: <7cc6459e3032ff3a8cb9c35c9628b828524305f3.1709876991.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709876991.git.tanggeliang@kylinos.cn>
References: <cover.1709876991.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP event macros (SUB_ESTABLISHED, LISTENER_CREATED, LISTENER_CLOSED),
and the protocol family macros (AF_INET, AF_INET6) are defined in both
mptcp_join.sh and userspace_pm.sh. In order not to duplicate code, this
patch declares them all in mptcp_lib.sh with MPTCP_LIB_ prefixs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 ++++++++-----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 11 +++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 18 +++++++--------
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 84eb01a16fb8..fc301789a8b5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2785,13 +2785,6 @@ backup_tests()
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
 	local e_type=$2
@@ -2799,9 +2792,9 @@ verify_listener_events()
 	local e_sport=$5
 	local name
 
-	if [ $e_type = $LISTENER_CREATED ]; then
+	if [ $e_type = $MPTCP_LIB_EVENT_LISTENER_CREATED ]; then
 		name="LISTENER_CREATED"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
+	elif [ $e_type = $MPTCP_LIB_EVENT_LISTENER_CLOSED ]; then
 		name="LISTENER_CLOSED "
 	else
 		name="$e_type"
@@ -2856,8 +2849,10 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
-		verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
+		verify_listener_events $evts_ns1 $MPTCP_LIB_EVENT_LISTENER_CREATED \
+				       $MPTCP_LIB_AF_INET 10.0.2.1 10100
+		verify_listener_events $evts_ns1 $MPTCP_LIB_EVENT_LISTENER_CLOSED \
+				       $MPTCP_LIB_AF_INET 10.0.2.1 10100
 		kill_events_pids
 	fi
 
@@ -3463,11 +3458,11 @@ userspace_tests()
 		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
 		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" \
 			"id 20 flags signal 10.0.3.1" "after rm_addr 10"
 		userspace_pm_rm_addr $ns1 20
-		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns1 10.0.3.1 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
 		chk_rm_nr 2 2 invert
 		chk_mptcp_info subflows 0 subflows 0
@@ -3494,7 +3489,7 @@ userspace_tests()
 			"subflow"
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_addr $ns2 20
-		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"" \
 			"after rm_addr 20"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index a977a722fb3d..d529b4b37af8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,17 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
+# These variables are used in some selftests, read-only
+declare -rx MPTCP_LIB_EVENT_ANNOUNCED=6         # MPTCP_EVENT_ANNOUNCED
+declare -rx MPTCP_LIB_EVENT_REMOVED=7           # MPTCP_EVENT_REMOVED
+declare -rx MPTCP_LIB_EVENT_SUB_ESTABLISHED=10  # MPTCP_EVENT_SUB_ESTABLISHED
+declare -rx MPTCP_LIB_EVENT_SUB_CLOSED=11       # MPTCP_EVENT_SUB_CLOSED
+declare -rx MPTCP_LIB_EVENT_LISTENER_CREATED=15 # MPTCP_EVENT_LISTENER_CREATED
+declare -rx MPTCP_LIB_EVENT_LISTENER_CLOSED=16  # MPTCP_EVENT_LISTENER_CLOSED
+
+declare -rx MPTCP_LIB_AF_INET=2
+declare -rx MPTCP_LIB_AF_INET6=10
+
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 MPTCP_LIB_TEST_COUNTER=0
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 1e0b39e5525c..72dca742280f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -19,15 +19,15 @@ if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
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
+ANNOUNCED=${MPTCP_LIB_EVENT_ANNOUNCED}
+REMOVED=${MPTCP_LIB_EVENT_REMOVED}
+SUB_ESTABLISHED=${MPTCP_LIB_EVENT_SUB_ESTABLISHED}
+SUB_CLOSED=${MPTCP_LIB_EVENT_SUB_CLOSED}
+LISTENER_CREATED=${MPTCP_LIB_EVENT_LISTENER_CREATED}
+LISTENER_CLOSED=${MPTCP_LIB_EVENT_LISTENER_CLOSED}
+
+AF_INET=${MPTCP_LIB_AF_INET}
+AF_INET6=${MPTCP_LIB_AF_INET6}
 
 file=""
 server_evts=""
-- 
2.40.1

