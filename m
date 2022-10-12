Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0017E0
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665586126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gZpHbRnOLCDmwQEILfUSTH9IwHFryPdUw9v0J8h6gyo=;
	b=iveffYRKXaiwrowivov0EdyuSDRNn525DPnJSlnDSVLdeOCOQMoRgGbPTd2iMVtyvqIkG1
	nDomFAz+4KtEIsjX1cv1IZvUcj9affkPG0QM+DhlJnCfZ/MCySqTW5YzbQaFwxtU28UJfU
	E7i8Bxhf3T3QMVYzlJoveUDNgvZC7JM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-9gXPusvGO_WI5bRGe-Onnw-1; Wed, 12 Oct 2022 10:48:45 -0400
X-MC-Unique: 9gXPusvGO_WI5bRGe-Onnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E34AB811E75
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 14:48:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.238])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 75A0C140EBF5
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 14:48:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3] mptcp: fix abba deadlock on fastopen
Date: Wed, 12 Oct 2022 16:48:40 +0200
Message-Id: <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Our CI reported lockdep splat in the fastopen code:
 ======================================================
 WARNING: possible circular locking dependency detected
 6.0.0.mptcp_f5e8bfe9878d+ #1558 Not tainted
 ------------------------------------------------------
 packetdrill/1071 is trying to acquire lock:
 ffff8881bd198140 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect+0x19c/0x310

 but task is already holding lock:
 ffff8881b8346540 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0xfdf/0x1740

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #1 (k-sk_lock-AF_INET){+.+.}-{0:0}:
        __lock_acquire+0xb6d/0x1860
        lock_acquire+0x1d8/0x620
        lock_sock_nested+0x37/0xd0
        inet_stream_connect+0x3f/0xa0
        mptcp_connect+0x411/0x800
        __inet_stream_connect+0x3ab/0x800
        mptcp_stream_connect+0xac/0x110
        __sys_connect+0x101/0x130
        __x64_sys_connect+0x6e/0xb0
        do_syscall_64+0x59/0x90
        entry_SYSCALL_64_after_hwframe+0x63/0xcd

 -> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
        check_prev_add+0x15e/0x2110
        validate_chain+0xace/0xdf0
        __lock_acquire+0xb6d/0x1860
        lock_acquire+0x1d8/0x620
        lock_sock_nested+0x37/0xd0
        inet_wait_for_connect+0x19c/0x310
        __inet_stream_connect+0x26c/0x800
        tcp_sendmsg_fastopen+0x341/0x650
        mptcp_sendmsg+0x109d/0x1740
        sock_sendmsg+0xe1/0x120
        __sys_sendto+0x1c7/0x2a0
        __x64_sys_sendto+0xdc/0x1b0
        do_syscall_64+0x59/0x90
        entry_SYSCALL_64_after_hwframe+0x63/0xcd

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(k-sk_lock-AF_INET);
                                lock(sk_lock-AF_INET);
                                lock(k-sk_lock-AF_INET);
   lock(sk_lock-AF_INET);

  *** DEADLOCK ***

 1 lock held by packetdrill/1071:
  #0: ffff8881b8346540 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0xfdf/0x1740
 ======================================================

The problem is caused by the blocking inet_wait_for_connect() releasing
and re-acquiring the msk socket lock while the subflow socket lock is
still held and the MPTCP socket requires that the msk socket lock must
be acquired before the subflow socket lock.

Address the issue always invoking tcp_sendmsg_fastopen() in an
unblocking manner, and later eventually complete the blocking
__inet_stream_connect() as needed.

Fixes: d98a82a6afc7 ("mptcp: handle defer connect in mptcp_sendmsg")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - dropped FASTOPEN_CONNECT chunk (Matttbe)
 - comments fixlet (Matttbe)
 - rebased on top of (""mptcp: factor out mptcp_connect()")

v1 -> v2:
 - really invoke fastopen in unblocking manner
 - clear copied_syn on completion errors
---
 net/mptcp/protocol.c | 49 ++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1cdf9cd1a3cc..82d899233df4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1673,6 +1673,37 @@ static void mptcp_set_nospace(struct sock *sk)
 	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
 }
 
+static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
+				  size_t len, int *copied_syn)
+{
+	unsigned int saved_flags = msg->msg_flags;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int ret;
+
+	lock_sock(ssk);
+	msg->msg_flags |= MSG_DONTWAIT;
+	msk->connect_flags = O_NONBLOCK;
+	msk->is_sendmsg = 1;
+	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
+	msk->is_sendmsg = 0;
+	msg->msg_flags = saved_flags;
+	release_sock(ssk);
+
+	/* do the blocking bits of inet_stream_connect outside the ssk socket lock */
+	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
+		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
+					    msg->msg_namelen, msg->msg_flags, 1);
+
+		/* Keep the same behaviout of plain TCP: zero the copied bytes in
+		 * case of any error, except timeout or signal
+		 */
+		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
+			*copied_syn = 0;
+	}
+
+	return ret;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1693,26 +1724,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	ssock = __mptcp_nmpc_socket(msk);
 	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
-		struct sock *ssk = ssock->sk;
 		int copied_syn = 0;
 
-		lock_sock(ssk);
-
-		msk->connect_flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
-		msk->is_sendmsg = 1;
-		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
-		msk->is_sendmsg = 0;
+		ret = mptcp_sendmsg_fastopen(sk, ssock->sk, msg, len, &copied_syn);
 		copied += copied_syn;
-		if (ret == -EINPROGRESS && copied_syn > 0) {
-			/* reflect the new state on the MPTCP socket */
-			inet_sk_state_store(sk, inet_sk_state_load(ssk));
-			release_sock(ssk);
+		if (ret == -EINPROGRESS && copied_syn > 0)
 			goto out;
-		} else if (ret) {
-			release_sock(ssk);
+		else if (ret)
 			goto do_error;
-		}
-		release_sock(ssk);
 	}
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
-- 
2.37.3

