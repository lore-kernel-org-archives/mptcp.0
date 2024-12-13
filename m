Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F39188CC9
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075351; cv=none; b=IUC4gsQW3RiwKz+c4vYhsWQnxKQrnuj7bt2tHX8N+n5rjAAu3DLJY8ebd//WHyQZCWMH7i7ix8TqAN/1/kCDUmkGjRyKXOC8SQl01E2TF7Ew5bJ1hFgYTbk8mP/lO3HgXk8EO57GTeHBojQwQBVQ0nPhBOzHrGF2hCm4IB6dGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075351; c=relaxed/simple;
	bh=aTXVfyjBz7PlvKz/drFfOLhJMic597preliYPpLfbdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhfgtuDShuO6ddonea0lO1hy278Lky6+DmJ91kGEyRWkTquTeocvZgNS4GTNzbrmpT507k8HNs/KkfTJOmGS2xaofjArs9e0UVZVX6OE7aH5iFskSLuQYDK4n1I/qYJ2gDQIYri8l2q+pxCTny5pcBN/6ei6DlTYHml6IjZ1C4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgc53a7T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgc53a7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D212C4CED1;
	Fri, 13 Dec 2024 07:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075350;
	bh=aTXVfyjBz7PlvKz/drFfOLhJMic597preliYPpLfbdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgc53a7TE9HTZEZ6y18m2/hYvL41tCGAM/Vgru1MaOH5n9XlwvbsFXha9px2Ra2kS
	 wKpz8WYYeQPYuO8xKSiy52uFLYNRvG2dKWVpPeKEaryhtyoyXVXdVSI9vmR+3Es45f
	 Q7Ytx9nBW4neFSLurQ9KxeWdJfICvXVS/+JFVQKIncfdKB3MXlSCEBNZAsdm4E9TiX
	 xR1lu4ZVn1W5aW3knB6zbpRFCVIWsbr634lt/ssBy7FkJvElzhCc/wispGizcNHQL8
	 prffALnMnnMkvUqSKJTOf+V7iNjrB5lzbLcxd1k5Vr/U8ybqrKeXYSPJgkWzm4Jn9t
	 ke8kUsVmjuVXw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/8] mptcp: add info parameter for dump_addr
Date: Fri, 13 Dec 2024 15:35:27 +0800
Message-ID: <dc3e70d8b4da08374fdad0ec3c61303ba195e018.1734074788.git.tanggeliang@kylinos.cn>
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

The genl_info information is useful for dump_addr() interface in both
in-kernel PM and userspace PM. The former can use it to get pm_nl_pernet,
the latter can use it to get msk through mptcp_userspace_pm_get_sock().

So this patch adds an 'info' parameter to dump_addr interface, so that
'info' can be obtained in mptcp_pm_nl_get_addr_dumpit() and then passed to
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

