Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1A6D3D
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 23:45:08 +0000 (UTC)
IronPort-SDR: EAGvwxKerSZJPLoX/4JzKdhQZ6mtm8Ap5OeTM4uORyJu/eVdLOZV+nA0q9FvujY1Ee1CqjpCX/
 y+hsRfjwyLzg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258923269"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="258923269"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:45:07 -0700
IronPort-SDR: /x+FmtNv0HHgxaYPbXp/rtB6Qkeahz6UXTytJrXL8G2F0fJQV8zDz82qyr51t+4bnKamjAdfRb
 GDLxoRkAxz3Q==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461793351"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.243.150])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:45:07 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 00/13] mptcp: Improve socket option handling
Date: Thu, 15 Apr 2021 16:44:49 -0700
Message-Id: <20210415234502.224225-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP sockets have previously had limited socket option support. The
architecture of MPTCP sockets (one userspace-facing MPTCP socket that
manages one or more in-kernel TCP subflow sockets) adds complexity for
passing options through to lower levels. This patch set adds MPTCP
support for socket options commonly used with TCP.

Patch 1 reverts an interim socket option fix (a socket option blocklist)
that was merged in the net tree for v5.12.

Patch 2 moves the socket option code to a separate file, with no
functional changes.

Patch 3 adds an allowlist for socket options that are known to function
with MPTCP. Later patches in this set add more allowed options.

Patches 4 and 5 add infrastructure for syncing MPTCP-level options with
the TCP subflows.

Patches 6-12 add support for specific socket options.

Patch 13 adds a socket option self test.


Florian Westphal (10):
  mptcp: add skeleton to sync msk socket options to subflows
  mptcp: tag sequence_seq with socket state
  mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY
  mptcp: setsockopt: handle receive/send buffer and device bind
  mptcp: setsockopt: support SO_LINGER
  mptcp: setsockopt: add SO_MARK support
  mptcp: setsockopt: add SO_INCOMING_CPU
  mptcp: setsockopt: SO_DEBUG and no-op options
  mptcp: sockopt: add TCP_CONGESTION and TCP_INFO
  selftests: mptcp: add packet mark test case

Matthieu Baerts (1):
  mptcp: revert "mptcp: forbit mcast-related sockopt on MPTCP sockets"

Paolo Abeni (2):
  mptcp: move sockopt function into a new file
  mptcp: only admit explicitly supported sockopt

 net/mptcp/Makefile                            |   2 +-
 net/mptcp/protocol.c                          | 219 ++---
 net/mptcp/protocol.h                          |  16 +
 net/mptcp/sockopt.c                           | 756 ++++++++++++++++++
 net/mptcp/subflow.c                           |   5 +
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../selftests/net/mptcp/mptcp_connect.c       |  23 +-
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 276 +++++++
 8 files changed, 1122 insertions(+), 177 deletions(-)
 create mode 100644 net/mptcp/sockopt.c
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh


base-commit: 3a1aa533f7f676aad68f8dbbbba10b9502903770
-- 
2.31.1

