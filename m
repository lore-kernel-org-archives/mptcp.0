Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC442BA
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 19:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646422609; x=1677958609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDyvqzTu29FXtv16eiKUM5mBYmDMZmAQzisbhe1QwiE=;
  b=DxAks4vxF4XAVoAc1EE+p+n4Mts/7MZDcdkihKVP1w879WGsmR3kqSho
   OV3XClWJOTFOscp/qk5P8JIp1uyJpPPPGv/ivAo+y54IranZSo1YJottZ
   vHisWKQlWSsPwBS2TImNFwRMUwrVYHMU2jPRm4drkfflUtIRaYu/sOgtS
   HURJtV2lQ7DlWoGqAlBSrkmcLNKgsz2rLIjKgNaXcSCbrSCb4dhpCXv56
   z7XbVL97Nyln/ZgUZlJjtYbT8aO7pMagVLW7pLU/pGglRQvI7TEFOjw0R
   uBOw/+VIPgnzfpA205a+5uNN+LCUDdiEFmQsmEk6i9OFzOBxs76a0Ymfp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278739512"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="278739512"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552340793"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.225.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:43 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 10/11] selftests: mptcp: add more arguments for chk_join_nr
Date: Fri,  4 Mar 2022 11:36:35 -0800
Message-Id: <20220304193636.219315-11-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304193636.219315-1-mathew.j.martineau@linux.intel.com>
References: <20220304193636.219315-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch added five more arguments for chk_join_nr(). The default
values of them are all zero.

The first two, csum_ns1 and csum_ns1, are passed to chk_csum_nr(), to
check the mib counters of the checksum errors in ns1 and ns2. A '+'
can be added into this two arguments to represent that multiple
checksum errors are allowed when doing this check. For example,

        chk_csum_nr "" +2 +2

indicates that two or more checksum errors are allowed in both ns1 and
ns2.

The remaining two, fail_nr and rst_nr, are passed to chk_fail_nr() and
chk_rst_nr() respectively, to check the sending and receiving mib
counters of MP_FAIL and MP_RST.

Also did some cleanups in chk_fail_nr(), renamed two local variables
and updated the output message.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 +++++++++++++------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4812e820acf..2912289d63f4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -766,8 +766,21 @@ dump_stats()
 chk_csum_nr()
 {
 	local msg=${1:-""}
+	local csum_ns1=${2:-0}
+	local csum_ns2=${3:-0}
 	local count
 	local dump_stats
+	local allow_multi_errors_ns1=0
+	local allow_multi_errors_ns2=0
+
+	if [[ "${csum_ns1}" = "+"* ]]; then
+		allow_multi_errors_ns1=1
+		csum_ns1=${csum_ns1:1}
+	fi
+	if [[ "${csum_ns2}" = "+"* ]]; then
+		allow_multi_errors_ns2=1
+		csum_ns2=${csum_ns2:1}
+	fi
 
 	if [ ! -z "$msg" ]; then
 		printf "%03u" "$TEST_COUNT"
@@ -777,8 +790,9 @@ chk_csum_nr()
 	printf " %-36s %s" "$msg" "sum"
 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
-	if [ "$count" != 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" != $csum_ns1 -a $allow_multi_errors_ns1 -eq 0 ] ||
+	   [ "$count" -lt $csum_ns1 -a $allow_multi_errors_ns1 -eq 1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		ret=1
 		dump_stats=1
 	else
@@ -787,8 +801,9 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
-	if [ "$count" != 0 ]; then
-		echo "[fail] got $count data checksum error[s] expected 0"
+	if [ "$count" != $csum_ns2 -a $allow_multi_errors_ns2 -eq 0 ] ||
+	   [ "$count" -lt $csum_ns2 -a $allow_multi_errors_ns2 -eq 1 ]; then
+		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		ret=1
 		dump_stats=1
 	else
@@ -799,27 +814,27 @@ chk_csum_nr()
 
 chk_fail_nr()
 {
-	local mp_fail_nr_tx=$1
-	local mp_fail_nr_rx=$2
+	local fail_tx=$1
+	local fail_rx=$2
 	local count
 	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "ftx"
 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_fail_nr_tx" ]; then
-		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
+	if [ "$count" != "$fail_tx" ]; then
+		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		ret=1
 		dump_stats=1
 	else
 		echo -n "[ ok ]"
 	fi
 
-	echo -n " - frx   "
+	echo -n " - failrx"
 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_fail_nr_rx" ]; then
-		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
+	if [ "$count" != "$fail_rx" ]; then
+		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		ret=1
 		dump_stats=1
 	else
@@ -911,6 +926,10 @@ chk_join_nr()
 	local syn_nr=$2
 	local syn_ack_nr=$3
 	local ack_nr=$4
+	local csum_ns1=${5:-0}
+	local csum_ns2=${6:-0}
+	local fail_nr=${7:-0}
+	local rst_nr=${8:-0}
 	local count
 	local dump_stats
 	local with_cookie
@@ -957,9 +976,9 @@ chk_join_nr()
 	fi
 	[ "${dump_stats}" = 1 ] && dump_stats
 	if [ $checksum -eq 1 ]; then
-		chk_csum_nr
-		chk_fail_nr 0 0
-		chk_rst_nr 0 0
+		chk_csum_nr "" $csum_ns1 $csum_ns2
+		chk_fail_nr $fail_nr $fail_nr
+		chk_rst_nr $rst_nr $rst_nr
 	fi
 }
 
-- 
2.35.1

