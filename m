Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F052C88
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 04:37:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249476764"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="249476764"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 21:37:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="568443828"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 21:37:16 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: mptcp@lists.linux.dev,
	mathew.j.martineau@linux.intel.com,
	kishen.maloor@intel.com
Subject: [RFC PATCH 0/4] mptcp: Update netlink interface for userspace PM
Date: Thu,  7 Oct 2021 00:36:52 -0400
Message-Id: <20211007043656.261552-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series marks the beginning of an attempt to update the MPTCP
netlink interface with commands to support the offloading of path management 
decisions to userspace path managers.

Specifically, the commits in this series introduce the following commands:

* MPTCP_PM_CMD_ANNOUNCE: Issue an ADD_ADDR advertisement over the selected MPTCP
  connection.

* MPTCP_PM_CMD_REMOVE: Issue a REMOVE_ADDR signal to remove a previously added
  address over the selected MPTCP connection.

Additionally, the PM netlink test controller (pm_nl_ctl) was updated to
support the new commands.

The netlink implementations above exercise the "userspace PM mode" defined
in the following patch series:
https://lore.kernel.org/mptcp/20211006235953.212243-1-mathew.j.martineau@linux.intel.com/T/#t

Kishen Maloor (4):
  mptcp: pm_netlink: Add MPTCP_PM_CMD_ANNOUNCE
  mptcp: selftests: MPTCP_PM_CMD_ANNOUNCE
  mptcp: pm_netlink: Add MPTCP_PM_CMD_REMOVE
  mptcp: selftests: MPTCP_PM_CMD_REMOVE

 include/uapi/linux/mptcp.h                    |   4 +
 net/mptcp/pm_netlink.c                        |  88 +++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 172 ++++++++++++++++++
 3 files changed, 264 insertions(+)

-- 
2.31.1

