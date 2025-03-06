Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2E20AF77
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258933; cv=none; b=o9BiJqatyRCwoQZ4iL6fozG0azoBqIf6SEI+VEeNoZUdygdOdxMY2jXAVmJksKjou6ocZQIL4I2gnsYlPvOKRmGyLA+6wsyNgBKaAuuKeV6B+U28TCpV5pUowg0RTHkMBAlUpT1gVK+fcoPfcvU7p928w2vr5X58CR9IRxdV/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258933; c=relaxed/simple;
	bh=ZTU9d6sfmDmRD0Pe8ErrQiYJ3Hw7O4cLW5SO4opndGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blkyQwoNgbR1Wx69+U4MKH+rHp2cDcKCfkjzXOAbmKjOYGk5rwxvjflp1WClLgu4hdaktk202ElRtmLv6W8suC+j9OacH3ghgKJoSA+Kt/EtY+73PrZkKgNftflDXCIh31NA3008UcoJwOnTxS0ZNTGqT8WDJ/Xib8R7J6slrpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECROpTfS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECROpTfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133A2C4CEEB;
	Thu,  6 Mar 2025 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258933;
	bh=ZTU9d6sfmDmRD0Pe8ErrQiYJ3Hw7O4cLW5SO4opndGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECROpTfStOs/NffAktnjdRw5+mxI9KhWZbAE+KHOiyQzl5d8hnQrOHb66B9GffzKy
	 NA74JDuRjhiwN1wOYly4HtTox+tSBPsDr0Y1Ei8DWYUGeqMu9T2YLGi+LD3sFt2FZr
	 lMuFOcSkhPW4eaDraUx6tdqszvJL9bdpK9NIhB2vd7P9KppBTvjp9o45VRVe55VpfT
	 RQf39m6iz0ji63aO/8TYR8ntqaHgx/uGLO+ibUJP92Inn4d53V+K7WL0MPAoIuodhG
	 LBmCJUF0PqWimFQsynPPUssQYwBDGdraAgsbrToICdpkZr3D4F5byJ/fgWwqPHhrAy
	 EBrJjvGIzo8Zw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 12/12] selftests: mptcp: add path_manager sysctl tests
Date: Thu,  6 Mar 2025 19:01:47 +0800
Message-ID: <d011c0b9ad15e4bc293fcb46b5864515b8239553.1741258415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741258415.git.tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch checks if the newly added net.mptcp.path_manager is mapped
successfully from or to the old net.mptcp.pm_type. And add a new helper
set_path_manager() to set the newly added net.mptcp.path_manager.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

fix

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 58 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 3651f73451cf..35ba4edc0fa2 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -118,9 +118,61 @@ trap cleanup EXIT
 
 # Create and configure network namespaces for testing
 mptcp_lib_ns_init ns1 ns2
-for i in "$ns1" "$ns2" ;do
-	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
-done
+
+set_path_manager()
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
+
+if [ -f /proc/sys/net/mptcp/path_manager ]; then
+	ip netns exec "$ns1" sysctl -q net.mptcp.pm_type=0
+	pm_name="$(ip netns exec "$ns1" sysctl -n net.mptcp.path_manager)"
+	if [ "${pm_name}" != "kernel" ]; then
+		test_fail "unexpected pm_name: ${pm_name}"
+		mptcp_lib_result_print_all_tap
+		exit ${KSFT_FAIL}
+	fi
+
+	ip netns exec "$ns1" sysctl -q net.mptcp.pm_type=1
+	pm_name="$(ip netns exec "$ns1" sysctl -n net.mptcp.path_manager)"
+	if [ "${pm_name}" != "userspace" ]; then
+		test_fail "unexpected pm_name: ${pm_name}"
+		mptcp_lib_result_print_all_tap
+		exit ${KSFT_FAIL}
+	fi
+
+	set_path_manager "$ns1" "kernel"
+	pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
+	if [ "${pm_type}" != "0" ]; then
+		test_fail "unexpected pm_type: ${pm_type}"
+		mptcp_lib_result_print_all_tap
+		exit ${KSFT_FAIL}
+	fi
+
+	set_path_manager "$ns1" "userspace"
+	pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
+	if [ "${pm_type}" != "1" ]; then
+		test_fail "unexpected pm_type: ${pm_type}"
+		mptcp_lib_result_print_all_tap
+		exit ${KSFT_FAIL}
+	fi
+
+	set_path_manager "$ns2" "userspace"
+	print_test "check path_manager and pm_type sysctl mapping"
+	test_pass
+else
+	for i in "$ns1" "$ns2"; do
+		ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
+	done
+fi
 
 #  "$ns1"              ns2
 #     ns1eth2    ns2eth1
-- 
2.43.0

