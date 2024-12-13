Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F0188CC9
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075342; cv=none; b=ZOGcW1mYeIiTBrR2W2Px6ORL+03MupU6CsL8VOGU08Ek+vWwwyv33dCU+gcGbR9+ZIY7fp/1U5Z6f1y0OSgTldzJMPdN3r0eGhKrixLhmeVkMD+RIeAO24dW4Uni0OH06F/EvQg5pLCLLaNIIZaUN0KoxR4Z1RJq6Zzm+maEXjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075342; c=relaxed/simple;
	bh=xi3n30NKy6jcAWd6CK0ffRX8YNgG4baU8O7YcFiv/VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV9zR6PDnc44pKAZMiBUFAwFcWgj8P3qlh93kPUYanB5bwJ1eUnI1kEMPveHniYGKSk75PBLlvvhSZ7RX/MrkVSFkFIwGOmCRA2jgVbTaLNlkcBTreurnUnCD/IHpG+b30ZlC7FuV5dt0Mi3ENdrKEJ/j44+dg8WnUt0p1yXoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PshzT/j2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PshzT/j2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274A8C4CED1;
	Fri, 13 Dec 2024 07:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075341;
	bh=xi3n30NKy6jcAWd6CK0ffRX8YNgG4baU8O7YcFiv/VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PshzT/j2tGj3YFIx3RMA7EarbIehAIxX4QN9q1lHQu74b9f3Sp1SjCm/yG2TiRwim
	 69GnJybcgkEyYky/SjmoUnErEma0kHnWHB5EkbBV67c8k+7Why/cRcGztyLOWfVMPc
	 QB2jk3TrI7CBM7Tqiw5C0HaZL05n7nRUoPgCVHasE8MpY9cNwwNTWxYYnqrqmsf97K
	 nJmqqe+GvH4IDff8yfBMoftdsz0o5zN3MQGCdP9n9LDeZTllJvGe8j+3jgF5LudpYG
	 ZL+PNNiSKpO5ERPyTgWQhduFrymvS8BgS3Y7Wfhki7WDon5OEsSEtDfCkLz1sAy0H5
	 6bQOi6bqKrNEw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/8] mptcp: make three pm wrappers static
Date: Fri, 13 Dec 2024 15:35:22 +0800
Message-ID: <27f9dc45e43007e93483afbbb92a0dfac3e0ceab.1734074788.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734074788.git.tanggeliang@kylinos.cn>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Three netlink functions:

	mptcp_pm_nl_get_addr_doit()
	mptcp_pm_nl_get_addr_dumpit()
	mptcp_pm_nl_set_flags_doit()

are generic, implemented for each PM, in-kernel PM and userspace PM. It's
clearer to move them from pm_netlink.c to pm.c.

And the linked three path manager wrappers

	mptcp_pm_get_addr()
	mptcp_pm_dump_addr()
	mptcp_pm_set_flags()

can be changed as static functions, no need to export them in protocol.h.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         | 23 ++++++++++++++++++++---
 net/mptcp/pm_netlink.c | 16 ----------------
 net/mptcp/protocol.h   |  3 ---
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16c336c51940..a29be5ff73a6 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -10,6 +10,7 @@
 #include "protocol.h"
 
 #include "mib.h"
+#include "mptcp_pm_gen.h"
 
 /* path manager command handlers */
 
@@ -433,14 +434,19 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_get_addr(skb, info);
 	return mptcp_pm_nl_get_addr(skb, info);
 }
 
-int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_get_addr(skb, info);
+}
+
+static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
 
@@ -449,13 +455,24 @@ int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 	return mptcp_pm_nl_dump_addr(msg, cb);
 }
 
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	return mptcp_pm_dump_addr(msg, cb);
+}
+
+static int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
 		return mptcp_userspace_pm_set_flags(skb, info);
 	return mptcp_pm_nl_set_flags(skb, info);
 }
 
+int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_set_flags(skb, info);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98ac73938bd8..32367fcc728e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1812,11 +1812,6 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	return mptcp_pm_get_addr(skb, info);
-}
-
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb)
 {
@@ -1860,12 +1855,6 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 	return msg->len;
 }
 
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
-{
-	return mptcp_pm_dump_addr(msg, cb);
-}
-
 static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 {
 	struct nlattr *attr = info->attrs[id];
@@ -2035,11 +2024,6 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
-int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	return mptcp_pm_set_flags(skb, info);
-}
-
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
 {
 	genlmsg_multicast_netns(&mptcp_genl_family, net,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 19a811220621..3bff78efd8ed 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1035,7 +1035,6 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
 bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr);
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
@@ -1128,12 +1127,10 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info);
-- 
2.45.2

