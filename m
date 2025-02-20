Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1C1F1501
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047826; cv=none; b=Zb35hWxpIWJE6zqQyLR8xhSX9SUNCOTNXDRsYUSPobv/YmMcIwHuTY/vWeokmAyovoPHmw+455opreyXDNuB3wdZnlPYBHlYK2F1qpeezspO59v4XosAehm9OrXOewIdEBP+nypj9v4S16IWygSf9IKen7dXW11vydlAb7QULYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047826; c=relaxed/simple;
	bh=/ZTgXVof5MLJRRJLAzJox/qd/0bvC+gN807X/Zq9VVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lfr0QNtvX0cSz0ej+EQqaldlpabHf8xGDndpY5Q2i6tLiBS2QaVFj1g/gaY5rTy3XXBt4lOhkdJt9ZuEVQ7zd2NKutQkMmiShxqjloyx0XbG4gF8gErkxuUFUsS32Uxyvn7K3PKBS0Sq31BkBMPC6XAnhdJg/nMaZ3VEZUMaHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCwB4p3M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCwB4p3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC27C4CEDD;
	Thu, 20 Feb 2025 10:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740047826;
	bh=/ZTgXVof5MLJRRJLAzJox/qd/0bvC+gN807X/Zq9VVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCwB4p3MBWP8Zgi1BqTZPoXxghVfrn/JWK7THazMtXwEehNeDyO15l9jFmYSorMVV
	 1ZCesr2Ct+bBqgViNTY6f6/T0n9ERwTa8qt8RTd3tkJhohjn3FKunYalZNEUtFSTeo
	 Vtj+jatRkh/0lvODpNU5BWaOMypKVrMeCmDMoDvgMp1wgDJRIPGAWtPomDLW4krFRO
	 Sf8OgMQHEPiFXGIf8BZRIjX8bN0G8Vx/mRR0Ewrse1Q5v2pnIvDtjkxxMHfKwNv80q
	 pP0+lmELVc1oQw1jHoaz/tv0kJko10JyDu9F0hAoDiIZMF7noPUUKVT3CaYjLtj9jQ
	 C3DFDqklJnVmw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 1/9] mptcp: pm: in-kernel: add address_removed/subflow_closed
Date: Thu, 20 Feb 2025 18:36:50 +0800
Message-ID: <bb44b29f8dd30c79e29693279941b0ca8e0e03e6.1740047738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740047738.git.tanggeliang@kylinos.cn>
References: <cover.1740047738.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the code in the loop of traversing all msks in
mptcp_nl_remove_subflow_and_signal_addr() as two new helpers,
mptcp_pm_nl_address_removed() and mptcp_pm_nl_subflow_closed(),
used for signaling a RM_ADDR and closing a subflow respectively.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 60 +++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3859642792db..3914b80ed225 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1506,11 +1506,47 @@ static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)
 		msk->pm.local_addr_used--;
 }
 
+static int mptcp_pm_nl_address_removed(struct mptcp_sock *msk,
+				       const struct mptcp_pm_addr_entry *local)
+{
+	bool remove_subflow;
+
+	remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, &local->addr);
+	mptcp_pm_remove_anno_addr(msk, &local->addr, remove_subflow &&
+				  !(local->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
+	return 0;
+}
+
+static int mptcp_pm_nl_subflow_closed(struct mptcp_sock *msk,
+				      const struct mptcp_pm_addr_entry *local)
+{
+	struct mptcp_rm_list list = { .nr = 1 };
+	bool remove_subflow;
+
+	list.ids[0] = mptcp_endp_get_local_id(msk, &local->addr);
+	remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, &local->addr);
+	if (remove_subflow) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_nl_rm_subflow_received(msk, &list);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+
+	if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+		spin_lock_bh(&msk->pm.lock);
+		__mark_subflow_endp_available(msk, list.ids[0]);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+
+	if (msk->mpc_endpoint_id == local->addr.id)
+		msk->mpc_endpoint_id = 0;
+
+	return 0;
+}
+
 static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   const struct mptcp_pm_addr_entry *entry)
 {
 	const struct mptcp_addr_info *addr = &entry->addr;
-	struct mptcp_rm_list list = { .nr = 1 };
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
@@ -1518,31 +1554,13 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
-		bool remove_subflow;
 
 		if (mptcp_pm_is_userspace(msk))
 			goto next;
 
 		lock_sock(sk);
-		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
-		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
-					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
-
-		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
-		if (remove_subflow) {
-			spin_lock_bh(&msk->pm.lock);
-			mptcp_pm_nl_rm_subflow_received(msk, &list);
-			spin_unlock_bh(&msk->pm.lock);
-		}
-
-		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-			spin_lock_bh(&msk->pm.lock);
-			__mark_subflow_endp_available(msk, list.ids[0]);
-			spin_unlock_bh(&msk->pm.lock);
-		}
-
-		if (msk->mpc_endpoint_id == entry->addr.id)
-			msk->mpc_endpoint_id = 0;
+		mptcp_pm_nl_address_removed(msk, entry);
+		mptcp_pm_nl_subflow_closed(msk, entry);
 		release_sock(sk);
 
 next:
-- 
2.43.0

