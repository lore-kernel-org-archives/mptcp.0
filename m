Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21EB72
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 23:24:44 +0000 (UTC)
IronPort-SDR: LnJK8X6VR8+L0kBf3ZaaHj5jv9H6VgtzE9tBlCyvTYt6bcHOl5tO6ZfWAEMbzgACHqMRYWrA8j
 o08IiqsUmffQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="225487483"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="225487483"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 16:24:41 -0700
IronPort-SDR: BdeWeVIBJ+DcmF3X1OnWDR6TN4A8lYEaW4qTxKtLN2zNzq1XQF7bpgvu+6aemBK3oPmRjotC3V
 evdDYQZME3QQ==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="483669037"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.3.143])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 16:24:41 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	fw@strlen.de,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/7] mptcp: Add timestamp support
Date: Thu,  3 Jun 2021 16:24:26 -0700
Message-Id: <20210603232433.260703-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the SO_TIMESTAMP and SO_TIMESTAMPING socket options for MPTCP
sockets and add receive path cmsg support for timestamps.

Patches 1, 2, and 5 expose existing sock and tcp helpers for timestamps
(no new EXPORT_SYMBOLS()s).

Patch 3 propagates timestamp options to subflows.

Patch 4 cleans up MPTCP handling of SOL_SOCKET options.

Patch 6 adds timestamp csmg data when receiving on sockets that have
been configured for timestamps.

Patch 7 adds self test coverage for timestamps.


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


base-commit: 6a8dd8b2fa5b7cec4b13f5f5b2589d9abbac0fab
-- 
2.31.1

