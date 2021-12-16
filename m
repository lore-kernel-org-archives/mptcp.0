Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6762CA7
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 22:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639693453; x=1671229453;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W+oQEPf5k+TCc56ryed3FabOFZCSGj2Us3rFybSBRfg=;
  b=eTkn0NMZoZymIbcoGF3GRbPxgHGgUHbVEPHy8wl7O3p7KbQCDXrhWCBe
   JPqPnathUCqQjrPndB3g4NPLqlt4qdnhSOELXd3k9uC6ulwF6Uhvywz7R
   6RKn1Q3u2gaIV+fHAlSo6Z34UniLsEuQ29meNmlCoTliqhDntJpWwjPb1
   8fjSoVd5X/LonYA+uMc0GF4Mev9sb7aQ0K2cUhs06DpYscOtLIGtOezxu
   QC35xZqKOor5gpK+asx810zMFPFQDD0DV7ddnDwJ+HqA5hoqZHrMFfkEt
   ATbg78oZynB2XpsNryVaX6FJA+/Vv9gY3+EF9YdcJRfLueMqC3rpyj9Zb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="300393154"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="300393154"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="519461220"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:24:10 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 00/21] mptcp: support userspace path management
Date: Thu, 16 Dec 2021 17:22:53 -0500
Message-Id: <20211216222314.1244708-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series brings together all the required changes to
flexibly manage paths/subflows over MPTCP connections
from path manager implementations running in userspace. Path
management decisions may be made on either end of MPTCP
connections based on state captured through MPTCP netlink events.

The series starts with a set of general fixes and enhancements
in the related kernel code. It is followed with base functionality
and new netlink APIs for handling userspace path management. Further,
it extends the MPTCP self-test framework with the new netlink APIs,
along with the ability to capture MPTCP netlink events to aid in 
functional/behavioral validations. Lastly, it adds a new self-test
script with a suite of test cases covering all the userspace path
management capabilities.

Florian Westphal (2):
  mptcp: netlink: split mptcp_pm_parse_addr into two functions
  mptcp: netlink: allow userspace-driven subflow establishment

Kishen Maloor (19):
  mptcp: do not restrict subflows with non-kernel PMs
  mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
  mptcp: reflect remote port (not 0) in ANNOUNCED events
  mptcp: establish subflows from either end of connection
  mptcp: netlink: store per namespace list of refcounted listen socks
  mptcp: netlink: store lsk ref in mptcp_pm_addr_entry
  mptcp: netlink: process IPv6 addrs in creating listening sockets
  mptcp: attempt to add listening sockets for announced addrs
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
 net/mptcp/options.c                           |   5 +-
 net/mptcp/pm.c                                |  12 +-
 net/mptcp/pm_netlink.c                        | 842 ++++++++++++++++--
 net/mptcp/protocol.c                          |   7 +-
 net/mptcp/protocol.h                          |  12 +-
 net/mptcp/subflow.c                           |   6 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 587 +++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 561 ++++++++++++
 9 files changed, 1935 insertions(+), 104 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh


base-commit: f81a8b95bfe9cae8ff02739e3e263d9310422af7
-- 
2.31.1

