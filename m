Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C92CAD
	for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 00:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642725340; x=1674261340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=37OiH+ekDV4sczue07YU3KYi/b272WtlcVytdrNcBoc=;
  b=HI604TMb9tLk0QTwIAkalZ8kRViGhKo3p9bN5c7OEtcPDLcP6wg4PcHu
   Dz6HKjJvaWn0odg90MJJzh2E5lnrE76lryvmEG3a7EGqw4a9S1batsqr8
   yCt0DS7rOeIpxKIZhYP5DRcs9iG5MNR+IyoFnR9XprJGWB1LvVE5WAWlO
   COK/dPivgis3sZaQvDI8rPnS/Lb+o4T0/oNaVL21TYB1tHMx2NgekrQit
   CwIgxqu6rHCjiJhbMF50CqFhvqtM027wsx0XzlquPwjaIOZJJdXIApyNY
   WYVSBsAxgeA89wew/ibpT1jFOckqhUAFMAdmQxbKnuNIBbK6KzjZcKzJD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="232886198"
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="232886198"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 16:35:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="531215221"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.220.167])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 16:35:37 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 3/3] selftests: mptcp: fix ipv6 routing setup
Date: Thu, 20 Jan 2022 16:35:29 -0800
Message-Id: <20220121003529.54930-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121003529.54930-1-mathew.j.martineau@linux.intel.com>
References: <20220121003529.54930-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

MPJ ipv6 selftests currently lack per link route to the server
net. Additionally, ipv6 subflows endpoints are created without any
interface specified. The end-result is that in ipv6 self-tests
subflows are created all on the same link, leading to expected delays
and sporadic self-tests failures.

Fix the issue by adding the missing setup bits.

Fixes: 523514ed0a99 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
Reported-and-tested-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 27d0eb9afdca..b8bdbec0cf69 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -75,6 +75,7 @@ init()
 
 		# let $ns2 reach any $ns1 address from any interface
 		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
+		ip -net "$ns2" route add default via dead:beef:$i::1 dev ns2eth$i metric 10$i
 	done
 }
 
@@ -1476,7 +1477,7 @@ ipv6_tests()
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single subflow IPv6" 1 1 1
 
@@ -1511,7 +1512,7 @@ ipv6_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal IPv6" 2 2 2
 	chk_add_nr 1 1
-- 
2.34.1

