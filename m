Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C428E2B
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709877468; cv=none; b=h9WFft5i2Bw9q1OHFCIgdRTWk4SLRbW3C5PEyIfdkItBMgTssW/Jiekp12yvmJNQmUngrthFdBsxXv4cLCpjphepA2vkGOK3FEG3b8/2CY9bXycmE/hgS1g+mhikCZtBFyXIo188WzeHNg3mfQr08BhrXRQJqA9ztJUeGanCRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709877468; c=relaxed/simple;
	bh=g3cCTfrQ484c1X1ZXJ9ZCqnUD8fekNETgnDcvgb3ETE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwPAaaAsu9r2/s4Eagdede7TEa7dx6sfAHqMWPexUVrX+0bp8TE1BPieQ1rhDvPP0+FwjcWAjexE1i1YLTD7+XbdkmUYdL9jaOO1OfLXUYORswDYGGwGyq9ZBBK9mE08oXutU2rZIssNmTR6To+DqScHLdusWwc4CqmQyKSEXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQRC0hH7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQRC0hH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFFDC433C7;
	Fri,  8 Mar 2024 05:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709877467;
	bh=g3cCTfrQ484c1X1ZXJ9ZCqnUD8fekNETgnDcvgb3ETE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQRC0hH7rr3p+3NhyfqW6TVZjoxL5Ll6mMUNi5CMXxHiDZIxp8si0dYESiABiL2RX
	 OXDILAVUdJxftiFhiE82QpxjerSM50NIXmbcv810hywvnz5IWRNL+FwwVooPHMI7Hy
	 66FEMNDu2vPvbVDbonEfrzKmfEDD3T5feXLJXCrG39dnP70arYfPgV6MnQfpXx4Lfv
	 ukItDJ1fitwc/Vq4y2u9HdalcR29Apy1RHiTvKIYWQe18ow2G8WUri6X4sG/t7ukh8
	 sagUKd1b+nBpQ4RPCr3U+k4X4J+ZP+TFzHxwhWwT8Wjf8Ot7PMPL4c4ODdoQaRVP9s
	 uu5CnWzKAdtBg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/7] selftests: mptcp: extract mptcp_lib_check_expected
Date: Fri,  8 Mar 2024 13:57:35 +0800
Message-Id: <32ad4d66ad8049f668373985bdf6019c03cf35e2.1709876991.git.tanggeliang@kylinos.cn>
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

Extract the main part of check_expected() in userspace_pm.sh to a new
function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
in both mptcp_john.sh and userspace_pm.sh. check_expected_one() is
moved into mptcp_lib.sh too as mptcp_lib_check_expected_one().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 30 +++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 33 ++-----------------
 2 files changed, 32 insertions(+), 31 deletions(-)

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
index bc2f0184b1eb..6d0862a1b68d 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -5,7 +5,7 @@
 # code but we accept it.
 #shellcheck disable=SC2086
 
-# Some variables are used below but indirectly, see check_expected_one()
+# Some variables are used below but indirectly, see verify_*_event()
 #shellcheck disable=SC2034
 
 . "$(dirname "${0}")/mptcp_lib.sh"
@@ -228,39 +228,10 @@ make_connection()
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
-		mptcp_lib_pr_fail
-	fi
-
-	mptcp_lib_print_err "\tExpected value for '${var}': '${!exp}', got '${!var}'."
-	return 1
-}
-
 # $@: all var names to check
 check_expected()
 {
-	local rc=0
-	local var
-
-	for var in "${@}"
-	do
-		check_expected_one "${var}" "${rc}" || rc=1
-	done
-
-	if [ ${rc} -eq 0 ]
+	if mptcp_lib_check_expected "${@}"
 	then
 		test_pass
 		return 0
-- 
2.40.1

