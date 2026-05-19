Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13C3E5EE8
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225945; cv=none; b=pE0PQuTNhwZ/4Bn0edNZAssWRxIbFYlfeoel8AqnGRuRRjOv2e3alxdgnx/3Dg5TTA5QVmrIoHuX7k55wuVDS6QDF7RJJk+Z//QVlOUB6XRNNvMLOt0vFqs4UKJFUnpvgNEzUFiZeex0ymZyK7WK/UM4HUx+0nTnMoiyhK6Ap9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225945; c=relaxed/simple;
	bh=5iwVc/wGhW2h6ZkS85KdaUyWbfKw5Iouj003igkNqf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UzyeGW6BxU0tNl7bPlmJAqE+HhiJgVygIhucr75I1ILGEcoX9BpTMdHjvDzATOP7Tu2sIY4p1vxSRUiU6fUO2q9/LFvLbjq4XFNoVMHRGD1i59ZJ5NwWYjOBuqAZ6Wy5WQHGRGgIHOTR144DvmdOZ1OrJvmjWXCPjCRAgYjotwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P86mcD4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P86mcD4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B5A1F00893;
	Tue, 19 May 2026 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225944;
	bh=hONp9e+KXomYTQj/+J0dPGjvbi9dT974pnHzxKr+ZgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=P86mcD4n6QbPDOiTWp59CwEnw45jI3NJQd7gDh1tadWq+uIB7qFSbVGS1O4VCtXCE
	 JIFR/evOjvMF38HPcNBKDtTXL+Eo8xM29FJ7aRKjRxLhxEv78y/LzBuYivQX+1xPeh
	 qlnUuQdKxkvCJP0TQWX//4PzSWx+r22TQERaCLKOurv7BnsfOxNoBtveskhzdGx1qw
	 UtI60XwKP5SZyhlHMnfvUNKO8vHai4q5lEF0tVIMWWZv4WP3ctpHDxN1fRa03LZ9FX
	 ZTYsuCG4055aGtciuBBgBoITe4d+4lY06gOgOteBY2gfwXCEH8aNt/frttIT9M6XcK
	 FLZP4zjv8e2Iw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:26 +1000
Subject: [PATCH mptcp-next v3 15/16] mptcp: pm: avoid using del_timer
 directly
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-15-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5293; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5iwVc/wGhW2h6ZkS85KdaUyWbfKw5Iouj003igkNqf0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVBnIhBWDDVkbEKseA+RMwwOqewotvGDiTPz
 VpiyQVYDbuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 c1B7D/4xfazZVc2HB5aOaS5rNIY88n9u3JsLdpAYDbpov+58+QShUksmKTLgz/sR3I1CZkn/oTm
 B43cu/QVoj5hdhjhqHAHlhVEVrDGMWEvhmMafVW7kMJCJkI5m6gGf7gFOnGpbva1xfpLK0Xlgti
 Ie+EqxtKaMV8CLi5lpqF2ZdqmTbnsgrSe/vrSSFF8IicAOfyk+wOAo9OLGAba/5M5p7rJpVyeuX
 Dgt+vKMJBtQwgqlecVL+acLHhhWZEYjmIHccwF/lbBYyu+mGdVgU2/9WvnR13m7acS6EC7OP4aK
 1CQ40a2K/cyE1lfTmiH86mIt5sUj7HGIYrxE+6/GKgf8G8haTkjepCKSWYXqDxHwkoZ7KeSI+nv
 jaKDDHm47K6RiQ4nYEasq09exyDD5doXsx8Q7pNyE6nF0Ss9yPRs5DN/L2FtEgphl8kE4fugbCh
 RAkywq/K7xjOUY6GKtfrNcFOiJpDFQ1G4W7In3XFaI5rca/5m3wNgE5vJk4fQd1GmaqHseA0+9T
 6QlZOUJb5qd7Kb+doFaxljZ/EWQNLmFYp/BQTApPgaOfsgNMIpY0Re+R9FkssjWei9M0YKLzSP5
 StqUDnYCWJoD478QhTIMcQsXhErRQveWYsk2SXR8qJWDhdf3guosjJwpOuVurO8KtEso0EM2c/p
 wfXfagOa8tn1ljA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_pm_announced_del_timer() removes the matched ADD_ADDR entry (if
found) from the ADD_ADDR list only if check_id is false. That's
dangerous, and not clear, because it means the caller should be free the
entry only in some cases, and it easy to miss that.

Instead, make it static, and call it from mptcp_pm_add_addr_echoed,
which is the only other case where mptcp_pm_add_addr_del_timer should be
called with check_id set to true. Bonus with that: a second call to
mptcp_pm_add_addr_lookup_by_addr() can be avoided.

Note that instead of adding the signature above to avoid a compilation
issue because this helper is called before the definition of the
function, the whole helper is moved above where it is first called. Its
content is untouched, except the addition of the 'static' keyboard.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  1 -
 net/mptcp/pm.c       | 75 +++++++++++++++++++++++++++-------------------------
 net/mptcp/protocol.h |  3 ---
 3 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 259c77b40829..e411324ec2e0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1199,7 +1199,6 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_announced_del_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7af4affa8ecf..ad52dd73d7e8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -149,6 +149,40 @@ mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
 	return NULL;
 }
 
+static struct mptcp_pm_add_addr *
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id)
+{
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_add_addr *entry;
+	struct timer_list *timer = NULL;
+
+	rcu_read_lock();
+
+	spin_lock_bh(&msk->pm.lock);
+	entry = mptcp_pm_announced_lookup(msk, addr);
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
+		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		timer = &entry->timer;
+	}
+	if (!check_id && entry)
+		list_del(&entry->list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	/* Note: entry might have been removed by another thread.
+	 * We hold rcu_read_lock() to ensure it is not freed under us.
+	 */
+	if (timer && check_id)
+		sk_stop_timer(sk, timer);
+
+	rcu_read_unlock();
+
+	if (timer && !check_id)
+		sk_stop_timer_sync(sk, timer);
+
+	return entry;
+}
+
 bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 			       const struct mptcp_addr_info *addr)
 {
@@ -398,40 +432,6 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 	sock_put(sk);
 }
 
-struct mptcp_pm_add_addr *
-mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
-			     const struct mptcp_addr_info *addr, bool check_id)
-{
-	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_add_addr *entry;
-	struct timer_list *timer = NULL;
-
-	rcu_read_lock();
-
-	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_pm_announced_lookup(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id)) {
-		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
-		timer = &entry->timer;
-	}
-	if (!check_id && entry)
-		list_del(&entry->list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	/* Note: entry might have been removed by another thread.
-	 * We hold rcu_read_lock() to ensure it is not freed under us.
-	 */
-	if (timer && check_id)
-		sk_stop_timer(sk, timer);
-
-	rcu_read_unlock();
-
-	if (timer && !check_id)
-		sk_stop_timer_sync(sk, timer);
-
-	return entry;
-}
-
 bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
@@ -730,15 +730,18 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
+	struct mptcp_pm_add_addr *entry;
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!READ_ONCE(pm->work_pending))
+	entry = mptcp_pm_announced_del_timer(msk, addr, true);
+
+	if (!entry || !READ_ONCE(pm->work_pending))
 		return;
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_pm_announced_lookup(msk, addr) && READ_ONCE(pm->work_pending))
+	if (READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a0d2d72a5401..ddb0be7f19bd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1134,9 +1134,6 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			      u8 bkup);
 bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-struct mptcp_pm_add_addr *
-mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
-			     const struct mptcp_addr_info *addr, bool check_id);
 bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
 			       const struct mptcp_addr_info *addr);
 bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *ssk);

-- 
2.53.0

