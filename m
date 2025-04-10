Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531EE1EEA3E
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 04:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744258472; cv=none; b=U8mZxuCdT4SGf8vJSGN9SLdEJUozJZxZtOvB2FjAWzZJiVCgNQclhq7xyWXHtwvROuHqTSr2gP5LkraSKWUQ6h2A43gfIizowLUxrmynkl5aftoWTQNOhJSXEih9aB06vSPvC88VNLNB390hSSq1rPpajt6wI1Qjvhsqqz5YDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744258472; c=relaxed/simple;
	bh=lbrsVYdaxXiw+hcLGPLkD00f01yr9M9l9MUS2g1WULA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iO1e6OXI/SNjeqQvyNhryGlbBu7uvCxTjp2Raff7/vjLbI8o7Wo9eFsn3FDFqW52KKMkoe0/NDFEbJjhj+z0DP4uHqsmS80aKL4mTtr19ZX3n7dLzup7tNl0B/bxFX5s5mKGS5VbFV/djXwBsp3N9If7sxyEPdpOR7hdm7gffjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DX7MPJxf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DX7MPJxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CDAC4CEDD;
	Thu, 10 Apr 2025 04:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744258470;
	bh=lbrsVYdaxXiw+hcLGPLkD00f01yr9M9l9MUS2g1WULA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DX7MPJxfEi5A1NM+U2AJrNFFq21LVdw4BDQNdZAik+uCV0hbkpy1qp6SK1WI34DTi
	 cfqGlbkYvB7AQfwqbO6+mFyObe0DO0pTSdm4ebxWUX1BnMD3AiYcR274lJl13KgWyg
	 CKYv7g8Ufb+HuhsSZrx01kPajBuAPns8oM3W18Yzrq0l+QOZc6ucQ0R+NwGp8CvsmE
	 /7nbhLg3hSCtTiUKE7s9XZ8t0gyX1/K9E9rLWUaFPtIHBNqqLEGlUpisES2maTuSCM
	 8GMnFxifeVmMRS3RaSmV5Bzq1GguLsGeo1ck1NRItrpegS06ZA8w87zg+LfKFJshhI
	 ssOj+U/ucnhrw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/2] mptcp: pm: userspace: drop delete_local_addr helper
Date: Thu, 10 Apr 2025 00:14:20 -0400
Message-ID: <2b140a3cefd7d5766a79e8c55b73cf2d38c710d0.1744257362.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744257362.git.tanggeliang@kylinos.cn>
References: <cover.1744257362.git.tanggeliang@kylinos.cn>
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
index 7fc19b844384..3824b4165421 100644
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
@@ -408,14 +385,13 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -534,9 +510,6 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
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

