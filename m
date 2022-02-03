Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756D2CA1
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 03:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858024; x=1675394024;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=lb+/sjxrVOCu6IaiElGnADZNu5LQc1FIjY+PPW9x2pc=;
  b=D+LE5D633rF7r3Beofjs+6UHdmmvJryeW7TW64VlrvM15ZYZaiVhTQSr
   vpvK+a+7JVfmmb+JuFmNYRtXtxB1qo1WDQ2MrUZAGIYGg6zPQclCTYkCV
   DMeaUl0o62Zo7/eJ7mn8UmRPO8CYZXBmtdyZ9GdYAvbSrMqaaj7n19nCY
   nKwqiJqPYqMKt4OmB8TmynGuiamGHXj5I4X/rn0HzcDOIfD3Qwy/Lha89
   xIqqMylawPamgtug42NRvI/B1G1bNvxvUt2CkKscyj0M5Kile5X4nvx/F
   cJjxz1SEjUWnQ5UqV94Y8I/5SqhS8tQZGiBos6v2nBxTI4Xq1dXU7mg7/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308795479"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="308795479"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:13:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="771658257"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:13:40 -0800
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 3/8] mptcp: reflect remote port (not 0) in ANNOUNCED events
Date: Wed,  2 Feb 2022 22:13:26 -0500
Message-Id: <20220203031331.2996457-4-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220203031331.2996457-1-kishen.maloor@intel.com>
References: <20220203031331.2996457-1-kishen.maloor@intel.com>
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
v4: refactor mptcp_pm_add_addr_received() and
mptcp_event_addr_announced() to eliminate a param
---
 net/mptcp/options.c    |  2 +-
 net/mptcp/pm.c         |  6 ++++--
 net/mptcp/pm_netlink.c | 11 ++++++++---
 net/mptcp/protocol.h   |  4 ++--
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7b615dc10897..6dfaa8e11331 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1131,7 +1131,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
 		    add_addr_hmac_valid(msk, &mp_opt)) {
 			if (!mp_opt.echo) {
-				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
+				mptcp_pm_add_addr_received(sk, &mp_opt.addr);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3e053b759181..94f008b2d624 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -200,15 +200,17 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
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
index bf24c1a74e1d..ff13012178ae 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1974,10 +1974,12 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
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
 
@@ -1999,7 +2001,10 @@ void mptcp_event_addr_announced(const struct mptcp_sock *msk,
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
index ac8b57d4f853..4371ac3fbde1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -751,7 +751,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk);
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
 void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 				 const struct mptcp_subflow_context *subflow);
-void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
+void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      struct mptcp_addr_info *addr);
@@ -780,7 +780,7 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct mptcp_addr_info *info);
+void mptcp_event_addr_announced(const struct sock *ssk, const struct mptcp_addr_info *info);
 void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
-- 
2.31.1

