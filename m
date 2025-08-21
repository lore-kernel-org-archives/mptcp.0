Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E02ECEA6
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766523; cv=none; b=okThYB1Xu40xpOu0ke39EYf53gkVg1Snbu4NmPcIqAoykkSsTVzqRMVz4nvgsTzDRfDUZ9bZKNrd7EtPfDWCHXfcBSyZ8z8UT3x0lZp7g4Bm7DOqNUdikjlHxz7A9p+NXLLYS6jW7//PEPhxPAREEoavoWkkNgsRJCTe/fOYwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766523; c=relaxed/simple;
	bh=Z8jSlQtSF3UI+BXdWwQiScWUhlOTAQGv9C3mqc+r6rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJnUcx3IvL0EMerhiM9zN9pSTVYQb9U0yLImEd2Eh1mn2FZvkyKVgx5S3pxS30kkV8Tb7kyl5piDFx9NIAykrKej9Zd0v2jM45mGLsd9xKBuk7URQlFSG+WWhZtkAmEG1fA2EO5/kcYNrFdadlifIKqNpl/qefpxLIs4dINhzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqtFY5Z1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqtFY5Z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A773BC4CEEB;
	Thu, 21 Aug 2025 08:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755766523;
	bh=Z8jSlQtSF3UI+BXdWwQiScWUhlOTAQGv9C3mqc+r6rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqtFY5Z1o8qJ12CaD8JqPD1dZYtnrrcVQ9HuPNq5Od/QZpEYCFgpHBU78XGImVl4a
	 UdseEtntCFbBmd3EfyVPPvVRZOcm2HhQbUhvF+WLsG/mnNbItjXfxTw5LozcC5+IQF
	 aM8VDTCXgcd1PMyGlSt5npdQa08cCWjKv+i1HDeGbN0rDI3sGg/pmkR3pwUTDtNALJ
	 xvDzFiN9/6A2ndbH7jf/9azKLv7QVlRg2HHOWqbEWbnexEjxIBIxU0ge4aNBymEJu5
	 tsfBRroOjQuRNm+amZJUtH8ywQ9lDhCyDg+4vFCuLQ4cYPi1u6px+EyyjyPrOfP4U/
	 jDyxMnLhwD+fw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 01/10] selftests: mptcp: sockopt: improve test output clarity
Date: Thu, 21 Aug 2025 16:54:49 +0800
Message-ID: <752c2facc23b63b8a621c0285294948594655b0b.1755680616.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755680616.git.tanggeliang@kylinos.cn>
References: <cover.1755680616.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Refine test output to print detailed titles for SOL_MPTCP socket option
tests in both IPv4 and IPv6 contexts. This enhances readability and
distinctly separates v4/v6 results. The output now explicitly labels
each test phase and result, making failures easier to identify.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 418a903c3a4d..003d218defa8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -261,28 +261,37 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
-	print_title "SOL_MPTCP sockopt v4"
+	mptcp_lib_print_info "sockopt v4"
 	if [ $lret -ne 0 ]; then
-		mptcp_lib_pr_fail
+		mptcp_lib_pr_fail "sockopt v4"
 		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
-	mptcp_lib_pr_ok
-	mptcp_lib_result_pass "sockopt v4"
+
+	for opt in "SOL_MPTCP"; do
+		print_title "$opt sockopt v4"
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "$opt sockopt v4"
+	done
 
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
-	print_title "SOL_MPTCP sockopt v6"
+	mptcp_lib_print_info "sockopt v6"
 	if [ $lret -ne 0 ]; then
-		mptcp_lib_pr_fail
+		mptcp_lib_pr_fail "sockopt v6"
 		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
-	mptcp_lib_pr_ok
-	mptcp_lib_result_pass "sockopt v6"
+
+	for opt in "SOL_MPTCP"; do
+		print_title "$opt sockopt v6"
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "$opt sockopt v6"
+	done
+
 }
 
 run_tests()
@@ -329,6 +338,8 @@ do_tcpinq_tests()
 		return
 	fi
 
+	mptcp_lib_print_info "sockopt TCP_INQ"
+
 	local args
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args
-- 
2.48.1

