Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF42CA8
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643330324; x=1674866324;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cYeX4s+nxyI9LTlzy6F5vVs2+ZHT91AU5jh/Uoo/C5I=;
  b=MzR8h9ZknljFsHdPCNvs1XeMHC6/MgJe6tFaciBL4L8J/XHKJSOX/pko
   k7qKFpGY2Mvb0itVpXFu6lVkAswyOQlGymJVdaJIcP4gAAZpceuET6IrY
   0aOebeiVb++lZEv11jBq86yS5m8fE6FxWtmPooXHT5pZaCJ8/lukaNtUN
   sn8akiCnYasx6UtXhHfTwBQ2Q0q4aBXCwthCXXJt0Qr9RUydTryymAgfz
   Pa6BbsrBYou9ClI39BN6/toplepN+EoTq1aNw8U+3z9peoGZDUvgCQhur
   BKJM/UwKQZ14anPewYA1qTJyIRowMIJYQyPf8bSp7BvmmKQlCjXyd4uZ6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="245846914"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="245846914"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="564000997"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:38:20 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v3 3/8] mptcp: reflect remote port (not 0) in ANNOUNCED events
Date: Thu, 27 Jan 2022 19:38:07 -0500
Message-Id: <20220128003812.2732609-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220128003812.2732609-1-kishen.maloor@intel.com>
References: <20220128003812.2732609-1-kishen.maloor@intel.com>
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
 net/mptcp/options.c    | 2 +-
 net/mptcp/pm.c         | 5 +++--
 net/mptcp/pm_netlink.c | 8 ++++++--
 net/mptcp/protocol.h   | 6 ++++--
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0d0d2eb8c8ca..0d3c8f7e5be6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1132,7 +1132,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
 		    add_addr_hmac_valid(msk, &mp_opt)) {
 			if (!mp_opt.echo) {
-				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
+				mptcp_pm_add_addr_received(msk, &mp_opt.addr, sk);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6b6220895929..e5d5cb847209 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -200,14 +200,15 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 }
 
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+				const struct mptcp_addr_info *addr,
+				const struct sock *ssk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
 
 	pr_debug("msk=%p remote_id=%d accept=%d", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
 
-	mptcp_event_addr_announced(msk, addr);
+	mptcp_event_addr_announced(msk, addr, ssk);
 
 	spin_lock_bh(&pm->lock);
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 93800f32fcb6..f90e77c3775d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1972,7 +1972,8 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
 }
 
 void mptcp_event_addr_announced(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *info)
+				const struct mptcp_addr_info *info,
+				const struct sock *ssk)
 {
 	struct net *net = sock_net((const struct sock *)msk);
 	struct nlmsghdr *nlh;
@@ -1996,7 +1997,10 @@ void mptcp_event_addr_announced(const struct mptcp_sock *msk,
 	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, info->id))
 		goto nla_put_failure;
 
-	if (nla_put_be16(skb, MPTCP_ATTR_DPORT, info->port))
+	if (nla_put_be16(skb, MPTCP_ATTR_DPORT,
+			 info->port  == 0 ?
+			 ((struct inet_sock *)inet_sk(ssk))->inet_dport :
+			 info->port))
 		goto nla_put_failure;
 
 	switch (info->family) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c47d69a42fcb..d20c65fcba89 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -753,7 +753,8 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 				 const struct mptcp_subflow_context *subflow);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
+				const struct mptcp_addr_info *addr,
+				const struct sock *ssk);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
@@ -781,7 +782,8 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct mptcp_addr_info *info);
+void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct mptcp_addr_info *info,
+				const struct sock *ssk);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
-- 
2.31.1

