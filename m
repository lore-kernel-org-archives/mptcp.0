Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA213A3ED
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020272; cv=none; b=ekC0Eys3uDro85NBCLRgkNx3M1AltVzTAR20pjxQK5d7IYFUMK+US5WsQdfX8gePm2FBB6bU6sSw3eQxDNqsdxaeA6D/7IMplvA0SFlyHxVXiXQz0jtlveSR+eKHsQOwTgq8rGUpbx2jBwBcoqLYGVatmcycZkv4kQcpffaD1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020272; c=relaxed/simple;
	bh=XJBrxtnje2GL9Ak8KcqIPa32ItgN+B54GR6VajxR/K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XihwGF2CQhwoq89ZKO2Mp10I5kjmrLeOMB+Jxg3hqeUeK10GAkettzfSHtZW6OdfB3MwTnk9xk5fCtVsjzZHHwGpdcXDs0zi40zY3QdU1Bihgek6/lCWod3vSvczR2xeMXV4yQ+QmijXD4qGt0dqXDPtuawCjbvjIO9XwvFAvl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPNJgKtq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPNJgKtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7198C4CED1;
	Thu, 20 Feb 2025 02:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740020271;
	bh=XJBrxtnje2GL9Ak8KcqIPa32ItgN+B54GR6VajxR/K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aPNJgKtqyMgCeESan5fR0NH5Xs+UOrs01J4o3TE4Mbva4Jhj7nl4I/xf9kWxUqwfH
	 ++BCFexnspu2mySvfVWhtDmfRJicHJnuqTdcVfGlKuqLWWKEWkQeYN8QlbXWLG4xLd
	 m1UU4hK+Kl/J2ykdSc9eEE69BhuSu/Cy4ikYCG6zTFfv0OR65Z/T0wyO+i4Wy9GZJ6
	 hndQSSO6rLKpIEVtdIfHXOp9rVa29csDS6VZh5+MJraVBlE/5TPhCayEKslpuQMiVe
	 f0ee9OJiUmBEi9NvKskmnxCgkSWWXrupfTONgp9rziyIiySNr4jf3qDt+gQZ6vvzMv
	 0Q7TsNdR3oX2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 7/9] mptcp: pm: initialize and release mptcp_pm_ops
Date: Thu, 20 Feb 2025 10:57:31 +0800
Message-ID: <e8019aa464c83748914d1b1f235f5dcae0e2fbe8.1740019794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740019794.git.tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a struct mptcp_pm_ops pointer "ops" in struct mptcp_pm_data, and two
functions mptcp_pm_initialize() and mptcp_pm_release(), to set and release
this pointer. mptcp_pm_initialize() is invoked in mptcp_pm_data_reset(),
while mptcp_pm_release() is invoked in __mptcp_destroy_sock().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 33 +++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 91e377058243..9d42aed440a0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -627,6 +627,9 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	pm->rm_list_tx.nr = 0;
 	pm->rm_list_rx.nr = 0;
 	WRITE_ONCE(pm->pm_type, pm_type);
+	rcu_read_lock();
+	mptcp_pm_initialize(msk, mptcp_pm_find(pm_type));
+	rcu_read_unlock();
 
 	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
 		bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
@@ -721,3 +724,33 @@ void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
 	list_del_rcu(&pm->list);
 	spin_unlock(&mptcp_pm_list_lock);
 }
+
+int mptcp_pm_initialize(struct mptcp_sock *msk, struct mptcp_pm_ops *pm)
+{
+	if (!pm)
+		return -EINVAL;
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
+void mptcp_pm_release(struct mptcp_sock *msk)
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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2b48cf648346..de8eb3ec8cdd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2944,6 +2944,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 	mptcp_release_sched(msk);
+	mptcp_pm_release(msk);
 
 	sk->sk_prot->destroy(sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 021c0f87da1b..cddb919fc120 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -220,6 +220,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
 	struct list_head userspace_pm_local_addr_list;
+	struct mptcp_pm_ops *ops;
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
@@ -1043,6 +1044,8 @@ struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm);
 int mptcp_pm_register(struct mptcp_pm_ops *pm);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm);
+int mptcp_pm_initialize(struct mptcp_sock *msk, struct mptcp_pm_ops *pm);
+void mptcp_pm_release(struct mptcp_sock *msk);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.43.0

