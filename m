Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD314A08E
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494259; cv=none; b=q5nVrbuR/B2dWLZIDWzDbqYkSAtA6uXP6TsYfX8Fsd8nwNC2yWvtCDQj/VyeHInwEM/JtWHHlvOWm+7t2eDJ3+JGEEnke4l5TzlxMIfBrnrZiJM4IuVYI20yPbzs6Vr/WiUTza4Tij6xKVIiW25RtIdA+DPTm2FeoVJqNF7Pn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494259; c=relaxed/simple;
	bh=/v343bsB/x4ZR18kN71yaHGjwhOk50DZDpL64LPrQMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUaaA6xM/YNYlbXExretU3bBV+GNPsiWRuZIkGlDFgALf7NZnjFQ5sOyFv4ncx5YTajbHG8ApzsEti95Pt263SZfJWd9ZF/CzGuv6uEy+iD2AhmTpZ1BM/aKNAWbhQNNk5KZA+zELJztWDzZpzmDeDHQ2BGFAcR4/SmyGiVq8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unWsqDZ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unWsqDZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B10C4CEDF;
	Fri, 10 Jan 2025 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494258;
	bh=/v343bsB/x4ZR18kN71yaHGjwhOk50DZDpL64LPrQMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=unWsqDZ+tl7rqRcU9pjvKV2x3RQr9JfYLfLj5FoCsbl7LXf6k+JxzBDyhOKKQuP2N
	 P7uSwJXJ1v0izIyjt9Ux+CaNHcswWWi6QwjSTIZnITG9FDhSb80TKjgSbgzA+Obezv
	 HRy5cgg09U9qeDi80SsZbz2xO9W0eAK+2CotRWhV4+MlrfFJBOnyzu0qmTVJoWMTZ7
	 jXMUBzCr4MF3TTpyL3MEYr7sfeDMWe8oQs2JGiTwoxC7DZWi1YJtpByEKxNATrv4aG
	 fjQiXolbATM6MpBcqK6+B2DrCGpO0EaqClm37Q+B//gO0sLE5/bLAwOQJXH4vvNc4x
	 bfFg2/UWG2VwA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v9 5/8] mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
Date: Fri, 10 Jan 2025 15:30:39 +0800
Message-ID: <1c97e5116246d09f8978d0355a84b434bf829231.1736493803.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736493803.git.tanggeliang@kylinos.cn>
References: <cover.1736493803.git.tanggeliang@kylinos.cn>
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

"Suggested-by: Jakub Kicinski <kuba@kernel.org>"
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 41 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e350d6cc23bf..4cbd234e2670 100644
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
@@ -200,16 +199,14 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 
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
@@ -217,6 +214,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
@@ -312,18 +310,17 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 
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
@@ -369,19 +366,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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
@@ -389,6 +384,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
+	laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
@@ -402,6 +398,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	entry.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
+	raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
@@ -493,18 +490,16 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 
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
@@ -512,12 +507,14 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
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

