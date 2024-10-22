Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF5D19258C
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588514; cv=none; b=jZxSRr/p6bZTiA8LXEek+MT8WW8ZCtGHh8Rb4qr68/8knrr1kpypi2aTHW+kUgXNrpEQAtszmo2NkIZ5wFHuGaZeDXR5D8jzjPdkItZLnXnNxNcS1RgQ3YtrnCJKIYY3mjhRI9iC8xsJup5dcm41GQV9SKVUBUbJLHP6KflVkKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588514; c=relaxed/simple;
	bh=jxnliQgObZ6J9UJUzgjw1cLCXUhe5qokADPfyxB0sWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANecNP45krvv7mZv1TCaxOecx2MOJXhqZn+/0RdxiT+FFYy1jpljowUqO68G6fKcS8uOP0yynNzCnie8MY3GID2fGgp8CRAaQoxNZ9jallzNjaABU7ffevsuL/WMExuIEKsVeJc15F5g/BHoF0SSC+v4FoAPxlXTt9aGvqM8MA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQsfLBR3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQsfLBR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23E2C4CEC3;
	Tue, 22 Oct 2024 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588514;
	bh=jxnliQgObZ6J9UJUzgjw1cLCXUhe5qokADPfyxB0sWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQsfLBR3mL32jpePOYf0AdvtT0sq/FgjBic//k2bcf1VD9L+/jvx6lULRUoa4q5jg
	 SrEJgBkgFKkQuE12XdfzDMlMtyaeCUxFnfmNcNgef+hcsT4l0wpJqRFt6yqTAbVKE4
	 /51XBYbI9UgzWUDv58iMIMtUoBpIcnq6SfNhXKYqKm+HSBcOh6xNqE82/ERj2HePSr
	 qSN54HggsHtheyN//ftS8iWDLU0tqK0l7HFFcbU6kC0v1VbV3HKSR7ovhWNi9SgeSy
	 tCJ7dET1k0thxIOt5Yz7SLokoaqkg6meGG0r9jnHvz/skzbqTQh5KCngo1SLZ6EX5h
	 zr1EpjTGR6zwg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 13/36] mptcp: add struct mptcp_id_bitmap
Date: Tue, 22 Oct 2024 17:14:21 +0800
Message-ID: <344964d66ab0250ae027ffd46a0e6782d572c33d.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A new struct mptcp_id_bitmap is defined to unify all bitmap type of address
IDs for both in-kernel PM and userspace PM.

This type can be used to easily refactor dump_addr() interface of the path
managers to accept an mptcp_id_bitmap type parameter. It also allows this
parameter of dump_addr() can be modified by BPF program when implementing
this interface of a BFP path manager.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  2 +-
 net/mptcp/pm_netlink.c   | 42 ++++++++++++++++++++--------------------
 net/mptcp/pm_userspace.c | 14 ++++++--------
 net/mptcp/protocol.h     |  6 +++++-
 4 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f5725c00eb70..b6e6859903ef 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -512,7 +512,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->addr_signal, 0);
 	WRITE_ONCE(pm->remote_deny_join_id0, false);
 	pm->status = 0;
-	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	bitmap_fill(msk->pm.id_avail_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 02e4dda0dc13..c030a79cd1dd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -37,7 +37,7 @@ struct pm_nl_pernet {
 	unsigned int		local_addr_max;
 	unsigned int		subflows_max;
 	unsigned int		next_id;
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct mptcp_id_bitmap	id_bitmap;
 };
 
 #define MPTCP_PM_ADDR_MAX	8
@@ -161,7 +161,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 
-		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap.map))
 			continue;
 
 		new_local->addr = entry->addr;
@@ -189,7 +189,7 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
 	 * can lead to additional addresses not being announced.
 	 */
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap.map))
 			continue;
 
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
@@ -243,7 +243,7 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
 	if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
-	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
+	    (find_next_and_bit(pernet->id_bitmap.map, msk->pm.id_avail_bitmap.map,
 			       MPTCP_PM_MAX_ADDR_ID + 1, 0) == MPTCP_PM_MAX_ADDR_ID + 1)) {
 		WRITE_ONCE(msk->pm.work_pending, false);
 		return false;
@@ -443,15 +443,15 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 		msk->pm.subflows++;
 		addrs[i++] = remote;
 	} else {
-		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+		struct mptcp_id_bitmap unavail_id;
 
 		/* Forbid creation of new subflows matching existing
 		 * ones, possibly already created by incoming ADD_ADDR
 		 */
-		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+		bitmap_zero(unavail_id.map, MPTCP_PM_MAX_ADDR_ID + 1);
 		mptcp_for_each_subflow(msk, subflow)
 			if (READ_ONCE(subflow->local_id) == local->id)
-				__set_bit(subflow->remote_id, unavail_id);
+				__set_bit(subflow->remote_id, unavail_id.map);
 
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
@@ -460,7 +460,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 			if (deny_id0 && !addrs[i].id)
 				continue;
 
-			if (test_bit(addrs[i].id, unavail_id))
+			if (test_bit(addrs[i].id, unavail_id.map))
 				continue;
 
 			if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
@@ -470,7 +470,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
 				/* forbid creating multiple address towards
 				 * this id
 				 */
-				__set_bit(addrs[i].id, unavail_id);
+				__set_bit(addrs[i].id, unavail_id.map);
 				msk->pm.subflows++;
 				i++;
 			}
@@ -558,7 +558,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		rcu_read_lock();
 		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
-			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
+			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap.map);
 			msk->mpc_endpoint_id = entry->addr.id;
 			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 		}
@@ -596,7 +596,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
 			return;
 
-		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap.map);
 		msk->pm.add_addr_signaled++;
 
 		/* Special case for ID0: set the correct ID */
@@ -625,7 +625,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
-		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap.map);
 
 		/* Special case for ID0: set the correct ID */
 		if (local.addr.id == msk->mpc_endpoint_id)
@@ -991,7 +991,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		ret = -ERANGE;
 		goto out;
 	}
-	if (test_bit(entry->addr.id, pernet->id_bitmap)) {
+	if (test_bit(entry->addr.id, pernet->id_bitmap.map)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1025,7 +1025,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 
 	if (!entry->addr.id && needs_id) {
 find_next:
-		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
+		entry->addr.id = find_next_zero_bit(pernet->id_bitmap.map,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
 						    pernet->next_id);
 		if (!entry->addr.id && pernet->next_id != 1) {
@@ -1037,7 +1037,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	if (!entry->addr.id && needs_id)
 		goto out;
 
-	__set_bit(entry->addr.id, pernet->id_bitmap);
+	__set_bit(entry->addr.id, pernet->id_bitmap.map);
 	if (entry->addr.id > pernet->next_id)
 		pernet->next_id = entry->addr.id;
 
@@ -1480,7 +1480,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
 		if (ret) {
-			__set_bit(addr->id, msk->pm.id_avail_bitmap);
+			__set_bit(addr->id, msk->pm.id_avail_bitmap.map);
 			msk->pm.add_addr_signaled--;
 		}
 		mptcp_pm_remove_addr(msk, &list);
@@ -1492,7 +1492,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)
 {
 	/* If it was marked as used, and not ID 0, decrement local_addr_used */
-	if (!__test_and_set_bit(id ? : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap) &&
+	if (!__test_and_set_bit(id ? : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap.map) &&
 	    id && !WARN_ON_ONCE(msk->pm.local_addr_used == 0))
 		msk->pm.local_addr_used--;
 }
@@ -1623,7 +1623,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 
 	pernet->addrs--;
 	list_del_rcu(&entry->list);
-	__clear_bit(entry->addr.id, pernet->id_bitmap);
+	__clear_bit(entry->addr.id, pernet->id_bitmap.map);
 	spin_unlock_bh(&pernet->lock);
 
 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), entry);
@@ -1687,7 +1687,7 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 	if (slist.nr)
 		mptcp_pm_nl_rm_subflow_received(msk, &slist);
 	/* Reset counters: maybe some subflows have been removed before */
-	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	bitmap_fill(msk->pm.id_avail_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
 	msk->pm.local_addr_used = 0;
 	spin_unlock_bh(&msk->pm.lock);
 }
@@ -1745,7 +1745,7 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	list_splice_init(&pernet->local_addr_list, &free_list);
 	__reset_counters(pernet);
 	pernet->next_id = 1;
-	bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	bitmap_zero(pernet->id_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
 	mptcp_nl_flush_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
@@ -1878,7 +1878,7 @@ static int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 
 	spin_lock_bh(&pernet->lock);
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
-		if (test_bit(i, pernet->id_bitmap)) {
+		if (test_bit(i, pernet->id_bitmap.map)) {
 			entry = __lookup_addr_by_id(pernet, i);
 			if (!entry)
 				break;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c10794154187..cb4f2a174d0d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -42,15 +42,15 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry,
 						    bool needs_id)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_id_bitmap id_bitmap;
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	bitmap_zero(id_bitmap.map, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_for_each_address(msk, e) {
@@ -64,7 +64,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
+		__set_bit(e->addr.id, id_bitmap.map);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -79,7 +79,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 		*e = *entry;
 		if (!e->addr.id && needs_id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
+			e->addr.id = find_next_zero_bit(id_bitmap.map,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
@@ -586,17 +586,15 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb)
 {
-	struct id_bitmap {
-		DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
-	} *bitmap;
 	const struct genl_info *info = genl_info_dump(cb);
 	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_id_bitmap *bitmap;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
 	void *hdr;
 
-	bitmap = (struct id_bitmap *)cb->ctx;
+	bitmap = (struct mptcp_id_bitmap *)cb->ctx;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8282a6355765..4358a9a21270 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -211,6 +211,10 @@ enum mptcp_addr_signal_status {
 /* max value of mptcp_addr_info.id */
 #define MPTCP_PM_MAX_ADDR_ID		U8_MAX
 
+struct mptcp_id_bitmap {
+	DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
+};
+
 struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
@@ -231,7 +235,7 @@ struct mptcp_pm_data {
 	u8		pm_type;
 	u8		subflows;
 	u8		status;
-	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct mptcp_id_bitmap id_avail_bitmap;
 	struct mptcp_rm_list rm_list_tx;
 	struct mptcp_rm_list rm_list_rx;
 };
-- 
2.45.2

