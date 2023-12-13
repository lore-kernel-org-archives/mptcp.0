Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8DECA59
	for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xpVUFG3q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702447051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5aMKIp+uwEBCZF3v+smv/pJGzeCPZUM618HVj4CFZXM=;
	b=xpVUFG3qUV7IStxIzfBfFk0q7Ktr4aqqG7GcoFiXkp6Iwa3+QiNaNr9Vp1sRWx/xxxqCSF
	S1H7Y6nFXy2svWwxOdONiWrGd/arDRHmC+UWckd5Xo7sDo86JWvTw1kbkQS+j2g1bl9ZuL
	tJZ7oXhD8g7vsJ771yJbfLUdVfQXzCw=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 3/3] selftests: mptcp: check CURRESTAB counters
Date: Wed, 13 Dec 2023 13:56:39 +0800
Message-Id: <6b76a198cc11f69bf8c4621f1c8a5cd0c9d1a6ff.1702446832.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702446832.git.geliang.tang@linux.dev>
References: <cover.1702446832.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds a new helper chk_cestab_nr() to check the current
established connections counter MIB_CURRESTAB. Set the newly added
variables cestab_ns1 and cestab_ns2 to indicate how many connections
are expected in ns1 or ns2.

Invoke check_cestab() to check the counter during the connection in
do_transfer() and invoke chk_cestab_nr() to re-check it when the
connectin closed. These checks are embedded in add_tests().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 87590a43b50d..3cd066e6e2b0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -56,6 +56,8 @@ unset FAILING_LINKS
 unset test_linkfail
 unset addr_nr_ns1
 unset addr_nr_ns2
+unset cestab_ns1
+unset cestab_ns2
 unset sflags
 unset fastclose
 unset fullmesh
@@ -976,6 +978,33 @@ pm_nl_set_endpoint()
 	fi
 }
 
+chk_cestab_nr()
+{
+	local ns=$1
+	local cestab=$2
+	local count
+
+	print_check "cestab $cestab"
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$cestab" ]; then
+		fail_test "got $count current establish[s] expected $cestab"
+	else
+		print_ok
+	fi
+}
+
+check_cestab()
+{
+	if [ -n "${cestab_ns1}" ]; then
+		chk_cestab_nr $1 1
+	fi
+	if [ -n "${cestab_ns2}" ]; then
+		chk_cestab_nr $2 1
+	fi
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -1089,6 +1118,7 @@ do_transfer()
 	local cpid=$!
 
 	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
+	check_cestab $listener_ns $connector_ns
 
 	wait $cpid
 	local retc=$?
@@ -2477,47 +2507,52 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		addr_nr_ns2=1 speed=slow \
+		addr_nr_ns2=1 speed=slow cestab_ns2=1 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add signal address
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=1 speed=slow \
+		addr_nr_ns1=1 speed=slow cestab_ns1=1 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_cestab_nr $ns1 0
 	fi
 
 	# add multiple subflows
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 speed=slow \
+		addr_nr_ns2=2 speed=slow cestab_ns2=1 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add multiple subflows IPv6
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 speed=slow \
+		addr_nr_ns2=2 speed=slow cestab_ns2=1 \
 			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add multiple addresses IPv6
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		addr_nr_ns1=2 speed=slow \
+		addr_nr_ns1=2 speed=slow cestab_ns1=1 \
 			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
+		chk_cestab_nr $ns1 0
 	fi
 }
 
-- 
2.35.3

