Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399EB2C9D
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858051; x=1675394051;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2buBXhR4Ro8geKj4XAO3QBaDltv0nT7jDIACqpLzAZQ=;
  b=QKX7n9hzIMUqTddJFikkmKakLkeiGag8nPg36FFjoqx1lvm6jjqMUojZ
   AZrKow5nW2DaDvP6NwIMAH7fKEOqekDzZgTav2l3DV6XVoXnwTEuZiGFL
   3Xjk5//CPVHAozr/RuzkFcnI5mJD1uA8bJVKs0ktq/gbCf/+Sfamt1Mbo
   ZyQeYCO1mH0jnFG6iUyGsXQr8BVrAOo0+aIz/ixZwQK303bsvzzBdw3G/
   PpMDCLhYLWOUqVhHhB3tohlfT1nnbrHaXKB0SnE2qsEJvT8odvInMPWZE
   9p60LUBLKIWEHTPS1TskVAWCKM/W2dMSc0Q5auCfcbGLgxrydwQ5rWF5u
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235467495"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="235467495"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:14:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="631204615"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:14:09 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 00/13] mptcp: APIs and self-tests for userspace path management
Date: Wed,  2 Feb 2022 22:13:50 -0500
Message-Id: <20220203031403.2996549-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series brings together the base functionality
and new netlink APIs for flexible path management from userspace.
It further extends the MPTCP self-testing framework to support the new
netlink APIs along with the ability to capture MPTCP netlink events
to aid in functional/behavioral validations. Lastly, it adds a new
self-testing script with a suite of test cases covering the entire
range of the new userspace path management capabilities.

Note: This patch series depends on the prior series "mptcp: fixes and
enhancements related to path management".

v1 -> v2:
-fixed build error when IPv6 is not enabled

v2 -> v3:
-verify expected value of the server_side attribute in MPTCP connection
events in the self-testing script
-incorporate new addr flag MPTCP_PM_ADDR_FLAG_NO_LISTEN and helper
lsk_list_find_or_create() in MPTCP_PM_CMD_ANNOUNCE
-added descriptive remarks throughout the self-testing script
(userspace_pm.sh)

v3 -> v4:
-use the sock option memory buffer to store/limit local addrs
populated by userspace PMs
-call lsk_list_find() after a failed lsk_list_find_or_create()
in MPTCP_PM_CMD_ANNOUNCE for a chance to retrieve a recently
created lsk by a simultaneous call
-removed whitespace, reduced line lengths in userspace_pm.sh

Florian Westphal (2):
  mptcp: netlink: split mptcp_pm_parse_addr into two functions
  mptcp: netlink: allow userspace-driven subflow establishment

Kishen Maloor (11):
  mptcp: allow ADD_ADDR reissuance by userspace PMs
  mptcp: handle local addrs announced by userspace PMs
  mptcp: read attributes of addr entries managed by userspace PMs
  mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
  mptcp: selftests: support MPTCP_PM_CMD_ANNOUNCE
  mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
  mptcp: selftests: support MPTCP_PM_CMD_REMOVE
  mptcp: selftests: support MPTCP_PM_CMD_SUBFLOW_CREATE
  mptcp: selftests: support MPTCP_PM_CMD_SUBFLOW_DESTROY
  mptcp: selftests: capture netlink events
  selftests: mptcp: functional tests for the userspace PM type

 include/uapi/linux/mptcp.h                    |   7 +
 net/mptcp/pm_netlink.c                        | 620 ++++++++++++++--
 net/mptcp/protocol.c                          |   2 +
 net/mptcp/protocol.h                          |   4 +-
 net/mptcp/subflow.c                           |   2 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 598 ++++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 687 ++++++++++++++++++
 7 files changed, 1855 insertions(+), 65 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh

-- 
2.31.1

