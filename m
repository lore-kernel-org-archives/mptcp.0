Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11FA2F24
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 03:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858020; x=1675394020;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QyO5XUHrX375nxLcJp9UO+PgzPy/Bh9dqWmLHtsuxNU=;
  b=CWlIG8yMjOmcDowmbR7lysAL0XPk/W9xEjAg62Lp3dkJT8krroxoYFMS
   8HmYor8H1XBbJM9y2JslWU1bznBX9yO1tm0OkIN/NxUd8OZPyQDQI/7Ab
   aZnSTwed6rM/EcbwUpLU6K2C4h2H4WZlVadTCb47o9ZqVllEDnaaRFgMA
   LhuKDjRsrVtTN/0JQffyTaFhQuzLsS47rYklppJTQpY+BeqqbuHcyZAgU
   t9LXe/3KtQg630nnQKn8TYYUY+UZL9BDgIR0DNHJK/0SWWFfbrLXVPXrX
   XxKdQ9dvJR5GpxMn3PiW6QeKr/rK+FJgVWSmzCdVLUCx69r/yoJXmpX/E
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308795476"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="308795476"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:13:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="771658247"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:13:39 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 0/8] mptcp: fixes and enhancements related to path management
Date: Wed,  2 Feb 2022 22:13:23 -0500
Message-Id: <20220203031331.2996457-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains fixes and enhancements related to
path management over MPTCP connections, particularly in support of
out-of-kernel PMs. The changes ensure that the required bits of
information are conveyed through MPTCP netlink events which 
would be consumed by a path manager in making decisions, more
flexibility in establishing paths from either end of an MPTCP
connection, and better handling of listening sockets which serve
in MPJ handshakes.

v1 -> v2:
-fixed formatting
-check_fully_established: check for 3rd ACK retransmission only on passive
side of the MPJ handshake

v2 -> v3:
-subflow_simultaneous_connect: check for active subflow socket
-new helper lsk_list_find_or_create()
-updated mptcp_pm_nl_create_listen_socket() to take struct net* as param
-new addr flag MPTCP_PM_ADDR_FLAG_NO_LISTEN to skip creating a
listening socket in the kernel during an ADD_ADDR request
-reflect the pm.server_side attribute in the MPTCP_EVENT_CREATED
and MPTCP_EVENT_ESTABLISHED events 

v3 -> v4:
-refactor mptcp_pm_add_addr_received() and
mptcp_event_addr_announced() to eliminate a param
-add and use new internal API mptcp_pm_is_kernel() 
-bypass accounting fo non-kernel PM managed connections
-call lsk_list_find() after a failed lsk_list_find_or_create()
for a chance to retrieve a recently created lsk by a simultaneous
call

Kishen Maloor (8):
  mptcp: bypass in-kernel PM restrictions for non-kernel PMs
  mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
  mptcp: reflect remote port (not 0) in ANNOUNCED events
  mptcp: establish subflows from either end of connection
  mptcp: netlink: store per namespace list of refcounted listen socks
  mptcp: netlink: store lsk ref in mptcp_pm_addr_entry
  mptcp: attempt to add listening sockets for announced addrs
  mptcp: expose server_side attribute in MPTCP netlink events

 include/uapi/linux/mptcp.h |   2 +
 net/mptcp/options.c        |   4 +-
 net/mptcp/pm.c             |  12 +-
 net/mptcp/pm_netlink.c     | 222 ++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.c       |   5 +-
 net/mptcp/protocol.h       |  21 +++-
 net/mptcp/subflow.c        |   4 +-
 7 files changed, 228 insertions(+), 42 deletions(-)


base-commit: a6d509111fdeec203af494abc83af6e746d3519f
-- 
2.31.1

