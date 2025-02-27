Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593715B102
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740638662; cv=none; b=f0iVIYPp2oJ/r7hJykr1+Us3MBWPWzarketqGmMkuPRmM/yX9DNdQiyCJJ9gcm5//HGVvRzPTFiumsuVnl+jyXALP8li5DY+ZhusMydhX3Vz9b6/HsWrzj5hwVu/muGxe+yf3a4Ej5URI7TQcNKJiEJ8ZFQgAt9AkTjUV8TQ9yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740638662; c=relaxed/simple;
	bh=+GxoLYkjnhoqNLbe10capEc4MTSdMJndiVl1v/9Oiz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKpburjHx1f4kRpmTsxS2bgqFkVVrnRlHj8QPTR/oI1GiBpQ7tmdiNo/vk4h0WsA5in3X2b73zAmzvAlaw6vdvtkNofD9AJaGENmitcoXhrE8v6Jn7LGAY9vVwm2b5ag2bT1M4btZayDSGz8ogsZRBun6UKCXGKVcWT7TlLdWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaoikGta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaoikGta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C4CC4CEDD;
	Thu, 27 Feb 2025 06:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740638662;
	bh=+GxoLYkjnhoqNLbe10capEc4MTSdMJndiVl1v/9Oiz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XaoikGtatCkQSTKAWuUdFZ7L05LzqfRCkbdDfJQtFhix82ZxsmPzhYIjSKA6aDgKH
	 EU5zYuPw5MEG/wxsGEYnDSxZWfCSvfdfByTzW8pGmVo2bOAeFGvmhGHFLmkUqKoxIm
	 h7jHHR8rRgrj2grKCSZWy2yxqYVa5bC3H+W4OtS3tuGUK3GbpRy7uiEI7xRsX3c4uV
	 +aUHo+1Sy9b449snQpDz/O7JiXzmxC8svggnCaKcbAAoYW9DzFoBMpmTYcUVNgit1s
	 EWNV1qo7D3+Vwist2r8G5dkhWwVXCyju1XsgfabmXMZ5BGviuXNU5wYOBajHwOfHHZ
	 w4ARYqWw1n/Rg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 4/6] mptcp: pm: in-kernel: drop is_userspace in remove_id_zero
Date: Thu, 27 Feb 2025 14:43:55 +0800
Message-ID: <d9e2fc66a1207673f07510b7b34f08edd9828220.1740638334.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740638334.git.tanggeliang@kylinos.cn>
References: <cover.1740638334.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

There're duplicate operations in mptcp_nl_remove_subflow_and_signal_addr()
and mptcp_nl_remove_id_zero_address(), both of which traverse all mptcp
sockets in the net namespace. This patch drops the traversal operation in
the latter and reuse the traversal loop of the former to do the removal of
id zero address.

An additional benefit is that the check for mptcp_pm_is_userspace() in
mptcp_nl_remove_id_zero_address() is dropped, which reduces the path
manager's reliance on mptcp_pm_is_userspace() and mptcp_pm_is_kernel()
helpers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 77 ++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0d98c2df72f7..e546388070b4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1514,6 +1514,28 @@ static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)
 		msk->pm.local_addr_used--;
 }
 
+static void mptcp_nl_remove_id_zero_address(struct mptcp_sock *msk,
+					    const struct mptcp_addr_info *addr)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_addr_info msk_local;
+
+	if (list_empty(&msk->conn_list))
+		return;
+
+	mptcp_local_address((struct sock_common *)msk, &msk_local);
+	if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
+		return;
+
+	list.ids[list.nr++] = 0;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, &list);
+	mptcp_pm_nl_rm_subflow_received(msk, &list);
+	__mark_subflow_endp_available(msk, 0);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   const struct mptcp_pm_addr_entry *entry)
 {
@@ -1532,6 +1554,11 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 			goto next;
 
 		lock_sock(sk);
+		if (entry->addr.id == 0) {
+			mptcp_nl_remove_id_zero_address(msk, &entry->addr);
+			goto out;
+		}
+
 		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
@@ -1551,42 +1578,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 		if (msk->mpc_endpoint_id == entry->addr.id)
 			msk->mpc_endpoint_id = 0;
-		release_sock(sk);
-
-next:
-		sock_put(sk);
-		cond_resched();
-	}
-
-	return 0;
-}
-
-static int mptcp_nl_remove_id_zero_address(struct net *net,
-					   struct mptcp_addr_info *addr)
-{
-	struct mptcp_rm_list list = { .nr = 0 };
-	long s_slot = 0, s_num = 0;
-	struct mptcp_sock *msk;
-
-	list.ids[list.nr++] = 0;
-
-	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
-		struct sock *sk = (struct sock *)msk;
-		struct mptcp_addr_info msk_local;
-
-		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
-			goto next;
-
-		mptcp_local_address((struct sock_common *)msk, &msk_local);
-		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
-			goto next;
-
-		lock_sock(sk);
-		spin_lock_bh(&msk->pm.lock);
-		mptcp_pm_remove_addr(msk, &list);
-		mptcp_pm_nl_rm_subflow_received(msk, &list);
-		__mark_subflow_endp_available(msk, 0);
-		spin_unlock_bh(&msk->pm.lock);
+out:
 		release_sock(sk);
 
 next:
@@ -1618,8 +1610,10 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	 * id addresses. Additionally zero id is not accounted for in id_bitmap.
 	 * Let's use an 'mptcp_rm_list' instead of the common remove code.
 	 */
-	if (addr.addr.id == 0)
-		return mptcp_nl_remove_id_zero_address(sock_net(skb->sk), &addr.addr);
+	if (addr.addr.id == 0) {
+		entry = &addr;
+		goto del_addr;
+	}
 
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, addr.addr.id);
@@ -1642,9 +1636,12 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	__clear_bit(entry->addr.id, pernet->id_bitmap);
 	spin_unlock_bh(&pernet->lock);
 
+del_addr:
 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), entry);
-	synchronize_rcu();
-	__mptcp_pm_release_addr_entry(entry);
+	if (entry->addr.id) {
+		synchronize_rcu();
+		__mptcp_pm_release_addr_entry(entry);
+	}
 
 	return ret;
 }
-- 
2.43.0

