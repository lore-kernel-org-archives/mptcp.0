Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24929360
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 02:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651631948; x=1683167948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vsnw+ionwlQ/bLcjkhtG/wrtlCAeyvXE0/2zswBqgx0=;
  b=Xq0rnVLn3K4MJyINf89ATcXK+gi7l5Khp8xyypNGWLYxH3EYNROltbab
   LJTES2n7M0hvc+7dlvhRr00GdXoLgcj0wuhfEygYqTaPZgqFLdz/jhdN5
   F6WEj/GWce44gEpJJgQDgeDhS2i5hV7sNPV1mZ48kUkhzrQNWWx/nrAeI
   W3OwzGVNA4DUhJXkTJfhzIHK7PEW1xd3t8v07tbqBE/LJPzaAnGm5usCT
   PVY1kzf195jDrqrnaoVOIBzHFrl/mSxGMHs6nfJC5WPUtFmkbD7h1ct3I
   Zcx2LKQC+G72YX+Cn1+Hx9UUjVRwztDmeK2IZjlkI/yVgl7xCIdIWRjuI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="266488751"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="266488751"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 19:39:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="584493362"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.20.240])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 19:39:07 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 00/13] mptcp: Userspace path manager API
Date: Tue,  3 May 2022 19:38:48 -0700
Message-Id: <20220504023901.277012-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace path managers (PMs) make use of generic netlink MPTCP events
and commands to control addition and removal of MPTCP subflows on an
existing MPTCP connection. The path manager events have already been
upstream for a while, and this patch series adds four netlink commands
for userspace:

* MPTCP_PM_CMD_ANNOUNCE: advertise an address that's available for 
additional subflow connections.

* MPTCP_PM_CMD_REMOVE: revoke an advertisement

* MPTCP_PM_CMD_SUBFLOW_CREATE: initiate a new subflow on an existing MPTCP 
connection

* MPTCP_PM_CMD_SUBFLOW_DESTROY: close a subflow on an existing MPTCP 
connection

Userspace path managers, such as mptcpd, can be more easily customized
for different devices. The in-kernel path manager remains available to
handle server use cases.


Patches 1-3 update common path manager code (used by both in-kernel and
userspace PMs)

Patches 4, 6, and 8 implement the new generic netlink commands.

Patches 5, 7, and 9-13 add self test support and test cases for the new
path manager commands.


Florian Westphal (2):
  mptcp: netlink: split mptcp_pm_parse_addr into two functions
  mptcp: netlink: allow userspace-driven subflow establishment

Kishen Maloor (11):
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
 net/mptcp/pm_netlink.c                        | 157 ++--
 net/mptcp/pm_userspace.c                      | 429 ++++++++++
 net/mptcp/protocol.c                          |   1 +
 net/mptcp/protocol.h                          |  37 +-
 net/mptcp/subflow.c                           |   2 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 645 ++++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 779 ++++++++++++++++++
 10 files changed, 1999 insertions(+), 61 deletions(-)
 create mode 100644 net/mptcp/pm_userspace.c
 create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh


base-commit: f43f0cd2d9b07caf38d744701b0b54d4244da8cc
-- 
2.36.0

