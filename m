Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256382;
	b=ao7lm4NzOYZS+/hepunsWvotKxhT3qyk4o0YsxbAu4DhoEBARqhr3Fx46o1PCcssOKXo
	 cYUg8Qy8NKPrYaNiMbD7nPBuxRt+LN8oPILe2hlixIRPoUMYBhpOKs9JQnnCPoTRjLPd8
	 wh37E6OzirEYrdoyMteimQN3R9qEyzxmCk/d0hKoval18UMiLaXfLXYXW2Ir5ky9ZdA8G
	 oULjS42me4ole0S9mm3T6MY5xPQuuCADPad+yrD9H4oIY94P9TQh2+EB7Gt0Udf0MQYRk
	 4KEHI0h4QHVaCgbSgTzm7gQteNTlbXSCbzeOUz9Bh60liZ75g7+XNVg9ZzGi/Ob0z8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pYWSeNyiA0knZcASPM8Si5EX2vlAu5pmAZ4wmX3c4Zo=;
	b=0as9SCPFBj5FfEzb2/ohYCRfzciaqIpSKdhMhc0SZsiv7E0XmUcz1wxfaArlaaT4IKRi
	 3WC9kPmM6mDETW1MpGOm0JB6zGS8WidZEkyQ9ghOuVMtEky56/xMKFKMaHiRUH/2F7hjk
	 moiLHX5mTgbnFMxGQRGz2N0PyWeI9Fiw9uToPx+lfhVigW7kr0bV0eIxcNeDQ7woKZbWT
	 SKAX8yw/QuGYFZ2Hi9/RttxyeUgIYQ0mfdRK+nLi55YzLSB78TNFpzTrlE670Omj3sADp
	 i/QR2YJcz8Vi8X9ceNp79mdDJ6SMqJ56g++T5ztrRwNjlK3Jw/H09j4oioBhYk5YS5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A1TaLi8V;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E2606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 06:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 217E2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A1TaLi8V
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd3310348d2so180979a12.1
        for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 23:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793256381; x=1793861181; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYWSeNyiA0knZcASPM8Si5EX2vlAu5pmAZ4wmX3c4Zo=;
        b=A1TaLi8VrnplMhX/TH4gx64sxsE5RqlppbgE4IYbk0DYzWoI2j84CB49gg9Ml/DgV0
         lEowo2BFE4olGa9PFQN2O/AfBXsv20doKDb560EnENlVDWhUv7gnXfGx7ibOdbFhtWDq
         XWeRgmenZYTdS7Y34WmsU0w5S1PklKp5MKGdyEv7k2/yaeKNT4lr+dDj7+SbLaN6TnkA
         FPCztTQbzfR+Kz+xnVw6QluTimzPKeyszcUr6VCm53BDUwXx3LbOejE9v95KLAd/+yWj
         30NHlcvUVfJqT/wAhYeX2rKEzpXVPlo22hdexonhzTKYXzmoEOI4WVsVKSLTU/e6iDmf
         hojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793256381; x=1793861181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYWSeNyiA0knZcASPM8Si5EX2vlAu5pmAZ4wmX3c4Zo=;
        b=mXDgdbbJ+F13ml8PyAOWuc4/9uqDMDdq5gaZYQS35bjl3wggdmMDXmsdczlBnfH72r
         AJESYUtCwAiFe2wNy6H1SDhIY77CihYS3xyvl7I6yw0xaEkKfd2D+9KjzbnuSo/p399Q
         OraB3RACxtMJV72ZN+SR4NOMoziFgE/uIbpCeWJObABc8nHTWHJYciNcZnQ9PgZvV05p
         wq5CwHacPFXYKBXXtYZzYAYHF+T6XPeCrqvrcEDeC42+xyUzLmK14ICvipEpqTxVZyf4
         M9Iuqf5bBdpwQ4vRzaHaa90k1hLsiRgPJ4ttbUsd2vzd/Rv6swRblwOqOioTMOG+LvcV
         z2ng==
X-Forwarded-Encrypted: i=1; AKwUvBww4BmTvR7pU6HkhH1ykv+vCS0iHA+I5ljEdaDYZZVVWpcr7gjYXpeRRwYYXCu0B8UNn+BPMQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKlcMHUGskveltg7+dHzi753n3gQs9X/svQZKeDjw1SQgVSX8eu
	JNU/E8VDOxXPmQiLOEcsyjk8/3ATIfxCqf+6oHaGB2tZ2pgs8V6DVEVA
X-Gm-Gg: AYBFou1KwdHb+WQxosSHCcBNSMNFWlhnsGjf23d8j+AOEjbV9JwRCi9CWc5yJW3+kmm
	w3W9M34Xo7+SGYvXel5iQx9dVEImFuiRQk8i5qS3EDUeIwOrPGi2OTRRU066xHQDw4jA2Qa8gq4
	ubQQhx5ObvOM8tINTJ5+u/rEWQXv1zrh2JVM6I2UhJk7NCdnKMogtA5two9xSZ7NagAJXOR7B0g
	h8n51xwbr+fDCWMmoS/VsB/Y+WPjYpa3L5su93ydLxPFTDuFC1R0HIUtspIsx48lNVl9Jort/w3
	LE9onSUl4XoaRSA2W/d98dPiILmWzDm3oV+sTujKsMq0dLydKageKTKvdoO+o99YOlmXRY44XrP
	0zQObGBsvV+w+97RklZdskV5WJr2UPcYBKa7McYjnGsjYOKooTu3aRT88IJRbjZr/I+XC6K7WqG
	JRthqmBzURCPWZ5h+vHjGC9wPeiUkT3d4hcD5B9M5o384Cno5uYrEGFW/Ugt6nMBlEYOzAKxGBx
	Bw8dPZIE2SPzH71/ZGHRuIGZCNU/1fFK+fh7E6ZYaOGwkE54qNZkMpISsueHr5+UUaJD8ebGxir
	Ka9Dr0u8mfAX9MGwl44ANUxU
X-Received: by 2002:a17:90b:4b0b:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3ae6ecde884mr966447a91.8.1793256381151;
        Wed, 28 Oct 2026 23:46:21 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98f888sm2700767a91.13.2026.10.28.23.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:46:20 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org
Cc: geliang@kernel.org,
	mptcp@lists.linux.dev,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH mptcp-net v2] mptcp: free delegated subflow contexts only after they are dequeued
Date: Thu, 29 Oct 2026 14:46:13 +0800
Message-Id: <pm-mptcp-objects-candidate-0010-v4-f64139fe98063730da45@gmail.com>
X-Mailer: git-send-email 2.34.1
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

mptcp_subflow_delegate() links the subflow context into a per-CPU list
and pins only the TCP subflow socket with sock_hold(). The context is
freed independently of that reference, with kfree_rcu(), by
subflow_ulp_release() when inet_csk_destroy_sock() tears the ULP down,
by __mptcp_close_ssk() for a context whose ULP release ran earlier, and
by mptcp_subflow_drop_ctx() when a subflow falls back to plain TCP.
None of them checks whether delegated_node is still linked.

When mptcp_napi_poll() dequeues the entry on the scheduling CPU only
after that RCU grace period has elapsed, for example because the poll
returned at its budget or runs from ksoftirqd, it unlinks the node from
freed memory, as the first report below shows:

  TCP / NAPI                   Close                     RCU
  enqueue ctx, sock_hold(ssk)
  return at budget
                               __mptcp_close_ssk()
                                 ctx->disposable = 1
                                 __tcp_close()
                                   tcp_cleanup_ulp()
                                     kfree_rcu(ctx)
                                                         reclaim ctx
  dequeue ctx->delegated_node

Retire the context at these three places instead: set a new RETIRED bit
in delegated_status and free the context only if no action is
scheduled; otherwise mptcp_napi_poll() frees it once it has dequeued
the entry. Both sides use atomic read-modify-write operations on the
same word, so exactly one of them frees the context.

The poll must not process a subflow whose ULP is gone either. The ULP
release has dropped the reference on the MPTCP socket, which may be
freed and reused before the poll takes its data lock, as the second
report shows. Skip such a subflow. The ops pointer is cleared with the
socket owned or under its bh lock, so a racing read lands in the owned
branch, which only dequeues the entry; both paths free a context that
was retired while queued.

mptcp_subflow_ctx_reset() cleared delegated_status with the rest of the
reset group on disconnect, wiping the scheduled bit of an entry that
may still be queued. Move the field out of the group and only drop the
pending actions there.

The reports below were decoded with scripts/decode_stacktrace.sh
against the 7.2.0-rc5 based test kernels that produced them, rebuilt
from the same source and configuration, with the line numbers mapped to
this tree; only the relevant frames are kept. The second one was taken
with KASAN poisoning forced for the SLAB_TYPESAFE_BY_RCU MPTCP socket
cache; without it, the poll locks and updates whatever socket reuses
that memory.

  BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report (lib/list_debug.c:65)
  Read of size 8 at addr ffff8881271668c8 by task kworker/0:9/1315

  Call Trace:
   <IRQ>
   __list_del_entry_valid_or_report (lib/list_debug.c:65)
   mptcp_napi_poll (include/linux/list.h:140 include/linux/list.h:261 include/linux/list.h:333 net/mptcp/protocol.h:806 net/mptcp/protocol.c:4794)
   __napi_poll.constprop.0 (net/core/dev.c:7958)
   net_rx_action (net/core/dev.c:8021 net/core/dev.c:8178)
   handle_softirqs (kernel/softirq.c:669)
   </IRQ>
   <TASK>
   __local_bh_enable_ip (kernel/softirq.c:473)
   __mptcp_close_ssk (net/mptcp/protocol.c:2656)
   mptcp_close_ssk (net/mptcp/protocol.c:2767 net/mptcp/protocol.c:2750)
   mptcp_worker (net/mptcp/protocol.c:2796 net/mptcp/protocol.c:3145)
   </TASK>

  Allocated by task 1308:
   subflow_create_ctx (include/linux/slab.h:991 include/linux/slab.h:1312 net/mptcp/subflow.c:1893)
   subflow_ulp_init (net/mptcp/subflow.c:2032)
   tcp_set_ulp (net/ipv4/tcp_ulp.c:150 net/ipv4/tcp_ulp.c:171)
   mptcp_subflow_create_socket (net/mptcp/subflow.c:1854)
   __mptcp_subflow_connect (net/mptcp/subflow.c:1677)
   mptcp_pm_create_subflow_or_signal_addr (net/mptcp/pm_kernel.c:424)
   mptcp_pm_nl_add_addr_doit (net/mptcp/pm_kernel.c:982 net/mptcp/pm_kernel.c:1048)

  Freed by task 29:
   __rcu_free_sheaf_prepare (include/linux/kasan.h:235 mm/slub.c:2748 mm/slub.c:3009)
   rcu_free_sheaf (mm/slub.c:6061)
   rcu_core (kernel/rcu/tree.c:2650 kernel/rcu/tree.c:2919)

  The buggy address belongs to the object at ffff888127166800
   which belongs to the cache kmalloc-512 of size 512

  BUG: KASAN: slab-use-after-free in _raw_spin_lock_bh (include/linux/spinlock_api_smp.h:182 kernel/locking/spinlock.c:205)
  Read of size 1 at addr ffff88810acf25d8 by task ksoftirqd/2/29

  Call Trace:
   <TASK>
   _raw_spin_lock_bh (include/linux/spinlock_api_smp.h:182 kernel/locking/spinlock.c:205)
   mptcp_subflow_process_delegated (include/linux/spinlock.h:353 net/mptcp/protocol.c:3936)
   mptcp_napi_poll (net/mptcp/protocol.c:4799)
   __napi_poll.constprop.0 (net/core/dev.c:7958)
   net_rx_action (net/core/dev.c:8021 net/core/dev.c:8178)
   handle_softirqs (kernel/softirq.c:669)
   run_ksoftirqd (kernel/softirq.c:1133 kernel/softirq.c:1125)
   </TASK>

  Allocated by task 586:
   sk_alloc (net/core/sock.c:2337)
   inet_create (net/ipv4/af_inet.c:333 net/ipv4/af_inet.c:259)
   __sock_create (net/socket.c:1679)
   __sys_socket (net/socket.c:1737 net/socket.c:1774 net/socket.c:1821)

  Freed by task 586:
   __sk_destruct (net/core/sock.c:2318 net/core/sock.c:2420)
   sk_destruct (net/core/sock.c:2448)
   __sk_free (net/core/sock.c:2459)
   sk_free (net/core/sock.c:2470)
   mptcp_close (include/net/sock.h:2024 net/mptcp/protocol.c:3545)
   inet_release (net/ipv4/af_inet.c:442)
   __sock_release (net/socket.c:735)

  The buggy address belongs to the object at ffff88810acf2400
   which belongs to the cache MPTCP of size 2944

Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM
---
Changes in v2:
- Retire the context at all three places that free it and let
  mptcp_napi_poll() free a queued one, instead of chaining the socket
  destructor: a closing listener can still be cloned by a handshake that
  passed its state check before the close, and the clone would inherit the
  overridden destructor.
- Free a retired context in the owned branch of mptcp_napi_poll() too:
  mptcp_subflow_drop_ctx() runs with the subflow owned but not bh-locked, so
  the poll can read the ULP ops before they are cleared and take that branch
  (Sashiko review).
- Keep delegated_status out of the reset group, so that a disconnect no
  longer clears the scheduled bit of an entry that is still queued (Sashiko
  review).
- Drop patch 2: the skip in mptcp_napi_poll() already covers the delegated
  action it described, and the BPF case only reads stale fields of an MPTCP
  socket from a SLAB_TYPESAFE_BY_RCU cache within an RCU read-side section,
  as bpf_skc_to_mptcp_sock() always could.
- Decode the stack traces, map the line numbers to the export-net branch of
  mptcp_net-next and send to the MPTCP list only.

Link to v1: https://lore.kernel.org/r/pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-0@gmail.com

 net/mptcp/protocol.c | 20 +++++++++++++++++---
 net/mptcp/protocol.h | 20 ++++++++++++++++++--
 net/mptcp/subflow.c  |  4 ++--
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4335eb8f9f2d..bb535d6cb2e7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2707,7 +2707,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 */
 	if (!inet_csk(ssk)->icsk_ulp_ops) {
 		WARN_ON_ONCE(!sock_flag(ssk, SOCK_DEAD));
-		kfree_rcu(subflow, rcu);
+		mptcp_subflow_ctx_retire(subflow);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
 		__tcp_close(ssk, 0);
@@ -4795,7 +4795,18 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		bh_lock_sock_nested(ssk);
-		if (!sock_owned_by_user(ssk)) {
+		if (unlikely(!READ_ONCE(inet_csk(ssk)->icsk_ulp_ops))) {
+			/* The ULP is gone, released or fallen back to plain
+			 * TCP: there is nothing left to process, and the msk
+			 * may be gone too. The ops are cleared with the socket
+			 * owned or under its bh lock, so a racing read lands
+			 * in the owned branch below. Both free a context that
+			 * was retired while queued.
+			 */
+			if (xchg(&subflow->delegated_status, 0) &
+			    BIT(MPTCP_DELEGATE_RETIRED))
+				kfree_rcu(subflow, rcu);
+		} else if (!sock_owned_by_user(ssk)) {
 			mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_status, 0));
 		} else {
 			/* tcp_release_cb_override already processed
@@ -4804,7 +4815,10 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 			 * CPU that scheduled it.
 			 */
 			smp_wmb();
-			clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status);
+			if (set_mask_bits(&subflow->delegated_status,
+					  BIT(MPTCP_DELEGATE_SCHEDULED), 0) &
+			    BIT(MPTCP_DELEGATE_RETIRED))
+				kfree_rcu(subflow, rcu);
 		}
 		bh_unlock_sock(ssk);
 		sock_put(ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 011e73d04ee6..26ae5425ef37 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -553,8 +553,10 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 #define MPTCP_DELEGATE_SEND		1
 #define MPTCP_DELEGATE_ACK		2
 #define MPTCP_DELEGATE_SNDBUF		3
+#define MPTCP_DELEGATE_RETIRED		4	/* the ULP is gone, NAPI frees the ctx */
 
-#define MPTCP_DELEGATE_ACTIONS_MASK	(~BIT(MPTCP_DELEGATE_SCHEDULED))
+#define MPTCP_DELEGATE_ACTIONS_MASK	(~(BIT(MPTCP_DELEGATE_SCHEDULED) | \
+					   BIT(MPTCP_DELEGATE_RETIRED)))
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
@@ -628,11 +630,11 @@ struct mptcp_subflow_context {
 
 	u32	subflow_id;
 
-	long	delegated_status;
 	unsigned long	fail_tout;
 
 	);
 
+	long	delegated_status;	    /* not reset, the ctx may still be queued */
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
 
 	u32	setsockopt_seq;
@@ -671,6 +673,8 @@ mptcp_subflow_ctx_reset(struct mptcp_subflow_context *subflow)
 	memset(&subflow->reset, 0, sizeof(subflow->reset));
 	subflow->request_mptcp = 1;
 	WRITE_ONCE(subflow->local_id, -1);
+	/* a queued delegated action stays queued, only its payload goes */
+	set_mask_bits(&subflow->delegated_status, MPTCP_DELEGATE_ACTIONS_MASK, 0);
 }
 
 /* Convert reset reasons in MPTCP to enum sk_rst_reason type */
@@ -791,6 +795,18 @@ static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *subflow,
 	}
 }
 
+/* Retire a subflow context whose ULP is gone: free it, unless a delegated
+ * action is still queued for it, in which case mptcp_napi_poll() frees it
+ * once the entry is dequeued.
+ */
+static inline void mptcp_subflow_ctx_retire(struct mptcp_subflow_context *subflow)
+{
+	if (!(set_mask_bits(&subflow->delegated_status, 0,
+			    BIT(MPTCP_DELEGATE_RETIRED)) &
+	      BIT(MPTCP_DELEGATE_SCHEDULED)))
+		kfree_rcu(subflow, rcu);
+}
+
 static inline struct mptcp_subflow_context *
 mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 78e886b20258..ddf7424c46b6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -828,7 +828,7 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 			sock_put(ctx->conn);
 	}
 
-	kfree_rcu(ctx, rcu);
+	mptcp_subflow_ctx_retire(ctx);
 }
 
 void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
@@ -2087,7 +2087,7 @@ static void subflow_ulp_release(struct sock *ssk)
 
 	mptcp_subflow_ops_undo_override(ssk);
 	if (release)
-		kfree_rcu(ctx, rcu);
+		mptcp_subflow_ctx_retire(ctx);
 }
 
 static void subflow_ulp_clone(const struct request_sock *req,
-- 
2.43.0

