Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B7173
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 22:59:50 +0000 (UTC)
IronPort-SDR: TnUN1/fExXbu9lwkQ9/cGhpsLFoxSu8yzbMtV9cSc2qgUoqHyNFY3hjmTeJOXGdPP+qFvcfvMw
 or0eGJcFiu7w==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="266575613"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="266575613"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 15:59:49 -0700
IronPort-SDR: HQY8/5wxQYDJ2ev1x8LFPECtKofreEBLMMzXjSR/KH6tX8+DoqggqRT5TaqmS/rpfeDu44Wqaf
 9OOv6FF49xtw==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="441387018"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.70.185])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 15:59:49 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/5] mptcp: More v5.13 fixes
Date: Thu, 10 Jun 2021 15:59:39 -0700
Message-Id: <20210610225944.351224-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here's another batch of MPTCP fixes for v5.13.

Patch 1 cleans up memory accounting between the MPTCP-level socket and
the subflows to more reliably transfer forward allocated memory under
pressure.

Patch 2 wakes up socket readers more reliably.

Patch 3 changes a WARN_ONCE to a pr_debug.

Patch 4 changes the selftests to only use syncookies in test cases where
they do not cause spurious failures.

Patch 5 modifies socket error reporting to avoid a possible soft lockup.


Paolo Abeni (5):
  mptcp: try harder to borrow memory from subflow under pressure
  mptcp: wake-up readers only for in sequence data
  mptcp: do not warn on bad input from the network
  selftests: mptcp: enable syncookie only in absence of reorders
  mptcp: fix soft lookup in subflow_error_report()

 net/mptcp/protocol.c                          |  52 +++++----
 net/mptcp/protocol.h                          |   1 -
 net/mptcp/subflow.c                           | 108 +++++++++---------
 .../selftests/net/mptcp/mptcp_connect.sh      |  11 +-
 4 files changed, 88 insertions(+), 84 deletions(-)


base-commit: 22488e45501eca74653b502b194eb0eb25d2ad00
-- 
2.32.0

