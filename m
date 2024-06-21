Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49216174EED
	for <mptcp@lists.linux.dev>; Fri, 21 Jun 2024 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969968; cv=none; b=AuZ0SuWp3nms3/FI6U4WlmZcJoTURymQM/UM7wwwCnFPRaEeFE+qvGAEzHvCGH/Fe+QltV38jMuIlW3i0r/zI4pMT2U4SQQXXXTi5jqgBi6EK8rueHtUm0ZYTxN/muAmFy54ooqztOpmkYeRnqHvWgcZ+DRMPiO8exKBH+icmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969968; c=relaxed/simple;
	bh=3cqSJ+rQBhqK/BunDk7NEDtDeXP1Y+n7Dy+gGOVdQdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=buIPI3sYf4PjEEUV0dT60JuJTaC3Nm3aidMKMuX28LYcXkkbekLNBclSLc/SdSZkCNnjEBHglyPSNR4PvZYH82u39AhKkx+cOdHyQ+PbibVM8dEvyDOuBatjnIMiFgXeciSC2YtaF+X3DdFFV8QReloBkZO0/TBLTxak/WHDPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rmuc4mET; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rmuc4mET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28769C3277B;
	Fri, 21 Jun 2024 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718969967;
	bh=3cqSJ+rQBhqK/BunDk7NEDtDeXP1Y+n7Dy+gGOVdQdc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rmuc4mETp9FICY5ZzK+YWFVxUO7T2jc3YIjna3+8h7XjOQSGIBWzhuU56joXiMe8s
	 w9XS8IYWhvqIgX6AS18BUr8eKCKdMm038/PdQnvWauWxJ+cNlVS5oc81xCjhataZg4
	 dSSvaPSLuVLOKg/IL4ct0iv9VVD8V9KSC+wxR5RKE9BspOzEPp5dk7GdWul5HnwWLH
	 6QntT5wDeJ+HQpZqoOOP1jBvR2rGBrkeDALUkpnhLi1rdjJryflEYbXwySzpdBXV7V
	 R1fXaU+wkiyE0oCP98fo5HAYZvsWpWGAas1mEpMM+28hqEy2ma3HLMaXep0ZXIJkZA
	 5Rv7ysAXPVf3Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Jun 2024 13:39:08 +0200
Subject: [PATCH mptcp-next 2/4] mptcp: split id_avail_bitmap per target
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-mptcp-pm-avail-v1-2-b692d5eb89b5@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
In-Reply-To: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6546; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3cqSJ+rQBhqK/BunDk7NEDtDeXP1Y+n7Dy+gGOVdQdc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmdWZsyr/bjiE8E4nKGvBrpYhfAgZDDdLoScQ9r
 5faIXlKs1WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZnVmbAAKCRD2t4JPQmmg
 c4zrEADuFk4t35236e619r7rhsf+EaK5VyB1nhzCsMnoyi9Ei/Zlg8gkf0A7CceG1sgUDFF6bAx
 ROeKFzr8ZV6/L3/a6n+71xiXdiG5WiuGhXiWl8wup63FBPG2qp/Lko5J/pdzRWU5wZ0/Qny4P1N
 UidfsihhsJEJc2vAOsyDjyQIYAgxuL74sg/VhMOWKN3fTf3DeObaFMA6k7qiTbYZF4bZKxonHrX
 QffX1AtZxN512dWQ30q0grTnMwgseswzXTPLrTWGm0vAfDrYXi+kB/IS657DxQJad89BpAxQJWr
 g67E9ChHZvLYfP48mGUL9QCqihc8lai0VJeZPnnw5aGsqYdW5FXPvtntEihExftckbqFRlRIQVe
 /TMzeJ5nSc2d1FXlqsp+aewFawooMmThnW8AFWU1AeQmT5iHw0pWEnmrMf9SGpA2OVeDz6XPRoM
 9pZVahc7WDsBfHYeJkPI1GEcHOgbt7pTINpN5kSKvByNYI04s9vNvDFFyi3bINRp3yE8hdta7t3
 /PjW19X33dqeHkS4PwqpXC+zmWMs0PtdHwr6/CG3ty+iqNWIeUTYiI5t8vbzYuKSw3VekkCEmQy
 aWzIyMxq5E5fYc1ScPrHOj9f/NQcfSyZ5Wy2mlmlsvABYQ289AfbQgA2wZmR9Ta95UJK6FfOtZd
 nwTQu2G9r23RhCA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Up to the 'Fixes' commit, having an endpoint with both the 'signal' and
'subflow' flags, resulted in the creation of a subflow and an address
announcement using the address linked to this endpoint. After this
commit, only the address announcement was done, ignoring the 'subflow'
flag.

That's because the same bitmap was used for the two flags. It is easy to
split it in two: one for 'signal', and one for 'subflow'.

It is unusual to set the two flags together: creating a new subflow
using a new local address will implicitly advertise it to the other
peer. So in theory, no need to advertise it explicitly as well. Maybe
there are use-cases -- the subflow might not reach the other peer that
way, we can ask the other peer to try initiating the new subflow without
delay -- or very likely the user is confused, and put both flags "just
to be sure at least the right one is set". Still, the kernel should do
what has been asked: using this endpoint to announce the address and to
create a new subflow from it.

An alternative is to forbid the use of the two flags together, but
that's probably too late, and there are maybe use-cases. This patch will
avoid people complaining subflows are not created using the endpoint
they added with the 'subflow' and 'signal' flag.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         |  3 ++-
 net/mptcp/pm_netlink.c | 20 ++++++++++++--------
 net/mptcp/protocol.h   |  5 +++--
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 55406720c607..d29fb35bb927 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -543,7 +543,8 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->addr_signal, 0);
 	WRITE_ONCE(pm->remote_deny_join_id0, false);
 	pm->status = 0;
-	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	bitmap_fill(msk->pm.id_avail_signals_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	bitmap_fill(msk->pm.id_avail_subflows_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ea9e5817b9e9..4805452d05a2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -156,7 +156,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 
-		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+		if (!test_bit(entry->addr.id, msk->pm.id_avail_subflows_bitmap))
 			continue;
 
 		ret = entry;
@@ -178,10 +178,10 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
 	 * can lead to additional addresses not being announced.
 	 */
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 
-		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+		if (!test_bit(entry->addr.id, msk->pm.id_avail_signals_bitmap))
 			continue;
 
 		ret = entry;
@@ -228,7 +228,9 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
 	if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
-	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
+	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_signals_bitmap,
+			       MPTCP_PM_MAX_ADDR_ID + 1, 0) == MPTCP_PM_MAX_ADDR_ID + 1) ||
+	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_subflows_bitmap,
 			       MPTCP_PM_MAX_ADDR_ID + 1, 0) == MPTCP_PM_MAX_ADDR_ID + 1)) {
 		WRITE_ONCE(msk->pm.work_pending, false);
 		return false;
@@ -537,7 +539,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		rcu_read_lock();
 		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
-			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
+			__clear_bit(entry->addr.id, msk->pm.id_avail_signals_bitmap);
+			__clear_bit(entry->addr.id, msk->pm.id_avail_subflows_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
 			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 		}
@@ -570,7 +573,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		if (local) {
 			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
-				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+				__clear_bit(local->addr.id, msk->pm.id_avail_signals_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
 				mptcp_pm_nl_addr_send_ack(msk);
@@ -592,7 +595,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
 		msk->pm.local_addr_used++;
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(local->addr.id, msk->pm.id_avail_subflows_bitmap);
 		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
 		if (nr == 0)
 			continue;
@@ -822,7 +825,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 		if (rm_type == MPTCP_MIB_RMSUBFLOW)
-			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
+			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id,
+				  msk->pm.id_avail_subflows_bitmap);
 		else if (rm_type == MPTCP_MIB_RMADDR)
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		if (!removed)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 19d60b6d5b45..cbb430108823 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -187,7 +187,7 @@ enum mptcp_pm_status {
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 	MPTCP_PM_ALREADY_ESTABLISHED,	/* persistent status, set after ESTABLISHED event */
 	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED /* persistent status, set after MPC local address is
-					 * accounted int id_avail_bitmap
+					 * accounted in id_avail_*_bitmap
 					 */
 };
 
@@ -231,7 +231,8 @@ struct mptcp_pm_data {
 	u8		pm_type;
 	u8		subflows;
 	u8		status;
-	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	DECLARE_BITMAP(id_avail_signals_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	DECLARE_BITMAP(id_avail_subflows_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_rm_list rm_list_tx;
 	struct mptcp_rm_list rm_list_rx;
 };

-- 
2.43.0

