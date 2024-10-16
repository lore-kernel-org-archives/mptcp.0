Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6601205E04
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069983; cv=none; b=tTJkt5IUOWWwOcZGhi646M0ZyKoMJzvz1QwqI8+Nyg0rWVQlDp/Oalt2Easl+6e9+aDrT8oCNzM/b5+lcxXWRkOMb1uKNMV/useNuqeE0QhW+2l2aK65vF5Z6e9sZIIOjtH3XuyhniuwA57WfPInArtC9BqtdBGsN/6fYiXl8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069983; c=relaxed/simple;
	bh=NnpShtCsmWhqFIS0vooxuASxjfo2lXyGvepMupASBis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqGpD0Z7nRityve3GGD0IXYyFn29270kBR+QKS8Rt2jAXcL99zmA9+ZWX5HqE4GL4qdK1c2S1axBlOtYsi5ZcVPSdCtg9Tp43msWBvO3Qy8z839sTf3QrdOiUisYwrsk+f2x8YQBhk4pZO6gweWLlS5Ei+it7HUbEcP0DUwjmCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACN4qeyr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACN4qeyr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C364C4CEC5;
	Wed, 16 Oct 2024 09:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729069982;
	bh=NnpShtCsmWhqFIS0vooxuASxjfo2lXyGvepMupASBis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACN4qeyrlX2V6fyanFteurFh+6eSo/ulq/0sZIIEdqSHw73LUhWB3hydMkdn1VFUN
	 lPpIpMvEEHA9sCwf4zmkmYaVPBDUhu7XE1rVf1ZS5LuzvE+/70yZo54UHCm0fgUBw7
	 NSxT12Nt/Gdsn9iRFsC3/taoiXEnoYMljLElHppUyWv6bEzKTSfFHLI93u865eYp7L
	 ufADE27w0CUswAw3TWf1xY78Gaai9Wrm6qM1hUovaA9YlAMxPlqzjqVqR6BZbpExky
	 GuhyFyxPt9/R8OM3f1bd2QOyAUpIhZMg4g5q8U34oIRWzcED1wXyYr3ucg3FdOrjTa
	 muVpnWHgfmOXA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 10/33] mptcp: add addr parameter for get_addr
Date: Wed, 16 Oct 2024 17:12:14 +0800
Message-ID: <862b1207f395a4a45c709eec5e67308e9adad801.1729069854.git.tanggeliang@kylinos.cn>
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
index be9d1aa3377f..5d9e72fbddf3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1792,13 +1792,14 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
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
@@ -1814,34 +1815,36 @@ static int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
 
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
@@ -1854,7 +1857,7 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	ret = mptcp_pm_get_addr(addr.addr.id, info);
+	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
 	return ret;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 079baceb9ca1..d1f2b592b47c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -632,7 +632,8 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
@@ -664,26 +665,27 @@ int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
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
index 8ee0617209af..364f121f69c8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1126,7 +1126,8 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
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

