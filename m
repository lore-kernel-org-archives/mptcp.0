Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB1288B1
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730239; cv=pass; b=KTCIIiY+I5BXBp5V971V2YgZ/lAt/wl2hEsKY7U3hCZvn6iOiLZCSxC7TjXU1BF/QGJIhSCaRbmzFbqXC6Iz585mTTivHrtm9U2DVTpDjHvA9L37s48GA/piZf3no9GdAbRTWpyw6I9mTYNM9ZEGDr8rcJdj7XcFmiYf9nqsyUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730239; c=relaxed/simple;
	bh=z8ZqBaTUh9KHqiqJcs8bU6j+lVJfW4vjOY3cbvBuOOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKyvmB6qgXFy2afW7WHz5dOA3ctfacUHyOmHD+C+7h2VqQDHlCGl1IU5ooj6yDZvm1QyB32g6ElHvuI5Yw+Yz/s1IvMCbCF/m7GSNPty9JAIoVr18Jo7Cl5JUMPT31Kt94Mkuz53scKbVIPadvKES79Osmo9+6w7uduQCImEbUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=Z80jHptE reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="Z80jHptE"
ARC-Seal: i=1; a=rsa-sha256; t=1782730232; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aD/osCDo71WFQ2gybG9vdMCzNwR7xmsQmy5UxIrWseKR60hd2/nrqZq7+k3Odt0CNn8uwpSxacrHgQOw4Lwk4b3SRq0QHY50BsKsXDXXdjT4hE2AhaDJ0SAAndvlXf10yXa8qS01ZSty0O2//FJqM/AzDihYp+t0aBLFWRgGGjg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782730232; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+4dWuiPeb7ok0G06f3DVfAaEV6dWiC7PT84fM6cdTgI=; 
	b=NtcZtKc0F/yYU8voXNXz3FlGBjFWWiN61TJVlbz3w3vAc0zAMzkISLutL5DqoFFo8GFXTRDuFm144JNhSShwoUGdnzEtmoyGRiIKA3jiIyIXFXZakd+hu7tgVpT4+KB7EJqNEZCAaeYpUP0QnVtZZLwGqOvrgxvlRxsiRSuLXCI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782730232;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+4dWuiPeb7ok0G06f3DVfAaEV6dWiC7PT84fM6cdTgI=;
	b=Z80jHptEU1vBSo78tMGlemQiDxoB0mSC7TfjJfgfQ70TZnS378FmeExvAsgY1WPg
	ay+bCX2Uz+AqzvdPX/Y9VuX7b5x/M2wSIy2ID7iwvbnGVLG4HXXObRIlbTdGlmb/tfB
	oEBxMSThJ8176sGjIQnrR7fPUV7oIzuLidK2RJjQ=
Received: by mx.zohomail.com with SMTPS id 1782730229646910.2016716662766;
	Mon, 29 Jun 2026 03:50:29 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	shardulsb08@gmail.com,
	akshit@mpiricsoftware.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-net v3] mptcp: bpf: fix NULL deref and UAF in bpf_mptcp_sock_from_subflow()
Date: Mon, 29 Jun 2026 16:20:20 +0530
Message-ID: <20260629105020.1670781-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

bpf_mptcp_sock_from_subflow() is reachable from tracing BPF programs via
bpf_skc_to_mptcp_sock() on an arbitrary socket, without the subflow
socket lock held. It assumes sk_is_mptcp(sk) implies a valid subflow
context whose ->conn points to a live parent mptcp_sock. That invariant
does not hold in several windows:

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

Non-sleepable BPF runs in an RCU read-side critical section, so a reader
that obtains the msk is guaranteed it stays allocated for the program's
duration. That relies on classic RCU and does not hold off RCU Tasks
Trace, so it does not extend to sleepable programs. Unlike the other
bpf_skc_to_*() casts, which return the same object as the input sk, this
helper returns a different object, so stop exposing it to sleepable
programs in tracing_prog_func_proto().

Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/622
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
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

 kernel/trace/bpf_trace.c |  2 +-
 net/mptcp/bpf.c          | 14 ++++++++++++--
 net/mptcp/protocol.c     |  6 +++++-
 net/mptcp/subflow.c      | 25 ++++++++++++++++++-------
 4 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 82f8feea6931..dcb25a8a4496 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1746,7 +1746,7 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skc_to_unix_sock:
 		return &bpf_skc_to_unix_sock_proto;
 	case BPF_FUNC_skc_to_mptcp_sock:
-		return &bpf_skc_to_mptcp_sock_proto;
+		return prog->sleepable ? NULL : &bpf_skc_to_mptcp_sock_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_tracing_proto;
 	case BPF_FUNC_sk_storage_delete:
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0845061ddc65..ec5d75a30519 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -193,8 +193,20 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
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
+			/* pairs with smp_store_release() when ->conn is
+			 * published in subflow_syn_recv_sock()
+			 */
+			conn = smp_load_acquire(&ctx->conn);
+			if (conn)
+				return mptcp_sk(conn);
+		}
+	}
 
 	return NULL;
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ffcf5a1788f6..4c713fc4e3a9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3182,6 +3182,11 @@ static void __mptcp_init_sock(struct sock *sk)
 	mptcp_pm_data_init(msk);
 	spin_lock_init(&msk->fallback_lock);
 
+	/* the returned parent msk may be handed to lockless readers
+	 * (bpf_skc_to_mptcp_sock()); free it after an RCU grace period
+	 */
+	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&sk->mptcp_retransmit_timer, mptcp_retransmit_timer, 0);
 	timer_setup(&msk->sk.mptcp_tout_timer, mptcp_tout_timer, 0);
@@ -3717,7 +3722,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	/* passive msk is created after the first/MPC subflow */
 	msk->subflow_id = 2;
 
-	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	security_inet_csk_clone(nsk, req);
 
 	/* this can't race with mptcp_close(), as the msk is
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb9..19e0b19c112b 100644
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
@@ -880,12 +885,16 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
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
+			/* publish the fully initialised parent; pairs with
+			 * smp_load_acquire() in bpf_mptcp_sock_from_subflow()
+			 */
+			smp_store_release(&ctx->conn, conn);
 
 			if (mp_opt.deny_join_id0)
 				WRITE_ONCE(owner->pm.remote_deny_join_id0, true);
@@ -920,7 +926,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
-			ctx->conn = (struct sock *)owner;
+			WRITE_ONCE(ctx->conn, (struct sock *)owner);
 
 			if (subflow_use_different_sport(owner, sk)) {
 				pr_debug("ack inet_sport=%d %d\n",
@@ -1827,7 +1833,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 
 	*new_sock = sf;
 	sock_hold(sk);
-	subflow->conn = sk;
+	WRITE_ONCE(subflow->conn, sk);
 	mptcp_subflow_ops_override(sf->sk);
 
 	return 0;
@@ -2024,6 +2030,11 @@ static void subflow_ulp_release(struct sock *ssk)
 		if (!release && !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW,
 						  &mptcp_sk(sk)->flags))
 			mptcp_schedule_work(sk);
+
+		/* hide the parent from lockless readers (e.g. BPF) before
+		 * dropping the subflow-owned reference
+		 */
+		WRITE_ONCE(ctx->conn, NULL);
 		sock_put(sk);
 	}
 
-- 
2.43.0

