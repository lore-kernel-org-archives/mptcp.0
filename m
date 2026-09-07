Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1484307AA
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776118; cv=none; b=CsS4NTScNuE0cdBBhVnIN2cqSfxzC9Ph2vB+659VDyzUR8FlZV9MRaxF5ipgvhX9ssNQRRMKS4yyCZ3O3IYD0X4YeiBHVslm3YeFGzNqbYXAXiLp98AdIX9lVvPmcVn/5jrnw+H3VuuckxT3S25k4xdoXJ2yO/B0AtgQVqfyed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776118; c=relaxed/simple;
	bh=ioB3sffTUzcUOYa7HVzkn4TdcwOrfRSXuWhbltRfhOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUTJc2djN2XhyhDD5n25Ass+cZvNLIVDJIew58WSntkW8gGftrHRXYGGKV8w8DUMzDjg/1zZNpP3mfDvvJ+EBZw58tC3KyDV9y9yfO/xjhe5c0GD4a0n0wK0DpaHNZUDbYfXQgoZGTk4b7BaIv3Ra9YzES2tbJOiuxcy7Zfg6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5796C2BCF5;
	Mon,  7 Sep 2026 10:15:17 +0000 (UTC)
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFACC79F89;
	Mon,  7 Sep 2026 10:15:17 +0000 (UTC)
From: quanyeyang@proton.me
Date: Mon, 07 Sep 2026 18:15:13 +0800
Subject: [PATCH mptcp-net v3 1/3] mptcp: fix data-race in __mptcp_retrans /
 mptcp_incoming_options
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-mptcp-snd-una-race-v3-1-65ba0d5f0221@proton.me>
References: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
In-Reply-To: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: geliang@kernel.org, matttbe@kernel.org, pabeni@redhat.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788776116; l=3739;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=agIiS5q6FGHevKPJXeJCtkoOlh0vEQhEXqOv5mqmEkw=;
 b=6T25jhW77ypek/AoHcSoUMsqIHbfp8wvgWM6cuB0HXUEJoKGffGNkVKyvMlfhZ5qBm5MRsTrT
 npNuyRDlwquD8ImAQSfdGJvaJ/NCzuq337fGAENWKnJhpRiVD0/2WUL
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: quanyeyang@proton.me
Reply-To: quanyeyang@proton.me

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

SyzKaller found this data-race:

  BUG: KCSAN: data-race in __mptcp_retrans / mptcp_incoming_options

  write (marked) to 0xffff888015e8e5f0 of 8 bytes by interrupt on cpu 0:
   __mptcp_snd_una_update net/mptcp/options.c:1055 [inline]
   mptcp_incoming_options+0x6a3/0x1ac0 net/mptcp/options.c:1183
   tcp_data_queue+0x101b/0x2440 net/ipv4/tcp_input.c:5583
   tcp_rcv_established+0x684/0x1fc0 net/ipv4/tcp_input.c:6654
   tcp_v4_do_rcv+0x35c/0x690 net/ipv4/tcp_ipv4.c:1866
   tcp_v4_rcv+0x1d91/0x25a0 net/ipv4/tcp_ipv4.c:2263
   ip_protocol_deliver_rcu+0x46/0x280 net/ipv4/ip_input.c:207
   ip_local_deliver_finish+0x190/0x270 net/ipv4/ip_input.c:241
   NF_HOOK include/linux/netfilter.h:318 [inline]
   NF_HOOK include/linux/netfilter.h:312 [inline]
   ip_local_deliver+0xe3/0x210 net/ipv4/ip_input.c:262
   dst_input include/net/dst.h:480 [inline]
   ip_rcv_finish net/ipv4/ip_input.c:492 [inline]
   NF_HOOK include/linux/netfilter.h:318 [inline]
   NF_HOOK include/linux/netfilter.h:312 [inline]
   ip_rcv+0x200/0x220 net/ipv4/ip_input.c:612
   __netif_receive_skb_one_core+0xeb/0x110 net/core/dev.c:6178
   __netif_receive_skb+0x1f/0xc0 net/core/dev.c:6291
   process_backlog+0x168/0x360 net/core/dev.c:6642
   __napi_poll+0x71/0x460 net/core/dev.c:7706
   napi_poll net/core/dev.c:7769 [inline]
   net_rx_action+0x6f8/0x810 net/core/dev.c:7926
   handle_softirqs+0xc9/0x2e0 kernel/softirq.c:622
   run_ksoftirqd kernel/softirq.c:1063 [inline]
   run_ksoftirqd+0x20/0x30 kernel/softirq.c:1055
   smpboot_thread_fn+0x287/0x520 kernel/smpboot.c:160
   kthread+0x1f2/0x240 kernel/kthread.c:436
   ret_from_fork+0x321/0x440 arch/x86/kernel/process.c:158
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

  read to 0xffff888015e8e5f0 of 8 bytes by task 24 on cpu 1:
   mptcp_rtx_head net/mptcp/protocol.h:487 [inline]
   __mptcp_retrans+0x169/0x8f0 net/mptcp/protocol.c:2759
   mptcp_worker+0x6a6/0xb30 net/mptcp/protocol.c:2980
   process_one_work+0x3ee/0x970 kernel/workqueue.c:3275
   process_scheduled_works kernel/workqueue.c:3358 [inline]
   worker_thread+0x3c3/0x730 kernel/workqueue.c:3439
   kthread+0x1f2/0x240 kernel/kthread.c:436
   ret_from_fork+0x321/0x440 arch/x86/kernel/process.c:158
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

  value changed: 0x0b17a4285ae6137d -> 0x0b17a4285b078905

It looks like msk->snd_una was being modified in __mptcp_snd_una_update
under the msk data lock (spin lock), while being accessed in
mptcp_rtx_head() under a different lock: the msk socket lock.

Annotate access to msk->snd_una in mptcp_rtx_head() to prevent such
issue.

Fixes: 64b9cea7a0af ("mptcp: fix spurious retransmissions")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 net/mptcp/protocol.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b3121c8c766b..19ad2fe2036a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -304,7 +304,9 @@ struct mptcp_sock {
 						 * protection
 						 */
 	u64		bytes_acked;
-	u64		snd_una;
+	u64		snd_una;		/* updated under the msk data lock,
+						 * lockless read
+						 */
 	u64		wnd_end;
 	u32		last_data_sent;
 	u32		last_data_recv;
@@ -488,7 +490,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (msk->snd_una == msk->snd_nxt)
+	if (READ_ONCE(msk->snd_una) == msk->snd_nxt)
 		return NULL;
 
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);

-- 
2.55.0


