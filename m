Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C89F205126
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070025; cv=none; b=GgXfR2+YPRjB75BalHb0mTd7rLKGdi8kP/NM1TsiSx1Sf3ghHM9yap+J9/xOP2MXtaHdp0qIveFFhRSyq3dODr9kKNw1FbqgNOaAk5dSes1ofiQ2wbwI5Rt89zvO4zmDsK49rBTAUTUxDjCjoAalsgeRDzVx3WFSFqzg9Kpw8H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070025; c=relaxed/simple;
	bh=nPmKUiwmjEgfDfDp6B6/vil9iPWYlLioNJiYNhtJNok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAq89cW/snybggDfWUIRtgFZQc+iY8wHfZOxKoGdMcBbJKDQcOYaVW+bJjtalPy8zVIWv7K7KP/X/BmN45TtB8jU6T6JstdSHqe9mZQ/GIjj24vJcLzZZE5hjOanvEgXuA9OvX1deJF8BxAV7eHqVCxUOeYkfLzkdOqNOsMBf2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1rUM3bJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1rUM3bJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9EEC4CEC5;
	Wed, 16 Oct 2024 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729070025;
	bh=nPmKUiwmjEgfDfDp6B6/vil9iPWYlLioNJiYNhtJNok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1rUM3bJc3g+5+qzkGMMTwSfZxCUXpGDXweX08NxVVNsxYPMArFCvFpuV43Ddot/A
	 ugXYAv31lBqSf4P1SB52Qgjyfuk38EMWI3z/cVrzNE/ZaSW3zx0CB6R1aU30p0m3gK
	 0vETT92UtCGD5vtPFVoBrD3IaSzyLStiQYacp7F4PqooUr9y+kx8/GWp+uSYRT94ou
	 JuzcIe79sFaazyXpvzJ2Z6kYqnzw28ySvnYksIX5plKDGMfXQ7oK/nHR6uid3YKdUn
	 hpdhwRvQ8JYaANSu6ceTw1GK5ewlftxsdij5Nh6Q4DuKP7jUn5bfyA/b3rQt7XkIma
	 cqK1N6jHyczOQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 33/33] mptcp: register default userspace pm
Date: Wed, 16 Oct 2024 17:12:37 +0800
Message-ID: <109bde463401881d74b860a8349a845096ba0705.1729069854.git.tanggeliang@kylinos.cn>
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

This patch defines the original userspace pm as the default path manager,
named mptcp_userspace_pm, and register it in mptcp_pm_data_init().

Add a struct mptcp_pm_ops pointer "ops" in struct mptcp_pm_data, and two
functions mptcp_init_pm() and mptcp_release_pm(), to set and release this
pointer. mptcp_init_pm() is invoked in mptcp_pm_data_reset(), while
mptcp_release_pm() is invoked in __mptcp_destroy_sock().

In this way, different userspace path managers can be initialized through
the pm_type sysctl, and then called into their respective interfaces
through "ops" of "msk->pm".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  4 ++
 net/mptcp/pm_userspace.c | 88 ++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.c     |  1 +
 net/mptcp/protocol.h     |  4 ++
 4 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c2229e46de1a..3b9249c34d5a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -516,6 +516,9 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 		WRITE_ONCE(pm->work_pending, 0);
 		WRITE_ONCE(pm->accept_addr, 0);
 		WRITE_ONCE(pm->accept_subflow, 0);
+
+		if (mptcp_init_pm(msk, mptcp_pm_find(pm_type)))
+			return;
 	}
 
 	WRITE_ONCE(pm->addr_signal, 0);
@@ -535,4 +538,5 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_nl_init();
+	mptcp_userspace_pm_init();
 }
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f07c77dca84b..a3d4a11daf65 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -157,7 +157,9 @@ static int userspace_pm_get_local_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_pm_addr_entry *local)
 {
-	return userspace_pm_get_local_id(msk, local);
+	return INDIRECT_CALL_1(msk->pm.ops->get_local_id,
+			       userspace_pm_get_local_id,
+			       msk, local);
 }
 
 static u8 userspace_pm_get_flags(struct mptcp_sock *msk,
@@ -178,7 +180,9 @@ static u8 userspace_pm_get_flags(struct mptcp_sock *msk,
 u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
 				struct mptcp_addr_info *skc)
 {
-	return userspace_pm_get_flags(msk, skc);
+	return INDIRECT_CALL_1(msk->pm.ops->get_flags,
+			       userspace_pm_get_flags,
+			       msk, skc);
 }
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
@@ -258,7 +262,9 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_address_announce(msk, &addr_val);
+	err = INDIRECT_CALL_1(msk->pm.ops->address_announce,
+			      userspace_pm_address_announce,
+			      msk, &addr_val);
 	release_sock(sk);
 	if (err)
 		GENL_SET_ERR_MSG(info, "address_announce failed");
@@ -344,7 +350,9 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	lock_sock(sk);
-	err = userspace_pm_address_remove(msk, id_val);
+	err = INDIRECT_CALL_1(msk->pm.ops->address_remove,
+			      userspace_pm_address_remove,
+			      msk, id_val);
 	release_sock(sk);
 	if (err)
 		GENL_SET_ERR_MSG(info, "address_remove failed");
@@ -416,7 +424,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_subflow_create(msk, &entry, &addr_r);
+	err = INDIRECT_CALL_1(msk->pm.ops->subflow_create,
+			      userspace_pm_subflow_create,
+			      msk, &entry, &addr_r);
 	release_sock(sk);
 	if (err)
 		GENL_SET_ERR_MSG(info, "subflow_create failed");
@@ -548,7 +558,9 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_subflow_destroy(msk, &local, &addr_r);
+	err = INDIRECT_CALL_1(msk->pm.ops->subflow_destroy,
+			      userspace_pm_subflow_destroy,
+			      msk, &local, &addr_r);
 	release_sock(sk);
 	if (err)
 		GENL_SET_ERR_MSG(info, "subflow_destroy failed");
@@ -602,7 +614,9 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,
 	sk = (struct sock *)msk;
 
 	lock_sock(sk);
-	ret = userspace_pm_set_flags(msk, loc, rem);
+	ret = INDIRECT_CALL_1(msk->pm.ops->set_flags,
+			      userspace_pm_set_flags,
+			      msk, loc, rem);
 	release_sock(sk);
 	if (ret)
 		GENL_SET_ERR_MSG(info, "set_flags failed");
@@ -647,7 +661,9 @@ int mptcp_userspace_pm_dump_addr(struct mptcp_id_bitmap *bitmap,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	ret = userspace_pm_dump_addr(msk, bitmap);
+	ret = INDIRECT_CALL_1(msk->pm.ops->dump_addr,
+			      userspace_pm_dump_addr,
+			      msk, bitmap);
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
 
@@ -677,7 +693,9 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
-	entry = userspace_pm_get_addr(msk, id);
+	entry = INDIRECT_CALL_1(msk->pm.ops->get_addr,
+				userspace_pm_get_addr,
+				msk, id);
 	if (entry) {
 		*addr = *entry;
 		ret = 0;
@@ -689,6 +707,20 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	return ret;
 }
 
+static struct mptcp_pm_ops mptcp_userspace_pm = {
+	.address_announce	= userspace_pm_address_announce,
+	.address_remove		= userspace_pm_address_remove,
+	.subflow_create		= userspace_pm_subflow_create,
+	.subflow_destroy	= userspace_pm_subflow_destroy,
+	.get_local_id		= userspace_pm_get_local_id,
+	.get_flags		= userspace_pm_get_flags,
+	.get_addr		= userspace_pm_get_addr,
+	.dump_addr		= userspace_pm_dump_addr,
+	.set_flags		= userspace_pm_set_flags,
+	.type			= MPTCP_PM_TYPE_USERSPACE,
+	.owner			= THIS_MODULE,
+};
+
 /* Must be called with rcu read lock held */
 struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type)
 {
@@ -724,7 +756,45 @@ int mptcp_register_path_manager(struct mptcp_pm_ops *pm)
 
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
+int mptcp_init_pm(struct mptcp_sock *msk, struct mptcp_pm_ops *pm)
+{
+	if (!pm)
+		pm = &mptcp_userspace_pm;
+
+	if (!bpf_try_module_get(pm, pm->owner))
+		return -EBUSY;
+
+	msk->pm.ops = pm;
+	if (msk->pm.ops->init)
+		msk->pm.ops->init(msk);
+
+	pr_debug("userspace_pm type %u initialized\n", msk->pm.ops->type);
+	return 0;
+}
+
+void mptcp_release_pm(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_ops *pm = msk->pm.ops;
+
+	if (!pm)
+		return;
+
+	msk->pm.ops = NULL;
+	if (pm->release)
+		pm->release(msk);
+
+	bpf_module_put(pm, pm->owner);
+}
+
+void __init mptcp_userspace_pm_init(void)
+{
+	mptcp_register_path_manager(&mptcp_userspace_pm);
+}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e420ce9bbfb6..0f4305379e58 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3038,6 +3038,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 	mptcp_release_sched(msk);
+	mptcp_release_pm(msk);
 
 	sk->sk_prot->destroy(sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5b21d1f1ba16..c81fe379b0f8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -220,6 +220,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
 	struct list_head userspace_pm_local_addr_list;
+	struct mptcp_pm_ops *ops;
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
@@ -1055,6 +1056,8 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type);
 int mptcp_register_path_manager(struct mptcp_pm_ops *pm);
 void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm);
+int mptcp_init_pm(struct mptcp_sock *msk, struct mptcp_pm_ops *pm);
+void mptcp_release_pm(struct mptcp_sock *msk);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
@@ -1154,6 +1157,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_nl_init(void);
+void __init mptcp_userspace_pm_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
-- 
2.43.0

