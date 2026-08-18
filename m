Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3C3C98B5
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054696; cv=pass; b=g3nloFlVnrSdI2j9Vll+q/sA0Rp+VGM+5mUoyURg6EdCCfWWUvqedrSSbx+GBA32zDwdvAQ3wUfOzFxR5BP9+q4TRO0dePSP9arrZSJzYjYocWZOmXtZtuwooY7nyIR0sWDAC3ty4/QgbU5pEURgFm1Zg7zj2u4Zbt0DzSvrauE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054696; c=relaxed/simple;
	bh=37+27jY4W2KEKNFVlFYvpV4P4ftPxbmFLsrq9PTyLTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thKo+4ft6/ggUX9ClnxheVYSnT1dFyvpKFs8MGaxIogRATjOdoTsnaY430wt36KsmsdHEvGB8FwUknXin0G2/q5n8JuA6oCaBjeo7pYVpdHMH2pswPP5S2n5gE1WsIQkKreWRApDQFQhL2Mxh70pNgQT0Xcnp5fuUtBb9x00pXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=KOOFBjQl reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="KOOFBjQl"
ARC-Seal: i=1; a=rsa-sha256; t=1787054688; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=maDJwV33NxXb5vNRys1mpcAG0epgFv91Fvl8I6fsNz8x4pY9KygJFQ3YqzNMrj231nr7f184NRAywQ5u0GokrNRpR32E4Lu8wA5jAELnAB2yWsV13iX1VQ+TAjN5mOT21AS+be0SE6uF3N2IA2V/0iX8L3kgrO2ms0Qsdn/HyYg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787054688; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OdYQOi/K2bv7BzQ8NBUoFC9QMvE/t1g06XJ3rCWttwM=; 
	b=fbeZe06hfy7kUJc1boqWFkwYq54nK3tkTAgwGOkELZwjkIb/6hHiDX1Gh3cNKv2eq6KjmsYlb/IzNcASTlCJADppZLrRlf1OifBtCcqlnL6woryXVQMman4UsVytcsIJmpY1UKhZX9pdPpTucluPR1LkCW6S7wDh91LLv3XyUsg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787054688;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OdYQOi/K2bv7BzQ8NBUoFC9QMvE/t1g06XJ3rCWttwM=;
	b=KOOFBjQlwc1kqWr4UUZ0BVr61LEsN5iG3hae7XMSRq5CIPl6P2aIUSlaB9ilrNY/
	PX8polCfvbK2Tfx05HMN8lsdegCxTdubpKlLrvzeesnVGdQvckPj5/Ojs62DkbphQ9h
	Cp6BLMGqJ1OIoRcjfSqMVorp246OU92XLXeBBTUE=
Received: by mx.zohomail.com with SMTPS id 1787054685965342.3766921748005;
	Tue, 18 Aug 2026 05:04:45 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-net v5] mptcp: bpf: fix NULL deref and UAF in bpf_mptcp_sock_from_subflow()
Date: Tue, 18 Aug 2026 17:34:37 +0530
Message-ID: <20260818120437.3949686-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

bpf_mptcp_sock_from_subflow() is reachable from tracing BPF programs
via bpf_skc_to_mptcp_sock() on an arbitrary socket, without the
subflow socket lock held. It assumes sk_is_mptcp(sk) implies a valid
subflow context whose ->conn points to a live parent mptcp_sock. That
invariant does not hold in several windows:

- Fallback: subflow_ulp_fallback() clears icsk_ulp_data before clearing
tcp_sk(sk)->is_mptcp, so a reader can observe is_mptcp == 1 with a NULL
context and dereference mptcp_subflow_ctx(sk)->conn through NULL.

- Init: subflow_ulp_init() sets is_mptcp = 1 while ->conn is still NULL;
on CONFIG_DEBUG_NET, mptcp_sk() dereferences its argument in a
WARN_ON(), so mptcp_sk(NULL) faults.

- Publish: the passive MPC path in subflow_syn_recv_sock() stored the
freshly cloned parent into ->conn with a plain assignment, on a child
that is already hashed and globally visible. A lockless reader could
observe a non-NULL ->conn before the stores initialising the new
mptcp_sock were visible.

- Teardown: subflow_ulp_release() and mptcp_subflow_drop_ctx() dropped
the subflow-owned parent reference with sock_put() without clearing
->conn, and the established parent msk was not SOCK_RCU_FREE, so a
lockless reader could dereference a freed parent: a use-after-free.

Load the context with rcu_dereference() and read ->conn with
smp_load_acquire(), paired with an smp_store_release() on the publish so
a reader observing a non-NULL ->conn also observes the initialised
parent. Reject a NULL context or NULL ->conn before casting. Clear ->conn
before dropping the parent reference in both release paths, and give the
parent msk RCU-grace lifetime by setting SOCK_RCU_FREE in
__mptcp_init_sock().

Commit 5e20087d1b67 ("mptcp: handle mptcp listener destruction via rcu")
already makes the listener msk SOCK_RCU_FREE for its lockless ->conn
reader and resets the flag on the accepted child, which had no such
reader. This helper adds one to the accepted msk; __mptcp_destroy_sock()
performs all msk teardown before the final sock_put() and shares
mptcp_destroy_common() with the already-RCU-freed listener, so extending
the same lifetime is safe. Drop the reset.

v4 went with dropping this from tracing_prog_func_proto() instead,
since sock_ops/cg_sockopt hold the lock and nothing else uses it from
tracing. Sashiko pointed out the helper's still reachable lock-free
through bpf_sk_base_func_proto() (XDP, TC), and sock_ops can pass in
an arbitrary socket via bpf_sk_lookup_tcp() anyway, so that didn't
actually fix it. Back to hardening the read itself. Tracing stays
removed since nothing needs it there.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/622
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---

Changes in v5:
- Sashiko caught that dropping the helper from tracing_prog_func_proto()
in v4 doesn't actually close this - it's still reachable lock-free via
bpf_sk_base_func_proto() (XDP/TC), and sock_ops can pass an arbitrary
socket in via bpf_sk_lookup_tcp() regardless of its own lock. Back to
the v3 lockless-read fix (rcu_dereference/acquire-release/SOCK_RCU_FREE),
on top of keeping the tracing removal from v4.
- Checked if the v3 sleepable guard on the tracing case is still needed
now that tracing access is gone entirely - it's not, none of the
remaining callers (TC, XDP, sock_ops, cg_sockopt, sk_lookup) can load
as sleepable per can_be_sleepable() in the verifier.

Changes in v4:
- Instead of hardening the lockless read (rcu_dereference/acquire-
release/SOCK_RCU_FREE from v3), just drop tracing's access to the
helper, per Paolo. sock_ops and cg_sockopt already hold the subflow
lock so they're not affected, and nothing in-tree uses this from a
tracing program anyway. Patch is now a 2-line removal in
kernel/trace/bpf_trace.c, everything else from v3 is dropped.

Changes in v3:
- Fix the publish race in subflow_syn_recv_sock() that v2 missed
(Sashiko): the passive MPC path stored the freshly cloned parent into
->conn with a plain assignment on an already-hashed child. Publish with
smp_store_release() and pair the helper read with smp_load_acquire(), so
a lockless reader observing a non-NULL ->conn also sees the initialised
parent.
- Clear ->conn before sock_put() in mptcp_subflow_drop_ctx() too, not just
subflow_ulp_release(): it had the same stale-pointer teardown pattern.
- Audited the SOCK_RCU_FREE change: __mptcp_destroy_sock() does all msk
teardown before the final sock_put() and shares mptcp_destroy_common()
with the already-RCU-freed listener, so deferring the free is safe.

Changes in v2:
- Lockless access fixes (Li Xiasong): load the subflow context with
rcu_dereference_check() instead of a plain dereference, and read ->conn
once.
- Fix the teardown use-after-free that v1 did not address: clear ->conn
before dropping the parent reference in subflow_ulp_release(), and give
the parent msk RCU-grace lifetime via SOCK_RCU_FREE.
- Stop exposing the helper to sleepable BPF programs, where classic RCU
gives no lifetime guarantee.

v1: https://lore.kernel.org/all/20260612072643.2313900-1-kalpan.jani@mpiricsoftware.com/
v2: https://lore.kernel.org/all/20260626125058.868855-1-kalpan.jani@mpiricsoftware.com/
v3: https://lore.kernel.org/all/20260629105020.1670781-1-kalpan.jani@mpiricsoftware.com/
v4: https://lore.kernel.org/all/20260817113202.1832692-1-kalpan.jani@mpiricsoftware.com/

---
 kernel/trace/bpf_trace.c |  2 --
 net/mptcp/bpf.c          | 17 +++++++++++++++--
 net/mptcp/protocol.c     |  7 ++++++-
 net/mptcp/subflow.c      | 40 +++++++++++++++++++++++++++++++++-------
 4 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 82f8feea6931..43a5517fde47 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1745,8 +1745,6 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_skc_to_udp6_sock_proto;
 	case BPF_FUNC_skc_to_unix_sock:
 		return &bpf_skc_to_unix_sock_proto;
-	case BPF_FUNC_skc_to_mptcp_sock:
-		return &bpf_skc_to_mptcp_sock_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_tracing_proto;
 	case BPF_FUNC_sk_storage_delete:
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0845061ddc65..272bfbaf199d 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -193,8 +193,21 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
-	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
-		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+	struct mptcp_subflow_context *ctx;
+	struct sock *conn;
+
+	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk)) {
+		ctx = rcu_dereference(inet_csk(sk)->icsk_ulp_data);
+		if (ctx) {
+			/*
+			 * Pairs with smp_store_release() when ->conn is
+			 * published in subflow_syn_recv_sock().
+			 */
+			conn = smp_load_acquire(&ctx->conn);
+			if (conn)
+				return mptcp_sk(conn);
+		}
+	}
 
 	return NULL;
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ffcf5a1788f6..4c5091c0375c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3182,6 +3182,12 @@ static void __mptcp_init_sock(struct sock *sk)
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
 
+	/*
+	 * The returned parent msk may be handed to lockless readers
+	 * (bpf_skc_to_mptcp_sock()); free it after an RCU grace period.
+	 */
+	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&sk->mptcp_retransmit_timer, mptcp_retransmit_timer, 0);
 	timer_setup(&msk->sk.mptcp_tout_timer, mptcp_tout_timer, 0);
@@ -3717,7 +3723,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	/* passive msk is created after the first/MPC subflow */
 	msk->subflow_id = 2;
 
-	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	security_inet_csk_clone(nsk, req);
 
 	/* this can't race with mptcp_close(), as the msk is
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb9..76a649d2c2b6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -787,8 +787,12 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 	list_del(&mptcp_subflow_ctx(ssk)->node);
 	if (inet_csk(ssk)->icsk_ulp_ops) {
 		subflow_ulp_fallback(ssk, ctx);
-		if (ctx->conn)
-			sock_put(ctx->conn);
+		if (ctx->conn) {
+			struct sock *conn = ctx->conn;
+
+			WRITE_ONCE(ctx->conn, NULL);
+			sock_put(conn);
+		}
 	}
 
 	kfree_rcu(ctx, rcu);
@@ -818,6 +822,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	bool fallback, fallback_is_fatal;
 	enum sk_rst_reason reason;
 	struct mptcp_sock *owner;
+	struct sock *conn;
 	struct sock *child;
 
 	pr_debug("listener=%p, req=%p, conn=%p\n", listener, req, listener->conn);
@@ -880,12 +885,19 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		ctx->setsockopt_seq = listener->setsockopt_seq;
 
 		if (ctx->mp_capable) {
-			ctx->conn = mptcp_sk_clone_init(listener->conn, &mp_opt, child, req);
-			if (!ctx->conn)
+			conn = mptcp_sk_clone_init(listener->conn, &mp_opt, child, req);
+			if (!conn)
 				goto fallback;
 
 			ctx->subflow_id = 1;
-			owner = mptcp_sk(ctx->conn);
+			owner = mptcp_sk(conn);
+
+			/*
+			 * Publish the fully initialized parent. Pairs with
+			 * smp_load_acquire() in
+			 * bpf_mptcp_sock_from_subflow().
+			 */
+			smp_store_release(&ctx->conn, conn);
 
 			if (mp_opt.deny_join_id0)
 				WRITE_ONCE(owner->pm.remote_deny_join_id0, true);
@@ -920,7 +932,11 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
-			ctx->conn = (struct sock *)owner;
+			/*
+			 * Publish the parent. Pairs with smp_load_acquire()
+			 * in bpf_mptcp_sock_from_subflow().
+			 */
+			smp_store_release(&ctx->conn, (struct sock *)owner);
 
 			if (subflow_use_different_sport(owner, sk)) {
 				pr_debug("ack inet_sport=%d %d\n",
@@ -1827,7 +1843,11 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 
 	*new_sock = sf;
 	sock_hold(sk);
-	subflow->conn = sk;
+	/*
+	 * Publish the parent. Pairs with smp_load_acquire() in
+	 * bpf_mptcp_sock_from_subflow().
+	 */
+	smp_store_release(&subflow->conn, sk);
 	mptcp_subflow_ops_override(sf->sk);
 
 	return 0;
@@ -2024,6 +2044,12 @@ static void subflow_ulp_release(struct sock *ssk)
 		if (!release && !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW,
 						  &mptcp_sk(sk)->flags))
 			mptcp_schedule_work(sk);
+
+		/*
+		 * Hide the parent from lockless readers (e.g. BPF)
+		 * before dropping the subflow-owned reference.
+		 */
+		WRITE_ONCE(ctx->conn, NULL);
 		sock_put(sk);
 	}
 
-- 
2.43.0

