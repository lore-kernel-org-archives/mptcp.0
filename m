Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1742B7
	for <mptcp@lists.linux.dev>; Fri,  4 Mar 2022 19:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646422608; x=1677958608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wc9PGwvPhtaF4JiP57AOPUOF9WiO6euM1D/bIVvEp5I=;
  b=eZkiAxMfVVXSrPcUStSrirWt3+XwMGtDU5N1M/yFB1HxAnBwEB5cQxTv
   Wr8HTWiTKhR7xFJVTkdWM04q6Y5qABOyXVww9rgx1RBjt5svdxIIWGSZw
   gTyjEHTFU6C5qyOXjzNgRD6EN+8SVJjRHsi+vllfAWStkIPoVuz7ahMPo
   qhmEpK2fS6OZNpPUQoEBHwhpVPkDhkYeWsPl0Clv+NEueTVMb/uafBLch
   wGW4To8XN2m99i8fiAhE9ZNl94lg5AZF36vW19//YYDYgkjsV2ljaVu42
   hzU+242bu0Sml2gxyYAP+wlWqNfzIxVvaPs5qH3oRPCa3n6mRbT+I9rml
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278739509"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="278739509"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:36:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552340791"
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
Subject: [PATCH net-next 08/11] selftests: mptcp: add fastclose testcase
Date: Fri,  4 Mar 2022 11:36:33 -0800
Message-Id: <20220304193636.219315-9-mathew.j.martineau@linux.intel.com>
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

This patch added the self test for MP_FASTCLOSE. Reused the argument
addr_nr_ns2 of do_transfer() to pass the extra arguments '-I 2' to
mptcp_connect commands. Then mptcp_connect disconnected the
connections to trigger the MP_FASTCLOSE sending and receiving. Used
chk_fclose_nr to check the MP_FASTCLOSE mibs and used chk_rst_nr to
check the MP_RST mibs. This test used the test_linkfail value to make
1024KB test files.

The output looks like this:

Created /tmp/tmp.XB8sfv1hJ0 (size 1024 KB) containing data sent by client
Created /tmp/tmp.RtTDbzqrXI (size 1024 KB) containing data sent by server
001 fastclose test                syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  ctx[ ok ] - fclzrx[ ok ]
                                  rtx[ ok ] - rstrx [ ok ]   invert

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1fda29d5d69f..4604dd13a87e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -452,6 +452,12 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
+	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+		# disconnect
+		extra_args="$extra_args -I ${addr_nr_ns2:10}"
+		addr_nr_ns2=0
+	fi
+
 	local local_addr
 	if is_v6 "${connect_addr}"; then
 		local_addr="::"
@@ -2196,6 +2202,15 @@ fullmesh_tests()
 	chk_rm_nr 0 1
 }
 
+fastclose_tests()
+{
+	reset
+	run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_2
+	chk_join_nr "fastclose test" 0 0 0
+	chk_fclose_nr 1 1
+	chk_rst_nr 1 1 invert
+}
+
 all_tests()
 {
 	subflows_tests
@@ -2213,6 +2228,7 @@ all_tests()
 	checksum_tests
 	deny_join_id0_tests
 	fullmesh_tests
+	fastclose_tests
 }
 
 # [$1: error message]
@@ -2239,6 +2255,7 @@ usage()
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
 	echo "  -m fullmesh_tests"
+	echo "  -z fastclose_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
@@ -2270,7 +2287,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fesltra64bpkdmchCSi' opt; do
+while getopts 'fesltra64bpkdmchzCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2317,6 +2334,9 @@ while getopts 'fesltra64bpkdmchCSi' opt; do
 		m)
 			fullmesh_tests
 			;;
+		z)
+			fastclose_tests
+			;;
 		c)
 			;;
 		C)
-- 
2.35.1

