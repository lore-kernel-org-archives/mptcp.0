Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4A2C83
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 01:30:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="231577912"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="231577912"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 17:30:14 -0800
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="568294743"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.27.251])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 17:30:14 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 2/6] mptcp: Add a member to mptcp_pm_data to track kernel vs userspace mode
Date: Wed, 17 Nov 2021 17:30:01 -0800
Message-Id: <20211118013005.263660-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211118013005.263660-1-mathew.j.martineau@linux.intel.com>
References: <20211118013005.263660-1-mathew.j.martineau@linux.intel.com>
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
index 467fbb2a4eba..3a3800771aca 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -373,6 +373,10 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
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
index 092cb77a64d8..edaf0cc75474 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -178,6 +178,14 @@ enum mptcp_pm_status {
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
@@ -200,6 +208,7 @@ struct mptcp_pm_data {
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
+	u8		pm_type;
 	u8		subflows;
 	u8		status;
 	struct mptcp_rm_list rm_list_tx;
-- 
2.34.0

