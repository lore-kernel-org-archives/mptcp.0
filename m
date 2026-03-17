Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1733F361
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744733; cv=none; b=KVn51pxctX75rwLr1zRSfsF98W1nGwi8mEu786IOLk5+ZCuA6wU4ApRtsFcffkRPUelLIUUsfPYZziKs/qOapRGPIcsFkMZsaJO2KrZ7FN1/ALuslG+Tst/ThPZQC2ajGEE9kDJnbENqY8n+PX+iZtLmjEsfEuXZ2MmWqFacUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744733; c=relaxed/simple;
	bh=KxKEtJC9Qo12p1jKqM/nMfhSCEIlogweQ6xCsZTGLdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qUJnIHQIUTlPcGWTgvskBpeq6PH8N4bPmjyM2mAAqo+yCFkQNbWGYnWjAc6z+Tid3aiVo5R5XGx/gbzN9jGocRjAyY5kaIQKXd4MIBFaK4oz8kFa5xM60iJo/Qs2AqDHzVVHDQJ0Hyh9WoRqNsgsY/PDpa2pilnJbPw232aEC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV3B7ehh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV3B7ehh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E37C4CEF7;
	Tue, 17 Mar 2026 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773744732;
	bh=KxKEtJC9Qo12p1jKqM/nMfhSCEIlogweQ6xCsZTGLdk=;
	h=From:Date:Subject:To:Cc:From;
	b=VV3B7ehhdRXgUMC6zHaQVZoVVdEH3Ad1Zz4Fk1/bgQ0WqSv4j9x+2UVEEAwNda3Lq
	 sKmyT96H7ZBbdweQQN93v6dzbPg++tfyl/NUYZt7g5OXAB0tndhqdTtXICAoSiVzbI
	 V+wEByJ8IBVUp09DfApzjiPnJUy8pnlMo2ceL79gaDPBqXx9QGf/Vr8C2kdPjcY2Bi
	 fmM03xYqlU4j4UGeCXjupoZaYFxqomZeo/O1s266tTCgmAwMaZF5jDCtdD30JFYLTv
	 HsspehTUT1sNA2Ggrk6h6+QgAr44skhCDa3STPdAEourmzdWL44Yd7sGSWqclXvNP2
	 0uDRoCsnFJKMw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 17 Mar 2026 11:52:03 +0100
Subject: [PATCH mptcp-net v2] mptcp: fix data-race in __mptcp_retrans /
 mptcp_incoming_options
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mptcp-data-race-snd_una-v2-1-2caac60de92a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNUQ6CMBBEr0L22zV0waJ+eQ9DTCkrNEoh20o0h
 Lvb4AH8nMy8NwsEFscBztkCwrMLbvQp0C4D2xvfMbo2ZaCcdF4ojcMU7YStiQbFWMbg29vLG9R
 Nw6UqTg3RERI9Cd/dezNf4Qd5jlCnqnchjvLZPme1Df7qZ4UKiVSVlwciq6vLg8Xzcz9KB/W6r
 l9eeFJJygAAAA==
X-Change-ID: 20260316-mptcp-data-race-snd_una-6bbe4139b228
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4054; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KxKEtJC9Qo12p1jKqM/nMfhSCEIlogweQ6xCsZTGLdk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ3GkXfmy9lcrFM48R6n0PrHXI+q1S9ktW8UmBi0Hx1p
 Rv/admGjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInsimRkmFhWeHnzcpPPuTPd
 H0csuX52zwTR17cfae+dWarjbpysk83wz5bn1fUHXolupwS4toT09KcXP10aKlNXdELGTUH8vaw
 /BwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

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
---
- Link to v1: https://lore.kernel.org/r/20260316-mptcp-data-race-snd_una-v1-1-221704522c67@kernel.org
---
v2:
 - mention under which locks the field is being updated and read (Paolo)
 - add comment where snd_una is defined to help future changes (Paolo)
---
 net/mptcp/protocol.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f5d4d7d030f2..9ff23c858077 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -300,7 +300,7 @@ struct mptcp_sock {
 						 * protection
 						 */
 	u64		bytes_acked;
-	u64		snd_una;
+	u64		snd_una;		/* updated under the msk data lock, lockless read */
 	u64		wnd_end;
 	u32		last_data_sent;
 	u32		last_data_recv;
@@ -484,7 +484,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (msk->snd_una == msk->snd_nxt)
+	if (READ_ONCE(msk->snd_una) == msk->snd_nxt)
 		return NULL;
 
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);

---
base-commit: 767b686e12d42196211fe3efef07310ae2ce382a
change-id: 20260316-mptcp-data-race-snd_una-6bbe4139b228

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

