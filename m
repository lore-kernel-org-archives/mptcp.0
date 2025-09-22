Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185A285058
	for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579849; cv=none; b=dJpVJTMufybGXkN8uaNcN0e+xANCHygHX/egjkzB2jjk5GMp+Ds3UG2eLE+dVJqvnke6pX2RdYYOg+2JJoHlW1CwnblVfWp78/bIes1jFlkfxdYiYkZj9LbKzTebxdkQYuf1BCDFKv3/Yc33LamSN2iYZb3NrTyDcmNiIq49uPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579849; c=relaxed/simple;
	bh=ndfy6Mw2jvVkalIV+KJeSFelr6WEbJjZmLy0qzzfsaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Na6P6P02d4d5O5TJh26fNrmcfS1WlM7YZXcjmlr+8ub1EeDNIsep5Bx3wqQd+7KUD8HCrB+FgN6pk6UOQkPR53tmuPuO3ZSpXsij5CA8jlNiDBf82rC2huyZ6BmraL/BdYra6j/9S6Bkfpryl+Gj1KetPlKhbSHwxoYVe1q/+hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/e3wTWf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/e3wTWf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69827C4CEF0;
	Mon, 22 Sep 2025 22:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758579848;
	bh=ndfy6Mw2jvVkalIV+KJeSFelr6WEbJjZmLy0qzzfsaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y/e3wTWf0vHWsPOq9XVn3+o2kkz9L+r5972tYmIH2xmtR6CV/LhEcn1R6ZBjWCDi0
	 5ZuqGPR/5rCfBl8JZ2qXWeb6/x1bZvxlYZjVvQFoTpISRzvXhr5hSRbkvwfNRIMKMd
	 24fuH/35ZpWvMsckTMBWs+kgATDxUehZIyWJsb8QguyuOaJUV6dhj1uHKnplAO8oEN
	 B89VqKDuTVHeCfdc1MFcPOQD7ZaV+Ve2ar90Nyj1DHOamyKFGWHaVkYIMzTHLB/SU2
	 va2MFTPmGlqPQh6Qdhnd6SUDeKU0H45UbcS0r1RVM84H815ApiAZdrrVaK9Wvh1JLB
	 iFXAX3995xuiQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Sep 2025 00:23:53 +0200
Subject: [PATCH mptcp-next 2/6] mptcp: pm: in-kernel: reduce pernet struct
 size
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-pm-kern-endp-add_addr-new-v1-2-60e3a8968f45@kernel.org>
References: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
In-Reply-To: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9388; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ndfy6Mw2jvVkalIV+KJeSFelr6WEbJjZmLy0qzzfsaY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIunmk4bmXU/2hhyzPehfcZCvdGzmR723jzcfGdmtSZa
 sfmV82c21HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRlnyG/wUb+O2Mj8/gmb3I
 N/zBtWPTtx14tUAiclr03heLllmVMbxk+O/0/d6s5PNq597+uLwjLfWAvrD/jnexEn+PqBWeX6E
 vup0LAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

All the 'unsigned int' variables from the 'pm_nl_pernet' structure are
bounded to MPTCP_PM_ADDR_MAX, currently set to 8. The endpoint ID is
also bounded by the protocol to 8-bit. MPTCP_PM_ADDR_MAX, if extended
later, will never over 8-bit.

So no need to use 'unsigned int' variables, 'u8' is enough.

Note that the exposed counters in MPTCP_INFO are already limited to
8-bit, same for pm->extra_subflows, and others. So it seems even better
to limit them to 8-bit.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 59 ++++++++++++++++++++-------------------------------
 net/mptcp/protocol.h  |  8 +++----
 2 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 52ae6304b311189ab927857ab74a9ee44ac6d76a..ae6ab3178c226fe3ec66d156bb0dc919075043e5 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -18,12 +18,12 @@ struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
 	struct list_head	endp_list;
-	unsigned int		endpoints;
-	unsigned int		endp_signal_max;
-	unsigned int		endp_subflow_max;
-	unsigned int		limit_add_addr_accepted;
-	unsigned int		limit_extra_subflows;
-	unsigned int		next_id;
+	u8			endpoints;
+	u8			endp_signal_max;
+	u8			endp_subflow_max;
+	u8			limit_add_addr_accepted;
+	u8			limit_extra_subflows;
+	u8			next_id;
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 };
 
@@ -45,7 +45,7 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
 	return pm_nl_get_pernet(genl_info_net(info));
 }
 
-unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
+u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
 {
 	const struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
@@ -53,7 +53,7 @@ unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_signal_max);
 
-unsigned int mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk)
+u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
@@ -61,7 +61,7 @@ unsigned int mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_subflow_max);
 
-unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
+u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
@@ -69,7 +69,7 @@ unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_add_addr_accepted);
 
-unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
+u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
@@ -185,15 +185,13 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			       struct mptcp_addr_info *local,
 			       struct mptcp_addr_info *addrs)
 {
+	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
 	DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct sock *sk = (struct sock *)msk, *ssk;
 	struct mptcp_subflow_context *subflow;
-	unsigned int limit_extra_subflows;
 	int i = 0;
 
-	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
-
 	/* Forbid creation of new subflows matching existing ones, possibly
 	 * already created by incoming ADD_ADDR
 	 */
@@ -272,20 +270,14 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	u8 endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
+	u8 endp_signal_max = mptcp_pm_get_endp_signal_max(msk);
 	struct sock *sk = (struct sock *)msk;
-	unsigned int limit_extra_subflows;
 	bool signal_and_subflow = false;
-	unsigned int endp_subflow_max;
-	unsigned int endp_signal_max;
-	struct pm_nl_pernet *pernet;
 	struct mptcp_pm_local local;
 
-	pernet = pm_nl_get_pernet(sock_net(sk));
-
-	endp_signal_max = mptcp_pm_get_endp_signal_max(msk);
-	endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
-	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
-
 	/* do lazy endpoint usage accounting for the MPC subflows */
 	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
@@ -400,16 +392,15 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 				  struct mptcp_pm_local *locals,
 				  bool c_flag_case)
 {
+	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
-	unsigned int limit_extra_subflows;
 	struct mptcp_addr_info mpc_addr;
 	struct mptcp_pm_local *local;
 	int i = 0;
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
-	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
@@ -448,16 +439,15 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 				struct mptcp_addr_info *remote,
 				struct mptcp_pm_local *locals)
 {
-	unsigned int endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
+	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	u8 endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
 	struct sock *sk = (struct sock *)msk;
-	unsigned int limit_extra_subflows;
 	struct mptcp_addr_info mpc_addr;
 	struct mptcp_pm_local *local;
 	int i = 0;
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
-	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	while (msk->pm.local_addr_used < endp_subflow_max) {
 		local = &locals[i];
@@ -534,17 +524,14 @@ fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
+	u8 limit_add_addr_accepted = mptcp_pm_get_limit_add_addr_accepted(msk);
+	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
-	unsigned int limit_extra_subflows;
-	unsigned int limit_add_addr_accepted;
 	struct mptcp_addr_info remote;
 	bool sf_created = false;
 	int i, nr;
 
-	limit_add_addr_accepted = mptcp_pm_get_limit_add_addr_accepted(msk);
-	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
-
 	pr_debug("accepted %d:%d remote family %d\n",
 		 msk->pm.add_addr_accepted, limit_add_addr_accepted,
 		 msk->pm.remote.family);
@@ -586,7 +573,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 {
 	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
-		unsigned int limit_add_addr_accepted =
+		u8 limit_add_addr_accepted =
 			mptcp_pm_get_limit_add_addr_accepted(msk);
 
 		/* Note: if the subflow has been closed before, this
@@ -617,8 +604,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     bool needs_id, bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
-	unsigned int addr_max;
 	int ret = -EINVAL;
+	u8 addr_max;
 
 	spin_lock_bh(&pernet->lock);
 	/* to keep the code simple, don't do IDR-like allocation for address ID,
@@ -1064,8 +1051,8 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
-	unsigned int addr_max;
 	struct nlattr *attr;
+	u8 addr_max;
 	int ret;
 
 	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a65aedc84ef5db3d8fc489b39d85ca56eb50e30e..027d717ef7cffe150f8de7b3b404916a1899537a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1177,10 +1177,10 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)

-- 
2.51.0

