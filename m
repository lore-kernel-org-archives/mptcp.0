Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F67125B6
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n9EJ7v3W"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702891530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9YhqeR0jXsf88rmbsJtmwXf+/JD9Gcu+n14D4b1+jg=;
	b=n9EJ7v3WDi/q46gF46E4IIcA/SiDMjjqrhUfpNEBeBDnugrt3RkMVk6E9BrjC+oRzNNO5g
	Nr94CIptF8qPs9yYS36ioJjiDkCOOCfp+uBMV+qq2z8MN840TJd3SJ/my7ZNu7yjbIZAxo
	eBvRDPIe21bHgabfrm449scfH470MWc=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v2 13/15] mptcp: get addr in userspace pm list
Date: Mon, 18 Dec 2023 17:23:42 +0800
Message-Id: <836d60383d7989a23b0252a9d2f81f0cb36591b3.1702891194.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702891194.git.geliang.tang@linux.dev>
References: <cover.1702891194.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If a token is gotten in mptcp_pm_nl_get_addr_doit(), that means a userspace
PM is used. Invoke mptcp_userspace_pm_get_addr() to get addr in userspace
PM list.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ebc9841224a7..cd99c0e5281f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1715,14 +1715,20 @@ int mptcp_pm_nl_put_entry_msg(struct sk_buff *msg,
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
+	struct net *net = sock_net(skb->sk);
 	int ret;
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
+	if (token)
+		return mptcp_userspace_pm_get_addr(net, info, nla_get_u32(token),
+						   addr.addr.id);
+
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
 	if (!entry) {
-- 
2.35.3

