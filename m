Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D793644D1
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467211; cv=none; b=MrhrsMu4CJDw4j/3S5KaTBLOFIZcUIHCw5S41w+PvyNT2Wyq8BFvZH1Cg/uzbnGP+l+E+QRwLhVg5ltLBbLTidZz4lo4geyJSJEwgd1AKEIn5AAS8cPmvKwu5oJc8J5T70YQ4tAgfP6AOljSG6TA7ZPHRfzwm6GrYGil8U22bXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467211; c=relaxed/simple;
	bh=ppm4ec2WvVA4bz/8hRCnbNXZ2n6i4EcneNAlXKnmC9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvsI1KdACelYauFXmS8DjbxV+SzGkRjiIVG+ZeH/uOoejZror0qwDroUbvl//pUJgCTGXcm35pt9NdhIb9egXsx6KjRF66vsBDZl5qrkrMnddphXsuSI4fzPX5j0voXfdZrnsZhddQ9Bb+xrKABDgA/rctitrPkGSQRUjlKU0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tn8/KMxU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn8/KMxU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2477C19425;
	Fri, 17 Apr 2026 23:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467210;
	bh=ppm4ec2WvVA4bz/8hRCnbNXZ2n6i4EcneNAlXKnmC9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tn8/KMxU/PDspiRM4Cez0GjW6ukxpsVdCMDtnpyNkk3KOgW+GUfni0deGbxgTHa86
	 Gx41ZnygVjjgVwtxg7c171ATrBin4pnR1j/67qYIOJIQGGlUK8hdDfI5VW+h61Oi4T
	 CjCdhsyB+5ssM7rDbyK4i3F1KINshX3VaTft3ZrFS7SwTXEdOzUoM/mNlpsw0dLYa2
	 EOeb+j6d+EMyvMt+l8HosBzMOp5ik8UXMipqfKpWehk8rU9cTOJxNJ71sMRtkLmh47
	 PY2w91jVGsK1lZCq7QL7elQ8mF3h77spR2i78GX/Ak2M4L2SZ/iIegjbwXx5HESmeq
	 j2G10pfUuwKbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/3] mptcp: pm: userspace: drop delete_local_addr helper
Date: Sat, 18 Apr 2026 07:06:22 +0800
Message-ID: <e2c1bd781cdd4a7a0233305c0cc5cd12e36ec31c.1776466833.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776466833.git.tanggeliang@kylinos.cn>
References: <cover.1776466833.git.tanggeliang@kylinos.cn>
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
index d838e8ea65fd..b33c883aec98 100644
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
-		msk->pm.extra_subflows++;
+	msk->pm.extra_subflows++;
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
2.51.0

