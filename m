Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2BA2C9E
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 00:33:44 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="236907556"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="236907556"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="465835388"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.72.63])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:28 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v4 0/6] mptcp: Add userspace PM mode to bypass kernel PM
Date: Wed, 15 Dec 2021 16:33:18 -0800
Message-Id: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One part of supporting userspace path managers is to prevent the
in-kernel PM from acting on userspace-managed MPTCP connections.

These patches:

 * Add a per-MPTCP-socket 'pm_type'. A mix of kernel-managed and
   userspace-managed connections are supported within each namespace.

 * Conditionally decouple incoming ADD_ADDR/RM_ADDR and subflow changes
   from the in-kernel PM. Netlink events are still triggered, and ADD_ADDR
   echo handling is still in kernel code even if path management is
   otherwise handled in userspace.

 * Add a sysctl for setting the per-namespace default for in-kernel vs
   userspace path management of new MPTCP sockets. This is an integer
   value to allow extensibility.

 * Add selftests to confirm that the in-kernel PM is bypassed.

RFC -> v1: Changed sysctl from a bool to an integer, added patch 1
(cleanup) and patch 6 (selftests), fixed ADD_ADDR echo and initial
pm->subflows_allowed settings.

v1 -> v2: Rebased on latest export branch, removed extra kernel-mode
check when receiving ADD_ADDR, and fix !CONFIG_SYSCTL build.

v2 -> v3: Rebased on latest export branch, use helper function for PM
mode, clarify initialization logic for userspace vs. kernel PM,
add a Tested-by tag from v2 review.

v3 -> v4: Rebased on latest export branch and resolved conflicts

Mat Martineau (6):
  mptcp: Remove redundant assignments in path manager init
  mptcp: Add a member to mptcp_pm_data to track kernel vs userspace mode
  mptcp: Bypass kernel PM when userspace PM is enabled
  mptcp: Make kernel path manager check for userspace-managed sockets
  mptcp: Add a per-namespace sysctl to set the default path manager type
  selftests: mptcp: Add tests for userspace PM type

 Documentation/networking/mptcp-sysctl.rst     | 18 +++++
 net/mptcp/ctrl.c                              | 21 ++++++
 net/mptcp/pm.c                                | 50 +++++++++----
 net/mptcp/pm_netlink.c                        | 30 ++++----
 net/mptcp/protocol.h                          | 16 ++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 70 ++++++++++++++++++-
 6 files changed, 170 insertions(+), 35 deletions(-)


base-commit: 81706660508b6caa94d0fbeb8875882f155c73a9
-- 
2.34.1

