Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157533E7
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 21:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651010248; x=1682546248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uQR/9rFY6hY2tSmUCN0th77tAuxipN7j03E1ZDb6EZY=;
  b=YpHffhdf1a+Z4rwN/Vb/g1VhEJiIt6IgwA0vNrgencTyaPeQhNJHP+t1
   7bIuSM5w/9b/aWwChZ7unCkHtdL7Hy7PFivOqhauENlaChS85qeAKlAPy
   xzN3eIvODTQpg1jHA78DaDjkn4dsQ8dJADVQKu7njCyQLqbCDuChMhKeS
   n7AHshEg9Uzoe/wOTxf+fx4G6zv5Nz2PDXvxib2EeTXAyqSvmIZHIuXeM
   TTEtlMcODQw8kMEj3GgDETCzFYb3edReJ/82o+NX00aiiWzkMha7fojta
   s7sPPYxAC+hXUo3Rkr6WlOH7AuQLQb5wHStXYyOTaaRaLSSRAiTAkRCJG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326222723"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326222723"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532878102"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.10.176])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:57:23 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 7/7] selftests: mptcp: print extra msg in chk_csum_nr
Date: Tue, 26 Apr 2022 14:57:17 -0700
Message-Id: <20220426215717.129506-8-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
References: <20220426215717.129506-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

When the multiple checksum errors occur in chk_csum_nr(), print the
numbers of the errors as an extra message.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8023c0773d95..e5c8fc2816fb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1013,6 +1013,7 @@ chk_csum_nr()
 	local csum_ns2=${2:-0}
 	local count
 	local dump_stats
+	local extra_msg=""
 	local allow_multi_errors_ns1=0
 	local allow_multi_errors_ns2=0
 
@@ -1028,6 +1029,9 @@ chk_csum_nr()
 	printf "%-${nr_blank}s %s" " " "sum"
 	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
+	if [ "$count" != "$csum_ns1" ]; then
+		extra_msg="$extra_msg ns1=$count"
+	fi
 	if { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
 	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
@@ -1039,15 +1043,20 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
 	[ -z "$count" ] && count=0
+	if [ "$count" != "$csum_ns2" ]; then
+		extra_msg="$extra_msg ns2=$count"
+	fi
 	if { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
 	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		fail_test
 		dump_stats=1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
 	[ "${dump_stats}" = 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
 
 chk_fail_nr()
-- 
2.36.0

