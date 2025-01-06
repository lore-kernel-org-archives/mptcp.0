Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599C1D86C0
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151393; cv=none; b=DsyRmGWWbD8Z85REyJQa4iGyYuz10Xj91enWZMe7crmjN6wQ+qKe38+yBUoZcx+pX2wDvTbI2Kg66joMKvRMoW3kUTeoCyCkk9kh0gMY+bRdWO18rjD+GoxNArjF37O/KanrXzD8bVGyPC3KfXJahyIba7RTJgbLkNyHEsYFcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151393; c=relaxed/simple;
	bh=qh9ywY8AX1t6ZlF9ywYACC4CYHUA1cLdPm9NyNy0mH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWVs0H7DuoASlCqQnZ2EfASyX56hemAU4hBQ0ZtE3wZaZhsllZesg8FkjJmKreR1PPcyOqVpebor5eaxxiEeM7G+JQqE+qjweHm8hEDirVsniweXwC0T6k6qWVLQBuwGnQQCQyYeu4tVp+e0x6oD0mqmfK0zlnu3RE58G5i4g58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8h8aD1O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8h8aD1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFBEC4CEE0;
	Mon,  6 Jan 2025 08:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151393;
	bh=qh9ywY8AX1t6ZlF9ywYACC4CYHUA1cLdPm9NyNy0mH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k8h8aD1OBYDRhtCTmST45CKUiarIldfGqV9R1pIsH6gRRS+1NAijLVBLobpFJJMjD
	 I4QLlf0uZS+HN09fQ6nyUaHNEWSilY8Z5+tQmncCsoIa+4FIT47On0ZSUMjo+JciL8
	 1pzXH3RTzJG+rnZrvEHWpY37DBX2a8WPQr9wOGHiQTM+c/ftc5/kLU2YrT3Lbh8m8g
	 V0sXErOaUB2zfn8dwhAnxbsRPzNHZKE1A9w2aWhm91XeGDoX8o3828gqMiZZlu5/bw
	 uwSSDzr75ROHHywXRVvYreaYnrRwyNFiq+HxG7/a6+m+LMzBJRDunJAETe0YiM/ty4
	 RvUHJOVY4mY5A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 05/11] mptcp: add local & remote parameters for set_flags
Date: Mon,  6 Jan 2025 16:16:10 +0800
Message-ID: <fd0daf0d017e8b60c2503ddcbda67254c57ee6e7.1736150983.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736150983.git.tanggeliang@kylinos.cn>
References: <cover.1736150983.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch updates the interfaces set_flags to reduce repetitive code,
adds two more parameters 'local' and 'remote' for them. These addresses
are parsed in public helper mptcp_pm_nl_set_flags_doit(), then pass them
to mptcp_pm_nl_set_flags() and mptcp_userspace_pm_set_flags().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  8 +++--
 net/mptcp/pm_netlink.c   | 70 +++++++++++++++++++++++++++-------------
 net/mptcp/pm_userspace.c | 43 +++++-------------------
 net/mptcp/protocol.h     | 12 +++++--
 4 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6cd69ea9a69b..4e851be7a177 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -449,11 +449,13 @@ int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 	return mptcp_pm_nl_dump_addr(msg, cb);
 }
 
-int mptcp_pm_set_flags(struct genl_info *info)
+int mptcp_pm_set_flags(struct mptcp_pm_addr_entry *local,
+		       struct mptcp_addr_info *remote,
+		       struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(info);
-	return mptcp_pm_nl_set_flags(info);
+		return mptcp_userspace_pm_set_flags(local, remote, info);
+	return mptcp_pm_nl_set_flags(local, remote, info);
 }
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e9747bc948b9..7f5a72525bca 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1981,10 +1981,10 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct genl_info *info)
+int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct mptcp_addr_info *remote,
+			  struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
 			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	struct net *net = genl_info_net(info);
@@ -1992,52 +1992,76 @@ int mptcp_pm_nl_set_flags(struct genl_info *info)
 	struct pm_nl_pernet *pernet;
 	u8 lookup_by_id = 0;
 	u8 bkup = 0;
-	int ret;
 
 	pernet = pm_nl_get_pernet(net);
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
-	if (addr.addr.family == AF_UNSPEC) {
+	if (local->addr.family == AF_UNSPEC)
 		lookup_by_id = 1;
-		if (!addr.addr.id) {
-			GENL_SET_ERR_MSG(info, "missing required inputs");
-			return -EOPNOTSUPP;
-		}
-	}
 
-	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&pernet->lock);
-	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
-			       __lookup_addr(pernet, &addr.addr);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
+			       __lookup_addr(pernet, &local->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		GENL_SET_ERR_MSG(info, "address not found");
 		return -EINVAL;
 	}
-	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	if ((local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
 	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		spin_unlock_bh(&pernet->lock);
 		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		return -EINVAL;
 	}
 
-	changed = (addr.flags ^ entry->flags) & mask;
-	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
-	addr = *entry;
+	changed = (local->flags ^ entry->flags) & mask;
+	entry->flags = (entry->flags & ~mask) | (local->flags & mask);
+	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
+	mptcp_nl_set_flags(net, &local->addr, bkup, changed);
 	return 0;
 }
 
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return mptcp_pm_set_flags(info);
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
+	struct nlattr *attr_loc;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
+		return -EINVAL;
+
+	attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
+	ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
+	if (ret < 0)
+		return ret;
+
+	if (loc.addr.family == AF_UNSPEC) {
+		if (!loc.addr.id) {
+			NL_SET_ERR_MSG_ATTR(info->extack, attr_loc,
+					    "missing address ID");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (attr_rem) {
+		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
+		if (ret < 0)
+			return ret;
+
+		if (rem.family == AF_UNSPEC) {
+			NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
+					    "invalid remote address family");
+			return -EINVAL;
+		}
+	}
+
+	return mptcp_pm_set_flags(&loc, &rem, info);
 }
 
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2a00227e3f35..0f703e06d771 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -569,12 +569,10 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	return err;
 }
 
-int mptcp_userspace_pm_set_flags(struct genl_info *info)
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct mptcp_addr_info *remote,
+				 struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	u8 lookup_by_id = 0;
@@ -588,42 +586,17 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
-	if (ret < 0)
-		goto set_flags_err;
-
-	if (loc.addr.family == AF_UNSPEC) {
+	if (local->addr.family == AF_UNSPEC)
 		lookup_by_id = 1;
-		if (!loc.addr.id) {
-			NL_SET_ERR_MSG_ATTR(info->extack, attr,
-					    "missing address ID");
-			ret = -EOPNOTSUPP;
-			goto set_flags_err;
-		}
-	}
 
-	if (attr_rem) {
-		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
-		if (ret < 0)
-			goto set_flags_err;
-
-		if (rem.family == AF_UNSPEC) {
-			NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
-					    "invalid remote address family");
-			ret = -EINVAL;
-			goto set_flags_err;
-		}
-	}
-
-	if (loc.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = lookup_by_id ? mptcp_userspace_pm_lookup_addr_by_id(msk, loc.addr.id) :
-			       mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
+	entry = lookup_by_id ? mptcp_userspace_pm_lookup_addr_by_id(msk, local->addr.id) :
+			       mptcp_userspace_pm_lookup_addr(msk, &local->addr);
 	if (!entry) {
 		spin_unlock_bh(&msk->pm.lock);
-		ret = -EINVAL;
 		goto set_flags_err;
 	}
 
@@ -634,7 +607,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &entry->addr, &rem, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &entry->addr, remote, bkup);
 	release_sock(sk);
 
 set_flags_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index df5619ae8a14..d5a28ffbc1c3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1028,9 +1028,15 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_set_flags(struct genl_info *info);
-int mptcp_pm_nl_set_flags(struct genl_info *info);
-int mptcp_userspace_pm_set_flags(struct genl_info *info);
+int mptcp_pm_set_flags(struct mptcp_pm_addr_entry *local,
+		       struct mptcp_addr_info *remote,
+		       struct genl_info *info);
+int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
+			  struct mptcp_addr_info *remote,
+			  struct genl_info *info);
+int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
+				 struct mptcp_addr_info *remote,
+				 struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
-- 
2.45.2

