Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0B20764E
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347566; cv=none; b=Ted0Zp2aEsp2khRlCo/utrg+ue3kO/0iZYf3tPheT9BK5ha6ZOjZQ4ddvsBRGKY6AJr+jIW+sX4LB8fJZnu+k9rd/tv1yOTzz1WclraHmbAbJdBoXAL829OG9/Dk10c1yyV7UoXPozGa/DhggP3k4WP6eWo9skd8eWeqoZUcAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347566; c=relaxed/simple;
	bh=n8lEsj677D9kSSWysxqBhxPfYaQ6a3KahSk0Vh6QXcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtUUtO9e2/mwmYMByk9gr0G8wQ3Nnxe3icQ/CA1me2bOwy3fw7BcjB8QuotIZjeiGT0UfGMko+CA08eB3Zz9GMnGC8TQDmgT1ljFqdiXLAan//gVWaCcSrQfeB4/VgCkk0emhpFv2v76xByRWF8xcHsdfJygWP33DpJNyWVOdv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvlXAcuX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvlXAcuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F50FC4CED1;
	Fri,  7 Mar 2025 11:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347565;
	bh=n8lEsj677D9kSSWysxqBhxPfYaQ6a3KahSk0Vh6QXcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tvlXAcuXVEtETJ3rrSuqiBvGMz0Ts5OKxstEFoFiPvXlqUVYpGENYocgY+ba+h8KU
	 t99Gx80hzKEKuKkqzIWNg3c6yfj+EFF0OCRnynU4BIUSuSBLP9/OMgqbkpzteu4iHA
	 LtvWf73PCEoiaXTXJuerMDhDhTFDiU/ukVzoSWE6iataoRXSTc+ShW6q9tqu69NRSa
	 c6JfOIJEbhhzio3dwJdfNc8VhVFXLVCDXtn/d7G4aQ5YSbJKp6ta9qwvSaXxlWLwk4
	 5/egRGLBXwOVL/aNxca32Ol8WokPO5v2LvRnKOVmLyRnu5cHVXQMFSlqFOu8ob7hfT
	 JkXKzkleR15Ig==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 2/2] Squash to "selftests: mptcp: add path_manager sysctl tests"
Date: Fri,  7 Mar 2025 19:39:15 +0800
Message-ID: <c1d665b388561f7d91b2f4d45a86499eb2cd974e.1741347453.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347453.git.tanggeliang@kylinos.cn>
References: <cover.1741347453.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Check pm_type mapping in ns2 too.
Move set_path_manager to mptcp_lib.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 13 +++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 22 ++++---------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 051e289d7967..ed2c27e345f7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -693,3 +693,16 @@ mptcp_lib_pm_nl_change_endpoint() {
 		ip netns exec "${ns}" ./pm_nl_ctl set id "${id}" flags "${flags}"
 	fi
 }
+
+mptcp_lib_set_path_manager()
+{
+	local ns=$1
+	local pm=$2
+
+	if ! ip netns exec ${ns} sysctl net.mptcp.available_path_managers |
+	     grep -wq "${pm}"; then
+		test_fail "path manager ${pm} not found"
+		return 1
+	fi
+	ip netns exec ${ns} sysctl -q net.mptcp.path_manager="${pm}"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 35ba4edc0fa2..b8dec1ce5762 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -119,19 +119,6 @@ trap cleanup EXIT
 # Create and configure network namespaces for testing
 mptcp_lib_ns_init ns1 ns2
 
-set_path_manager()
-{
-	local ns=$1
-	local pm=$2
-
-	if ! ip netns exec ${ns} sysctl net.mptcp.available_path_managers |
-	     grep -wq "${pm}"; then
-		test_fail "path manager ${pm} not found"
-		return 1
-	fi
-	ip netns exec ${ns} sysctl -q net.mptcp.path_manager="${pm}"
-}
-
 if [ -f /proc/sys/net/mptcp/path_manager ]; then
 	ip netns exec "$ns1" sysctl -q net.mptcp.pm_type=0
 	pm_name="$(ip netns exec "$ns1" sysctl -n net.mptcp.path_manager)"
@@ -149,23 +136,22 @@ if [ -f /proc/sys/net/mptcp/path_manager ]; then
 		exit ${KSFT_FAIL}
 	fi
 
-	set_path_manager "$ns1" "kernel"
-	pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
+	mptcp_lib_set_path_manager "$ns2" "kernel"
+	pm_type="$(ip netns exec "$ns2" sysctl -n net.mptcp.pm_type)"
 	if [ "${pm_type}" != "0" ]; then
 		test_fail "unexpected pm_type: ${pm_type}"
 		mptcp_lib_result_print_all_tap
 		exit ${KSFT_FAIL}
 	fi
 
-	set_path_manager "$ns1" "userspace"
-	pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
+	mptcp_lib_set_path_manager "$ns2" "userspace"
+	pm_type="$(ip netns exec "$ns2" sysctl -n net.mptcp.pm_type)"
 	if [ "${pm_type}" != "1" ]; then
 		test_fail "unexpected pm_type: ${pm_type}"
 		mptcp_lib_result_print_all_tap
 		exit ${KSFT_FAIL}
 	fi
 
-	set_path_manager "$ns2" "userspace"
 	print_test "check path_manager and pm_type sysctl mapping"
 	test_pass
 else
-- 
2.43.0

