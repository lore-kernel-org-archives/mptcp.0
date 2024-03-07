Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659DA2AD17
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815743; cv=none; b=YuW50P43eOIdH5mBiBlRHXJL7A/2eNgRBcwEWgqjPm/OP1YXA7mIIEP1tljZfRel8EjoeT6vHX2yW5zO/plfD11aDr1Y4K/NMny4cqgxM2GxPsZ9g48jrGNanNJrYVMOPj8pJhOLFl8MfnjPpBCwQhltmfgyv3NYCF93BSaodyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815743; c=relaxed/simple;
	bh=J4dFZTAG8Idj+xHHj8IstkFvAxCrO4s+QuHq8BoIKv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYNEAYK4+iC9kOAcecnT45KGDYPagqLbKh15sf0Ha0s3xozZkEGzhlxbEZqNzPI1eo2yVshIKS1DV9mveaT8rRHgP7Gp7PgKn8N6Wm7exMPUajWKZoLI7aJDr3f7mRqiZp94QUYTBj3k9mzJYMK010DWKV8BhpkkgB4/E5TwPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQqIGY/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQqIGY/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC6DC43394;
	Thu,  7 Mar 2024 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709815743;
	bh=J4dFZTAG8Idj+xHHj8IstkFvAxCrO4s+QuHq8BoIKv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQqIGY/rojnnQ7C4i5bQQ8x30oL4Pea2l+Y6TWuur7dm9tuhPKnJ1euk+bfGhKbvi
	 fQx0j95cP/rJZPfhvNtqwFyWswKagyd//dXRZByVLfmq+6m6lhTChhvqd4xXO6zlMK
	 p48Gdwq14SUUbrMN2nGggDcl/XOimntWoHp9HvDQ3WL/N/MLp+2HzX6RUrV4TJwzQf
	 WtcTADhhDRVJV/bHThbwNhvKhEQe1rMZeMHDwSw9ZqvVoxqBnfqwnuFALl+A3XOXr0
	 S/Hxzy/Ni8JINV2l0qPUj8+q+lAHNauSxb59OB5H3DsA9diD68NMPL6FrO/F4oM8sa
	 s5rCp3qVluWog==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/5] selftests: mptcp: export event macros in mptcp_lib
Date: Thu,  7 Mar 2024 20:48:42 +0800
Message-Id: <36afeadc75e82e20c3033628682159c1a4bc38d0.1709815545.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709815545.git.tanggeliang@kylinos.cn>
References: <cover.1709815545.git.tanggeliang@kylinos.cn>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 ++++++++-----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 18 +++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 18 +++++++--------
 3 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f28b10a61268..5f5be437b9c8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2783,13 +2783,6 @@ backup_tests()
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
 	local name
 	local rc=0
 
-	if [ $e_type = $LISTENER_CREATED ]; then
+	if [ $e_type = $MPTCP_LIB_EVENT_LISTENER_CREATED ]; then
 		name="LISTENER_CREATED"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
+	elif [ $e_type = $MPTCP_LIB_EVENT_LISTENER_CLOSED ]; then
 		name="LISTENER_CLOSED "
 	else
 		name="$e_type"
@@ -2857,8 +2850,10 @@ add_addr_ports_tests()
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
 
@@ -3464,11 +3459,11 @@ userspace_tests()
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
@@ -3495,7 +3490,7 @@ userspace_tests()
 			"subflow"
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_addr $ns2 20
-		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"" \
 			"after rm_addr 20"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index aefe4db47656..5a765af98b71 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,24 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
+# shellcheck disable=SC2034
+readonly MPTCP_LIB_EVENT_ANNOUNCED=6         # MPTCP_EVENT_ANNOUNCED
+# shellcheck disable=SC2034
+readonly MPTCP_LIB_EVENT_REMOVED=7           # MPTCP_EVENT_REMOVED
+# shellcheck disable=SC2034
+readonly MPTCP_LIB_EVENT_SUB_ESTABLISHED=10  # MPTCP_EVENT_SUB_ESTABLISHED
+# shellcheck disable=SC2034
+readonly MPTCP_LIB_EVENT_SUB_CLOSED=11       # MPTCP_EVENT_SUB_CLOSED
+# shellcheck disable=SC2034
+readonly MPTCP_LIB_EVENT_LISTENER_CREATED=15 # MPTCP_EVENT_LISTENER_CREATED
+# shellcheck disable=SC2034
+readonly MPTCP_LIB_EVENT_LISTENER_CLOSED=16  # MPTCP_EVENT_LISTENER_CLOSED
+
+# shellcheck disable=SC2034
+readonly MPTCP_LIB_AF_INET=2
+# shellcheck disable=SC2034
+readonly MPTCP_LIB_AF_INET6=10
+
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 MPTCP_LIB_TEST_COUNTER=0
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 28669e49de80..3ae215a46c86 100755
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

