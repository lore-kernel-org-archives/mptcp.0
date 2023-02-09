Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF02F29
	for <mptcp@lists.linux.dev>; Thu,  9 Feb 2023 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675968551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5CNnHegGUEV+yO9Ty7XBUwvcoZ5SZjZmUNNPeB7394=;
	b=dmPA1lv8Y+kKe001rowuTXDc0/oGEmyj+ihyh31Ha44HczyjbgwGA2ghdlhkqanD2JqCqP
	227oQrHCSx9lqrs61icmLSpeiOtI6YSw+D4AuPu6ua0KE/f4undI+1uW+uL4P52qpP/9Gp
	kQWpbV7fzGMhWKcmmrdLqKjSkNyCjGc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-t4ESh_xRNOSvZ-YqN9fo1g-1; Thu, 09 Feb 2023 13:49:02 -0500
X-MC-Unique: t4ESh_xRNOSvZ-YqN9fo1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C67FA2806040;
	Thu,  9 Feb 2023 18:48:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3151EC158BB;
	Thu,  9 Feb 2023 18:48:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH v2 mptcp-net 2/2] mptcp: fix UaF in listener shutdown
Date: Thu,  9 Feb 2023 19:48:51 +0100
Message-Id: <ad634b00b9c4cfb0f8cd6c8ec57d1a7405ba3799.1675968499.git.pabeni@redhat.com>
In-Reply-To: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
References: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

As reported by Christoph, the mptcp listener shutdown path is prone
to an UaF issue.

BUG: KASAN: use-after-free in _raw_spin_lock_bh+0x73/0xe0
Write of size 4 at addr ffff88810cb23098 by task syz-executor731/1266

CPU: 1 PID: 1266 Comm: syz-executor731 Not tainted 6.2.0-rc59af4eaa31c1f6c00c8f1e448ed99a45c66340dd5 #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x6e/0x91
 print_report+0x16a/0x46f
 kasan_report+0xad/0x130
 kasan_check_range+0x14a/0x1a0
 _raw_spin_lock_bh+0x73/0xe0
 subflow_error_report+0x6d/0x110
 sk_error_report+0x3b/0x190
 tcp_disconnect+0x138c/0x1aa0
 inet_child_forget+0x6f/0x2e0
 inet_csk_listen_stop+0x209/0x1060
 __mptcp_close_ssk+0x52d/0x610
 mptcp_destroy_common+0x165/0x640
 mptcp_destroy+0x13/0x80
 __mptcp_destroy_sock+0xe7/0x270
 __mptcp_close+0x70e/0x9b0
 mptcp_close+0x2b/0x150
 inet_release+0xe9/0x1f0
 __sock_release+0xd2/0x280
 sock_close+0x15/0x20
 __fput+0x252/0xa20
 task_work_run+0x169/0x250
 exit_to_user_mode_prepare+0x113/0x120
 syscall_exit_to_user_mode+0x1d/0x40
 do_syscall_64+0x48/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

The msk grace period can legitly expire in between the last
reference count dropped in mptcp_subflow_queue_clean() and
the later eventual access in inet_csk_listen_stop()

After the previous patch we don't need anymore special-casing
msk listener socket cleanup: the mptcp worker will process each
of the unaccepted msk sockets.

Just drop the now unnecessary code.

Reported-and-tested-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/346
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c |  1 -
 net/mptcp/protocol.h |  1 -
 net/mptcp/subflow.c  | 80 --------------------------------------------
 3 files changed, 82 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d7588535bf6d..ae2d715f82b5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2400,7 +2400,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
 		if (ssk->sk_state == TCP_LISTEN) {
 			tcp_set_state(ssk, TCP_CLOSE);
-			mptcp_subflow_queue_clean(sk, ssk);
 			inet_csk_listen_stop(ssk);
 			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 252f050c96c6..ba4d22ffd228 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -631,7 +631,6 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow);
 void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
-void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7cc967985011..8b46311b8d5e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1814,86 +1814,6 @@ static void subflow_state_change(struct sock *sk)
 	}
 }
 
-void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)
-{
-	struct request_sock_queue *queue = &inet_csk(listener_ssk)->icsk_accept_queue;
-	struct mptcp_sock *msk, *next, *head = NULL;
-	struct request_sock *req;
-
-	/* build a list of all unaccepted mptcp sockets */
-	spin_lock_bh(&queue->rskq_lock);
-	for (req = queue->rskq_accept_head; req; req = req->dl_next) {
-		struct mptcp_subflow_context *subflow;
-		struct sock *ssk = req->sk;
-		struct mptcp_sock *msk;
-
-		if (!sk_is_mptcp(ssk))
-			continue;
-
-		subflow = mptcp_subflow_ctx(ssk);
-		if (!subflow || !subflow->conn)
-			continue;
-
-		/* skip if already in list */
-		msk = mptcp_sk(subflow->conn);
-		if (msk->dl_next || msk == head)
-			continue;
-
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
-		struct sock *sk = (struct sock *)msk;
-		bool do_cancel_work;
-
-		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
-		next = msk->dl_next;
-		msk->dl_next = NULL;
-
-		/* The upcoming mptcp_close is going to drop all the references
-		 * to the first subflow, ignoring that one of such reference is
-		 * owned by the request socket still in the accept queue and that
-		 * later inet_csk_listen_stop will drop it.
-		 * Acquire an extra reference here to avoid an UaF at that point.
-		 */
-		if (msk->first)
-			sock_hold(msk->first);
-
-		do_cancel_work = __mptcp_close(sk, -1);
-		release_sock(sk);
-		if (do_cancel_work) {
-			/* lockdep will report a false positive ABBA deadlock
-			 * between cancel_work_sync and the listener socket.
-			 * The involved locks belong to different sockets WRT
-			 * the existing AB chain.
-			 * Using a per socket key is problematic as key
-			 * deregistration requires process context and must be
-			 * performed at socket disposal time, in atomic
-			 * context.
-			 * Just tell lockdep to consider the listener socket
-			 * released here.
-			 */
-			mutex_release(&listener_sk->sk_lock.dep_map, _RET_IP_);
-			mptcp_cancel_work(sk);
-			mutex_acquire(&listener_sk->sk_lock.dep_map,
-				      SINGLE_DEPTH_NESTING, 0, _RET_IP_);
-		}
-		sock_put(sk);
-	}
-
-	/* we are still under the listener msk socket lock */
-	lock_sock_nested(listener_ssk, SINGLE_DEPTH_NESTING);
-}
-
 static int subflow_ulp_init(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-- 
2.39.1

