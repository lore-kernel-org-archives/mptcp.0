Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32A3D6B
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 23:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647472603; x=1679008603;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iHzQhwb1Xs1/mYJwfGskzpz5Y+EdCdnhJbu2rfVuycw=;
  b=SpZ3rxpZa1YvPkNHy5qBzBzG1dn7Qu4mXrVaa/n7ObPEU0DwLHo5x0nm
   VQUiayFvp9BZRnkKwQihzNh2Ss2j5YAD7TQGcOUIEohbhBMduO4eemAgZ
   P+3uWcZbH2trd8u4mUFU9wUVsKn6Vpml7puNTfD/r75k/TKrgNTdipP2J
   Y3M0WrcNjVMH2K1Ksw62pFzE7zoQPDZUvspv6hkcJdSV8BbyGaEH681uy
   SKtS+XbIp1i3Tz1kG6p9j8xkXWKAkDqhFx9hz4W10cMcLdCI0ZB735aC/
   Cr7eg18xAxuu5q6x00xTXbfh/NzVP5gc+Zm+Cj64wQ+Y/gIqFGxQr+exV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317453504"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317453504"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:16:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="613813289"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:16:42 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v5 00/14] mptcp: APIs and self-tests for userspace path management
Date: Wed, 16 Mar 2022 19:16:22 -0400
Message-Id: <20220316231636.645625-1-kishen.maloor@intel.com>
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
 net/mptcp/pm_netlink.c                        | 567 +++++++++++--
 net/mptcp/protocol.c                          |   2 +
 net/mptcp/protocol.h                          |   5 +-
 net/mptcp/subflow.c                           |   2 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 645 ++++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 771 ++++++++++++++++++
 7 files changed, 1936 insertions(+), 63 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh


base-commit: 2a9f09777d24fc18cc62762b398054d3961ad8bf
prerequisite-patch-id: 20845587057b7bd3f8726eef5a28578d5f01634b
prerequisite-patch-id: 4b1b25e0f761f6adf36c3d270faf86723019c2b4
prerequisite-patch-id: d226de51a08a67605829c0b9425348cdff5a8699
prerequisite-patch-id: 60e0fae2bad56928af787f76cfbf80a6e4a0f790
prerequisite-patch-id: a347386be396a7513fa37db5655441d459230ac6
--
2.31.1
