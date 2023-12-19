Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1E11725
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bcJxjOGe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702974044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rJ8+ohgW9OuaEtFrHx3ROOmIHU6wZv+xOE5wlpTBPY=;
	b=bcJxjOGe5aDJyvrVzZf84RUuOlvZf31zTc6rBmFphP2d3+Knjcb2Oj/YSSuN+MW+/LAudA
	Q+519xFMfd+OB7QGHcQoFBhGbJETKoajt3ohDLqpF2FyDtX/N/NbkEXI7ww/OdR/W5fWv5
	Ok15T+x0b79uV1MVqIT5TpZuhghSbrw=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v3 12/14] mptcp: get addr in userspace pm list
Date: Tue, 19 Dec 2023 16:19:23 +0800
Message-Id: <a96eb45c03124dbf62c7fb95338eddf877a49b80.1702973751.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702973751.git.geliang.tang@linux.dev>
References: <cover.1702973751.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch renames mptcp_pm_nl_get_addr_doit() to in-kernel netlink
PM get addr function mptcp_pm_nl_get_addr(). If a token is gotten in
mptcp_pm_nl_get_addr_doit(), that means a userspace PM is used. So
invoke mptcp_userspace_pm_get_addr() to get addr in userspace PM list.
Otherwise, invoke mptcp_pm_nl_get_addr().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 812dc719269a..41a22301608b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1650,7 +1650,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1700,6 +1700,13 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_get_addr(skb, info);
+	return mptcp_pm_nl_get_addr(skb, info);
+}
+
 static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb)
 {
-- 
2.35.3

