Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904CA8120D
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588543; cv=none; b=dxxAdsZjbrqxB92XjFtB1KoW5AngZzUeBrA7ZclZC7fINQJIxqiNOjtWSY/Pmm9VOHXx+Oqefs/JNZy5WYo7C7iCRYqLUDKDTad/puHRnMnOnZm/3Wf0WrZMYrpilDiOsjWA3gGe6kyZXR9xHjdL5H1WC1uy8Expx9dSORQsYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588543; c=relaxed/simple;
	bh=/pITNTvcoUggq9ca5Uys19ix4sRtwm4WGqxiq/SpNGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsDvfxsH0m4JML2WBVgiQ55boPFsaeiK3zieoT/K6rFghuWBmu1+BJX1SdjKFk4UarJObJ6AA36eqzDdMiMt/vh1r3xj6fC5T9as6aqNgja0Jd4HlQqrus1x5vAPaJNsO7uKxOUDPo+Y6DNCGT9U9TNNm1TYf1RYPt1fwUQgA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qet60TuA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qet60TuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D501C4CEC3;
	Tue, 22 Oct 2024 09:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588543;
	bh=/pITNTvcoUggq9ca5Uys19ix4sRtwm4WGqxiq/SpNGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qet60TuAGFLzt4oA8QPfN36m1lfyi30RjwdjMUnHVd9p4sQOVQDP5q8jV4/uoUag7
	 sQG8U2927ze8lJzBN3v/83g2wQYM76KLBHwyXoCQNFj3TY3H4yxONA0p/KCSjfJDtt
	 JBWXVkxSwab00akwaCPNONELpRrrAN98MEc/TidVTwwKlRGOlGf+S9GoM3jy0YVyZv
	 ibraYLHuuLiQ593I/LNBHGaMrdb/j7sLX9E39BtRldYMP5UnKPFIJyIzJ13z9Ve2jT
	 Yfc647jmuuqiU5ZfG/NGeLIAhf3N50AwvTg7Z5K+G+4ba6ufB0V9J3piOBPcLbbJZJ
	 mjphGZ2MpswYg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 31/36] mptcp: register default userspace pm
Date: Tue, 22 Oct 2024 17:14:39 +0800
Message-ID: <985f5c2c5b59f73be5f494708614afcd3057634a.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm.c           |  8 ++++
 net/mptcp/pm_userspace.c | 88 ++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.c     |  1 +
 net/mptcp/protocol.h     |  4 ++
 4 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c2229e46de1a..57ccb021091c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -489,6 +489,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
+	int ret;
 
 	pm->add_addr_signaled = 0;
 	pm->add_addr_accepted = 0;
@@ -516,6 +517,12 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 		WRITE_ONCE(pm->work_pending, 0);
 		WRITE_ONCE(pm->accept_addr, 0);
 		WRITE_ONCE(pm->accept_subflow, 0);
+
+		rcu_read_lock();
+		ret = mptcp_init_pm(msk, mptcp_pm_find(pm_type));
+		rcu_read_unlock();
+		if (ret)
+			return;
 	}
 
 	WRITE_ONCE(pm->addr_signal, 0);
@@ -535,4 +542,5 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_nl_init();
+	mptcp_userspace_pm_init();
 }
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 54c97d3d05ef..b22077fa1fa6 100644
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
@@ -737,7 +769,45 @@ int mptcp_register_path_manager(struct mptcp_pm_ops *pm)
 
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
index 21bc3586c33e..de6f93cffaaa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3040,6 +3040,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 	mptcp_release_sched(msk);
+	mptcp_release_pm(msk);
 
 	sk->sk_prot->destroy(sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d6c9ca292bff..26950be3b37c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -220,6 +220,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
 	struct list_head userspace_pm_local_addr_list;
+	struct mptcp_pm_ops *ops;
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
@@ -1058,6 +1059,8 @@ struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type);
 int mptcp_validate_path_manager(struct mptcp_pm_ops *pm);
 int mptcp_register_path_manager(struct mptcp_pm_ops *pm);
 void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm);
+int mptcp_init_pm(struct mptcp_sock *msk, struct mptcp_pm_ops *pm);
+void mptcp_release_pm(struct mptcp_sock *msk);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
@@ -1157,6 +1160,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_nl_init(void);
+void __init mptcp_userspace_pm_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
-- 
2.45.2

