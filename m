Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057996087F
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940626; cv=none; b=SAwtaqcyRKx5eyxWphArTr94MBRqykR0++nVy8ROFeHO+jbuLToZ1PHGMnCx746fewTznawL9jpQtfZ+LyY2EmTW7kmfCRrcO7L6mzkSgcCymBLvcFyZv2NATNSaE15oJu1b3J+CzkPtb0L8sZYgLZCjnuznXyHxeIfnDfJSoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940626; c=relaxed/simple;
	bh=oW/EiQDw658JlZCGP9BI96DjBiRUD2qwq/SR9/2n1wY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKSMSEOAoJ2K5Hd25hKhyyBCDYx1JgNdy22OqTinjiFzZCN1vctPBhTVTmBhIjcl7C+7SclKBhkj8FJz6Y7K+1Z4dzJxSvJZWVpvzlIAQcfl4c6DWhxGkWD3ROmH0fg6nK2QGWsNn99ZV2H7lX59bYTIFrxBrBaYrWfjqv8SJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga89eLmz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga89eLmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60400C43390;
	Mon, 26 Feb 2024 09:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708940625;
	bh=oW/EiQDw658JlZCGP9BI96DjBiRUD2qwq/SR9/2n1wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ga89eLmzzVxKO10o/sLH4i+qbAXOoKrtXN2nzHYwc1axr4WRGLYamU8XM3lJTa2pJ
	 W0AGiejo4zWtBRuVcLR8gZNY3R7ze/2eixiyDzIOLduk4HH3mf2k0Krp2TxYhQ+o4B
	 6uOJ2Pe+JQ1mby85tWvGs0JlLtDb61fMXR2nHLJwKp1ztFrQS7vnXeM71k4cVCE1bT
	 zCJRGTtbHbxkcDa6gowdn0bKOqwsbp6CuYhykTcw4la/CBzMx6M+g6YVNiUAUVGPa+
	 pGIzihN11pNvZAYJiQfVDcd4RRXGlOQ4Ty5d6iCkmv3NEVEuflgavdnPw1gfNC+uvs
	 K9yALZi8QNVug==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 09/12] selftests: mptcp: extract mptcp_lib_check_expected
Date: Mon, 26 Feb 2024 17:43:20 +0800
Message-Id: <71d2dc8ad19fd8d87c8e128ed3f02a6c77d1c9d2.1708939962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708939962.git.tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
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
index df495658f043..ed0013b47edb 100644
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
@@ -419,3 +422,48 @@ mptcp_lib_print_test_counter() {
 
 	printf "%02u ${fmt}" "$((++counter))" "${msg}"
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

