Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CCC7462
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942281; cv=none; b=kkiBSa7EYwTdexBmtSdstZgoBagDvRANRwMWWTwBjXUbvkTXgrL0Kpv57Bd0ajqLduAZxHWVdOEJ9p+IY/zmaWSYwpiLizVQtoIu20GWupz1/zVu9NtyA0GXM5tBdMrG4a4h13vSi3IeNRQaXa05rk8uEeftQjELcbAAZ2jYA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942281; c=relaxed/simple;
	bh=fz5SaDHvJxIFOFiZ/axMZwcmu8FoKw5ExSWjiiTKsbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiVZZz11HUKeV563NEruGQ4MuN0V8XRu7UKDIJlGdh5Ga5w2OwBcxNGC0g1ObXe7F89xG70UM7box3hF0ESRVQ104QpZCoYESJB3opl4oqIPO18DLfMD30dRQMvD46Pqh0EXxWVBd/1Zk4DwIufn7wVxyCgxXzKmnNZ0B1z/1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0+IRm08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0+IRm08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834D4C4CED3;
	Mon, 23 Dec 2024 08:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734942280;
	bh=fz5SaDHvJxIFOFiZ/axMZwcmu8FoKw5ExSWjiiTKsbE=;
	h=From:To:Cc:Subject:Date:From;
	b=J0+IRm08HEPLI+qFun6RowfL0j6JUVzbzrrvOMUQerzzbE8IKZ+IXU7M9ikbpJVlM
	 2MgKN1LJhjF6W/5RCSpTHk6ppTzp1LTChnj/GTNMA0qyQ/gRme3GhwxheT1S6UgEAm
	 OQh9Ktp8l0Dvt8j4felr7piHI+VJkG1Ak2Y9rvOqUjgvZrPEJ4PgJ9/4aZ4n6gLcdi
	 Xc7Wmm5COObN22WyKXjGodwv224GJgmizTQn9p4SgFLlp5f84Sy85ODIbp+qj00/+U
	 P1jcz9B60QgxvWp+VucWH+KYaJDMoA4D9Dnn+x4Wa9Fp9O9vs5GF0IXWniod4/MR/e
	 LLJyg7F2yajRw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5] mptcp: use GENL_REQ_ATTR_CHECK in userspace pm
Date: Mon, 23 Dec 2024 16:24:34 +0800
Message-ID: <ef87c8dd40c8dac4b946bf77e272d01ca64cc9dd.1734941967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
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

'Suggested-by: Jakub Kicinski <kuba@kernel.org>'
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v5:
 - drop 'struct nlattr *' variables as Matt suggested (thanks)

v4:
 - use GENL_REQ_ATTR_CHECK in more functions as Matt suggested (thanks)

v3:
 - use GENL_REQ_ATTR_CHECK in mptcp_userspace_pm_get_sock only
 - drop GENL_SET_ERR_MSG as Matt suggested (thanks)

v2:
 - use GENL_REQ_ATTR_CHECK in get_addr(), dump_addr() and set_flags()
   too.
---
 net/mptcp/pm_userspace.c | 69 ++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 740a10d669f8..42dda8877372 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -175,17 +175,17 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_sock *msk;
 
-	if (!token) {
-		GENL_SET_ERR_MSG(info, "missing required token");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN))
 		return NULL;
-	}
 
-	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
+	msk = mptcp_token_get_sock(genl_info_net(info),
+				   nla_get_u32(info->attrs[MPTCP_PM_ATTR_TOKEN]));
 	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[MPTCP_PM_ATTR_TOKEN],
+				    "invalid token");
 		return NULL;
 	}
 
@@ -200,16 +200,13 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
 
-	if (!addr) {
-		GENL_SET_ERR_MSG(info, "missing required address");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
 		return err;
-	}
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -217,7 +214,8 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
+	err = mptcp_pm_parse_entry(info->attrs[MPTCP_PM_ATTR_ADDR],
+				   info, true, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
 		goto announce_err;
@@ -309,19 +307,16 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
 	u8 id_val;
 
-	if (!id) {
-		GENL_SET_ERR_MSG(info, "missing required ID");
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_LOC_ID))
 		return err;
-	}
 
-	id_val = nla_get_u8(id);
+	id_val = nla_get_u8(info->attrs[MPTCP_PM_ATTR_LOC_ID]);
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -362,8 +357,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct mptcp_pm_local local;
@@ -371,10 +364,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -382,9 +374,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
+	err = mptcp_pm_parse_entry(info->attrs[MPTCP_PM_ATTR_ADDR],
+				   info, true, &entry);
 	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[MPTCP_PM_ATTR_ADDR],
+				    "error parsing local addr");
 		goto create_err;
 	}
 
@@ -395,9 +390,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	entry.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
-	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
+	err = mptcp_pm_parse_addr(info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE],
+				  info, &addr_r);
 	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE],
+				    "error parsing remote addr");
 		goto create_err;
 	}
 
@@ -483,18 +481,15 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_l;
 	struct mptcp_addr_info addr_r;
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
@@ -502,15 +497,21 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 
 	sk = (struct sock *)msk;
 
-	err = mptcp_pm_parse_entry(laddr, info, true, &addr_l);
+	err = mptcp_pm_parse_entry(info->attrs[MPTCP_PM_ATTR_ADDR],
+				   info, true, &addr_l);
 	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[MPTCP_PM_ATTR_ADDR],
+				    "error parsing local addr");
 		goto destroy_err;
 	}
 
-	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
+	err = mptcp_pm_parse_addr(info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE],
+				  info, &addr_r);
 	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE],
+				    "error parsing remote addr");
 		goto destroy_err;
 	}
 
-- 
2.45.2

