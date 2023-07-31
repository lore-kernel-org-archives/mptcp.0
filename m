Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0844A12
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 22:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690842370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uanG8LCAtreVe7g5BE8jXcpugOwMEqpRqDNL6UwvZZA=;
	b=MQs7gmoGd7W4Ac7nJi3TFmEOukGFlEyVqspqR66nHVep2gpVm4lv9p1DUJVvjN4CJF0NFj
	d1BL5BfUVQrHj111JUT6Q6G47MMfp+Mxq7Hl05GamPIwyNglkwgWJRy3zWuU0rpkyQ2wwW
	5NeTra1Il2PULpW853AbP3co9i0fM10=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-KayEoHBAPJW4Q--tNY1QcA-1; Mon, 31 Jul 2023 18:26:03 -0400
X-MC-Unique: KayEoHBAPJW4Q--tNY1QcA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 544C28022EF;
	Mon, 31 Jul 2023 22:26:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B356C2017DC6;
	Mon, 31 Jul 2023 22:26:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net] mptcp: fix disconnect vs accept race
Date: Tue,  1 Aug 2023 00:25:56 +0200
Message-ID: <68f1f65f9b5542fd200f995844f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Despite commit 0ad529d9fd2b ("mptcp: fix possible divide by zero in
recvmsg()"), the mptcp protocol is still prone to a race between
disconnect() (or shutdown) and accept.

The root cause is that the mentioned commit checks the msk-level
flag, but mptcp_stream_accept() does acquire the msk-level lock,
as it can rely directly on the first subflow lock.

As reported by Christoph than can lead to a race where an msk
socket is accepted after that mptcp_subflow_queue_clean() releases
the listener socket lock and just before it takes destructive
actions leading to the following splat:

BUG: kernel NULL pointer dereference, address: 0000000000000012
PGD 5a4ca067 P4D 5a4ca067 PUD 37d4c067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 2 PID: 10955 Comm: syz-executor.5 Not tainted 6.5.0-rc1-gdc7b257ee5dd #37
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:mptcp_stream_accept+0x1ee/0x2f0 include/net/inet_sock.h:330
Code: 0a 09 00 48 8b 1b 4c 39 e3 74 07 e8 bc 7c 7f fe eb a1 e8 b5 7c 7f fe 4c 8b 6c 24 08 eb 05 e8 a9 7c 7f fe 49 8b 85 d8 09 00 00 <0f> b6 40 12 88 44 24 07 0f b6 6c 24 07 bf 07 00 00 00 89 ee e8 89
RSP: 0018:ffffc90000d07dc0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888037e8d020 RCX: ffff88803b093300
RDX: 0000000000000000 RSI: ffffffff833822c5 RDI: ffffffff8333896a
RBP: 0000607f82031520 R08: ffff88803b093300 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000003e83 R12: ffff888037e8d020
R13: ffff888037e8c680 R14: ffff888009af7900 R15: ffff888009af6880
FS:  00007fc26d708640(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000012 CR3: 0000000066bc5001 CR4: 0000000000370ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_accept+0x1ae/0x260 net/socket.c:1872
 __sys_accept4+0x9b/0x110 net/socket.c:1913
 __do_sys_accept4 net/socket.c:1954 [inline]
 __se_sys_accept4 net/socket.c:1951 [inline]
 __x64_sys_accept4+0x20/0x30 net/socket.c:1951
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x47/0xa0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Address the issue by temporary removing the pending request socket
from the accept queue, so that racing accept() can't touch them.

After depleting the msk - the ssk still exists, as plain TCP sockets,
re-insert them into the accept queue, so that later inet_csk_listen_stop()
will complete the tcp socket disposal.

Fixes: 2a6a870e44dd ("mptcp: stops worker on unaccepted sockets at listener close")
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/423
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note: as a net-next follow-up it would be nice to support mptcp socket
migration, basically duplicating part of the inet_csk_listen_stop() logic
---
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  | 58 ++++++++++++++++++++++----------------------
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a7db82eb4eea..1ce9b1a1fb56 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -324,7 +324,6 @@ struct mptcp_sock {
 	u32		subflow_id;
 	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
-	struct mptcp_sock	*dl_next;
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ad7080fabb2f..9bf3c7bc1762 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1793,16 +1793,31 @@ static void subflow_state_change(struct sock *sk)
 void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)
 {
 	struct request_sock_queue *queue = &inet_csk(listener_ssk)->icsk_accept_queue;
-	struct mptcp_sock *msk, *next, *head = NULL;
-	struct request_sock *req;
-	struct sock *sk;
+	struct request_sock *req, *head, *tail;
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk, *ssk;
 
-	/* build a list of all unaccepted mptcp sockets */
+	/* Due to lock dependencies no relevant lock can be acquired under rskq_lock.
+	 * Splice the req list, so that accept() can not reach the pending ssk after
+	 * the listener socket is released below.
+	 */
 	spin_lock_bh(&queue->rskq_lock);
-	for (req = queue->rskq_accept_head; req; req = req->dl_next) {
-		struct mptcp_subflow_context *subflow;
-		struct sock *ssk = req->sk;
+	head = queue->rskq_accept_head;
+	tail = queue->rskq_accept_tail;
+	queue->rskq_accept_head = NULL;
+	queue->rskq_accept_tail = NULL;
+	spin_unlock_bh(&queue->rskq_lock);
+
+	if (!head)
+		return;
 
+	/* can't acquire the msk socket lock under the subflow one,
+	 * or will cause ABBA deadlock
+	 */
+	release_sock(listener_ssk);
+
+	for (req = head; req; req = req->dl_next) {
+		ssk = req->sk;
 		if (!sk_is_mptcp(ssk))
 			continue;
 
@@ -1810,32 +1825,10 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 		if (!subflow || !subflow->conn)
 			continue;
 
-		/* skip if already in list */
 		sk = subflow->conn;
-		msk = mptcp_sk(sk);
-		if (msk->dl_next || msk == head)
-			continue;
-
 		sock_hold(sk);
-		msk->dl_next = head;
-		head = msk;
-	}
-	spin_unlock_bh(&queue->rskq_lock);
-	if (!head)
-		return;
-
-	/* can't acquire the msk socket lock under the subflow one,
-	 * or will cause ABBA deadlock
-	 */
-	release_sock(listener_ssk);
-
-	for (msk = head; msk; msk = next) {
-		sk = (struct sock *)msk;
 
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
-		next = msk->dl_next;
-		msk->dl_next = NULL;
-
 		__mptcp_unaccepted_force_close(sk);
 		release_sock(sk);
 
@@ -1859,6 +1852,13 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 
 	/* we are still under the listener msk socket lock */
 	lock_sock_nested(listener_ssk, SINGLE_DEPTH_NESTING);
+
+	/* restore the listener queue, to let the TCP code clean it up */
+	spin_lock_bh(&queue->rskq_lock);
+	WARN_ON_ONCE(queue->rskq_accept_head);
+	queue->rskq_accept_head = head;
+	queue->rskq_accept_tail = tail;
+	spin_unlock_bh(&queue->rskq_lock);
 }
 
 static int subflow_ulp_init(struct sock *sk)
-- 
2.41.0

