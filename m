Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872BF2C9D
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 23:37:07 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="303232018"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="303232018"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 15:37:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="683556052"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.7.225])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 15:37:06 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/3] mptcp: Miscellaneous changes for 5.17
Date: Fri, 17 Dec 2021 15:36:59 -0800
Message-Id: <20211217233702.299461-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are three unrelated patches that we've been testing in the MPTCP
tree.


Patch 1 modifies the packet scheduler that picks which TCP subflow is
used for each chunk of outgoing data. The updated scheduler improves
throughput on multiple-subflow connections.

Patch 2 updates a selftest to verify recent TCP_ULP sockopt changes
on MPTCP fallback sockets.

Patch 3 cleans up some unnecessary comparisons with an 8-bit value.


Florian Westphal (1):
  selftests: mptcp: try to set mptcp ulp mode in different sk states

Jean Sacren (1):
  mptcp: clean up harmless false expressions

Paolo Abeni (1):
  mptcp: enforce HoL-blocking estimation

 net/mptcp/pm_netlink.c                        |  8 +-
 net/mptcp/protocol.c                          | 72 +++++++++-----
 net/mptcp/protocol.h                          |  1 +
 .../selftests/net/mptcp/mptcp_connect.c       | 97 ++++++++++---------
 .../selftests/net/mptcp/mptcp_connect.sh      | 20 ----
 5 files changed, 103 insertions(+), 95 deletions(-)


base-commit: f75c1d55ecbadce027fd650d3ca79e357afae0d9
-- 
2.34.1

