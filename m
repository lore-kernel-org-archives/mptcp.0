Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA157BE7D
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657705; cv=none; b=ewRn63NeYAnH6GJBb7WnMl8I3jle0cuWJppY9WP5nYwApiLXy0D7VkIvLPuindVgaqkHIncA+o6oHnCoMPVqe1GjLV6DjrLpHFO0b49BliIcoJQSqTIlvsZX6vwk6v5XHAmPNOg4AGVKE1RJVh4dVOmaZBnyXBQK38XfpIcpHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657705; c=relaxed/simple;
	bh=zWeKNILmuSVkGegVv5z1WGwxcfnQWepXGL7vA/8PNnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1cwmT//8XwkqkzMhV9wGU4yRE2wbiJNUnw1iAv+WqvgSOzJ3XuafvWnQzvwYy0snU/bZV9dj3xf8Zgvu4V11oygXlWeqg/t4GOv1QJW7OzfmugskftuPLhqURxuv05Ks/802Kz4QZHKCxFGBvlb/jZp2DBK6dFTRNIHmwtlfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZlfSsU2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZlfSsU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC46C43390;
	Fri, 23 Feb 2024 03:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657704;
	bh=zWeKNILmuSVkGegVv5z1WGwxcfnQWepXGL7vA/8PNnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZlfSsU2cJE3UCd9VxPW36fV0HyUQTHZoNYmmhIRQs0tMmpOENviqrsnvnLDK6hww
	 jbenMKXQ78jVRwhkDaduKt1TD2A5A8bcC93BY7vJ7KUxxV71GnvHp0dT0f5aSD9puU
	 V+nTAC+0/hIk3UZiETo7Lx7DGszbLgUiBdPrup30ot9Zv8OJJ3MAXY1jt/3utznF+f
	 eUUv+sV3Ob4WXkWpITiYwpEMum0s91SWOjwmB5c1sLk+Hs/9wbYmAojwJD4XCbMeju
	 /TWhq5ywLjSlSJ1nZ0AesaFV67v1rJUcVyPTrCjwRNPXUQxTT4JztfHQw7aHRMc9js
	 hdSlcl0Quhc1Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/8] selftests: mptcp: extract mptcp_lib_check_expected
Date: Fri, 23 Feb 2024 11:08:09 +0800
Message-Id: <6a74882ff635138b578d43cd0008920320c7e342.1708657487.git.tanggeliang@kylinos.cn>
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

Extract the main part of check_expected() in userspace_pm.sh to a new
function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
in both mptcp_john.sh and userspace_pm.sh.

check_expected_one() is moved into mptcp_lib.sh too as a sub function
of mptcp_lib_check_expected().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 45 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 37 ++-------------
 2 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 9e1486a618a6..abb786fa05c0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -413,3 +413,48 @@ mptcp_lib_events() {
 	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
 	pid=$!
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
index 5ffa1157467c..2fd9c7eabe79 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -232,46 +232,15 @@ make_connection()
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
+		mptcp_lib_result_pass "${TEST_NAME}"
 		return 0
 	elif [ "${rc}" -eq 2 ]
 	then
-- 
2.40.1

