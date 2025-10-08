Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A3288C0E
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932021; cv=none; b=dxlkTfD3qpemqHPRfERzZ3emTxKqiRMp+l/n2HvnURwlj2B3PD632yQsnL1wrfTZy/2d8Kx1UL/BlIl5PvmpZ6GOKZGq20de5qfMMlw3k5Kq8Pcty8wab2v65fRMJDwI9gYnHOZOfQvlNqAakISxNJ8ldmkMJZpjAR3NdBH71eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932021; c=relaxed/simple;
	bh=qDNiunwNw0uMf4xSBrGK7rg9QiuNn0qVryzoqfxYbYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/gb6F/8WOAErk5L4BaaW4z3TQtd/Rhxo0yGsdWL45wXs92VB69wAY6rDoYFpedRrMwM6TMLPl+X2fwxXQ70hQvdKpkSq3g8EP2R+mvl7tgQYgclZiEuwETCbwUaQ6st/mLAlbg6gFq+pMORhjwR8az2DtmaWUO46x8tIgJk/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnx3/Jgu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnx3/Jgu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BECC4CEF4;
	Wed,  8 Oct 2025 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932020;
	bh=qDNiunwNw0uMf4xSBrGK7rg9QiuNn0qVryzoqfxYbYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dnx3/JgugVmTZTTdI298Bk4tGSy6xKYceHigmxxg9FdTAhErErYu8/nFJgheKR0pF
	 KqonJNH+aORAjH5GP3AYAcu+/3Yoju/6VPztorg+Fzp02PQVvyPU/BPPfWkIOEbPZE
	 hLEsKoCjB+IWXrzf/3EjoTWlAc8ZQb8AC7MWsQHQLkFceoApMcwciyZ0aRzUpi2UZW
	 2EMf/QjM1Md+wdKcv9HYjcb3XoH4vnAHoiRznMuyVoHmtJ7yG/L+TRyWiK+b2cDCBs
	 WwSDFSbmuSR07PNJzLZ89h7053F0RuDjMrwpTdHNdyi03nOHvkbfRU6FkUytKsN9z+
	 yrhAd4Q0Txxuw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Oct 2025 16:00:00 +0200
Subject: [PATCH mptcp-net 6/7] mptcp: pm: in-kernel: record fullmesh endp
 nb
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-c-flag-add-addr-delay-v1-6-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5255; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qDNiunwNw0uMf4xSBrGK7rg9QiuNn0qVryzoqfxYbYQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKe5eVKTHlV3bnWLoiDbUbxx6kPJnPe7Xwqttrw+9XFH
 U8f+PO96yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiI5l+G3yxXW+8bf8uICv5z
 dL19wfxHNavOX5/Reu7oMduLe09kNk5nZNj47OlhpiVKR06+f3fE+dvhty+nh8Xs6Ji7d7qyefL
 XQ4+4AQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of iterating over all endpoints, under RCU read lock, just to
check if one of them as the fullmesh flag, we can keep a counter of
fullmesh endpoint, similar to what is done with the other flags.

This counter is now checked, before iterating over all endpoints.

Similar to the other counters, this new one is also exposed. A userspace
app can then know when it is being used in a fullmesh mode, with
potentially (too) many subflows.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |  3 ++-
 net/mptcp/pm_kernel.c      | 38 +++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h       |  1 +
 net/mptcp/sockopt.c        |  2 ++
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 87cfab874e24..04eea6d1d0a9 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -70,7 +70,8 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_acked;
 	__u8	mptcpi_subflows_total;
 	__u8	mptcpi_endp_laminar_max;
-	__u8	reserved[2];
+	__u8	mptcpi_endp_fullmesh_max;
+	__u8	reserved;
 	__u32	mptcpi_last_data_sent;
 	__u32	mptcpi_last_data_recv;
 	__u32	mptcpi_last_ack_recv;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index df2bc36593d0..054d85045381 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -22,6 +22,7 @@ struct pm_nl_pernet {
 	u8			endp_signal_max;
 	u8			endp_subflow_max;
 	u8			endp_laminar_max;
+	u8			endp_fullmesh_max;
 	u8			limit_add_addr_accepted;
 	u8			limit_extra_subflows;
 	u8			next_id;
@@ -70,6 +71,14 @@ u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_laminar_max);
 
+u8 mptcp_pm_get_endp_fullmesh_max(const struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return READ_ONCE(pernet->endp_fullmesh_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_fullmesh_max);
+
 u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
@@ -603,9 +612,12 @@ fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 	int i;
 
 	/* If there is at least one MPTCP endpoint with a fullmesh flag */
-	i = fill_local_addresses_vec_fullmesh(msk, remote, locals, c_flag_case);
-	if (i)
-		return i;
+	if (mptcp_pm_get_endp_fullmesh_max(msk)) {
+		i = fill_local_addresses_vec_fullmesh(msk, remote, locals,
+						      c_flag_case);
+		if (i)
+			return i;
+	}
 
 	/* If there is at least one MPTCP endpoint with a laminar flag */
 	if (mptcp_pm_get_endp_laminar_max(msk))
@@ -790,6 +802,10 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		addr_max = pernet->endp_laminar_max;
 		WRITE_ONCE(pernet->endp_laminar_max, addr_max + 1);
 	}
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+		addr_max = pernet->endp_fullmesh_max;
+		WRITE_ONCE(pernet->endp_fullmesh_max, addr_max + 1);
+	}
 
 	pernet->endpoints++;
 	if (!entry->addr.port)
@@ -1188,6 +1204,10 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		addr_max = pernet->endp_laminar_max;
 		WRITE_ONCE(pernet->endp_laminar_max, addr_max - 1);
 	}
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+		addr_max = pernet->endp_fullmesh_max;
+		WRITE_ONCE(pernet->endp_fullmesh_max, addr_max - 1);
+	}
 
 	pernet->endpoints--;
 	list_del_rcu(&entry->list);
@@ -1503,6 +1523,18 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	changed = (local->flags ^ entry->flags) & mask;
 	entry->flags = (entry->flags & ~mask) | (local->flags & mask);
 	*local = *entry;
+
+	if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+		u8 addr_max = pernet->endp_fullmesh_max;
+
+		if (entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
+			addr_max++;
+		else
+			addr_max--;
+
+		WRITE_ONCE(pernet->endp_fullmesh_max, addr_max);
+	}
+
 	spin_unlock_bh(&pernet->lock);
 
 	mptcp_pm_nl_set_flags_all(net, local, changed);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0545eab23125..1e8f40bb7870 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1180,6 +1180,7 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_endp_fullmesh_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a28a48385885..de90a2897d2d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -982,6 +982,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_endp_subflow_max(msk);
 		info->mptcpi_endp_laminar_max =
 			mptcp_pm_get_endp_laminar_max(msk);
+		info->mptcpi_endp_fullmesh_max =
+			mptcp_pm_get_endp_fullmesh_max(msk);
 	}
 
 	if (__mptcp_check_fallback(msk))

-- 
2.51.0

