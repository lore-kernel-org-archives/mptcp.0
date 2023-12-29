Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5D111A4
	for <mptcp@lists.linux.dev>; Fri, 29 Dec 2023 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AvJcfQQa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703854140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i59hKRxb9raxsP0miossJSre0249qr+cHgBrRC814d0=;
	b=AvJcfQQamlLzwXjgVUnvfwq0xI3zOTDPfw6Vx0w7A1Nlq6TTKCSkMSQ8Ikzr0EF1pg92WL
	RElSrN7IRj4Zpv896d4/KRhLXiJ3C/CqbHDTdSUAR2LTZhcvlaOyVYj9ivv5id1+/yo9bv
	ld7VwxMcc63oBPhXqt/iRL5+w30A2lo=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 23/24] mptcp: set error messages for set_flags
Date: Fri, 29 Dec 2023 20:47:41 +0800
Message-Id: <bb12d8e504bc1d5ac9cd47d9a5e25ed086f61c9c.1703853513.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703853512.git.geliang.tang@linux.dev>
References: <cover.1703853512.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In addition to returning the error value, this patch also sets an error
messages with GENL_SET_ERR_MSG or NL_SET_ERR_MSG_ATTR both for pm_netlink.c
and pm_userspace.c.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c   | 6 +++++-
 net/mptcp/pm_userspace.c | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a94e38e01631..5b7f08b9b0f0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1906,8 +1906,10 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
-		if (!addr.addr.id)
+		if (!addr.addr.id) {
+			GENL_SET_ERR_MSG(info, "missing required inputs");
 			return -EOPNOTSUPP;
+		}
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
@@ -1917,11 +1919,13 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
+		GENL_SET_ERR_MSG(info, "address not found");
 		return -EINVAL;
 	}
 	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		spin_unlock_bh(&pernet->lock);
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		return -EINVAL;
 	}
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5a734fa25e8d..b5aa272c83b4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -568,13 +568,17 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	token_val = nla_get_u32(token);
 
 	msk = mptcp_token_get_sock(net, token_val);
-	if (!msk)
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
 		return ret;
+	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk))
+	if (!mptcp_pm_is_userspace(msk)) {
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto set_flags_err;
+	}
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
 	if (ret < 0)
@@ -588,6 +592,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (loc.addr.family == AF_UNSPEC ||
 	    rem.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "address families do not match");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
-- 
2.39.2

