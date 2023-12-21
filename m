Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0AA6BB32
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/GJ4T4H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703158399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPd0q3rxOC8YgtXGIPKvHHWALS4lVoJT9XUWguPUnN8=;
	b=O/GJ4T4HK/dWsE3OVHcwLKTjDNTnBLw+j/qMdGsBzlUcmNcQEIfuLskppjUbM5cIXZwbOE
	If08n8S+kR5n2X2XsjDbSGtOcv8yMcenatQ23bHDkYpcBa87XbVocLeGKF44fpMszhcamg
	mPRqv/Uc9tAGA/thejAmq/FNJ3EgTt0=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 02/15] selftests: mptcp: userspace: capitalize test_name
Date: Thu, 21 Dec 2023 19:31:05 +0800
Message-Id: <d3ecfe9ca1e50f459c2d4965b6f3b9f20fb4a6ef.1703158128.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703158128.git.geliang.tang@linux.dev>
References: <cover.1703158128.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Most scripts use uppercase variable TEST_NAME, but lowercase one are
used in userspace_pm.sh. To maintain consistency with other scripts,
this patch renames variable test_name to TEST_NAME:

    test_name -> TEST_NAME   in userspace_pm.sh

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f1dbd97c0c96..b0a7c69f5da0 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -55,7 +55,7 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
-test_name=""
+TEST_NAME=""
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -69,9 +69,9 @@ print_title()
 # $1: test name
 print_test()
 {
-	test_name="${1}"
+	TEST_NAME="${1}"
 
-	_printf "%-63s" "${test_name}"
+	_printf "%-63s" "${TEST_NAME}"
 }
 
 print_results()
@@ -82,13 +82,13 @@ print_results()
 test_pass()
 {
 	print_results " OK "
-	mptcp_lib_result_pass "${test_name}"
+	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
 	print_results "SKIP"
-	mptcp_lib_result_skip "${test_name}"
+	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
@@ -101,7 +101,7 @@ test_fail()
 		_printf "\t%s\n" "${1}"
 	fi
 
-	mptcp_lib_result_fail "${test_name}"
+	mptcp_lib_result_fail "${TEST_NAME}"
 }
 
 # This function is used in the cleanup trap
-- 
2.35.3

