Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FEE10ED
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650428732; x=1681964732;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Bt4QjmiuKZPElaIRgLgCFqXGO4QGOA+unANuA78WkZc=;
  b=bl4rFlzF2vlQgG0IK4tYWNxOJ5tZGrLyeqMRhaky6tPFg/ksnkjCj9AK
   F/xHdpXkYplnTGqdrpDenCzuxhTauf9tRyRLx7/J0WirIxzxIJ4u17Oxl
   QMU1Ui7pVmWVgJU+dvTftbyaCFAwquXwszebQ+FXSS3tpiRzCTjIie4Al
   tWs2lbqyrjss//S5zhjOs3KsW16ZetPtSKSdKvfBmH0ldGGQIfwX3G4Oj
   JgnAYNioX9yC4VsnbSJjkOt/+2WCgQmnXN2nK5SJrPScZ7ZCx0dd6rK4M
   VdxF0QqO6rZsAWqCNqr0866qTWkUdfNGDReEBpXCQJrWtjQj5GcN3qT20
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="251242270"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="251242270"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 21:25:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="529584147"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 21:25:28 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 1/3] Squash-to: mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
Date: Wed, 20 Apr 2022 00:25:22 -0400
Message-Id: <20220420042524.2268380-2-kishen.maloor@intel.com>
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
 net/mptcp/pm_userspace.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index fce61530fe9e..a2de579ebd6d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -126,12 +126,12 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
+	int err = -EINVAL;
 	u32 token_val;
-	int err;
 
 	if (!addr || !token) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
-		return -EINVAL;
+		return err;
 	}
 
 	token_val = nla_get_u32(token);
@@ -139,29 +139,29 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	msk = mptcp_token_get_sock(sock_net(skb->sk), token_val);
 	if (!msk) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
-		return -EINVAL;
+		return err;
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		return -EINVAL;
+		goto announce_err;
 	}
 
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
-		return err;
+		goto announce_err;
 	}
 
 	if (addr_val.addr.id == 0 || !(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		GENL_SET_ERR_MSG(info, "invalid addr id or flags");
-		return -EINVAL;
+		goto announce_err;
 	}
 
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
-		return err;
+		goto announce_err;
 	}
 
 	lock_sock((struct sock *)msk);
@@ -175,7 +175,10 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock((struct sock *)msk);
 
-	return 0;
+	err = 0;
+ announce_err:
+	sock_put((struct sock *)msk);
+	return err;
 }
 
 int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
-- 
2.31.1

