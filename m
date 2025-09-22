Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791E2F5461
	for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579850; cv=none; b=mOpcee/cMRoQTTvwbVk0XnOWeA1SeZGheqVF2eT/0D7kvZObSjdXGxuJUnNfaNuZ+PfCzLOYMc369+OFsb5dEt/Kp7xSsIv0u70z05n7i+dhVD421pBvvDAoX1Tc5wwXfAoPVgT2/qC0LuRALig+1sWYMYCwqgwo1EeO8MQxBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579850; c=relaxed/simple;
	bh=+ML4j/WGZHFbj1g1bEuZXXpMdS58mzdBrsXq73Uvxbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDOmVxjudRRwF2nfRcC9mnIAAJbcqJ1Z0k1SJZlOAbY1ag5MmqBXZKqBGHm9sUR5+NcXRU86vytymEK0y7SAjPo/CJwEjxAaIbG7DXm68DW80AYQCv1n5IinDCwvsKdPMkSPxXaWW3POyU+IctHQdl+GzbvO2hyIivIGHWXNefs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmz34n3z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmz34n3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EA0C4CEF0;
	Mon, 22 Sep 2025 22:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758579849;
	bh=+ML4j/WGZHFbj1g1bEuZXXpMdS58mzdBrsXq73Uvxbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cmz34n3zgDVs5OJggE14HrIQ4/yd1C1r31BmZDomP+DlWV+u6iJ9Hh7cq7DJKiJlw
	 E4OOUwI27KtR9np2Gp+XxunBrJASiJ2fy1cM6PvzZQt49C/IgHwiCWEiPdDxpdm76e
	 9TamjMRV92VwBMfla1wfYPgzP36zN6z+S0gVqn6DKPEM5KjIF2ox+Im0zJPtePU1RV
	 xKKtf7wHZRzhpyuiIvNSI9g3L7msrTGGBfcZx/6pXjiD00eaIw6TkcDUKEVspIsrHA
	 ICwfAgKGHoGuiOxDMkhgJfeuaRpUQod2Rdxw5bFz5PxwKwy5NSzlReB5O8ujRm385J
	 ZvjLTDEtItCFg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Sep 2025 00:23:54 +0200
Subject: [PATCH mptcp-next 3/6] mptcp: pm: in-kernel: compare IDs instead
 of addresses
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-pm-kern-endp-add_addr-new-v1-3-60e3a8968f45@kernel.org>
References: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
In-Reply-To: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6688; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+ML4j/WGZHFbj1g1bEuZXXpMdS58mzdBrsXq73Uvxbc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIunmn0FP3txXc54rXcXN1FP+Rrj08P4dWZ7yHvGpyp7
 md8R+xxRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESEzRn+l2u9ePYjRGZfxYdV
 qi06+ZaejYVfv6Te0Z4k/79MhvtAA8M/80Wyqyb8OTr19JeXykfOMdjNfe36PpZZ1PKn19kJ1wx
 FeQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When receiving an ADD_ADDR right after the 3WHS, the connection will
switch to 'fully established'. It means the MPTCP worker will be called
to treat two events, in this order: ADD_ADDR_RECEIVED, PM_ESTABLISHED.

The MPTCP endpoints cannot have the ID 0, because it is reserved to the
address and port used by the initial subflow. To be able to deal with
this case in different places, msk->mpc_endpoint_id contains the
endpoint ID linked to the initial subflow. This variable was only set
when treating the first PM_ESTABLISHED event, after ADD_ADDR_RECEIVED.
That's why in fill_local_addresses_vec(), the endpoint addresses were
compared with the one of the initial subflow, instead of only comparing
the IDs.

Instead, msk->mpc_endpoint_id is now set when treating ADD_ADDR_RECEIVED
as well, if needed, then the IDs can be compared.

To be able to do so, the code doing that is now in a dedicated helper,
and called from the functions linked to the two actions.

While at it, mptcp_endp_get_local_id() has also been moved up, next to
this new helper, because they are linked, and to be able to use it in
fill_local_addresses_vec() in the next commit.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 81 +++++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index ae6ab3178c226fe3ec66d156bb0dc919075043e5..7be454196a41f625100a6e0d6cbf1ee360dff553 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -268,6 +268,44 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 	return NULL;
 }
 
+static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
+				  const struct mptcp_addr_info *addr)
+{
+	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
+}
+
+static void mptcp_set_mpc_endpoint_id(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_addr_info mpc_addr;
+	struct pm_nl_pernet *pernet;
+	bool backup = false;
+
+	/* do lazy endpoint usage accounting for the MPC subflows */
+	if (likely(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED)) ||
+	    !msk->first)
+		return;
+
+	subflow = mptcp_subflow_ctx(msk->first);
+	pernet = pm_nl_get_pernet_from_msk(msk);
+
+	mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
+	rcu_read_lock();
+	entry = __lookup_addr(pernet, &mpc_addr);
+	if (entry) {
+		__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
+		msk->mpc_endpoint_id = entry->addr.id;
+		backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	}
+	rcu_read_unlock();
+
+	if (backup)
+		mptcp_pm_send_ack(msk, subflow, true, backup);
+
+	msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
+}
+
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	u8 limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
@@ -278,28 +316,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	bool signal_and_subflow = false;
 	struct mptcp_pm_local local;
 
-	/* do lazy endpoint usage accounting for the MPC subflows */
-	if (unlikely(!(msk->pm.status & BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED))) && msk->first) {
-		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(msk->first);
-		struct mptcp_pm_addr_entry *entry;
-		struct mptcp_addr_info mpc_addr;
-		bool backup = false;
-
-		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
-		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr);
-		if (entry) {
-			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
-			msk->mpc_endpoint_id = entry->addr.id;
-			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
-		}
-		rcu_read_unlock();
-
-		if (backup)
-			mptcp_pm_send_ack(msk, subflow, true, backup);
-
-		msk->pm.status |= BIT(MPTCP_PM_MPC_ENDPOINT_ACCOUNTED);
-	}
+	mptcp_set_mpc_endpoint_id(msk);
 
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
 		 msk->pm.local_addr_used, endp_subflow_max,
@@ -396,12 +413,9 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info mpc_addr;
 	struct mptcp_pm_local *local;
 	int i = 0;
 
-	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
-
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
@@ -419,8 +433,7 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 
 		/* Special case for ID0: set the correct ID */
-		if (mptcp_addresses_equal(&local->addr, &mpc_addr,
-					  local->addr.port))
+		if (local->addr.id == msk->mpc_endpoint_id)
 			local->addr.id = 0;
 
 		msk->pm.extra_subflows++;
@@ -443,12 +456,9 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	u8 endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_addr_info mpc_addr;
 	struct mptcp_pm_local *local;
 	int i = 0;
 
-	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
-
 	while (msk->pm.local_addr_used < endp_subflow_max) {
 		local = &locals[i];
 
@@ -460,8 +470,7 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
 			continue;
 
-		if (mptcp_addresses_equal(&local->addr, &mpc_addr,
-					  local->addr.port))
+		if (local->addr.id == msk->mpc_endpoint_id)
 			continue;
 
 		msk->pm.local_addr_used++;
@@ -507,6 +516,8 @@ fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 	bool c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
 	int i;
 
+	mptcp_set_mpc_endpoint_id(msk);
+
 	/* If there is at least one MPTCP endpoint with a fullmesh flag */
 	i = fill_local_addresses_vec_fullmesh(msk, remote, locals, c_flag_case);
 	if (i)
@@ -927,12 +938,6 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static u8 mptcp_endp_get_local_id(struct mptcp_sock *msk,
-				  const struct mptcp_addr_info *addr)
-{
-	return msk->mpc_endpoint_id == addr->id ? 0 : addr->id;
-}
-
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)

-- 
2.51.0

