Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2168
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 01:47:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="237609790"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="237609790"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 17:47:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="463602364"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.17.231])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 17:47:16 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v3 3/6] mptcp: Bypass kernel PM when userspace PM is enabled
Date: Mon, 13 Dec 2021 17:46:44 -0800
Message-Id: <20211214014647.136505-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214014647.136505-1-mathew.j.martineau@linux.intel.com>
References: <20211214014647.136505-1-mathew.j.martineau@linux.intel.com>
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
index 053afb058440..cff0d9585ab4 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -189,7 +189,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (!READ_ONCE(pm->accept_addr)) {
+	if (!READ_ONCE(pm->accept_addr) || mptcp_pm_is_userspace(msk)) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 478abe18b9e9..9e84a46f3d87 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -798,6 +798,11 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
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

