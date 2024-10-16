Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54618D626
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069976; cv=none; b=TbDOZ93nJUVLr3jN8iBWYvLrg4ESr2WlJ9irkg0aA/Qlvba2dMPbFmBSJS2HMSGmqlZPZ9kKRCu9K+25Wauf5ZI5kbmldhwDFxS2qgbSJWcQmoiX/+SdgRVRQAVw12D6NXqhOd7gkXKVMm586Ws8zfsQs2vO5JAUGIEYrevU+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069976; c=relaxed/simple;
	bh=NRHw9P2ONxn8aUcs8tWFvd5uoauks3WL00DaLxKCi/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pub4p+daoHQ4OwPfGSLQ5eTbm5xU5sU6mDWVAPhidORK/BeyDeIshRs3SUnoylvaIJHhfHPq56ry8NOZq6/2iDnDvgdXgtpgMo3JmRMojVzhhCPuhCF3TOs8deyVFb5AJwR8/KMEuY5JVxZ9xHLSN3CEziu0XbIjHEVZxE33PQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO7qBXZi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO7qBXZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FE2C4CECE;
	Wed, 16 Oct 2024 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069976;
	bh=NRHw9P2ONxn8aUcs8tWFvd5uoauks3WL00DaLxKCi/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SO7qBXZiL/LIaK45atykEe48Tjxo7BOagVf7eXNPbk9EJDXOJDCqSJXAH1kIevqlN
	 gJFReq3blWT3rCfdfQXkCgyNSJrc+i7qTekU5oivG8k96Q3ehHoaiSAWKUqjtXkhmK
	 qoGIzVvx//WXJgu6RtBjlqfJR8cenM31+RjJUSE4lY/ZUyMd2gVCuVcN6UaVsta7jj
	 KXpN9eR0HRO5DAPDaVGwdrqTN+OxbQQjrVderKOwQwDxkS1kwfcqPiJc7vUw+7pvtP
	 PsKDWGf6STilS5kYY+7PQinq4ataDCWsI0A7bGacZRJsEPxqBFk/Mm6OBLMbqb+gHL
	 /Tm98sdkpk+IA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 06/33] mptcp: add mptcp_userspace_pm_get_sock helper
Date: Wed, 16 Oct 2024 17:12:10 +0800
Message-ID: <0b4f91aa7d9e71df017b58d35fd00b7dbaf1069f.1729069853.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Each userspace pm netlink function uses nla_get_u32() to get the msk
token value, then pass it to mptcp_token_get_sock() to get the msk.
Finally check whether userspace PM is selected on this msk. It makes
sense to wrap them into a helper, named mptcp_userspace_pm_get_sock(),
to do this.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 137 +++++++++++++--------------------------
 1 file changed, 44 insertions(+), 93 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ce0f7131c701..79ae32c921b7 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -169,36 +169,51 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 	return backup;
 }
 
-int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct mptcp_sock *msk = NULL;
+
+	if (!token) {
+		GENL_SET_ERR_MSG(info, "missing required inputs");
+		goto out;
+	}
+
+	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+		goto out;
+	}
+
+	if (!mptcp_pm_is_userspace(msk)) {
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		sock_put((struct sock *)msk);
+		msk = NULL;
+	}
+
+out:
+	return msk;
+}
+
+int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+{
 	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
-	u32 token_val;
 
-	if (!addr || !token) {
+	if (!addr) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
 		return err;
 	}
 
-	token_val = nla_get_u32(token);
-
-	msk = mptcp_token_get_sock(sock_net(skb->sk), token_val);
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return err;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto announce_err;
-	}
-
 	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
@@ -271,7 +286,6 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
@@ -279,30 +293,21 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	LIST_HEAD(free_list);
 	int err = -EINVAL;
 	struct sock *sk;
-	u32 token_val;
 	u8 id_val;
 
-	if (!id || !token) {
+	if (!id) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
 		return err;
 	}
 
 	id_val = nla_get_u8(id);
-	token_val = nla_get_u32(token);
 
-	msk = mptcp_token_get_sock(sock_net(skb->sk), token_val);
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return err;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto out;
-	}
-
 	if (id_val == 0) {
 		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
 		goto out;
@@ -336,7 +341,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
@@ -344,28 +348,18 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
-	u32 token_val;
 
-	if (!laddr || !raddr || !token) {
+	if (!laddr || !raddr) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
 		return err;
 	}
 
-	token_val = nla_get_u32(token);
-
-	msk = mptcp_token_get_sock(genl_info_net(info), token_val);
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return err;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto create_err;
-	}
-
 	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
@@ -468,35 +462,24 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_addr_info addr_l;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
 	int err = -EINVAL;
-	u32 token_val;
 
-	if (!laddr || !raddr || !token) {
+	if (!laddr || !raddr) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
 		return err;
 	}
 
-	token_val = nla_get_u32(token);
-
-	msk = mptcp_token_get_sock(genl_info_net(info), token_val);
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return err;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto destroy_err;
-	}
-
 	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
@@ -559,30 +542,18 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct net *net = sock_net(skb->sk);
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
-	u32 token_val;
 	u8 bkup = 0;
 
-	token_val = nla_get_u32(token);
-
-	msk = mptcp_token_get_sock(net, token_val);
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return ret;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "userspace PM not selected");
-		goto set_flags_err;
-	}
-
 	ret = mptcp_pm_parse_entry(attr, info, false, &loc);
 	if (ret < 0)
 		goto set_flags_err;
@@ -619,30 +590,20 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 		DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
 	} *bitmap;
 	const struct genl_info *info = genl_info_dump(cb);
-	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	struct nlattr *token;
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *hdr;
 
 	bitmap = (struct id_bitmap *)cb->ctx;
-	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 
-	msk = mptcp_token_get_sock(net, nla_get_u32(token));
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return ret;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto out;
-	}
-
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_for_each_address(msk, entry) {
@@ -667,7 +628,6 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	release_sock(sk);
 	ret = msg->len;
 
-out:
 	sock_put(sk);
 	return ret;
 }
@@ -676,28 +636,19 @@ int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
 				struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_pm_addr_entry addr, *entry;
-	struct net *net = sock_net(skb->sk);
 	struct mptcp_sock *msk;
 	struct sk_buff *msg;
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *reply;
 
-	msk = mptcp_token_get_sock(net, nla_get_u32(token));
-	if (!msk) {
-		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+	msk = mptcp_userspace_pm_get_sock(info);
+	if (!msk)
 		return ret;
-	}
 
 	sk = (struct sock *)msk;
 
-	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto out;
-	}
-
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		goto out;
-- 
2.43.0

