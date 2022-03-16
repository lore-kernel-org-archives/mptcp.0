Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532138F5
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 19:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647457682; x=1678993682;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=4rzgiyjsRNZjnsz0tdhwvs1W07Pt9Oew4Wz1QZQ9D+Q=;
  b=UcmEELk5m/OuWktwxlmwobhHn4ma0HJtyDcHle5oFpVkfRr+RrJ5vcmQ
   FIrsot71AUPOQyGyMf4/R7PhmSZ/29jJYDtOHg+1kNH/fdMHqoE+IkIVH
   zCCCVLStGnKZlDhKFEUQZzOTwykmimwHUq89TL4fPRWQrS8QvSipNx7iM
   MJMAGvI9QpEUAYUXEW80+xgEtoEfavyQ1nvTLXA+NgmKYtTAyFXm2LvM3
   VNJhneoRJQ96UBwBm6dt7L+gO1fwqkaVueU/2+bR83miaIKZ8iLfepSTN
   +eh9IcfGPPGlofqxmHjgSAD4rk7TcfGiUDHVbebLnzzogrenan2ecFNRs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="255521711"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="255521711"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:07:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="644799812"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:07:58 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/5] mptcp: reflect remote port (not 0) in ANNOUNCED events
Date: Wed, 16 Mar 2022 15:07:45 -0400
Message-Id: <20220316190747.634325-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220316190747.634325-1-kishen.maloor@intel.com>
References: <20220316190747.634325-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per RFC 8684, if no port is specified in an ADD_ADDR message, MPTCP
SHOULD attempt to connect to the specified address on the same port
as the port that is already in use by the subflow on which the
ADD_ADDR signal was sent.

To facilitate that, this change reflects the specific remote port in
use by that subflow in MPTCP_EVENT_ANNOUNCED events.

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/options.c    |  2 +-
 net/mptcp/pm.c         |  6 ++++--
 net/mptcp/pm_netlink.c | 11 ++++++++---
 net/mptcp/protocol.h   |  4 ++--
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 88f4ebbd6515..c9625fea3ef9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1133,7 +1133,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
 		    add_addr_hmac_valid(msk, &mp_opt)) {
 			if (!mp_opt.echo) {
-				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
+				mptcp_pm_add_addr_received(sk, &mp_opt.addr);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 32a9bcc4b9be..4573dab87c9e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -203,15 +203,17 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
+void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_pm_data *pm = &msk->pm;
 
 	pr_debug("msk=%p remote_id=%d accept=%d", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
 
-	mptcp_event_addr_announced(msk, addr);
+	mptcp_event_addr_announced(ssk, addr);
 
 	spin_lock_bh(&pm->lock);
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4f09eb97faff..905f451ff0f9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2008,10 +2008,12 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
 	kfree_skb(skb);
 }
 
-void mptcp_event_addr_announced(const struct mptcp_sock *msk,
+void mptcp_event_addr_announced(const struct sock *ssk,
 				const struct mptcp_addr_info *info)
 {
-	struct net *net = sock_net((const struct sock *)msk);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	struct net *net = sock_net(ssk);
 	struct nlmsghdr *nlh;
 	struct sk_buff *skb;
 
@@ -2033,7 +2035,10 @@ void mptcp_event_addr_announced(const struct mptcp_sock *msk,
 	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, info->id))
 		goto nla_put_failure;
 
-	if (nla_put_be16(skb, MPTCP_ATTR_DPORT, info->port))
+	if (nla_put_be16(skb, MPTCP_ATTR_DPORT,
+			 info->port == 0 ?
+			 ((struct inet_sock *)inet_sk(ssk))->inet_dport :
+			 info->port))
 		goto nla_put_failure;
 
 	switch (info->family) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1d8c58fb8cdc..3e5c8d5273a9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -750,7 +750,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 				 const struct mptcp_subflow_context *subflow);
-void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
+void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
@@ -779,7 +779,7 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct mptcp_addr_info *info);
+void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 bool mptcp_userspace_pm_active(struct net *net);
 
-- 
2.31.1

