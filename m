Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E91188CC9
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075347; cv=none; b=Ew0xS7e775woI18cwkMW9x5A7KAXtKwdYdBC8eFMXh/9ajwg+4q+cowpE5He4K4Ose1ZTODTbN9yjYsoIZXpw5xwc1wgOYDliD1Y5Qk8vqSq8+e/dEDfpASaR2zQ553LG3LYU/RbsKoHiGWjzNz3SIPlh+in4DP2KSnySMBRThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075347; c=relaxed/simple;
	bh=3W8MExl9zIcqR8Zyz3r8AmqznSKWrI50ntDkiRouaHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRHGPZzuoYb+sodS/DdFCoa/Xcg1vkpBkPGoDcVzJ9GNyQHx0W9T+b2tZSdClc6EtnnJCFeOZ3A4OY6LzqFjn3v4+3zQzaI1xs1drHc9cmEMpDfwVyjRxxgnoPZUVzyGvEZdGmdwQiGxpzscuME7W1/g7pk6kCN9n68VFGU5pjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fazg+nA4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fazg+nA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA08AC4CED0;
	Fri, 13 Dec 2024 07:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075347;
	bh=3W8MExl9zIcqR8Zyz3r8AmqznSKWrI50ntDkiRouaHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fazg+nA4XCZ7MrgfCfNokxOWt673RyK1wskMIkDWNivUKRWMfFpx2q0fbunJqaprb
	 XiA3LKylYDaPvPoJs02DByshMSNPtNiRn1NxLBZLDJ6qag8+pB0AZq6bj7V5450NYb
	 vRG2RfEmhMJKFTSWST0Sx3C3SKOHp7Pqly4B5tFAL1kuI9aMsUusmPIkxHwkTdtmhZ
	 jK8VP4RJ//2sifPL2ESIrYTP5HRzaHO8YvAeGo7++UzQ8Getr83rBet0vnRtb4rYaN
	 oboseBrQLjXOkdL9ivZr4hx3zo4FxJ8ILtCbWLu4cfVzv0+KwFg0dNQaWaTlZYQ5mi
	 wOGJg7ZYMR7qg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/8] mptcp: reuse sending nlmsg code in get_addr
Date: Fri, 13 Dec 2024 15:35:25 +0800
Message-ID: <cff80604d6dc61ebee0f07240b2cac515a89c87d.1734074788.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734074788.git.tanggeliang@kylinos.cn>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
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

