Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F176359A6F
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 06:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777616384; cv=none; b=FXOquveoobLXOkyYnA/Kx34oUduhoF+QqgwcJdAFfdjFLwbxu16FBAcP5xoDUhSLwE49WCBBquPK8gYaHUbkw4KESs02BNId4xcjfeVCSOwkIWCAmDeGzODHOEpflIZ66LU4psj2SMOLWjRNzgqx+yuD7+uumbZz4z1QDBlOAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777616384; c=relaxed/simple;
	bh=gdksfWno4NRqZvRe5wW1agoNMgFD9rpiTe2Lex5rGUY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QRYVR3Htn6DdeIMtl0kO0p0dDGzLJrKovbgXC73aameiXfBMM5enoqAOMFn+FDbwP4OWOIO3WLgxVg6nU3v/QLhmK9O+u9WGOhaDzlF+UrjTXKk66Ow2qLnhyuffiDyWEL4SRQDWPXrVg7Xiib2I0YFKRcwGceVCl3NJMz0pfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffveSl+X; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffveSl+X"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24cd2e2b3so16865725ad.0
        for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 23:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777616383; x=1778221183; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wEqIbS/x+88BxBPbCEcElgpPI86CIU+0ClgeNLowLqE=;
        b=ffveSl+XmxHxpCoJMq4b40uNafDWzSHVWJHVaafMZnNBCFuspjMk0qUqDBTDEdevgX
         HrtvYQYUo/HuShPl/dMCJnJQqdsecYnW4/K0u36elW2cykcEzZ7XAwbx1tjbgI+Q/Fur
         Ygf9Y1faMZGOCDLFXJRQzMHqEGO6fTDP0cRS9fuorHBsax5JNgPWqKKLcCnLy39UMerM
         VySrzmBYjfwBT8nUnLZU52lPQU3F28pfRMIcmS8kN0MMeAa2p9tFlaXLqLHLQy3yCBlH
         sqEuwoFjXw0NJFoCDHVvSGixQ7KHfmT5vzfsD8BRDxmfcluPCRk+ru7WfX3y4N61AhRo
         301g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777616383; x=1778221183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wEqIbS/x+88BxBPbCEcElgpPI86CIU+0ClgeNLowLqE=;
        b=Uavluq8j7idO3glKnesmtUzQkcSGfQqnUhCOVhT2v+x271LrtjZTV48SFo21SxoVF8
         5Z1jnBa5nBNrBNLLB5X+iXa1saxR3gmZS7xdxmeBfqI4jteHbryoHjV3WEg8OxAg/7X7
         jjIcvPcfuNpLmKpnxAbLTNznrtJKY53Mkd9K8y5f/R1xtYJ+r+CBFMxITXmGOWlF6nzY
         yvSq2TdDcFasrW+OzZrXBxBuMfJZqEVS8p70fq5rXmlzd0UMQ9KzeR+4zC5dxpLgBLzT
         Vw0g5rsPPCd569vEBpmj5v5NLqpl5Ze9as8gLItAtLJvhopz41qMK/6N8Vp7CqR4pR49
         z9fQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ypzrWzhkUG+Nzj/kuWMwNIZTXJNXn7dmh7FdSVoAT/kXV7hjsrJ5c+6U7dC0hf4qv2GAtEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YztidB+hx0ii0EbBxXDPnSw6o8QTDk9JV0UPc/upa/EgipszJGp
	NHedM78GyIXilx2uc3hu/yjSqWzt1SImRE9DH2xGJtEa82a6MM55VQLWwJFNA//J9RPUkvVhQcR
	ub/St2A==
X-Received: from pldb13.prod.google.com ([2002:a17:902:ed0d:b0:2b0:6147:a0ee])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:124f:b0:2b2:4d36:7ba
 with SMTP id d9443c01a7336-2b9d22db5b6mr15900245ad.0.1777616382358; Thu, 30
 Apr 2026 23:19:42 -0700 (PDT)
Date: Fri,  1 May 2026 06:19:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501061939.1808489-1-kuniyu@google.com>
Subject: [PATCH v1 mptcp] mptcp: Clear mptcp_out_options.ext_copy in mptcp_established_options_dss().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Keita Morisaki <kmta1236@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, mptcp@lists.linux.dev, 
	syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported read of uninit-value in mptcp_write_data_fin().

Since the cited commit, struct mptcp_out_options is not cleared
in __tcp_transmit_skb().

Let's clear it in mptcp_established_options_dss().

Another option is to move struct mptcp_out_options to struct
tcp_out_options.cleared, but this memset() is not needed for TCP.

[0]:
BUG: KMSAN: uninit-value in mptcp_write_data_fin net/mptcp/options.c:542 [inline]
BUG: KMSAN: uninit-value in mptcp_established_options_dss net/mptcp/options.c:590 [inline]
BUG: KMSAN: uninit-value in mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
 mptcp_write_data_fin net/mptcp/options.c:542 [inline]
 mptcp_established_options_dss net/mptcp/options.c:590 [inline]
 mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
 tcp_established_options+0x312/0xcc0 net/ipv4/tcp_output.c:1192
 __tcp_transmit_skb+0x5dc/0x5fe0 net/ipv4/tcp_output.c:1575
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499
 tcp_send_ack+0x3d/0x60 net/ipv4/tcp_output.c:4505
 mptcp_subflow_shutdown+0x164/0x690 net/mptcp/protocol.c:3137
 mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
 __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
 __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
 mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
 inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
 __sock_release net/socket.c:722 [inline]
 sock_close+0xd6/0x2f0 net/socket.c:1514
 __fput+0x60e/0x1010 fs/file_table.c:510
 ____fput+0x25/0x30 fs/file_table.c:538
 task_work_run+0x208/0x2b0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 __do_fast_syscall_32+0x2c7/0x460 arch/x86/entry/syscall_32.c:310
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable opts created at:
 __tcp_transmit_skb+0x4d/0x5fe0 net/ipv4/tcp_output.c:1536
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499

CPU: 1 UID: 0 PID: 5855 Comm: syz.3.4 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026

Fixes: cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()")
Reported-by: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/mptcp/69f44505.050a0220.3cbe47.0008.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983c..3fb914196987 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -572,6 +572,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	bool ret = false;
 	u64 ack_seq;
 
+	memset(&opts->ext_copy, 0, sizeof(opts->ext_copy));
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 
-- 
2.54.0.545.g6539524ca2-goog

