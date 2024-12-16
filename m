Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB7157469
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330342; cv=none; b=b4XB+ELznig1s+Ll6BCETD5IrSEc4TuEUDlc5BwjgHDfseKeFfM7eP0YOitt7kFEhLLOicGb08blaDYsKqYjpKjEl03jYpFVlcOIuiJ6ZswOeQ2WXPjz08bFFpPCEOypq4ntubUzwNXQx4y2edNaCJuPh0fIrlPl1e201thx5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330342; c=relaxed/simple;
	bh=4s5dQD8fMaJh/dXhH1Gz9D3dyjGkpykdv1CCcPPJo10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcoYUtsQK1u60lIjh5KposFQPPgJMygcQdbXX2g2jeGfX1bjUyU0XlsZyCrKHQitl0C6fnixKovBot2clMxwJr1NQYbtP+1lQ4mKIughp2wttdjCmduF8biM7UoCK1sg/ggKPcajbnQWUUxelGZb5Lyq8gkliuC1o7wm2b7BQcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4VH3qYz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4VH3qYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D72C4CED0;
	Mon, 16 Dec 2024 06:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734330341;
	bh=4s5dQD8fMaJh/dXhH1Gz9D3dyjGkpykdv1CCcPPJo10=;
	h=From:To:Cc:Subject:Date:From;
	b=A4VH3qYzQzQ4iU1m3UivNmtOg3QXIOvdoXpr3EwHd57bpHzqWw0ookWgpAOUz2qk6
	 J4oSh69jRwsu3tJ8U8Uo4v85sawWpcRjZqSAO1IyscfkyTY5cSc61R953D1E3wVOy6
	 SBrn/g4KedbRukCxtVSa1fesxZbILIpWmUFnaVTLfqdO1ywQUy8VaX4orLMQ5G0e1o
	 xbg6wWrh8OG3gdVVp8aPJKlb7hfpO+qR6B3f+je0/J6eCC4xJXH75zeyRO/VEHXu79
	 Bsvcd3VkJ2YY6UN4eIKmra3JBAAuhmb6ldXX91E8AvsB6YB/sCEGSQ1SkpRDFF1cHy
	 edn1lLyl9D3Zw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mptcp-next v2] mptcp: use GENL_REQ_ATTR_CHECK for token
Date: Mon, 16 Dec 2024 14:25:35 +0800
Message-ID: <a5dc0d188ebb30b3d541178a821b08f1124246ba.1734330271.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A more general way to check if MPTCP_PM_ATTR_TOKEN exists in 'info'
is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN) instead of
directly reading info->attrs[MPTCP_PM_ATTR_TOKEN] and then checking
if it's NULL.

So this patch uses GENL_REQ_ATTR_CHECK() for 'token' in 'info' in
mptcp_pm_get_addr(), mptcp_pm_dump_addr(), mptcp_pm_set_flags() and
mptcp_userspace_pm_get_sock().

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - use GENL_REQ_ATTR_CHECK in get_addr(), dump_addr() and set_flags()
   too.
---
 net/mptcp/pm.c           | 18 +++++++++---------
 net/mptcp/pm_userspace.c |  5 +++--
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16c336c51940..7c8525ff4107 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -435,25 +435,25 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 
 int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(skb, info);
-	return mptcp_pm_nl_get_addr(skb, info);
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
+		return mptcp_pm_nl_get_addr(skb, info);
+	return mptcp_userspace_pm_get_addr(skb, info);
 }
 
 int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
 
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_dump_addr(msg, cb);
-	return mptcp_pm_nl_dump_addr(msg, cb);
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
+		return mptcp_pm_nl_dump_addr(msg, cb);
+	return mptcp_userspace_pm_dump_addr(msg, cb);
 }
 
 int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(skb, info);
-	return mptcp_pm_nl_set_flags(skb, info);
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
+		return mptcp_pm_nl_set_flags(skb, info);
+	return mptcp_userspace_pm_set_flags(skb, info);
 }
 
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 740a10d669f8..cc2b7c50d4d6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -175,14 +175,15 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_sock *msk;
+	struct nlattr *token;
 
-	if (!token) {
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN)) {
 		GENL_SET_ERR_MSG(info, "missing required token");
 		return NULL;
 	}
 
+	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
 	if (!msk) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
-- 
2.45.2

