Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9772
	for <mptcp@lists.linux.dev>; Fri, 26 Mar 2021 18:27:36 +0000 (UTC)
IronPort-SDR: 2vZ+KV5fjq7FgEKP/Z2dAI9v1jiBEclq2EdglkPCkCo3MAKfrx61kuUmgiuHNAGoQ1C61LrnQN
 Cs0YVnAn053A==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211365153"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="211365153"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 11:27:35 -0700
IronPort-SDR: sRDywhDIWe+NaqBL6ARE2DVshJn+rqfQG/53KvRRu3NW5X08hIFGDAkaeYa3NvQusLmvkI+6pH
 sLh3aMkk7OSQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="443456552"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.24.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 11:27:35 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 07/13] selftests: mptcp: timeout testcases for multi addresses
Date: Fri, 26 Mar 2021 11:26:36 -0700
Message-Id: <20210326182642.136419-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326182642.136419-1-mathew.j.martineau@linux.intel.com>
References: <20210326182307.136256-1-mathew.j.martineau@linux.intel.com>
 <20210326182642.136419-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

This patch added the timeout testcases for multi addresses, valid and
invalid.

These testcases need to transmit 8 ADD_ADDRs, so add a new speed level
'least' to set 10 to mptcp_connect to slow down the transmitting process.
The original speed level 'slow' still uses 50.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fe990d8696a9..32379efa2276 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -234,8 +234,10 @@ do_transfer()
 
 	if [ $speed = "fast" ]; then
 		mptcp_connect="./mptcp_connect -j"
-	else
-		mptcp_connect="./mptcp_connect -r"
+	elif [ $speed = "slow" ]; then
+		mptcp_connect="./mptcp_connect -r 50"
+	elif [ $speed = "least" ]; then
+		mptcp_connect="./mptcp_connect -r 10"
 	fi
 
 	local local_addr
@@ -818,6 +820,26 @@ add_addr_timeout_tests()
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
 	chk_add_nr 4 0
+
+	# signal addresses timeout
+	reset_with_add_addr_timeout
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
+	chk_add_nr 8 0
+
+	# signal invalid addresses timeout
+	reset_with_add_addr_timeout
+	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
+	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
+	chk_add_nr 8 0
 }
 
 remove_tests()
-- 
2.31.0

