Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B592C9E
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 00:33:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="302742055"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="302742055"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="465835391"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.72.63])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 16:33:28 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v4 3/6] mptcp: Bypass kernel PM when userspace PM is enabled
Date: Wed, 15 Dec 2021 16:33:21 -0800
Message-Id: <20211216003324.403195-4-mathew.j.martineau@linux.intel.com>
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

When a MPTCP connection is managed by a userspace PM, bypass the kernel
PM for incoming advertisements and subflow events. Netlink events are
still sent to userspace.

v2: Remove unneeded check in mptcp_pm_rm_addr_received() (Kishen Maloor)
v3: Add and use helper function for PM mode (Paolo Abeni)

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm.c       | 2 +-
 net/mptcp/protocol.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e72e6010e323..47ac9651e12c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -208,7 +208,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (!READ_ONCE(pm->accept_addr)) {
+	if (!READ_ONCE(pm->accept_addr) || mptcp_pm_is_userspace(msk)) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2fe59769b037..0c680a5177eb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -799,6 +799,11 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 
+static inline bool mptcp_pm_is_userspace(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL;
+}
+
 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
 {
 	u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
-- 
2.34.1

