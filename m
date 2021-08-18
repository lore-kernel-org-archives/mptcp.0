Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2790168
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:28:10 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mGInj-00043r-EL; Wed, 18 Aug 2021 12:28:03 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v3 0/5] mptcp: add SOL_MPTCP getsockopt support
Date: Wed, 18 Aug 2021 12:27:51 +0200
Message-Id: <20210818102756.30734-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
- address comments from Mat.
  This only affects selftest program (init 'fd' to -1).
  Other than that, the only changes are in commit messages or
  re-format of code (reverse xmas).

Changes in v2:
- move #define to start of file (Mat)
- refer to '"multipath-tcp.org"', not mptcp.org (Mat)
- use __kernel_sa_family_t in uapi header (test robot)
- add test cases with invalid inputs (Paolo)
- avoid duplicate mptcp_sockopt.h in Makefile (Paolo)
- remove _u_optlen (Paolo)

original cover letter:

This adds the MPTCP_INFO, MPTCP_TCPINFO and MPTCP_SUBFLOW_ADDRS
mptcp getsockopt optnames.

MPTCP_INFO exposes the mptcp_info struct as an alternative to the
existing netlink diag interface.

MPTCP_TCPINFO exposes the tcp_info struct.
Unlike SOL_TCP/TCP_INFO, this returns one struct for each active
subflow.

MPTCP_SUBFLOW_ADDRS allows userspace to discover the ip addresses/ports
used by the local and remote endpoints, one for each active tcp subflow.

MPTCP_TCPINFO and MPTCP_SUBFLOW_ADDRS share the same meta-header that
needs to be pre-filled by userspace with the size of the data structures
it expects.  This is done to allow extension of the involved structs
later on, without breaking backwards compatibility.

The meta-structure can also be used to discover the required space
to obtain all information, as kernel will fill in the number of
active subflows even if there is not enough room for the requested info
itself.

More information is available in the individual patches.
Last patch adds test cases for the three optnames.

Florian Westphal (5):
  mptcp: add new mptcp_fill_diag helper
  mptcp: add MPTCP_INFO getsockopt
  mptcp: add MPTCP_TCPINFO getsockopt support
  mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support
  selftests: mptcp: add mptcp getsockopt test cases

 include/linux/socket.h                        |   1 +
 include/net/mptcp.h                           |   4 +
 include/uapi/linux/mptcp.h                    |  29 +
 net/mptcp/mptcp_diag.c                        |  26 +-
 net/mptcp/sockopt.c                           | 276 ++++++++
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../selftests/net/mptcp/mptcp_sockopt.c       | 644 ++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  31 +-
 8 files changed, 985 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_sockopt.c

-- 
2.31.1

