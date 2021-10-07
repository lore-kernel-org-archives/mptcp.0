Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902A2C81
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 00:06:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="223525413"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="223525413"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 17:06:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="484311700"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.0.106])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 17:06:46 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next] mptcp: Make mptcp_pm_nl_mp_prio_send_ack() static
Date: Wed,  6 Oct 2021 17:06:45 -0700
Message-Id: <20211007000645.213221-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is only used within pm_netlink.c now.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 6 +++---
 net/mptcp/protocol.h   | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 050eea231528..30b974801d51 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -654,9 +654,9 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 	}
 }
 
-int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
-				 struct mptcp_addr_info *addr,
-				 u8 bkup)
+static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
+					struct mptcp_addr_info *addr,
+					u8 bkup)
 {
 	struct mptcp_subflow_context *subflow;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7379ab580a7e..284fdcec067e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -736,9 +736,6 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
-int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
-				 struct mptcp_addr_info *addr,
-				 u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
-- 
2.33.0

