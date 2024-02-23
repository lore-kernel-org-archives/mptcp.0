Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B8BA5F
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657699; cv=none; b=FCUr5kA6dsJT8mKKc/Hvp1waWBuCoEjTP7M/9Trw9Up/CrPdqvY8+WvFnm23aOK+PjfrQPiMTFK+DZaL0xTf81DtbJHDbT43KWmq30fUeGMOA+8TYw602Tfe42Umm45DraLa65lm//JwBqbMZnKVS/BxrD/I4nwFH9TRxb9jCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657699; c=relaxed/simple;
	bh=QF/Ku5J1XQb0e3aOVfNtKRxd4H18h1esKo7KJ+iXIGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGPq5S4ejGbeikLbJVF/LzxqQ501BtKbsZagw5hv9thsFrV7OZHGUI4m4NAMwik310CpUxXY5gh2aqTXNvKnCg60sbdT7Sets/9O9kv77YDC+GVsETbsigenMGtdWgs4wHlPTz2C2HPhYz9s1Bf+0q4mzZh9mu1CW0/8YnqKOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwcFHs3T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwcFHs3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44464C433C7;
	Fri, 23 Feb 2024 03:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657699;
	bh=QF/Ku5J1XQb0e3aOVfNtKRxd4H18h1esKo7KJ+iXIGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwcFHs3TUdHx5YDyd//aOh9i3ZNT4494yjs1LGUZhckm5mupGko0RBBzOx9TznXP8
	 1f/5fFcO7H7C2zgqHcPUVJJ0jIHSBc54JcU1F8vyc1wvRufsLVGpeADEJl8r9jV71v
	 trdJRHcYzg6j448AbFKzeTsL0yQ9+kInAZ8qcAO62f5/JQoQuCzaJhRaRe+I9UYBiL
	 XubcZ18RkrqrnPMqEF+2kXMlBkoLPyi+RKjQyQP7HVUTcqsVt1PbCkUu6r6AdB5G+p
	 X8eXWg/k/yhPl7G95P8YzWlWqUyZXeCrX/4ATorcC3qGX1n1zBsWhLCkUQezwrBEva
	 UDPxPLFCvUo0g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/8] selftests: mptcp: unify TEST_COUNT/TEST_NAME
Date: Fri, 23 Feb 2024 11:08:05 +0800
Message-Id: <1fa43917b604d9b4d0b67630f2268abad94af9fb.1708657487.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708657486.git.tanggeliang@kylinos.cn>
References: <cover.1708657486.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Most scripts use variable TEST_COUNT, but test_cnt are used in diag.sh
and simult_flows.sh. Most scripts use uppercase variable TEST_NAME, but
lowercase one are used in userspace_pm.sh. To maintain consistency with
other scripts, this patch unify them as TEST_COUNT and TEST_NAME:

    test_cnt  -> TEST_COUNT  in diag.sh, simult_flows.sh
    test_name -> TEST_NAME   in userspace_pm.sh

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh         | 12 ++++++------
 tools/testing/selftests/net/mptcp/simult_flows.sh |  6 +++---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index aa3fb808fc6d..ce2e78e6f65b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -9,7 +9,7 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns=""
-test_cnt=1
+TEST_COUNT=1
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
@@ -63,13 +63,13 @@ __chk_nr()
 		else
 			echo "[FAIL] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
-			ret=$test_cnt
+			ret=$TEST_COUNT
 		fi
 	else
 		echo "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	TEST_COUNT=$((TEST_COUNT+1))
 }
 
 __chk_msk_nr()
@@ -118,16 +118,16 @@ wait_msk_nr()
 	if [ $i -ge $timeout ]; then
 		echo "[FAIL] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-		ret=$test_cnt
+		ret=$TEST_COUNT
 	elif [ $nr != $expected ]; then
 		echo "[FAIL] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
-		ret=$test_cnt
+		ret=$TEST_COUNT
 	else
 		echo "[ OK ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	TEST_COUNT=$((TEST_COUNT+1))
 }
 
 chk_msk_fallback_nr()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 58cfdaf1db25..934034d9958b 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -14,7 +14,7 @@ ns3=""
 capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-test_cnt=1
+TEST_COUNT=1
 ret=0
 bail=0
 slack=50
@@ -126,8 +126,8 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+test_cnt))
-	test_cnt=$((test_cnt+1))
+	port=$((10000+TEST_COUNT))
+	TEST_COUNT=$((TEST_COUNT+1))
 
 	:> "$cout"
 	:> "$sout"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b0cce8f065d8..bca071ba5e4f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -53,7 +53,7 @@ server_addr_id=${RANDOM:0:2}
 ns1=""
 ns2=""
 ret=0
-test_name=""
+TEST_NAME=""
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -67,9 +67,9 @@ print_title()
 # $1: test name
 print_test()
 {
-	test_name="${1}"
+	TEST_NAME="${1}"
 
-	_printf "%-68s" "${test_name}"
+	_printf "%-68s" "${TEST_NAME}"
 }
 
 print_results()
@@ -80,13 +80,13 @@ print_results()
 test_pass()
 {
 	print_results " OK "
-	mptcp_lib_result_pass "${test_name}"
+	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
 	print_results "SKIP"
-	mptcp_lib_result_skip "${test_name}"
+	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
@@ -99,7 +99,7 @@ test_fail()
 		_printf "\t%s\n" "${1}"
 	fi
 
-	mptcp_lib_result_fail "${test_name}"
+	mptcp_lib_result_fail "${TEST_NAME}"
 }
 
 # This function is used in the cleanup trap
-- 
2.40.1

