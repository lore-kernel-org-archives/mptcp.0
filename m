Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141829AC
	for <mptcp@lists.linux.dev>; Wed,  7 Dec 2022 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670435641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VCzrFAm3bJSjNueyc/d30tZzDzxPfNRToMKmBKVkKRo=;
	b=EjOMKTDqwxxdgHKUAXwOpw6ugRSQbclLbZ3pJXCgBcdXqPpOMjgwPfqRc/2D3Kt9CbLzfm
	mm8A5JHl0CTRNkGoDmgrDFtoR3Oc0/J5EcvjUjQrlBNIuFy+CyJxV/FL9rW/xxltrLj1UR
	7AIXUQ6wKRLIO5eRTW3ysQ7Chkfyw1k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-tGnVu0pCMySuiyUz4NQnmQ-1; Wed, 07 Dec 2022 12:53:59 -0500
X-MC-Unique: tGnVu0pCMySuiyUz4NQnmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EEF329DD9BC
	for <mptcp@lists.linux.dev>; Wed,  7 Dec 2022 17:53:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B335340C6EC2
	for <mptcp@lists.linux.dev>; Wed,  7 Dec 2022 17:53:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix lockdep false positive
Date: Wed,  7 Dec 2022 18:52:49 +0100
Message-Id: <0818f7332284bd7781956959fbebb90188e140cb.1670435550.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

MatB reported a lockdep splat in the mptcp listener code cleanup:

 WARNING: possible circular locking dependency detected
 packetdrill/14278 is trying to acquire lock:
 ffff888017d868f0 ((work_completion)(&msk->work)){+.+.}-{0:0}, at: __flush_work (kernel/workqueue.c:3069)

 but task is already holding lock:
 ffff888017d84130 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close (net/mptcp/protocol.c:2973)

 which lock already depends on the new lock.


 the existing dependency chain (in reverse order) is:

 -> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
        __lock_acquire (kernel/locking/lockdep.c:5055)
        lock_acquire (kernel/locking/lockdep.c:466)
        lock_sock_nested (net/core/sock.c:3463)
        mptcp_worker (net/mptcp/protocol.c:2614)
        process_one_work (kernel/workqueue.c:2294)
        worker_thread (include/linux/list.h:292)
        kthread (kernel/kthread.c:376)
        ret_from_fork (arch/x86/entry/entry_64.S:312)

 -> #0 ((work_completion)(&msk->work)){+.+.}-{0:0}:
        check_prev_add (kernel/locking/lockdep.c:3098)
        validate_chain (kernel/locking/lockdep.c:3217)
        __lock_acquire (kernel/locking/lockdep.c:5055)
        lock_acquire (kernel/locking/lockdep.c:466)
        __flush_work (kernel/workqueue.c:3070)
        __cancel_work_timer (kernel/workqueue.c:3160)
        mptcp_cancel_work (net/mptcp/protocol.c:2758)
        mptcp_subflow_queue_clean (net/mptcp/subflow.c:1817)
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

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(sk_lock-AF_INET);
                                lock((work_completion)(&msk->work));
                                lock(sk_lock-AF_INET);
   lock((work_completion)(&msk->work));

  *** DEADLOCK ***

The report is actually a false positive, since the only exiting lock
nesting is the msk socket lock acquire by the mptcp work.
cancel_work_sync() is invoked without the relevant socket lock being
held, but under a different (the msk listener) socket lock.

We could silence the splat adding a per workqueue dynamic lockdep key,
but that looks overkill. Instead just tell lockdep the msk socket lock
is not held around cancel_work_sync().

Fixes: 30e51b923e43 ("mptcp: fix unreleased socket in accept queue")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
note: mutex_release() is available as a NULL macro even when LOCKDEP is
disabled
---
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  | 14 ++++++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d03bdcda33e..289dd4add88c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2363,7 +2363,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
 		if (ssk->sk_state == TCP_LISTEN) {
 			tcp_set_state(ssk, TCP_CLOSE);
-			mptcp_subflow_queue_clean(ssk);
+			mptcp_subflow_queue_clean(sk, ssk);
 			inet_csk_listen_stop(ssk);
 			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a9ff7028fad8..3cd3270407b0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -630,7 +630,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow);
 void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
-void mptcp_subflow_queue_clean(struct sock *ssk);
+void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 29904303f5c2..d5ff502c88d7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1764,7 +1764,7 @@ static void subflow_state_change(struct sock *sk)
 	}
 }
 
-void mptcp_subflow_queue_clean(struct sock *listener_ssk)
+void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)
 {
 	struct request_sock_queue *queue = &inet_csk(listener_ssk)->icsk_accept_queue;
 	struct mptcp_sock *msk, *next, *head = NULL;
@@ -1813,8 +1813,18 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
 
 		do_cancel_work = __mptcp_close(sk, 0);
 		release_sock(sk);
-		if (do_cancel_work)
+		if (do_cancel_work) {
+			/* lockdep will report a false positive ABBA deadlock between
+			 * cancel_work_sync and the listener socket. The involved locks
+			 * belong to differen sockets WRT the existing AB chain.
+			 * Using a per socket key would be very invasive and heavy, just
+			 * tell lockdep to consider the listener socket released here
+			 */
+			mutex_release(&listener_sk->sk_lock.dep_map, _RET_IP_);
 			mptcp_cancel_work(sk);
+			mutex_acquire(&listener_sk->sk_lock.dep_map,
+				      SINGLE_DEPTH_NESTING, 0, _RET_IP_);
+		}
 		sock_put(sk);
 	}
 
-- 
2.38.1

