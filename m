Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21EE198E80
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736310085; cv=none; b=oMl7z7YwLmA5YUzzx29DT/ggXqJKwqfCwk0bIYepOC0uzYH7gI/wHhph8ShzApv+IB3uH07iPr2Iz5+wrM1wyRepg7jhnPofTGMuUdd0DZpEnSplXg9reePBg/P2RVAnkfqgHWcfKqGA/Ka0RfHilz6nGl5u4hfx5wA+sxi4B/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736310085; c=relaxed/simple;
	bh=cEEDlSGqWNx/G7yCKuCDpDk71t4EOFNnzBEVNJnefic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7PUR6TDZkyhYqalgt6Aym4FNHpU93sBgXR/k9jLEMZxlu7CYBKMT8ATGfbsuzWBqM594sYKFgr3EH91LZdqUF06/tn5208sjkieu6GZEv7dm1MjSc567lmaNMv+Uk1s2BQOrVsuiEe/Jw5DGlzWFd780pWSldkroqcybq5eiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nkkdmk6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nkkdmk6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B01C4CEE2;
	Wed,  8 Jan 2025 04:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736310085;
	bh=cEEDlSGqWNx/G7yCKuCDpDk71t4EOFNnzBEVNJnefic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nkkdmk6IdmBDkc0+RJ6ZfyLN5WCvce6Rq7Zw8phcy9yHLAU5WTtAMVlzGzwg3D3aQ
	 88tdtzw/BvDwVRPqG5ESI09IsYeZlEnsJpvTm9b4bVbtB+/ixplijsMapONeehrvl9
	 FHYm63J2KvR1ALyDD7kdkZDrGjWuL4/hH4dWVBDmgHYQDmcIylsbFklZHPoLF05RWb
	 Mpn3lk9fQiQ7QuCXVlo1Ja9/Qq0NvDP0+iho5/jfI/Zk3HXWgIdeN0omljynhzTq0d
	 6h0dDOrR9HAS0tBUfZWToVj7K4lo41wBsI+LI2+VVuGyixN9Azum0tnblGm6Bw3qmP
	 cL2nx1c4rfw7Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/8] mptcp: reuse sending nlmsg code in get_addr
Date: Wed,  8 Jan 2025 12:21:08 +0800
Message-ID: <1473334ecc24db88104fa3690d3a61a81a77cb46.1736308884.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736308884.git.tanggeliang@kylinos.cn>
References: <cover.1736308884.git.tanggeliang@kylinos.cn>
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
The former uses rcu read lock, and the latter uses msk->pm.lock.

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

This way we can reuse the send_nlmsg() code in get_addr() interfaces
between the netlink PM and userspace PM. They only need to implement their
own get_addr() interfaces to hold the different locks, get the entry from
the different lists, then release the locks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 39 +++++++++++++++++++++++++++++++++----
 net/mptcp/pm_netlink.c   | 40 ++++++--------------------------------
 net/mptcp/pm_userspace.c | 42 +++++-----------------------------------
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 50 insertions(+), 77 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index caf5bfc3cd1d..ba22d17c1451 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,17 +434,20 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
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
 {
 	struct mptcp_pm_addr_entry addr;
 	struct nlattr *attr;
+	struct sk_buff *msg;
+	void *reply;
 	int ret;
 
 	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
@@ -455,7 +458,35 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	return mptcp_pm_get_addr(addr.addr.id, info);
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
+	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
+	if (ret) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
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
+	return ret;
 }
 
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 89a720ce432a..ad7816cafcd4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1773,49 +1773,21 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
+int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			 struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry *entry;
-	struct sk_buff *msg;
-	struct nlattr *attr;
-	void *reply;
-	int ret;
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
+	int ret = -EINVAL;
 
 	rcu_read_lock();
 	entry = __lookup_addr_by_id(pernet, id);
-	if (!entry) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
-		ret = -EINVAL;
-		goto unlock_fail;
+	if (entry) {
+		*addr = *entry;
+		ret = 0;
 	}
-
-	ret = mptcp_nl_fill_addr(msg, entry);
-	if (ret)
-		goto unlock_fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
-	rcu_read_unlock();
-	return ret;
-
-unlock_fail:
 	rcu_read_unlock();
 
-fail:
-	nlmsg_free(msg);
 	return ret;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ca30139d649d..3d69e37f27c6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -684,15 +684,13 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	struct sk_buff *msg;
-	struct nlattr *attr;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *reply;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -700,46 +698,16 @@ int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
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
-	if (!entry) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
-		ret = -EINVAL;
-		goto unlock_fail;
+	if (entry) {
+		*addr = *entry;
+		ret = 0;
 	}
-
-	ret = mptcp_nl_fill_addr(msg, entry);
-	if (ret)
-		goto unlock_fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
-	sock_put(sk);
-	return ret;
 
-unlock_fail:
-	spin_unlock_bh(&msk->pm.lock);
-	release_sock(sk);
-fail:
-	nlmsg_free(msg);
-out:
 	sock_put(sk);
 	return ret;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 14d6b6be0483..a43481c40577 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1124,8 +1124,10 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info);
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
+int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			 struct genl_info *info);
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.45.2

