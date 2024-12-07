Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BC622C6DC
	for <mptcp@lists.linux.dev>; Sat,  7 Dec 2024 01:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733533696; cv=none; b=AdK2kxKvdQw+/5z7z8zsNd4CtVJinzkDnrVd1y2oe1Ykr/4QX3e74OAR0QcAD5YmQMQl5lc9rOmkEHUN7x1Ur2jDBEvfKK2sKP7Gtq5qqf2aEFt20Ffo+jWz8girZtV6KkiAEOOTmjfN1UW1ms560IuV769g/LPgqg8gLHvMB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733533696; c=relaxed/simple;
	bh=3W8MExl9zIcqR8Zyz3r8AmqznSKWrI50ntDkiRouaHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZaRu0qci1w9+75xER/YWO9pFOFar8gjY+7Y6pvtT0HG7R/dTYJCyt93CdnBM50jjrsTctcLWesjfmkxtUk9tpaEsWmKWMRfouO/hwsqyO47iTT3HKVKSDt3aFSEW8YHepgnTc9ByXT4ENVQtfExvhsX8KO422FJQqtB5OO0ueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pm6XVb/U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm6XVb/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154C9C4CED2;
	Sat,  7 Dec 2024 01:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733533695;
	bh=3W8MExl9zIcqR8Zyz3r8AmqznSKWrI50ntDkiRouaHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pm6XVb/Uq6r9+8u7oGSwS71j+8SUcZWUfxtMR3el0f3wdvkzcwhkO1AVcJymgIzZS
	 21vn0YE4XdGHd5jboZsh4OEqYUk7CN50qoq5lxvMriq5tCKDZazBpBfbz6XREXHcy5
	 GYFFvUBMMCQiYMuEsdFFMxCdYx9DNWH/lPTuU/evrghBn9ZkY8OMHheF5Cu+Nwf3kg
	 NocGsFKh+cbU9znGSJqysrq+YG/ZstVm4XjdCapxXuN6Rx1hF3HVbgRjrVzg/JfeMD
	 6hk0hBtJ0yDRRbjaHq9YhQtj/ghAVs+J+gUq1Ik4otxjTer8d8dzw9Xilf73nSOuGJ
	 /1/tHF7BhtNyQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/7] mptcp: reuse sending nlmsg code in get_addr
Date: Sat,  7 Dec 2024 09:07:24 +0800
Message-ID: <0c8358438b3ff44b76f95972f437a3b4a63c1190.1733533215.git.geliang@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733533215.git.geliang@kernel.org>
References: <cover.1733533215.git.geliang@kernel.org>
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
 net/mptcp/pm.c           | 39 ++++++++++++++++++++++++++++++++++----
 net/mptcp/pm_netlink.c   | 39 ++++++--------------------------------
 net/mptcp/pm_userspace.c | 41 +++++-----------------------------------
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 50 insertions(+), 75 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c7d323c7c7aa..9f3d82a86746 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,24 +434,55 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
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
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct mptcp_pm_addr_entry addr;
+	struct sk_buff *msg;
+	void *reply;
 	int ret;
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
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
+	return ret;
 }
 
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index de6a8e7a4a1a..dce6a5b5ea4d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1762,48 +1762,21 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
+int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			 struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry *entry;
-	struct sk_buff *msg;
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
-		GENL_SET_ERR_MSG(info, "address not found");
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
index 40a018be243e..6dd5a3f1c0c7 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -663,14 +663,13 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	struct sk_buff *msg;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *reply;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -678,46 +677,16 @@ int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 
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
-		GENL_SET_ERR_MSG(info, "address not found");
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
index 76a0cfe54723..a80a0191e2cd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1131,8 +1131,10 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
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

