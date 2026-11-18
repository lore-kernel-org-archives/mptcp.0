Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794991246;
	b=5DbPTQXk5OwExBtPSHRm42hn4/c+9L58mnDRTxDJHi1kh3CcYhSjyNhtMmRGUBjpzwU3
	 QcRS6/E/X+mupRlh7v7upVzutIm2MjEWXr+b0UWfAGIZKmp3WeVmhB+M7WEuZyMuylt6z
	 7iwU4P9kawD8Jwms23G8T+I8kvqbNLZnJnws3fj23Ohxa0QLsBOOwVhx+Y67rJY0hpFn4
	 RC2e1zuMdjsW0kIQCWbNRGQ1Af65SkoJFe0vjpZSCcFWM62cB+KYsMPvUDAmRM9raqtrs
	 Qx58cZDUAVSPzS3lTqnLHborjWvn9BtEIK2JsevoNPtB+9OIuz9TqyWYpwxx2SCgibQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991246;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=s5cJnsrEzzdlbSxFju6IRvP26HdQ6O9fjGCJZzj1LE0=;
	b=nAos6+jJVNY/I08TvMXU/3BYn1eSg0lRmGQMK6WK9jLa6LkOYW5K8lfgP8xxVS66Qp/n
	 MUiPjh+0/yosOxdJycaMCjJlzhZHxumpxAE+7o/6qcnEP1J/xrPfOho/ylYNT3DrTLQDr
	 lk7somirIhgnXM0NCrG8fKg7ZnwX3iQwm7rjd1pvSLc88vxLeMOEdW4aSgT8a9kC+pjYC
	 xL68WnHKEj0y/SuTbF5EfEyU2ETm9LDNtS1F3kpv5PhFicOdSeEBZ0PkZQyPXBjV27qWf
	 pHyfthNwuc97dcS41itjK3ho884+u/zuhNpHx/Vm/ajv9E41tSW2X5orVYOQEQzXHDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6E606A891
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 08:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EA6E606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1794991239; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F9+xCfg1yEgs/z41wbVS1hzSq8T0CvNLbfD/SI5E3UA4hHu3EmZKMYbaSZfPNFNU/Yhii8Y1GOD5BY8YSP59oLIaeq0c8teb+13j+zf8vVopZyBf0zpq2In93+gVotlLQkS9Hwyq4mqOpbYMhNr1ZqkXvWZEtUlzzcHnXMhlwRs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794991239; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=s5cJnsrEzzdlbSxFju6IRvP26HdQ6O9fjGCJZzj1LE0=; 
	b=YRztVvn4nrYjXQyumUhBj8RglNv+/i9Yct7zNTCRcjItFh4HeCQM5kah1t6NU68uHwGlJF6Nu8gWoONZzDhUC2totREyPMPMz18Np/0eSWOly0M9F6PM/xZ43TehFqrB988ppuWI+DiFq5AwttlP0m/EDla1oBITjFmy6dn18iM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=LfyjKrYPuLQouQc6ktG0SIC3CFjqLc3tRxvXVWurXCdeIO9LGhufdNwGdJV4/wu1xIaSlScQGUcHNwFOKxHmjGSa14iSzsmMyyhji8BPBkPMnzJarycQ5qBizV5etaNn+NA5v/erOUd3u7qkQjjPcrmFUAtPlV/y/39EQMWx7Qc=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=s5cJnsrEzzdlbSxFju6IRvP26HdQ6O9fjGCJZzj1LE0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794991237528592.5153872044795;
	Wed, 18 Nov 2026 00:40:37 -0800 (PST)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-next v6] mptcp: bpf: fix NULL deref and UAF in bpf_mptcp_sock_from_subflow()
Date: Wed, 18 Nov 2026 14:10:11 +0530
Message-ID: <20261118084011.4051683-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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
  concurrent reader can observe is_mptcp == 1 with a NULL context.

- Init: subflow_ulp_init() sets is_mptcp = 1 while ->conn is still NULL;
  ->conn is only assigned later in subflow_syn_recv_sock() or
  mptcp_subflow_create_socket(). On CONFIG_DEBUG_NET, mptcp_sk()
  dereferences its argument in a WARN_ON(), so mptcp_sk(NULL) faults.

- Teardown: subflow_ulp_release() drops the subflow-owned parent
  reference without clearing ->conn. A lockless reader can therefore
  access a parent socket after its reference has been dropped.

Load the context with rcu_dereference_check() and the parent socket
with smp_load_acquire(). Publish ->conn with smp_store_release() in
the MP_CAPABLE, MP_JOIN and outgoing subflow paths. Clear ->conn
with a release store before dropping the subflow-owned reference.

Give the parent msk RCU-grace lifetime by setting SOCK_RCU_FREE in
the shared __mptcp_init_sock(), covering both active and passive
paths, and dropping the reset in mptcp_sk_clone_init(). This ensures
a reader that obtains the parent under the applicable RCU protection
does not access freed memory.

Keep bpf_skc_to_mptcp_sock() available to non-sleepable tracing
programs for compatibility, while rejecting sleepable tracing
programs because classic RCU does not protect the parent socket
through sleepable execution.

Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/622
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Changes since v5:
- Use rcu_dereference_check() to safely access the subflow context.
- Use smp_load_acquire() and smp_store_release() to synchronize access to ctx->conn.
- Clear ctx->conn before dropping the subflow-owned parent socket reference.
- Set SOCK_RCU_FREE in __mptcp_init_sock() to cover both active and passive MPTCP sockets.
- Remove the SOCK_RCU_FREE reset from mptcp_sk_clone_init().
- Reject sleepable tracing programs from using bpf_skc_to_mptcp_sock(), while retaining support for non-sleepable tracing programs.

v5: https://lore.kernel.org/all/20260915093506.465110-1-kalpan.jani@mpiricsoftware.com/
---
 kernel/trace/bpf_trace.c |  2 +-
 net/mptcp/bpf.c          | 15 +++++++++++++--
 net/mptcp/protocol.c     |  6 +++++-
 net/mptcp/subflow.c      | 29 ++++++++++++++++++++++-------
 4 files changed, 41 insertions(+), 11 deletions(-)

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
index 08bb037f0951..f43f9a2acc3f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -193,8 +193,19 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
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
+			/* Pair with release stores publishing or clearing ctx->conn. */
+			conn = smp_load_acquire(&ctx->conn);
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
index 8e386899ceb9..a7612bae675f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -780,6 +780,7 @@ static void subflow_ulp_fallback(struct sock *sk,
 void mptcp_subflow_drop_ctx(struct sock *ssk)
 {
 	struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(ssk);
+	struct sock *conn;
 
 	if (!ctx)
 		return;
@@ -787,8 +788,12 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 	list_del(&mptcp_subflow_ctx(ssk)->node);
 	if (inet_csk(ssk)->icsk_ulp_ops) {
 		subflow_ulp_fallback(ssk, ctx);
-		if (ctx->conn)
-			sock_put(ctx->conn);
+		conn = ctx->conn;
+		if (conn) {
+			/* Clear the pointer before dropping its reference. */
+			smp_store_release(&ctx->conn, NULL);
+			sock_put(conn);
+		}
 	}
 
 	kfree_rcu(ctx, rcu);
@@ -861,6 +866,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 	if (child && *own_req) {
 		struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(child);
+		struct sock *conn;
 
 		tcp_rsk(req)->drop_req = false;
 
@@ -880,12 +886,14 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		ctx->setsockopt_seq = listener->setsockopt_seq;
 
 		if (ctx->mp_capable) {
-			ctx->conn = mptcp_sk_clone_init(listener->conn, &mp_opt, child, req);
-			if (!ctx->conn)
+			conn = mptcp_sk_clone_init(listener->conn, &mp_opt, child, req);
+			if (!conn)
 				goto fallback;
 
+			/* Publish the initialized parent socket to lockless readers. */
+			smp_store_release(&ctx->conn, conn);
 			ctx->subflow_id = 1;
-			owner = mptcp_sk(ctx->conn);
+			owner = mptcp_sk(conn);
 
 			if (mp_opt.deny_join_id0)
 				WRITE_ONCE(owner->pm.remote_deny_join_id0, true);
@@ -920,7 +928,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
-			ctx->conn = (struct sock *)owner;
+			/* Publish the parent socket to lockless readers. */
+			smp_store_release(&ctx->conn, (struct sock *)owner);
 
 			if (subflow_use_different_sport(owner, sk)) {
 				pr_debug("ack inet_sport=%d %d\n",
@@ -1827,7 +1836,8 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 
 	*new_sock = sf;
 	sock_hold(sk);
-	subflow->conn = sk;
+	/* Publish the parent socket after taking its reference. */
+	smp_store_release(&subflow->conn, sk);
 	mptcp_subflow_ops_override(sf->sk);
 
 	return 0;
@@ -2024,6 +2034,11 @@ static void subflow_ulp_release(struct sock *ssk)
 		if (!release && !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW,
 						  &mptcp_sk(sk)->flags))
 			mptcp_schedule_work(sk);
+
+		/* hide the parent from lockless readers (e.g. BPF) before
+		 * dropping the subflow-owned reference
+		 */
+		smp_store_release(&ctx->conn, NULL);
 		sock_put(sk);
 	}
 
-- 
2.43.0

