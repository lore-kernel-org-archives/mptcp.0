Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162D2D46B3
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272920; cv=none; b=JYwCDEVTApGnF2sDbuSej0be2d7Ydx8AuaFH6nvIQqx17aQcrkHJ+qimRrdX99xp4fb7594+1iW0Qsuu4iVomFKewwF+RlWK9tnJQYlMuAyZRqdB82Uu1jKCQ5GN4MpJUc9T279pXN1X64W7XzbmIiqwvQFbtiGwFf0ZgL9uvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272920; c=relaxed/simple;
	bh=mKo1Ipw7skITpB7jn3vZ9tG6YfemJ3gVf+U7K+u/Gwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvc8UMw+Nf1IHst3JcMj/BtcEfLAeiBBQk5DHksp6nBgle/6lnT+6cBjTBC4sFppythFvM++JxFLIWTMaMnahD8pdy3DGOMUHr0Z2i9r6WU9KAR+hxDTT5rOqB5ev3S3AQz7ydGcFfgInidQ9+nggJqyKg8uMlOnp9ZxnTOzdyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqMbQioF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqMbQioF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01BBC4CEFA;
	Fri, 19 Sep 2025 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272920;
	bh=mKo1Ipw7skITpB7jn3vZ9tG6YfemJ3gVf+U7K+u/Gwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PqMbQioF7dnDDV54/VPT+kbFrrdYCKlQNdxc60BfzuO/GSVqkbf1g7Dzk01eyXzNI
	 sGwGdQ4saVnyh2STdoEQfgnpmOhfm4TPJ7l+18TgGblT7HnCRN2vHwz6+d6PpC5119
	 xw7aGxQLCAptfBHPkLiNO1jTeVKar0ohR50fS3tYNmpkAYDmBCyJXoexasvsG7JHOi
	 hSF9wEJWMZWuEKF+I8nYXuwilxTO/p1QRsRTb6REbDhbO+zpZF7/hhlRXMNx5txmLm
	 BDD9ehLrI+i574+fvh+iseZU2PPFiwjnyo4rRR3D4reWGt3O1RqMGKeDxFi7d1zsx5
	 NQor1sCapb2VA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 11:08:13 +0200
Subject: [PATCH mptcp-next v2 07/10] mptcp: pm: in-kernel: rename
 'add_addr_accept_max' to 'limit_add_addr_accepted'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-pm-kern-endp-add_addr-v2-7-1f8f04f01914@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
In-Reply-To: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7837; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mKo1Ipw7skITpB7jn3vZ9tG6YfemJ3gVf+U7K+u/Gwc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOyva8Prwv6rzbfv6uu/MKbqio1UYlbHFVCmktdjlwY
 FdBLPf9jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkc92D4zb6qXe6q6m+br/f+
 27w31Xth03gs0v6l4+xJLX85dry/Z8PIMEstbeWr6c+uFP0+9MJ96rWsZ+u+9T+yOizHs3pR85S
 gCawA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'add_addr_accept_max', which in fact represents the limit
of ADD_ADDR that can be accepted:  the limit set via 'ip mptcp limit
add_addr_accepted X' for example. It is not linked to the maximum number
of accepted ADD_ADDR.

While at it, add an additional name for the corresponding variable in
MPTCP INFO: mptcpi_limit_add_addr_accepted. Not to break the current
uAPI, the new name is added as a 'define' pointing to the former name.
This will then also help userspace devs.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: avoid one line above 80 chars
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_kernel.c      | 29 ++++++++++++++++-------------
 net/mptcp/protocol.h       |  4 ++--
 net/mptcp/sockopt.c        |  4 ++--
 4 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 69fc20db1c2f731d5f93cfee4e58a23119ff7a97..1c275ce96b524cf1525b80967f28b57a59c24a0f 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -50,6 +50,7 @@ struct mptcp_info {
 	__u8	mptcpi_add_addr_signal_max;
 	#define mptcpi_endp_signal_max mptcpi_add_addr_signal_max
 	__u8	mptcpi_add_addr_accepted_max;
+	#define mptcpi_limit_add_addr_accepted mptcpi_add_addr_accepted_max
 	__u32	mptcpi_flags;
 	__u32	mptcpi_token;
 	__u64	mptcpi_write_seq;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1c6d0a21c346da90f6bb85d9a281b606dcc576e1..43bb7bcf3de951fe148cc8dc1cd207f954e92562 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -21,7 +21,7 @@ struct pm_nl_pernet {
 	unsigned int		addrs;
 	unsigned int		stale_loss_cnt;
 	unsigned int		endp_signal_max;
-	unsigned int		add_addr_accept_max;
+	unsigned int		limit_add_addr_accepted;
 	unsigned int		local_addr_max;
 	unsigned int		limit_extra_subflows;
 	unsigned int		next_id;
@@ -54,13 +54,13 @@ unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_signal_max);
 
-unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	return READ_ONCE(pernet->add_addr_accept_max);
+	return READ_ONCE(pernet->limit_add_addr_accepted);
 }
-EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
+EXPORT_SYMBOL_GPL(mptcp_pm_get_limit_add_addr_accepted);
 
 unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk)
 {
@@ -538,16 +538,16 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int limit_extra_subflows;
-	unsigned int add_addr_accept_max;
+	unsigned int limit_add_addr_accepted;
 	struct mptcp_addr_info remote;
 	bool sf_created = false;
 	int i, nr;
 
-	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
+	limit_add_addr_accepted = mptcp_pm_get_limit_add_addr_accepted(msk);
 	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
 	pr_debug("accepted %d:%d remote family %d\n",
-		 msk->pm.add_addr_accepted, add_addr_accept_max,
+		 msk->pm.add_addr_accepted, limit_add_addr_accepted,
 		 msk->pm.remote.family);
 
 	remote = msk->pm.remote;
@@ -578,7 +578,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		/* add_addr_accepted is not decr for ID 0 */
 		if (remote.id)
 			msk->pm.add_addr_accepted++;
-		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+		if (msk->pm.add_addr_accepted >= limit_add_addr_accepted ||
 		    msk->pm.extra_subflows >= limit_extra_subflows)
 			WRITE_ONCE(msk->pm.accept_addr, false);
 	}
@@ -587,10 +587,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 {
 	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+		unsigned int limit_add_addr_accepted =
+			mptcp_pm_get_limit_add_addr_accepted(msk);
+
 		/* Note: if the subflow has been closed before, this
 		 * add_addr_accepted counter will not be decremented.
 		 */
-		if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+		if (--msk->pm.add_addr_accepted < limit_add_addr_accepted)
 			WRITE_ONCE(msk->pm.accept_addr, true);
 	}
 }
@@ -1274,7 +1277,7 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 	int ret;
 
 	spin_lock_bh(&pernet->lock);
-	rcv_addrs = pernet->add_addr_accept_max;
+	rcv_addrs = pernet->limit_add_addr_accepted;
 	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
 	if (ret)
 		goto unlock;
@@ -1284,7 +1287,7 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto unlock;
 
-	WRITE_ONCE(pernet->add_addr_accept_max, rcv_addrs);
+	WRITE_ONCE(pernet->limit_add_addr_accepted, rcv_addrs);
 	WRITE_ONCE(pernet->limit_extra_subflows, subflows);
 
 unlock:
@@ -1308,7 +1311,7 @@ int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 		goto fail;
 
 	if (nla_put_u32(msg, MPTCP_PM_ATTR_RCV_ADD_ADDRS,
-			READ_ONCE(pernet->add_addr_accept_max)))
+			READ_ONCE(pernet->limit_add_addr_accepted)))
 		goto fail;
 
 	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOWS,
@@ -1503,7 +1506,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 		    subflows_allowed) ||
 		   !!mptcp_pm_get_endp_signal_max(msk));
 	WRITE_ONCE(pm->accept_addr,
-		   !!mptcp_pm_get_add_addr_accept_max(msk) &&
+		   !!mptcp_pm_get_limit_add_addr_accepted(msk) &&
 		   subflows_allowed);
 	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 31da0aa0f52443c16324dfe2a266252994bf656c..63c46a00c9d48c4e6d41753b5f020f7cf39ffba0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1178,7 +1178,7 @@ void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
@@ -1200,7 +1200,7 @@ static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
 	       msk->pm.local_addr_used == 0 &&
-	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
+	       mptcp_pm_get_limit_add_addr_accepted(msk) == 0 &&
 	       msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk);
 }
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 4688e0f25d15d9363b33bdcf3ad75c8295a810e3..5ab9909dbe799bed5c59d2b1b04cc0e88e960574 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -976,8 +976,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_limit_extra_subflows(msk);
 		info->mptcpi_endp_signal_max =
 			mptcp_pm_get_endp_signal_max(msk);
-		info->mptcpi_add_addr_accepted_max =
-			mptcp_pm_get_add_addr_accept_max(msk);
+		info->mptcpi_limit_add_addr_accepted =
+			mptcp_pm_get_limit_add_addr_accepted(msk);
 		info->mptcpi_local_addr_max =
 			mptcp_pm_get_local_addr_max(msk);
 	}

-- 
2.51.0

