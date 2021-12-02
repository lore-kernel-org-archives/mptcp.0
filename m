Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4FB2CA2
	for <mptcp@lists.linux.dev>; Thu,  2 Dec 2021 00:52:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="322841465"
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="322841465"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:52:22 -0800
X-IronPort-AV: E=Sophos;i="5.87,280,1631602800"; 
   d="scan'208";a="677471784"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.83.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:52:21 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 2/6] mptcp: Add a member to mptcp_pm_data to track kernel vs userspace mode
Date: Wed,  1 Dec 2021 16:52:12 -0800
Message-Id: <20211202005216.154787-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com>
References: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com>
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
 net/mptcp/pm.c       | 4 ++++
 net/mptcp/protocol.h | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4b79b73aee3c..053afb058440 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -373,6 +373,10 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	pm->subflows = 0;
 	pm->rm_list_tx.nr = 0;
 	pm->rm_list_rx.nr = 0;
+	WRITE_ONCE(pm->pm_type, MPTCP_PM_TYPE_KERNEL);
+	/* pm->work_pending must be only be set to 'true' when
+	 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
+	 */
 	WRITE_ONCE(pm->work_pending,
 		   (!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed) ||
 		   !!mptcp_pm_get_add_addr_signal_max(msk));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 50175e4cbcb8..478abe18b9e9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -177,6 +177,14 @@ enum mptcp_pm_status {
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 };
 
+enum mptcp_pm_type {
+	MPTCP_PM_TYPE_KERNEL = 0,
+	MPTCP_PM_TYPE_USERSPACE,
+
+	__MPTCP_PM_TYPE_NR,
+	__MPTCP_PM_TYPE_MAX = __MPTCP_PM_TYPE_NR - 1,
+};
+
 enum mptcp_addr_signal_status {
 	MPTCP_ADD_ADDR_SIGNAL,
 	MPTCP_ADD_ADDR_ECHO,
@@ -199,6 +207,7 @@ struct mptcp_pm_data {
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
+	u8		pm_type;
 	u8		subflows;
 	u8		status;
 	struct mptcp_rm_list rm_list_tx;
-- 
2.34.1

