Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5D168BC
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uzez25EE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699376331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EffrR3DjMUv68JTaYrke9emq9oQjv+87RebdJLkoSlM=;
	b=Uzez25EEuE2b5z8azjRbvXObRp/vPItLXQabBWyX8ZqKzIhbxS90TZSk+2jOdDijuGXS8n
	p4kjSkKQ1ZJl+UgO6yHT7j7QMwr1wkVEH3hT83V0HtoKr94zoydfMVFxO1iXZBbW+Krt1D
	aZ+VcEN+7ZLIKhtVvF+bak8PoQofZjg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-EayLNmY_OC2Qc9uTp-gAeA-1; Tue,
 07 Nov 2023 11:58:40 -0500
X-MC-Unique: EayLNmY_OC2Qc9uTp-gAeA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFED3299E753;
	Tue,  7 Nov 2023 16:58:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A06BA492BFE;
	Tue,  7 Nov 2023 16:58:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Eric Dumazet <edumazet@google.com>
Subject: [PATCH mptcp-net v2] mptcp: fix possible NULL pointer dereference on close
Date: Tue,  7 Nov 2023 17:58:27 +0100
Message-ID: <c872b639f2c3c9b6b20ec46d3a109bde6ab7b5f5.1699376301.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

After the blamed commit below, the MPTCP release callback can
dereference the first subflow pointer via __mptcp_set_connected()
and send buffer auto-tuning. Such pointer is always expected to be
valid, except at socket destruction time, when the first subflow is
deleted and the pointer zeroed.

If the connect event is handled by the release callback while the
msk socket is finally released, MPTCP hits the following splat:

general protection fault, probably for non-canonical address 0xdffffc00000000f2: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000790-0x0000000000000797]
CPU: 1 PID: 26719 Comm: syz-executor.2 Not tainted 6.6.0-syzkaller-10102-gff269e2cd5ad #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:mptcp_subflow_ctx net/mptcp/protocol.h:542 [inline]
RIP: 0010:__mptcp_propagate_sndbuf net/mptcp/protocol.h:813 [inline]
RIP: 0010:__mptcp_set_connected+0x57/0x3e0 net/mptcp/subflow.c:424
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8a62323c
RDX: 00000000000000f2 RSI: ffffffff8a630116 RDI: 0000000000000790
RBP: ffff88803334b100 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000034 R12: ffff88803334b198
R13: ffff888054f0b018 R14: 0000000000000000 R15: ffff88803334b100
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbcb4f75198 CR3: 000000006afb5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mptcp_release_cb+0xa2c/0xc40 net/mptcp/protocol.c:3405
 release_sock+0xba/0x1f0 net/core/sock.c:3537
 mptcp_close+0x32/0xf0 net/mptcp/protocol.c:3084
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:485
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1419
 __fput+0x270/0xbb0 fs/file_table.c:394
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2a20 kernel/exit.c:876
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1026
 get_signal+0x23ba/0x2790 kernel/signal.c:2900
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4b/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fb515e7cae9
Code: Unable to access opcode bytes at 0x7fb515e7cabf.
RSP: 002b:00007fb516c560c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: 000000000000003c RBX: 00007fb515f9c120 RCX: 00007fb515e7cae9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000006
RBP: 00007fb515ec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fb515f9c120 R15: 00007ffc631eb968
 </TASK>

To avoid sparkling unneeded conditionals, address the issue explicitly
checking msk->first only in the critical place.

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Reported-by: syzbot+9dfbaedb6e6baca57a32@syzkaller.appspotmail.com
Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/454
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2: reword the changelog, to be hopefully more descriptive (Mat)
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0ad507ac6bc7..52985670a206 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3398,10 +3398,11 @@ static void mptcp_release_cb(struct sock *sk)
 	if (__test_and_clear_bit(MPTCP_CLEAN_UNA, &msk->cb_flags))
 		__mptcp_clean_una_wakeup(sk);
 	if (unlikely(msk->cb_flags)) {
-		/* be sure to set the current sk state before tacking actions
-		 * depending on sk_state, that is processing MPTCP_ERROR_REPORT
+		/* be sure to set the current sk state before taking actions
+		 * depending on sk_state (MPTCP_ERROR_REPORT)
+		 * On sk release avoid actions depending on the first subflow
 		 */
-		if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags))
+		if (__test_and_clear_bit(MPTCP_CONNECTED, &msk->cb_flags) && msk->first)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-- 
2.41.0

