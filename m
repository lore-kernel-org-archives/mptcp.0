Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCD0170A23
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689513; cv=none; b=lqEJiCntkfFehttg4D4duDM6II75r4gkkcZtFuuBD6KjRI5ieidSh3JPMMeHV467N7pMU8zSUx9HN4mAtoxtIFINoV04p/h639ZlPT0/5P9ITYeArG0JQeDuDM+F2OsrTZmRddB5ussWIkjXb1F7zRZlHrTQ4zd7jMu6PGKmK2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689513; c=relaxed/simple;
	bh=OdtqH+EW79DCjVhPSxD2MusBhrNH29iJNbInAeS7LRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hclbh0B7T3R8Vy/L/aWpF67uLqFTj35h5KuYCA84xoYna7UrXOSygvHB3hZVrQ+h8cESO6yXHimQiQwoXIufT5221Pnv8M09xqEGhA0BVboy3uNjOyd1IV6p+lWW4xtFHDYTA3wxuVdU9SxDKEQ7Hn2YjLPzSesinyOkP9ZkO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBMGJ7Mu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBMGJ7Mu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C31BC4CEC7;
	Mon, 30 Sep 2024 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727689513;
	bh=OdtqH+EW79DCjVhPSxD2MusBhrNH29iJNbInAeS7LRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBMGJ7MutKNWu9rohewnjOT9wHIKNCboo0aNUC7qpCKcFzqfidrxN0+yDPWrSwlwo
	 +K9+HNMlFP4EHN+G99aptbmSaD/LmcHTZCpH+blZhl9GLY3jzRxSVMvpkKozU7AnUr
	 afB8+YUWUy72+/QBx+7DC1DUlPAGdYBIFGzjNrLquJffEGox4IHqs032vYrM8ekuGy
	 /NO14d16cwBWQkN52ZUwd91nwg4c1YvA2M8QOphTzoRLsIkqgLaRNWQgzlalLnaUQ7
	 B9vkB46G5LJpHEB6OXKr7TkIxwkWWO3xfPRCfyYX1URe66mE5nuDxcJ/sJULtOjHot
	 ymCwCl5caea0Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/7] mptcp: reuse sending nlmsg code in get_addr
Date: Mon, 30 Sep 2024 17:44:58 +0800
Message-ID: <7d7f1396fc257ea68fbb8a2c41413c98257ac6e6.1727689369.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727689369.git.tanggeliang@kylinos.cn>
References: <cover.1727689369.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With the previous commit, we can reuse the send_nlmsg() code in
get_addr() interfaces between the netlink PM and userspace PM.
They only need to implement their own get_addr() interfaces to
hold the different locks, get the entry from the different lists,
then release the locks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 58 ++++++++++++++++++++--------------------
 net/mptcp/pm_userspace.c | 32 ----------------------
 2 files changed, 29 insertions(+), 61 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b646f97f6afe..ef47b54d8328 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1795,21 +1795,7 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry *entry;
-	struct sk_buff *msg;
 	int ret = -EINVAL;
-	void *reply;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  info->genlhdr->cmd);
-	if (!reply) {
-		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
-		ret = -EMSGSIZE;
-		goto fail;
-	}
 
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, id);
@@ -1819,21 +1805,6 @@ static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	}
 	spin_unlock_bh(&pernet->lock);
 
-	if (ret) {
-		GENL_SET_ERR_MSG(info, "address not found");
-		goto fail;
-	}
-
-	ret = mptcp_nl_fill_addr(msg, addr);
-	if (ret)
-		goto fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
-	return ret;
-
-fail:
-	nlmsg_free(msg);
 	return ret;
 }
 
@@ -1849,13 +1820,42 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr;
+	struct sk_buff *msg;
+	void *reply;
 	int ret;
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
 	if (ret < 0)
 		return ret;
 
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
+				  info->genlhdr->cmd);
+	if (!reply) {
+		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
+		ret = -EMSGSIZE;
+		goto fail;
+	}
+
 	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
+	if (ret) {
+		GENL_SET_ERR_MSG(info, "address not found");
+		goto fail;
+	}
+
+	ret = mptcp_nl_fill_addr(msg, &addr);
+	if (ret)
+		goto fail;
+
+	genlmsg_end(msg, reply);
+	ret = genlmsg_reply(msg, info);
+	return ret;
+
+fail:
+	nlmsg_free(msg);
 	return ret;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 80cb2c6508ba..7c0bb084303b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -675,10 +675,8 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	struct net *net = genl_info_net(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	struct sk_buff *msg;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *reply;
 
 	msk = mptcp_token_get_sock(net, nla_get_u32(token));
 	if (!msk) {
@@ -693,20 +691,6 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 		goto out;
 	}
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  info->genlhdr->cmd);
-	if (!reply) {
-		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
-		ret = -EMSGSIZE;
-		goto fail;
-	}
-
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
@@ -717,22 +701,6 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
 
-	if (ret) {
-		GENL_SET_ERR_MSG(info, "address not found");
-		goto fail;
-	}
-
-	ret = mptcp_nl_fill_addr(msg, addr);
-	if (ret)
-		goto fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
-	sock_put(sk);
-	return ret;
-
-fail:
-	nlmsg_free(msg);
 out:
 	sock_put(sk);
 	return ret;
-- 
2.43.0

