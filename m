Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21B33EB
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649374836; x=1680910836;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PzeQs5O1G2LV5GamG58nv5ashwlOUEpuHZh46M5MTmI=;
  b=mZ5nYeVHPULYh0gFOSlzJZv1FEX3omD23IVfzKUgMxWkRCopQX55IchM
   L5FQGOuqH19lVeYmmOTuU3gGU9EYsWRigybnnU9/UKGpNoBkEjnALGDmt
   7+rrHC0jFcGrsw+OEzNnGVOJeuijV3j4PwjL5KJpv/FJPaTqfckDVVor3
   jjc7W7JCtNjqEjAeNr2eyrqRWJotPA4r3zZpigkD4UgjdVkA5cpeEQrHB
   0FGejtNEM6Bi2hVIsG0epbSg7B9MqYGHshdyzK45lSCQs3QGr01in/vWo
   yLhb+oK2K4odfQIH3/4WxzYEaC3wR32o2g8tmX2PcVAHsSShhgIsvueYz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="259062007"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="259062007"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 16:40:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571270935"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 16:40:35 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 00/14] mptcp: APIs and self-tests for userspace path management
Date: Thu,  7 Apr 2022 19:40:15 -0400
Message-Id: <20220407234029.1774481-1-kishen.maloor@intel.com>
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
Further it extends the MPTCP self-testing framework to support the new
netlink APIs along with the ability to capture MPTCP netlink events
to aid in functional/behavioral validations. Lastly, it adds a
self-testing script with a suite of test cases covering the entire
range of the new userspace path management capabilities.

Note: This series depends on the prior patchset "mptcp: fixes and
enhancements related to path management".

v5:
-Primary change over v4 is the reliance on userspace
managed listener sockets for receiving MPJ requests.
-Addressed CI reported issues.

v6:
-Put all distinct userspace PM related code into a separate compilation
unit: pm_userspace.c.
-Made a few internal helpers non-static (now declared in protocol.h) to
facilitate the above change.
-Use the pm spinlock instead of mptcp_data_lock() to synchronize
access to the per-msk local_addr_list.

v7:
-Move userspace PM specific handling from pm_netlink
into mptcp_userspace_pm_get_local_id()
and mptcp_userspace_pm_get_flags_and_ifindex_by_id() in pm_userspace.

v8:
-Add copyright notice to pm_userspace.c.

Florian Westphal (2):
  mptcp: netlink: split mptcp_pm_parse_addr into two functions
  mptcp: netlink: allow userspace-driven subflow establishment

Kishen Maloor (12):
  mptcp: allow ADD_ADDR reissuance by userspace PMs
  mptcp: handle local addrs announced by userspace PMs
  mptcp: read attributes of addr entries managed by userspace PMs
  mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
  selftests: mptcp: support MPTCP_PM_CMD_ANNOUNCE
  mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
  selftests: mptcp: support MPTCP_PM_CMD_REMOVE
  selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_CREATE
  selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_DESTROY
  selftests: mptcp: capture netlink events
  selftests: mptcp: create listeners to receive MPJs
  selftests: mptcp: functional tests for the userspace PM type

 include/uapi/linux/mptcp.h                    |   7 +
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/pm.c                                |   1 +
 net/mptcp/pm_netlink.c                        | 169 ++--
 net/mptcp/pm_userspace.c                      | 415 ++++++++++
 net/mptcp/protocol.c                          |   1 +
 net/mptcp/protocol.h                          |  39 +-
 net/mptcp/subflow.c                           |   2 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 645 ++++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 771 ++++++++++++++++++
 10 files changed, 1989 insertions(+), 63 deletions(-)
 create mode 100644 net/mptcp/pm_userspace.c
 create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh


base-commit: 812de90f114c9234a4ebc80058e71250e552ce5f
--
2.31.1
