Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ADADDC4
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708852410; cv=none; b=UArSXEPB9yW2QDNBSOVb4lmH9/vqWr9U94nNYCNrvtXlX/foAn65bAN41xUvdxelVk0P54rCBc8Bl7/yuEexv5CMHmJ9VuG+SfeFREBrMLMD81PebgpUsCRIqvQH3t2ZihKLSSTbPZMzh4a6ZSzMtwlkI5eH/a0xNeBBZsA7Sq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708852410; c=relaxed/simple;
	bh=NtWI8hoNQSNaM0fU3cCbGBOP47t4ETz5d7bgpU8oqjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhfraVLCT7f82esLIG/SjHYtPm3Em854ajYjUxJWkSaL6UKvFXuvuG7W8RKM+zkG2BWzoy85blpqpIVKiD2EYgvcRdgquLgvIbjWlL2K4IwUU/tYYuhNyZsAAsAMHCjkZFyej9tlKh82q6u78F2u7nSAX67YSOipJVa3L8W32MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq30fSGc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq30fSGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9358C43390;
	Sun, 25 Feb 2024 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708852410;
	bh=NtWI8hoNQSNaM0fU3cCbGBOP47t4ETz5d7bgpU8oqjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eq30fSGcsm5Km4Vsijsdh3cSqf8hQc0Ug+4Ildl/QexAOowgysqJN1CGv87vzKe9z
	 sGs0BtjE23PZvNe7Y9RXro0pH7u/HiCi2E+00mrIVTsBGKdSpt5abh/2cWODvq0cly
	 n6ZkIKyAkRaziIPtIVqLG//tMBs11+GgYt4Zr03ctskhkDWUihgRvby9w6fyNcySS6
	 bI/c+oSXudAsixvmY6FFG+23VE96KcAe6011K2INn/rj2f+iViH1sB1P+I5tJ2+woS
	 v5mXAaUJmUJzayrHjw7WLn6G+UvONRRwEBCKJBCO0rBl9/4oUimyi3M1P6kB4GqLKD
	 +XXR3IgeAvoFA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 07/13] selftests: mptcp: add mptcp_lib_print_test_counter
Date: Sun, 25 Feb 2024 17:12:28 +0800
Message-Id: <2a4cf49beb3327717f2dbcba38a693879893fbd6.1708852208.git.tanggeliang@kylinos.cn>
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

This patch adds a new helper mptcp_lib_print_test_counter() to print out
test counter in each test result and increase the counter. The counter
digits of most tests are 2, only mptcp_join.sh is 3.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 9 +++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8e8977031fa0..abd5fb4704d1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -48,7 +48,7 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
+TEST_COUNT=1
 TEST_NAME=""
 nr_blank=6
 
@@ -172,7 +172,7 @@ cleanup()
 
 print_title()
 {
-	printf "%03u %s\n" "${TEST_COUNT}" "${TEST_NAME}"
+	mptcp_lib_print_test_counter TEST_COUNT "%s\n" "${TEST_NAME}" 3
 }
 
 print_check()
@@ -268,8 +268,6 @@ reset()
 
 	TEST_NAME="${1}"
 
-	TEST_COUNT=$((TEST_COUNT+1))
-
 	if skip_test; then
 		last_test_ignored=1
 		return 1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 7e309493eda2..630fecb942e4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -411,3 +411,12 @@ mptcp_lib_events() {
 	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
 	pid=$!
 }
+
+mptcp_lib_print_test_counter() {
+	declare -n counter="${1}"
+	local fmt="${2}"
+	local msg="${3}"
+	local digit="${4-2}"
+
+	printf "%0${digit}u ${fmt}" "$((counter++))" "${msg}"
+}
-- 
2.40.1

