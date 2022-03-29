Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4120E5
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 02:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648520048; x=1680056048;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uBPSYn5PjbwgaUDDVCEqOGJJ7a4v8wXr/zjQ3RDEpC0=;
  b=c3lV5IcPpRo6Uad+k7XWiCwd52+coRl4CPaVhdPxxHg04Ou0sZrW/tO9
   gfX/lxgloW6Hx3mN6eIn0YfwqHxdvJCv+I69fm/nrIyOZeqwdYakYUzZM
   NJxswLy54irWXs2uDi00qFpJgdQC3waH4sBqkpkZ3McFkDL0ewg7ptlmi
   v2z0LxOT5/+YoZFw2iJ30Cw048KI1WiMNOX9Smr+Dv09TRaY1QTxapgIK
   nn0NZRblY3VUYcc7YnlUjdUbTzyUIOyMNkSsjic5jG0CkZRE8G4+HMDkH
   9j4ppWyFaZLU59ezbenwDvVExk2vcGBe93D/qtpMmcadKHmbgfFrP/4Rl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="345578741"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="345578741"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564202536"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:07 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 0/6] mptcp: fixes and enhancements related to path management
Date: Mon, 28 Mar 2022 22:13:55 -0400
Message-Id: <20220329021401.1196466-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series incorporates fixes and enhancements related to
path management over MPTCP connections, particularly in support of
userspace PMs. The changes ensure that the required bits of
information are conveyed through MPTCP netlink events which
would be consumed by the path manager in making its decisions.
Further it adds flexibility in establishing paths and from
both ends of MPTCP connections.

v6:
-Dropped framework and functionality around the use of kernel
listening sockets for receiving MPJs.

v7:
-Fixed bug caught by the CI build.

v8:
-Fixed logic to achieve the desired outcome of not responding to
address advertisements when a userspace PM is offline.
-Factored out minor changes to mptcp_pm_is_userspace() to be
squashed into an earlier commit.

v9:
-Removed an explicit 'struct inet_sock *' cast in a patch which was
not necessary.

Kishen Maloor (6):
  Squash-to: mptcp: Bypass kernel PM when userspace PM is enabled
  mptcp: bypass in-kernel PM restrictions for non-kernel PMs
  mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
  mptcp: reflect remote port (not 0) in ANNOUNCED events
  mptcp: establish subflows from either end of connection
  mptcp: expose server_side attribute in MPTCP netlink events

 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/options.c        |  4 ++--
 net/mptcp/pm.c             | 21 +++++++++++++++++----
 net/mptcp/pm_netlink.c     | 24 +++++++++++++++++++++---
 net/mptcp/protocol.c       |  5 +----
 net/mptcp/protocol.h       | 22 ++++++++++++++++------
 net/mptcp/subflow.c        |  5 ++++-
 7 files changed, 62 insertions(+), 20 deletions(-)


base-commit: 8e1fca01ac83e646133bd647abdae74d6d6449ba
--
2.31.1
