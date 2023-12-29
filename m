Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E598C111A1
	for <mptcp@lists.linux.dev>; Fri, 29 Dec 2023 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GPvNq0z0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703854134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y3hR6uaX++P0llC8ADN+iL1rjjyN/eb2lJZcBcEAMQ=;
	b=GPvNq0z03M48ezxIHdgTkTIYPDXJYOk1H7v/69nIqOcqTvQMefr4olJ5IL/IHIdcCPKyjg
	jnzNcgHy4CyrdawD/Jqi24B6GWsuYvL2quTTL5J0ghz69nuj+qe9ziii85Bk9elb4entI1
	HvjNOdgA5C/e3nDJebIYzbYtOEjYdWw=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 19/24] mptcp: get addr in userspace pm list
Date: Fri, 29 Dec 2023 20:47:37 +0800
Message-Id: <60e112aa3860633cb2cd28b9916fc119a07f25a3.1703853513.git.geliang.tang@linux.dev>
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

This patch renames mptcp_pm_nl_get_addr_doit() as a dedicated in-kernel
netlink PM get addr function mptcp_pm_nl_get_addr(). and invoke a new
wrapper mptcp_pm_get_addr() in mptcp_pm_nl_get_addr_doit.

If a token is gotten in the wrapper, that means a userspace PM is used.
So invoke mptcp_userspace_pm_get_addr() to get addr in userspace PM list.
Otherwise, invoke mptcp_pm_nl_get_addr().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm.c         | 8 ++++++++
 net/mptcp/pm_netlink.c | 7 ++++++-
 net/mptcp/protocol.h   | 2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a251487d3315..86cd65dd94df 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -441,6 +441,14 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 }
 
+int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_get_addr(skb, info);
+
+	return mptcp_pm_nl_get_addr(skb, info);
+}
+
 int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0a9826be3593..cbf5c8dcf167 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1667,7 +1667,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1717,6 +1717,11 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_get_addr(skb, info);
+}
+
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c560c310d7a6..f6f592971936 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1034,6 +1034,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
+int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info);
 
-- 
2.39.2

