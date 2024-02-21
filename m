Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305953C1D
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497085; cv=none; b=AbQLYu/tnK9d0JMOrZo94WABlcatjk5W4Fn9NYD3tls3I8qqvwryEx25RDGx+NakdPlA3lsoC0UEGeFLjTSeHfEtTnCLMJp9ardBcY3P+pfW/UH7qVcHI0RJkVwFDsmDR8tldoTRS5HQqCAC72lP1K+n8xo8uRl5Lw2nJbMaX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497085; c=relaxed/simple;
	bh=fAy7vYN6t5YdsccNbCCfIufVORVxTGBp+1/VDFrXN3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gp7voHfasmBgkt17XbaZMF4DKAS2681UKTC3I3QfRjMWrcm6/r5SqieBeJSu1SQcFlaRZ6loV6WlIRxWRT2R126C4rV3JrArI0Eh91lCrHwo53H1q7n/Q/Uv3SonSKpXg55dIS8DtJpUkfPOPqJiWpaW1IGgUt+PnlZEeXc9hBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cdof4yxg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cdof4yxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC7CC43390;
	Wed, 21 Feb 2024 06:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708497084;
	bh=fAy7vYN6t5YdsccNbCCfIufVORVxTGBp+1/VDFrXN3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cdof4yxgDrGhAGTWfsPOYzenCQwKM+NgB8yI5hqRnZHCG2fSLCC85o7UBvj3Py0cg
	 Xb2py2rGbegOiUPJzKCvsTn3zzncMI6kYpIdXKNlDatBE1vZsMJZgBwynnz1VQ7tsD
	 KFIPfxxY9oBufIXwj4/sPkvU1u9aQ7GG6lmblRaxi1y/LSbCQon2wkualeZ2fJTQQ7
	 tQjLMspYXG0roVK9wAn8lYbhE/ZScwOQxg626+NP7LMg4yiNnQBedx+xf3gNKR574J
	 EUlXa3RL7r3JNA1x0teBhL5tZwwXrrub+Q8iEEuYFr47mwmNH39Q8xuIMMk5lvaOvJ
	 IkfBkrIBfFFYA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/8] mptcp: update set_flags interfaces
Date: Wed, 21 Feb 2024 14:31:10 +0800
Message-Id: <1acc9b6a34e0e29732ed291250556eb147d72541.1708497039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708497039.git.tanggeliang@kylinos.cn>
References: <cover.1708497039.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch updates set_flags interfaces, make it more similar to the
interfaces of dump_addr and get_addr:

 mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 10 +++----
 net/mptcp/pm_netlink.c   | 58 +++++++++++++++++-----------------------
 net/mptcp/pm_userspace.c | 32 +++++++++++++++++-----
 net/mptcp/protocol.h     | 10 +++----
 4 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 28e5d514bf20..55406720c607 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -456,13 +456,11 @@ int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
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
+	return mptcp_pm_nl_set_flags(skb, info);
 }
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a900df9f173d..c799fe84dfd3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1887,66 +1887,58 @@ static int mptcp_nl_set_flags(struct net *net,
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
index b9809d988693..7ef3b69852f0 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -546,14 +546,19 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
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
 
@@ -566,12 +571,27 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	if (!mptcp_pm_is_userspace(msk))
 		goto set_flags_err;
 
-	if (loc->addr.family == AF_UNSPEC ||
-	    rem->addr.family == AF_UNSPEC)
+	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
+	if (ret < 0)
+		goto set_flags_err;
+
+	if (attr_rem) {
+		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+		if (ret < 0)
+			goto set_flags_err;
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 746d0d1f94ec..7905783c95e4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -975,13 +975,9 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
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
2.40.1

