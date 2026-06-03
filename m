Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6701B3806DB
	for <mptcp@lists.linux.dev>; Wed,  3 Jun 2026 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487891; cv=pass; b=gQ4A5LuimvvXrh7LtijPghAPVarQT/hIwFhX1n5s4UiitOZRVV7CfsoOb+0x4zYRwOcWyKyNlkSd4eXYDDHWFZUPucdZDi4xYxmYoCgWngv4KeI/CtZoCzKUHQYhKAtKmDYFLtfUYUJz7+jDyW181jgxzfD9HbxoOnrazsjh0qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487891; c=relaxed/simple;
	bh=n3mLDITZhLvsaGoccIMAPTP8z2qZAbJLV7FfjDOg7mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfExlRD4ESX8Ldfd7tQu8eGcUOGC/U/xIx/CePq+vaStUzsVuySo094LvLzlr4i+tYzFVZPnp4xRKpnR2xqKClFgEFSgPVQHGaMsilFCEM/fkGCkLI/aBHLxvkhMv1e1FNOdIee0BreCuEipEysT+DY78cIWR++rag3n8GN2aP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=kkSK4qOE reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="kkSK4qOE"
ARC-Seal: i=1; a=rsa-sha256; t=1780487886; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iqk3ROgj6pk2Cti/otsFKr/wi4VsrLp+ex7oN5SD4iwP9KJmmtCewKEPqhgCVJoeoeU0SXeoAwxQfBgvt2kFu77VgM8NApZXCiRVNUN02MguJAlccjpfmisSdK3tGZcf2trA46ziyWF9ao0tTP+Kio0HrynX3KebOjiRdjDZlpY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780487886; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O4nkeXToL6z0Eb+vF2qg1/B58ty94zCYdr3LLkyGWyI=; 
	b=h9Blr6oLwz8bmpMDpQkvXvsVEnsYA4gmXz+2CQHoo3Ad83O+md/d9D/eVun11VGDJhT+RGzs7hDkhYHk3qbsTyWl3Cp+4g3T/0zWh3EzrethwvNhlw7OjgjJ/X1zGCmp0k6VmDT+Qk57Ke4WDDxKi65sE8mWUTvruq101T6qDVs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780487886;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=O4nkeXToL6z0Eb+vF2qg1/B58ty94zCYdr3LLkyGWyI=;
	b=kkSK4qOE1C6uE1yGdacVNy4eUcSJenmNWxl78QxUzj/V6Qb8z6n9ahJyXyOpd724
	z+vNvuS6J3CPrmDSCP5f89sMNpPVgbgiNy8xW+yjWoh1uohLh0bW5n9qR25ArHTCyZM
	xbUBuUpBv0aBoz5UJL4SMB7WJyNd7qXtohX7c1HE=
Received: by mx.zohomail.com with SMTPS id 1780487883635613.776144100173;
	Wed, 3 Jun 2026 04:58:03 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-net] mptcp: pm: use timer_shutdown_sync() on free paths
Date: Wed,  3 Jun 2026 17:26:34 +0530
Message-ID: <20260603115634.2292342-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Replace sk_stop_timer_sync() (which wraps timer_delete_sync()) with
timer_shutdown_sync() in mptcp_pm_del_add_timer() and
mptcp_pm_free_anno_list() when freeing ADD_ADDR timer entries.

Issue #623 identified potential re-arming of ADD_ADDR timers
after cancellation. While the code is currently safe via RCU
protection and timer_delete_sync() retry loop, it relies on
implementation details rather than the documented timer API contract.

The kernel's timer API documentation states: "Callers must prevent
restarting of the timer, otherwise this function is meaningless."
timer_shutdown_sync() is the documented API for this exact scenario
- it sets timer->function = NULL, permanently preventing any
re-arm attempts.

Benefits of this change:
- Uses the proper, documented kernel API for shutdown scenarios
- Prevents re-arms at the core level (sets timer->function = NULL)
- Eliminates unsynchronized timer_done check in
  mptcp_pm_free_anno_list
- More robust against future kernel changes to timer internals
- Removes reliance on timer_delete_sync() retry loop mechanism

The change is safe: current protections (RCU, timer_delete_sync
retry loop) remain in place during the transition. This is a code
quality improvement, not a bug fix for a live crash.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/623
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/pm.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3e770c7407e1..82785ae78c56 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -157,6 +157,9 @@ bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	ret = entry;
+	/* timer_shutdown_sync() already called in mptcp_pm_del_add_timer.
+	 * Timer is permanently stopped and cannot re-arm. Safe to free.
+	 */
 	kfree_rcu(entry, rcu);
 
 	return ret;
@@ -404,6 +407,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
 	bool stop_timer = false;
+	int timer_was_armed;
 
 	rcu_read_lock();
 
@@ -421,13 +425,24 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	 * We hold rcu_read_lock() to ensure it is not freed under us.
 	 */
 	if (stop_timer) {
-		if (check_id)
+		/* For check_id=false (entry about to be freed): use
+		 * timer_shutdown_sync() to permanently prevent re-arming.
+		 * This matches the kernel's documented pattern for shutdown
+		 * scenarios and eliminates reliance on timer_delete_sync
+		 * catching in-callback re-arms.
+		 *
+		 * For check_id=true (entry kept alive): use async stop.
+		 */
+		if (check_id) {
 			sk_stop_timer(sk, &entry->add_timer);
-		else
-			sk_stop_timer_sync(sk, &entry->add_timer);
+		} else {
+			timer_was_armed = timer_shutdown_sync(&entry->add_timer);
+			if (timer_was_armed)
+				__sock_put(sk);
+		}
 	}
 
 	rcu_read_unlock();
+
 	return entry;
 }
 
@@ -474,6 +489,7 @@ static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	struct mptcp_pm_add_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
+	int timer_was_armed;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -482,8 +498,16 @@ static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
-		if (!entry->timer_done)
-			sk_stop_timer_sync(sk, &entry->add_timer);
+		/* Always shutdown timer: no timer_done check needed.
+		 * timer_shutdown_sync() is idempotent and prevents future
+		 * re-arms. This eliminates the unsynchronized timer_done
+		 * read, making the shutdown intent explicit and matching
+		 * the kernel's documented pattern for cleanup scenarios.
+		 */
+		timer_was_armed = timer_shutdown_sync(&entry->add_timer);
+		if (timer_was_armed)
+			__sock_put(sk);
+
 		kfree_rcu(entry, rcu);
 	}
 }
-- 
2.43.0
