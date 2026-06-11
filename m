Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE461519B4
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 00:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138193; cv=pass; b=dU2slf96khZRRDgbdgDhwuE+Oq+Jc/jOdwNqXPzz4KfJPb+wBTie3Hv6QDSv/+zrVilEOYQ3qLoUtuHiDFrCOjBm9K5VpEonPRwGD2LGfbqxB7/vYKg6ocykr4SE6ZjojXTa6V3QI42v3Tym8irkamnpn3VG9KxcAucALleIxEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138193; c=relaxed/simple;
	bh=ZzqpQQwo074bgQ7N1gfQOQoTzjP/+qoFGeG9TvQOSAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L6H/AFGEPVNn0hH7AvpdNTvjsH5yqOjMYTyPY65EgafCcLU7ijlDXV4i1V7aB5XqHycUSVmsWrv3WqLIxpvdQqrpU7muYthyuMUukAE4fXTo9NzfLFC4CYqbN0S7c4AwHPKsTnytHlMO4O03LCzyi3pfRXJ6tKg1Ds5OgPq0BMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=C0uIZaDK reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="C0uIZaDK"
ARC-Seal: i=1; a=rsa-sha256; t=1781138187; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QOHz9anI9dTaybU77qxOvOKylz8rEbfavxWc6ea2el8TY7QxAfJbsFGaVkEyj8OXuTsE+f9pb8DgA5bwlfhOLQnhXTtELy2NRa4G8qAuo9RksrsIIldfH2dipn5F+6rSjt2rqNj3t4oNJYGJOVps3EXPcuV7RYs9//3wLMWt5u0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781138187; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lvhzoO0Zfls7LAVS53ykIndDLNLB9FgxadsRvFnb8sk=; 
	b=DoqgBOlzHE56M/eyb8qjZbjcfGwnI4v7dAA+76Ljb51XRJknHqzdFfABS6iCW3YBaJ6GLADPXuIlw1Xpz0imW8XcPDJGxu4pD1uabOlOQHJpSSsLwEeEFKvZMG/H0PahSvAf5dDEqjYMlK1BUyT0lax3Dx3HZNafefQdEDd3ki4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781138187;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=lvhzoO0Zfls7LAVS53ykIndDLNLB9FgxadsRvFnb8sk=;
	b=C0uIZaDKGqEuMsv0wDwcqUXiUjPb0cRe16jpl/AYxW1AYcexKA2Utga3HNPOClj1
	uNMb2PkJbahvSFl4VCWlapsIKMHa7X1H8sjoam2E7iyG0cs7bVVZZSdgIUahQ2Mgx48
	lEVEhVK2KYQflemkdjiLD0x/4B+V31aOEQCzTPhY=
Received: by mx.zohomail.com with SMTPS id 1781138185581229.91578392623285;
	Wed, 10 Jun 2026 17:36:25 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH net v3] mptcp: pm: fix memory leak from alloc-during-teardown race
Date: Thu, 11 Jun 2026 06:06:13 +0530
Message-Id: <20260611003613.3184956-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

mptcp_pm_destroy() frees the entries on msk->pm.anno_list under
msk->pm.lock and then, for the userspace PM, frees the entries on
msk->pm.userspace_pm_local_addr_list under the same lock. The lock is
dropped between the two.

A concurrent userspace PM genl ANNOUNCE on the same msk holds a sock
reference via mptcp_token_get_sock() and, in
mptcp_pm_nl_announce_doit(), calls
mptcp_userspace_pm_append_new_local_addr() and
mptcp_pm_alloc_anno_list(). Both take msk->pm.lock briefly to add to
their respective lists. Because the genl handler holds a sock
reference, mptcp_pm_destroy() may run on the same msk via
mptcp_disconnect(), which invokes mptcp_destroy_common() without
dropping the sock refcount, before the handler completes.

If the lock acquisitions interleave such that mptcp_pm_destroy() empties
a list first, the later alloc adds its entry to a list head that nothing
else iterates for this msk, and the entry leaks. kmemleak reports both
192-byte mptcp_pm_add_entry objects (from mptcp_pm_alloc_anno_list())
and 64-byte mptcp_pm_addr_entry objects (from
mptcp_userspace_pm_append_new_local_addr()) under sustained concurrent
ANNOUNCE + close load against the userspace PM.

Add an MPTCP_PM_DESTROYING bit in msk->pm.status, set by
mptcp_pm_destroy() under pm.lock before the lists are freed and checked
under pm.lock by the alloc paths. Either the alloc takes pm.lock first,
in which case its entry is on the list when mptcp_pm_destroy() frees it;
or mptcp_pm_destroy() takes pm.lock first, in which case the later alloc
observes the bit and refuses.

The bit lives in the pm data reset group, so mptcp_pm_data_reset()
clears it. That is correct on the final-close path, where
mptcp_pm_destroy() is not followed by mptcp_pm_data_reset(). On the
mptcp_disconnect() reuse path, however, mptcp_pm_data_reset() runs after
mptcp_pm_destroy() and clears the bit without pm.lock, so an append that
takes pm.lock after the reset can still add an entry; and
mptcp_pm_data_reset() may re-select a non-userspace path manager for the
reused socket, whose mptcp_pm_destroy() would then not free
userspace_pm_local_addr_list. Free that list unconditionally in
mptcp_pm_destroy(), dropping the mptcp_pm_is_userspace() guard, so such
an entry is always reclaimed; the list is empty for a kernel-PM socket,
so this is a no-op there.

Found by an MPTCP protocol-flow harness extending BRF
(arXiv:2305.08782). The userspace PM baseline of ~0.3 kmemleak
reports/minute is removed by the fence; the rarer disconnect/reuse
residual is reclaimed by the unconditional free above.

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v3:
- Free userspace_pm_local_addr_list unconditionally in mptcp_pm_destroy()
  (drop the mptcp_pm_is_userspace() guard), so an entry appended on the
  mptcp_disconnect() reuse path is reclaimed even when the reused socket
  is re-selected to a non-userspace path manager (sashiko, Matt).

v2:
- Use an MPTCP_PM_DESTROYING bit in msk->pm.status instead of a separate
  bool field (Matt).
- Add Fixes tag (Matt).

The unpatched userspace PM leaks at ~0.3 kmemleak reports/minute; that is
removed by the fence. The disconnect/reuse residual addressed in v3 was
exercised on the same harness, seeded with the corpus that reproduces
the unpatched leak within minutes: ~22 VM-hours (4 VMs, ~5.5 h) with
zero kmemleak reports.

Link to v2: https://lore.kernel.org/all/20260523212930.2957096-1-shardul.b@mpiricsoftware.com/
Link to v1: https://lore.kernel.org/all/20260519191207.1110003-1-shardul.b@mpiricsoftware.com/

 net/mptcp/pm.c           | 17 +++++++++++++++--
 net/mptcp/pm_userspace.c |  4 ++++
 net/mptcp/protocol.h     |  8 ++++++--
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 470501470fe54..14365033adac4 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -440,6 +440,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING))
+		return false;
+
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
@@ -1102,10 +1105,20 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.status |= BIT(MPTCP_PM_DESTROYING);
+	spin_unlock_bh(&msk->pm.lock);
+
 	mptcp_pm_free_anno_list(msk);
 
-	if (mptcp_pm_is_userspace(msk))
-		mptcp_userspace_pm_free_local_addr_list(msk);
+	/* Always free the userspace local address list, not only when the
+	 * socket currently uses the userspace PM: mptcp_pm_data_reset() (on
+	 * the mptcp_disconnect() reuse path) re-selects the path manager from
+	 * the netns default, so a userspace-PM socket can be reused as a
+	 * kernel-PM one with entries still queued here. Freeing an empty
+	 * list is a no-op.
+	 */
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 0d3a95e676f17..07c8ef0db981e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -54,6 +54,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING)) {
+		ret = -EINVAL;
+		goto append_err;
+	}
 	mptcp_for_each_userspace_pm_addr(msk, e) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0 && needs_id)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b93b878478d26..3bc02fbe7e119 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -189,8 +189,12 @@ enum mptcp_pm_status {
 	MPTCP_PM_ESTABLISHED,
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 	MPTCP_PM_ALREADY_ESTABLISHED,	/* persistent status, set after ESTABLISHED event */
-	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED /* persistent status, set after MPC local address is
-					 * accounted int id_avail_bitmap
+	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED, /* persistent status, set after MPC local address is
+					  * accounted int id_avail_bitmap
+					  */
+	MPTCP_PM_DESTROYING,		/* set under pm.lock by mptcp_pm_destroy() to fence
+					 * out PM list allocs that would be orphaned
+					 * by the teardown
 					 */
 };
 
-- 
2.34.1

