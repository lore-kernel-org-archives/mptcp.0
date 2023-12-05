Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004E15481
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z5FlSQcP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s22ZMHsfzK3pgcJLxroE1V2rC5Ktlt048+vSmvOKulw=;
	b=Z5FlSQcPZyAK6YQ9E5JG01REE3wP+UJTUman3K1p8RzLqvXjhqUrlpqOrwUGZRjCC+aZ8N
	Q8TantOeguCbV0SHHQXUU8cD89EdLhczc3fLqY4ewjn521fOsKJMPOgDY54xbahQ08qhTL
	hXpqocIZrApgFAda+nO/S+kRTicvPuE=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 02/33] selftests: mptcp: userspace: capitalize test_name
Date: Tue,  5 Dec 2023 15:00:49 +0800
Message-Id: <279f67e9ee4f4e1cd1adb46bf78143fb3ba0ddaf.1701759405.git.geliang.tang@linux.dev>
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

Most scripts use uppercase variable TEST_NAME, but lowercase one are
used in userspace_pm.sh. To maintain consistency with other scripts,
this patch renames variable test_name to TEST_NAME:

    test_name -> TEST_NAME   in userspace_pm.sh

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index e78fcd3bff16..c9da970e5d24 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -54,7 +54,7 @@ sec=$(date +%s)
 rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
-test_name=""
+TEST_NAME=""
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -68,9 +68,9 @@ print_title()
 # $1: test name
 print_test()
 {
-	test_name="${1}"
+	TEST_NAME="${1}"
 
-	_printf "%-63s" "${test_name}"
+	_printf "%-63s" "${TEST_NAME}"
 }
 
 print_results()
@@ -81,13 +81,13 @@ print_results()
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
@@ -100,7 +100,7 @@ test_fail()
 		_printf "\t%s\n" "${1}"
 	fi
 
-	mptcp_lib_result_fail "${test_name}"
+	mptcp_lib_result_fail "${TEST_NAME}"
 }
 
 # This function is used in the cleanup trap
-- 
2.35.3

