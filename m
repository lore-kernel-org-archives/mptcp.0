Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE016FB0
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881335; cv=none; b=VNoLSek55Trmcj/VQV22vNkaAHC0ZzrcHz9QNZ9ErxVYxSvLNuvtT7lU0yn48EUKoyZqNeQ6AJ2Y+lFVzFAJhIrt2E29qmYLbZ0eAQxX+bqBmG34jVSsL+CVk6i/IxFbaWJOnNTaQCCk9rvss3jQgII1+3lDpge/5dwrd4RR53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881335; c=relaxed/simple;
	bh=mmzc7mLX/pp+4/834DqQqofFdcapSC05ny0izEtmmpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pz9T0HHJwrhqH6ZMSnfml+6bW0shlQ47FEdt+XK11ha6hBs5Fh7oDcA7U4TrReP7wM7t3U3iuhJTOeJv8p+FEXXBXJ2alhCb/20EJ8UjrBYHE2QadYOVSaQWZMZLFTOccPBb6lZwzaH4iFiHGzToX3E62D4TpJA2eNXNZIwY8DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVXKzDKl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVXKzDKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D310C4CED1;
	Wed,  2 Oct 2024 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881334;
	bh=mmzc7mLX/pp+4/834DqQqofFdcapSC05ny0izEtmmpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVXKzDKlu2B/GY8L5REvkH/mILcPZQPpxfbmOVEpgyhE8vLl6Xpx8Kn4knzCM6e7W
	 dcItZ6gCtKzLpKVd8e2outd0+EwGTWhruT6XkIyA0HTekWTRfGKdLssxXQzUI1I/ps
	 TB1mc5RAGAPgzn7YdU8SbDOjojItWipG5YaTmHaVh/PbsPXNAIi0uQd7dLVTN+yyeB
	 3TkweEeo1RwwVniGczWACskDjC7hU5Ol3QR0EC6PirkTMQfMUAj7t76xuJBZ53qaXx
	 RWtU+zrzUa+xl5tNIAZPsONpWWUauzR//vXlXyF6RXPH284zW7LcX+ea0mG2MyJEt9
	 oSDwS6WQGc0Sg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/9] mptcp: make pm wrappers static
Date: Wed,  2 Oct 2024 23:01:57 +0800
Message-ID: <58030bde64496b632614feaa8c9f29050b66e8db.1727881073.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727881073.git.tanggeliang@kylinos.cn>
References: <cover.1727881073.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The path manager wrappers, mptcp_pm_get_addr(), mptcp_pm_dump_addr() and
mptcp_pm_set_flags() are used to switch the interfaces between in-kernel
PM and userspace PM.

These wrappers are defined in pm.c but only used in pm_netlink.c. It makes
more sense to move them to pm_netlink.c and make them all static.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         | 23 -----------------------
 net/mptcp/pm_netlink.c | 31 +++++++++++++++++++++++++++----
 net/mptcp/protocol.h   |  7 -------
 3 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5afc1f8e5ca7..c051c1ec4de4 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -433,29 +433,6 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
-{
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(skb, info);
-	return mptcp_pm_nl_get_addr(skb, info);
-}
-
-int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
-{
-	const struct genl_info *info = genl_info_dump(cb);
-
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_dump_addr(msg, cb);
-	return mptcp_pm_nl_dump_addr(msg, cb);
-}
-
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
-{
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(skb, info);
-	return mptcp_pm_nl_set_flags(skb, info);
-}
-
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e1907dad3bc4..d7a4199b142e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1790,7 +1790,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1840,13 +1840,20 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_get_addr(skb, info);
+	return mptcp_pm_nl_get_addr(skb, info);
+}
+
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	return mptcp_pm_get_addr(skb, info);
 }
 
-int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
-			  struct netlink_callback *cb)
+static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
+				 struct netlink_callback *cb)
 {
 	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
@@ -1888,6 +1895,15 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	return msg->len;
 }
 
+static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_dump_addr(msg, cb);
+	return mptcp_pm_nl_dump_addr(msg, cb);
+}
+
 int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 				struct netlink_callback *cb)
 {
@@ -2009,7 +2025,7 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -2063,6 +2079,13 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_set_flags(skb, info);
+	return mptcp_pm_nl_set_flags(skb, info);
+}
+
 int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	return mptcp_pm_set_flags(skb, info);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ef50ef0c0829..95533d5b82c4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1035,8 +1035,6 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
-int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
@@ -1127,13 +1125,8 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
-int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
-			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info);
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info);
 
-- 
2.43.0

