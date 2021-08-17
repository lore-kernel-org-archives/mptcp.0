Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC39168
	for <mptcp@lists.linux.dev>; Tue, 17 Aug 2021 22:07:33 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="203357967"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="203357967"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 15:07:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="573058341"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.9.45])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 15:07:32 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	geliangtang@xiaomi.com
Subject: [PATCH net-next 0/6] mptcp: Add full mesh path manager option
Date: Tue, 17 Aug 2021 15:07:21 -0700
Message-Id: <20210817220727.192198-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The path manager in MPTCP controls the creation of additional subflows
after the initial connection is created. As each peer advertises
available endpoints with the ADD_ADDR MPTCP option, the recipient of
those advertisements must decide which subflows to create from the known
local and remote interfaces that are available for use by MPTCP.

The existing in-kernel path manager will create one additional subflow
when an ADD_ADDR is received, or a local address is newly configured for
MPTCP use. The maximum number of subflows has a configurable limit.

This patch set adds a MPTCP_PM_ADDR_FLAG_FULLMESH flag to the MPTCP
netlink API that enables subflows to be created more aggressively. When
an ADD_ADDR is received from a peer, new subflows are created between
that address/port and all local addresses configured for MPTCP.
Similarly, when a new local address is newly configured for use by
MPTCP, new subflows are created between that local address and all known
remote addresses for that MPTCP connection. The configurable limit on
the number of subflows still applies. If the new flag is not used the
path manager behavior is unchanged.

Patch 1 adds a helper function and refactors another function to prepare
for the rest of the patch series.

Patches 2 and 3 add two mesh connection capabilities: initiating
subflows based on added local addresses, or reacting to incoming
advertisements.

Patches 4-6 add full mesh cases to the self tests.


Geliang Tang (6):
  mptcp: drop flags and ifindex arguments
  mptcp: remote addresses fullmesh
  mptcp: local addresses fullmesh
  selftests: mptcp: set and print the fullmesh flag
  selftests: mptcp: add fullmesh testcases
  selftests: mptcp: delete uncontinuous removing ids

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/pm_netlink.c                        | 154 ++++++++++++++++--
 net/mptcp/protocol.h                          |   5 +-
 net/mptcp/subflow.c                           |   7 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  74 ++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  16 +-
 6 files changed, 231 insertions(+), 26 deletions(-)


base-commit: 752be2976405b7499890c0b6bac6d30d34d08bd6
-- 
2.33.0

