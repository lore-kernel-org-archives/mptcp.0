Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6217A5AC
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204424; cv=none; b=U43aEh/0vLi14FxmKHyIk8OIIUN7XryxYD4NGsLSmXcSZX+sfhMdUA8jhW/U6advurn/06yuzlmIXpKDar+EXysdff/alv+wFoYUh3PUvLFP1D+FbJQK2NaxVY84QlgEJz1IdbMfsWT1/DdhLkmltxoukx5wo/Ja25gv4/AEWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204424; c=relaxed/simple;
	bh=piK/4W3mQ6FZZ7PaDzpZTdz5dIEmN8KdnW5JUvSs/kI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6uQzampvh0FYJovB72oFpQz7Xp4I8+E1Mus2/yCNRWNCw1Yn/9xOtJUf+llDas0HEwDaFqEXBBHARXpyqJffb7F33Jel9iNUmzd7HEjYE3I2GlyPyPIXAms4hdEtf8lzqeqJgEby539XvD+iG2rBzazcidyuHsiCdptUJ6c3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkmmyRZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkmmyRZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50FAC32786;
	Fri,  9 Aug 2024 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204424;
	bh=piK/4W3mQ6FZZ7PaDzpZTdz5dIEmN8KdnW5JUvSs/kI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AkmmyRZfGygB4fLXvVdEvpJQA1FDZcVQsj7h8+0qn8YBPd8+BXBM7rlASzSJy365l
	 IoHDkm1GAZxDf0YqQBF9m3mW3gNI/9VHVgh+AVjAHBIj1U+R49dxtovfgIkQ/sY5pA
	 Mz/My3P9YNv0K2umFpy2rdnLZRAyktAXf2dE5NJEQ/yktI8ZJEtS8uDcgSLwqR3Q/C
	 D5T0d6E0BBON27Xl/sMQ1hdwjww5IYV9vTdVZFfszJTofmaJJYRpW9aZv10SvMkuf6
	 8EhD1gswGVBqjn2uXpe0JYn9B8yZ5Sbm/fA/+6mpBZBo60Bdekm7gslNC3tGZRp6/3
	 Yh34QHSqm5xjQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Aug 2024 13:51:26 +0200
Subject: [PATCH mptcp-next v4 8/8] selftests: mptcp: join: mute errors when
 ran in the background
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mptcp-join-tx-mib-v4-8-98b0b0e098c5@kernel.org>
References: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
In-Reply-To: <20240809-mptcp-join-tx-mib-v4-0-98b0b0e098c5@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4122; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=piK/4W3mQ6FZZ7PaDzpZTdz5dIEmN8KdnW5JUvSs/kI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtgM/XEqaDJdUmEZFtRGGVqP/0KBSJ97sDIfYe
 d9sMMXS2q+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYDPwAKCRD2t4JPQmmg
 cx2oEADj0Vs7EIPF+ZnZgQ/7znK18d+8xgAdv3Jj+TuNfZ4yI2Z7htkNx0Em0O2Ji9l5zcoBmVb
 dlmOhH0VxEsef9NniUwSaCaDzU+EMnXZD7fqtQvn0MABFznYggCS89B6o8JuRcx2Cvq55+JxpXG
 K80i3pzKqSOLjHYdMIV4Rx/UsfLZ6Rl6rIhJ4PdxEM09FdBUJ41q8C7CwGSqvwmZ/EMtpYUZlE8
 U9lcgTptc+LfA2jbisDcnsxxZStUWBXN+w4Vgw0Y3T960mxONd360nr1DvoBbulb/9eKqhmCrir
 uLF7k2k4Lg5FiV3mXGa0mVL526ROxU9r1vlCSWWuuXwN2vMVphXZjbsS0CCUffO7RZJi0hKe4Wp
 WCbX1A36kW/7vu9gxU95h5ybOeYdMtZxSpvMb6Z/z/UZKlfJne/NgAndEnDjakg1qESHkZrzbl7
 PVHYzw62m02K7DwLZcsfkzlBr54oV3goxUqcyy5TksXFPKUMCap+1tA0zS/x0ukisjiQo2P2WlF
 jKQ5s3xmpVh2vimv9PJc4fGz0IKCuwL7DAMXga2ajxIK2GlkrGYMRiSCx1YyiE/rzorEqNODwG3
 B6xKT2tW2yh+0Qae6D8SN9o1eqWKUToqu1JR78iUclSNKSxJ8/UTfUztqjW8+FcYrPc/oGCpps7
 /GmRl2UNswa073Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The test is supposed to be killed before the end, which will likely
cause "Connection reset by peer" errors. It is confusing, especially
because in case of real transfer errors, the test will not be marked as
failed. But that's OK, there are many other tests checking that.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 36 ++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 717de94201ba..60422d11a2ae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3486,8 +3486,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 2 2
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
@@ -3521,8 +3521,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
@@ -3550,8 +3550,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
 		chk_mptcp_info subflows 0 subflows 0
@@ -3571,8 +3571,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
@@ -3595,8 +3595,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		speed=5 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
@@ -3626,8 +3626,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		speed=slow \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_mpj $ns1
@@ -3651,8 +3651,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3698,8 +3698,8 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
-		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_mpj $ns2
@@ -3735,8 +3735,8 @@ endpoint_tests()
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		test_linkfail=4 speed=20 \
-			run_tests $ns1 $ns2 10.0.1.1 &
+		{ test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
 		wait_attempt_fail $ns2

-- 
2.45.2

