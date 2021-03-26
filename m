Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92F72
	for <mptcp@lists.linux.dev>; Fri, 26 Mar 2021 18:27:38 +0000 (UTC)
IronPort-SDR: iHtw/oifNe4yULAq39wC1IqygEF7yI6lqfZ0y0/sKzUEFjJdjLEYrEV6FxeDVUw7KMn+XLbtvL
 EMJaoyxhUVQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211365156"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="211365156"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 11:27:36 -0700
IronPort-SDR: ImIQ8jG3nK0NrlpkbBKO6Xm2zYrHupxTSU/7QWQdsRqWPXuIFqVvLnZ2wxVbTIfnbP5y2VVWdy
 DC2qA+Om1CYQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="443456557"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.24.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 11:27:36 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 09/13] mptcp: move to next addr when subflow creation fail
Date: Fri, 26 Mar 2021 11:26:38 -0700
Message-Id: <20210326182642.136419-9-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326182642.136419-1-mathew.j.martineau@linux.intel.com>
References: <20210326182307.136256-1-mathew.j.martineau@linux.intel.com>
 <20210326182642.136419-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

When an invalid address was announced, the subflow couldn't be created
for this address. Therefore mptcp_pm_nl_subflow_established couldn't be
invoked. Then the next addresses in the local address list didn't have a
chance to be announced.

This patch invokes the new function mptcp_pm_add_addr_echoed when the
address is echoed. In it, use mptcp_lookup_anno_list_by_saddr to check
whether this address is in the anno_list. If it is, PM schedules the
status MPTCP_PM_SUBFLOW_ESTABLISHED to invoke
mptcp_pm_create_subflow_or_signal_addr to deal with the next address in
the local address list.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c  |  1 +
 net/mptcp/pm.c       | 15 +++++++++++++++
 net/mptcp/protocol.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2d2340b22f61..69cafaacc31b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1040,6 +1040,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 			mptcp_pm_add_addr_received(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 		} else {
+			mptcp_pm_add_addr_echoed(msk, &addr);
 			mptcp_pm_del_add_timer(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0a06d5947a73..966942d1013f 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -196,6 +196,21 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
+void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_data *pm = &msk->pm;
+
+	pr_debug("msk=%p", msk);
+
+	spin_lock_bh(&pm->lock);
+
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
+
+	spin_unlock_bh(&pm->lock);
+}
+
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 {
 	if (!mptcp_pm_should_add_signal(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9c51444b26cf..b417b3591e07 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -647,6 +647,8 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
+void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
+			      struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
-- 
2.31.0

