Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92F2F20
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 15:29:56 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nIBOM-0003F1-Jf; Thu, 10 Feb 2022 16:29:54 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 0/4] mptcp: replace per-addr listener sockets
Date: Thu, 10 Feb 2022 16:29:45 +0100
Message-Id: <20220210152949.19572-1-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a hidden per-netns pseudo "listener"
socket to handle mptcp join requests with a valid token but that
do not match an existing listening socket.

First patch is a minor preparation patch: MPTCP Join requests packets
that fail to find a suitable socket by means of standard address/port
demultiplexing will be steered to a pseudo-listener, similar to TPROXY
interception.

This pseudo listener isn't bound to an address or port (all zero), so
we need to fetch the port number from the tcp header and not the
listener socket.

Patch two adds a stub to the tcp demux code.
This has no functionality, its extra to make tcp datapath change
stand out.

Third patch is the bulk work, it adds per netns listener and
implements token-based socket demultiplexing.

Last patch zaps the per-address sockets from mptcp, they are not
needed anymore.

Florian Westphal (4):
  mptcp: prefer ip address in syn skb instead of listen sk bound address
  tcp: add mptcp join demultiplex hooks
  mptcp: handle join requests via pernet listen socket
  mptcp: remove per-address listening sockets

 include/net/mptcp.h    |  15 +++
 net/ipv4/tcp_ipv4.c    |   4 +
 net/ipv6/tcp_ipv6.c    |  23 +++--
 net/mptcp/ctrl.c       | 214 ++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/pm_netlink.c |  82 +++-------------
 net/mptcp/protocol.c   |   2 +-
 net/mptcp/protocol.h   |   4 +-
 net/mptcp/subflow.c    |   8 +-
 8 files changed, 268 insertions(+), 84 deletions(-)

-- 
2.34.1
