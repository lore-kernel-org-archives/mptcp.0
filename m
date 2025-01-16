Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEC24A7E8
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737013146; cv=none; b=ZKZfsw0+0e2dc8Wbt94nB6xd/1EysV0hhG69TQCrVTbtYbIydar0QB878TDZgElvxir4ZK8R12hGayRTCOkZuC730q2AC1vM3YCy0/ceupOm3IihguhMcHEMh3bZTh1MH2h12WgHySIOFtYS+I0W44Z3o1rCAPleVGmybFNnZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737013146; c=relaxed/simple;
	bh=d4udjXvUX3PnlXph/+AVDGH4A72XqR6BZddblfdDrsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzTWANSKN04CqBeNjTpX3jv6rhXdpKVSKw3ArgEXe5t6ym8e1c3CY8IBHESPbudREbI4BPpmVyRvjXRVeidUYs1nREaH6djvmbDz7iBKplsochS0E5wKvBxMdpu0H3dmsXRdgtBQ6KKZL3JVg309ZhElNqZwp+wAqg2dnGXEZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swlB2P5Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swlB2P5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4BBC4CED6;
	Thu, 16 Jan 2025 07:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737013146;
	bh=d4udjXvUX3PnlXph/+AVDGH4A72XqR6BZddblfdDrsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swlB2P5QOH1w/rbiS/hozRYMhGDMqkCmjPwIR/2NgDsfYWjkWppaq2kmJ5Mo0DaBt
	 7iz1ZiRmzTPu6ilELzRb0XoKiz5VdvrQlWDuyZtZjX/fLZOwEBuqS0+WzfzDFnv7ya
	 y9iPyclIQk7h8T7jtuGP0tIzqTmhnyXDe1CkJvJ3c7P6g18Y9+78X2sGQabOfTxk4F
	 AFh2ztZUlfoSEiBfVbWl2i97hpSPzLNEZXbel27t2UKYD5pygcPnvpUaQ5DfOdSQD9
	 sQWHM876CaQA2lrrvwL1zvbWvglj2VNpt1V7XnorUW128rwY3HOj2xpM7phxJEztqD
	 GpPHguU3dJQ/w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/3] mptcp: init and release mptcp_pm_ops
Date: Thu, 16 Jan 2025 15:38:53 +0800
Message-ID: <0518e94994cfb655487ad70f3a01218b91fc4f24.1737012662.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737012662.git.tanggeliang@kylinos.cn>
References: <cover.1737012662.git.tanggeliang@kylinos.cn>
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
 net/mptcp/pm.c           |  4 +++
 net/mptcp/pm_userspace.c | 58 +++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.c     |  1 +
 net/mptcp/protocol.h     |  3 +++
 4 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3b47c2380a44..75faa0a909d7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -627,6 +627,10 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 		WRITE_ONCE(pm->work_pending, 0);
 		WRITE_ONCE(pm->accept_addr, 0);
 		WRITE_ONCE(pm->accept_subflow, 0);
+
+		rcu_read_lock();
+		mptcp_init_pm(msk, mptcp_pm_find(pm_type));
+		rcu_read_unlock();
 	}
 
 	WRITE_ONCE(pm->addr_signal, 0);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 289a97d5bd8d..c3a5c6402b47 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -164,7 +164,9 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	if (new_entry.addr.port == msk_sport)
 		new_entry.addr.port = 0;
 
-	return userspace_pm_get_local_id(msk, &new_entry);
+	return msk->pm.ops->get_local_id ?
+	       msk->pm.ops->get_local_id(msk, &new_entry) :
+	       userspace_pm_get_local_id(msk, &new_entry);
 }
 
 static u8 userspace_pm_get_flags(struct mptcp_sock *msk,
@@ -184,7 +186,9 @@ static u8 userspace_pm_get_flags(struct mptcp_sock *msk,
 u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
 				struct mptcp_addr_info *skc)
 {
-	return userspace_pm_get_flags(msk, skc);
+	return msk->pm.ops->get_flags ?
+	       msk->pm.ops->get_flags(msk, skc) :
+	       userspace_pm_get_flags(msk, skc);
 }
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
@@ -269,7 +273,9 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_address_announce(msk, &addr_val);
+	err = msk->pm.ops->address_announce ?
+	      msk->pm.ops->address_announce(msk, &addr_val) :
+	      userspace_pm_address_announce(msk, &addr_val);
 	release_sock(sk);
 	if (err)
 		NL_SET_ERR_MSG_ATTR(info->extack, addr,
@@ -369,7 +375,9 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	lock_sock(sk);
-	err = userspace_pm_address_remove(msk, id_val);
+	err = msk->pm.ops->address_remove ?
+	      msk->pm.ops->address_remove(msk, id_val) :
+	      userspace_pm_address_remove(msk, id_val);
 	release_sock(sk);
 	if (err)
 		NL_SET_ERR_MSG_ATTR_FMT(info->extack, id,
@@ -450,7 +458,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_subflow_create(msk, &entry, &addr_r);
+	err = msk->pm.ops->subflow_create ?
+	      msk->pm.ops->subflow_create(msk, &entry, &addr_r) :
+	      userspace_pm_subflow_create(msk, &entry, &addr_r);
 	release_sock(sk);
 
 	if (err)
@@ -586,7 +596,9 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_subflow_destroy(msk, &addr_l, &addr_r);
+	err = msk->pm.ops->subflow_destroy ?
+	      msk->pm.ops->subflow_destroy(msk, &addr_l, &addr_r) :
+	      userspace_pm_subflow_destroy(msk, &addr_l, &addr_r);
 	release_sock(sk);
 	if (err)
 		GENL_SET_ERR_MSG(info, "subflow not found");
@@ -658,7 +670,9 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 	}
 
 	lock_sock(sk);
-	ret = userspace_pm_set_flags(msk, local, &rem);
+	ret = msk->pm.ops->set_flags ?
+	      msk->pm.ops->set_flags(msk, local, &rem) :
+	      userspace_pm_set_flags(msk, local, &rem);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
@@ -805,6 +819,36 @@ void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm)
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
index 6034190e0d78..ab57ce556246 100644
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

