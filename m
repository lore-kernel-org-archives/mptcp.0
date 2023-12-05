Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB7812E4C
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qkIqyoQ/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701758118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h9JRxj2Ha4DJ5RZI+Fo++WljsB/DIonMjNNhjdLVzGc=;
	b=qkIqyoQ/ZnHOhVPZ7nVbvTAJgG9h7+FzQL7M/NJ43ie64Fq+JGCb1SQvApSrgCZLGZsamN
	AbVhgux9M+dRQvxw5uAx1R5vbRxnKw/gGjSLmsN0/7F8IwMYcKUH72gJjM3diFKA11wubU
	CmGnUfh06CsJNbduAeXqcEuuDJeNKiU=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: join: check CURRESTAB counters"
Date: Tue,  5 Dec 2023 14:35:28 +0800
Message-Id: <586cfcf80d9222a33d1477049225e67c907c127b.1701757488.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Squash to:

[mptcp-next,v3,5/5] selftests: mptcp: join: check CURRESTAB counters

Add cestab_ns1/2, instead of reusing addr_nr_ns1/2.

Please update the commit log:

'''
This patch adds a new helper chk_cestab_nr() to check the current
established connections counter MIB_CURRESTAB. Set the newly added
variables cestab_ns1 and cestab_ns2 to indicate how many connections
are expected in ns1 or ns2.

Invoke check_cestab() to check the counter during the connection in
do_transfer() and invoke chk_cestab_nr() to re-check it when the
connectin closed. These checks are embedded in add_tests().
'''

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 ++++++++++---------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 36d855a37933..3cd066e6e2b0 100755
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
@@ -982,7 +984,7 @@ chk_cestab_nr()
 	local cestab=$2
 	local count
 
-	print_check "cestab"
+	print_check "cestab $cestab"
 	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
 	if [ -z "$count" ]; then
 		print_skip
@@ -993,6 +995,16 @@ chk_cestab_nr()
 	fi
 }
 
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
@@ -1007,9 +1019,6 @@ do_transfer()
 	local fastclose=${fastclose:-""}
 	local speed=${speed:-"fast"}
 
-	local addr_nr_ns1=${addr_nr_ns1:-0}
-	local addr_nr_ns2=${addr_nr_ns2:-0}
-
 	:> "$cout"
 	:> "$sout"
 	:> "$capout"
@@ -1109,13 +1118,7 @@ do_transfer()
 	local cpid=$!
 
 	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
-
-	if [ $addr_nr_ns1 != "0" ]; then
-		chk_cestab_nr $ns1 1
-	fi
-	if [ $addr_nr_ns2 != "0" ]; then
-		chk_cestab_nr $ns2 1
-	fi
+	check_cestab $listener_ns $connector_ns
 
 	wait $cpid
 	local retc=$?
@@ -1127,13 +1130,6 @@ do_transfer()
 	    kill $cappid
 	fi
 
-	if [ $addr_nr_ns1 != "0" ]; then
-		chk_cestab_nr $ns1 0
-	fi
-	if [ $addr_nr_ns2 != "0" ]; then
-		chk_cestab_nr $ns2 0
-	fi
-
 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
 		nstat | grep Tcp > /tmp/${listener_ns}.out
 	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
@@ -2511,47 +2507,52 @@ add_tests()
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

