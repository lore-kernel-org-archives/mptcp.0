Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C68E12B76
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IXez5LrJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMbThuJkcXWh6LypkzH5CCnUy/y6MvPDOPLrmnTztCY=;
	b=IXez5LrJ75Kg9or9vHbNV6XBJngMwfi4zcSjXX3L2WMitWCeQ4rjLU7INSxQiexfRmbCEf
	EaWumIboYqFqD0PG1KDYZS8MjCl/knbOLDLZzms0fix6o2ttuOQ9cgXlPuNd1on7j5D0+T
	uPE+A2OciT5lrHLLO4qjJjTdbRFSCHI=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 27/33] selftests: mptcp: export cin/cout/sin/sout vars
Date: Tue,  5 Dec 2023 15:01:14 +0800
Message-Id: <5b9a2d7ab5274184c27881a0803df2e8a6296e84.1701759405.git.geliang.tang@linux.dev>
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

Export cin, cout, sin and sout vars into mptcp_lib.sh as public vars.
Then they can be used in all test scripts unified.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 ----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 12 ++----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 10 ++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 10 ----------
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  5 -----
 5 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b0a8edace8f8..aeedd822490c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -7,11 +7,7 @@ time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
 final_ret=0
-sin=""
-sout=""
 cin_disconnect=""
-cin=""
-cout=""
 ksft_skip=4
 capture=false
 timeout_poll=30
@@ -128,8 +124,6 @@ TEST_GROUP=""
 cleanup()
 {
 	rm -f "$cin_disconnect" "$cout_disconnect"
-	rm -f "$cin" "$cout"
-	rm -f "$sin" "$sout"
 	rm -f "$capout"
 
 	mptcp_lib_ns_exit
@@ -138,10 +132,6 @@ cleanup()
 
 mptcp_lib_check_tools "ip" "ss"
 
-sin=$(mktemp)
-sout=$(mktemp)
-cin=$(mktemp)
-cout=$(mktemp)
 capout=$(mktemp)
 cin_disconnect="$cin".disconnect
 cout_disconnect="$cout".disconnect
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 57b6fb008997..a2f595d70a92 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,14 +12,10 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sin=""
 sinfail=""
-sout=""
-cin=""
 cinfail=""
 cinsent=""
 tmpfile=""
-cout=""
 capout=""
 ksft_skip=4
 timeout_poll=30
@@ -132,11 +128,7 @@ init() {
 
 	mptcp_lib_check_tools "ip" "ss" "iptables"
 
-	sin=$(mktemp)
-	sout=$(mktemp)
-	cin=$(mktemp)
 	cinsent=$(mktemp)
-	cout=$(mktemp)
 	mptcp_lib_evts_init
 
 	trap cleanup EXIT
@@ -147,8 +139,8 @@ init() {
 
 cleanup()
 {
-	rm -f "$cin" "$cout" "$sinfail"
-	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
+	rm -f "$sinfail"
+	rm -f "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
 	mptcp_lib_evts_remove
 	cleanup_partial
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index a6880e1d0593..56aaa5350cb2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -25,6 +25,11 @@ TEST_NAME=""
 
 MPTCP_LIB_SUBTESTS=()
 
+sin=$(mktemp)
+sout=$(mktemp)
+cin=$(mktemp)
+cout=$(mktemp)
+
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
    [ "${NO_COLOR:-}" != "1" ]; then
@@ -559,9 +564,14 @@ mptcp_lib_check_tools() {
 
 mptcp_lib_cleanup() {
 	: "${check_output_err:?}"
+	: "${sin:?}"
+	: "${sout:?}"
+	: "${cin:?}"
+	: "${cout:?}"
 
 	echo "cleanup"
 	rm -f $check_output_err
+	rm -f "$sin" "$sout" "$cin" "$cout"
 }
 
 echo -e "\n${KSFT_TEST}\n"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index de051a49745b..ec829165d562 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -3,10 +3,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sin=""
-sout=""
-cin=""
-cout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
@@ -69,8 +65,6 @@ init()
 cleanup()
 {
 	mptcp_lib_ns_exit
-	rm -f "$cin" "$cout"
-	rm -f "$sin" "$sout"
 	mptcp_lib_cleanup
 }
 
@@ -311,10 +305,6 @@ do_tcpinq_tests()
 	return $?
 }
 
-sin=$(mktemp)
-sout=$(mktemp)
-cin=$(mktemp)
-cout=$(mktemp)
 init
 make_file "$cin" "client" 1
 make_file "$sin" "server" 1
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index b82c083c934e..03e88b6c47d0 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -12,8 +12,6 @@ bail=0
 slack=50
 large=""
 small=""
-sout=""
-cout=""
 capout=""
 size=0
 
@@ -26,7 +24,6 @@ usage() {
 
 cleanup()
 {
-	rm -f "$cout" "$sout"
 	rm -f "$large" "$small"
 	rm -f "$capout"
 
@@ -46,8 +43,6 @@ setup()
 {
 	large=$(mktemp)
 	small=$(mktemp)
-	sout=$(mktemp)
-	cout=$(mktemp)
 	capout=$(mktemp)
 	size=$((2 * 2048 * 4096))
 
-- 
2.35.3

