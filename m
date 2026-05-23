Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8E1DF748
	for <mptcp@lists.linux.dev>; Sat, 23 May 2026 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779571786; cv=pass; b=Sqw+FGQqH797meRS8SRLt381YFRkjI1HZ3yIRbknuGHzWUI1cx8/G9wLChip1Sv3fQzJMYWV8lZwBnERjRKuaLRyojijBmYhKCBDmWT3YaYgAhIp9K5e3KXsQuOTZD9Ov8WhzMjlItoWeNDpb/BcozX/QXFVGA0VXA3vrB7OyPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779571786; c=relaxed/simple;
	bh=qWkpBQk1G5lihWIBd3zqCyR4aCWLz4DK0OTjDlbBDLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QfwZO3dSH0TY7zcjStsqCbEetMmKaQ6FRL78VNxF78UHjPQ6XS2dPbbhseNUl2ackoppyx+wS6pX8D3pS8Jef5b6/rnGuYPPIkdHhIkY/IsKFg3ZzNrdDsl1ZFN/lSwHMufz8ZDS7kRL8Gg/YwGKWRYEQtuoTEXJYoqnk8UCbo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=UH0bYFQQ reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="UH0bYFQQ"
ARC-Seal: i=1; a=rsa-sha256; t=1779571780; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZggjBnMEKkCkL3TytgFovuo6HUmf52Rr5C4aEj6ZIGdhXVuGDlckqByV33fshmw9S8MFuNuPjp5V2F4I6BdIBC7NDpMxvAT04rBXVdZeIUq49k6S+NWMxYj6lWMZ8EFbC+rDrihlH8IS3tE7qR3mTHb6fop5ZR3WkqXBvbh6ROk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779571780; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EFgEZtEKzx3K46A7teloV1u1E9Qt0JyQGUQNhLZuAag=; 
	b=WxcBkZ+Lw6HAVIQcrj+JH4LKEege4/HCeLNtkt8oFZd4AtRuwwrcy7CV3On49CLNXIMzFhnE6hICRLZW5dIeF1eDsGd06LnffjZALAyDfCsdC460V5bP6yib9dmgxkI9ZSPOSjrO32JwvtqRTEsBV4LnVxbK4tcFSyGEX1pq2AE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779571780;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=EFgEZtEKzx3K46A7teloV1u1E9Qt0JyQGUQNhLZuAag=;
	b=UH0bYFQQI4pxjZONaUrXsrKrfuDAdWwcxKY4lA/6a11tDKBN8NEwG8+/2KAmPKMO
	dqaJ+AxlnxCL2QjyAhbixdavCicRaOWfB25+J4C3Swai6I9kVoGCgItP31MuDXR7muA
	hsNqqisN+2KslxVsjzKGC8D5yNuplc0mplvQS4EU=
Received: by mx.zohomail.com with SMTPS id 1779571778503288.14403365910493;
	Sat, 23 May 2026 14:29:38 -0700 (PDT)
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
Subject: [PATCH net v2] mptcp: pm: fix memory leak from alloc-during-teardown race
Date: Sun, 24 May 2026 02:59:30 +0530
Message-Id: <20260523212930.2957096-1-shardul.b@mpiricsoftware.com>
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

Add an MPTCP_PM_DESTROYING bit in msk->pm.status, set by
mptcp_pm_destroy() under pm.lock before the splice and checked
under pm.lock by the alloc paths. Either the alloc takes pm.lock
first, in which case its entry will be on the list when destroy's
splice runs and will be freed normally; or destroy takes pm.lock
first, in which case the subsequent alloc observes the bit and
refuses. Either ordering is correct, and the race that orphans
an entry is precluded. The bit lives in the pm data reset group,
so mptcp_pm_data_reset() clears it on the disconnect/reuse path
as well as on fresh socket init.

Found by an MPTCP protocol-flow harness extending BRF
(arXiv:2305.08782). Baseline ~0.3 kmemleak reports/minute on the
userspace PM reduces to zero across multi-hour runs with this
patch applied.

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v2:
- Use a new MPTCP_PM_DESTROYING bit in msk->pm.status instead of a
  separate bool field; the bit lives in the PM data reset group, so
  mptcp_pm_data_reset() clears it on the disconnect/reuse path as
  well as on fresh socket init (Matt).
- Add Fixes tag (Matt).

Link to v1: https://lore.kernel.org/all/20260519191207.1110003-1-shardul.b@mpiricsoftware.com/

 net/mptcp/pm.c           | 7 +++++++
 net/mptcp/pm_userspace.c | 4 ++++
 net/mptcp/protocol.h     | 7 +++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3e770c7407e1f..480842b01fed0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -440,6 +440,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING))
+		return false;
+
 	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
@@ -1109,6 +1112,10 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.status |= BIT(MPTCP_PM_DESTROYING);
+	spin_unlock_bh(&msk->pm.lock);
+
 	mptcp_pm_free_anno_list(msk);
 
 	if (mptcp_pm_is_userspace(msk))
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8cbc1920afb49..3ba1f67ba8ed8 100644
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
index e4f5aba24da7d..86a050e22585d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -189,8 +189,11 @@ enum mptcp_pm_status {
 	MPTCP_PM_ESTABLISHED,
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 	MPTCP_PM_ALREADY_ESTABLISHED,	/* persistent status, set after ESTABLISHED event */
-	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED /* persistent status, set after MPC local address is
-					 * accounted int id_avail_bitmap
+	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED, /* persistent status, set after MPC local address is
+					  * accounted int id_avail_bitmap
+					  */
+	MPTCP_PM_DESTROYING,		/* set under pm.lock by mptcp_pm_destroy() to fence
+					 * out PM list allocs that would be orphaned by splice
 					 */
 };
 
-- 
2.34.1

