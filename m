Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A62C85
	for <mptcp@lists.linux.dev>; Tue, 16 Nov 2021 13:59:26 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mmyzV-0003TK-VJ; Tue, 16 Nov 2021 14:59:18 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 mptcp-next 0/4] TCP_INQ support
Date: Tue, 16 Nov 2021 14:48:00 +0100
Message-Id: <20211116134804.30090-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No major changes since v2, see individual patches for details.

This adds TCP_INQ for mptcp and extends the selftest infra.
Patch 3 adds ioctls to retrieve amount of in-sequence bytes
ready to for read() (older version of TCP_INQ) and counters for
unsent and unacked byte count.

Last patch is new in v2, its a more specific TCP_INQ test case.
See individual patches for changes since v1.

Florian Westphal (4):
  mptcp: add TCP_INQ cmsg support
  selftests: mptcp: add TCP_INQ support
  mptcp: add SIOCINQ, OUTQ and OUTQNSD ioctls
  selftests: mptcp: add inq test case

 net/mptcp/protocol.c                          |  89 ++-
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  37 ++
 tools/testing/selftests/net/mptcp/.gitignore  |   1 +
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../selftests/net/mptcp/mptcp_connect.c       |  58 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c | 603 ++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  44 +-
 8 files changed, 830 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.32.0

