Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2614A91
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749506; cv=none; b=TZZ4Jr6KEzFXVLk8lhquHNuaUz/KoaDputWlHDCffH9Oqjt4RjhQrA1M+ASsCkF3g6L3M1gRFfH/CRbHaDe4qTczxCWSiKEnA0wZgXkpY1aEriYNtCAJDLr58klFY1LLoPYO7VTNKEqDJphBrW9xbh6a4FszQPe07NpDyobQxv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749506; c=relaxed/simple;
	bh=srrKjxGJET1ZWAdtRGz78BrE5Ull+xjdfEioHlrjzZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5IEeeEcTM7UsQoZhSNweE9QYK5rXsWG34ta28tJvy80yLP1O47KbD3MPVTMfAaw20/6u9FwoQAIoTDTeSpmuEG5koSgJBOdTk6Q7iVrRTw703Jm3geeEkkdgWkgSO8xgEKGfkWcSEtqiuTglLD0kPVRlQDGmXnGBZr6Iw/kkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/GXbAJ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/GXbAJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71A0C4CED6;
	Fri, 28 Feb 2025 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749505;
	bh=srrKjxGJET1ZWAdtRGz78BrE5Ull+xjdfEioHlrjzZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H/GXbAJ81EdyWwuHcIxfl3RpJHP1NGagoa8MO+TVkSfZR5W0ghvr7NSUuC11oUimY
	 Q/iqFARiiK7mtz6kS/ZJW1c8QX9kDOakhF7fvmc9cInXW8OPZnWwuaqAHfF+6WZBDA
	 57MVQnQr8aiKG1BuL20gPHQV/7FAAc0jO94bebkuw9PQEcEctcYPAk/JHk/uPlhHSl
	 h4CTP9jGK4N52CDMli9i6voLBMOve7gkyCczgNO+hNc9hQVqXz8haO4TS812O9C5PG
	 ddkpYNu1996DGwLOIY+dOz/EAqcjVfjxBx+qjoiE4a3hm0zlAxCNeuL2MEKzqErF1q
	 WZsyyN/Vqyotg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:24 +0100
Subject: [PATCH mptcp-next v2 04/14] mptcp: pm: remove '_nl' from
 mptcp_pm_nl_rm_addr_received
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-4-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5420; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=srrKjxGJET1ZWAdtRGz78BrE5Ull+xjdfEioHlrjzZg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq5mHVrrMPccL8S7ia5TR/Y71FKo2APQQu4T
 mU8av+oP0qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6uQAKCRD2t4JPQmmg
 c1GND/9nqpzYnV5l7uRa5dwFc7kLCB+I/x9vhYvtSvmZcydMhZ+looDpr8OaVbnYc5U0hU8jGXP
 yZDSpDuYIwTT2O/aMim9n0Lvv9lxXdpi0m/Xu7MEdUTV4vQ2PAZB/bcvTqJKzAaWho6y9mkDSrY
 cgtB6u0a5P2ruxFmMhdHegcl00oCEsNf3q0sLdJgtf06b/G0kdiW8IBByo2WuiqL5hWITqW/nUQ
 +1Twht1VQxhEfZWb9nhrH5rw6zdC5XzNMiNHCcZzIrtVhHz1W9QBjSD3oRFn84Lz2+s4e9ptwYh
 0pbCJshcxbzoT9+YXcfK1tgofAnbVo3ajr8M/rnFqsBFB6ocg4vsRPoVPNpAeJmDKjSuI8Nw15y
 SAUk7YG55oA/EYxuo0HAwESvJ1cz8RJw8L/Jq3OMYShlMl3aQ18ASqhPV7Yx12ai1JEakcwe+X+
 987xf4R79vh4GWqxdCRtnD3N9dYv3DpwVFjDTGquQIq8V4nlSSRejkKoD9SIweaNNdf4IHxrwWc
 vLvZrlMmXOfyBoVtRNFosD8jCwcS/EQBH0X0FCqGz+vFZqRr7LewvqWawlIl0MWxgtXr/6/MFpC
 aJz3pr9Roxc4E0ac0IFGx07/HTMow19sN2bmqMxx7oclcN004yLYWNfJr9uj+uaQzZFZwxcQhPJ
 lbfxYlqi+9kUEiw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, in-kernel PM specific helpers are prefixed with
'mptcp_pm_nl_'. But here 'mptcp_pm_nl_rm_addr_received' is not specific
to this PM: it is called from the PM worker, and used by both the
in-kernel and userspace PMs. The helper has been renamed to
'mptcp_pm_rm_addr_recv' instead of '_received' to avoid confusions with
the one from pm.c.

mptcp_pm_nl_rm_addr_or_subflow', and 'mptcp_pm_nl_rm_subflow_received'
have been updated too for the same reason.

To avoid confusions, the '_nl' bit has been removed from the name.

While at it, the in-kernel PM specific code has been move from
mptcp_pm_rm_addr_or_subflow to a new dedicated helper, clearer.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 55 +++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f6f7ea25640b7f0f71fc6cc3217ea278e15a4c13..09ef3aa025e7094392badfcc24a964c0a530ca5d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -838,9 +838,20 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
-static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
-					   const struct mptcp_rm_list *rm_list,
-					   enum linux_mptcp_mib_field rm_type)
+static void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
+{
+	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+		/* Note: if the subflow has been closed before, this
+		 * add_addr_accepted counter will not be decremented.
+		 */
+		if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+			WRITE_ONCE(msk->pm.accept_addr, true);
+	}
+}
+
+static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
+					const struct mptcp_rm_list *rm_list,
+					enum linux_mptcp_mib_field rm_type)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk = (struct sock *)msk;
@@ -893,35 +904,23 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 
-		if (rm_type == MPTCP_MIB_RMADDR)
+		if (rm_type == MPTCP_MIB_RMADDR) {
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
-
-		if (!removed)
-			continue;
-
-		if (!mptcp_pm_is_kernel(msk))
-			continue;
-
-		if (rm_type == MPTCP_MIB_RMADDR && rm_id &&
-		    !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
-			/* Note: if the subflow has been closed before, this
-			 * add_addr_accepted counter will not be decremented.
-			 */
-			if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
-				WRITE_ONCE(msk->pm.accept_addr, true);
+			if (removed && mptcp_pm_is_kernel(msk))
+				mptcp_pm_nl_rm_addr(msk, rm_id);
 		}
 	}
 }
 
-static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
+static void mptcp_pm_rm_addr_recv(struct mptcp_sock *msk)
 {
-	mptcp_pm_nl_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
+	mptcp_pm_rm_addr_or_subflow(msk, &msk->pm.rm_list_rx, MPTCP_MIB_RMADDR);
 }
 
-static void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
-					    const struct mptcp_rm_list *rm_list)
+static void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
+				const struct mptcp_rm_list *rm_list)
 {
-	mptcp_pm_nl_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
+	mptcp_pm_rm_addr_or_subflow(msk, rm_list, MPTCP_MIB_RMSUBFLOW);
 }
 
 void mptcp_pm_worker(struct mptcp_sock *msk)
@@ -946,7 +945,7 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
 		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
-		mptcp_pm_nl_rm_addr_received(msk);
+		mptcp_pm_rm_addr_recv(msk);
 	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
@@ -1538,7 +1537,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
 		if (remove_subflow) {
 			spin_lock_bh(&msk->pm.lock);
-			mptcp_pm_nl_rm_subflow_received(msk, &list);
+			mptcp_pm_rm_subflow(msk, &list);
 			spin_unlock_bh(&msk->pm.lock);
 		}
 
@@ -1583,7 +1582,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
-		mptcp_pm_nl_rm_subflow_received(msk, &list);
+		mptcp_pm_rm_subflow(msk, &list);
 		__mark_subflow_endp_available(msk, 0);
 		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
@@ -1670,7 +1669,7 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_remove_addr(msk, &alist);
 	}
 	if (slist.nr)
-		mptcp_pm_nl_rm_subflow_received(msk, &slist);
+		mptcp_pm_rm_subflow(msk, &slist);
 	/* Reset counters: maybe some subflows have been removed before */
 	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	msk->pm.local_addr_used = 0;
@@ -1910,7 +1909,7 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
 	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	mptcp_pm_rm_subflow(msk, &list);
 	__mark_subflow_endp_available(msk, list.ids[0]);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 	spin_unlock_bh(&msk->pm.lock);

-- 
2.47.1

