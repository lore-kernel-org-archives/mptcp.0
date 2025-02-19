Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A512B73
	for <mptcp@lists.linux.dev>; Wed, 19 Feb 2025 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969136; cv=none; b=hKK0+4yBX5w0ry+ssLDzYHzBIbZTYy5lv+EvUqEOUTIdZNCBSpsMB2qNx6UgocoMjD7fs48sVlH//6+sJS1QFcgfObuh+u9R0zIlx0ShS3iziyI+PC8BpSlMjUetthuD8kzSgY1Jz0aWlFvvaeCFcukOL7iRAS+ZSaKaJsI/4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969136; c=relaxed/simple;
	bh=qj8dCSm8z0AlG2w2C8wrBTvsmS8fLAhrNDam+GcFsyk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=Dv3wDMsV5enu3+dShIdrBKC3a0bTK8wGpPFoYrSm9uoXh1xhubzkX1ZRwBwoBSmhj8wEIA7eaqbcqC11Z1Tl+Xm3nEQv8Lk5eZ7FyMmk3FHHZzkmXOZyAMK2GwXuzXCFB6w1InJPoshdu6SjzX8j5hoM37cqtxnK85ZGVX4w06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOQ68qr+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOQ68qr+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739969132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ndEH/CpohF0X2yQMfHqbZ4uXwVSGrgje4DQFbNjsnHE=;
	b=EOQ68qr+yYzxoHvlUw72sd4cA4MV2Ew0bfbJ/iYsegIXLdQJf0et3ygkEf/FpiHYnA/oUl
	uUwZTh9aiY3D5JB+6JIW5xO2lWACc6XW2VT4TyKc7+HBxYtcAjdHjNt9wHKXjSMpT7nryl
	48in6N5h4uj+qdTpNfItbKGXQPQ4YGA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-nJiX98xVPWGivIkDgYgwVw-1; Wed,
 19 Feb 2025 07:45:30 -0500
X-MC-Unique: nJiX98xVPWGivIkDgYgwVw-1
X-Mimecast-MFC-AGG-ID: nJiX98xVPWGivIkDgYgwVw_1739969130
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5614190308E
	for <mptcp@lists.linux.dev>; Wed, 19 Feb 2025 12:45:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.29])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1316C190C544
	for <mptcp@lists.linux.dev>; Wed, 19 Feb 2025 12:45:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: always handle address removal under msk socket lock
Date: Wed, 19 Feb 2025 13:45:24 +0100
Message-ID: <61cded134e753976259b48a4269f203dcae6c8fa.1739969092.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jEpE8OvzqM-6ZN-v5U1a_Hf16VEHeNHYT8zO76-piaY_1739969130
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Syzkaller reported a lockdep splat in the PM control path:

WARNING: CPU: 0 PID: 6693 at ./include/net/sock.h:1711 sock_owned_by_me include/net/sock.h:1711 [inline]
WARNING: CPU: 0 PID: 6693 at ./include/net/sock.h:1711 msk_owned_by_me net/mptcp/protocol.h:363 [inline]
WARNING: CPU: 0 PID: 6693 at ./include/net/sock.h:1711 mptcp_pm_nl_addr_send_ack+0x57c/0x610 net/mptcp/pm_netlink.c:788
Modules linked in:
CPU: 0 UID: 0 PID: 6693 Comm: syz.0.205 Not tainted 6.14.0-rc2-syzkaller-00303-gad1b832bf1cf #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:sock_owned_by_me include/net/sock.h:1711 [inline]
RIP: 0010:msk_owned_by_me net/mptcp/protocol.h:363 [inline]
RIP: 0010:mptcp_pm_nl_addr_send_ack+0x57c/0x610 net/mptcp/pm_netlink.c:788
Code: 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ca 7b d3 f5 eb b9 e8 c3 7b d3 f5 90 0f 0b 90 e9 dd fb ff ff e8 b5 7b d3 f5 90 <0f> 0b 90 e9 3e fb ff ff 44 89 f1 80 e1 07 38 c1 0f 8c eb fb ff ff
RSP: 0000:ffffc900034f6f60 EFLAGS: 00010283
RAX: ffffffff8bee3c2b RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc90004d42000 RSI: 000000000000a407 RDI: 000000000000a408
RBP: ffffc900034f7030 R08: ffffffff8bee37f6 R09: 0100000000000000
R10: dffffc0000000000 R11: ffffed100bcc62e4 R12: ffff88805e6316e0
R13: ffff88805e630c00 R14: dffffc0000000000 R15: ffff88805e630c00
FS:  00007f7e9a7e96c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fd18ff8 CR3: 0000000032c24000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mptcp_pm_remove_addr+0x103/0x1d0 net/mptcp/pm.c:59
 mptcp_pm_remove_anno_addr+0x1f4/0x2f0 net/mptcp/pm_netlink.c:1486
 mptcp_nl_remove_subflow_and_signal_addr net/mptcp/pm_netlink.c:1518 [inline]
 mptcp_pm_nl_del_addr_doit+0x118d/0x1af0 net/mptcp/pm_netlink.c:1629
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb1f/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2543
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:733
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2573
 ___sys_sendmsg net/socket.c:2627 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7e9998cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7e9a7e9038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7e99ba5fa0 RCX: 00007f7e9998cde9
RDX: 000000002000c094 RSI: 0000400000000000 RDI: 0000000000000007
RBP: 00007f7e99a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f7e99ba5fa0 R15: 00007fff49231088

Indeed the PM can try to send a RM_ADDR over a msk without acquiring
first the msk socket lock.

The bugged code-path comes from an early optimization: when there
are no subflows, the PM should (usually) not send RM_ADDR
notifications.

The above statement is incorrect, as without locks another process
could concurrent create a new subflow and cause the RM_ADDR generation.

Additionally the supposed optimization is not very effective even
performance-wise, as most mptcp sockets should have at least one
subflow: the MPC one.

Address the issue removing the buggy code path, the existing "slow-path"
will handle correctly even the edge case.

Reported-by: syzbot+cd3ce3d03a3393ae9700@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/546
Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 572d160edca3..c0e47f4f7b1a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1514,11 +1514,6 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		if (mptcp_pm_is_userspace(msk))
 			goto next;
 
-		if (list_empty(&msk->conn_list)) {
-			mptcp_pm_remove_anno_addr(msk, addr, false);
-			goto next;
-		}
-
 		lock_sock(sk);
 		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
-- 
2.48.1

