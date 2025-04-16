Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D7518D63E
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744787990; cv=none; b=cpHE7C9iSC2jab8W4Qsy8bCelvGwJD+vXhdvEBtlbPkZM5yhBsZ2s739cPrrqWOAMxB9FhtOOetk+jIc/hTcQuBwn9NGNx3ATPhVzm95y8IMeFduSv8XSJiz3ufHdDQc8cWvGznYmRL/1h7acHrd0h9iPa3S7bHBxKlQlgf2Xfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744787990; c=relaxed/simple;
	bh=sAj1TrG6wvJtSfyRwkWXVcpdbFOaKTuN9JiBJqAnqLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqORfIzULTq8Zxn6VtTUFTOcKEcHdOV1RqLjp2dGrIdJCylAZXJE/By2h9YeJ9NHhFTIjCMz3w7ebzSqDhjBqFDxo2V3YkvYI4L76mI8Yn6JL45BmN2lM6R4jaNuqZ+hmnTM8BgtfD6BSaLScO5nCxB9zqTCgkuHJj6yN5XZvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2XgDZ5/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2XgDZ5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56BFC4CEE9;
	Wed, 16 Apr 2025 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744787990;
	bh=sAj1TrG6wvJtSfyRwkWXVcpdbFOaKTuN9JiBJqAnqLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2XgDZ5/MkYuxXImiMvA+5E7pxBFe1SaWtTSldphnx+Py/t1sPLGUaFG+YgVJFgxp
	 gt3XTHlAjwXQ6wlSssTWMvzdu+jV1GEgFECUuvVCR45JlwbcXWn+D/CLWA5p8uogMw
	 NRpd6yRvxg9C/8RDHP9IRMz5lUkAHEtgE8On4rH8wz9FFNAGQkpDn608B4Z3anyY0e
	 PidrJAxmKKtHdnygiaMdzXdZDeOif6QIbIwt+yRraLGT2Tu+c2lxTUrCA1ny96SmKH
	 Kt8PAdgz/2qbTFsjLsJaTJeehKaW+jNhCVr48anPKugAe06VNIOFKFNMzrpkdm6dCY
	 YgmQFxr0QEf6w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/3] mptcp: pm: userspace: drop delete_local_addr helper
Date: Wed, 16 Apr 2025 15:17:07 +0800
Message-ID: <2440a7ebe28a5034326d04b9c9cd8e4fa4edcd28.1744787273.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744787273.git.tanggeliang@kylinos.cn>
References: <cover.1744787273.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address entries should not be removed from local_addr_list when a subflow
is deleted by the userspace PM, should only be removed when sending a
REMOVE_ADDR.

So mptcp_userspace_pm_delete_local_addr() helper shouldn't be called in
mptcp_pm_nl_subflow_create_doit() and mptcp_pm_nl_subflow_destroy_doit().

Since this helper is open-coding in mptcp_pm_nl_remove_doit(), it can be
dropped now.

Address entries are removed from local_addr_list when sending a REMOVE_ADDR
by the userspace PM, the local_addr_used counter of PM should also be
decremented accordingly.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1911fe1799fa..85c6c65edbed 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -90,30 +90,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
-/* If the subflow is closed from the other peer (not via a
- * subflow destroy command then), we want to keep the entry
- * not to assign the same ID to another address and to be
- * able to send RM_ADDR after the removal of the subflow.
- */
-static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
-						struct mptcp_pm_addr_entry *addr)
-{
-	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *entry;
-
-	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
-	if (!entry)
-		return -EINVAL;
-
-	/* TODO: a refcount is needed because the entry can
-	 * be used multiple times (e.g. fullmesh mode).
-	 */
-	list_del_rcu(&entry->list);
-	sock_kfree_s(sk, entry, sizeof(*entry));
-	msk->pm.local_addr_used--;
-	return 0;
-}
-
 static struct mptcp_pm_addr_entry *
 mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 {
@@ -331,6 +307,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	list_del_rcu(&match->list);
+	msk->pm.local_addr_used--;
 	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_remove_addr_entry(msk, match);
@@ -412,14 +389,13 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
-	if (err)
+	if (err) {
 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
+		goto create_err;
+	}
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
-	else
-		msk->pm.subflows++;
+	msk->pm.subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
@@ -538,9 +514,6 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto release_sock;
 	}
 
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
-	spin_unlock_bh(&msk->pm.lock);
 	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-- 
2.43.0

