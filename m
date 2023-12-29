Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F1D111A1
	for <mptcp@lists.linux.dev>; Fri, 29 Dec 2023 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n70NB4tb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703854138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DxATTz4z9a6GtSma8pChuUL2/QUZmYn207gZ35d1ww=;
	b=n70NB4tbWZS9CZGRtiXCEU3EZF2MAaqZbalw2+GcpY1AEFBTMPo1W8P3jKHs5j1UCgJkZZ
	Um5xSg0NCHkv6BS9mGgE5VlBZ8IS+ih+onqvWC1+XC+LZhjMX8MEPKNhUxfn3mjHsfEX6H
	F97Up6beeCOWYKSMH7cyBaCte59e2mk=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 22/24] mptcp: update set_flags interfaces
Date: Fri, 29 Dec 2023 20:47:40 +0800
Message-Id: <4233ba38d2ff068c3dfbc531948023319c89332c.1703853513.git.geliang.tang@linux.dev>
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

This patch updates set_flags interfaces, make it more similar to the
interfaces of dump_addr and get_addr:

 mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/pm.c           | 11 ++++----
 net/mptcp/pm_netlink.c   | 58 +++++++++++++++++-----------------------
 net/mptcp/pm_userspace.c | 34 ++++++++++++++++++-----
 net/mptcp/protocol.h     | 10 +++----
 4 files changed, 60 insertions(+), 53 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 86cd65dd94df..4ee742831918 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -459,13 +459,12 @@ int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 	return mptcp_pm_nl_dump_addr(msg, cb);
 }
 
-int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
-		       struct mptcp_pm_addr_entry *loc,
-		       struct mptcp_pm_addr_entry *rem, u8 bkup)
+int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
-	if (token)
-		return mptcp_userspace_pm_set_flags(net, token, loc, rem, bkup);
-	return mptcp_pm_nl_set_flags(net, loc, bkup);
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_set_flags(skb, info);
+
+	return mptcp_pm_nl_set_flags(skb, info);
 }
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index cbf5c8dcf167..a94e38e01631 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1885,66 +1885,58 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8 bkup)
+int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
+	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
+	struct net *net = sock_net(skb->sk);
 	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
 	u8 lookup_by_id = 0;
+	u8 bkup = 0;
+	int ret;
+
+	pernet = pm_nl_get_pernet(net);
+
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		return ret;
 
-	if (addr->addr.family == AF_UNSPEC) {
+	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
-		if (!addr->addr.id)
+		if (!addr.addr.id)
 			return -EOPNOTSUPP;
 	}
 
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+		bkup = 1;
+
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
-	if ((addr->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
 
-	changed = (addr->flags ^ entry->flags) & mask;
-	entry->flags = (entry->flags & ~mask) | (addr->flags & mask);
-	*addr = *entry;
+	changed = (addr.flags ^ entry->flags) & mask;
+	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
+	addr = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &addr->addr, bkup, changed);
+	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
 	return 0;
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry remote = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct net *net = sock_net(skb->sk);
-	u8 bkup = 0;
-	int ret;
-
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
-	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &remote);
-		if (ret < 0)
-			return ret;
-	}
-
-	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
-		bkup = 1;
-
-	return mptcp_pm_set_flags(net, token, &addr, &remote, bkup);
+	return mptcp_pm_set_flags(skb, info);
 }
 
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d3ebc0992c9a..5a734fa25e8d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -551,14 +551,19 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
-				 struct mptcp_pm_addr_entry *loc,
-				 struct mptcp_pm_addr_entry *rem, u8 bkup)
+int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
+	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct net *net = sock_net(skb->sk);
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
 	u32 token_val;
+	u8 bkup = 0;
 
 	token_val = nla_get_u32(token);
 
@@ -571,12 +576,27 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	if (!mptcp_pm_is_userspace(msk))
 		goto set_flags_err;
 
-	if (loc->addr.family == AF_UNSPEC ||
-	    rem->addr.family == AF_UNSPEC)
+	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
+	if (ret < 0)
+		return ret;
+
+	if (attr_rem) {
+		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (loc.addr.family == AF_UNSPEC ||
+	    rem.addr.family == AF_UNSPEC) {
+		ret = -EINVAL;
 		goto set_flags_err;
+	}
+
+	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+		bkup = 1;
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
 	release_sock(sk);
 
 set_flags_err:
@@ -666,7 +686,7 @@ int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 		return ret;
 	}
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr, NULL);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f6f592971936..89c2ff0f4b6b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -933,13 +933,9 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex);
-int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
-		       struct mptcp_pm_addr_entry *loc,
-		       struct mptcp_pm_addr_entry *rem, u8 bkup);
-int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8 bkup);
-int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
-				 struct mptcp_pm_addr_entry *loc,
-				 struct mptcp_pm_addr_entry *rem, u8 bkup);
+int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.39.2

