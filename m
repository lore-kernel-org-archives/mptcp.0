Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A036D0E
	for <mptcp@lists.linux.dev>; Wed,  7 Apr 2021 00:16:11 +0000 (UTC)
IronPort-SDR: fNS9Z5yeUk82R57wM9gbYvSoLJzvsA1Qp4eMBQldghegoEvnBOvD3Jl4NemT7Ici8cWAghTkF3
 wsoMBNkqMv2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="192723058"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="192723058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 17:16:10 -0700
IronPort-SDR: c0Tg82npxhOSKY4RKP9zNmlP5KGAoGGYCss0UJ0YNEYu/UH8QmiMV3QrLuQWQd2MJ+SAcPGDcJ
 +/JMf7it1PKg==
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="458105191"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.254.115.52])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 17:16:10 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/8] mptcp: Cleanup, a new test case, and header trimming
Date: Tue,  6 Apr 2021 17:15:56 -0700
Message-Id: <20210407001604.85071-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some more patches to include from the MPTCP tree:

Patches 1-6 refactor an address-related data structure and reduce some
duplicate code that handles IPv4 and IPv6 addresses.

Patch 7 adds a test case for the MPTCP netlink interface, passing a
specific ifindex to the kernel.

Patch 8 drops extra header options from IPv4 address echo packets,
improving consistency and testability between IPv4 and IPv6.

Davide Caratti (1):
  mptcp: drop all sub-options except ADD_ADDR when the echo bit is set

Geliang Tang (7):
  mptcp: move flags and ifindex out of mptcp_addr_info
  mptcp: use mptcp_addr_info in mptcp_out_options
  mptcp: drop OPTION_MPTCP_ADD_ADDR6
  mptcp: use mptcp_addr_info in mptcp_options_received
  mptcp: drop MPTCP_ADDR_IPVERSION_4/6
  mptcp: unify add_addr(6)_generate_hmac
  selftests: mptcp: add the net device name testcase

 include/net/mptcp.h                           |  21 ++-
 net/mptcp/options.c                           | 175 ++++++------------
 net/mptcp/pm_netlink.c                        |  41 ++--
 net/mptcp/protocol.h                          |  38 +---
 net/mptcp/subflow.c                           |   7 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |   8 +
 6 files changed, 115 insertions(+), 175 deletions(-)


base-commit: be107538c5296fb888938ec3a32da21bb1733655
-- 
2.31.1

