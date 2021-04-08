Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AA66D00
	for <mptcp@lists.linux.dev>; Thu,  8 Apr 2021 18:49:56 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lUZiv-00015F-2s; Thu, 08 Apr 2021 20:49:49 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp 00/10] mptcp: add SOL_SOCKET support
Date: Thu,  8 Apr 2021 20:49:26 +0200
Message-Id: <20210408184936.6245-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set improves support for several SOL_SOCKET tuneables,
addressing comments received for v1 patch set.

First patch adds skeleton synchronization functions to copy mptcp socket
settings to a subflow socket.

Second patch adds sequence counting scheme to avoid re-sync when subflow
and mptcp-level socket are known to have the same setting applied.

Notable changes:
I removed the sequence number from patch 1 and split it into second
patch to make those bits clearer.

TCP_CONGESTION is now applied to all subflows.

TCP_INFO retrieves info from the first subflow.  It seems better to
add MPTCP_INFO from out-of-tree patch set in a future change for
userspace that wants mptcp-level flow statistics.

I've not changed SO_LINGER either, this should be updated in a
future change to send a FASTCLOSE when mptcp socket gets closed
while the linger time is 0.

The last patch adds a simple test to check SO_MARK replication.

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

 net/mptcp/protocol.c                          |  55 ++-
 net/mptcp/protocol.h                          |  11 +
 net/mptcp/sockopt.c                           | 404 ++++++++++++++++++
 net/mptcp/subflow.c                           |   5 +
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../selftests/net/mptcp/mptcp_connect.c       |  23 +-
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 276 ++++++++++++
 7 files changed, 765 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh

-- 
2.26.3

