Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428B14F6F
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KV9oaU1w"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFtbUfSnlg269Iz4kNIf/xfQceiSvmLCcxrHqg3R1vQ=;
	b=KV9oaU1wJhanU7mpXJCRsOEQV0Lfr25T27U82N1NPke/y+mYaU60Dp7PxL9u9r5RHVen90
	LGWcdLd+HD9KNZ/8B4hFa+27W7Onxbk0BPBS+Kw1QDWgXGtFgbAo8/Ij6vt1IHOWrbKUdR
	MuXcwN3JVkZpJU3l5vcSGwxbAVFUO6M=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 19/33] selftests: mptcp: rename test_cnt to TEST_COUNT
Date: Tue,  5 Dec 2023 15:01:06 +0800
Message-Id: <a01baca7e1eec081da6411ab6c2d68f2c9759572.1701759405.git.geliang.tang@linux.dev>
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

Most scripts use variable TEST_COUNT, but test_cnt are used in diag.sh
and simult_flows.sh. To maintain consistency with other scripts, this
patch renames them as TEST_COUNT:

    test_cnt  -> TEST_COUNT  in diag.sh, simult_flows.sh

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/diag.sh         | 12 ++++++------
 tools/testing/selftests/net/mptcp/simult_flows.sh |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 79f77998d7c4..47a37d379c9a 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-test_cnt=1
+TEST_COUNT=1
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
 
@@ -56,13 +56,13 @@ __chk_nr()
 		else
 			mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
-			ret=$test_cnt
+			ret=$TEST_COUNT
 		fi
 	else
 		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	TEST_COUNT=$((TEST_COUNT+1))
 }
 
 __chk_msk_nr()
@@ -102,16 +102,16 @@ wait_msk_nr()
 	if [ $i -ge $timeout ]; then
 		mptcp_lib_print_err "[ FAIL ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-		ret=$test_cnt
+		ret=$TEST_COUNT
 	elif [ $nr != $expected ]; then
 		mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
-		ret=$test_cnt
+		ret=$TEST_COUNT
 	else
 		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	TEST_COUNT=$((TEST_COUNT+1))
 }
 
 chk_msk_fallback_nr()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index c077e05e1319..b2b31bb49543 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -8,7 +8,7 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-test_cnt=1
+TEST_COUNT=1
 bail=0
 slack=50
 
@@ -109,8 +109,8 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+$test_cnt))
-	test_cnt=$((test_cnt+1))
+	port=$((10000+$TEST_COUNT))
+	TEST_COUNT=$((TEST_COUNT+1))
 
 	:> "$cout"
 	:> "$sout"
-- 
2.35.3

