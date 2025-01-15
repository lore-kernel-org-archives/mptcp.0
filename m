Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D53F1BEF9E
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924927; cv=none; b=BM+dixiZSzIJvV2EIzsR3F4ABJDjL52QDx5Hek7TX2hzvzSXWvOAg6sPZ83tSjJsBk6VtFEseTf92s3ft+nfE+u2mfcNfBXtOxMxPtn6wh7lgaZoSjGF0BMiNX9YZHZlNR4KaLjL8oQplMdzAiZ8F7+r3jkmlZsseFEQFEAkHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924927; c=relaxed/simple;
	bh=5BQj75zP2sQAJFSNQDRX18yN9P8vflEFlVP/UqSEsS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoRRj214N0n30CyffKOKtXzrPOkoykcYhkTCxXidOwp/M4Zxx5ZaezPPi78cAqDNrUWfD/Ruz7feIQ8UCjVy8NIYZYpintgfoxj+GvHHfStzCjybyGkMV6KKol+2KlbGqWwBh2FB/kO8GpV7FcEDac+Em0tGagAkDCDy4E2DnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlg/i6BL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlg/i6BL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF84C4CEDF;
	Wed, 15 Jan 2025 07:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736924927;
	bh=5BQj75zP2sQAJFSNQDRX18yN9P8vflEFlVP/UqSEsS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xlg/i6BL1i5xt5QFC7s0A87c5yfkwq0td8PMjtlIlX5nToUDrXXCRBm0gQ5OoAcZI
	 IXz92+fDdHOncAP8wapBM0BFCPik/ZKFhttGVyyJ6efYCazC83vvoPIkvCp2+w9lrC
	 0uOr1rKTaG2D7eSJprvoUZtx0/sV30SW7C7a/l9nEWjhOb4t+qiwY1y8LUTHX0J+46
	 G+DEeHB0GFnAhC2q2JMzKaIn9Oz8u9NBCcuQ3fnZTSsf4TtDo1v0o6cDNfm94OOW0D
	 WwpTZoK8jB8s6riKSzzrQPFn5cDovsUeYIqpKGfBeCNQ9gpeZGZt8WrsqAef9NpCnr
	 eFSp4qu710XsQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/3] mptcp: init and release mptcp_pm_ops
Date: Wed, 15 Jan 2025 15:08:34 +0800
Message-ID: <f6e61348e27e7893e5c26a01f529b027572acb65.1736924549.git.tanggeliang@kylinos.cn>
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

Add a struct mptcp_pm_ops pointer "ops" in struct mptcp_pm_data, and two
functions mptcp_init_pm() and mptcp_release_pm(), to set and release this
pointer. mptcp_init_pm() is invoked in mptcp_pm_data_reset(), while
mptcp_release_pm() is invoked in __mptcp_destroy_sock().

In this way, different userspace path managers can be initialized through
the pm_type sysctl, and then called into their respective interfaces
through "ops" of "msk->pm".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  7 +++++
 net/mptcp/pm_userspace.c | 58 +++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.c     |  1 +
 net/mptcp/protocol.h     |  3 +++
 4 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index aa0fee7c1b77..8352d44ab9b3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -604,6 +604,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
+	int ret;
 
 	pm->add_addr_signaled = 0;
 	pm->add_addr_accepted = 0;
@@ -631,6 +632,12 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
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
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ac4ccda43ce8..e19374a057c5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -157,7 +157,9 @@ static int userspace_pm_get_local_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_pm_addr_entry *local)
 {
-	return userspace_pm_get_local_id(msk, local);
+	return msk->pm.ops->get_local_id ?
+	       msk->pm.ops->get_local_id(msk, local) :
+	       userspace_pm_get_local_id(msk, local);
 }
 
 static u8 userspace_pm_get_flags(struct mptcp_sock *msk,
@@ -177,7 +179,9 @@ static u8 userspace_pm_get_flags(struct mptcp_sock *msk,
 u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
 				struct mptcp_addr_info *skc)
 {
-	return userspace_pm_get_flags(msk, skc);
+	return msk->pm.ops->get_flags ?
+	       msk->pm.ops->get_flags(msk, skc) :
+	       userspace_pm_get_flags(msk, skc);
 }
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
@@ -262,7 +266,9 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_address_announce(msk, &addr_val);
+	err = msk->pm.ops->address_announce ?
+	      msk->pm.ops->address_announce(msk, &addr_val) :
+	      userspace_pm_address_announce(msk, &addr_val);
 	release_sock(sk);
 	if (err)
 		NL_SET_ERR_MSG_ATTR(info->extack, addr,
@@ -362,7 +368,9 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	lock_sock(sk);
-	err = userspace_pm_address_remove(msk, id_val);
+	err = msk->pm.ops->address_remove ?
+	      msk->pm.ops->address_remove(msk, id_val) :
+	      userspace_pm_address_remove(msk, id_val);
 	release_sock(sk);
 	if (err)
 		NL_SET_ERR_MSG_ATTR_FMT(info->extack, id,
@@ -443,7 +451,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_subflow_create(msk, &entry, &addr_r);
+	err = msk->pm.ops->subflow_create ?
+	      msk->pm.ops->subflow_create(msk, &entry, &addr_r) :
+	      userspace_pm_subflow_create(msk, &entry, &addr_r);
 	release_sock(sk);
 
 	if (err)
@@ -578,7 +588,9 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_subflow_destroy(msk, &addr_l, &addr_r);
+	err = msk->pm.ops->subflow_destroy ?
+	      msk->pm.ops->subflow_destroy(msk, &addr_l, &addr_r) :
+	      userspace_pm_subflow_destroy(msk, &addr_l, &addr_r);
 	release_sock(sk);
 	if (err)
 		GENL_SET_ERR_MSG(info, "subflow not found");
@@ -650,7 +662,9 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 	}
 
 	lock_sock(sk);
-	ret = userspace_pm_set_flags(msk, local, &rem);
+	ret = msk->pm.ops->set_flags ?
+	      msk->pm.ops->set_flags(msk, local, &rem) :
+	      userspace_pm_set_flags(msk, local, &rem);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
@@ -794,6 +808,36 @@ void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm)
 	spin_unlock(&mptcp_pm_list_lock);
 }
 
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
 void __init mptcp_userspace_pm_init(void)
 {
 	mptcp_register_path_manager(&mptcp_userspace_pm);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5cda189d29f2..bba22c3f7279 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2940,6 +2940,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 	mptcp_release_sched(msk);
+	mptcp_release_pm(msk);
 
 	sk->sk_prot->destroy(sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 762873d9fa8c..a64125e8ad80 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -221,6 +221,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
 	struct list_head userspace_pm_local_addr_list;
+	struct mptcp_pm_ops *ops;
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
@@ -1052,6 +1053,8 @@ struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type);
 int mptcp_validate_path_manager(struct mptcp_pm_ops *pm);
 int mptcp_register_path_manager(struct mptcp_pm_ops *pm);
 void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm);
+int mptcp_init_pm(struct mptcp_sock *msk, struct mptcp_pm_ops *pm);
+void mptcp_release_pm(struct mptcp_sock *msk);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.43.0

