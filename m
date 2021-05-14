Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB26071
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 09:49:12 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lhURM-0006ru-TD; Fri, 14 May 2021 11:49:04 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 mptcp-next 0/7] add cmsg support to receive path
Date: Fri, 14 May 2021 11:48:50 +0200
Message-Id: <20210514094857.10663-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:
 - drop patch 1 (busypoll support), SO_BUSYPOLL will have no effect.
 effect.
 - adjust patch 5 accordingly.

Changes since v2:
 - fix indendation of a if line in patch 1 (Mat)
 - avoid useless conditional in patch 5 (Mat)

This adds setsockopt support for busypoll + and the various
SO_TIMESTAMP variants.

To reduce copy&paste, a few helper functions get exported for
mptcp sake.

Last patch extends the existing setsockopt test case to also
cover/enable SO_TIMESTAMP.

Florian Westphal (7):
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
 net/mptcp/protocol.c                          |  28 +++-
 net/mptcp/sockopt.c                           | 149 ++++++++++--------
 .../selftests/net/mptcp/mptcp_connect.c       | 125 ++++++++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   4 +-
 8 files changed, 296 insertions(+), 124 deletions(-)

-- 
2.26.3

