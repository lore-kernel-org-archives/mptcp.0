Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E98622
	for <mptcp@lists.linux.dev>; Sat,  9 Apr 2022 01:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649468320; x=1681004320;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l01KeKvxRI97YWsjvyhA/BTMNn/PPGrSYcAgqRSCZKc=;
  b=WwJ+5BgJd13xIyWe/OKtpP2XgL6vryY4fk65BsCoCar8QqHyjgOLTvyH
   SvbgJTgEDAY+s0dGutRxd5sFU31un8mOa3foMhuSZY/j23Ob/+EHYuESG
   BDOEw04UMkKxwX42MKxP4c37Hk2VtTQsjRrqQLnHiRHecLU1aEfd0gRrP
   53XH/Nt8+XzIRkr9fkgVzUEzyTPoGzIIdF7YUv/tJ9YC/JWnQOU5E60AY
   3Gbdr6FxNv43AmRwurIOqFoopgbFA/xjwZFHNAjdZD2u7AAqwvYOwaCWH
   6uPOHis/uc68hsRMjlDpU/eN6uBCQhjQXK0qkT613sSqeE0VWzyoKRklk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261921142"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="261921142"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:38:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="698436064"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:38:29 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 00/14] mptcp: APIs and self-tests for userspace path management
Date: Fri,  8 Apr 2022 21:38:11 -0400
Message-Id: <20220409013825.1877395-1-kishen.maloor@intel.com>
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

v9:
-userspace_pm.sh: Mitigate possible buffering issues with CI.

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
 .../selftests/net/mptcp/userspace_pm.sh       | 781 ++++++++++++++++++
 10 files changed, 1999 insertions(+), 63 deletions(-)
 create mode 100644 net/mptcp/pm_userspace.c
 create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh


base-commit: 812de90f114c9234a4ebc80058e71250e552ce5f
--
2.31.1
