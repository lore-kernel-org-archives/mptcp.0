Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8117BB32
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689512; cv=none; b=jbSzcgWyEARnLKyoFG0fJyAJj7RvEB59E9MCP8bZnWsKzbnITetiN8V1pMlRBAfrzWhUmteQexnrgBFKd02SqARv+4w4a5LTEreqOxqgvRv9hlv7PwcoM9QA0nDpK7DMv+57ol6yrTEtrCnXvaf0OMrXdSk4fG/gc67vttjLM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689512; c=relaxed/simple;
	bh=nNRqH34t9uBqY9IuvhgW93di59EvStO48hyQNz05ORk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mgcxfo73tTUwTqz1Oo3cGUqev3xjGuvQKMcxg42+ZlrWcOWVCPlxfVKyWuY7eH/61EjbNyvWYIvxxEN+K3jjV/PiOQ1ncYWDgRuV1sy7RYePAcSWxJxcnBhxtOuClPLvhVKav5wYDDVhQMTgEf7wUcNwvf1rOD08U+H0+Axfb9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCyj3Gi+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCyj3Gi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B07C4CEC7;
	Mon, 30 Sep 2024 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727689511;
	bh=nNRqH34t9uBqY9IuvhgW93di59EvStO48hyQNz05ORk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCyj3Gi+6uxPXeV202Pmbhb+NXNGtq/UvWRWbXFNs7CZw1O/2Hj+160Snr8Vj+A59
	 JivucvTM3FBLZDlxoTtunRdln68UFqfPEvdomaMgV5miWcAvbe2zksJKx6+h7BI1ea
	 gFthv50rVpoYuYG7w0EuDVeTfCCFNbckJ8UMJ1xBDoCZyww1o3NNXnMaZ+f2juEHmT
	 OWMI0zzpzW5iKwc0qfnzWhtdwahO3bp362u9pzkfYpbebq9n67MSPSQCwKnDN8SKSw
	 HHUTdauMGSb9iAQgJKnD+W4+1GPt2rf1e6myeQ9lnLobfgeTP14DQbpTQvkK9TZ2gT
	 4D/Di6IJlS/dA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/7] mptcp: add addr parameter for get_addr
Date: Mon, 30 Sep 2024 17:44:57 +0800
Message-ID: <f1b6bfa3e91d3687e34a0217cd4a059d27b52a7a.1727689369.git.tanggeliang@kylinos.cn>
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

The netlink messages are sent both in mptcp_pm_nl_get_addr() and
mptcp_userspace_pm_get_addr(), this makes the code somewhat repetitive.
This is because the netlink PM and userspace PM use different locks to
protect the address entry that needs to be sent via the netlink message.
The former uses pernet->lock, and the latter uses msk->pm.lock.

The current get_addr() flow looks like this:

	lock();
	entry = get_entry();
	send_nlmsg(entry);
	unlock();

After holding the lock, get the entry from the list, send the entry, and
finally release the lock.

This patch changes the process by getting the entry while holding the lock,
then making a copy of the entry so that the lock can be released. Finally,
the copy of the entry is sent without locking:

	lock();
	entry = get_entry();
	*copy = *entry;
	unlock();

	send_nlmsg(copy);

This way we can reuse this send_nlmsg() code between the netlink PM and
userspace PM.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 33 ++++++++++++++++++---------------
 net/mptcp/pm_userspace.c | 24 +++++++++++++-----------
 net/mptcp/protocol.h     |  3 ++-
 3 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9b09ec22eeca..b646f97f6afe 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1790,13 +1790,14 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
+static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct sk_buff *msg;
+	int ret = -EINVAL;
 	void *reply;
-	int ret;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -1812,34 +1813,36 @@ static int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
 
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, id);
-	if (!entry) {
+	if (entry) {
+		*addr = *entry;
+		ret = 0;
+	}
+	spin_unlock_bh(&pernet->lock);
+
+	if (ret) {
 		GENL_SET_ERR_MSG(info, "address not found");
-		ret = -EINVAL;
-		goto unlock_fail;
+		goto fail;
 	}
 
-	ret = mptcp_nl_fill_addr(msg, entry);
+	ret = mptcp_nl_fill_addr(msg, addr);
 	if (ret)
-		goto unlock_fail;
+		goto fail;
 
 	genlmsg_end(msg, reply);
 	ret = genlmsg_reply(msg, info);
-	spin_unlock_bh(&pernet->lock);
 	return ret;
 
-unlock_fail:
-	spin_unlock_bh(&pernet->lock);
-
 fail:
 	nlmsg_free(msg);
 	return ret;
 }
 
-static int mptcp_pm_get_addr(u8 id, struct genl_info *info)
+static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			     struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(id, info);
-	return mptcp_pm_nl_get_addr(id, info);
+		return mptcp_userspace_pm_get_addr(id, addr, info);
+	return mptcp_pm_nl_get_addr(id, addr, info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
@@ -1852,7 +1855,7 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	ret = mptcp_pm_get_addr(addr.addr.id, info);
+	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
 	return ret;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 22ea1b8a11e3..80cb2c6508ba 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -668,7 +668,8 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct net *net = genl_info_net(info);
@@ -709,26 +710,27 @@ int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
-	if (!entry) {
+	if (entry) {
+		*addr = *entry;
+		ret = 0;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+
+	if (ret) {
 		GENL_SET_ERR_MSG(info, "address not found");
-		ret = -EINVAL;
-		goto unlock_fail;
+		goto fail;
 	}
 
-	ret = mptcp_nl_fill_addr(msg, entry);
+	ret = mptcp_nl_fill_addr(msg, addr);
 	if (ret)
-		goto unlock_fail;
+		goto fail;
 
 	genlmsg_end(msg, reply);
 	ret = genlmsg_reply(msg, info);
-	spin_unlock_bh(&msk->pm.lock);
-	release_sock(sk);
 	sock_put(sk);
 	return ret;
 
-unlock_fail:
-	spin_unlock_bh(&msk->pm.lock);
-	release_sock(sk);
 fail:
 	nlmsg_free(msg);
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 07cb80be98cb..4342be369914 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,7 +1127,8 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0

