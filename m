Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6602C81
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 00:00:08 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226439233"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="226439233"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="560351274"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.0.106])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 16:59:58 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	kishen.maloor@intel.com
Subject: [RFC PATCH 1/6] mptcp: Add a member to mptcp_pm_data to track kernel vs userspace mode
Date: Wed,  6 Oct 2021 16:59:48 -0700
Message-Id: <20211006235953.212243-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006235953.212243-1-mathew.j.martineau@linux.intel.com>
References: <20211006235953.212243-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding support for netlink path management commands, the kernel
needs to know whether paths are being controlled by the in-kernel path
manager or a userspace PM.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c       | 1 +
 net/mptcp/protocol.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ab386ff3294..79aafcb51756 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -369,6 +369,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
 	WRITE_ONCE(msk->pm.remote_deny_join_id0, false);
+	WRITE_ONCE(msk->pm.userspace, false);
 	msk->pm.status = 0;
 
 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 284fdcec067e..b06c2307296d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -197,6 +197,7 @@ struct mptcp_pm_data {
 	bool		accept_addr;
 	bool		accept_subflow;
 	bool		remote_deny_join_id0;
+	bool		userspace;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
-- 
2.33.0

