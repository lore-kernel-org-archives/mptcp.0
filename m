Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0AE555
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709877466; cv=none; b=CPZWVRx0MmQOh7lZogQ5uRsZSJgF2LEv2CiLWxXnkLOKPAfXMWCAPPol4+XoWNqbj9Ew6ez288dR1lHUrFvA5LM4jzn/wCSz+Y3zzgYQO8yPtZRhM3tqXsQsTaycDPit1LYpPFAMSGNVzHj7o9/w8yMPZ6j8ubk0vQ8YWTLDMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709877466; c=relaxed/simple;
	bh=0f7AVl2hAegExFa8381DUjNXVylId3k6XGe6FEuGoT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMXdWGJtwEVOiyK7zvQtU/PdKRt5km7AAX0EbQEFumc8myDNQCD03fyrAqHFQUim8P4LzWADzYpzL39hS1mWNqHS/eQfus2QfVUCr/cDQAerwKRuLcMrikGe1ixL1h3OiplX3462zNf7EKqPO8sqRpxEoJt8O19kbaOPfsu1Utc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLsJXHP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLsJXHP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE1DC43390;
	Fri,  8 Mar 2024 05:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709877466;
	bh=0f7AVl2hAegExFa8381DUjNXVylId3k6XGe6FEuGoT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLsJXHP9zOuCRs0A6JLv3mXrLEGXpvG8hwJaWXtjiT2SYbC6DFw0LMkAoW4YiEQcS
	 01RCB/XqnZmYJ7GM3Paz2/eTNs9W2xZYhaiqlK/aIABkTsvIolUsoLjJA0/xY4wI5R
	 sVWw4t3HifVDAipsqLyZYWw5gkeuPZuA6WR7NH0Go+xJ6F1V1LiCOdlliWyyyoy9he
	 ziI9mZD0Ao+NlRm4CbmOfNWSpWD0/wdHASQW42u5ZN60dmcc1DEDbZ3m8+0IhJIWYx
	 waWcl7pzwF9Bx7pm8DY3SiBM0oiMFPfM4nhMDNa8NsNowqQCRodVNFPRVe+Im3Usu6
	 I5RIT+2dVkzSA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/7] selftests: mptcp: call test_fail without argument
Date: Fri,  8 Mar 2024 13:57:34 +0800
Message-Id: <4852453633fd9591d2108344d83f9dbf2674b797.1709876991.git.tanggeliang@kylinos.cn>
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

This patch modifies test_fail() to call mptcp_lib_pr_fail() only if there
are arguments (if [ ${#} -gt 0 ]) in userspace_pm.sh, add arguments
"unexpected type: ${type}" when calling test_fail() from test_remove().
Then mptcp_lib_pr_fail() can be used in check_expected_one() instead of
test_fail().

The same in mptcp_join.sh, calling fail_test() without argument, and adapt
this helper not to call print_fail() in this case.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  7 +++++--
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 ++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index cecf09d14f46..7392fc9f5ea1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -452,7 +452,9 @@ fail_test()
 {
 	ret=1
 
-	print_fail "${@}"
+	if [ ${#} -gt 0 ]; then
+		print_fail "${@}"
+	fi
 
 	# just in case a test is marked twice as failed
 	if [ ${last_test_failed} -eq 0 ]; then
@@ -2834,7 +2836,8 @@ verify_listener_events()
 		print_ok
 		return 0
 	fi
-	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
+	print_fail "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
+	fail_test
 }
 
 add_addr_ports_tests()
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 4e29aa9c2529..bc2f0184b1eb 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -85,7 +85,10 @@ test_skip()
 # $1: msg
 test_fail()
 {
-	mptcp_lib_pr_fail "${@}"
+	if [ ${#} -gt 0 ]
+	then
+		mptcp_lib_pr_fail "${@}"
+	fi
 	ret=1
 	mptcp_lib_result_fail "${test_name}"
 }
@@ -239,7 +242,7 @@ check_expected_one()
 
 	if [ "${prev_ret}" = "0" ]
 	then
-		test_fail
+		mptcp_lib_pr_fail
 	fi
 
 	mptcp_lib_print_err "\tExpected value for '${var}': '${!exp}', got '${!var}'."
@@ -263,6 +266,7 @@ check_expected()
 		return 0
 	fi
 
+	test_fail
 	return 1
 }
 
@@ -412,7 +416,7 @@ test_remove()
 	then
 		test_pass
 	else
-		test_fail
+		test_fail "unexpected type: ${type}"
 	fi
 
 	# RM_ADDR using an invalid addr id should result in no action
@@ -425,7 +429,7 @@ test_remove()
 	then
 		test_pass
 	else
-		test_fail
+		test_fail "unexpected type: ${type}"
 	fi
 
 	# RM_ADDR from the client to server machine
-- 
2.40.1

