Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB115D5C1
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298410; cv=none; b=fHs6AEyl7SEoJgjra4jVcTYoooVNSrrbxb3h7Ss8qumz6WZsg3nLG4QNwWzufDJjfFEdcFfGcu+24iqU2Jb4y4wXd+tn5t58P3XeGDKqpu/+L82GkNMa+x5XOVwnR3fe63aaTfBkoArqpsLiKFSob/6RZjDhLWZhhguudZxNXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298410; c=relaxed/simple;
	bh=/u3gCX8BHNF2cTPDn+WFIzR7nDhtLd1k4baWkqqlp8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nmt+/y+eBD6MqibwYzAsj45s72ddIGznu7jTxJ6lQbYjVH2lMArj2BXyFZk1zFhoYfgXlNZC9a9Dj8TvsZTk5figlJVY7HA9V76LyB5SG1NS2Vd4WV1nToDSHwYv2AUWRG2zEGXPBp8l6bFIegNDU4J/p0G0XQOH9Op5uliQ9h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMrBhU7Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMrBhU7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1082C4CECC;
	Mon,  7 Oct 2024 10:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728298410;
	bh=/u3gCX8BHNF2cTPDn+WFIzR7nDhtLd1k4baWkqqlp8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMrBhU7Za10sB2ZYXg5KSgZ5ALGbDNhtFqPUnQS+nJg4PJcC1ZMNOmHy4b2aTsLdW
	 +kD7XiVsfvknj7CNJYsJrNVj87QJqp1qOw0OLlOea5RYBCi8rNk9nyvHmV8tsnkkk3
	 xpF4dZdzt4M77CrA5tw17LwcKL28+sf2XcYfQQbzSxSKFynXz+1sRCB1ug0susd60Q
	 UiefXpr05649q49+qhBMuSV4XaM5uEJSK675ij5pgrN5OwLMxE/DhyXSSevY5K86pH
	 uDNVp+ZGrPLrgP3ue2P6ToPesLeC1Q60T6jtbjRJkyDNRJ/ruULdUITFPrX6i471nu
	 haocl6477M8cA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 02/10] mptcp: add mptcp_userspace_pm_get_sock helper
Date: Mon,  7 Oct 2024 18:53:14 +0800
Message-ID: <ad83b40893519c6a056255dcfaf1bd34c6c539fe.1728298100.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728298100.git.tanggeliang@kylinos.cn>
References: <cover.1728298100.git.tanggeliang@kylinos.cn>
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
Finally check whether userspace pm is selected on this msk. It makes
sense to wrap them into a helper, named mptcp_userspace_pm_get_sock(),
to do this.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 137 +++++++++++++--------------------------
 1 file changed, 44 insertions(+), 93 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e3f29d8865f4..6aaf10b8ddd1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -166,36 +166,51 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
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
@@ -268,7 +283,6 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
 
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
@@ -276,30 +290,21 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -333,7 +338,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
@@ -341,28 +345,18 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -465,35 +459,24 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
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
@@ -556,30 +539,18 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
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
@@ -613,31 +584,21 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb)
 {
 	const struct genl_info *info = genl_info_dump(cb);
-	struct net *net = sock_net(msg->sk);
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_id_bitmap *bitmap;
 	struct mptcp_sock *msk;
-	struct nlattr *token;
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *hdr;
 
 	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
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
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
@@ -662,7 +623,6 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	release_sock(sk);
 	ret = msg->len;
 
-out:
 	sock_put(sk);
 	return ret;
 }
@@ -671,28 +631,19 @@ int mptcp_userspace_pm_get_addr(struct sk_buff *skb,
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

