Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78681E9F8
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 23:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668122612; x=1699658612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K5WFNYmzwEU6n6c2Iik7W5YdAFUW2w/26+1Z+wYlPJk=;
  b=lmLyQhaOPDHVV/5e2cqjGLdw1S2l5oda60chEQJArj2c2jF2QGIU9hxn
   l75RCDf0sheD1R6WoVZRorE9AInSyjbxY+nZk0GH7n/WeppWkl288o5+v
   akdgBZoGKnH342DrdEEwsntRH6FvdGRdWk2CHwDRsOR6VDZNYEmz3+zB6
   BH2mlDG8wmqKm3pdRc5qdE5zBbdwNOkadAfQYs9m8B49QH0l3Wb5KkU59
   TydUANzIwqqt1Su34F6exaAyrsjz1TbzfhpHWf81oduMNEjZU935kK9K9
   c0XoHME/VSWeMvEAzaFPgDm62ax6s4VcXMceI5HpmjSIR6cmXn1FOYkCW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373594076"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="373594076"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 15:23:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="637367375"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="637367375"
Received: from jsandova-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.81.89])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 15:23:29 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 4/5] selftests: mptcp: use max_time instead of time
Date: Thu, 10 Nov 2022 15:23:21 -0800
Message-Id: <20221110232322.125068-5-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110232322.125068-1-mathew.j.martineau@linux.intel.com>
References: <20221110232322.125068-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

'time' is the local variable of run_test() function, while 'max_time' is
the local variable of do_transfer() function. So in do_transfer(),
$max_time should be used, not $time.

Please note that here $time == $max_time so the behaviour is not changed
but the right variable is used.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ffa13a957a36..af70c14e0bf9 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -173,7 +173,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${ns3} \
-			./mptcp_connect -jt ${timeout_poll} -l -p $port -T $time \
+			./mptcp_connect -jt ${timeout_poll} -l -p $port -T $max_time \
 				0.0.0.0 < "$sin" > "$sout" &
 	local spid=$!
 
@@ -181,7 +181,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${ns1} \
-			./mptcp_connect -jt ${timeout_poll} -p $port -T $time \
+			./mptcp_connect -jt ${timeout_poll} -p $port -T $max_time \
 				10.0.3.3 < "$cin" > "$cout" &
 	local cpid=$!
 
-- 
2.38.1

