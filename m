Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C022F21
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 07:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643873114; x=1675409114;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UvXw2MIvV8O99Sc83n2n9LbbQDWhcJp/7ZDpUuTlO94=;
  b=LqtAEWjgBASRdZiuR12WdrcC7Q84qz6QsJKwdWX+vBToUx6S2C48UDMp
   fiz75W0/s6qtEsSMNgWhnO6E2itnovKT7qL6lZhwkJzPnFFRAHD+KAZ/1
   QiFkOiexLc/0whXj+/h9RuX6hZu1/PkgE14ROyhewH0PdlKeQG1bWV4KU
   mpxe2cx94+T1PzQbj6XWhgreK+T4z/3JvxWi/XDNm9B2lQq1toJaYy0tN
   zsv5WUMe4ZS5SAxxCLcfzvH+stVBUSmlAYRdmtmV/dzPZt4l6XEZGgOf1
   x1jNcgoBkBS31Q/0U0gpOTbM8mObMFD9nziEYB5rnRryeinEzsZ92WCCB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272580768"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="272580768"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="535118710"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 23:25:13 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 0/8] mptcp: fixes and enhancements related to path management
Date: Thu,  3 Feb 2022 02:25:00 -0500
Message-Id: <20220203072508.3072309-1-kishen.maloor@intel.com>
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

v4 -> v5:
-Fixed error: implicit declaration of function
'mptcp_pm_nl_create_listen_socket'

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

