Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64BF3F7867
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782478279; cv=pass; b=UXeJPs4T7VKlwfHYCXhX9NBYfWRCz2nrLWdkGDDyC3442ON8Q1Qy5nrkSg03gl8y0XF3Q0Rl1fzW9jwi2yytmTbgvYXxMRj4eowPSL+kYLmu47vVf4gASofNvm52VlbmpZJzkzI3bvHNHKvhVTor3lVdztFxkBcjUYdJa3e6bVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782478279; c=relaxed/simple;
	bh=LGPX2Fkuo1v0XdziTW6KBucTzCQMl8S3iAcR3tjlGbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXgXWBDkHbdxOIS+McguUMqyZ+u307sJK5DravNFSWT3HiVMgUyBq65Rq4pH/JPheWAcsByAiUB6Vz7ZRp83HXXGwjoI+OigpJow8WNrK2mrlVv6Ts/ppGaBXOPUdJJO/k9bf912eJjrnLBOKzxqXrCm3CFXmgWuwICqz1ilS3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=LUrf6BHb reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="LUrf6BHb"
ARC-Seal: i=1; a=rsa-sha256; t=1782478272; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BSNCK3xdyfm72h3bLvWE2XG+OB83XL+GB85Mbg0jrNwqNkT0eitQx4zesYUez1ouu1w4BpjxUGNSwR8ojiXWxAHauY+nUvP7P38MJIZGkeVbFItUVuWIxMh96FHcAEmJ8e3X08dccN1eRnuj9ube7MIG940Q+TPxxlMm6dp8vvU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782478272; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QeKQWmjEtJHvNNFBUy8w/ZgDziTFzFw8Ob5/jDo9BVU=; 
	b=TLy1dJZ5AaJiEl91Iki6UJr53khZg6m+SUJyyfgeRO2T0Q+I+qQZgIGwPZizTY56d8vSteBHjUEFdFdpN0Ewm11sjqjWS0NQWh8E4U4pDomjkVZmJIc4GU6EJgPWau0nm1ethV9mGQu2U1FEHMmIPDjyqXWzh6xoBkpcwrLOp1c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782478272;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QeKQWmjEtJHvNNFBUy8w/ZgDziTFzFw8Ob5/jDo9BVU=;
	b=LUrf6BHbnGaJN8TE++EfCzvkSh5gXsECvVwOMZivPP0PfbwNoqxUsiKc27XqEDgR
	/rTo2RSTa22VbLwaL7lNGcIFp/QbNgAmHrIs/4CfUp3gvmpxO6SewsY4EgMO8+ioEqt
	yogaXILI8QOC/3nk63uWpUpOCQzn2lJfuro48+6A=
Received: by mx.zohomail.com with SMTPS id 1782478269910424.5467883130053;
	Fri, 26 Jun 2026 05:51:09 -0700 (PDT)
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
Subject: [PATCH mptcp-net v2] mptcp: bpf: fix NULL deref and UAF in bpf_mptcp_sock_from_subflow()
Date: Fri, 26 Jun 2026 18:20:58 +0530
Message-ID: <20260626125058.868855-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

bpf_mptcp_sock_from_subflow() is reachable from BPF programs via
bpf_skc_to_mptcp_sock() on an arbitrary socket, without the subflow
socket lock held. It assumes sk_is_mptcp(sk) implies a valid subflow
context whose ->conn points to a live parent mptcp_sock. That invariant
does not hold in three windows:

- Fallback: subflow_ulp_fallback() clears icsk_ulp_data via
  rcu_assign_pointer(..., NULL) before clearing tcp_sk(sk)->is_mptcp, so a
  concurrent reader can observe is_mptcp == 1 with a NULL context and
  dereference mptcp_subflow_ctx(sk)->conn through a NULL pointer.

- Init: subflow_ulp_init() sets is_mptcp = 1 while ->conn is still NULL;
  ->conn is only assigned later in subflow_syn_recv_sock() or
  mptcp_subflow_create_socket(). On CONFIG_DEBUG_NET, mptcp_sk()
  dereferences its argument in a WARN_ON(), so mptcp_sk(NULL) faults.

- Teardown: subflow_ulp_release() drops the subflow-owned parent
  reference with sock_put(ctx->conn) without clearing ctx->conn. The
  established parent msk is not SOCK_RCU_FREE (mptcp_sk_clone_init()
  resets the flag), so it is freed synchronously and a lockless reader can
  dereference a dangling ->conn: a use-after-free.

icsk_ulp_data is an __rcu pointer and this helper can run locklessly, so
load the context with rcu_dereference_check() (lockdep_sock_is_held()
covers the locked struct_ops callers), load ->conn once with READ_ONCE(),
pair the ->conn stores with WRITE_ONCE(), reject a NULL context or NULL
->conn, and clear ->conn before dropping the parent reference.

A NULL check alone cannot fix the teardown case: a reader may load a
non-NULL ->conn just before it is cleared and dereference the parent
after sock_put() has freed it. Give the parent msk RCU-grace lifetime by
setting SOCK_RCU_FREE in the shared __mptcp_init_sock(), covering both the
active and passive paths, and dropping the reset in mptcp_sk_clone_init().
Non-sleepable BPF runs in an RCU read-side critical section, so a reader
that obtains the msk is then guaranteed it stays allocated for the
program's duration.

That lifetime guarantee relies on classic RCU, which does not hold off RCU
Tasks Trace, so it does not extend to sleepable programs. Unlike the other
bpf_skc_to_*() casts, which return the same object as the trusted input
sk, this helper returns a different object, so stop exposing it to
sleepable programs in tracing_prog_func_proto().

Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/622
Assisted-by: Claude:claude-opus-4.8.
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Changes in v2:
- Lockless access fixes (Li Xiasong): load the subflow context with
  rcu_dereference_check() instead of a plain dereference, and read ->conn
  once with READ_ONCE().
- Fix the teardown use-after-free that v1 did not address: clear ->conn
  before dropping the parent reference in subflow_ulp_release(), and give
  the parent msk RCU-grace lifetime via SOCK_RCU_FREE so a lockless reader
  cannot dereference a freed parent.
- Stop exposing the helper to sleepable BPF programs, where classic RCU
  gives no lifetime guarantee.

v1: https://lore.kernel.org/all/20260612072643.2313900-1-kalpan.jani@mpiricsoftware.com/
  

 kernel/trace/bpf_trace.c |  2 +-
 net/mptcp/bpf.c          | 14 ++++++++++++--
 net/mptcp/protocol.c     |  6 +++++-
 net/mptcp/subflow.c      |  9 +++++++--
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a02bd258677e..ea489edbecec 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1715,7 +1715,7 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_skc_to_unix_sock:
 		return &bpf_skc_to_unix_sock_proto;
 	case BPF_FUNC_skc_to_mptcp_sock:
-		return &bpf_skc_to_mptcp_sock_proto;
+		return prog->sleepable ? NULL : &bpf_skc_to_mptcp_sock_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_tracing_proto;
 	case BPF_FUNC_sk_storage_delete:
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 08bb037f0951..138e6a145135 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -193,8 +193,18 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 {
-	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
-		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+	struct mptcp_subflow_context *ctx;
+	struct sock *conn;
+
+	if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk)) {
+		ctx = rcu_dereference_check(inet_csk(sk)->icsk_ulp_data,
+					    lockdep_sock_is_held(sk));
+		if (ctx) {
+			conn = READ_ONCE(ctx->conn);
+			if (conn)
+				return mptcp_sk(conn);
+		}
+	}
 
 	return NULL;
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a4f7e99b30db..fa85ad0dc5a8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3177,6 +3177,11 @@ static void __mptcp_init_sock(struct sock *sk)
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
@@ -3712,7 +3717,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	/* passive msk is created after the first/MPC subflow */
 	msk->subflow_id = 2;
 
-	sock_reset_flag(nsk, SOCK_RCU_FREE);
 	security_inet_csk_clone(nsk, req);
 
 	/* this can't race with mptcp_close(), as the msk is
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb9..8eefd64dcf7d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -920,7 +920,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
-			ctx->conn = (struct sock *)owner;
+			WRITE_ONCE(ctx->conn, (struct sock *)owner);
 
 			if (subflow_use_different_sport(owner, sk)) {
 				pr_debug("ack inet_sport=%d %d\n",
@@ -1827,7 +1827,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 
 	*new_sock = sf;
 	sock_hold(sk);
-	subflow->conn = sk;
+	WRITE_ONCE(subflow->conn, sk);
 	mptcp_subflow_ops_override(sf->sk);
 
 	return 0;
@@ -2024,6 +2024,11 @@ static void subflow_ulp_release(struct sock *ssk)
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

