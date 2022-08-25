Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD82F28
	for <mptcp@lists.linux.dev>; Thu, 25 Aug 2022 11:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661426990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bm6s2uo9XDUfWGf10OeyH0oeVw1scJ+PCU5hLq4wM9Q=;
	b=WdskQaOmpP9HxvmpE2VRQy9BJRaedzG5LYEEf5fPY7hPMJsef/y/znuYc5vUhoG/HYBlV8
	PYzFu8vS7SZBvB/EXgN/avrEdgMLIjQ7MHSVxcGrmpb2t5EIQTxn5lL2+yOHPrUvFZ4boS
	9AJzbOKzotkz+WUKTRWkPVrgobysFwc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-79fPUdDfP3C7oO4iatAo3A-1; Thu, 25 Aug 2022 07:29:49 -0400
X-MC-Unique: 79fPUdDfP3C7oO4iatAo3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CD21185A7BA
	for <mptcp@lists.linux.dev>; Thu, 25 Aug 2022 11:29:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.40.193.140])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C0502141510F
	for <mptcp@lists.linux.dev>; Thu, 25 Aug 2022 11:29:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix fwd memory accounting on coalesce
Date: Thu, 25 Aug 2022 13:29:35 +0200
Message-Id: <e07e982885b904607d42e1e45840c4eb3c124d4b.1661426770.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The intel bot reported a memory accounting related splat:

[  240.473094] ------------[ cut here ]------------
[  240.478507] page_counter underflow: -4294828518 nr_pages=4294967290
[  240.485500] WARNING: CPU: 2 PID: 14986 at mm/page_counter.c:56 page_counter_cancel+0x96/0xc0
[  240.570849] CPU: 2 PID: 14986 Comm: mptcp_connect Tainted: G S                5.19.0-rc4-00739-gd24141fe7b48 #1
[  240.581637] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  240.590600] RIP: 0010:page_counter_cancel+0x96/0xc0
[  240.596179] Code: 00 00 00 45 31 c0 48 89 ef 5d 4c 89 c6 41 5c e9 40 fd ff ff 4c 89 e2 48 c7 c7 20 73 39 84 c6 05 d5 b1 52 04 01 e8 e7 95 f3
01 <0f> 0b eb a9 48 89 ef e8 1e 25 fc ff eb c3 66 66 2e 0f 1f 84 00 00
[  240.615639] RSP: 0018:ffffc9000496f7c8 EFLAGS: 00010082
[  240.621569] RAX: 0000000000000000 RBX: ffff88819c9c0120 RCX: 0000000000000000
[  240.629404] RDX: 0000000000000027 RSI: 0000000000000004 RDI: fffff5200092deeb
[  240.637239] RBP: ffff88819c9c0120 R08: 0000000000000001 R09: ffff888366527a2b
[  240.645069] R10: ffffed106cca4f45 R11: 0000000000000001 R12: 00000000fffffffa
[  240.652903] R13: ffff888366536118 R14: 00000000fffffffa R15: ffff88819c9c0000
[  240.660738] FS:  00007f3786e72540(0000) GS:ffff888366500000(0000) knlGS:0000000000000000
[  240.669529] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  240.675974] CR2: 00007f966b346000 CR3: 0000000168cea002 CR4: 00000000003706e0
[  240.683807] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  240.691641] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  240.699468] Call Trace:
[  240.702613]  <TASK>
[  240.705413]  page_counter_uncharge+0x29/0x80
[  240.710389]  drain_stock+0xd0/0x180
[  240.714585]  refill_stock+0x278/0x580
[  240.718951]  __sk_mem_reduce_allocated+0x222/0x5c0
[  240.729248]  __mptcp_update_rmem+0x235/0x2c0
[  240.734228]  __mptcp_move_skbs+0x194/0x6c0
[  240.749764]  mptcp_recvmsg+0xdfa/0x1340
[  240.763153]  inet_recvmsg+0x37f/0x500
[  240.782109]  sock_read_iter+0x24a/0x380
[  240.805353]  new_sync_read+0x420/0x540
[  240.838552]  vfs_read+0x37f/0x4c0
[  240.842582]  ksys_read+0x170/0x200
[  240.864039]  do_syscall_64+0x5c/0x80
[  240.872770]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  240.878526] RIP: 0033:0x7f3786d9ae8e
[  240.882805] Code: c0 e9 b6 fe ff ff 50 48 8d 3d 6e 18 0a 00 e8 89 e8 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
[  240.902259] RSP: 002b:00007fff7be81e08 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  240.910533] RAX: ffffffffffffffda RBX: 0000000000002000 RCX: 00007f3786d9ae8e
[  240.918368] RDX: 0000000000002000 RSI: 00007fff7be87ec0 RDI: 0000000000000005
[  240.926206] RBP: 0000000000000005 R08: 00007f3786e6a230 R09: 00007f3786e6a240
[  240.934046] R10: fffffffffffff288 R11: 0000000000000246 R12: 0000000000002000
[  240.941884] R13: 00007fff7be87ec0 R14: 00007fff7be87ec0 R15: 0000000000002000
[  240.949741]  </TASK>
[  240.952632] irq event stamp: 27367
[  240.956735] hardirqs last  enabled at (27366): [<ffffffff81ba50ea>] mem_cgroup_uncharge_skmem+0x6a/0x80
[  240.966848] hardirqs last disabled at (27367): [<ffffffff81b8fd42>] refill_stock+0x282/0x580
[  240.976017] softirqs last  enabled at (27360): [<ffffffff83a4d8ef>] mptcp_recvmsg+0xaf/0x1340
[  240.985273] softirqs last disabled at (27364): [<ffffffff83a4d30c>] __mptcp_move_skbs+0x18c/0x6c0
[  240.994872] ---[ end trace 0000000000000000 ]---

After commit d24141fe7b48 ("mptcp: drop SK_RECLAIM_* macros"),
if rmem_fwd_alloc become negative, mptcp_rmem_uncharge() can
try to reclaim a negative amount of pages, since the expression:

	reclaimable >= PAGE_SIZE

will evaluate to true for any negative value of the int
'reclaimable': 'PAGE_SIZE' is an unsigned long and
the negative integer will be promoted to a (very large)
unsigned long value.

Still after the mentioned commit, kfree_skb_partial()
in mptcp_try_coalesce() will reclaim most of just released fwd
memory, so that following charging of the skb delta size will
lead to negative fwd memory values.

At that point a racing recvmsg() can trigger the splat.

Address the issue switching the order of the memory accounting
operations. The fwd memory can still transiently reach negative
values, but that will happen in an atomic scope and no code
path could touch/use such value.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: d24141fe7b ("mptcp: drop SK_RECLAIM_* macros")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
- Given all the above, I think we should revert/drop the 
  rx path refactor patches: not needed to address the memory
  accounting issue, and with too much problems to be solved
  in a reasonable time-frame.
- AFAICS plain TCP does not have a similar issue, as at
coalesce time the memory account operation are always performed
in the safe order.
---
 net/mptcp/protocol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 74699bd47edf..c03e3162d98d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -145,9 +145,14 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
-	kfree_skb_partial(from, fragstolen);
+
+	/* note the fwd memory can reach a negative value after accunting
+	 * for the delta, but the later skb free will restore a non
+	 * negative one
+	 */
 	atomic_add(delta, &sk->sk_rmem_alloc);
 	sk->sk_forward_alloc -= delta;
+	kfree_skb_partial(from, fragstolen);
 	return true;
 }
 
-- 
2.37.1

