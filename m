Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5E37189C
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217947; cv=pass; b=FtA5sZb8ZKierL6CCvTznT0PP3NdHrnMUolz6T1j2eozZ5ncmQJTkB2fu44n2sWIuIP8m6wOGYIDho7Xk/VdAe0fpTnk+v/yS8aTS5iQYxP0RD82F+J6n0jnDYgEI6rDP6Vydd/f2rIIZ/TdXnG022XAQso17Rm3ub8Hsl3y3sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217947; c=relaxed/simple;
	bh=px00PjnmHQ302ytqURaLSHfsiyFPBwXhsZRFB+oQBo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EVa7T/dlArIhb4/S04HIt1KbzEoi/h2+0POdHsT6TvRyShHcRjPLuAqVNvcdMwPtGwOYqVPcG9ECF2gL8QAJjEROVTN5GuBWp3srJsQ8LzueBlrGrW8NUaiz51CYrB715v4RQMrLrd5EHnTnz0j8hutjNIm+w+N782ZdVhcxtwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=pGMzDpCP reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="pGMzDpCP"
ARC-Seal: i=1; a=rsa-sha256; t=1779217939; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JlrDf+3o4FHfgAQmOkwO5t0k/X5+G8k2KXT0eQIGTPvRT0rOCW6RL2CsapyR2qQt8TndC1rWK75KdO6Kg84MKv/JZr4jJOh9fg/j07lX8wniGEqdOpzaM/I3tozTJvCoxn23nNUc9saHNKYkK+1Cq+mFkb+/od+m18LgNyldr8w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779217939; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=egFiJBzq1rsUljbagMXzY2X0xZsDM6E+zMWNQ+h+lyQ=; 
	b=Yd9W+waftLjsVSGonCaUAJxcwQuSd1IC3uep+wVnUwWifPtCh6SA5QB0jPl/R8ViarRACZJOyg75BlmELU+VkRE9ZphB1pPFYrbgnAWifBGhnC8FVNJW1OZBShTJAwglvsEPY8txlLBk3OsiobQm84nf+O/7bzk1ot80vzcxwRA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779217939;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=egFiJBzq1rsUljbagMXzY2X0xZsDM6E+zMWNQ+h+lyQ=;
	b=pGMzDpCPDLYmw4OPwjxF5OnJyDxnDkX32OMmB7EobxO6Bp/PxaBcaWLtzQOp7eqv
	feE+RxyNkZuXK04AkhIMfMFGyEhDlPndg5gdZxZv+M/VJH8qcRt0p0BoiXCZiQ6yio+
	FzNbQSudwQdfYGH67bOHHd40LiucHphi9LQN8prM=
Received: by mx.zohomail.com with SMTPS id 1779217936524692.5377344477154;
	Tue, 19 May 2026 12:12:16 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	pabeni@redhat.com
Cc: martineau@kernel.org,
	geliang@kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH net] mptcp: pm: fix memory leak from alloc-during-teardown race
Date: Wed, 20 May 2026 00:42:07 +0530
Message-Id: <20260519191207.1110003-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

mptcp_pm_destroy() drains msk->pm.anno_list via list_splice_init()
under msk->pm.lock and then, for the userspace PM, drains
msk->pm.userspace_pm_local_addr_list under the same lock. Between
the two splices, msk->pm.lock is released.

A concurrent userspace PM genl ANNOUNCE on the same msk holds a
sock reference via mptcp_token_get_sock() and, in
mptcp_pm_nl_announce_doit(), calls
mptcp_userspace_pm_append_new_local_addr() and
mptcp_pm_alloc_anno_list(). Both take msk->pm.lock briefly to
add to their respective lists. Because the genl handler holds a
sock reference, mptcp_pm_destroy() may run on the same msk via
mptcp_disconnect(), which invokes mptcp_destroy_common() without
dropping the sock refcount, before the handler completes.

If the lock acquisitions interleave such that mptcp_pm_destroy()'s
splice runs first, the subsequent alloc paths land on a list head
pointing to itself. Nothing else iterates that list for this msk,
and the added entry leaks. kmemleak reports both 192-byte
mptcp_pm_add_entry objects (from mptcp_pm_alloc_anno_list()) and
64-byte mptcp_pm_addr_entry objects (from
mptcp_userspace_pm_append_new_local_addr()) under sustained
concurrent ANNOUNCE + close load against the userspace PM.

Add a teardown flag set by mptcp_pm_destroy() before its
pm.lock-held splice and checked under pm.lock by the alloc paths.
Either the alloc takes pm.lock first, in which case its entry
will be on the list when destroy's splice runs and will be freed
normally; or destroy takes pm.lock first, in which case the
subsequent alloc observes the flag and refuses. Either ordering
is correct, and the race that orphans an entry is precluded. The
flag is cleared in mptcp_pm_data_init() so the state is correct
on slab reuse.

Found by an MPTCP protocol-flow harness extending BRF
(arXiv:2305.08782). Baseline ~0.3 kmemleak reports/minute on the
userspace PM reduces to zero across multi-hour runs with this
patch applied.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/pm.c           | 6 ++++++
 net/mptcp/pm_userspace.c | 4 ++++
 net/mptcp/protocol.h     | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3e770c7407e1f..5b5c5e0c38583 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -440,6 +440,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
+	if (READ_ONCE(msk->pm.destroying))
+		return false;
+
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
@@ -1109,6 +1112,8 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
+	WRITE_ONCE(msk->pm.destroying, true);
+
 	mptcp_pm_free_anno_list(msk);
 
 	if (mptcp_pm_is_userspace(msk))
@@ -1149,6 +1154,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	spin_lock_init(&msk->pm.lock);
 	INIT_LIST_HEAD(&msk->pm.anno_list);
 	INIT_LIST_HEAD(&msk->pm.userspace_pm_local_addr_list);
+	msk->pm.destroying = false;
 	mptcp_pm_data_reset(msk);
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8cbc1920afb49..bf53db7307302 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -54,6 +54,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
+	if (READ_ONCE(msk->pm.destroying)) {
+		ret = -EINVAL;
+		goto append_err;
+	}
 	mptcp_for_each_userspace_pm_addr(msk, e) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0 && needs_id)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e4f5aba24da7d..c7a068ea71324 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -222,6 +222,13 @@ struct mptcp_pm_data {
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
+	/* set by mptcp_pm_destroy() before its pm.lock-held splice;
+	 * checked under pm.lock by alloc paths to refuse adds that would
+	 * be orphaned by destroy's splice.  Cleared in mptcp_pm_data_init()
+	 * so the field is correct after slab reuse.
+	 */
+	bool		destroying;
+
 	struct_group(reset,
 
 	u8		addr_signal;
-- 
2.34.1

