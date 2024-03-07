Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8C12B167
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815739; cv=none; b=uJdun3TNuOU892kUzAd1smFLdcOUBF1HpGum/xWAu4X5TwK6yfm9TTVTKrCExKGc/0mCntKpjW1+akGLdOcsLPeWCNBEY2sQ7jAve/Y1WyesCrcBdW1mV3hXKsIJ/YxqkrS939dLIooNdb2Ck42JOD0if0iFpMBHbGkGXd4Ygis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815739; c=relaxed/simple;
	bh=uIRLvHX3CjoY4bl58xEBR8R3aWju+Vt9JOog6WBhVxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dIjm5OHDaYigTaesSChZuwh9mkzLUrmKMcWcsidswtLZ6eOostTglFFi9OYfISWO88lQIeGIKAD2dH+oRm46SnZ6bC8LmMFmIfXrYGpk4Gbm694DrKUj0R1Ljdx73XDN7GBWICIT9V1LactiGyZyUOWFyqD+zwOf1jjPYeMh2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoZYUIo3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoZYUIo3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A3EC433F1;
	Thu,  7 Mar 2024 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709815739;
	bh=uIRLvHX3CjoY4bl58xEBR8R3aWju+Vt9JOog6WBhVxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hoZYUIo3TSZFxfIm8W29+c43HEoO5pyWjUY4131f49HMm0jLyqRlcoqGqLoXfCcNq
	 fF5N3W70rFtHUiynYCBhaUu9poEaDvCEIlAWAkwCsbcj6jzFHVobHUU2qrxl1WT8us
	 RVJYBWQngImyeCgveJ43FpkJgfqtzfnVuZXjRcjZfmoruhENP1rhyLMwCKJOr6Urbh
	 KTJyN/bSs6HiYJZ28Td0PtxDiIF3QKqSHgvf3t6vKbPd4PxiRQ0sCrqQH+1bgi0YIk
	 vxPT5td0svN7+15MJVhI94gDS0k8HguyPqhVWi6ug3J1cSr3IKzPS9gBQ96dp3/ckk
	 RpbjeHoqCExnQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/5] selftests: mptcp: extract mptcp_lib_check_expected
Date: Thu,  7 Mar 2024 20:48:40 +0800
Message-Id: <b1d6b400a21b15b9237e6cdd35d325f9fd5584d9.1709815545.git.tanggeliang@kylinos.cn>
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

Extract the main part of check_expected() in userspace_pm.sh to a new
function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
in both mptcp_john.sh and userspace_pm.sh. check_expected_one() is
moved into mptcp_lib.sh too as mptcp_lib_check_expected_one().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 30 ++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 34 +++----------------
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ea39392c68e7..44491f18ed17 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -438,3 +438,33 @@ mptcp_lib_print_title() {
 	# shellcheck disable=SC2059 # the format is in a variable
 	printf "${MPTCP_LIB_TEST_FORMAT}" "$((++MPTCP_LIB_TEST_COUNTER))" "${*}"
 }
+
+# $1: var name ; $2: prev ret
+mptcp_lib_check_expected_one() {
+	local var="${1}"
+	local exp="e_${var}"
+	local prev_ret="${2}"
+
+	if [ "${!var}" = "${!exp}" ]; then
+		return 0
+	fi
+
+	if [ "${prev_ret}" = "0" ]; then
+		mptcp_lib_pr_fail
+	fi
+
+	mptcp_lib_print_err "Expected value for '${var}': '${!exp}', got '${!var}'."
+	return 1
+}
+
+# $@: all var names to check
+mptcp_lib_check_expected() {
+	local rc=0
+	local var
+
+	for var in "${@}"; do
+		mptcp_lib_check_expected_one "${var}" "${rc}" || rc=1
+	done
+
+	return "${rc}"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 4e29aa9c2529..6ab9efda8627 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -5,7 +5,7 @@
 # code but we accept it.
 #shellcheck disable=SC2086
 
-# Some variables are used below but indirectly, see check_expected_one()
+# Some variables are used below but indirectly, see verify_*_event()
 #shellcheck disable=SC2034
 
 . "$(dirname "${0}")/mptcp_lib.sh"
@@ -225,44 +225,20 @@ make_connection()
 	fi
 }
 
-# $1: var name ; $2: prev ret
-check_expected_one()
-{
-	local var="${1}"
-	local exp="e_${var}"
-	local prev_ret="${2}"
-
-	if [ "${!var}" = "${!exp}" ]
-	then
-		return 0
-	fi
-
-	if [ "${prev_ret}" = "0" ]
-	then
-		test_fail
-	fi
-
-	mptcp_lib_print_err "\tExpected value for '${var}': '${!exp}', got '${!var}'."
-	return 1
-}
-
 # $@: all var names to check
 check_expected()
 {
 	local rc=0
-	local var
 
-	for var in "${@}"
-	do
-		check_expected_one "${var}" "${rc}" || rc=1
-	done
-
-	if [ ${rc} -eq 0 ]
+	mptcp_lib_check_expected "${@}" || rc=1
+	if [ "${rc}" -eq 0 ]
 	then
 		test_pass
 		return 0
 	fi
 
+	ret=1
+	mptcp_lib_result_fail "${test_name}"
 	return 1
 }
 
-- 
2.40.1

