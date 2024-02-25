Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4FADDDA
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866262; cv=none; b=t3putAZJX/s7BvEeDLM7OiEXuU4bQ1WPKKDtzvd1GOQo92e3EG33XUb5sd1xRePBvTJZtLV3MhWUz7ZlSEQybpPmGNtHckUxPTQRCrA4mq6Fu+TTm40miHYHlJmxE+8V2hzZAr3v7qHyfYRZdEtbZAWUeidzT98jtplik1QKMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866262; c=relaxed/simple;
	bh=cG7LtClUGrTY7Xbzxsz9KBip+L2lbEGjEmbXiGPrnC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpy4x2czEXl/9BIWg9+UM96bnxwUZR66xlHOO1IEx8eYRhr5X2Guekj3ekLGagk6mqEFPQABe6LbPkloDDYiEW9rkiPEwYhfO74sORqnvCRq1bHwKNXnnihqBLM4UTJef43b2O0/HY4SCGNzviEMz1zQ/Mg9ZdWG8sN2FCVNslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNr21TZ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNr21TZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A897AC433C7;
	Sun, 25 Feb 2024 13:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708866262;
	bh=cG7LtClUGrTY7Xbzxsz9KBip+L2lbEGjEmbXiGPrnC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNr21TZ3tekfLTzV9cL1wvKdGbAlNGk+6G4+eCDMumxZ/Czbn9Re6TTZ9uGkTNaHb
	 zsoO505tFlcZszOWb+P5/doZE7LjhG7JnLStLnpoIkd6Vqu3vTP6NlJASx2cdwp2to
	 K1H3FyglLWl9xsoe19m/WJRXOJZ/TqqKEPo7zOlnoHKy6EsAEGy2lRK2IUbOB50GQr
	 IEW0oHWXzH8S2ceM/0+4aQjDt5DV2ZJpef2je3rAfhGiMR7dFVPFI1Ey/flhRNvE/Z
	 qt2/LU+rLSIcVKzVtg/GvU4OT9kDECezRzczlHbnO4icCqAbJWmsAHvQRrjN7H+lp8
	 klh3rvDHI2VJg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 10/13] selftests: mptcp: extract mptcp_lib_check_expected
Date: Sun, 25 Feb 2024 21:03:58 +0800
Message-Id: <d555f375345ded8d39ce48077f46073529654dd2.1708866087.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708866087.git.tanggeliang@kylinos.cn>
References: <cover.1708866087.git.tanggeliang@kylinos.cn>
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
in both mptcp_john.sh and userspace_pm.sh.

check_expected_one() is moved into mptcp_lib.sh too as a sub function
of mptcp_lib_check_expected().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 48 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 39 ++-------------
 2 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 630fecb942e4..5dfdb054371d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -1,6 +1,9 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Some variables are used below but indirectly, see check_expected_one()
+#shellcheck disable=SC2034
+
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
@@ -420,3 +423,48 @@ mptcp_lib_print_test_counter() {
 
 	printf "%0${digit}u ${fmt}" "$((counter++))" "${msg}"
 }
+
+# $@: all var names to check
+mptcp_lib_check_expected() {
+	# $1: var name ; $2: prev ret
+	check_expected_one() {
+		local var="${1}"
+		local exp="e_${var}"
+		local prev_ret="${2}"
+
+		if [ "${!var}" = "${!exp}" ]
+		then
+			return 0
+		fi
+
+		if [ "${prev_ret}" = "0" ]
+		then
+			return 2
+		fi
+
+		printf "\tExpected value for '%s': '%s', got '%s'.\n" \
+			"${var}" "${!exp}" "${!var}"
+		return 1
+	}
+
+	local rc=0
+	local var
+
+	for var in "${@}"
+	do
+		check_expected_one "${var}" "${rc}" || rc="${?}"
+		if [ "${rc}" -eq 2 ]
+		then
+			break
+		fi
+	done
+	unset -f check_expected_one
+
+	if [ ${rc} -eq 0 ]
+	then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	fi
+
+	return "${rc}"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index ced72741ed56..702484199dd2 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -5,7 +5,7 @@
 # code but we accept it.
 #shellcheck disable=SC2086
 
-# Some variables are used below but indirectly, see check_expected_one()
+# Some variables are used below but indirectly
 #shellcheck disable=SC2034
 
 . "$(dirname "${0}")/mptcp_lib.sh"
@@ -233,46 +233,15 @@ make_connection()
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
-		return 2
-	fi
-
-	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
-		"${var}" "${!exp}" "${!var}"
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
-		check_expected_one "${var}" "${rc}" || rc="${?}"
-		if [ "${rc}" -eq 2 ]
-		then
-			break
-		fi
-	done
-
-	if [ ${rc} -eq 0 ]
+	mptcp_lib_check_expected "${@}" || rc="${?}"
+	if [ "${rc}" -eq 0 ]
 	then
-		test_pass
+		mptcp_lib_result_pass "${test_name}"
 		return 0
 	elif [ "${rc}" -eq 2 ]
 	then
-- 
2.40.1

