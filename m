Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB52CA1
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 22:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642025771; x=1673561771;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nRVymqImLVZUnWJH/FWCAR9ITX7opML5AleHBZilvmc=;
  b=d86+UgV/J7AQ/FBDbvJSyrvufHLCuC1j0JykVj5M+eMc5oY7WxfqJPaf
   vlmJ1s+xy/Je3rg2ZHL/PU7UsrAc/P9faIae3s46//Mc/ccYID6dFNtoI
   f5YoqVf5xqvdQu5TMIZuSFLRmlAi9XPMwd9dLuQ/ZFfp59VZtaSaq/leP
   Sbyp40EyUl5GlFOkJfWFMvPb4/l8ALv5xlmP/jzDgVJ5t1JFNcOr46C7Z
   y954I7syeCpbAm6u5mlmjN17YVIhQNowCxxx2gGMTE7WOunZz3cH8UqyR
   JCom1vlrIu/MiXXXbyjb6KBzYWruTVKILl98kZ3gsmskAhjHzYrb0xWeP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307213930"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307213930"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="490907336"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:16:07 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 03/21] mptcp: reflect remote port (not 0) in ANNOUNCED events
Date: Wed, 12 Jan 2022 17:15:05 -0500
Message-Id: <20220112221523.1829397-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220112221523.1829397-1-kishen.maloor@intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
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
index 7a6a39b71633..cceba8c7806d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1123,7 +1123,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
 		    add_addr_hmac_valid(msk, &mp_opt)) {
 			if (!mp_opt.echo) {
-				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
+				mptcp_pm_add_addr_received(msk, &mp_opt.addr, sk);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5f35fe8a5e82..db889ff60326 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -204,14 +204,15 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
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
index f12effa71942..fc07ab9a53ba 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1933,7 +1933,8 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
 }
 
 void mptcp_event_addr_announced(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *info)
+				const struct mptcp_addr_info *info,
+				const struct sock *ssk)
 {
 	struct net *net = sock_net((const struct sock *)msk);
 	struct nlmsghdr *nlh;
@@ -1957,7 +1958,10 @@ void mptcp_event_addr_announced(const struct mptcp_sock *msk,
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
index d1b46c0d8c40..e2a67d3469f6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -752,7 +752,8 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 				 const struct mptcp_subflow_context *subflow);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
+				const struct mptcp_addr_info *addr,
+				const struct sock *ssk);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
@@ -780,7 +781,8 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct mptcp_addr_info *info);
+void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct mptcp_addr_info *info,
+				const struct sock *ssk);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
-- 
2.31.1

