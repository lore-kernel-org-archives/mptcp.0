Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23E2FAD
	for <mptcp@lists.linux.dev>; Fri, 13 Aug 2021 22:15:55 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="212520891"
X-IronPort-AV: E=Sophos;i="5.84,320,1620716400"; 
   d="scan'208";a="212520891"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 15:15:54 -0700
X-IronPort-AV: E=Sophos;i="5.84,320,1620716400"; 
   d="scan'208";a="504320445"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.69.245])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 15:15:54 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com
Subject: [PATCH net-next 0/8] mptcp: Improve use of backup subflows
Date: Fri, 13 Aug 2021 15:15:40 -0700
Message-Id: <20210813221548.111990-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multipath TCP combines multiple TCP subflows in to one stream, and the
MPTCP-level socket must decide which subflow to use when sending (or
resending) chunks of data. The choice of the "best" subflow to transmit
on can vary depending on the priority (normal or backup) for each
subflow and how well the subflow is performing.

In order to improve MPTCP performance when some subflows are failing,
this patch set changes how backup subflows are utilized and introduces
tracking of "stale" subflows that are still connected but not making
progress.

Patch 1 adjusts MPTCP-level retransmit timeouts to use data from all
subflows.

Patch 2 makes MPTCP-level retransmissions less aggressive to avoid
resending data that's still queued at the TCP level.

Patch 3 changes the way pending data is handled when subflows are
closed. Unacked MPTCP-level data still in the subflow tx queue is
immediately moved to another subflow for transmission instead of waiting
for MPTCP-level timeouts to trigger retransmission.

Patch 4 has some sysctl code cleanup.

Patches 5 and 6 add tracking of "stale" subflows, so only underlying TCP
subflow connections that appear to be making progress are considered
when selecting a subflow to (re)transmit data. How fast a subflow goes
stale is configurable with a per-namespace sysctl. Related MIBS are
added too.

Patch 7 makes sure the backup flag is always correctly recorded when the
MP_JOIN SYN/ACK is received for an added subflow.

Patch 8 adds more test cases for backup subflows and stale subflows.


Paolo Abeni (8):
  mptcp: more accurate timeout
  mptcp: less aggressive retransmission strategy
  mptcp: handle pending data on closed subflow
  mptcp: cleanup sysctl data and helpers
  mptcp: faster active backup recovery
  mptcp: add mibs for stale subflows processing
  mptcp: backup flag from incoming MPJ ack option
  selftests: mptcp: add testcase for active-back

 Documentation/networking/mptcp-sysctl.rst     |  12 +
 net/mptcp/ctrl.c                              |  26 ++-
 net/mptcp/mib.c                               |   2 +
 net/mptcp/mib.h                               |   2 +
 net/mptcp/options.c                           |   8 +-
 net/mptcp/pm.c                                |  21 ++
 net/mptcp/pm_netlink.c                        |  39 ++++
 net/mptcp/protocol.c                          | 187 +++++++++++----
 net/mptcp/protocol.h                          |  31 ++-
 net/mptcp/subflow.c                           |   6 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 218 +++++++++++++++---
 11 files changed, 464 insertions(+), 88 deletions(-)


base-commit: 876c14ad014d0e39c57cbfde53e13d17cdb6d645
-- 
2.32.0

