Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034710ED
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650428729; x=1681964729;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=r8oISTE1yPoUIpDSwXE9J8a4R8amCYca23/2wVOMr4c=;
  b=VyH/zWlt4u85Gx7ouju/J3m0j6XoDZaY95zecx58kgPthT42bD8fq1Gl
   18+9ggkOMCrOvznVS1ujqGrHBmMqBqwK142snPBjM7CEQbjqO0TGxiRW8
   MpTyVHio7pH0a5T7CsfbyuQVdm935c/S0uCIjP434GlAMGdKwIDsmER+b
   6V2xyUZv3v6ouy2/TGeyF4BAVzjXEHKmZmnDBHbmoFhbn65R1x197gz0E
   ZeDUAcQ+p4/EojIP6exVHrqawxoLNaiXKYVGdLithTWl8CQE14mFBnGZO
   uZx92G4OJ30iCUSaZ7VZ80d9siArEQdn7p1Uhkdx3oLR+tR+w9hyA8nXq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="251242271"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="251242271"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 21:25:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="529584150"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 21:25:28 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 2/3] Squash-to: mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
Date: Wed, 20 Apr 2022 00:25:23 -0400
Message-Id: <20220420042524.2268380-3-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220420042524.2268380-1-kishen.maloor@intel.com>
References: <20220420042524.2268380-1-kishen.maloor@intel.com>
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
index a2de579ebd6d..bd8b692c60c4 100644
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

