Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2012B76
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X2t7zMaU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqQMLWqfq0QNjXHf2cJO6LdE2Q7bOPKSgvTN0qcIohQ=;
	b=X2t7zMaUOM6JWWdevFal9I7ejAlcQky0Pzblfn4Bpzl+2b5yagBBL63GQ3eUmTIOg4AR6b
	KMhU74l1mEvq+KqhKZLBxTZ16pwSE+lA0H4xmc3U4UTcAT43br7cbWp/0R1QQvAF1MjBuP
	jYy9khJ+FJhJP6fs2brLcINmV+JMOV8=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 29/33] selftests: mptcp: export capture/checksum vars
Date: Tue,  5 Dec 2023 15:01:16 +0800
Message-Id: <b115a46eb9eba96b07bcba445f0d3eed8a573332.1701759405.git.geliang.tang@linux.dev>
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

The variables 'capture' and 'checksum' are defined in multiple scripts.
So this patch moves them into mptcp_lib.sh as public variables.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 --
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 --
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 3 +++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 -
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index aeedd822490c..a3f864cb0a02 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -9,7 +9,6 @@ optstring="S:R:d:e:l:r:h4cm:f:tC"
 final_ret=0
 cin_disconnect=""
 ksft_skip=4
-capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ipv6=true
@@ -21,7 +20,6 @@ sndbuf=0
 rcvbuf=0
 options_log=true
 do_tcp=0
-checksum=false
 filesize=0
 connect_per_transfer=1
 PORT=0
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d998c4a9cb07..db254496b43a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -20,8 +20,6 @@ capout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-capture=false
-checksum=false
 ip_mptcp=0
 check_invert=0
 validate_checksum=false
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 56aaa5350cb2..8c7f181768b3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -23,6 +23,9 @@ readonly AF_INET6=10
 TEST_COUNT=0
 TEST_NAME=""
 
+capture=false
+checksum=false
+
 MPTCP_LIB_SUBTESTS=()
 
 sin=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 03e88b6c47d0..34981e88e129 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_ns_init
-capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-- 
2.35.3

