Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC723302770
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217367; cv=none; b=BbDsPR70vuVluTZZS1t1sxDSiVzBQkF+525gwDgpMk+y3JoEYyueKfmy3fWMXbU/hSLkhzVN+hCGU0aZaFs0dPVu2fPwzyRMH6K8jdfV4vXJ+wV4WasfjiqVbNFcdfQkpH1EWPEgJzJPSnCSsY4eQ3NGMXt/f6rg9trNDmHmVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217367; c=relaxed/simple;
	bh=K7Y2tHH1QdiWTJIMeRn3LNuEAmQjWNDw6PGQh+nNJeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QgZEnObanb1FtS/uxqNfjlB54XDTtq6dgK/Ior6vCkx5awdMTxVSc/Wcm/Ca+T02Ww1XMSVDxrxr0hwKXi5v5BU1vutUQtg5om/gEY0vniQ5CR/Qyu/OGe+bWpbMKhpHXtQX1Un61A3G75wIdnfqFIWm7ZsSOF+DIRtT1NVyOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLIrZqN2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLIrZqN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1870C4CEF1;
	Thu, 18 Sep 2025 17:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217367;
	bh=K7Y2tHH1QdiWTJIMeRn3LNuEAmQjWNDw6PGQh+nNJeQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pLIrZqN2FJmO7FCVEmfaaDyw9ntwDb1ntb8Pvic2tjPVgOhYnA7xJT2KwO2hE95qM
	 Khw1i2fVwtHaYWO+d0kHpUTjr/NjBswbD/tiklOlZ0EHo7IhAsonVqxIuSsjz982F1
	 aLWcp4brULtIA8qkLHRgODs93tSnL+ZoVJb4d1yQDOsuNpNs7KIH4dAVeKEzsNDj3d
	 gT9NQWGaRGK02cM+06AP9cjENUHz2QLJv7CIrg+tLfLkK4cg+0FX5ZgfVTocv+mYRE
	 Colb29OKDwHzabVBg0oZoWvm+4t6sq7VYBWY98cCtQgs6QRUmLlssTjD2zG0uHnbfP
	 oQJ/D6V2F3S8g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Sep 2025 19:42:21 +0200
Subject: [PATCH mptcp-next 05/10] mptcp: pm: in-kernel: rename
 'subflows_max' to 'limit_extra_subflows'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pm-kern-endp-add_addr-v1-5-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13748; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=K7Y2tHH1QdiWTJIMeRn3LNuEAmQjWNDw6PGQh+nNJeQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuHRz3JCwyVJunOPvfEq4v32p9BX5/AWKNvf1ZCfPe
 lrXpcDTUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBHbd4wMG2Zyz7yl1JnwdlLj
 viu6h+0OXZaW7+14pDX36UkHGw/FTIb/pVf2fouK3c1/41nUHmM3hW8GtnXzw5MPiq6unPPl1VJ
 rLgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'subflows_max', which in fact represents the limit of
extra subflows: the limit set via 'ip mptcp limit subflows X' for
example. It is not linked to the maximum number of created / possible
subflows.

While at it, add an additional name for the corresponding variable in
MPTCP INFO: mptcpi_limit_extra_subflows. Not to break the current uAPI,
the new name is added as a 'define' pointing to the former name. This
will then also help userspace devs.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm.c             | 10 +++++-----
 net/mptcp/pm_kernel.c      | 50 ++++++++++++++++++++++++----------------------
 net/mptcp/protocol.h       |  6 +++---
 net/mptcp/sockopt.c        |  4 ++--
 5 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index f807c8dba56e7eb278fce0ad3184de3d0e24399b..314200c61f150da445ff87debb154bfd98f324fc 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -46,6 +46,7 @@ struct mptcp_info {
 	__u8	mptcpi_add_addr_signal;
 	__u8	mptcpi_add_addr_accepted;
 	__u8	mptcpi_subflows_max;
+	#define mptcpi_limit_extra_subflows mptcpi_subflows_max
 	__u8	mptcpi_add_addr_signal_max;
 	__u8	mptcpi_add_addr_accepted_max;
 	__u32	mptcpi_flags;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 2e0b7509b8a91cba14f656480f425e0f7241890e..ea40f31f17ba0d6c82db250d17f5a051ce6fabfa 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -483,7 +483,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
-	unsigned int subflows_max;
+	unsigned int limit_extra_subflows;
 	int ret = 0;
 
 	if (mptcp_pm_is_userspace(msk)) {
@@ -496,10 +496,10 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 		return false;
 	}
 
-	subflows_max = mptcp_pm_get_subflows_max(msk);
+	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->extra_subflows,
-		 subflows_max, READ_ONCE(pm->accept_subflow));
+		 limit_extra_subflows, READ_ONCE(pm->accept_subflow));
 
 	/* try to avoid acquiring the lock below */
 	if (!READ_ONCE(pm->accept_subflow))
@@ -507,8 +507,8 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 
 	spin_lock_bh(&pm->lock);
 	if (READ_ONCE(pm->accept_subflow)) {
-		ret = pm->extra_subflows < subflows_max;
-		if (ret && ++pm->extra_subflows == subflows_max)
+		ret = pm->extra_subflows < limit_extra_subflows;
+		if (ret && ++pm->extra_subflows == limit_extra_subflows)
 			WRITE_ONCE(pm->accept_subflow, false);
 	}
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 6439f877f334083d86c85d3c19caebba8da7902c..e61d417da2154809ad83da5a1b8eede1216a2b5a 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -23,7 +23,7 @@ struct pm_nl_pernet {
 	unsigned int		add_addr_signal_max;
 	unsigned int		add_addr_accept_max;
 	unsigned int		local_addr_max;
-	unsigned int		subflows_max;
+	unsigned int		limit_extra_subflows;
 	unsigned int		next_id;
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 };
@@ -62,13 +62,13 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
 
-unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	return READ_ONCE(pernet->subflows_max);
+	return READ_ONCE(pernet->limit_extra_subflows);
 }
-EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
+EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_extra_subflows);
 
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
 {
@@ -190,10 +190,10 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 	DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct sock *sk = (struct sock *)msk, *ssk;
 	struct mptcp_subflow_context *subflow;
-	unsigned int subflows_max;
+	unsigned int limit_extra_subflows;
 	int i = 0;
 
-	subflows_max = mptcp_pm_get_subflows_max(msk);
+	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	/* Forbid creation of new subflows matching existing ones, possibly
 	 * already created by incoming ADD_ADDR
@@ -221,7 +221,7 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.extra_subflows >= subflows_max)
+		if (msk->pm.extra_subflows >= limit_extra_subflows)
 			break;
 	}
 
@@ -270,18 +270,18 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
+	unsigned int limit_extra_subflows;
 	unsigned int add_addr_signal_max;
 	bool signal_and_subflow = false;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 	struct mptcp_pm_local local;
-	unsigned int subflows_max;
 
 	pernet = pm_nl_get_pernet(sock_net(sk));
 
 	add_addr_signal_max = mptcp_pm_get_add_addr_signal_max(msk);
 	local_addr_max = mptcp_pm_get_local_addr_max(msk);
-	subflows_max = mptcp_pm_get_subflows_max(msk);
+	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	/* do lazy endpoint usage accounting for the MPC subflows */
 	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
@@ -309,7 +309,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
 		 msk->pm.local_addr_used, local_addr_max,
 		 msk->pm.add_addr_signaled, add_addr_signal_max,
-		 msk->pm.extra_subflows, subflows_max);
+		 msk->pm.extra_subflows, limit_extra_subflows);
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
@@ -349,7 +349,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 subflow:
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < local_addr_max &&
-	       msk->pm.extra_subflows < subflows_max) {
+	       msk->pm.extra_subflows < limit_extra_subflows) {
 		struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 		bool fullmesh;
 		int i, nr;
@@ -398,14 +398,15 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 				  bool c_flag_case)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-	unsigned int subflows_max = mptcp_pm_get_subflows_max(msk);
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
+	unsigned int limit_extra_subflows;
 	struct mptcp_addr_info mpc_addr;
 	struct mptcp_pm_local *local;
 	int i = 0;
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
@@ -431,7 +432,7 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.extra_subflows >= subflows_max)
+		if (msk->pm.extra_subflows >= limit_extra_subflows)
 			break;
 	}
 	rcu_read_unlock();
@@ -446,13 +447,14 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 {
 	unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-	unsigned int subflows_max = mptcp_pm_get_subflows_max(msk);
 	struct sock *sk = (struct sock *)msk;
+	unsigned int limit_extra_subflows;
 	struct mptcp_addr_info mpc_addr;
 	struct mptcp_pm_local *local;
 	int i = 0;
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	while (msk->pm.local_addr_used < local_addr_max) {
 		local = &locals[i];
@@ -473,7 +475,7 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.extra_subflows >= subflows_max)
+		if (msk->pm.extra_subflows >= limit_extra_subflows)
 			break;
 	}
 
@@ -531,14 +533,14 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
+	unsigned int limit_extra_subflows;
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
-	unsigned int subflows_max;
 	bool sf_created = false;
 	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
-	subflows_max = mptcp_pm_get_subflows_max(msk);
+	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	pr_debug("accepted %d:%d remote family %d\n",
 		 msk->pm.add_addr_accepted, add_addr_accept_max,
@@ -573,7 +575,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		if (remote.id)
 			msk->pm.add_addr_accepted++;
 		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-		    msk->pm.extra_subflows >= subflows_max)
+		    msk->pm.extra_subflows >= limit_extra_subflows)
 			WRITE_ONCE(msk->pm.accept_addr, false);
 	}
 }
@@ -1273,13 +1275,13 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto unlock;
 
-	subflows = pernet->subflows_max;
+	subflows = pernet->limit_extra_subflows;
 	ret = parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
 	if (ret)
 		goto unlock;
 
 	WRITE_ONCE(pernet->add_addr_accept_max, rcv_addrs);
-	WRITE_ONCE(pernet->subflows_max, subflows);
+	WRITE_ONCE(pernet->limit_extra_subflows, subflows);
 
 unlock:
 	spin_unlock_bh(&pernet->lock);
@@ -1306,7 +1308,7 @@ int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 		goto fail;
 
 	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOWS,
-			READ_ONCE(pernet->subflows_max)))
+			READ_ONCE(pernet->limit_extra_subflows)))
 		goto fail;
 
 	genlmsg_end(msg, reply);
@@ -1415,7 +1417,7 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	if (msk->pm.extra_subflows == mptcp_pm_get_subflows_max(msk) ||
+	if (msk->pm.extra_subflows == mptcp_pm_get_limit_extra_subflows(msk) ||
 	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
 			       MPTCP_PM_MAX_ADDR_ID + 1, 0) == MPTCP_PM_MAX_ADDR_ID + 1)) {
 		WRITE_ONCE(msk->pm.work_pending, false);
@@ -1450,7 +1452,7 @@ static int __net_init pm_nl_init_net(struct net *net)
 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
 
 	/* Cit. 2 subflows ought to be enough for anybody. */
-	pernet->subflows_max = 2;
+	pernet->limit_extra_subflows = 2;
 	pernet->next_id = 1;
 	pernet->stale_loss_cnt = 4;
 	spin_lock_init(&pernet->lock);
@@ -1486,7 +1488,7 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 
 static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 {
-	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
+	bool subflows_allowed = !!mptcp_pm_get_limit_extra_subflows(msk);
 	struct mptcp_pm_data *pm = &msk->pm;
 
 	/* pm->work_pending must be only be set to 'true' when
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 33f7bf9a8c1344a01432c18d183a5d1b2d1f2c9e..acfe46e530cd75b14b33d9f4940b90fbf2867517 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1179,13 +1179,13 @@ void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
 {
-	if (--msk->pm.extra_subflows < mptcp_pm_get_subflows_max(msk))
+	if (--msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk))
 		WRITE_ONCE(msk->pm.accept_subflow, true);
 }
 
@@ -1201,7 +1201,7 @@ static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
 	       msk->pm.local_addr_used == 0 &&
 	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
-	       msk->pm.extra_subflows < mptcp_pm_get_subflows_max(msk);
+	       msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 17966da80239d731de925f3e4211b3ee00f802e4..4e82bcfcd34e3a1dffb05799cf181ee2940e75d7 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -972,8 +972,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 
 	/* The following limits only make sense for the in-kernel PM */
 	if (mptcp_pm_is_kernel(msk)) {
-		info->mptcpi_subflows_max =
-			mptcp_pm_get_subflows_max(msk);
+		info->mptcpi_limit_extra_subflows =
+			mptcp_pm_get_limit_extra_subflows(msk);
 		info->mptcpi_add_addr_signal_max =
 			mptcp_pm_get_add_addr_signal_max(msk);
 		info->mptcpi_add_addr_accepted_max =

-- 
2.51.0

