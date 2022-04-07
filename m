Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1F180
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 02:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649299367; x=1680835367;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KkWgLVVcTO5nctNModK3CWprp4y3xZpe06I0tbzUthQ=;
  b=H+aEr7fKY82LEgu0bhDKIbtQCtiAClqBpcWnBN6GEerrGJoZSFg+2F32
   XijiywVkeTwfpzOg0wQhPlLrop2FOuC6EpAzHVMHiohMBnRh2i7+CRzBo
   ynn6Aza0Z7OCIyZcBbWOCWkMwgUGYfcNJQlW3KpNPJ7Bb08ehiV8KMClB
   E78+UXMzida6trRG3yHQc0acx1GJsOCgz5VZRPucHtPp9D8xNYf0wd1vN
   PqhK7scYPUIuPQ1N6QgivFp7JEcHphH1H5ANSSckusWh720sO2GJ9gh7e
   6de8qiliKPWusoPcPDrJtOawBHnWy2bulNaF0re/z8nlYD1SuixnaPHSn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="286189739"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="286189739"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:42:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="658882181"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 19:42:46 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v7 00/14] mptcp: APIs and self-tests for userspace path management
Date: Wed,  6 Apr 2022 22:42:27 -0400
Message-Id: <20220407024241.1757334-1-kishen.maloor@intel.com>
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
 net/mptcp/pm_userspace.c                      | 411 ++++++++++
 net/mptcp/protocol.c                          |   1 +
 net/mptcp/protocol.h                          |  39 +-
 net/mptcp/subflow.c                           |   2 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 645 ++++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 771 ++++++++++++++++++
 10 files changed, 1985 insertions(+), 63 deletions(-)
 create mode 100644 net/mptcp/pm_userspace.c
 create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh


base-commit: 812de90f114c9234a4ebc80058e71250e552ce5f
--
2.31.1
