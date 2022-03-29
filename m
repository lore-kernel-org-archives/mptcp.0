Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31D20E5
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 02:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648520082; x=1680056082;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B+RDrgz+1DeDqxoI3YNa9orOMYrPd+ZRaRDOk5fY6Aw=;
  b=Tu7lQUkASsydJNs+ix9u40ZaZg/svEThvERWl3jLyGK6Qg6ZGS0XdvZ1
   wwQ4EoZf5qKZSv3QgnrUXWqPiylbcMTtiESagwWuCzBrId5+3P774B+WJ
   aLmhL4LVRDdAGQgvvdfuKbvxhmWu887BQ1SRDAl/AtDCNJ4l+gbduh/tX
   RyYG8sy8OFt4ozKZhoorPdZGRToZg55YYV5G5hoa/oqaZLjIw8v0Y8dt7
   +3zYJkloWau4THJw8+kTWKXqZoh/iKBRbjiN1Kah+K0f3woH/DnQCJzIJ
   zBYzyMYUWojVgqfJOcKnUzzTsGP/yXgtHvuIY8/H1j2KLKVYzn+5cUs2S
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="284037573"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="284037573"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564202874"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:41 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v6 00/14] mptcp: APIs and self-tests for userspace path management
Date: Mon, 28 Mar 2022 22:14:23 -0400
Message-Id: <20220329021437.1196552-1-kishen.maloor@intel.com>
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
 net/mptcp/pm_netlink.c                        | 249 ++++--
 net/mptcp/pm_userspace.c                      | 368 +++++++++
 net/mptcp/protocol.c                          |   1 +
 net/mptcp/protocol.h                          |  35 +-
 net/mptcp/subflow.c                           |   2 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 645 ++++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 771 ++++++++++++++++++
 10 files changed, 1989 insertions(+), 92 deletions(-)
 create mode 100644 net/mptcp/pm_userspace.c
 create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh


base-commit: 8e1fca01ac83e646133bd647abdae74d6d6449ba
prerequisite-patch-id: ae42506131e46e03f020b722a856ace3304d53cc
prerequisite-patch-id: 5b76b4bf6d57927ad5590a1a9252fafda8d2a71a
prerequisite-patch-id: 4b1b25e0f761f6adf36c3d270faf86723019c2b4
prerequisite-patch-id: f7595549285182f6af1e46cb58e5ec317306a203
prerequisite-patch-id: 60e0fae2bad56928af787f76cfbf80a6e4a0f790
prerequisite-patch-id: a347386be396a7513fa37db5655441d459230ac6
--
2.31.1
