Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18B3DDC4
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708852415; cv=none; b=Z4nNSi/nHp2WM2gvBss2afWDlqeqi46Q2M4R6tXzLCPfJN7xpd8BA3xE1fKF3oVZg0GFmGI0kx9nR3ekObcmlMaqsP9BXfBImC7WvCb7YseLGhI88KAishYsMXurNzt7wjAkeEQ09XYfHBgctNXYJZwap+TFRkaDT2Zxy5YqmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708852415; c=relaxed/simple;
	bh=N8TPZDwXKgyRGEXUU4MyA/p8sDOG1KGq7dsvY3bB8mM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgIJczmni3/7hINmgA9yG4DYREaW/wSQ0X7MRDp1HDNANwEwJTldkGpa4W95ii8hYcSU6xJaqVjcaBa0JAF/GwZy0UcRnMAR2JfjTnBTFxdTy0/UqpV4/8aOFnw/eZrpx07ExqZA1Xw9HbpnKmYi0brVAHclA6x9fviX97lV8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brL5DDQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brL5DDQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC135C433F1;
	Sun, 25 Feb 2024 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708852414;
	bh=N8TPZDwXKgyRGEXUU4MyA/p8sDOG1KGq7dsvY3bB8mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brL5DDQsRevDzBOHkJ6lzRYx7YtyIWRga6YDiHFdHGy2y+Zrvrto5vYUIevsxV7hA
	 zpVDJBuxsDUzEaiEldKMIIlt+tI9Io14FbLB097vEBquTonETtf6Ijkv6YClHFVqrc
	 kNHlsJO3T+PvpE00shqz0FuGKEpBtjzsc4cJh0oh4PBSnO7I2Jg46/O6C3iIaqneqH
	 p6MvzmC2bwUHAS6f35dU+R7U5awgW1z7ks58XRCHlwMXqnYH9DtDSjStxEd2Mc5jUk
	 hWnlbr1Xm+bh0tcR6gi2xzAf9z/2IwtGLCo2srXNHoe6Y2qAZJyFq0hG4E3vIojVW3
	 rWheNfqi6AfmQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 10/13] selftests: mptcp: extract mptcp_lib_check_expected
Date: Sun, 25 Feb 2024 17:12:31 +0800
Message-Id: <adad49735f7c060082494a1200ea4e5907674218.1708852208.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708852208.git.tanggeliang@kylinos.cn>
References: <cover.1708852208.git.tanggeliang@kylinos.cn>
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
index 630fecb942e4..7d1b851d01ca 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,9 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
+# Some variables are used below but indirectly, see check_expected_one()
+#shellcheck disable=SC2034
+
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 
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

