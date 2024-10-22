Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CE196C6C
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588504; cv=none; b=JK+ds5/ocq/m5jOaT7GRGBEJsq1FALuDzBD6j0QW2z8e1i7PDxGHFhP7GkWO+twv7TD6xERlJ3VWq4RVK/o+z1gzgNu06+xpA6bbQBtrZc1AkyCNxVibGj5jPFj0hWU2E1aokWZAB8be/D8w0RRnd0HDLG/TZPMoBz1Kaf9zTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588504; c=relaxed/simple;
	bh=3vtyJKteLifOTz5Owsejkq3lwo6fJZXC340hIuh4xvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTIDx/hEmKGl2DCe3SSKR7na/qNaDwJW3pqeAvIv9EkyDLKeD/BD7/sSr+6+nStq2hLgUzxfv4EbzlAQjI7JoJqseNu0S52nuKkOlHgkWEZyNMdYSwyMxHZJUxOWcyjiKAsXCm0rcCNzJypvsOy1ee7vFO9LGv/62KtRxwbwVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF5Vwcqb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF5Vwcqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB47BC4CEC3;
	Tue, 22 Oct 2024 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588504;
	bh=3vtyJKteLifOTz5Owsejkq3lwo6fJZXC340hIuh4xvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QF5VwcqbZu4gh3ghJtiFgjFjdUUWw0l8LNMXLFHt6dHeuS1LnULbVN+EiXdBk+pIM
	 XkXG2WmDH4r+2VsFSXJxBeWghhAFjs7eiJNZMzefHk5XQNF+WisvMoru4cptabWRuM
	 oAcFfGyT50gMNuF1u5NqZ+mwV1Ffvbp5Akc6DpQAHwwSn5evJNIowWuV/CYQtMkWLF
	 ULlVsH0gLXPAtBdb4/RUMcpAv12vRmmuivs3rlPvIBlxX/JvvlwJTaEloZK3lJSfqC
	 Pu3gwSH7vWlGGFmEgbvUWl7LbUl/3wzvXEOEtYmdsh6ZHH403TmmeqLelsBES9J3jD
	 nodl8uHrrrhng==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 07/36] mptcp: make three pm wrappers static
Date: Tue, 22 Oct 2024 17:14:15 +0800
Message-ID: <6a0fc4027e27a2bdbbaea2997a5489399ea0fc7d.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Three path manager wrappers, mptcp_pm_get_addr(), mptcp_pm_dump_addr() and
mptcp_pm_set_flags() are used to switch the interfaces between in-kernel
PM and userspace PM. These wrappers are defined in pm.c but only used in
pm_netlink.c. It makes more sense to move them to pm_netlink.c and make
them all static.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c         | 23 -----------------------
 net/mptcp/pm_netlink.c | 31 +++++++++++++++++++++++++++----
 net/mptcp/protocol.h   |  7 -------
 3 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f3d354a72c94..f5725c00eb70 100644
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
index a60a6fc04bf4..8b4815d0df53 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1792,7 +1792,7 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
@@ -1842,13 +1842,20 @@ int mptcp_pm_nl_get_addr(struct sk_buff *skb, struct genl_info *info)
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
@@ -1890,6 +1897,15 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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
@@ -2011,7 +2027,7 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
-int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
+static int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -2065,6 +2081,13 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
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
index ce3b12778b3f..b6e66bfca2e5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1036,8 +1036,6 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
-int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
@@ -1128,13 +1126,8 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
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
2.45.2

