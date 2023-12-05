Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58DC14F6F
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e8ye2Z5H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctKgn71fSeckXK8wedBJ47KW77SRr2GTkJF9XFlyBBQ=;
	b=e8ye2Z5HyP1MAu/sufCz5mzn9DbjtmdF0kdRYqTImlf6U8we+88YR93BsrM2rWDGPvxYR0
	CAJEE3zus7nXS327rF8AtydEyCVtL6muhNkRO2b7c+33Dx4ajxPy9dRNH/RK9fKUdSm8GI
	TiN994vfa3UrCrNFuO8Ohe91xLtSGc8=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 25/33] selftests: mptcp: export TEST_NAME/COUNT to mptcp_lib
Date: Tue,  5 Dec 2023 15:01:12 +0800
Message-Id: <b7e5d733963422cf8bbcf65c4b5eff82a9a7525b.1701759405.git.geliang.tang@linux.dev>
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

Move the variables 'TEST_NAME' and 'TEST_COUNT' into mptcp_lib.sh as
public variables.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 -
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 --
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 3 +++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 -
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 --
 6 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index d1ea35e590f3..4b0cc5c41188 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,6 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-TEST_COUNT=0
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 011980ec6b6f..b0a8edace8f8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -123,7 +123,6 @@ done
 
 mptcp_lib_ns_init
 
-TEST_COUNT=0
 TEST_GROUP=""
 
 cleanup()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b5d149008d21..57b6fb008997 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -38,8 +38,6 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
-TEST_NAME=""
 nr_blank=6
 
 # These var are used only in some tests, make sure they are not already set
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 491730cf24dc..a6880e1d0593 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -20,6 +20,9 @@ MPTCP_LIB_LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 readonly AF_INET=2
 readonly AF_INET6=10
 
+TEST_COUNT=0
+TEST_NAME=""
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 8fa40bc0b37c..ef61cec3bf37 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -8,7 +8,6 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-TEST_COUNT=0
 bail=0
 slack=50
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 66dbeaba1575..ec3a68233577 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -35,8 +35,6 @@ client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
 mptcp_lib_ns_init
-TEST_COUNT=0
-TEST_NAME=""
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
-- 
2.35.3

