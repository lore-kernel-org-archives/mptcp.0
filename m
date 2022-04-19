Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C51845
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 23:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650409429; x=1681945429;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=pBOeyy2hr87q1cO9BfSp91GRkJyMIhNauZ9qhn+PZqU=;
  b=OywYeVI8x5lIWWCinqO1xacseiimw7sUk20PtDnq2riwSQzzMjK7RYKr
   g87Otwj8r8yk8P/6MmzqIBqjRycrg0WaKnGVhBh2ZVS5y8ft1RXlMr15H
   2FhYpnJ6Zu6nO2grI/BC8cRKYDfESVG6guRn8YsHOCOmIx9s+GgdJgsLg
   pURtthjHgzbLxP1aeg06wmfR13H08W+HZWoEs6l7LPE8WD4PV4/E5gGqp
   4oKdCfVREY2NwwLYGQlEe+KBq0Pb6Bgg6SnBp+7N5VU+nm6oAs28j21PN
   XjEVlw8E8ecSW0ItZABfgY3g2ZfXqFe7ked0VhI3pvqy8AHe+PeAchBA8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263654610"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263654610"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:03:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="625832517"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:03:47 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/3] Squash-to: mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
Date: Tue, 19 Apr 2022 19:03:39 -0400
Message-Id: <20220419230340.2263545-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220419230340.2263545-1-kishen.maloor@intel.com>
References: <20220419230340.2263545-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 net/mptcp/pm_userspace.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index fca3e4bdf5d4..3d8f6126b952 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -189,12 +189,13 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
+	int err = -EINVAL;
 	u32 token_val;
 	u8 id_val;
 
 	if (!id || !token) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
-		return -EINVAL;
+		return err;
 	}
 
 	id_val = nla_get_u8(id);
@@ -203,12 +204,12 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	msk = mptcp_token_get_sock(sock_net(skb->sk), token_val);
 	if (!msk) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
-		return -EINVAL;
+		return err;
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		return -EINVAL;
+		goto remove_err;
 	}
 
 	lock_sock((struct sock *)msk);
@@ -223,7 +224,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock((struct sock *)msk);
-		return -EINVAL;
+		goto remove_err;
 	}
 
 	list_move(&match->list, &free_list);
@@ -235,7 +236,11 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	list_for_each_entry_safe(match, entry, &free_list, list) {
 		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
 	}
-	return 0;
+
+	err = 0;
+ remove_err:
+	sock_put((struct sock *)msk);
+	return err;
 }
 
 int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
-- 
2.31.1

