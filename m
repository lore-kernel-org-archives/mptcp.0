Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D8E15AE0
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q4VZGqFf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WK0XvAD0vNzn69q3dh3w2zhl0sMIfDr1Ba8sdGChS2k=;
	b=q4VZGqFfv9bC4+PfJvxbJb7O+EVywqS8i/Cpdki9zsiPW5IrWkX0dHkJ9hYHvjbKhPN8hT
	Wpp4kf+SjuMF5Xhz2dHmgKA/eGYeLYCYLdzk9EYh+MOCgpns4rBGrJSLnmHS1Aau8W0GE5
	08azEI6lVj8xGnk4UTppVqKXLjoR1IE=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 05/33] selftests: mptcp: extract mptcp_lib_check_expected
Date: Tue,  5 Dec 2023 15:00:52 +0800
Message-Id: <f6dfa06376ba8999c942af038b0c487e91a9570e.1701759405.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1701759405.git.geliang.tang@linux.dev>
References: <cover.1701759405.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extract the main part of check_expected() in userspace_pm.sh to a new
function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
in both mptcp_john.sh and userspace_pm.sh.

check_expected_one() is moved into mptcp_lib.sh too as a sub function
of mptcp_lib_check_expected().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 43 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 41 +++---------------
 2 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index a41da009962f..8463bcbd9428 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -392,6 +392,49 @@ mptcp_lib_evts_remove() {
 	rm -rf "${server_evts}" "${client_evts}"
 }
 
+# $@: all var names to check
+mptcp_lib_check_expected() {
+	: "${ret:?}"
+
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
+			ret=${KSFT_FAIL}
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
+		check_expected_one "${var}" "${rc}" || rc=1
+	done
+	unset -f check_expected_one
+
+	if [ ${rc} -eq 0 ]
+	then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	fi
+
+	return 1
+}
+
 mptcp_lib_cleanup() {
 	: "${check_output_err:?}"
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 108a7548a1ed..85712f097597 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -237,46 +237,15 @@ make_connection()
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
-	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
-		"${var}" "${!exp}" "${!var}"
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
-	then
-		test_pass
-		return 0
+	mptcp_lib_check_expected ${*}
+	if [ $? -eq 0 ]; then
+		mptcp_lib_result_pass "${TEST_NAME}"
+	else
+		test_fail
 	fi
-
-	return 1
 }
 
 verify_announce_event()
-- 
2.35.3

