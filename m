Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20879B9D
	for <mptcp@lists.linux.dev>; Wed, 22 May 2024 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374876; cv=none; b=eh8yLsRIgMstduuYwHmThrJdjef8c5JfFI4J+AviF0rUFRBJkEEvpZ9t8/bRRUKeIsfBk7qscOA7s82Cf68bmaUM+PtX8rAJS4f85cOr+IOirnFt7VEm7bmyj3ydH83CNyERHuHN2PCZ9UPnaICT1JDjHkT7WqqpueAgIwkWbn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374876; c=relaxed/simple;
	bh=NNwISTmCUhySHdqJqAx/XtaM/YAyCnKegpzkvXP4K8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKcluaQU7ek9WsmIPBCsp/vbS4pvxZ6bKEF+iPQhNW8fALvPc5wc7OROyLhppeenDzy+21hL6idVUiZMQQ0W84gIu+dt80py8k1B65moO/ehy2cCchKcFqOOPzdGLI6RcSoQI9SRU+LdJxLhGx6yNMG3DbW2DH3TEWw00BHBl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyQb5Rz2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyQb5Rz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DB6C32781;
	Wed, 22 May 2024 10:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716374875;
	bh=NNwISTmCUhySHdqJqAx/XtaM/YAyCnKegpzkvXP4K8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kyQb5Rz2gl2XcJek0WJQfYqyLcpBTE/9oGejVKiZU6VAq9w4X3vQWOCBZyK4+PDlv
	 zXxq2CLg6+/ezZPkJNS8T1NlomcT46KDrElXnac7YOn+rCYlPWimU7hYArt4wPCHxm
	 Rth+hh84fskEoRHWJ/YqZ3Y95lM2hJXKgvkDsMaqClhyLdiE0LGIAD5ogWjPDyAHnh
	 IjTFZ7KSQutBfjydZ0JitTKRfTtpLREqS9DlPfxURUdxPy6NRyQAfbj5K39+o5J/af
	 uXdGfx3+TmvtgzO0zsq4i6M1sVxRSzkmo+rluDRlkT5CtpzboTj41EF77LIHIVceVC
	 8kuLxDuc4vMEA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 May 2024 12:47:45 +0200
Subject: [PATCH mptcp-net v3 3/4] selftests: mptcp: join: mark 'fastclose'
 tests as flaky
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-selftests-mptcp-disable-flaky-v3-3-a10c68bf2680@kernel.org>
References: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
In-Reply-To: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NNwISTmCUhySHdqJqAx/XtaM/YAyCnKegpzkvXP4K8I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmTc1XBCL51eZqNF/WCzhKTzyqxP55R7BcjfUmr
 zo/z0AbxTyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZk3NVwAKCRD2t4JPQmmg
 c+hID/wKyMWGTVi6L6sf9SEVJ/cw+GHYANbpEJuqOotsNNLXS3GDo8i5QxeBKqnvEhxaalHf3T5
 8AMCTJHvuaU9UNVT0oGrjH1LvOqNXijOf3K2cKROtWg0RaPila4ap+t1XEvKzxP0teCJicbUU0+
 oPUCEssKO5TMAyUglXyaAs0nXSWiJVC5uHws9EBIaYDos78hejKcpmA1NXd1F5KMePPLPNNjjmr
 bdH1U4+10nnvWTDpOExggmtZ4fq2UlivH61r8jfp8DoiiW1Y4BfF+0mSk1ZYR6Ss/tdVhdqGfxY
 W9CIW8Pk+lhRDWxjP0TwRqP1kkhV/hEO5YvY3SAkRnkJevcxYftYCAxtszvwU3Vn1RDLb8wOZgc
 ENF9OXUfWmeuc8DoS7tYf7NOO8etm8AkCAl/Xm7LBmHlndV02TcwLcfZjFjZAUVaFgPiBIBFH3y
 YPyIG6nd2nMRoaN0TgiwflUUqMaMaz/EaEXChELgtY+hkZ3n3+OGJgtvb0Eo3hqUIy65O0f/opV
 9f6HaQwpiCVPWpro5t8CB8a6EnKCkSpLGXimUXrW3OO9CxJCDWHp25ieeFQOj1pM7o8uZxykdg7
 FKMzSQY7i03JiD0QrJOcI1k8T2P+vtdkC5Oy4oDQjFHAMrND35NmzNjL7zp+W84QbJEts/LOJaY
 eeRzz7yQUhhLbWA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These tests are flaky since their introduction. This might be less or
not visible depending on the CI running the tests, especially if it is
also busy doing other tasks in parallel, and if a debug kernel config is
being used.

It looks like this issue is often present with the NetDev CI. While this
is being investigated, the tests are marked as flaky not to create
noises on such CIs.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/324
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fefa9173bdaa..b869b46823d7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -261,6 +261,8 @@ reset()
 
 	TEST_NAME="${1}"
 
+	MPTCP_LIB_SUBTEST_FLAKY=0 # reset if modified
+
 	if skip_test; then
 		MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 		last_test_ignored=1
@@ -448,7 +450,9 @@ reset_with_tcp_filter()
 # $1: err msg
 fail_test()
 {
-	ret=${KSFT_FAIL}
+	if ! mptcp_lib_subtest_is_flaky; then
+		ret=${KSFT_FAIL}
+	fi
 
 	if [ ${#} -gt 0 ]; then
 		print_fail "${@}"
@@ -3069,6 +3073,7 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
@@ -3077,6 +3082,7 @@ fastclose_tests()
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 0 0 0 1

-- 
2.43.0

