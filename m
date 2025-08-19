Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1249620
	for <mptcp@lists.linux.dev>; Tue, 19 Aug 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594023; cv=none; b=CSy0v4IwE7ZTGdsvpNLHIRarTRZYkS8cmJoutmI6TynFlFHe8QjYmX7DUpmdiDdwSmyjDNfkJlUgvXG/JM0SGkUz3kI3yTngKpNusncYEuhfulAhxs9qyh2wp21hPuBCT8MoX89sPxZIL64Qor7aUBw0S1K+shFaGFgLmE2ISvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594023; c=relaxed/simple;
	bh=NJT4+JH/beYnnBG5m1sP4mD6wPxpGeugeXCHrlk138A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUYG1kxIe/nQR9W2pywApaeOt2Scdu4U3jNiF6ZKnDu/oaJG5RNRcfjcoYnX8wb0vFti0FCWya1zsP3a+jV8fNL2h6xFVHA/WBCOmSROah0i3Zfj0Hed50KUznkhMWjBCFgV5w+VcC7Y5Sre9F5l8bq6R6WvubJiFugPIn3gcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSCfrQJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSCfrQJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A9DC113D0;
	Tue, 19 Aug 2025 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594022;
	bh=NJT4+JH/beYnnBG5m1sP4mD6wPxpGeugeXCHrlk138A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSCfrQJW+ShLFdRE4ZItLL9G6rkmZuX8ZlLGp43cP/Vjrf1LdJGEwRfZY1SvhTkak
	 UNPXnMNeBFwvCiRfmohz7HwpRiJZDdrOTxGO4Aw5ymOqKMKQ0vT+x5IvGfjf/rxg+U
	 WGPm8PU5g652P1i54bIDAPXrWUOlxTBJorCPb6TlwnhDonLkk8jBPYG7lTfII46A6a
	 4HY2BS0RQ8ymjr42rnXb3aQ73uO2SY9aeWu65fhuEVlJZ/VHeeEM2MZp9Zo8myuEin
	 aNRlZ29T8WzaiFiGFe0P9pO0bHUqg15L5vMoSH7DE2xUFqfDRxKP6CIE8sAfGU7XK5
	 QEGxKVjNJ7LRg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 01/11] selftests: mptcp: sockopt: improve test output clarity
Date: Tue, 19 Aug 2025 17:00:07 +0800
Message-ID: <1300935de56f6192e9314a2293a6679595a3a138.1755592822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755592822.git.tanggeliang@kylinos.cn>
References: <cover.1755592822.git.tanggeliang@kylinos.cn>
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
 .../selftests/net/mptcp/mptcp_sockopt.sh       | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 418a903c3a4d..375d1eabe4f7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -261,28 +261,32 @@ do_mptcp_sockopt_tests()
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
+
+	print_title "SOL_MPTCP sockopt v4"
 	mptcp_lib_pr_ok
-	mptcp_lib_result_pass "sockopt v4"
+	mptcp_lib_result_pass "SOL_MPTCP sockopt v4"
 
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
+
+	print_title "SOL_MPTCP sockopt v6"
 	mptcp_lib_pr_ok
-	mptcp_lib_result_pass "sockopt v6"
+	mptcp_lib_result_pass "SOL_MPTCP sockopt v6"
 }
 
 run_tests()
@@ -329,6 +333,8 @@ do_tcpinq_tests()
 		return
 	fi
 
+	mptcp_lib_print_info "sockopt TCP_INQ"
+
 	local args
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args
-- 
2.48.1

