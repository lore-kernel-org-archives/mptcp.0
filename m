Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F3D15E89
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Byn0DPAQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uh1sdNzB8uUsiBgFVI34ay42V88kJbcHIF4iFnXIz6c=;
	b=Byn0DPAQCRu13+DBD2UQjIOejDfCWOEIC256kKgSOkGvG7+RHyEQQ/q6gHqU4GPf2AhCfN
	Zd3qiBI2f317KhfiBdvACZssdt2kAXrXRSNPFFKK4oJsKMYRv4rfmKDP7ovTuOGoziAjij
	GpQ3Wa/mpS0YHn/ukLVpzxP7fIrKcHA=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 20/33] selftests: mptcp: diag: print out test counter
Date: Tue,  5 Dec 2023 15:01:07 +0800
Message-Id: <0f13394f3c3d057d2a3bdede5c9dc91e633c5a2d.1701759405.git.geliang.tang@linux.dev>
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

This patch prints out TEST_COUNT for every tests in script diag.sh.

The output looks like:

 01 no msk on netns creation                          [  OK  ]
 02 listen match for dport 10000                      [  OK  ]
 03 listen match for sport 10000                      [  OK  ]
 04 listen match for saddr and sport                  [  OK  ]
 05 all listen sockets                                [  OK  ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/diag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 47a37d379c9a..d1ea35e590f3 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-TEST_COUNT=1
+TEST_COUNT=0
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
 
@@ -48,7 +48,7 @@ __chk_nr()
 
 	nr=$(eval $command)
 
-	printf "%-50s" "$msg"
+	printf "%02u %-50s" "$((TEST_COUNT+1))" "$msg"
 	if [ $nr != $expected ]; then
 		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			mptcp_lib_print_warn "[ SKIP ] Feature probably not supported"
@@ -98,7 +98,7 @@ wait_msk_nr()
 		sleep 1
 	done
 
-	printf "%-50s" "$msg"
+	printf "%02u %-50s" "$((TEST_COUNT+1))" "$msg"
 	if [ $i -ge $timeout ]; then
 		mptcp_lib_print_err "[ FAIL ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-- 
2.35.3

