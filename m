Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507E7485
	for <mptcp@lists.linux.dev>; Sat, 18 Jan 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737222408; cv=none; b=E4KOtrSvQfwSwAb1xFl6Y+sTb8IrWoy6xY39f1MUA0wSJ38xmlN+UBd/NRJEb5yzeZlXm4sHX0H5l5z2XRmrd2I4vDE6aDwGLeeIYSCVrh57mNvr8XbTEE3POi1Q/TtSCpr5Gj475EQGvjBEZD6Im7TzmEyZlRpHnmHYRJhiuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737222408; c=relaxed/simple;
	bh=CbmzaxZfmCQlIcMTAiAb2GXepYRakrLAqPkQikapGP0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=nZOH3lI857yL1Be/5PjM+omdy6Ky/Fn0Cvm5geVxj6eHfuJBj36o1y7uRw795OW+Fm5nkcl8jrjWO2VeoduUw1rHSqPvxEyKG7a60YPND9t5QTKR63hpP+ZOgsBwjLc2Ri0GpaET2onmBcHzgmH6m8uLR7PRJLvz6SCccRgYQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdK4Fvbc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdK4Fvbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737222404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oh3pAI9ARMvHqzUGaH+ZXkkX3IvStgOlRAMmhTHmhlo=;
	b=cdK4FvbcEf1XxbKRUlF7F4RlFJdrh50mZWyNagNfatkC8tdxfBDKL/1xB3TuY1oU8J5PPI
	WrYYWPVEGhO0cv92Ef6Ql0mSb8daUcr20fNS2UVordsgq544btZ+wyRQwubdsydBotd7gp
	DKgQ9ADmqNVHF21XcI/WpDMnBsrJqJ8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-7JcGFC7WPOmqdjd5n6Hrpg-1; Sat,
 18 Jan 2025 12:46:43 -0500
X-MC-Unique: 7JcGFC7WPOmqdjd5n6Hrpg-1
X-Mimecast-MFC-AGG-ID: 7JcGFC7WPOmqdjd5n6Hrpg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5292C19560AB
	for <mptcp@lists.linux.dev>; Sat, 18 Jan 2025 17:46:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85129195608A
	for <mptcp@lists.linux.dev>; Sat, 18 Jan 2025 17:46:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: handle fastopen disconnect correctly
Date: Sat, 18 Jan 2025 18:46:31 +0100
Message-ID: <e8371ec8065e09317dcf7d7aabc6c54e63634bbb.1737222305.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FklP7s2nG4hezVQQzMf3dYhzmebFJwQOpMKe-ufxH6A_1737222402
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Syzbot was able to trigger a data stream corruption:

WARNING: CPU: 0 PID: 9846 at net/mptcp/protocol.c:1024 __mptcp_clean_una+0xddb/0xff0 net/mptcp/protocol.c:1024
Modules linked in:
CPU: 0 UID: 0 PID: 9846 Comm: syz-executor351 Not tainted 6.13.0-rc2-syzkaller-00059-g00a5acdbf398 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__mptcp_clean_una+0xddb/0xff0 net/mptcp/protocol.c:1024
Code: fa ff ff 48 8b 4c 24 18 80 e1 07 fe c1 38 c1 0f 8c 8e fa ff ff 48 8b 7c 24 18 e8 e0 db 54 f6 e9 7f fa ff ff e8 e6 80 ee f5 90 <0f> 0b 90 4c 8b 6c 24 40 4d 89 f4 e9 04 f5 ff ff 44 89 f1 80 e1 07
RSP: 0018:ffffc9000c0cf400 EFLAGS: 00010293
RAX: ffffffff8bb0dd5a RBX: ffff888033f5d230 RCX: ffff888059ce8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000c0cf518 R08: ffffffff8bb0d1dd R09: 1ffff110170c8928
R10: dffffc0000000000 R11: ffffed10170c8929 R12: 0000000000000000
R13: ffff888033f5d220 R14: dffffc0000000000 R15: ffff8880592b8000
FS:  00007f6e866496c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6e86f491a0 CR3: 00000000310e6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mptcp_clean_una_wakeup+0x7f/0x2d0 net/mptcp/protocol.c:1074
 mptcp_release_cb+0x7cb/0xb30 net/mptcp/protocol.c:3493
 release_sock+0x1aa/0x1f0 net/core/sock.c:3640
 inet_wait_for_connect net/ipv4/af_inet.c:609 [inline]
 __inet_stream_connect+0x8bd/0xf30 net/ipv4/af_inet.c:703
 mptcp_sendmsg_fastopen+0x2a2/0x530 net/mptcp/protocol.c:1755
 mptcp_sendmsg+0x1884/0x1b10 net/mptcp/protocol.c:1830
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x1a6/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e86ebfe69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6e86649168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f6e86f491b8 RCX: 00007f6e86ebfe69
RDX: 0000000030004001 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f6e86f491b0 R08: 00007f6e866496c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6e86f491bc
R13: 000000000000006e R14: 00007ffe445d9420 R15: 00007ffe445d9508
 </TASK>

The root cause is the bad handling of disconnect() generated
internally by the MPTCP protocol in case of connect FASTOPEN
errors.

Address the issue increasing the socket disconnect counter even
on such a case, to allow other threads waiting on the same socket
lock to properly error out.

Reported-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/537
Fixes: c2b2ae3925b6 ("mptcp: handle correctly disconnect() failures")
Tested-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1b2e7cbb577f..f910e840aa8f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1767,8 +1767,10 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 		 * see mptcp_disconnect().
 		 * Attempt it again outside the problematic scope.
 		 */
-		if (!mptcp_disconnect(sk, 0))
+		if (!mptcp_disconnect(sk, 0)) {
+			sk->sk_disconnects++;
 			sk->sk_socket->state = SS_UNCONNECTED;
+		}
 	}
 	inet_clear_bit(DEFER_CONNECT, sk);
 
-- 
2.47.1

