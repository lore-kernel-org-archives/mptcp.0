Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F19E2CAF
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330325; x=1674866325;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tLKe7aItYw+feBkxTepmu5DXMedE21AX0I7KY2D/WOQ=;
  b=mNLu/RpBPhWKaF95w8qCiIow2b4JYWSPZAdYGpV7EMe+9rtCeGP+/iuv
   yycsUIfy1QHjj7k3F3TVEbrKGEM8rSBFELLha9BEtV4En5jzE2rW3e3rv
   OfPjppuloVP9yEtsZ4FE9WfthNvepYEJAe9CnbjsUammrUvk4vcJa+ZQd
   jQXE6IJP50OJZpus6hHA7pOw9C7KCv2ebxHgSIC4ONcWamHd3xtd/L+JU
   q1WKKkvFsLavy0OpEjtjqHYTtKZpT8Pc3KEM8K/VcYCXaCgYCGX76SV68
   hg8jlxo/q9/ftmgx2gsfDKdJjewSrmYVTsxar7/ntOWa4gNF2Htd5G/PK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333358329"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="333358329"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="480527103"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:41 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 00/14] mptcp: APIs and self-tests for userspace path management
Date: Thu, 27 Jan 2022 19:38:22 -0500
Message-Id: <20220128003836.2732694-1-kishen.maloor@intel.com>
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
-new sysctl configurable param net.mptcp.userspace_pm_local_addr_max
to control/bound userspace PM activity
-new test case to verify that net.mptcp.userspace_pm_local_addr_max is
enforced by the kernel
-verify expected value of the server_side attribute in MPTCP connection
events in the self-testing script
-incorporate new addr flag MPTCP_PM_ADDR_FLAG_NO_LISTEN and helper
lsk_list_find_or_create() in MPTCP_PM_CMD_ANNOUNCE
-added descriptive remarks throughout the self-testing script
(userspace_pm.sh)

Florian Westphal (2):
  mptcp: netlink: split mptcp_pm_parse_addr into two functions
  mptcp: netlink: allow userspace-driven subflow establishment

Kishen Maloor (12):
  mptcp: add sysctl param to limit userspace PM activity
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
 net/mptcp/ctrl.c                              |  17 +
 net/mptcp/pm.c                                |   4 +-
 net/mptcp/pm_netlink.c                        | 637 +++++++++++++++--
 net/mptcp/protocol.c                          |   2 +
 net/mptcp/protocol.h                          |   5 +-
 net/mptcp/subflow.c                           |   2 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 598 +++++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 656 ++++++++++++++++++
 9 files changed, 1862 insertions(+), 66 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh

-- 
2.31.1

