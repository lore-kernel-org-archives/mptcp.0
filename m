Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED31CEACB
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272917; cv=none; b=lU1SnBifKuiIncy6AeqQh8EHioZcZJN7FXybJS9V0zME1KWOZ7jVCUhQtUWMOrc0GHhOP242vgCZEzQyAkgP/SkqyZ8L2Q1GgZ4MwnghW6lS91RFMIa4VYxtD0j0Ccg5U/4K9H0HEceTNPaols4LQwhRNtqR2gy69724fTxkd9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272917; c=relaxed/simple;
	bh=KNO+OmZh3c2EjqDpGxIW1Rd2sUYWi+RqqK3+2kmzFXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EQL+AZyPPDxF37egKq1XmQYYm4o7mbTha0Y+G7HWk+0q+yDEu66YZ2K1L7iviLIBBOh7YnzZzeuUcNxzkUj2dpcqN7etVqkFcr68/65W9Exrk9GYKHtOaCeqUDqMHnZU3/DCvwku5eQ1p0WPEcqV5I6x86HXfHFyhh1W5ISe4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmwWVeul; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmwWVeul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CAFC4CEF7;
	Fri, 19 Sep 2025 09:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272916;
	bh=KNO+OmZh3c2EjqDpGxIW1Rd2sUYWi+RqqK3+2kmzFXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qmwWVeulVLtOrnfrV6cPC8V3/dqqG5NsQuPD29rgBgqGDrRwiNux5Ztmd3dxByTbQ
	 2D1yxhXmVTn8bQbuB4ySMaIlf5iSaOq1Q/zAWYlGjSVK6aCkXjj9jsAfFOreUEMfVH
	 RmlefGKnlcdL0F/byFJcGoNX0d6/8HXg37syQ2ZEe9c4NEPwMfd+nBHAqnu65Z8dWr
	 yzN7YRsaqOYwcmtu+ytMY1L4Zjr9pf6fGqfDWpdqxA9uK0wI/24ks0Ztqa3bKETNuC
	 w+CZ93KEy6UHb9dz8MjwXiZcaOPG/V1EJQ3cjK5rIye1mHoD6nC52VDHRuqFYtz0/8
	 YfOTnn8rMOlcQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 11:08:09 +0200
Subject: [PATCH mptcp-next v2 03/10] mptcp: pm: in-kernel: refactor
 fill_remote_addresses_vec
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-pm-kern-endp-add_addr-v2-3-1f8f04f01914@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
In-Reply-To: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5426; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KNO+OmZh3c2EjqDpGxIW1Rd2sUYWi+RqqK3+2kmzFXc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOyrZe5eyS1TcV2KUs46syP+SpXfnv+7GdEV9T8kXag
 rq37M7qKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmAiPAsNv1qhVF7fnqXsdLC8+
 pKTDV5PUbsc7gU017dp0uco7cfXbGBm+FlQKtZcJv1yctqCRv/LVb0YXO3Gvfcuk0+YeXzQrbhk
 3AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this modification, this function was quite long with many levels
of indentations.

Each case can be split in a dedicated function: fullmesh, non-fullmesh.

To remove one level of indentation, msk->pm.subflows >= subflows_max is
now checked after having added one subflow, and stops the loop if it is
no longer possible to add new subflows. This is fine to do this because
this function should only be called if msk->pm.subflows < subflows_max.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: keep 'Reverse X-Mas Tree' order, and comments (Geliang)
---
 net/mptcp/pm_kernel.c | 116 +++++++++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 49 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 5bdcfcc26308841c49375ce35205097f30592279..7bc243c96f30e20b4da3d610d3b8211e478626e6 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -159,74 +159,92 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
 	return found;
 }
 
-/* Fill all the remote addresses into the array addrs[],
- * and return the array size.
- */
-static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
-					      struct mptcp_addr_info *local,
-					      bool fullmesh,
-					      struct mptcp_addr_info *addrs)
+static unsigned int
+fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
+		 struct mptcp_addr_info *addrs)
 {
 	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
+	struct mptcp_addr_info remote = { 0 };
+	struct sock *sk = (struct sock *)msk;
+
+	if (deny_id0)
+		return 0;
+
+	mptcp_remote_address((struct sock_common *)sk, &remote);
+
+	if (!mptcp_pm_addr_families_match(sk, local, &remote))
+		return 0;
+
+	msk->pm.subflows++;
+	*addrs = remote;
+
+	return 1;
+}
+
+static unsigned int
+fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
+			       struct mptcp_addr_info *local,
+			       struct mptcp_addr_info *addrs)
+{
+	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
+	DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct sock *sk = (struct sock *)msk, *ssk;
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_addr_info remote = { 0 };
 	unsigned int subflows_max;
 	int i = 0;
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
-	mptcp_remote_address((struct sock_common *)sk, &remote);
 
-	/* Non-fullmesh endpoint, fill in the single entry
-	 * corresponding to the primary MPC subflow remote address
+	/* Forbid creation of new subflows matching existing ones, possibly
+	 * already created by incoming ADD_ADDR
 	 */
-	if (!fullmesh) {
-		if (deny_id0)
-			return 0;
+	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+	mptcp_for_each_subflow(msk, subflow)
+		if (READ_ONCE(subflow->local_id) == local->id)
+			__set_bit(subflow->remote_id, unavail_id);
 
-		if (!mptcp_pm_addr_families_match(sk, local, &remote))
-			return 0;
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
+		addrs[i].id = READ_ONCE(subflow->remote_id);
+		if (deny_id0 && !addrs[i].id)
+			continue;
 
+		if (test_bit(addrs[i].id, unavail_id))
+			continue;
+
+		if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
+			continue;
+
+		/* forbid creating multiple address towards this id */
+		__set_bit(addrs[i].id, unavail_id);
 		msk->pm.subflows++;
-		addrs[i++] = remote;
-	} else {
-		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+		i++;
 
-		/* Forbid creation of new subflows matching existing
-		 * ones, possibly already created by incoming ADD_ADDR
-		 */
-		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
-		mptcp_for_each_subflow(msk, subflow)
-			if (READ_ONCE(subflow->local_id) == local->id)
-				__set_bit(subflow->remote_id, unavail_id);
-
-		mptcp_for_each_subflow(msk, subflow) {
-			ssk = mptcp_subflow_tcp_sock(subflow);
-			mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
-			addrs[i].id = READ_ONCE(subflow->remote_id);
-			if (deny_id0 && !addrs[i].id)
-				continue;
-
-			if (test_bit(addrs[i].id, unavail_id))
-				continue;
-
-			if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
-				continue;
-
-			if (msk->pm.subflows < subflows_max) {
-				/* forbid creating multiple address towards
-				 * this id
-				 */
-				__set_bit(addrs[i].id, unavail_id);
-				msk->pm.subflows++;
-				i++;
-			}
-		}
+		if (msk->pm.subflows >= subflows_max)
+			break;
 	}
 
 	return i;
 }
 
+/* Fill all the remote addresses into the array addrs[],
+ * and return the array size.
+ */
+static unsigned int
+fill_remote_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *local,
+			  bool fullmesh, struct mptcp_addr_info *addrs)
+{
+	/* Non-fullmesh: fill in the single entry corresponding to the primary
+	 * MPC subflow remote address, and return 1, corresponding to 1 entry.
+	 */
+	if (!fullmesh)
+		return fill_remote_addr(msk, local, addrs);
+
+	/* Fullmesh endpoint: fill all possible remote addresses */
+	return fill_remote_addresses_fullmesh(msk, local, addrs);
+}
+
 static struct mptcp_pm_addr_entry *
 __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 {

-- 
2.51.0

