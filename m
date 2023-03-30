Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13EF9462
	for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680204147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=paeu0Knr30FgfOltm3mHmEjLVALOK7zYCd7ADF5EaPk=;
	b=K4Qxe1wuCBaYezmu21+FzPlEXViFmVVcyVOkXg6Vzq/vYhVujWXT8Rl0oJNZrKuVIScYJb
	wpK/rYjwwoZoOU10Fm6/18lwCYo0xDSh+ixi9e/HY8abDM105u6kwqDmmujkT+zMYek6MO
	ClOXlx2Hf+aVl7tKWx34xGgpoVdzWxs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-KPE4tr0_NkiehlxXMqXoFg-1; Thu, 30 Mar 2023 15:22:24 -0400
X-MC-Unique: KPE4tr0_NkiehlxXMqXoFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12FC928135AB;
	Thu, 30 Mar 2023 19:22:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 820C71121330;
	Thu, 30 Mar 2023 19:22:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH v3 mptcp-net 2/2] mptcp: fix accept vs worker race
Date: Thu, 30 Mar 2023 21:22:17 +0200
Message-Id: <b12779f37770dbdad059232c9cb45fbd56afabd2.1680204074.git.pabeni@redhat.com>
In-Reply-To: <cover.1680204074.git.pabeni@redhat.com>
References: <cover.1680204074.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mptcp worker and mptcp_accept() can race, as reported by Christoph:

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 14351 at lib/refcount.c:25 refcount_warn_saturate+0x105/0x1b0 lib/refcount.c:25
Modules linked in:
CPU: 1 PID: 14351 Comm: syz-executor.2 Not tainted 6.3.0-rc1-gde5e8fd0123c #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:refcount_warn_saturate+0x105/0x1b0 lib/refcount.c:25
Code: 02 31 ff 89 de e8 1b f0 a7 ff 84 db 0f 85 6e ff ff ff e8 3e f5 a7 ff 48 c7 c7 d8 c7 34 83 c6 05 6d 2d 0f 02 01 e8 cb 3d 90 ff <0f> 0b e9 4f ff ff ff e8 1f f5 a7 ff 0f b6 1d 54 2d 0f 02 31 ff 89
RSP: 0018:ffffc90000a47bf8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802eae98c0 RSI: ffffffff81097d4f RDI: 0000000000000001
RBP: ffff88802e712180 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffff88802eaea148 R12: ffff88802e712100
R13: ffff88802e712a88 R14: ffff888005cb93a8 R15: ffff88802e712a88
FS:  0000000000000000(0000) GS:ffff88803ed00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f277fd89120 CR3: 0000000035486002 CR4: 0000000000370ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:199 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 sock_hold include/net/sock.h:775 [inline]
 __mptcp_close+0x4c6/0x4d0 net/mptcp/protocol.c:3051
 mptcp_close+0x24/0xe0 net/mptcp/protocol.c:3072
 inet_release+0x56/0xa0 net/ipv4/af_inet.c:429
 __sock_release+0x51/0xf0 net/socket.c:653
 sock_close+0x18/0x20 net/socket.c:1395
 __fput+0x113/0x430 fs/file_table.c:321
 task_work_run+0x96/0x100 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x4fc/0x10c0 kernel/exit.c:869
 do_group_exit+0x51/0xf0 kernel/exit.c:1019
 get_signal+0x12b0/0x1390 kernel/signal.c:2859
 arch_do_signal_or_restart+0x25/0x260 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x131/0x1a0 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x19/0x40 kernel/entry/common.c:296
 do_syscall_64+0x46/0x90 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7fec4b4926a9
Code: Unable to access opcode bytes at 0x7fec4b49267f.
RSP: 002b:00007fec49f9dd78 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000006bc058 RCX: 00007fec4b4926a9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006bc058
RBP: 00000000006bc050 R08: 00000000007df998 R09: 00000000007df998
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006bc05c
R13: fffffffffffffea8 R14: 000000000000000b R15: 000000000001fe40
 </TASK>

The root cause is that the worker can force fallback to TCP the first
mptcp subflow, actually deleting the unaccepted msk socket.

We can explicitly prevent the race delaying the unaccepted msk deletion
at listener shutdown time. In case the closed subflow is later accepted,
just just drop the mptcp contenxt and let the user-space deal with the
paiered mptcp socket.

Fixes: b6985b9b8295 ("mptcp: use the workqueue to destroy unaccepted sockets")
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/375
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 48 ++++++++++++++++++++++++++------------------
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 26 ++++++++++++++++--------
 3 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d28528df43fa..ce495b5a683a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2373,6 +2373,15 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	bool need_push, dispose_it;
 
+	/* If the first subflow moved to a close state, e.g. due to
+	 * incoming reset and we reach here before accept we need to be able
+	 * to deliver the msk to user-space.
+	 * Do nothing at the moment and take action at accept and/or listener
+	 * shutdown.
+	 */
+	if (msk->in_accept_queue && msk->first == ssk)
+		return;
+
 	dispose_it = !msk->subflow || ssk != msk->subflow->sk;
 	if (dispose_it)
 		list_del(&subflow->node);
@@ -2407,18 +2416,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (!inet_csk(ssk)->icsk_ulp_ops) {
 		WARN_ON_ONCE(!sock_flag(ssk, SOCK_DEAD));
 		kfree_rcu(subflow, rcu);
-	} else if (msk->in_accept_queue && msk->first == ssk) {
-		/* if the first subflow moved to a close state, e.g. due to
-		 * incoming reset and we reach here before inet_child_forget()
-		 * the TCP stack could later try to close it via
-		 * inet_csk_listen_stop(), or deliver it to the user space via
-		 * accept().
-		 * We can't delete the subflow - or risk a double free - nor let
-		 * the msk survive - or will be leaked in the non accept scenario:
-		 * fallback and let TCP cope with the subflow cleanup.
-		 */
-		WARN_ON_ONCE(sock_flag(ssk, SOCK_DEAD));
-		mptcp_subflow_drop_ctx(ssk);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
 		if (ssk->sk_state == TCP_LISTEN) {
@@ -2487,13 +2484,6 @@ static void __mptcp_close_subflow(struct sock *sk)
 		mptcp_close_ssk(sk, ssk, subflow);
 	}
 
-	/* if the MPC subflow has been closed before the msk is accepted,
-	 * msk will never be accept-ed, close it now
-	 */
-	if (!msk->first && msk->in_accept_queue) {
-		sock_set_flag(sk, SOCK_DEAD);
-		inet_sk_state_store(sk, TCP_CLOSE);
-	}
 }
 
 static bool mptcp_check_close_timeout(const struct sock *sk)
@@ -2976,6 +2966,14 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sock_put(sk);
 }
 
+void __mptcp_unaccepted_force_close(struct sock *sk)
+{
+	sock_set_flag(sk, SOCK_DEAD);
+	inet_sk_state_store(sk, TCP_CLOSE);
+	mptcp_do_fastclose(sk);
+	__mptcp_destroy_sock(sk);
+}
+
 static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
 {
 	/* Concurrent splices from sk_receive_queue into receive_queue will
@@ -3825,6 +3823,18 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			if (!ssk->sk_socket)
 				mptcp_sock_graft(ssk, newsock);
 		}
+
+		/* Do late cleanup for the first subflow as necessary. Also
+		 * deal with bad peers not doing a complete shutdown.
+		 */
+		if (msk->first &&
+		    unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
+			__mptcp_close_ssk(newsk, msk->first,
+					  mptcp_subflow_ctx(msk->first), 0);
+			if (unlikely(list_empty(&msk->conn_list)))
+				inet_sk_state_store(newsk, TCP_CLOSE);
+		}
+
 	}
 	release_sock(newsk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a4e82bcfc7b8..457c9f63ed82 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -631,6 +631,7 @@ void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
+void __mptcp_unaccepted_force_close(struct sock *sk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d90267da9114..3d6ccf5067d7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1813,12 +1813,13 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 	struct request_sock_queue *queue = &inet_csk(listener_ssk)->icsk_accept_queue;
 	struct mptcp_sock *msk, *next, *head = NULL;
 	struct request_sock *req;
+	struct sock *sk, *ssk;
 
 	/* build a list of all unaccepted mptcp sockets */
 	spin_lock_bh(&queue->rskq_lock);
 	for (req = queue->rskq_accept_head; req; req = req->dl_next) {
 		struct mptcp_subflow_context *subflow;
-		struct sock *ssk = req->sk;
+		ssk = req->sk;
 
 		if (!sk_is_mptcp(ssk))
 			continue;
@@ -1828,11 +1829,12 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 			continue;
 
 		/* skip if already in list */
-		msk = mptcp_sk(subflow->conn);
+		sk = subflow->conn;
+		msk = mptcp_sk(sk);
 		if (msk->dl_next || msk == head)
 			continue;
 
-		sock_hold(subflow->conn);
+		sock_hold(sk);
 		msk->dl_next = head;
 		head = msk;
 	}
@@ -1846,18 +1848,26 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
 	release_sock(listener_ssk);
 
 	for (msk = head; msk; msk = next) {
-		struct sock *sk = (struct sock *)msk;
+		sk = (struct sock *)msk;
 
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+		ssk = msk->first;
 		next = msk->dl_next;
 		msk->dl_next = NULL;
 
-		/* prevent the stack from later re-schedule the worker for
-		 * this socket
-		 */
-		inet_sk_state_store(sk, TCP_CLOSE);
+		__mptcp_unaccepted_force_close(sk);
 		release_sock(sk);
 
+		/* the first subflow is not touched by the above, as the msk
+		 * is still in the accept queue, see __mptcp_close_ssk,
+		 * we need to release only the ctx related resources, the
+		 * tcp socket will be destroyed by inet_csk_listen_stop()
+		 */
+		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+		mptcp_subflow_drop_ctx(ssk);
+		release_sock(ssk);
+		sock_put(ssk);
+
 		/* lockdep will report a false positive ABBA deadlock
 		 * between cancel_work_sync and the listener socket.
 		 * The involved locks belong to different sockets WRT
-- 
2.39.2

