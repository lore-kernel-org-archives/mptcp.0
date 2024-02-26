Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742C1C696
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935502; cv=none; b=hG/z6lHP4Vvt/0qmLkikGlYsioeZvihVu4jRVV4m6EChtlYTRFBSJQVQUTz469ul4yHpNQ6FmKqYBkc0eelga0/KBre5xEzF7UKnk92i8FBVBJh8XQJFiF0Txgwj/dOgKwOrCRfQJ7YT8YvxIIfW+sVb0OctkEdLAR2s5CafB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935502; c=relaxed/simple;
	bh=CwguBhWAPp5I4T0KHxFeeBi/8OMB42NkicDGnQTehrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s9iCK8lyRWAQQ8NfyxuZf+srhJLP+Mj+CWp7OSQOeUhFw+26vYsYAZkmb2DrroJeK9ZUqFY0nK+hsNPBNv6vHN5o0scj5Q0FaPXIAdlAiQKw+u1KsBds3FEM7qLdcZrMtxrkwXZmWf9qo6l+08Bpx0Uaqt27NTkbM3orfuLO43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAQnSE9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAQnSE9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3B1C43394;
	Mon, 26 Feb 2024 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708935502;
	bh=CwguBhWAPp5I4T0KHxFeeBi/8OMB42NkicDGnQTehrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAQnSE9d+8kHOSTauKTQAATtCidbyPpLGzxrXz68mi1xeR+6150EB9Coe8CBSUvGU
	 LyW/Nf6ObkSMROXHVJTgfgkjt3UftLYq1rDHOwwIo59SOnOzNbSuj+qknnfcsLHPxA
	 4vZzsUIcjCzTZdVGERtF9HxyUhX3e4jc+iMNa94vgDj93AAPUAp9A9Hl4b1ZRZjdNJ
	 zmT1i/B0qzuapWufQeEpwpDHNKfRBx84Q3Hy1VgVEThdpz3sOwDEKQXts6zM+rSiX6
	 eYbFCaP/gQJb+0Bgum6YSXmjaD2FgXSVw0PwBW4jvS61a4o5BTOUUD3nzP1x5O/Nft
	 9UivZDLaWb6Jg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 10/13] selftests: mptcp: extract mptcp_lib_check_expected
Date: Mon, 26 Feb 2024 16:17:55 +0800
Message-Id: <f553a0a8da70cb1031ae0d7d3f4ee2a232e0a576.1708935196.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708935196.git.tanggeliang@kylinos.cn>
References: <cover.1708935196.git.tanggeliang@kylinos.cn>
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
index 482e88f5b7bf..141ade36c373 100644
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
 
 	printf "%0${digit}u ${fmt}" "$((++counter))" "${msg}"
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
index 473639a8009f..3f475ae44d0b 100755
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

