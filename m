Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18221FA3
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 11:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669202599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jbiMF4OnAhMMqNPcwfFJwMKJUob3Qe0pNA+BjIVF+Kk=;
	b=gbexfvaVZBYZOGzo67CfhnZ38NTUp9lk0nftQfRx761jt7QLg1sDkrhvApUYq/GuxxC+Gr
	D+5TovCqQk9doFHfPVcKc9QxFlcINv6p0i3oH+2FHZyBfz3nlobJqp8ncStvMjTvJDo4MM
	4DmnrlxMkyhpOwAW81js5hy9b37qo6c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-CCYsl793PY6cLeG5Ai7rEw-1; Wed, 23 Nov 2022 06:23:16 -0500
X-MC-Unique: CCYsl793PY6cLeG5Ai7rEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F6993C0F237;
	Wed, 23 Nov 2022 11:23:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.190])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 546CD4EA4A;
	Wed, 23 Nov 2022 11:23:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Jiang Biao <benbjiang@tencent.com>,
	Mengen Sun <mengensun@tencent.com>
Subject: [PATCH mptcp-net] mptcp: fix sleep in atomic at close time
Date: Wed, 23 Nov 2022 12:23:05 +0100
Message-Id: <feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Mat reported a splat at msk close time:

BUG: sleeping function called from invalid context at net/mptcp/protocol.c:2877
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 155, name: packetdrill
preempt_count: 201, expected: 0
RCU nest depth: 0, expected: 0
4 locks held by packetdrill/155:
#0: ffff888001536990 (&sb->s_type->i_mutex_key#6){+.+.}-{3:3}, at: __sock_release (net/socket.c:650)
#1: ffff88800b498130 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close (net/mptcp/protocol.c:2973)
#2: ffff88800b49a130 (sk_lock-AF_INET/1){+.+.}-{0:0}, at: __mptcp_close_ssk (net/mptcp/protocol.c:2363)
#3: ffff88800b49a0b0 (slock-AF_INET){+...}-{2:2}, at: __lock_sock_fast (include/net/sock.h:1820)
Preemption disabled at:
0x0
CPU: 1 PID: 155 Comm: packetdrill Not tainted 6.1.0-rc5 #365
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
__might_resched.cold (kernel/sched/core.c:9891)
__mptcp_destroy_sock (include/linux/kernel.h:110)
__mptcp_close (net/mptcp/protocol.c:2959)
mptcp_subflow_queue_clean (include/net/sock.h:1777)
__mptcp_close_ssk (net/mptcp/protocol.c:2363)
mptcp_destroy_common (net/mptcp/protocol.c:3170)
mptcp_destroy (include/net/sock.h:1495)
__mptcp_destroy_sock (net/mptcp/protocol.c:2886)
__mptcp_close (net/mptcp/protocol.c:2959)
mptcp_close (net/mptcp/protocol.c:2974)
inet_release (net/ipv4/af_inet.c:432)
__sock_release (net/socket.c:651)
sock_close (net/socket.c:1367)
__fput (fs/file_table.c:320)
task_work_run (kernel/task_work.c:181 (discriminator 1))
exit_to_user_mode_prepare (include/linux/resume_user_mode.h:49)
syscall_exit_to_user_mode (kernel/entry/common.c:130)
do_syscall_64 (arch/x86/entry/common.c:87)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

We can't acquire call mptcp_close under the 'fast' socket lock veriant,
replace it with a sock_lock_nested() as the relevant code is already
under the listening msk socket lock protection.

Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Closes: Matthieu Baerts <matthieu.baerts@tessares.net>
Fixes: 30e51b923e43 ("mptcp: fix unreleased socket in accept queue")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 05099b3760b5..602cb2fe5148 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1802,16 +1802,16 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
 
 	for (msk = head; msk; msk = next) {
 		struct sock *sk = (struct sock *)msk;
-		bool slow, do_cancel_work;
+		bool do_cancel_work;
 
 		sock_hold(sk);
-		slow = lock_sock_fast_nested(sk);
+		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 		next = msk->dl_next;
 		msk->first = NULL;
 		msk->dl_next = NULL;
 
 		do_cancel_work = __mptcp_close(sk, 0);
-		unlock_sock_fast(sk, slow);
+		release_sock(sk);
 		if (do_cancel_work)
 			mptcp_cancel_work(sk);
 		sock_put(sk);
-- 
2.38.1

