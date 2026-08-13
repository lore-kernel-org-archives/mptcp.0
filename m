Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146BB40DB47
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620756; cv=pass; b=b0Z43L6Z/UcNycwITKv4l1m9CXUezRsZGAUvkK/7VkciepwB6lCzHEkQCm3FHxi/baJ7opLrLw8jtZsdX9yyk36xhRBZ0SS3heqIbcXYZR2+XA8XCCdqQ6jo69KPgdNxQMkfbgQk4D1xp3XsoFjI5jvXDpfLGyBKBa7JUpHxJtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620756; c=relaxed/simple;
	bh=9b2F65tkG7xPfhJvmVP1kZ6kNUsCHnbHIlC1q3K3gGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=caWWKvA4h2NzWgMslervh5WdHWYDdU6JR/kz9zvCcfiJcYSwkhCQcAbilBOQtZHF79dI1gephWexX7Laz3Km5dvyc9AtdQJgOYoDUOdTpOR6ZI5MiH+e4F3fmbn+NSdJhyB3YKDxoEgxvKVkXaCYhSKawC6JIbwA/QYZd0O24/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=akshit@mpiricsoftware.com header.b=NLHva+lE reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=akshit@mpiricsoftware.com header.b="NLHva+lE"
ARC-Seal: i=1; a=rsa-sha256; t=1786620748; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H6mmMbRwunYaz7327iQO+lX7F1sNkP7m2/mG6CoRFsRIgDoEFls1QmyY8ZoCWy1Spy7s5nrEx+68mafcIaNdEydATU6V84JcPkKvGXe1dhUVbpM+W8M26CAi92TDl0aZDxrA3sdKgt5juDt2XGcO2JEUwvyGZz2jL7VCUTFpjT4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786620748; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=R0yK2wCIaNCoLPRcPKZjz6mwApswCqR0/CLxiVofF9g=; 
	b=WExBtX88YI9isS861anTmqmo0xYDigZj+A99EKO8D63kcCT3imLuAvclhKO7raRi8+dqaS2ixx/DBtXA87pIjspeQfBgq5yPf0WhrFKN6Im3gjIfw2KWXpnpoMzKNaJwRq1912CglvSPrAPZ8wp3FR/Q7A5gezSdvnJncpJlHBQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=akshit@mpiricsoftware.com;
	dmarc=pass header.from=<akshit@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786620747;
	s=mpiric; d=mpiricsoftware.com; i=akshit@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=R0yK2wCIaNCoLPRcPKZjz6mwApswCqR0/CLxiVofF9g=;
	b=NLHva+lEjENy2lnTX+2mWZFnWvW8yPhTZXy1HVlVCBN2g/J3mSUEtEYCYW2+L+bT
	Gleaz/T65SEd/+AZjJOqsfe9bF13E1tY4TnmRcjHjTFZyjVu7NGEumapMelLb3D16OB
	NUrJiO/p78SWVf/vSqd1RDM5aiYcVDmbG3DEKRhE=
Received: by mx.zohomail.com with SMTPS id 1786620740287195.33826843431825;
	Thu, 13 Aug 2026 04:32:20 -0700 (PDT)
From: Akshit Patadiya <akshit@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	kalpan.jani@mpiricsoftware.com,
	akshit@mpiric.us,
	Akshit Patadiya <akshit@mpiricsoftware.com>
Subject: [PATCH mptcp-next] mptcp: fix add_addr_accepted accounting on subflow close
Date: Thu, 13 Aug 2026 17:02:08 +0530
Message-ID: <20260813113208.3809139-1-akshit@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When an accepted remote address is used by a subflow that is
closed before the corresponding RM_ADDR is received, the
add_addr_accepted counter is not decremented when the subflow
is removed.

As a result, the accepted-address budget can remain consumed
for the lifetime of the MPTCP connection. A subsequent ADD_ADDR
is then not acted upon because the peer is considered to have
already reached the add_addr_accepted limit.

Release the accepted-address slot when the subflow using the
remote address is closed, so that a later RM_ADDR and subsequent
ADD_ADDR can correctly reuse the available budget.

This allows a new MP_JOIN to be created after a previously
accepted subflow has been closed and its address has been
removed.

Fixes: 1c1f72137598 ("mptcp: pm: only decrement add_addr_accepted for MPJ req")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/498
Signed-off-by: Akshit Patadiya <akshit@mpiricsoftware.com>
---
 net/mptcp/pm.c        |  8 +++---
 net/mptcp/pm_kernel.c | 63 ++++++++++++++++++++++++++++++++++++-------
 net/mptcp/protocol.h  |  3 +++
 3 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ba7c6f80a183..b6edb9df3216 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -681,8 +681,10 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 		return;
 
 	spin_lock_bh(&pm->lock);
-	if (update_subflows)
+	if (update_subflows) {
 		__mptcp_pm_close_subflow(msk);
+		mptcp_pm_nl_close_subflow(msk, subflow);
+	}
 
 	/* Even if this subflow is not really established, tell the PM to try
 	 * to pick the next ones, if possible.
@@ -786,7 +788,6 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 	for (i = 0; i < rm_list->nr; i++) {
 		u8 rm_id = rm_list->ids[i];
-		bool removed = false;
 
 		mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
@@ -807,7 +808,6 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 				 i, rm_id, id, remote_id, msk->mpc_endpoint_id);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
-			removed |= subflow->request_join;
 
 			/* the following takes care of updating the subflows counter */
 			mptcp_close_ssk(sk, ssk, subflow);
@@ -819,7 +819,7 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 
 		if (rm_type == MPTCP_MIB_RMADDR) {
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
-			if (removed && mptcp_pm_is_kernel(msk))
+			if (mptcp_pm_is_kernel(msk))
 				mptcp_pm_nl_rm_addr(msk, rm_id);
 		}
 	}
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d3014bf57bf3..8b087677a4e7 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -694,8 +694,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (sf_created) {
-		/* add_addr_accepted is not decr for ID 0 */
-		if (remote.id)
+		/* ID 0 is not accounted: the remote address of the initial
+		 * subflow is known from the beginning. Remember the other
+		 * accepted IDs, so the counter can be balanced later on even
+		 * if the linked subflows are gone by then.
+		 */
+		if (remote.id &&
+		    !__test_and_set_bit(remote.id, msk->pm.id_accepted_bitmap))
 			msk->pm.add_addr_accepted++;
 		if (msk->pm.add_addr_accepted >= limit_add_addr_accepted ||
 		    msk->pm.extra_subflows >= limit_extra_subflows)
@@ -705,16 +710,53 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 {
-	if (rm_id && !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
-		u8 limit_add_addr_accepted =
-			mptcp_pm_get_limit_add_addr_accepted(msk);
+	u8 limit_add_addr_accepted;
 
-		/* Note: if the subflow has been closed before, this
-		 * add_addr_accepted counter will not be decremented.
-		 */
-		if (--msk->pm.add_addr_accepted < limit_add_addr_accepted)
-			WRITE_ONCE(msk->pm.accept_addr, true);
+	/* Only remote addresses that have been accepted by this host are
+	 * accounted: not ID 0, and not MP_JOIN requests initiated by the peer.
+	 * The bit, not the presence of a subflow, is what tells them apart, so
+	 * this works even when the subflows are already closed, and a
+	 * duplicated RM_ADDR is a no-op.
+	 */
+	if (!rm_id || !__test_and_clear_bit(rm_id, msk->pm.id_accepted_bitmap))
+		return;
+
+	if (WARN_ON_ONCE(msk->pm.add_addr_accepted == 0))
+		return;
+
+	limit_add_addr_accepted = mptcp_pm_get_limit_add_addr_accepted(msk);
+	if (--msk->pm.add_addr_accepted < limit_add_addr_accepted)
+		WRITE_ONCE(msk->pm.accept_addr, true);
+}
+
+/* Called with the PM lock held, from the subflow close path, before the
+ * subflow is removed from conn_list.
+ */
+void mptcp_pm_nl_close_subflow(struct mptcp_sock *msk,
+			       const struct mptcp_subflow_context *subflow)
+{
+	u8 remote_id = READ_ONCE(subflow->remote_id);
+	struct mptcp_subflow_context *iter;
+
+	/* Only the subflows this host has created upon an ADD_ADDR reception
+	 * are accounted, and never the initial one.
+	 */
+	if (!subflow->request_join || !remote_id ||
+	    !test_bit(remote_id, msk->pm.id_accepted_bitmap))
+		return;
+
+	/* The remote address can still be used by another subflow, e.g. with
+	 * fullmesh endpoints.
+	 */
+	mptcp_for_each_subflow(msk, iter) {
+		if (iter == subflow || iter->close_event_done)
+			continue;
+		if (iter->request_join &&
+		    READ_ONCE(iter->remote_id) == remote_id)
+			return;
 	}
+
+	mptcp_pm_nl_rm_addr(msk, remote_id);
 }
 
 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
@@ -1668,6 +1710,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->accept_subflow, subflows_allowed);
 
 	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	bitmap_zero(pm->id_accepted_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 }
 
 struct mptcp_pm_ops mptcp_pm_kernel = {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e168e450fb0..54663d7aca34 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -243,6 +243,7 @@ struct mptcp_pm_data {
 	);
 
 	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	DECLARE_BITMAP(id_accepted_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_rm_list rm_list_tx;
 	struct mptcp_rm_list rm_list_rx;
 };
@@ -1127,6 +1128,8 @@ void mptcp_pm_send_ack(struct mptcp_sock *msk,
 		       bool prio, bool backup);
 void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_nl_close_subflow(struct mptcp_sock *msk,
+			       const struct mptcp_subflow_context *subflow);
 void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
 			 const struct mptcp_rm_list *rm_list);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
-- 
2.43.0

