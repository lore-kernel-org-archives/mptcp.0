Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710A21FF3F
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217369; cv=none; b=gfH/AR2Jd5p2CsWqLpptx4VAwo5aTbJGSeD9YMzA83zdsPSE/GRKeEiaAaJOTiAnftzgNZhhMgeusanuP6/+cu85r8b+c5AUG+Zx2h+C3WwJw6FuU/uXuObnMDJ2fbHTFdgCVA4o8aN0QrTZx+Cdi13GqwivMSQoNxCZmb5e8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217369; c=relaxed/simple;
	bh=jxRRANn4Qwl166UwwFtoMrDgbF8sMoelM8UuOCJaGOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NORJyae27R6SsFieYHYbt5+AzTALIzpinl1lYNbvv/8lwrKYvw6E3iYAJWbKkQpO50MpExXICzLapI1U1ZD7jvJ5UAJ1Kt0KMUKvt+uHJTpKOBE9zjJnS8eSKyYSIeymdcoqAMx3vR2lZ2iQRLvFs0m7/P+hhv+tXrhRw+75p3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmxMiHbR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmxMiHbR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87862C4CEE7;
	Thu, 18 Sep 2025 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217369;
	bh=jxRRANn4Qwl166UwwFtoMrDgbF8sMoelM8UuOCJaGOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gmxMiHbRVNRYUYOEICUTgHPllrRySmp9MLdCCP2B+5Gn9p/ELhS+AYoc7qmdNlbjj
	 vMBuGcajUJirmhVc/BF+CD6METk9JqrRUaiVhbkUASgRca9t0X7lcnoPJpJvbT/GvV
	 oTFhsme0u9FNX0Ff/2PF2wfK3BhY+FSQDnpg85plTzRq8Q6t4ZbBCutgUlk0k3KMDz
	 RVvfMEjhbPNk3NyYrx9iMO63+gAX8bgNI2zRk0NGkkgWTqSy0zPW071dmxwrIWomfX
	 C54XznWXez2+GkR3nOZaz0j1/5DzUEc6cfY8wqRvn+/5Bx1kGYjqqz9/ewJxsrHFIr
	 V05gySwpSqhgg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Sep 2025 19:42:23 +0200
Subject: [PATCH mptcp-next 07/10] mptcp: pm: in-kernel: rename
 'add_addr_accept_max' to 'limit_add_addr_accepted'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pm-kern-endp-add_addr-v1-7-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7580; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jxRRANn4Qwl166UwwFtoMrDgbF8sMoelM8UuOCJaGOc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuPQVVgfttp1c0jepUnNNzJKYSx+i+q8kLHr2keuN+
 PeLcgk3O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYip8vIsEHg7v9FT30Zdnze
 LPVOmcEmN4i7t4x1oiTvmRj5/F135jH8j5a//v33wscVaiWV76YkCt7g7it8arZq4SG1lfOuTQ9
 8xwIA
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
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_kernel.c      | 26 +++++++++++++-------------
 net/mptcp/protocol.h       |  4 ++--
 net/mptcp/sockopt.c        |  4 ++--
 4 files changed, 18 insertions(+), 17 deletions(-)

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
index eb046d4b0d72ffe20a56a07781a8862b389c93bf..fbe7a0a930b23a5aaaba9420ccb4c914695675a4 100644
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
@@ -534,16 +534,16 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
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
@@ -574,7 +574,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		/* add_addr_accepted is not decr for ID 0 */
 		if (remote.id)
 			msk->pm.add_addr_accepted++;
-		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+		if (msk->pm.add_addr_accepted >= limit_add_addr_accepted ||
 		    msk->pm.extra_subflows >= limit_extra_subflows)
 			WRITE_ONCE(msk->pm.accept_addr, false);
 	}
@@ -586,7 +586,7 @@ void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 		/* Note: if the subflow has been closed before, this
 		 * add_addr_accepted counter will not be decremented.
 		 */
-		if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+		if (--msk->pm.add_addr_accepted < mptcp_pm_get_limit_add_addr_accepted(msk))
 			WRITE_ONCE(msk->pm.accept_addr, true);
 	}
 }
@@ -1270,7 +1270,7 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 	int ret;
 
 	spin_lock_bh(&pernet->lock);
-	rcv_addrs = pernet->add_addr_accept_max;
+	rcv_addrs = pernet->limit_add_addr_accepted;
 	ret = parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
 	if (ret)
 		goto unlock;
@@ -1280,7 +1280,7 @@ int mptcp_pm_nl_set_limits_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto unlock;
 
-	WRITE_ONCE(pernet->add_addr_accept_max, rcv_addrs);
+	WRITE_ONCE(pernet->limit_add_addr_accepted, rcv_addrs);
 	WRITE_ONCE(pernet->limit_extra_subflows, subflows);
 
 unlock:
@@ -1304,7 +1304,7 @@ int mptcp_pm_nl_get_limits_doit(struct sk_buff *skb, struct genl_info *info)
 		goto fail;
 
 	if (nla_put_u32(msg, MPTCP_PM_ATTR_RCV_ADD_ADDRS,
-			READ_ONCE(pernet->add_addr_accept_max)))
+			READ_ONCE(pernet->limit_add_addr_accepted)))
 		goto fail;
 
 	if (nla_put_u32(msg, MPTCP_PM_ATTR_SUBFLOWS,
@@ -1499,7 +1499,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
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

