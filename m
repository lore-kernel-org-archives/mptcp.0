Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C22449EA4
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984213; cv=none; b=o+IbSnGH9I8pZuYO+zsPJ+h6c3HwnfVE0Dy+BFp5Vul3JfYOqD7Li7gctiyn6/kxKll3aoPqdcS2QEinV+oGvCOX+c9gkVgl/Sdi1iIdKmPYDThGmyYMY3il79f/1j9a/gm+6O0mHTlf5cSR1sGPVeJ5WiR3ZXiWT81PlQuzESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984213; c=relaxed/simple;
	bh=dbDOxPBSfYcBxoruAKqKSkjFgGy3qiu248z/HSmsx0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+ndM48PjEZ6Mr1wKJWeFWNUmYWGPP192cRNq1N4iht5nx8BnGVrvA45F5eRgsHTn+hypqanKkXI+hzGD/lDE1r/2PAic+Orv5VF27NLqFZslbqQf5biihUQLoNE+wTfJHOoNZCRMTXNib3XDFf9CtoLgcd8dNeanJzXq5DAWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idq5JsO5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idq5JsO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208B71F000FF;
	Mon, 21 Sep 2026 09:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984211;
	bh=5sg76MMNACIgog8iyFgUZplBMcf8xvbsa8j41flGELY=;
	h=From:To:Cc:Subject:Date;
	b=idq5JsO5ibmlAU841y8nxNiC1vzKpKqtUiCBWI9JYLz52F2G6JsbKZDvKzq3Y5ckf
	 rChQ5aCGXFw1HRl4KYn+fmkncv8k/xo+JwDyJDi4QZ8eiu5Oiy2PMA9FmyJwQagzEK
	 HV47sfbJ1WJIbDsydzi5JDxwLO5uCJqFx1RW2MgIMC8+aW+TPkedXaQoryyE48tdOL
	 inB36aSR3f5Ul/xVWXqnguarrOe0VkLhPeEGjFkxYi3j2ow/EVGEQbeslPL2fD6jTE
	 RB9wVXLaW3BGnKgM4fNe/U2V7dZmoobK70T+XhkygopNgO3zbCH/auscl/c9iDZE9F
	 jsqr8admLMZFg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v4] mptcp: pm: userspace: fix entry free path via RCU callback
Date: Mon, 21 Sep 2026 17:49:47 +0800
Message-ID: <97963911be08f2b6f99835217a24d23a99f3ac1f.1789983879.git.tanggeliang@kylinos.cn>
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
but the entry memory is freed later via kfree_rcu_mightsleep(). A
CAP_NET_ADMIN user can bypass the socket memory quota and exhaust kernel
memory by accumulating pending RCU callbacks.

Fix by deferring both the memory free and the sk_omem_alloc adjustment to
an RCU callback via sock_kfree_s().

A new mptcp_userspace_pm_release_entry() helper takes a sock reference
with sock_hold() before scheduling the callback, and the callback releases
it with sock_put() after freeing.

Apply the same helper to mptcp_userspace_pm_delete_local_addr() which has
the same issue. The synchronous freeing in free_local_addr_list() is left
unchanged: it only runs during msk destruction where no concurrent readers
exist.

While at it, reuse the lsk field of mptcp_pm_addr_entry via an anonymous
union for the sock backpointer - lsk is only used by the kernel PM, sk by
the userspace PM, so they are mutually exclusive.

Fixes: 13b4ece33cf9 ("mptcp: pm: Defer freeing of MPTCP userspace path manager entries")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v4:
 - address Mat & Matt's review comments on v3, thanks!
 - move sock_hold() and entry->sk assignment from allocation time to a new
   mptcp_userspace_pm_release_entry() helper at free time
 - keep free_local_addr_list() synchronous, no RCU needed there as it only
   runs during msk destruction
 - drop the SOCK_DEAD check in append_new_local_addr(), the leak chain is
   broken by the above sock_hold() relocation
 - use an anonymous union for lsk/sk instead of adding a new field

v3:
 - checking sock_flag(sk, SOCK_DEAD)) before holding the reference.
 - update the subject.
 - Link: https://patchwork.kernel.org/project/mptcp/patch/de8555fcb235d0e93c02c20bf47231846d30841d.1782886142.git.tanggeliang@kylinos.cn/

v2:
 - call mptcp_userspace_pm_free_entry in free_local_addr_list and
   delete_local_addr.
 - Link: https://patchwork.kernel.org/project/mptcp/patch/df199842d10185a73084c79aee9cdc91888adb6a.1782799160.git.tanggeliang@kylinos.cn/

v1:
 - Link: https://patchwork.kernel.org/project/mptcp/patch/9b443bafa57f40a51eb6a43f088ff37d71b39973.1782528088.git.tanggeliang@kylinos.cn/

This patch addresses the pre-existing issue Sashiko mentioned in
https://sashiko.dev/#/patchset/cover.1782457962.git.tanggeliang@kylinos.cn.
---
 net/mptcp/pm_userspace.c | 26 ++++++++++++++++++++------
 net/mptcp/protocol.h     |  6 +++++-
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f723a134356f..09c500c59eed 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -12,6 +12,24 @@
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
+static void mptcp_userspace_pm_release_entry(struct mptcp_pm_addr_entry *entry,
+					     struct sock *sk)
+{
+	entry->sk = sk;
+	sock_hold(sk);
+	call_rcu(&entry->rcu, mptcp_userspace_pm_free_entry);
+}
+
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
@@ -123,7 +141,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	 * be used multiple times (e.g. fullmesh mode).
 	 */
 	list_del_rcu(&entry->list);
-	sock_kfree_s(sk, entry, sizeof(*entry));
+	mptcp_userspace_pm_release_entry(entry, sk);
 	msk->pm.local_addr_used--;
 	return 0;
 }
@@ -355,11 +373,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	release_sock(sk);
 
-	kfree_rcu_mightsleep(match);
-	/* Adjust sk_omem_alloc like sock_kfree_s() does, to match
-	 * with allocation of this memory by sock_kmemdup()
-	 */
-	atomic_sub(sizeof(*match), &sk->sk_omem_alloc);
+	mptcp_userspace_pm_release_entry(match, sk);
 
 	err = 0;
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4bf04f9ecbd9..0724b90a4904 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -273,7 +273,11 @@ struct mptcp_pm_addr_entry {
 	struct mptcp_addr_info	addr;
 	u32			flags;
 	int			ifindex;
-	struct socket		*lsk;
+	union {
+		struct socket	*lsk;	/* kernel PM: listener socket */
+		struct sock	*sk;	/* userspace PM: owning msk */
+	};
+	struct rcu_head		rcu;
 };
 
 struct mptcp_data_frag {
-- 
2.53.0

