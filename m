Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66CC2C6
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494593; cv=none; b=NJUvlhcgE6B8VYFCraSNi7TlGNexj4cY3glOXTt1STktGEWstsIWX8tBTnv7WLKuvzfuo2B5mkjyHgJCJu2Gb/6IW9ILq1Q+7o7FMGOwbPCFboJ2t5MylIaKjZ26mX9IMhbqF+Pmg5bavhJjHGt6ks3cWk11seW79esbW6tofuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494593; c=relaxed/simple;
	bh=4dkcoBMJ0in5La0n6Okqu5Qp0d+bY/UhkK7JOp2i4rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aS6SLXqpxVPC39SO5lY8a28J+33s4KOr7Ya5E+3HwtESVXpDNxCw82wjTYqNPgn4PoVZS9WZGHMWstN/r8m8nQeAAIboHlCevhPJlxRnooJHAsw9UambsZIxthC4Q3n4o8azLZx0VDDQg/vEq3J8IwMZ2ZMgPYp1/0GmXG/wvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj/cY26k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj/cY26k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0C9C4CED6;
	Fri, 10 Jan 2025 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494592;
	bh=4dkcoBMJ0in5La0n6Okqu5Qp0d+bY/UhkK7JOp2i4rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sj/cY26krS0zGiC9zkOkFyxmxG2asLb4+a4n8u/8jIPaF3lDuFCTdf849ZzlupqE0
	 Gzc8yH2NHHbHH7x8tDuTzsO7VadaAFiBfUKBrexAHD6lyC8Rc3d4aZ7uwSKiPrMDXL
	 dz07hQO38KP76/TzTuotX125uXsJ16lvL0W7sdFOohBHbY5RuHzvJeafWqN/BO6Bm/
	 HY28KsPhURsrLrAza9zKeHOwMiBUUk+TUEwIlXyjP6NTzpjykmGvjsVTc3Qd1VWiEy
	 tDkEr9xN37MSFoeaFIOEo/PjdSHTBDQmSflWqHjB8IgUgphpWOZSBh7SUURhku8mb3
	 FxNy2Ea5cc1Kg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/7] mptcp: reuse sending nlmsg code in get_addr
Date: Fri, 10 Jan 2025 15:36:17 +0800
Message-ID: <f375a6d78670d1685088a341ab0d97d32ab548f0.1736494320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736494320.git.tanggeliang@kylinos.cn>
References: <cover.1736494320.git.tanggeliang@kylinos.cn>
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
index ab948a9fcfe8..181d3b87eb25 100644
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
index 9a974fe0d992..eaa02879de43 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -683,15 +683,13 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
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
@@ -699,46 +697,16 @@ int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 
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

