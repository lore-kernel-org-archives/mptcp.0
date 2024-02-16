Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D319168DE
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069365; cv=none; b=mUs9P7n7izd0HAO0mL8UbFvfHprNFkbLBlS+lq2ja0PBhJBeyRtbHCBVpXzRMJo6YuW4A/M92RmBOlyxIaZwFUMvb+TWdvUyzeUfK5lmqhJCawERBXB9mFaHqRVqwjycgXG8JvrXk3QTlPzrAER8AWAq9RN5xMtSsUwl8kKwjaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069365; c=relaxed/simple;
	bh=UYlXxvMoWkZF081WLIoWdKVoOO4qA468ytMjPC6qLoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TW/cuXI7nzK9c0Iqu8lZH3fJ6IwRJq0ZsBUtOJPNZLiGlqqGQqQhUwmInYLexu7mhbFuO1aFBY/g5VMZHT18q0LqpXZaQIOCwAZlDXofqW6Pm5ET4EBbrqoU3X6EeVY5zc6o0+E9a5dUq9pyFr7X2GXbLadL/cciXRnLvcHzna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqGEDxFI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqGEDxFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F7FC43390;
	Fri, 16 Feb 2024 07:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708069365;
	bh=UYlXxvMoWkZF081WLIoWdKVoOO4qA468ytMjPC6qLoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqGEDxFI5cmSqSnY5kCQGiVSMiegYPpDVY9GIVj/qjKcPp+FepzbNKxaP0QhmmWpS
	 Wzh1drqW4tGOWAmEv2ChDFvtiOk4mdD76bGF8rZAswV2clwxDkH/OS5bLGUjgT+WIG
	 14v8xVXIOaxtdFYZToiqd/+ej6+1wbRNW3qyyacjkkVXC7i1Uj4aYb9AFZT2PpbJzA
	 tamkCHYOoBhsctWYdPZnzDinmb6s+lyhznSu6bY1UqXGdBlcgtQ3zJCpJKJ7t59lPe
	 8xXzuR/anJLEYXEAZbmyq1Bj2tEgpjdQRnTb0caG21O706IdZXFFIOpYO2IHgzW6Di
	 xq5DZzQ8Mo+Dg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 12/14] mptcp: get addr in userspace pm list
Date: Fri, 16 Feb 2024 15:42:14 +0800
Message-Id: <be17914c8ff431b494ca13b8c2580d7402776d59.1708069036.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708069036.git.tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch renames mptcp_pm_nl_get_addr_doit() as a dedicated in-kernel
netlink PM get addr function mptcp_pm_nl_get_addr(). and invoke a new
wrapper mptcp_pm_get_addr() in mptcp_pm_nl_get_addr_doit.

If a token is gotten in the wrapper, that means a userspace PM is used.
So invoke mptcp_userspace_pm_get_addr() to get addr in userspace PM list.
Otherwise, invoke mptcp_pm_nl_get_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         | 7 +++++++
 net/mptcp/pm_netlink.c | 7 ++++++-
 net/mptcp/protocol.h   | 2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 193198cec74a..b4bdd92a5648 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -441,6 +441,13 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 }
 
+int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_get_addr(skb, info);
+	return mptcp_pm_nl_get_addr(skb, info);
+}
+
 int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7b15bb4f12c1..f04e354b0c64 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1672,7 +1672,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1722,6 +1722,11 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_get_addr(skb, info);
+}
+
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a86708996954..75d9184db7ff 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1037,6 +1037,8 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
+int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info);
+int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info);
 
-- 
2.40.1

