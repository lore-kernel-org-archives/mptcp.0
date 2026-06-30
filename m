Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B08472
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799327; cv=none; b=E9kBUXf0QKj1uOTxw+KF6ykVXobvzZwjYlR8twYkLUrP7jLDXcAOQyDswrkeIfK5Va0An0JbWWASwYIwAiRPztFfvmR2nCEqJfka3/Az1wwLITrqL3RdqjS4LzBzIGvWAwGcsXJxr9fhdDdvd9RXJeIKrmWLSVrf/BcMjXdHoD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799327; c=relaxed/simple;
	bh=yQuHyokSwl0fxBZIl8ce8817uQIcPJddH4PKpL51egw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlJi+etxJ443yRh9xOYEn9IKTHUk71PeKbrSsL7HquNfbtxmT9keKsTSmmRcjdckalS0l4BqQqTRssylEBQqc8zq1fGVTLYnhIIK99qwjAqbgPPNRHadj86X5gpUAB5k/E97WbRxTL1BS6GtXUgGXvyfYM3tsMUDKTStqmN956A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO/811oJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO/811oJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CDD1F000E9;
	Tue, 30 Jun 2026 06:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782799326;
	bh=1oe+mZTunc75rQ00nUR2xs8g61/wUOf1uZDxjDF44JA=;
	h=From:To:Cc:Subject:Date;
	b=nO/811oJ33/JzR3jqyaeSCmNXjRlXD+OSQk3qHMwGsYV3D5TQ8wGpUoudGLypDA2C
	 BuCcli87N3kmoYlfWHuWMO6g+zFqQSkZsRSKqrTIzdqwsweWh0GOz6hiAVVlgCWuQJ
	 Tmob17gRW+/AWNTGIJuOcPadI/sfZ/eHzOFKvXJTSQXgzxhdZb+Eui6Ah26VSxuwGe
	 CkEh4N/LUAhTgMlxG7ZfPt7g6lZQJqmHY3fJXy6OMdYUYAz8fHzfA7nC2NyfQiajkw
	 SoAvrTRDquRqy58g96jGF0/9tDViSCEIEVkS/CivvtS4pNaHqU2MKbYf+CUlbyp49M
	 EPBxyiMgDY9hQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v2] mptcp: pm: userspace: fix memory quota with RCU delayed free
Date: Tue, 30 Jun 2026 14:01:59 +0800
Message-ID: <df199842d10185a73084c79aee9cdc91888adb6a.1782799160.git.tanggeliang@kylinos.cn>
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

Fixes: 13b4ece33cf9 ("mptcp: pm: Defer freeing of MPTCP userspace path manager entries")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - call mptcp_userspace_pm_free_entry in free_local_addr_list and
   delete_local_addr.

v1:
 - Link: https://patchwork.kernel.org/project/mptcp/patch/9b443bafa57f40a51eb6a43f088ff37d71b39973.1782528088.git.tanggeliang@kylinos.cn/

This patch addresses the pre-existing issue Sashiko mentioned in
https://sashiko.dev/#/patchset/cover.1782457962.git.tanggeliang@kylinos.cn.
---
 net/mptcp/pm_userspace.c | 24 +++++++++++++++---------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ad6ba658e5a5..60b6c06b91aa 100644
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
 
@@ -73,6 +82,8 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 			ret = -ENOMEM;
 			goto append_err;
 		}
+		sock_hold(sk);
+		e->sk = sk;
 
 		if (!e->addr.id && needs_id)
 			e->addr.id = find_next_zero_bit(id_bitmap,
@@ -98,7 +109,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
 
 	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
@@ -109,7 +119,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	 * be used multiple times (e.g. fullmesh mode).
 	 */
 	list_del_rcu(&entry->list);
-	sock_kfree_s(sk, entry, sizeof(*entry));
+	call_rcu(&entry->rcu, mptcp_userspace_pm_free_entry);
 	msk->pm.local_addr_used--;
 	return 0;
 }
@@ -337,11 +347,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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

