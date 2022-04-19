Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E652184E
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 23:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650409429; x=1681945429;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=sLb4cwgI+u7R1HcWLkfy6PWHLVUbv4XFwozosD46xqc=;
  b=hKCEgsC6Wfi/7/4ErjfdFU6Dh57EgB1CGNJFL/HE7hrk0wPAZT8CVDPP
   EcXSkR3Og5sdmBR7bhE1yvY7ux+eg1ZA7rTveZFdBpx8p7JiyA2jM3tGr
   sWZMF+A5EiW8e533hFwxB1NO/QTnhKt31q4kooDgURM/unsKLwnwGr7cO
   jSZUYxI6yvzudfWiNRZMrQDxg3pCQlveQeiv6UpWgQpzATrkcg3gYHzNA
   eP/3v8sSfbt7bmkmmMrBygBRfI76FKbkvLO2dWqKfM419zCjMZgTL2jPY
   cuG4yS0Dw0YuYw3NuPvSDSBX6+rozaqnOCmL07DfOWn5L71Ie5zb29zYY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263654609"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263654609"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:03:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="625832514"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:03:46 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/3] Squash-to: mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
Date: Tue, 19 Apr 2022 19:03:38 -0400
Message-Id: <20220419230340.2263545-2-kishen.maloor@intel.com>
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
 net/mptcp/pm_userspace.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index fce61530fe9e..fca3e4bdf5d4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -127,11 +127,11 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
 	u32 token_val;
-	int err;
+	int err = -EINVAL;
 
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

