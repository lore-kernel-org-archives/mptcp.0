Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1915884A
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151401; cv=none; b=rIC5Y5/c5tU5eO2GFFLhFHYEePLc1ttczAVhkiTsPQp7/2OInwpEPGJ3G16dTTQBbfSb8EGYTI82ygpHEA+V4ONGmDTzRhUiyivIIN+mJyS4CIndYNZpV/ITWl+xPLNl6dQfxndDyStSU9HJTltXUmH9MnASkJaO7Muc8nKmkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151401; c=relaxed/simple;
	bh=FQgcebzF+PchMdKsoM25Kd26OJWtdwXFB5ff7XDGjNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H94q1LlFZJj8DTAGPBD/ieHp7WNQOX8Jy8G+VJZAu0iFZCG2imByJlClc3SXxHMwxJ/h5HWiDQk9vBvET+NTSma1BC/W3UmE3dLtLTCKejmoEnJGgjXzq/FxMt41qu1kbm5KX4rfSzVqGI6E9OV76s8a9Dd7mBVDAMA3Qj633MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2pAdpT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2pAdpT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E32EC4CEDF;
	Mon,  6 Jan 2025 08:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736151401;
	bh=FQgcebzF+PchMdKsoM25Kd26OJWtdwXFB5ff7XDGjNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2pAdpT8rdK5nNiUXtECVgSPgSlWu08Fir10IsDzB5hs/F6dIogF1JF/F+a27ar4u
	 4G3T9bU6Od/PhPS9IZmjmMO2Qqi1cD1CFD+rkPW4c5OV0dvxfFRHvxUxtebGr8MJ/3
	 hifmnA9ltAii9nRK7/LEiWQ+FLfUg5ayz3wpf92qYwzUZwhbLwjIq3pcY3KcXOkVt9
	 spfdVdXMO9f4hjs/KUCswLKYcgIpRyaYET1Zjco6fgV1JhAj09O5UGrWtDlR26igdN
	 RONaN1NEp9w9xhDXxYl4bw5D/fL1NCO+G9zBCI8boncaA9gGK1c9H9DEwa10OSedvL
	 xZrGg1Nmx7/SQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v7 09/11] mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
Date: Mon,  6 Jan 2025 16:16:14 +0800
Message-ID: <8272c35599055c36292b103ee25c50e0e731c50e.1736150983.git.tanggeliang@kylinos.cn>
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

A more general way to check if MPTCP_PM_ATTR_* exists in 'info'
is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_*) instead of
directly reading info->attrs[MPTCP_PM_ATTR_*] and then checking
if it's NULL.

So this patch uses GENL_REQ_ATTR_CHECK() for userspace PM in
mptcp_pm_nl_announce_doit(), mptcp_pm_nl_remove_doit(),
mptcp_pm_nl_subflow_create_doit(), mptcp_pm_nl_subflow_destroy_doit()
and mptcp_userspace_pm_get_sock().

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 41 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 341db3bc191b..201595f9ebf9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -175,14 +175,13 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_sock *msk;
+	struct nlattr *token;
 
-	if (!token) {
-		GENL_SET_ERR_MSG(info, "missing required token");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
 		return NULL;
-	}
 
+	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
 	if (!msk) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
@@ -201,16 +200,14 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
+	struct nlattr *addr;
 	int err = -EINVAL;
 	struct sock *sk;
 
-	if (!addr) {
-		GENL_SET_ERR_MSG(info, "missing required address");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -218,6 +215,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
@@ -314,18 +312,17 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
 	struct mptcp_sock *msk;
+	struct nlattr *id;
 	int err = -EINVAL;
 	struct sock *sk;
 	u8 id_val;
 
-	if (!id) {
-		GENL_SET_ERR_MSG(info, "missing required ID");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_LOC_ID))
 		return err;
-	}
 
+	id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	id_val = nla_get_u8(id);
 
 	msk = mptcp_userspace_pm_get_sock(info);
@@ -371,19 +368,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
+	struct nlattr *raddr, *laddr;
 	struct mptcp_pm_local local;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
 
-	if (!laddr || !raddr) {
-		GENL_SET_ERR_MSG(info, "missing required address(es)");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
+	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -391,6 +386,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
@@ -404,6 +400,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	entry.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
+	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
@@ -495,18 +492,16 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_l;
 	struct mptcp_addr_info addr_r;
+	struct nlattr *raddr, *laddr;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
 	int err = -EINVAL;
 
-	if (!laddr || !raddr) {
-		GENL_SET_ERR_MSG(info, "missing required address(es)");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
+	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -514,12 +509,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	sk = (struct sock *)msk;
 
+	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto destroy_err;
 	}
 
+	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
-- 
2.45.2

