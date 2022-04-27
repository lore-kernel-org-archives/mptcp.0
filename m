Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33DC7FA
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 22:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651099813; x=1682635813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNRuKBjmjxVENqUvRRSu2j5me55152i5hjFEZKIzhrg=;
  b=gNkrCdnayeOhdTD3p17Uft3oE5tVbrNHXODqi3pu0tgKIGyQej7Uhc8I
   S856IZ1QbcplLLTBctJ34Zd3ZK5X2281FV6+O+AlGVEhbUuBxGHjC5Lmp
   VV/KiOgWebjFpY9Z7Cim5gy+/WtWbmBBUHlEEsNCmD+hnqyYfrHL2fUwT
   ni/URbZVga6bd1xiQsG9U9sI2f3kpDYJM6VeXxgLupbFl1mkGRp0johq5
   xu5fLWvcZJAJbJ0KwMnKNKBSOSc2AZ6xW4OnkmHOZErFWbfgONqvv+Iqt
   D53j1EpXoTJZ7NVMHGsxOsQBX9lnoZWWsZS5N/NuDmIS3TLC1ElxKDwQT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="291252890"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="291252890"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 15:50:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="731049116"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.233.139])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 15:50:10 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next 2/6] mptcp: Add a member to mptcp_pm_data to track kernel vs userspace mode
Date: Wed, 27 Apr 2022 15:49:58 -0700
Message-Id: <20220427225002.231996-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427225002.231996-1-mathew.j.martineau@linux.intel.com>
References: <20220427225002.231996-1-mathew.j.martineau@linux.intel.com>
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

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c       | 4 ++++
 net/mptcp/protocol.h | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4de90e618be3..f9f1bf4be95e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -424,6 +424,10 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
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
index 0316605de559..f65395f04f81 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -184,6 +184,14 @@ enum mptcp_pm_status {
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
 
@@ -212,6 +220,7 @@ struct mptcp_pm_data {
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
+	u8		pm_type;
 	u8		subflows;
 	u8		status;
 	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-- 
2.36.0

