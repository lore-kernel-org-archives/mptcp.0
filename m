Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8710A1B
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 05:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616142; cv=none; b=DVu1dR2XPJ0+jzeGNLfbD0fr0vZIy+gMeQM9UfE4CblD/rf2DUz3lfe6nRZPa+bb3cGplhx5vRHY/1KXCPea/s4waB+PaV21f8Xei48oSyl37zRISTCkAxB8Au1uGc9Y9weP/Z1jJgeJY6EVNlIuyKidoY8iib0TQqg6REYGnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616142; c=relaxed/simple;
	bh=dnamg94oY8MZcfk3Y9kGU+YOD7C6OaVAAPFMQdpjUOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SsmUvtei6Ux7p6AjSeezU8Ts35m3QMAxoNHDwWAgd+rRlXchc3Q1y1T+QQkN5+W9wpz07j5fWhgS6OzulQWlU1Dxt+tIAHCmvlgoypdZutNYzDiplw92n7gU6xz1HBK5fr/YEBXlM8yM0sfsF114CywPHdOM/0RNtjALnNKBjvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmNCmZ0q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmNCmZ0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD56C43394;
	Tue,  5 Mar 2024 05:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709616141;
	bh=dnamg94oY8MZcfk3Y9kGU+YOD7C6OaVAAPFMQdpjUOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmNCmZ0qiJslRjApKo0nJ5AGqmb9zf5LbW/WvICvjNnApcXcMlHf3F8l9Ky5otNJh
	 cVLtCrKT97njFLm+bGl/kt9VbN3M++YgJS8P+QquPwxePCNDYjIJHr1D7ePTI2/TpO
	 HmEiXd7nP8L5Q0phXqZIDoJBTLRtoGJH54FaTQ9lP+/SGk65CPOijzIf1jtD4q95yq
	 t6ZIksIQec6SHEYJL/CLI8FtKemp7Mb9WVLXBjYQLOfaNscCK8fG0asA1shhGOa0+w
	 nehgGDwD5Y1xQ80y4zVsw7as2SiW79igJ5AuBMyVeIvgfKYZrUSU+XTYp/W5i3zXnS
	 HYdumerVdn4Xg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 6/9] selftests: mptcp: add print_title in mptcp_lib
Date: Tue,  5 Mar 2024 13:22:04 +0800
Message-Id: <a274f09d89ce01382403a7229ffb80157ffe3321.1709615883.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709615883.git.tanggeliang@kylinos.cn>
References: <cover.1709615883.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new variable MPTCP_LIB_TEST_FORMAT as the test title
printing format. Also add a helper mptcp_lib_print_title() to use this
format to print the test title with test counters. They are used in
mptcp_join.sh first.

Each MPTCP selftest is having subtests, and it helps to give them a
number to quickly identify them. This can be managed by mptcp_lib.sh,
reusing what has been done here. The following commit will use these
new helpers in the other tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 ++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 10 +++++++++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4ef0d5ae9dae..2f34e2b9a1c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -48,6 +48,7 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
+MPTCP_LIB_TEST_FORMAT="%03u %s\n"
 TEST_NAME=""
 nr_blank=6
 
@@ -169,11 +170,6 @@ cleanup()
 	cleanup_partial
 }
 
-print_title()
-{
-	printf "%03u %s\n" "${MPTCP_LIB_TEST_COUNTER}" "${TEST_NAME}"
-}
-
 print_check()
 {
 	printf "%-${nr_blank}s%-36s" " " "${*}"
@@ -232,7 +228,7 @@ skip_test()
 
 	local i
 	for i in "${only_tests_ids[@]}"; do
-		if [ "${MPTCP_LIB_TEST_COUNTER}" -eq "${i}" ]; then
+		if [ "$((MPTCP_LIB_TEST_COUNTER+1))" -eq "${i}" ]; then
 			return 1
 		fi
 	done
@@ -267,14 +263,13 @@ reset()
 
 	TEST_NAME="${1}"
 
-	MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
-
 	if skip_test; then
+		MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 		last_test_ignored=1
 		return 1
 	fi
 
-	print_title
+	mptcp_lib_print_title "${TEST_NAME}"
 
 	if [ "${init}" != "1" ]; then
 		init
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 032a555a6b45..459e90258f37 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -10,8 +10,8 @@ readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
-# shellcheck disable=SC2034 # unused at this moment
 MPTCP_LIB_TEST_COUNTER=0
+MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
@@ -413,3 +413,11 @@ mptcp_lib_events() {
 	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
 	pid=$!
 }
+
+mptcp_lib_print_title() {
+	: "${MPTCP_LIB_TEST_COUNTER:?}"
+	: "${MPTCP_LIB_TEST_FORMAT:?}"
+
+	# shellcheck disable=SC2059 # the format is in a variable
+	printf "${MPTCP_LIB_TEST_FORMAT}" "$((++MPTCP_LIB_TEST_COUNTER))" "${*}"
+}
-- 
2.40.1

