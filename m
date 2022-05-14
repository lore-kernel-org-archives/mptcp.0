Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C74366
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 00:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652487682; x=1684023682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1zXQQLIalYYZ2M8+aZMUpfjKxvlmKG2qfFu5cLhcq1M=;
  b=gFTPDY9IGVrNCz3rVJAnGH+JNyN2qjvr60CWEBPEvhi9f8Jjb/NgJRlh
   KmSFFSytN3PaeybbYsEw+w5grL7jamGrPgmZoalkdxiiOej38HYhzqmEx
   iicoK2Q+Mm8/JkhsRhkj339KNQT3cUC7nyo8QcOcsKI/jrr8AnabVHKYi
   N6EDwy9tRxOzvNQPWnlFUDhK858yo99Nc6HCBARW1gMu3n6X1WrP47klA
   mL99IJPYNFB6km0QkmSSn6xjb7XqDsounYzQpszsvHWirdoe/PuFbFrmQ
   zV7MuafKbU5VHlggmF132ucIwskVNy1yXwZzUGwbTccch/+IeNIAphaM9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250349594"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="250349594"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 17:21:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="625102784"
Received: from clakshma-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.160.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 17:21:20 -0700
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
Subject: [PATCH net-next 1/3] selftests: mptcp: fix a mp_fail test warning
Date: Fri, 13 May 2022 17:21:13 -0700
Message-Id: <20220514002115.725976-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514002115.725976-1-mathew.j.martineau@linux.intel.com>
References: <20220514002115.725976-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Old tc versions (iproute2 5.3) show actions in multiple lines, not a
single line. Then the following unexpected MP_FAIL selftest output
occurs:

 file received by server has inverted byte at 169
 ./mptcp_join.sh: line 1277: [: [{"total acts":1},{"actions":[{"order":0 pedit ,"control_action":{"type":"pipe"}keys 1
         index 1 ref 1 bind 1,"installed":0,"last_used":0
         key #0  at 148: val ff000000 mask ffffffff
 5: integer expression expected
 001 Infinite map                      syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       sum[ ok ] - csum  [ ok ]
                                       ftx[ ok ] - failrx[ ok ]
                                       rtx[ ok ] - rstrx [ ok ]
                                       itx[ ok ] - infirx[ ok ]
                                       ftx[ ok ] - failrx[ ok ] invert

This patch adds a 'grep' before 'sed' to fix this.

Fixes: b6e074e171bc ("selftests: mptcp: add infinite map testcase")
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d1de1e7702fb..7381d1f85209 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2693,6 +2693,7 @@ fastclose_tests()
 pedit_action_pkts()
 {
 	tc -n $ns2 -j -s action show action pedit index 100 | \
+		grep "packets" | \
 		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
 }
 
-- 
2.36.1

