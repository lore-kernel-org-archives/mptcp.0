Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441556FD3
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AIozkQdg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705376155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hik0ejV+SZ3gmoM9qQe8kG3SCBAFKDhWiurUkQVUtb0=;
	b=AIozkQdg82w9JTEeTYDyzmCYxxVWoVmYs9mq5oCcVZl+NC6C9SGgAVX/15kYr4OyTwylDO
	3Ke968n+JnzHKfVMNs+DsXWsMeJDHq6lpHDqe6TNl1PqaHoQCpPxkpEGSOtnm4YjZCSXGH
	iuq9tZBP9/VLZhYXSaXDwr1zqf51nz4=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 22/23] mptcp: set error messages for set_flags
Date: Tue, 16 Jan 2024 11:35:10 +0800
Message-Id: <c807fad8aca7af2c8d46a687a15298e42689753c.1705375746.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1705375746.git.tanggeliang@kylinos.cn>
References: <cover.1705375746.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <tanggeliang@kylinos.cn>

In addition to returning the error value, this patch also sets an error
messages with GENL_SET_ERR_MSG or NL_SET_ERR_MSG_ATTR both for pm_netlink.c
and pm_userspace.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 6 +++++-
 net/mptcp/pm_userspace.c | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6e913498ff79..4ab68f83ddd5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1896,8 +1896,10 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
-		if (!addr.addr.id)
+		if (!addr.addr.id) {
+			GENL_SET_ERR_MSG(info, "missing required inputs");
 			return -EOPNOTSUPP;
+		}
 	}
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
@@ -1907,11 +1909,13 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
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
index a6b2273a170d..97f5aadfbdab 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -566,13 +566,17 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
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
@@ -586,6 +590,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (loc.addr.family == AF_UNSPEC ||
 	    rem.addr.family == AF_UNSPEC) {
+		GENL_SET_ERR_MSG(info, "address families do not match");
 		ret = -EINVAL;
 		goto set_flags_err;
 	}
-- 
2.40.1

