Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2B7FBB6
	for <mptcp@lists.linux.dev>; Mon,  6 May 2024 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003493; cv=none; b=hhy3OCcOKqlUL8bVAEJdg2P8ggBQyECHAQEcZ3e5Ald9CzZ8q6fxnmrWSCBtURHLEHbk/h6JhUa0ADxT0ZvyJl3d6AuB4gzB2bThFBiMz4sn/Jk+EkpL9/9gBySbxgvkyX2ER+oYT5I/UsIc4kGCsox085/GFZ3580M7munUgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003493; c=relaxed/simple;
	bh=+WV694D1Xchf3rGhMjINKZTlEqm4gqzaZvYWlDXZTnw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bEaPABzd9LubBa3a4+CTD5FLs/V9KwpuUUhiBb7215e59QGUhSHGBbSl+hRfMutSGEO5/dM4ahES0oKj5/l0esxQa9H2gKigU6i6vKsntmVFoRSh8VYkdjrXe8ErxqO1VF734SFmu+ziudAaSnEolTNig1jZVTPDF64x7Vk/8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juudZnPf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juudZnPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A81C116B1
	for <mptcp@lists.linux.dev>; Mon,  6 May 2024 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715003493;
	bh=+WV694D1Xchf3rGhMjINKZTlEqm4gqzaZvYWlDXZTnw=;
	h=From:To:Subject:Date:From;
	b=juudZnPfNCF4e2S0EuSwa+HrnSythESnhmCK0PrjSy/PKG31Seh3erI5kmubvxA88
	 Vt5e/B49qwqYGJmQLKS734e7G64YzhTSIYBLKTmdiux9oCYMqWURtr50mTX0FCgAzH
	 0fB/ubL8qW2cmQ4wrwdkcx/Qem1G2ofF3gt0lZpP2fe/AoozHjeQuOWNvQrzKTcWSl
	 dHjwnyncF3tNb7K8kZ34jitZVq1m7USSNj0egnMQMzEObIB9L+vh5I6D/rf6nGwesR
	 5CgmzVVNeNtRw+HUAEXlvQQwxMDfkpC1zdnl3+PDHL/4BY74KyRcyQLJupcIvHH/0C
	 5hRcxzLiUpmlg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH] mptcp: fix possible NULL dereferences
Date: Mon,  6 May 2024 15:51:30 +0200
Message-ID: <20240506135129.3528973-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5373; i=matttbe@kernel.org; h=from:subject; bh=YtDgKo3HDIp70ee3/1IDtNC02n8tkfRYaO6SLO46E+0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmOOBhlHnqGoUGG5vX2pMQhfrpsQu8EstIh0wSA 5jjhCmmt6KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjjgYQAKCRD2t4JPQmmg czD2D/9ccGlPPmiCjph6PB6DBF6/5jH/P1j4jng1/5RCXPfnRqfjkiwLaaXu796pyFyGzvuuFV/ YvmZbhXoHY0ddW3uD/Pnkj/dhXL8IOWagw0sSAq/BGW9TXX93yVQfmn7m6cP+CXqZ5XdJ2UYo0v /TYXzBV+c2VFYeBhUB9Brwig1qoNMv2Ac3kK4fVQJBMXJJxuYswtjA4IVMPVYjJcsVz0GNcUJMg Ioauudlya+vEg6sspA9cPKleJ4vNYWkbyx1JnGnFlkIh9BcbwSxuYbdhcAwhI36VvYrDRPkOCs/ VcJkJzWH3d8EQlObY32uPIA8HR8DF/mJVvP8mkpI0+LtsAfJ9zxthsDwDmXI9598SsEn3ktdwqD R+1IzKsvIBWSD2ktckdC9uYoRxD4uXZ6Juk+0VeT+fEkndhmKHlLg6R1pZrvuflzV3ogb0uJ7vx YssxzdyOEWfFQjTFh25WixWmM0HveWgeHmYOrWwx4koyeLYwl+T6VDky/BLI9mEni+DpmG8rw22 yD/ENiNHy4cLqecfYGKaXVgJS2FbdzIgpJt/j24EHNZ1Ydu4zdsFpJG4KF8OmCYQp82lj9cy80i Q4P6z7ALoihgQN63ke4tTMslQXDUDrAjB1XxbJEjEhbVX3Ew300PQlXmUI0B2MtpCKQTUz/x10k XiWsawmhFL1LMLA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

subflow_add_reset_reason(skb, ...) can fail.

We can not assume mptcp_get_ext(skb) always return a non NULL pointer.

syzbot reported:

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 5098 Comm: syz-executor132 Not tainted 6.9.0-rc6-syzkaller-01478-gcdc74c9d06e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 RIP: 0010:subflow_v6_route_req+0x2c7/0x490 net/mptcp/subflow.c:388
Code: 8d 7b 07 48 89 f8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 c0 01 00 00 0f b6 43 07 48 8d 1c c3 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 84 01 00 00 0f b6 5b 01 83 e3 0f 48 89
RSP: 0018:ffffc9000362eb68 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff888022039e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88807d961140 R08: ffffffff8b6cb76b R09: 1ffff1100fb2c230
R10: dffffc0000000000 R11: ffffed100fb2c231 R12: dffffc0000000000
R13: ffff888022bfe273 R14: ffff88802cf9cc80 R15: ffff88802ad5a700
FS:  0000555587ad2380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f420c3f9720 CR3: 0000000022bfc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  tcp_conn_request+0xf07/0x32c0 net/ipv4/tcp_input.c:7180
  tcp_rcv_state_process+0x183c/0x4500 net/ipv4/tcp_input.c:6663
  tcp_v6_do_rcv+0x8b2/0x1310 net/ipv6/tcp_ipv6.c:1673
  tcp_v6_rcv+0x22b4/0x30b0 net/ipv6/tcp_ipv6.c:1910
  ip6_protocol_deliver_rcu+0xc76/0x1570 net/ipv6/ip6_input.c:438
  ip6_input_finish+0x186/0x2d0 net/ipv6/ip6_input.c:483
  NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
  NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
  __netif_receive_skb_one_core net/core/dev.c:5625 [inline]
  __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5739
  netif_receive_skb_internal net/core/dev.c:5825 [inline]
  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5885
  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1549
  tun_get_user+0x2f35/0x4560 drivers/net/tun.c:2002
  tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
  call_write_iter include/linux/fs.h:2110 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0xa84/0xcb0 fs/read_write.c:590
  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 3e140491dd80 ("mptcp: support rstreason for passive reset")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kernelxing@tencent.com>
Cc: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240506123032.3351895-1-edumazet@google.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7987342f4526..422aa06da93b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -287,6 +287,16 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 }
 EXPORT_SYMBOL_GPL(mptcp_subflow_init_cookie_req);
 
+static enum sk_rst_reason mptcp_get_rst_reason(const struct sk_buff *skb)
+{
+	const struct mptcp_ext *mpext = mptcp_get_ext(skb);
+
+	if (!mpext)
+		return SK_RST_REASON_NOT_SPECIFIED;
+
+	return sk_rst_convert_mptcp_reason(mpext->reset_reason);
+}
+
 static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 					      struct sk_buff *skb,
 					      struct flowi *fl,
@@ -308,13 +318,9 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie) {
-		struct mptcp_ext *mpext = mptcp_get_ext(skb);
-		enum sk_rst_reason reason;
-
-		reason = sk_rst_convert_mptcp_reason(mpext->reset_reason);
-		tcp_request_sock_ops.send_reset(sk, skb, reason);
-	}
+	if (!req->syncookie)
+		tcp_request_sock_ops.send_reset(sk, skb,
+						mptcp_get_rst_reason(skb));
 	return NULL;
 }
 
@@ -381,13 +387,9 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie) {
-		struct mptcp_ext *mpext = mptcp_get_ext(skb);
-		enum sk_rst_reason reason;
-
-		reason = sk_rst_convert_mptcp_reason(mpext->reset_reason);
-		tcp6_request_sock_ops.send_reset(sk, skb, reason);
-	}
+	if (!req->syncookie)
+		tcp6_request_sock_ops.send_reset(sk, skb,
+						 mptcp_get_rst_reason(skb));
 	return NULL;
 }
 #endif
@@ -923,7 +925,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	tcp_rsk(req)->drop_req = true;
 	inet_csk_prepare_for_destroy_sock(child);
 	tcp_done(child);
-	reason = sk_rst_convert_mptcp_reason(mptcp_get_ext(skb)->reset_reason);
+	reason = mptcp_get_rst_reason(skb);
 	req->rsk_ops->send_reset(sk, skb, reason);
 
 	/* The last child reference will be released by the caller */
-- 
2.43.0

