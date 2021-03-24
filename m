Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E81E6F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 13:24:01 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lP3MZ-0003kb-Ua; Wed, 24 Mar 2021 14:15:55 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: <mptcp@lists.01.org>,
	Florian Westphal <fw@strlen.de>
Subject: [RFC PATCH mptcp-next v2 0/8] initial SOL_SOCKET support
Date: Wed, 24 Mar 2021 14:15:38 +0100
Message-Id: <20210324131546.13730-1-fw@strlen.de>
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

Notable changes:
In patch 1, work queue is only used when caller holds a spinlock that
prevents calls to sleepable functions such as lock_sock().

TCP_CONGESTION is now applied to all subflows.
TCP_INFO retrieves info from the first subflow.
It seems better to add MPTCP_INFO from out-of-tree patch set
in a future change.

I've not changed SO_LINGER either but I think doing a FASTCLOSE
is the right thing to do when linger time is 0.

Sending this now so there is a bit of review time before thursdays
meeting.

Florian Westphal (8):
  mptcp: add skeleton to sync msk socket options to subflows
  mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY
  mptcp: setsockopt: handle receive/send buffer and device bind
  mptcp: setsockopt: support SO_LINGER
  mptcp: setsockopt: add SO_MARK support
  mptcp: setsockopt: add SO_INCOMING_CPU
  mptcp: setsockopt: SO_DEBUG and no-op options
  mptcp: sockopt: add TCP_CONGESTION and TCP_INFO

 net/mptcp/protocol.c |  54 +++++--
 net/mptcp/protocol.h |  11 ++
 net/mptcp/sockopt.c  | 362 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  |   1 +
 4 files changed, 419 insertions(+), 9 deletions(-)

-- 
2.26.3

