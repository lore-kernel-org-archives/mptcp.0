Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157CD8F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558358; cv=none; b=pr9d5wqu21YYr3ZKwuWWeaGnLBi6Ljf2wjllUg5dVmSXlc8CTJcTOFMGI54H8bbt0wmZLwFzFznHTFVK+CcVLrxhDwSmJt8yGJeL20dwo7gmVj32fUZMjv2JeE2joYtqoeigzzOuTAeMm+RUDpi6vbqAmXNn2gBEmzb7bI3ZOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558358; c=relaxed/simple;
	bh=1Ihzeopex0iYiWPTgu5kJ0PUnFWIJMnTfQqWnFITcJY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=KEqEIToSD4rO8s1caP0n7CSQ/odc4JegTEm3Siob9WwKm7U4SQyEF2kXTZfkUWHj66kC49a5bk3XGp0E572Z99F7oRUi4e1fFUtHRwldeFJTD4M4KSBGcNl7GFBpdBsVkCTUzFWC1LZTJhow+sNGyupsrQYUNxH3qBpQrnuh6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdObgcu0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdObgcu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A85C433A6;
	Thu, 18 Jan 2024 06:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558357;
	bh=1Ihzeopex0iYiWPTgu5kJ0PUnFWIJMnTfQqWnFITcJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SdObgcu0vYcg8nk8wzDPkhnkg4tCPAxQ3Fmtdw2KBorpCCxTWKAAywkr0J+rZI1fD
	 Mm3qhIZrsxB0L6pb127qLRO+7gZV1xJk0N1jyWk9EfZ/SWWSToF4QbT/SDfiJnT7nK
	 zUdkJFXEZbxSmxqQsBgJywFWryZdZhqrMJxMf2L9l5EsZaDCIlq0AAmyp67ZIeEV/f
	 1k0g/qaoUDt/wJDud0ZVcy/2CKEZi2Wqp+I3PBxngRqbQqiGZC3Em1FAC+GJ/v9SEh
	 ljhV6udc1fsk5D97FuYfokp+evRTOfSfDwVvUnwojfk9+HB61ljXzJtOucvLe5FvQ3
	 higBGyJlHPsCA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 21/23] mptcp: update set_flags interfaces
Date: Thu, 18 Jan 2024 14:12:01 +0800
Message-Id: <2eeb7d8c80850814335a00331820619ac925f64d.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
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
index d05c2c221932..30cedafb009e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -457,13 +457,11 @@ int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
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
index c227c8909cd3..6e913498ff79 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1875,66 +1875,58 @@ static int mptcp_nl_set_flags(struct net *net,
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
index 96620038a4e9..bb5672a4332e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -549,14 +549,19 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
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
 
@@ -569,12 +574,27 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
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
index a11d1a98beca..cd193737b369 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -936,13 +936,9 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
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

