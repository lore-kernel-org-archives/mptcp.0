Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F92C9E
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 00:33:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="236907563"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="236907563"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="465835390"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.72.63])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:28 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v4 2/6] mptcp: Add a member to mptcp_pm_data to track kernel vs userspace mode
Date: Wed, 15 Dec 2021 16:33:20 -0800
Message-Id: <20211216003324.403195-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
References: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
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
index 49402556b4ec..e72e6010e323 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -392,6 +392,10 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
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
index b22370878c86..2fe59769b037 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -180,6 +180,14 @@ enum mptcp_pm_status {
 					 */
 };
 
+enum mptcp_pm_type {
+	MPTCP_PM_TYPE_KERNEL = 0,
+	MPTCP_PM_TYPE_USERSPACE,
+
+	__MPTCP_PM_TYPE_NR,
+	__MPTCP_PM_TYPE_MAX = __MPTCP_PM_TYPE_NR - 1,
+};
+
 /* Status bits below MPTCP_PM_ALREADY_ESTABLISHED need pm worker actions */
 #define MPTCP_PM_WORK_MASK ((1 << MPTCP_PM_ALREADY_ESTABLISHED) - 1)
 
@@ -208,6 +216,7 @@ struct mptcp_pm_data {
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
+	u8		pm_type;
 	u8		subflows;
 	u8		status;
 	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-- 
2.34.1

