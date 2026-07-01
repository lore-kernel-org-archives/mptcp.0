Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F089312807
	for <mptcp@lists.linux.dev>; Wed,  1 Jul 2026 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886303; cv=none; b=qaVqcC4xShWRpx8p04PhvWYUBvw3cy1Y4cUgz1z1n5t8GczpbIeQtxvQtD79AizDF6RDlcb3+rhSrNLx6hYamJ+EDAK1p7eii/6GtIRsQIgXbOzLdWFglTBFADIDd0Ntvb3sujvjii7SOQPZ+tSsBPjA5re1tmQAsIwORV7i3B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886303; c=relaxed/simple;
	bh=DJjsOZ0KWefuPBop08pDgz1l3DxsTlhmRWuG2PwI4Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGqA0gtPlXNvHzrOycAMtydNE0JsPAsdWNPyicD2H/X3Uj5uinHV8b1qhY9j/7sVButJtfw4j+SezygpLdHssUbOAJiBpUApwK0DY48qOhHEZciOdBXaHbni1h9urCbSZpmNxXgbquPYQby+t8VsyWKefaxOAis/vwb3AZCM7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekihdcnu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekihdcnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A7E1F00A3A;
	Wed,  1 Jul 2026 06:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782886301;
	bh=CysB/YES5aPBDzR4z/r8nB2ZQ57IoEu/jdQGfUbkiKw=;
	h=From:To:Cc:Subject:Date;
	b=Ekihdcnul/EayaRNNYDrWKf4s4RSiRD/Jbp2wbgOQI3N21L63FG20q5VTTSbKxqaZ
	 B4N1pNaG+SDKetEglFcxnu28ygDSMz4/FxVq+clk05MUhFcpB667pzIoM6u1ViBeUz
	 EE005SS1xg2EjXyl1cbiXAy6Q0IfFJ8ptBfsxL0GInHl2vrvhs74zHIrRVMRLON2HC
	 yyz/oJRwVcPjjwsjdfmFcgAs6XQP/vXzhxnM69caxXUlpqMSQ6zzlIfdn9OAEZJSWW
	 zinlbRXPpzR5s/SlfLHYInXQLBm40/dDiBAa18idNe1CjcnW1mRaS4q6cvZzamHVcq
	 Od3bMjfXnQcjw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v3] mptcp: pm: userspace: unify entry free path via RCU callback
Date: Wed,  1 Jul 2026 14:11:32 +0800
Message-ID: <de8555fcb235d0e93c02c20bf47231846d30841d.1782886142.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_pm_nl_remove_doit(), sk_omem_alloc is decremented immediately
but the memory is freed later via kfree_rcu(). This allows a CAP_NET_ADMIN
user to bypass the socket memory quota and exhaust kernel memory by
accumulating RCU callbacks.

Fix by using call_rcu() with a custom callback that uses sock_kfree_s()
to free the entry and decrement sk_omem_alloc atomically. To ensure the
socket remains valid until the callback runs, take a reference with
sock_hold() when storing the socket pointer in the entry, and release it
with sock_put() in the callback.

Convert the synchronous freeing paths in free_local_addr_list() and
delete_local_addr() to use the same RCU callback, ensuring the socket
reference is properly released.

Additionally, mptcp_userspace_pm_append_new_local_addr() now checks
SOCK_DEAD under the spinlock before allocating. A SYN+JOIN handler
holding an msk reference from mptcp_token_get_sock() could otherwise
race with __mptcp_destroy_sock() - sock_orphan() sets SOCK_DEAD and
then mptcp_userspace_pm_release() clears the list, so a new entry
allocated after that point would never be freed and its sock_hold()
would leak the msk permanently.

Fixes: 13b4ece33cf9 ("mptcp: pm: Defer freeing of MPTCP userspace path manager entries")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v3:
 - checking sock_flag(sk, SOCK_DEAD)) before holding the reference.
 - update the subject.

v2:
 - call mptcp_userspace_pm_free_entry in free_local_addr_list and
   delete_local_addr.
 - Link: https://patchwork.kernel.org/project/mptcp/patch/df199842d10185a73084c79aee9cdc91888adb6a.1782799160.git.tanggeliang@kylinos.cn/

v1:
 - Link: https://patchwork.kernel.org/project/mptcp/patch/9b443bafa57f40a51eb6a43f088ff37d71b39973.1782528088.git.tanggeliang@kylinos.cn/

This patch addresses the pre-existing issue Sashiko mentioned in
https://sashiko.dev/#/patchset/cover.1782457962.git.tanggeliang@kylinos.cn.
---
 net/mptcp/pm_userspace.c | 33 ++++++++++++++++++++++++---------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ad6ba658e5a5..c024c5cd5da1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -12,10 +12,19 @@
 	list_for_each_entry(__entry,						\
 			    &((__msk)->pm.userspace_pm_local_addr_list), list)
 
+static void mptcp_userspace_pm_free_entry(struct rcu_head *head)
+{
+	struct mptcp_pm_addr_entry *entry =
+		container_of(head, struct mptcp_pm_addr_entry, rcu);
+	struct sock *sk = entry->sk;
+
+	sock_kfree_s(sk, entry, sizeof(*entry));
+	sock_put(sk);
+}
+
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
-	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
 	spin_lock_bh(&msk->pm.lock);
@@ -23,7 +32,7 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		sock_kfree_s(sk, entry, sizeof(*entry));
+		call_rcu(&entry->rcu, mptcp_userspace_pm_free_entry);
 	}
 }
 
@@ -54,6 +63,15 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
+	/* sock_orphan() has been called and mptcp_userspace_pm_release()
+	 * has cleared userspace_pm_local_addr_list. Any entry we allocate
+	 * here would never be freed via the list, leaking the sock_hold().
+	 */
+	if (sock_flag(sk, SOCK_DEAD)) {
+		ret = -EINVAL;
+		goto append_err;
+	}
+
 	mptcp_for_each_userspace_pm_addr(msk, e) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0 && needs_id)
@@ -73,6 +91,8 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 			ret = -ENOMEM;
 			goto append_err;
 		}
+		sock_hold(sk);
+		e->sk = sk;
 
 		if (!e->addr.id && needs_id)
 			e->addr.id = find_next_zero_bit(id_bitmap,
@@ -98,7 +118,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
 
 	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
@@ -109,7 +128,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	 * be used multiple times (e.g. fullmesh mode).
 	 */
 	list_del_rcu(&entry->list);
-	sock_kfree_s(sk, entry, sizeof(*entry));
+	call_rcu(&entry->rcu, mptcp_userspace_pm_free_entry);
 	msk->pm.local_addr_used--;
 	return 0;
 }
@@ -337,11 +356,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	release_sock(sk);
 
-	kfree_rcu_mightsleep(match);
-	/* Adjust sk_omem_alloc like sock_kfree_s() does, to match
-	 * with allocation of this memory by sock_kmemdup()
-	 */
-	atomic_sub(sizeof(*match), &sk->sk_omem_alloc);
+	call_rcu(&match->rcu, mptcp_userspace_pm_free_entry);
 
 	err = 0;
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..250736eae0be 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -257,6 +257,8 @@ struct mptcp_pm_addr_entry {
 	u32			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	struct sock		*sk;
+	struct rcu_head		rcu;
 };
 
 struct mptcp_data_frag {
-- 
2.53.0

