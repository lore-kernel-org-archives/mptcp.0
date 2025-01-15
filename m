Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A422E406
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924925; cv=none; b=m/uij9l/G537h5/VxAAKUQ3CrB/pA+8BcV4+0EBqOe39giItBZgpu45pNp6LftgdKcVXg0eWQNQtvFRWoGg9hgWjiQW8a0wRtjZDD6k+tS/VZs8wYeAYUr9DLsDpe/z+GljMuXxq98Z9nFO7VMoITVE2zMKnX0SlDKb+IyRkt1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924925; c=relaxed/simple;
	bh=LAV138qnnnVbF8SX3IChfKjVFZQyntkD5BpPKmnwrFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy0jU7fEFyH83LWdBjXeIdfYiulKOl6smvkN+kz77r7HQc52bizYgexM/MgJ2z/SiJ/1Mf8vSWQnEWkNG5UfXxvhYpXgUPmEV0DMgzX3qDJaUyTb3DnSL50dI7aHApgLYjjIRmATYlHe2LRxtHXYC6p5va3rIIbAz0RobedzXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8k08WB/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8k08WB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D770C4CEE1;
	Wed, 15 Jan 2025 07:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736924925;
	bh=LAV138qnnnVbF8SX3IChfKjVFZQyntkD5BpPKmnwrFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8k08WB/hNaK1ZNujfzaxOpU6wlpmO0fYwlryaIr9QQ4LwZ3tmJgy/idQEjWRs1hq
	 D3zv/E2AvbF8LrAlHHnqGcbivoqHDVLHlUAL8TV4/mbpHJu0LzuoqYhflz/k0LS/33
	 WqSmhpcNpzKtXWXD93fN6xtvw3y6XA7jMa1wl720pQwdNHzTZb8xnGOFnB8FyVmJa1
	 oNi6pl7ZEIoMCEdL7GZXAW+82ykXnrM87pU7RpQcvcBPtBNnx9C/gl5durLn83+Vzo
	 L++VGSIEI7TyU5iQ+MIDv62bn1ZDFHQL/Yw9KMh9GBRoIxigIUt29knTr50dkcyd6m
	 Xe7zcyaIkLWTg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] mptcp: register default userspace pm
Date: Wed, 15 Jan 2025 15:08:33 +0800
Message-ID: <d8cd935c5148deb124f99faa7f9186e87e53003c.1736924549.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736924549.git.tanggeliang@kylinos.cn>
References: <cover.1736924549.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original userspace pm as the default path manager,
named mptcp_userspace_pm, and register it in mptcp_pm_data_init().

Extract address_announce() interface of the userspace PM from the handler
of netlink commond MPTCP_PM_CMD_ANNOUNCE mptcp_pm_nl_announce_doit(), only
leave the code for obtaining msk through "info" and parsing address entry
in the handler.

Extract address_remove() interface of the userspace PM from the handler
of netlink commond MPTCP_PM_CMD_REMOVE mptcp_pm_nl_remove_doit(), only
leave the code for parsing address id and obtaining msk through "info"
in the handler.

Extract subflow_create() interface of the userspace PM from the handler of
netlink commond MPTCP_PM_CMD_SUBFLOW_CREATE

	mptcp_pm_nl_subflow_create_doit(),

only leave the code for obtaining msk through "info", parsing local address
entry and parsing remote address info in the handler.

Extract subflow_destroy() interface of the userspace PM from the handler of
netlink commond MPTCP_PM_CMD_SUBFLOW_DESTROY

	mptcp_pm_nl_subflow_destroy_doit(),

only leave the code for obtaining msk through "info", parsing local address
entry and parsing remote address info in the handler.

Extract set_flags() interface of the userspace PM from function
mptcp_userspace_pm_set_flags(), only leave the code for obtaining
msk through "info" in this function.

All fives interfaces are invoked under holding the msk socket lock.

Other interfaces get_local_id() and get_flags() are only defined as
wrappers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |   1 +
 net/mptcp/pm_userspace.c | 261 ++++++++++++++++++++++++---------------
 net/mptcp/protocol.h     |   1 +
 3 files changed, 165 insertions(+), 98 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a0f4d06692cc..aa0fee7c1b77 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -650,4 +650,5 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_nl_init();
+	mptcp_userspace_pm_init();
 }
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1530b0c9d0b4..ac4ccda43ce8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -135,8 +135,8 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_pm_addr_entry *local)
+static int userspace_pm_get_local_id(struct mptcp_sock *msk,
+				     struct mptcp_pm_addr_entry *local)
 {
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
@@ -154,8 +154,14 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, local, true);
 }
 
-u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
-				struct mptcp_addr_info *skc)
+int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_pm_addr_entry *local)
+{
+	return userspace_pm_get_local_id(msk, local);
+}
+
+static u8 userspace_pm_get_flags(struct mptcp_sock *msk,
+				 struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
 	u8 flags;
@@ -168,6 +174,12 @@ u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
 	return flags;
 }
 
+u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
+				struct mptcp_addr_info *skc)
+{
+	return userspace_pm_get_flags(msk, skc);
+}
+
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
 	struct mptcp_sock *msk;
@@ -193,6 +205,28 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	return msk;
 }
 
+static int userspace_pm_address_announce(struct mptcp_sock *msk,
+					 struct mptcp_pm_addr_entry *local)
+{
+	int err;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, local, false);
+	if (err < 0)
+		return err;
+
+	spin_lock_bh(&msk->pm.lock);
+
+	if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
+		msk->pm.add_addr_signaled++;
+		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_nl_addr_send_ack(msk);
+	}
+
+	spin_unlock_bh(&msk->pm.lock);
+
+	return 0;
+}
+
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr_val;
@@ -227,26 +261,13 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, false);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, addr,
-				    "did not match address and id");
-		goto announce_err;
-	}
-
 	lock_sock(sk);
-	spin_lock_bh(&msk->pm.lock);
-
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
-		msk->pm.add_addr_signaled++;
-		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
-		mptcp_pm_nl_addr_send_ack(msk);
-	}
-
-	spin_unlock_bh(&msk->pm.lock);
+	err = userspace_pm_address_announce(msk, &addr_val);
 	release_sock(sk);
+	if (err)
+		NL_SET_ERR_MSG_ATTR(info->extack, addr,
+				    "did not match address and id");
 
-	err = 0;
  announce_err:
 	sock_put(sk);
 	return err;
@@ -296,9 +317,32 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static int userspace_pm_address_remove(struct mptcp_sock *msk, u8 id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	if (id == 0)
+		return mptcp_userspace_pm_remove_id_zero_address(msk);
+
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+	if (!entry) {
+		spin_unlock_bh(&msk->pm.lock);
+		return -EINVAL;
+	}
+
+	list_del_rcu(&entry->list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	mptcp_pm_remove_addr_entry(msk, entry);
+
+	sock_kfree_s((struct sock *)msk, entry, sizeof(*entry));
+
+	return 0;
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry *match;
 	struct mptcp_sock *msk;
 	struct nlattr *id;
 	int err = -EINVAL;
@@ -318,32 +362,8 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	lock_sock(sk);
-
-	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk);
-		release_sock(sk);
-		goto out;
-	}
-
-	spin_lock_bh(&msk->pm.lock);
-	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
-	if (!match) {
-		spin_unlock_bh(&msk->pm.lock);
-		release_sock(sk);
-		goto out;
-	}
-
-	list_del_rcu(&match->list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	mptcp_pm_remove_addr_entry(msk, match);
-
+	err = userspace_pm_address_remove(msk, id_val);
 	release_sock(sk);
-
-	sock_kfree_s(sk, match, sizeof(*match));
-
-	err = 0;
-out:
 	if (err)
 		NL_SET_ERR_MSG_ATTR_FMT(info->extack, id,
 					"address with id %u not found",
@@ -353,12 +373,38 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int userspace_pm_subflow_create(struct mptcp_sock *msk,
+				       struct mptcp_pm_addr_entry *entry,
+				       struct mptcp_addr_info *remote)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_local local;
+	int err;
+
+	err = mptcp_userspace_pm_append_new_local_addr(msk, entry, false);
+	if (err < 0)
+		return err;
+
+	local.addr = entry->addr;
+	local.flags = entry->flags;
+	local.ifindex = entry->ifindex;
+
+	err = __mptcp_subflow_connect(sk, &local, remote);
+	spin_lock_bh(&msk->pm.lock);
+	if (err)
+		mptcp_userspace_pm_delete_local_addr(msk, entry);
+	else
+		msk->pm.subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
+	return 0;
+}
+
 int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct nlattr *raddr, *laddr;
-	struct mptcp_pm_local local;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
@@ -396,31 +442,13 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
-	if (err < 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr,
-				    "did not match address and id");
-		goto create_err;
-	}
-
-	local.addr = entry.addr;
-	local.flags = entry.flags;
-	local.ifindex = entry.ifindex;
-
 	lock_sock(sk);
-	err = __mptcp_subflow_connect(sk, &local, &addr_r);
+	err = userspace_pm_subflow_create(msk, &entry, &addr_r);
 	release_sock(sk);
 
 	if (err)
 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
 
-	spin_lock_bh(&msk->pm.lock);
-	if (err)
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
-	else
-		msk->pm.subflows++;
-	spin_unlock_bh(&msk->pm.lock);
-
  create_err:
 	sock_put(sk);
 	return err;
@@ -472,14 +500,34 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 	return NULL;
 }
 
+static int userspace_pm_subflow_destroy(struct mptcp_sock *msk,
+					struct mptcp_pm_addr_entry *local,
+					struct mptcp_addr_info *remote)
+{
+	struct sock *ssk, *sk = (struct sock *)msk;
+
+	ssk = mptcp_nl_find_ssk(msk, &local->addr, remote);
+	if (!ssk)
+		return -ESRCH;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_userspace_pm_delete_local_addr(msk, local);
+	spin_unlock_bh(&msk->pm.lock);
+	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
+	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+
+	return 0;
+}
+
 int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr_l;
 	struct mptcp_addr_info addr_r;
 	struct nlattr *raddr, *laddr;
 	struct mptcp_sock *msk;
-	struct sock *sk, *ssk;
 	int err = -EINVAL;
+	struct sock *sk;
 
 	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
 	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
@@ -530,37 +578,47 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 	lock_sock(sk);
-	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
-	if (!ssk) {
-		GENL_SET_ERR_MSG(info, "subflow not found");
-		err = -ESRCH;
-		goto release_sock;
-	}
-
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
-	spin_unlock_bh(&msk->pm.lock);
-	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
-	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-release_sock:
+	err = userspace_pm_subflow_destroy(msk, &addr_l, &addr_r);
 	release_sock(sk);
+	if (err)
+		GENL_SET_ERR_MSG(info, "subflow not found");
 
 destroy_err:
 	sock_put(sk);
 	return err;
 }
 
+static int userspace_pm_set_flags(struct mptcp_sock *msk,
+				  struct mptcp_pm_addr_entry *local,
+				  struct mptcp_addr_info *remote)
+{
+	struct mptcp_pm_addr_entry *entry;
+	u8 bkup = 0;
+
+	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+		bkup = 1;
+
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
+	if (entry) {
+		if (bkup)
+			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+		else
+			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
+	return mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, remote, bkup);
+}
+
 int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 				 struct genl_info *info)
 {
 	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
-	struct mptcp_pm_addr_entry *entry;
 	struct nlattr *attr, *attr_rem;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
-	u8 bkup = 0;
 
 	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
 		return ret;
@@ -591,21 +649,8 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 		goto set_flags_err;
 	}
 
-	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
-		bkup = 1;
-
-	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
-	if (entry) {
-		if (bkup)
-			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
-		else
-			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
-	}
-	spin_unlock_bh(&msk->pm.lock);
-
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, &rem, bkup);
+	ret = userspace_pm_set_flags(msk, local, &rem);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
@@ -682,6 +727,18 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	return ret;
 }
 
+static struct mptcp_pm_ops mptcp_userspace_pm = {
+	.address_announce	= userspace_pm_address_announce,
+	.address_remove		= userspace_pm_address_remove,
+	.subflow_create		= userspace_pm_subflow_create,
+	.subflow_destroy	= userspace_pm_subflow_destroy,
+	.get_local_id		= userspace_pm_get_local_id,
+	.get_flags		= userspace_pm_get_flags,
+	.set_flags		= userspace_pm_set_flags,
+	.type			= MPTCP_PM_TYPE_USERSPACE,
+	.owner			= THIS_MODULE,
+};
+
 /* Must be called with rcu read lock held */
 struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type)
 {
@@ -729,7 +786,15 @@ int mptcp_register_path_manager(struct mptcp_pm_ops *pm)
 
 void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm)
 {
+	if (pm == &mptcp_userspace_pm)
+		return;
+
 	spin_lock(&mptcp_pm_list_lock);
 	list_del_rcu(&pm->list);
 	spin_unlock(&mptcp_pm_list_lock);
 }
+
+void __init mptcp_userspace_pm_init(void)
+{
+	mptcp_register_path_manager(&mptcp_userspace_pm);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 10aa4820c5b2..762873d9fa8c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1162,6 +1162,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_nl_init(void);
+void __init mptcp_userspace_pm_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
-- 
2.43.0

