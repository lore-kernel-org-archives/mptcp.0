Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B373FF1
	for <mptcp@lists.linux.dev>; Thu, 12 May 2022 23:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652398027; x=1683934027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y8Kff7elEMZUNQ5A0JvdNuSLQhIb8zXMDvwIJO0oxHs=;
  b=dNHZcs3aRPFq9jyeeRAXebnJDu9hi1Gf5QEXEQ4Oru9EyF13X/bG7/5i
   thnckysUrlN3Uefw4Zw0RIeKcVqAY6d2FDToyJVzbrc5H6bAIb4FcYwe4
   8MMIlzcnH6Uh62CU+zvBY41Z4KHMUjfCs5oQPzg9mwr3KLR1/6fFiJxps
   VTYbx6DRFp7+dGNDpJ5v9Zyfoj2bpBLFdFlQMbGZ/DfpEzXTDCC/vKSwh
   K9causLZwOdI/VgDlqKYoGF+zXfzSWSNtAUXrQTuYQGu6fJqGafCOud9r
   4dBrbQL2mOGBbh39TLkYihz9hEk9xnmwyfWrjz/0v7bU6XKAQGSqSW8Ai
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="356590480"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="356590480"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 16:26:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="739919555"
Received: from cmokhtar-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.36.250])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 16:26:47 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/2] selftests: mptcp: add subflow limits test-cases
Date: Thu, 12 May 2022 16:26:42 -0700
Message-Id: <20220512232642.541301-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512232642.541301-1-mathew.j.martineau@linux.intel.com>
References: <20220512232642.541301-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Add and delete a bunch of endpoints and verify the
respect of configured limits.

This covers the codepath introduced by the previous patch.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 48 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7314257d248a..48ef112f42c2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1444,6 +1444,33 @@ chk_prio_nr()
 	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
+chk_subflow_nr()
+{
+	local need_title="$1"
+	local msg="$2"
+	local subflow_nr=$3
+	local cnt1
+	local cnt2
+
+	if [ -n "${need_title}" ]; then
+		printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${msg}"
+	else
+		printf "%-${nr_blank}s %s" " " "${msg}"
+	fi
+
+	cnt1=$(ss -N $ns1 -tOni | grep -c token)
+	cnt2=$(ss -N $ns2 -tOni | grep -c token)
+	if [ "$cnt1" != "$subflow_nr" -o "$cnt2" != "$subflow_nr" ]; then
+		echo "[fail] got $cnt1:$cnt2 subflows expected $subflow_nr"
+		fail_test
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" = 1 ] && ( ss -N $ns1 -tOni ; ss -N $ns1 -tOni | grep token; ip -n $ns1 mptcp endpoint )
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -2556,7 +2583,7 @@ fastclose_tests()
 	fi
 }
 
-implicit_tests()
+endpoint_tests()
 {
 	# userspace pm type prevents add_addr
 	if reset "implicit EP"; then
@@ -2578,6 +2605,23 @@ implicit_tests()
 			$ns2 10.0.2.2 id 1 flags signal
 		wait
 	fi
+
+	if reset "delete and re-add"; then
+		pm_nl_set_limits $ns1 1 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 slow &
+
+		wait_mpj $ns2
+		pm_nl_del_endpoint $ns2 2 10.0.2.2
+		sleep 0.5
+		chk_subflow_nr needtitle "after delete" 1
+
+		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 2
+		wait
+	fi
 }
 
 # [$1: error message]
@@ -2624,7 +2668,7 @@ all_tests_sorted=(
 	d@deny_join_id0_tests
 	m@fullmesh_tests
 	z@fastclose_tests
-	I@implicit_tests
+	I@endpoint_tests
 )
 
 all_tests_args=""
-- 
2.36.1

