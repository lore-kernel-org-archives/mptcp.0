Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7533987
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382914; cv=none; b=PalIE2qjXZpp+tTPTNEOJEkcvwQbHWDBhVkuFXxHILn7pTJ88bOP0Cwi678yLJUxLftRO1mDkSROHU8jvHO1Z72eO6kZ9bYzQneg868idQuGARi13FQKn0wpqSJiM/cGUJLJxuXM+fK94tlan0NDX7ky649/ldGQYrqM3rXJfhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382914; c=relaxed/simple;
	bh=iF+yVEngQsM8pod0s4X8LO+fbay/FWDDzOeidkhlsCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWIhcOrbWO5/1H18QkZYRsbD5Bfld4A2Erp6zJ6F4Ei0B73GOVO72lcSPZi9+umQt7ZD2D1BlgMqwkuwu0y38Py9gcIgReTVhPa+/ne9G83eAyNfqdWT/NReo6wBqXni0WFWNMrt2ng+zs3dNRS8TMkcQ0TuUvrew3nIlELBAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtrAKsPf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtrAKsPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA3AC4CED1;
	Thu,  5 Dec 2024 07:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733382914;
	bh=iF+yVEngQsM8pod0s4X8LO+fbay/FWDDzOeidkhlsCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtrAKsPfM6SnDLcey5kL1QrrTq0c7bjdwZxHmh3F0EDqw97yRl7XjssNhS2tK7IyM
	 nqqlzPEfTiaYJbGzLjUVWYoWaqibrG29a3BBL+IopPkWHfW9RYLW08Dh4w3WwRk+8x
	 LRQ8Ax87Gb+kG283Y2PrNfqxWgtS+AMj1OhHb2uouWHUQ/hMzeDmx0hVUxOxK294uf
	 W2kwjIYTPUdyhM/VbYhgI0h5pb061Iu/NWeTIoLIZWDsMdq13l/xsgNi4DUJdHNniz
	 LZFTCKrunPxSyisVftNi5eR6uIheCM1bBxX/NFvJEpHWmP68zD8who5XV/qNVM4RUA
	 vYolO5CQiBlXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/7] mptcp: add mptcp_userspace_pm_get_sock helper
Date: Thu,  5 Dec 2024 15:14:55 +0800
Message-ID: <439ccbf577e94905db34b3f97aeeac547b3f6d42.1733382223.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733382222.git.tanggeliang@kylinos.cn>
References: <cover.1733382222.git.tanggeliang@kylinos.cn>
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

This patch doesn't change the behaviour of the code, just refactoring.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 144 +++++++++++++--------------------------
 1 file changed, 47 insertions(+), 97 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c99ec28c1bd5..a6de837d8958 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -172,36 +172,50 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 	return backup;
 }
 
-int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
+static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
+	struct mptcp_sock *msk;
+
+	if (!token) {
+		GENL_SET_ERR_MSG(info, "missing required token");
+		return NULL;
+	}
+
+	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
+	if (!msk) {
+		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
+		return NULL;
+	}
+
+	if (!mptcp_pm_is_userspace(msk)) {
+		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		sock_put((struct sock *)msk);
+		return NULL;
+	}
+
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
-		GENL_SET_ERR_MSG(info, "missing required inputs");
+	if (!addr) {
+		GENL_SET_ERR_MSG(info, "missing required address");
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
@@ -274,7 +288,6 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
@@ -282,30 +295,21 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	LIST_HEAD(free_list);
 	int err = -EINVAL;
 	struct sock *sk;
-	u32 token_val;
 	u8 id_val;
 
-	if (!id || !token) {
-		GENL_SET_ERR_MSG(info, "missing required inputs");
+	if (!id) {
+		GENL_SET_ERR_MSG(info, "missing required ID");
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
@@ -342,7 +346,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
@@ -350,28 +353,18 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
-	u32 token_val;
 
-	if (!laddr || !raddr || !token) {
-		GENL_SET_ERR_MSG(info, "missing required inputs");
+	if (!laddr || !raddr) {
+		GENL_SET_ERR_MSG(info, "missing required address(es)");
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
@@ -474,35 +467,24 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
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
-		GENL_SET_ERR_MSG(info, "missing required inputs");
+	if (!laddr || !raddr) {
+		GENL_SET_ERR_MSG(info, "missing required address(es)");
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
@@ -565,31 +547,19 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
 	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct net *net = sock_net(skb->sk);
 	struct mptcp_pm_addr_entry *entry;
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
@@ -636,30 +606,20 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
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
 	mptcp_for_each_userspace_pm_addr(msk, entry) {
@@ -684,7 +644,6 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	release_sock(sk);
 	ret = msg->len;
 
-out:
 	sock_put(sk);
 	return ret;
 }
@@ -693,28 +652,19 @@ int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
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
2.45.2

