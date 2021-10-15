Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711E2C81
	for <mptcp@lists.linux.dev>; Fri, 15 Oct 2021 23:06:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="291483049"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="291483049"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:06:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="528398901"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.195.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:06:22 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	geliangtang@gmail.com
Subject: [PATCH net-next 3/3] mptcp: Make mptcp_pm_nl_mp_prio_send_ack() static
Date: Fri, 15 Oct 2021 16:05:52 -0700
Message-Id: <20211015230552.24119-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211015230552.24119-1-mathew.j.martineau@linux.intel.com>
References: <20211015230552.24119-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is only used within pm_netlink.c now.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 6 +++---
 net/mptcp/protocol.h   | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f7d33a9abd57..7b96be1e9f14 100644
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
2.33.1

