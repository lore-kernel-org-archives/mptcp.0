Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CB341ADF
	for <mptcp@lists.linux.dev>; Sat, 20 Jun 2026 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945115; cv=pass; b=CtMdjCTRgnudawu9g6DkiCAo+W9pH/cdm1DzbwZ+oRoPDTNn3U2t137d1lXxBqVrarSVfOsoayymtbG4tI6k7qIPcVEt6BSiXgs8k0yzATAhTPQm0ePurMSr4xQeTLiIyskkPcRHvLlzPaMD2M/vMSikmA0Zg/Q2AN8RZvK9lkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945115; c=relaxed/simple;
	bh=HKqfuNwumG0euBO5dyGg51v4Ae3Kbmmy+g+h7RC2xcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmlasnDUCj2clXR3u3JfVFhg9wRv6o9Sk1RspkXbLwcMvFtkvTN+xqm9VWzujNJ5Mg4dTZsQFcvNz7XnOJVb24MmaRO/2+fhow9i3MCLJer/SngEOl4rPara86JsqvLW3/VVtrvVaOr9XTAuPjRYEYRoz0efmNJUrDPpa0obHXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=O4ZZvVzj reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="O4ZZvVzj"
ARC-Seal: i=1; a=rsa-sha256; t=1781945100; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kkThBulncyKJ4WQ7Zasx/AocIylgP3tJ6xbmYgArLbpyMu3vz6tw5KQkjLccnj6lDxnMbHJWPzRZkv3E4a7iKE33MBImTlnahJQjq0hd6CykCpEVvgKEAq6U3uv1Jn8s4m3PYjOxgt04dgH9NqL2/v8s5p53cNGI0DrnShwQzIQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781945100; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/Nxe0qCvFfyvsisZio2EjBj4fn7T+i1McrV4/rS/QA4=; 
	b=MRujCcwj5BsU7qsQntBI56fPiVprAOWlMqSdRpUmDh4HWElZEpYVReThuxwHNCMWLykbkt8Zg0+RY5hlug9eUZoGJtGoImqg1Qm2dnP4Qhqlmk18QqqOE/IbQ5lcj1L7QDnfVdYENbjJ3ayymzt7tWFarokfVBgKB/SJIU7LoJk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781945100;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=/Nxe0qCvFfyvsisZio2EjBj4fn7T+i1McrV4/rS/QA4=;
	b=O4ZZvVzjzVmX0VJj1gIEWZKR5yvQtExXCnyFF2JetlTpHg3gt+uupjzi7FIt9dPc
	DiX+0QSVJnoB+77bGewYjFRxVlKquB8nFzca/1hozcMdcn7GsYhv3BeFnmRePsIBFCm
	Ts1pFIh7kaH56J/VbdIEDSat4tr/ebcH2C/Hg0Pw=
Received: by mx.zohomail.com with SMTPS id 1781945099753400.69837462281;
	Sat, 20 Jun 2026 01:44:59 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	pabeni@redhat.com,
	kalpan.jani@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 2/2] mptcp: pm: fix memory leak from alloc-during-teardown race
Date: Sat, 20 Jun 2026 14:14:24 +0530
Message-Id: <20260620084424.3072634-3-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260620084424.3072634-1-shardul.b@mpiricsoftware.com>
References: <20260620084424.3072634-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

mptcp_pm_destroy() empties msk->pm.anno_list and
msk->pm.userspace_pm_local_addr_list under msk->pm.lock during socket
teardown, dropping the lock between the two.

A concurrent userspace PM genl ANNOUNCE on the same msk holds a sock
reference via mptcp_token_get_sock() and, in
mptcp_pm_nl_announce_doit(), calls
mptcp_userspace_pm_append_new_local_addr() and
mptcp_pm_announced_alloc(). Both take msk->pm.lock briefly to add to
their respective lists. Because the genl handler holds a sock reference,
mptcp_pm_destroy() may run on the same msk via mptcp_disconnect(), which
invokes mptcp_destroy_common() without dropping the sock refcount,
before the handler completes.

If the lock acquisitions interleave such that mptcp_pm_destroy() empties
a list first, the later alloc adds its entry to a list head that nothing
else iterates for this msk, and the entry leaks. kmemleak reports both
mptcp_pm_add_addr objects (from mptcp_pm_announced_alloc()) and
mptcp_pm_addr_entry objects (from
mptcp_userspace_pm_append_new_local_addr()) under sustained concurrent
ANNOUNCE + close load against the userspace PM.

Add an MPTCP_PM_DESTROYING bit in msk->pm.status, set by
mptcp_pm_destroy() under pm.lock before the lists are emptied and
checked under pm.lock by the alloc paths. Either the alloc takes pm.lock
first, in which case its entry is on the list when mptcp_pm_destroy()
frees it; or mptcp_pm_destroy() takes pm.lock first, in which case the
later alloc observes the bit and refuses.

Found by an MPTCP protocol-flow harness extending BRF (arXiv:2305.08782).

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/pm.c           | 7 +++++++
 net/mptcp/pm_userspace.c | 4 ++++
 net/mptcp/protocol.h     | 8 ++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8e6d066a868d7..66393a9450a7d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -441,6 +441,9 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING))
+		return false;
+
 	add_entry = mptcp_pm_announced_lookup(msk, addr);
 	if (add_entry) {
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
@@ -1168,6 +1171,10 @@ static void mptcp_pm_ops_release(struct mptcp_sock *msk)
 
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.status |= BIT(MPTCP_PM_DESTROYING);
+	spin_unlock_bh(&msk->pm.lock);
+
 	mptcp_pm_free_announced_list(msk);
 	mptcp_pm_ops_release(msk);
 	/* Free the userspace local address list unconditionally: the socket
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 96fdaf12f6ddd..d9d3d665e8142 100644
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
index da40c6f3705f1..e79e1b8596bcb 100644
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

