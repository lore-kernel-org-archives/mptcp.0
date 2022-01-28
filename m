Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8262C9D
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330319; x=1674866319;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ca0M0+gODoceeWxxdvHzBrnyGxNDLhhrtZLca9Uhaho=;
  b=T0lUaEQAjl28rNReX+u9PbTCdZ2b6LKlwCT7fG0QvrXud96+abVh6W7h
   Jt5U3ZFZvicfNc/qaKogs4IMqIrZvF5KLwchuT1AHenJBxenwWvfXSQfK
   Aav8ixkSa7pe3jlP3v8LhlRk6XVhOFd2ZQUMJ2juaS2ra3l+XHOSFmQYb
   70mk7F8CJpWW5+Whjv1T9HrbEcYo+Atn8Dr9vFHB16CmPFKWVFe1VL/gh
   CD93fF9f08+steu8EXwP1GT8gWf5YPfG+QgS73e9tAkSi9M8Zx6C/Qyhi
   xmXdQc14o0SrWJA8RKv1OkLPfnRfA4y2QW4I6/nNM577WaUxO1ptnhowj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245846913"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="245846913"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="564000975"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:19 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 0/8] mptcp: fixes and enhancements related to path management
Date: Thu, 27 Jan 2022 19:38:04 -0500
Message-Id: <20220128003812.2732609-1-kishen.maloor@intel.com>
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

Kishen Maloor (8):
  mptcp: do not restrict subflows with non-kernel PMs
  mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
  mptcp: reflect remote port (not 0) in ANNOUNCED events
  mptcp: establish subflows from either end of connection
  mptcp: netlink: store per namespace list of refcounted listen socks
  mptcp: netlink: store lsk ref in mptcp_pm_addr_entry
  mptcp: attempt to add listening sockets for announced addrs
  mptcp: expose server_side attribute in MPTCP netlink events

 include/uapi/linux/mptcp.h |   2 +
 net/mptcp/options.c        |   4 +-
 net/mptcp/pm.c             |   8 +-
 net/mptcp/pm_netlink.c     | 210 ++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.c       |   5 +-
 net/mptcp/protocol.h       |  14 ++-
 net/mptcp/subflow.c        |   4 +-
 7 files changed, 209 insertions(+), 38 deletions(-)


base-commit: 05854a699d27b11d8fb3217ec2e0dbf28ecb58e8
-- 
2.31.1

