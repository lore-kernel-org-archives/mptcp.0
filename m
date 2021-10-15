Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A932C81
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 23:06:22 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="291483044"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="291483044"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:06:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="528398896"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.195.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:06:21 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 0/3] mptcp: A few fixes
Date: Fri, 15 Oct 2021 16:05:49 -0700
Message-Id: <20211015230552.24119-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set has three separate changes for the net-next tree:

Patch 1 guarantees safe handling and a warning if a NULL value is
encountered when gathering subflow data for the MPTCP_SUBFLOW_ADDRS
socket option.

Patch 2 increases the default number of subflows allowed per MPTCP
connection.

Patch 3 makes an existing function 'static'.


Mat Martineau (1):
  mptcp: Make mptcp_pm_nl_mp_prio_send_ack() static

Paolo Abeni (1):
  mptcp: increase default max additional subflows to 2

Tim Gardner (1):
  mptcp: Avoid NULL dereference in mptcp_getsockopt_subflow_addrs()

 net/mptcp/pm_netlink.c                          | 9 ++++++---
 net/mptcp/protocol.h                            | 3 ---
 net/mptcp/sockopt.c                             | 3 +++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 ++++-
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 +++---
 5 files changed, 16 insertions(+), 10 deletions(-)


base-commit: 295711fa8fec42a55623bf6997d05a21d7855132
-- 
2.33.1

