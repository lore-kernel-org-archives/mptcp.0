Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E852D46B3
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272921; cv=none; b=W4eTBi/SPhZh0okKm1IEtf3FBeQUJGuKjrnFaU1QJMTYu0v/rXJJGkirK9GuEpS84orHoAZloko+jeIoqG9jc4UDNDwXj5eot81QENs+KP2PkssoGFJ9xs+iokdMldM5je2iXkFJBnJLyz1MccTQTHjKrK8CXjtiDLnylQ3XF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272921; c=relaxed/simple;
	bh=h3Auxbrp53OJeDDZnGwXjRjUyFtmG3S7/Y5YQ6SnjqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c21A9hYP9ByCwIh4YB7kA4/jsJ+XloWySiiBbb5k4i12h/IGMR/3l2efVz5fdvDN8C4JaWukLciLI7Qtsjcy0RUaO/W1tIxk9uRX+8r3LFpIHsZp2iJnvuyR1MAqqEEQ7aOzgtXIBAw/sTKH5avDb5MWYl55lYrbXktkkokl3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORcj/LkO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORcj/LkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813EFC4CEF7;
	Fri, 19 Sep 2025 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272921;
	bh=h3Auxbrp53OJeDDZnGwXjRjUyFtmG3S7/Y5YQ6SnjqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ORcj/LkOzMtmL+WXoaH4g4d8VmXnWP5xzWYRSRm5DQGoFBKYstBUPGQE98gHh75gz
	 FeslhYOHv/P/S8+nx0pStwazFxofG+IYrSk2pX9kWVUNUm8NQ9eRoZCjQo2vBKi3Fl
	 hBdFc96CjL9zU5mUOi5T9MNSr7w5+SVena1JkZ6aovCdCld28nTfKt2I2oFB99gj+A
	 2tLb8PiJToHyNYnh7RZ8gDfqap0SSBHET5ICUGSqrRERn8DXBuJsSTdS62aRpK9IkW
	 7PyksNGJwlcGpZgHY4c2zw6VArUipsHE1lmCJpx7OfMl/GRUxCsD0kMN7f6od4t1MC
	 gQeiNd//djJYw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 11:08:14 +0200
Subject: [PATCH mptcp-next v2 08/10] mptcp: pm: in-kernel: rename
 'local_addr_max' to 'endp_subflow_max'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-pm-kern-endp-add_addr-v2-8-1f8f04f01914@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
In-Reply-To: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8539; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=h3Auxbrp53OJeDDZnGwXjRjUyFtmG3S7/Y5YQ6SnjqE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOyvZZWz8Ne1QUesAurj9bLn7/hriT57cue1fbeiKnr
 ZOtNGtaRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETOmDEy7O2Z+/J7nkqpds75
 kyYGM2vnrePT9/7WOHNTQ/nZCy4vmRkZ2m6eYkt5tljlfw+vINNWhXP6czMMJBQ8ZnfznJjAVyH
 JCQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'local_addr_max', which in fact represents the maximum
number of 'subflow' endpoints that can be used to create new subflows,
and not the number of local addresses that have been used to create
subflows.

While at it, add an additional name for the corresponding variable in
MPTCP INFO: mptcpi_endp_subflow_max. Not to break the current uAPI, the
new name is added as a 'define' pointing to the former name. This will
then also help userspace devs.

Also move the variable and function next to the other 'endp_X_max' ones.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_kernel.c      | 42 +++++++++++++++++++++---------------------
 net/mptcp/protocol.h       |  2 +-
 net/mptcp/sockopt.c        |  4 ++--
 4 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 1c275ce96b524cf1525b80967f28b57a59c24a0f..5ec996977b3fa2351222e6d01b814770b34348e9 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -58,6 +58,7 @@ struct mptcp_info {
 	__u64	mptcpi_rcv_nxt;
 	__u8	mptcpi_local_addr_used;
 	__u8	mptcpi_local_addr_max;
+	#define mptcpi_endp_subflow_max mptcpi_local_addr_max
 	__u8	mptcpi_csum_enabled;
 	__u32	mptcpi_retransmits;
 	__u64	mptcpi_bytes_retrans;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 43bb7bcf3de951fe148cc8dc1cd207f954e92562..a4f7ea1f43f6c7e9de6a36b84285d4dcc8731ca2 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -21,8 +21,8 @@ struct pm_nl_pernet {
 	unsigned int		addrs;
 	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
+	unsigned int		endp_subflow_max;
 	unsigned int		limit_add_addr_accepted;
-	unsigned int		local_addr_max;
 	unsigned int		limit_extra_subflows;
 	unsigned int		next_id;
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
@@ -54,6 +54,14 @@ unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_signal_max);
 
+unsigned int mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return READ_ONCE(pernet->endp_subflow_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_subflow_max);
+
 unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
@@ -70,14 +78,6 @@ unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_extra_subflows);
 
-unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
-{
-	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
-
-	return READ_ONCE(pernet->local_addr_max);
-}
-EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
-
 static bool lookup_subflow_by_daddr(const struct list_head *list,
 				    const struct mptcp_addr_info *daddr)
 {
@@ -276,15 +276,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	unsigned int limit_extra_subflows;
 	bool signal_and_subflow = false;
+	unsigned int endp_subflow_max;
 	unsigned int endp_signal_max;
-	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 	struct mptcp_pm_local local;
 
 	pernet = pm_nl_get_pernet(sock_net(sk));
 
 	endp_signal_max = mptcp_pm_get_endp_signal_max(msk);
-	local_addr_max = mptcp_pm_get_local_addr_max(msk);
+	endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
 	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	/* do lazy endpoint usage accounting for the MPC subflows */
@@ -311,7 +311,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	}
 
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
-		 msk->pm.local_addr_used, local_addr_max,
+		 msk->pm.local_addr_used, endp_subflow_max,
 		 msk->pm.add_addr_signaled, endp_signal_max,
 		 msk->pm.extra_subflows, limit_extra_subflows);
 
@@ -352,7 +352,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 subflow:
 	/* check if should create a new subflow */
-	while (msk->pm.local_addr_used < local_addr_max &&
+	while (msk->pm.local_addr_used < endp_subflow_max &&
 	       msk->pm.extra_subflows < limit_extra_subflows) {
 		struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 		bool fullmesh;
@@ -449,7 +449,7 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 				struct mptcp_addr_info *remote,
 				struct mptcp_pm_local *locals)
 {
-	unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
+	unsigned int endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct sock *sk = (struct sock *)msk;
 	unsigned int limit_extra_subflows;
@@ -460,7 +460,7 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
-	while (msk->pm.local_addr_used < local_addr_max) {
+	while (msk->pm.local_addr_used < endp_subflow_max) {
 		local = &locals[i];
 
 		if (!select_local_address(pernet, msk, local))
@@ -697,8 +697,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		WRITE_ONCE(pernet->endp_signal_max, addr_max + 1);
 	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-		addr_max = pernet->local_addr_max;
-		WRITE_ONCE(pernet->local_addr_max, addr_max + 1);
+		addr_max = pernet->endp_subflow_max;
+		WRITE_ONCE(pernet->endp_subflow_max, addr_max + 1);
 	}
 
 	pernet->addrs++;
@@ -1097,8 +1097,8 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		WRITE_ONCE(pernet->endp_signal_max, addr_max - 1);
 	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-		addr_max = pernet->local_addr_max;
-		WRITE_ONCE(pernet->local_addr_max, addr_max - 1);
+		addr_max = pernet->endp_subflow_max;
+		WRITE_ONCE(pernet->endp_subflow_max, addr_max - 1);
 	}
 
 	pernet->addrs--;
@@ -1181,7 +1181,7 @@ static void __flush_addrs(struct list_head *list)
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	WRITE_ONCE(pernet->endp_signal_max, 0);
-	WRITE_ONCE(pernet->local_addr_max, 0);
+	WRITE_ONCE(pernet->endp_subflow_max, 0);
 	pernet->addrs = 0;
 }
 
@@ -1502,7 +1502,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 	 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
 	 */
 	WRITE_ONCE(pm->work_pending,
-		   (!!mptcp_pm_get_local_addr_max(msk) &&
+		   (!!mptcp_pm_get_endp_subflow_max(msk) &&
 		    subflows_allowed) ||
 		   !!mptcp_pm_get_endp_signal_max(msk));
 	WRITE_ONCE(pm->accept_addr,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 63c46a00c9d48c4e6d41753b5f020f7cf39ffba0..a65aedc84ef5db3d8fc489b39d85ca56eb50e30e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1178,9 +1178,9 @@ void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 5ab9909dbe799bed5c59d2b1b04cc0e88e960574..92a2a274262732a345b9ab185efd7da1f0a5773a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -978,8 +978,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_endp_signal_max(msk);
 		info->mptcpi_limit_add_addr_accepted =
 			mptcp_pm_get_limit_add_addr_accepted(msk);
-		info->mptcpi_local_addr_max =
-			mptcp_pm_get_local_addr_max(msk);
+		info->mptcpi_endp_subflow_max =
+			mptcp_pm_get_endp_subflow_max(msk);
 	}
 
 	if (__mptcp_check_fallback(msk))

-- 
2.51.0

