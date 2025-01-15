Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159C1DB132
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935781; cv=none; b=qTxP1Bi9eQOs0n7YvVF0ecVzr0Dl75Di/hd6L6NzVSgbYJwZtTJxHlrfHSGHm4moF+NhZ6gzvHz3nDsCh84NZtQsVuYhiujcsFDuZDnCH9jboUt3CBExRfo2xBXi076L0mBPxtDkg5DpmGt8K2CxYkyiq2DzUPhAbDpmMhjIe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935781; c=relaxed/simple;
	bh=YemrnA+/owTqMW0077btHRdOZShLTSkU6kbDWJOCJpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OywSD3rayt6ZoW8pciQgr3bDrXPcAHE4x3irX6nJY8PYQ4xxsiFyRjskdpVFp/pvtN3tA6RtZvFaCVmPPMwyOSOxbTg1ag6eUhfMfKGAb8uFZKkTryHBAc77JY/L3kMRc5CreWjJfrHcfmqUBpd5wl4JyQ1ZufWYnoKPwO5UnAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwSxTMzh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwSxTMzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251B9C4CEE1;
	Wed, 15 Jan 2025 10:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736935781;
	bh=YemrnA+/owTqMW0077btHRdOZShLTSkU6kbDWJOCJpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwSxTMzhgu0EuTxrn3TDNMa5gve6kWQRHO7F8LMG1MoYbJwkPPV2F8r8RT3bW/cDJ
	 f0+2PAYqpS1Q3k4GzJVOfGUPuM/IffQhFYj0H9JwDXw+AFA7qeIEFPPP+NgjddvS2+
	 XohD3jGCE4ze7Fb7vZP0oalfE7GUrOnMFs+R9XaNQeGMM8KeDZvLIGleNrCQvtBvDe
	 UbpS1T8rCzRHJyBkdUgsgYg3AESaXouUY9qs9jlWdPHQiigYZD9exMBHpVbFBphH/i
	 cL23LBHUNPlLHk2CRq7axx8yAixHA/xHZ2KmSmbj3d2ZZf07GAHMmfF08neiqqtv7z
	 Pk312jZTDmZBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] mptcp: init and release mptcp_pm_ops
Date: Wed, 15 Jan 2025 18:09:28 +0800
Message-ID: <079fff7d1e707986d0a1ee0269af622bf63a8cee.1736935433.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736935433.git.tanggeliang@kylinos.cn>
References: <cover.1736935433.git.tanggeliang@kylinos.cn>
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
index 3b47c2380a44..4353498f7396 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -600,6 +600,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 {
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
+	int ret;
 
 	pm->add_addr_signaled = 0;
 	pm->add_addr_accepted = 0;
@@ -627,6 +628,12 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
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
index c03201c95fea..876411f22d99 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -164,7 +164,9 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	new_entry.addr.id = 0;
 	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
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
@@ -585,7 +595,9 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_subflow_destroy(msk, &addr_l, &addr_r);
+	err = msk->pm.ops->subflow_destroy ?
+	      msk->pm.ops->subflow_destroy(msk, &addr_l, &addr_r) :
+	      userspace_pm_subflow_destroy(msk, &addr_l, &addr_r);
 	release_sock(sk);
 	if (err)
 		GENL_SET_ERR_MSG(info, "subflow not found");
@@ -657,7 +669,9 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 	}
 
 	lock_sock(sk);
-	ret = userspace_pm_set_flags(msk, local, &rem);
+	ret = msk->pm.ops->set_flags ?
+	      msk->pm.ops->set_flags(msk, local, &rem) :
+	      userspace_pm_set_flags(msk, local, &rem);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
@@ -801,6 +815,36 @@ void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm)
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
index 2492354e34dd..94f412b11a6f 100644
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

