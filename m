Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367321FF3F
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217367; cv=none; b=QumHgmYyHLpcRVRPp/SDVkhv26IPSwsJtNpe02YO/+A6CQOXSSxgANi3R8VcMEOeUV1QLhnfFXDJtHnaBc4OGlfslSB0oQjbCxpUrGKXFs7hx66Gtk8N19KMzNRnA9sWiqFwkg+syqoPV3YbhDi4JLkIKpYiVGHhjAu9FI6TuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217367; c=relaxed/simple;
	bh=Md4AcybOrU7HH6m1PiMXZeD7csP/jwF0E7sWrjnF/UI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=usRrpkVZmdl5pp+18BP4BZkunDfZiR4mXWkrZdfc79/wqb023VWl3AgI0OR6lsXLYXXWBv1bcgKcM4w4j+WtTFs4zYw+1uJ2uXUHcxwistWsBcxQXmdKKhKXOmpmvLU6+nwHDmnNj0DXle9rNLAcysrbv5B+PqQ2b1Tb3NZqYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5cOP6Gh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5cOP6Gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02492C4CEE7;
	Thu, 18 Sep 2025 17:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217366;
	bh=Md4AcybOrU7HH6m1PiMXZeD7csP/jwF0E7sWrjnF/UI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q5cOP6GhhI1bEmpWKh6soVd+nw3pvmQZ03ldmwEnAwfsH86bWELmiFBCEy9tozVmE
	 4tHOtNVb1So1smQbCmoRaHo4JRTgj3BXYyhqbroe3NsAL3/0NFsCC/EEB3lwQl1DTo
	 vXQ45E44rkmbyeRpgjiBKJv0CQiWbHPbIzXpq3LrCWglukwPPjyp8r7yT3of6VBMfU
	 gSWhnB2j7h7BYx80v61Z2940zpcwGpyHYuwKn/aX+g6Y24nNdg/2FdnZDA0BOtIKVi
	 tljNXAVB8GC3Wb37q94p6yZREsb5KiS3nai1alFfDbvDKW//RfHTZuu58GEHBsEEAk
	 mA24aonCtUy+Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Sep 2025 19:42:20 +0200
Subject: [PATCH mptcp-next 04/10] mptcp: pm: rename 'subflows' to
 'extra_subflows'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pm-kern-endp-add_addr-v1-4-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10017; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Md4AcybOrU7HH6m1PiMXZeD7csP/jwF0E7sWrjnF/UI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuHRJ5y8y1spZy3guzOf95N32HzdEaQbtbtFYsedrw
 A5nWwWljlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl8VmH4p6Juv/XmjuI9q/vd
 zY253sh7Tljdk/SmPnBlRtFM9r63wYwMb0//XLHjoMOCHuvmB5KPNnj+FNPq0rSesza7J6ky9/J
 GTgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the Path-Managers are confusing, and it would
help current and future developers, to clarify them.

One of them is 'subflows', which in fact represents the number of extra
subflows: all the additional subflows created after the initial one, and
not the total number of subflows.

While at it, add an additional name for the corresponding variable in
MPTCP INFO: mptcpi_extra_subflows. Not to break the current uAPI, the
new name is added as a 'define' pointing to the former name. This will
then also help userspace devs.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h                        |  1 +
 net/mptcp/pm.c                                    | 10 +++++-----
 net/mptcp/pm_kernel.c                             | 24 +++++++++++------------
 net/mptcp/pm_userspace.c                          |  2 +-
 net/mptcp/protocol.h                              |  6 +++---
 net/mptcp/sockopt.c                               |  4 ++--
 tools/testing/selftests/bpf/progs/mptcp_subflow.c |  2 +-
 7 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 15eef878690b8556af21be8d959b6a2c9fe617d3..f807c8dba56e7eb278fce0ad3184de3d0e24399b 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -42,6 +42,7 @@
 
 struct mptcp_info {
 	__u8	mptcpi_subflows;
+	#define mptcpi_extra_subflows mptcpi_subflows
 	__u8	mptcpi_add_addr_signal;
 	__u8	mptcpi_add_addr_accepted;
 	__u8	mptcpi_subflows_max;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index edaf93fe6f86b32aee8e9bb88318b1dc2a7fcb5e..2e0b7509b8a91cba14f656480f425e0f7241890e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -489,7 +489,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	if (mptcp_pm_is_userspace(msk)) {
 		if (mptcp_userspace_pm_active(msk)) {
 			spin_lock_bh(&pm->lock);
-			pm->subflows++;
+			pm->extra_subflows++;
 			spin_unlock_bh(&pm->lock);
 			return true;
 		}
@@ -498,7 +498,7 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
-	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
+	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->extra_subflows,
 		 subflows_max, READ_ONCE(pm->accept_subflow));
 
 	/* try to avoid acquiring the lock below */
@@ -507,8 +507,8 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 
 	spin_lock_bh(&pm->lock);
 	if (READ_ONCE(pm->accept_subflow)) {
-		ret = pm->subflows < subflows_max;
-		if (ret && ++pm->subflows == subflows_max)
+		ret = pm->extra_subflows < subflows_max;
+		if (ret && ++pm->extra_subflows == subflows_max)
 			WRITE_ONCE(pm->accept_subflow, false);
 	}
 	spin_unlock_bh(&pm->lock);
@@ -594,7 +594,7 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	if (mptcp_pm_is_userspace(msk)) {
 		if (update_subflows) {
 			spin_lock_bh(&pm->lock);
-			pm->subflows--;
+			pm->extra_subflows--;
 			spin_unlock_bh(&pm->lock);
 		}
 		return;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 8d5df9b98589e5cd69f16dc54e9140e88a1835e2..6439f877f334083d86c85d3c19caebba8da7902c 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -175,7 +175,7 @@ fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
 	if (!mptcp_pm_addr_families_match(sk, local, &remote))
 		return 0;
 
-	msk->pm.subflows++;
+	msk->pm.extra_subflows++;
 	*addrs = remote;
 
 	return 1;
@@ -218,10 +218,10 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 
 		/* forbid creating multiple address towards this id */
 		__set_bit(addrs[i].id, unavail_id);
-		msk->pm.subflows++;
+		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.subflows >= subflows_max)
+		if (msk->pm.extra_subflows >= subflows_max)
 			break;
 	}
 
@@ -309,7 +309,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
 		 msk->pm.local_addr_used, local_addr_max,
 		 msk->pm.add_addr_signaled, add_addr_signal_max,
-		 msk->pm.subflows, subflows_max);
+		 msk->pm.extra_subflows, subflows_max);
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
@@ -349,7 +349,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 subflow:
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < local_addr_max &&
-	       msk->pm.subflows < subflows_max) {
+	       msk->pm.extra_subflows < subflows_max) {
 		struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
 		bool fullmesh;
 		int i, nr;
@@ -428,10 +428,10 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 					  local->addr.port))
 			local->addr.id = 0;
 
-		msk->pm.subflows++;
+		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.subflows >= subflows_max)
+		if (msk->pm.extra_subflows >= subflows_max)
 			break;
 	}
 	rcu_read_unlock();
@@ -470,10 +470,10 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 			continue;
 
 		msk->pm.local_addr_used++;
-		msk->pm.subflows++;
+		msk->pm.extra_subflows++;
 		i++;
 
-		if (msk->pm.subflows >= subflows_max)
+		if (msk->pm.extra_subflows >= subflows_max)
 			break;
 	}
 
@@ -497,7 +497,7 @@ fill_local_address_any(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 	if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
 		return 0;
 
-	msk->pm.subflows++;
+	msk->pm.extra_subflows++;
 
 	return 1;
 }
@@ -573,7 +573,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		if (remote.id)
 			msk->pm.add_addr_accepted++;
 		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-		    msk->pm.subflows >= subflows_max)
+		    msk->pm.extra_subflows >= subflows_max)
 			WRITE_ONCE(msk->pm.accept_addr, false);
 	}
 }
@@ -1415,7 +1415,7 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
+	if (msk->pm.extra_subflows == mptcp_pm_get_subflows_max(msk) ||
 	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
 			       MPTCP_PM_MAX_ADDR_ID + 1, 0) == MPTCP_PM_MAX_ADDR_ID + 1)) {
 		WRITE_ONCE(msk->pm.work_pending, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1911fe1799fa38a53381247a830a9a0daf1c4492..d838e8ea65fd4ef8b5d0698f0d4586d565fab32f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -419,7 +419,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
 	else
-		msk->pm.subflows++;
+		msk->pm.extra_subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0d6dae37c9daf4ec8990b9a87036aa393add585c..33f7bf9a8c1344a01432c18d183a5d1b2d1f2c9e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -236,7 +236,7 @@ struct mptcp_pm_data {
 	u8		add_addr_accepted;
 	u8		local_addr_used;
 	u8		pm_type;
-	u8		subflows;
+	u8		extra_subflows;
 	u8		status;
 
 	);
@@ -1185,7 +1185,7 @@ unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
 {
-	if (--msk->pm.subflows < mptcp_pm_get_subflows_max(msk))
+	if (--msk->pm.extra_subflows < mptcp_pm_get_subflows_max(msk))
 		WRITE_ONCE(msk->pm.accept_subflow, true);
 }
 
@@ -1201,7 +1201,7 @@ static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
 	       msk->pm.local_addr_used == 0 &&
 	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
-	       msk->pm.subflows < mptcp_pm_get_subflows_max(msk);
+	       msk->pm.extra_subflows < mptcp_pm_get_subflows_max(msk);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2abe6f1e99400498e915176c360be9281fd524f6..17966da80239d731de925f3e4211b3ee00f802e4 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -962,7 +962,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 
 	memset(info, 0, sizeof(*info));
 
-	info->mptcpi_subflows = READ_ONCE(msk->pm.subflows);
+	info->mptcpi_extra_subflows = READ_ONCE(msk->pm.extra_subflows);
 	info->mptcpi_add_addr_signal = READ_ONCE(msk->pm.add_addr_signaled);
 	info->mptcpi_add_addr_accepted = READ_ONCE(msk->pm.add_addr_accepted);
 	info->mptcpi_local_addr_used = READ_ONCE(msk->pm.local_addr_used);
@@ -996,7 +996,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
-	info->mptcpi_subflows_total = info->mptcpi_subflows +
+	info->mptcpi_subflows_total = info->mptcpi_extra_subflows +
 		__mptcp_has_initial_subflow(msk);
 	now = tcp_jiffies32;
 	info->mptcpi_last_data_sent = jiffies_to_msecs(now - msk->last_data_sent);
diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
index 70302477e326eecaef6aad4ecf899aa3d6606f23..41389e579578b7d6c0d9ffff520c9f3e930abb51 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
@@ -117,7 +117,7 @@ int _getsockopt_subflow(struct bpf_sockopt *ctx)
 		return 1;
 
 	msk = bpf_core_cast(sk, struct mptcp_sock);
-	if (msk->pm.subflows != 1) {
+	if (msk->pm.extra_subflows != 1) {
 		ctx->retval = -1;
 		return 1;
 	}

-- 
2.51.0

