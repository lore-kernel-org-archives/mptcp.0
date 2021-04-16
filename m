Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D12F84
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 22:38:18 +0000 (UTC)
IronPort-SDR: JtmSWkez0fqJAxWGNXiDIG0SDnVHXXEGnIv3jSv4eQXIN8OGuwKxhvB3loRqE09BESPl8sgDQN
 +Dg+iUxUXIXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="175231656"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="175231656"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:38:17 -0700
IronPort-SDR: mxYuzjH3ke5K39Wv96+Pxh2xzNh3Za+6ouNh9QBgaz9HNNSU/Y6ifLescYnUg9Yn58Dcrs7Ocx
 /GEfGC+dQ/7g==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="462107386"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.43.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:38:17 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/8] mptcp: Fixes and tracepoints from the mptcp tree
Date: Fri, 16 Apr 2021 15:38:00 -0700
Message-Id: <20210416223808.298842-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here's one more batch of changes that we've tested out in the MPTCP tree.


Patch 1 makes the MPTCP KUnit config symbol more consistent with other
subsystems.

Patch 2 fixes a couple of format specifiers in pr_debug()s

Patches 3-7 add four helpful tracepoints for MPTCP.

Patch 8 is a one-line refactor to use an available helper macro.


Geliang Tang (7):
  mptcp: fix format specifiers for unsigned int
  mptcp: export mptcp_subflow_active
  mptcp: add tracepoint in mptcp_subflow_get_send
  mptcp: add tracepoint in get_mapping_status
  mptcp: add tracepoint in ack_update_msk
  mptcp: add tracepoint in subflow_check_data_avail
  mptcp: use mptcp_for_each_subflow in mptcp_close

Nico Pache (1):
  kunit: mptcp: adhere to KUNIT formatting standard

 MAINTAINERS                  |   1 +
 include/trace/events/mptcp.h | 173 +++++++++++++++++++++++++++++++++++
 net/mptcp/Kconfig            |   2 +-
 net/mptcp/Makefile           |   2 +-
 net/mptcp/crypto.c           |   2 +-
 net/mptcp/options.c          |   6 ++
 net/mptcp/protocol.c         |  26 ++----
 net/mptcp/protocol.h         |  12 +++
 net/mptcp/subflow.c          |  10 +-
 net/mptcp/token.c            |   2 +-
 10 files changed, 207 insertions(+), 29 deletions(-)
 create mode 100644 include/trace/events/mptcp.h


base-commit: 4ad29b1a484e0c58acfffdcd87172ed17f35c1dd
-- 
2.31.1

