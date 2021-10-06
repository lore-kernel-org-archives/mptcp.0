Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525A2C95
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 00:00:06 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226439231"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="226439231"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="560351271"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.0.106])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:58 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	kishen.maloor@intel.com
Subject: [RFC PATCH 0/6] mptcp: Add userspace PM mode to bypass kernel PM
Date: Wed,  6 Oct 2021 16:59:47 -0700
Message-Id: <20211006235953.212243-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
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

 * Add a per-MPTCP-socket 'userspace' bool to track which PM type is in
   use for that socket. A mix of kernel-managed and userspace-managed
   connections are supported within each namespace.

 * Conditionally decouple incoming ADD_ADDR/RM_ADDR and subflow changes
   from the in-kernel PM. Netlink events are still triggered.

 * Add a sysctl for setting the per-namespace default for in-kernel vs
   userspace path management of new MPTCP sockets. This might be better
   handled with a new netlink command to get/set the default, but I've
   included this commit so we can discuss the best approach!

 * Some debug code to confirm that the in-kernel PM is not interfering
   with userspace-managed sockets. Some of these warnings (perhaps
   changed to debug messages?) may be good to permanently include, but
   are labeled "DO-NOT-MERGE" for now.


I've confirmed that mptcp_join.sh selftests fail as they should with the
in-kernel PM disconnected, but do not run into the warnings I
added. These are RFC patches so testing continues.

Kishen has some netlink command patches to follow. We're also working on
mptcpd changes (https://github.com/intel/mptcpd/pull/156) to interact
with the upstream kernel, but still have to resolve some differences
relative to the multipath-tcp.org implementation of the netlink commands.


Mat Martineau (6):
  mptcp: Add a member to mptcp_pm_data to track kernel vs userspace mode
  mptcp: Bypass kernel PM when userspace PM is enabled
  mptcp: Make kernel path manager check for userspace-managed sockets
  mptcp: Add a per-namespace sysctl to set the default path manager type
  DO-NOT-MERGE: debug: mptcp: Warn on use of in-kernel PM functions
  DO-NOT-MERGE: debug: mptcp: Warn on unexpected events when userspace
    PM is active

 Documentation/networking/mptcp-sysctl.rst | 17 ++++++
 net/mptcp/ctrl.c                          | 16 ++++++
 net/mptcp/pm.c                            | 16 +++++-
 net/mptcp/pm_netlink.c                    | 70 +++++++++++++++++++----
 net/mptcp/protocol.h                      |  2 +
 5 files changed, 108 insertions(+), 13 deletions(-)

-- 
2.33.0

