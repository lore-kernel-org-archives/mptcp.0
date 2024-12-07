Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED1822C6DC
	for <mptcp@lists.linux.dev>; Sat,  7 Dec 2024 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733533698; cv=none; b=GBjI8OAH1d+fo5HDXm8rJpmF8GssAF7TH+pJR6VYkB3tJxesnM2BDX5wIWqa6ja3vnvTl4rzTsQy21GUKV7XWS+NV+IFrpwht04tfnost7JDplu2nNbYjOuBjuo5Xh14ir8BDldRtqo95mW4Q2k2KrGsOLR/9kfwgiCodXUDYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733533698; c=relaxed/simple;
	bh=CuIEFEZApZ9JnwuCGToFSs/8+n5+3Z1R5r06rOc2Lok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEhWI4YnAodOXPMiVCjvI6FTtCI9Z/WW1JMvzMyZydwSxyt0+pOGPU6D8B8kOGAWlaQaWYVyAjzwT+Dn9o8tJncbUb4FZMCpGWWTlOBZAjGS+XPz8ZiN7qU9ofDzbJ5UZF/OjFnxBGIx3mJybA1nxr3HfF/xtPk9+pKj+Fqaw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCTRlEqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCTRlEqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C97C4CED2;
	Sat,  7 Dec 2024 01:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733533698;
	bh=CuIEFEZApZ9JnwuCGToFSs/8+n5+3Z1R5r06rOc2Lok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCTRlEqHuXznQ/EB052t+UagqbaSYtMCbeu/NE75CxltNy2uY1Yy9NLZltwlBbOoO
	 QMF4rpMPH+Nwzao3/OEbNzXQHgZ4XWBkBb9Bghefo8JSnhb/k9jWm7SS2jEJWletd+
	 nU2KU2O3S1DAZDbwo6sKKKyWmrD/j+awhCiNu5dUW6TF7BSHyec0JpCua2fEAXGwXq
	 263FkZLQi5G3LYgIbzElHa1oD6rmDagxL8oVCko8ckr2azB6RFaqzD52oLQQ7prV/z
	 4khvntGgfjRP5wRkh3xv7Pg4XPrk1wD2ZnMlp4N9z3eWmYLUNZ4gQxk9QlvU2v+Id1
	 /+MWvUuI4ywtA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 6/7] mptcp: add info parameter for dump_addr
Date: Sat,  7 Dec 2024 09:07:26 +0800
Message-ID: <0eab2e0554e9a00403109e2deec8989235490dee.1733533215.git.geliang@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733533215.git.geliang@kernel.org>
References: <cover.1733533215.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The genl_info information is useful for dump_addr() interface in both
in-kernel PM and userspace PM. The former can use it to get pm_nl_pernet,
the latter can use it to get msk through mptcp_userspace_pm_get_sock().

So this patch adds an "info" parameter to dump_addr interface, so that
"info" can be obtained in mptcp_pm_nl_get_addr_dumpit() and then passed to
mptcp_pm_nl_dump_addr() or mptcp_userspace_pm_dump_addr(), without having
to get it again in these two functions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 13 +++++++------
 net/mptcp/pm_netlink.c   |  5 +++--
 net/mptcp/pm_userspace.c |  4 ++--
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 080c842e9e90..0aaf16319c34 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -485,19 +485,20 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
+static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb,
+			      const struct genl_info *info)
 {
-	const struct genl_info *info = genl_info_dump(cb);
-
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_dump_addr(msg, cb);
-	return mptcp_pm_nl_dump_addr(msg, cb);
+		return mptcp_userspace_pm_dump_addr(msg, cb, info);
+	return mptcp_pm_nl_dump_addr(msg, cb, info);
 }
 
 int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 				struct netlink_callback *cb)
 {
-	return mptcp_pm_dump_addr(msg, cb);
+	const struct genl_info *info = genl_info_dump(cb);
+
+	return mptcp_pm_dump_addr(msg, cb, info);
 }
 
 static int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index eb5f48e45187..0d826bfc4718 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1784,9 +1784,10 @@ int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 }
 
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
-			  struct netlink_callback *cb)
+			  struct netlink_callback *cb,
+			  const struct genl_info *info)
 {
-	struct net *net = sock_net(msg->sk);
+	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	int id = cb->args[0];
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7c5914012947..7dc417255e8f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -615,12 +615,12 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 }
 
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-				 struct netlink_callback *cb)
+				 struct netlink_callback *cb,
+				 const struct genl_info *info)
 {
 	struct id_bitmap {
 		DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
 	} *bitmap;
-	const struct genl_info *info = genl_info_dump(cb);
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a9fc30f20376..1f9c66f53865 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1128,9 +1128,11 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
-			  struct netlink_callback *cb);
+			  struct netlink_callback *cb,
+			  const struct genl_info *info);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-				 struct netlink_callback *cb);
+				 struct netlink_callback *cb,
+				 const struct genl_info *info);
 int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 			 const struct genl_info *info);
 int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-- 
2.45.2

