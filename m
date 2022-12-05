Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4C7C
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670273102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aqphksb09+hK9Sv1/USB+qH5cNjSUS17UUZjMtmOm3g=;
	b=Xc6qcZ+/CszJW6INDhz7+xS7sM0c1M425E33cKe1+k4wsOEGCLpMirWVc/JkuLYBPFWvaN
	rHKFFXmi/wBOcHHPwM3WOxY0lle+YLBLpJRXarV+JMVg6JgfIfNAB3mdh3LhW9V9driFNc
	Zt2fyNA644iTvcpLi2UB5bus+ZHexPs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-eaJtYeNaMEuf-nKf3IWpVQ-1; Mon, 05 Dec 2022 15:45:01 -0500
X-MC-Unique: eaJtYeNaMEuf-nKf3IWpVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 984B93C025CE
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 20:45:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 267FB1121325
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 20:45:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net] mptcp: fix deadlock in fastopen error path.
Date: Mon,  5 Dec 2022 21:44:51 +0100
Message-Id: <f594fa95592f25434e24f0d16033cda1af9ce2cc.1670272505.git.pabeni@redhat.com>
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

MatM reported a deadlock at fastopening time:

INFO: task syz-executor.0:11454 blocked for more than 143 seconds.
      Tainted: G S                 6.1.0-rc5-03226-gdb0157db5153 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:25104 pid:11454 ppid:424    flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0x5c2/0x1550 kernel/sched/core.c:6503
 schedule+0xe8/0x1c0 kernel/sched/core.c:6579
 __lock_sock+0x142/0x260 net/core/sock.c:2896
 lock_sock_nested+0xdb/0x100 net/core/sock.c:3466
 __mptcp_close_ssk+0x1a3/0x790 net/mptcp/protocol.c:2328
 mptcp_destroy_common+0x16a/0x650 net/mptcp/protocol.c:3171
 mptcp_disconnect+0xb8/0x450 net/mptcp/protocol.c:3019
 __inet_stream_connect+0x897/0xa40 net/ipv4/af_inet.c:720
 tcp_sendmsg_fastopen+0x3dd/0x740 net/ipv4/tcp.c:1200
 mptcp_sendmsg_fastopen net/mptcp/protocol.c:1682 [inline]
 mptcp_sendmsg+0x128a/0x1a50 net/mptcp/protocol.c:1721
 inet6_sendmsg+0x11f/0x150 net/ipv6/af_inet6.c:663
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xf7/0x190 net/socket.c:734
 ____sys_sendmsg+0x336/0x970 net/socket.c:2476
 ___sys_sendmsg+0x122/0x1c0 net/socket.c:2530
 __sys_sendmmsg+0x18d/0x460 net/socket.c:2616
 __do_sys_sendmmsg net/socket.c:2645 [inline]
 __se_sys_sendmmsg net/socket.c:2642 [inline]
 __x64_sys_sendmmsg+0x9d/0x110 net/socket.c:2642
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5920a75e7d
RSP: 002b:00007f59201e8028 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f5920bb4f80 RCX: 00007f5920a75e7d
RDX: 0000000000000001 RSI: 0000000020002940 RDI: 0000000000000005
RBP: 00007f5920ae7593 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020004050 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5920bb4f80 R15: 00007f59201c8000
 </TASK>

In the error path, tcp_sendmsg_fastopen() ends-up calling
mptcp_disconnect(), and the latter tries to close each
subflow, acquring the socket lock on each of them.

At fastopen time, we have a single subflow, and such subflow
socket lock is already held by the called, causing the deadlock.

We already track the 'fastopen in progress' status inside the msk
socket. Use it to address the issue, making mptcp_disconnect() a
no op when invoked from the fastopen (error) path and doing the
relevant cleanup after releasing the subflow socket lock.

While at the above, rename the fastopen status bit to something
more meaningful.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/321
Reported-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Fixes: fa9e57468aa1 ("mptcp: fix abba deadlock on fastopen")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - Fixes -> Closes (MatM)
 - fix style issue - missing brackets (MatM)
 - fix code comment typo
 - fix pktdrill failures (ret != -EINPROGRESS -> ret && ret !=
   -EINPROGRESS)
---
 net/mptcp/protocol.c | 18 +++++++++++++++---
 net/mptcp/protocol.h |  2 +-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99f5e51d5ca4..6d03bdcda33e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1668,6 +1668,8 @@ static void mptcp_set_nospace(struct sock *sk)
 	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
 }
 
+static int mptcp_disconnect(struct sock *sk, int flags);
+
 static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
 				  size_t len, int *copied_syn)
 {
@@ -1678,9 +1680,9 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msgh
 	lock_sock(ssk);
 	msg->msg_flags |= MSG_DONTWAIT;
 	msk->connect_flags = O_NONBLOCK;
-	msk->is_sendmsg = 1;
+	msk->fastopening = 1;
 	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
-	msk->is_sendmsg = 0;
+	msk->fastopening = 0;
 	msg->msg_flags = saved_flags;
 	release_sock(ssk);
 
@@ -1694,6 +1696,8 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msgh
 		 */
 		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
 			*copied_syn = 0;
+	} else if (ret && ret != -EINPROGRESS) {
+		mptcp_disconnect(sk, 0);
 	}
 
 	return ret;
@@ -3005,6 +3009,14 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	/* We are on the fastopen error path. We can't call straight into the
+	 * subflows cleanup code due to lock nesting (we are already under
+	 * msk->firstsocket lock). Do nothing and leave the cleanup to the
+	 * caller.
+	 */
+	if (msk->fastopening)
+		return 0;
+
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_timer(sk);
@@ -3549,7 +3561,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	/* if reaching here via the fastopen/sendmsg path, the caller already
 	 * acquired the subflow socket lock, too.
 	 */
-	if (msk->is_sendmsg)
+	if (msk->fastopening)
 		err = __inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags, 1);
 	else
 		err = inet_stream_connect(ssock, uaddr, addr_len, msk->connect_flags);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 224f03a899c5..a9ff7028fad8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -294,7 +294,7 @@ struct mptcp_sock {
 	u8		recvmsg_inq:1,
 			cork:1,
 			nodelay:1,
-			is_sendmsg:1;
+			fastopening:1;
 	int		connect_flags;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
-- 
2.38.1

