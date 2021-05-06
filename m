Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0870
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 10:22:57 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1leb9e-0001Nh-4D; Thu, 06 May 2021 12:22:50 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 0/8] add cmsg support to receive path
Date: Thu,  6 May 2021 12:22:35 +0200
Message-Id: <20210506102243.2390-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds setsockopt support for busypoll + and the various
SO_TIMESTAMP variants.

To reduce copy&paste, a few helper functions get exported for
mptcp sake.

Last patch extends the existing setsockopt test case to also
cover/enable SO_TIMESTAMP.

Florian Westphal (8):
  mptcp: enable busypoll from mptcp receive path
  sock: expose so_timestamp options for mptcp
  sock: expose so_timestamping options for mptcp
  mptcp: sockopt: propagate timestamp request to subflows
  mptcp: setsockopt: handle SOL_SOCKET in one place only
  tcp: export timestamp helpers for mptcp
  mptcp: receive path cmsg support
  selftests: mptcp_connect: add SO_TIMESTAMPNS cmsg support

 include/net/sock.h                            |   3 +
 include/net/tcp.h                             |   4 +
 net/core/sock.c                               |  97 +++++++-----
 net/ipv4/tcp.c                                |  10 +-
 net/mptcp/protocol.c                          |  35 ++++-
 net/mptcp/sockopt.c                           | 145 ++++++++++--------
 .../selftests/net/mptcp/mptcp_connect.c       | 125 ++++++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   4 +-
 8 files changed, 303 insertions(+), 120 deletions(-)

-- 
2.26.3

