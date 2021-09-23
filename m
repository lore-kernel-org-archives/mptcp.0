Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBDC3FC7
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632396869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BZrRjnygKeTj/Mf0VmlL+mhgBwro8V2aj6HNY1QjEdA=;
	b=IYVW3qJzREXXgH06IweK9T4IMQwm71tov3wVhyiUj6fPAAvoB9t8SxDMXEfxWypKpRW92o
	zygyRBGM6zKlpNCgahcdvSuN0NGsbkbFPQeqtbyODNzb7uxb/gxoJU63KED6DW2GrF/EOv
	k86d5g83WP5JlHQHTPnwRZ0tSiu9bDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-WUA53ifMMNOATRoiMOGWxA-1; Thu, 23 Sep 2021 07:34:27 -0400
X-MC-Unique: WUA53ifMMNOATRoiMOGWxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F8A4362F8
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 11:34:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D6185D9F4
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 11:34:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] net: introduce and use lock_sock_fast_nested()
Date: Thu, 23 Sep 2021 13:34:22 +0200
Message-Id: <edc906c6750186d75e2cf2b87d84c10284c8dd8b.1632396844.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Syzkaller reported a false positive deadlock involving
the nl socket lock and the subflow socket lock:

MPTCP: kernel_bind error, err=-98
============================================
WARNING: possible recursive locking detected
5.15.0-rc1-syzkaller #0 Not tainted
--------------------------------------------
syz-executor998/6520 is trying to acquire lock:
ffff8880795718a0 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x267/0x7b0 net/mptcp/protocol.c:2738

but task is already holding lock:
ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1612 [inline]
ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x23/0x7b0 net/mptcp/protocol.c:2720

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(k-sk_lock-AF_INET);
  lock(k-sk_lock-AF_INET);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor998/6520:
 #0: ffffffff8d176c50 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40 net/netlink/genetlink.c:802
 #1: ffffffff8d176d08 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
 #1: ffffffff8d176d08 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x3e0/0x580 net/netlink/genetlink.c:790
 #2: ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1612 [inline]
 #2: ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x23/0x7b0 net/mptcp/protocol.c:2720

stack backtrace:
CPU: 1 PID: 6520 Comm: syz-executor998 Not tainted 5.15.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2944 [inline]
 check_deadlock kernel/locking/lockdep.c:2987 [inline]
 validate_chain kernel/locking/lockdep.c:3776 [inline]
 __lock_acquire.cold+0x149/0x3ab kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 lock_sock_fast+0x36/0x100 net/core/sock.c:3229
 mptcp_close+0x267/0x7b0 net/mptcp/protocol.c:2738
 inet_release+0x12e/0x280 net/ipv4/af_inet.c:431
 __sock_release net/socket.c:649 [inline]
 sock_release+0x87/0x1b0 net/socket.c:677
 mptcp_pm_nl_create_listen_socket+0x238/0x2c0 net/mptcp/pm_netlink.c:900
 mptcp_nl_cmd_add_addr+0x359/0x930 net/mptcp/pm_netlink.c:1170
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
 genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:792
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 sock_no_sendpage+0x101/0x150 net/core/sock.c:2980
 kernel_sendpage.part.0+0x1a0/0x340 net/socket.c:3504
 kernel_sendpage net/socket.c:3501 [inline]
 sock_sendpage+0xe5/0x140 net/socket.c:1003
 pipe_to_sendpage+0x2ad/0x380 fs/splice.c:364
 splice_from_pipe_feed fs/splice.c:418 [inline]
 __splice_from_pipe+0x43e/0x8a0 fs/splice.c:562
 splice_from_pipe fs/splice.c:597 [inline]
 generic_splice_sendpage+0xd4/0x140 fs/splice.c:746
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x110/0x180 fs/splice.c:936
 splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
 do_splice_direct+0x1b3/0x280 fs/splice.c:979
 do_sendfile+0xae9/0x1240 fs/read_write.c:1249
 __do_sys_sendfile64 fs/read_write.c:1314 [inline]
 __se_sys_sendfile64 fs/read_write.c:1300 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f215cb69969
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc96bb3868 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f215cbad072 RCX: 00007f215cb69969
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007ffc96bb3a08 R09: 00007ffc96bb3a08
R10: 0000000100000002 R11: 0000000000000246 R12: 00007ffc96bb387c
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000

the problem originates from uncorrect lock annotation in the mptcp
code and is only visible since commit 2dcb96bacce3 ("net: core: Correct
the sock::sk_lock.owned lockdep annotations"), but is present since
the port-based endpoint support initial implementation.

This patch addresses the issue introducing a nested variant of
lock_sock_fast() and using it in the relevant code path.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Fixes: 2dcb96bacce3 ("net: core: Correct the sock::sk_lock.owned lockdep annotations")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reported-and-tested-by: syzbot+1dd53f7a89b299d59eaf@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/sock.h   | 31 ++++++++++++++++++++++++++++++-
 net/core/sock.c      | 20 ++------------------
 net/mptcp/protocol.c |  2 +-
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c005c3c750e8..b5096e20fba5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1623,7 +1623,36 @@ void release_sock(struct sock *sk);
 				SINGLE_DEPTH_NESTING)
 #define bh_unlock_sock(__sk)	spin_unlock(&((__sk)->sk_lock.slock))
 
-bool lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock);
+bool __lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock);
+
+/**
+ * lock_sock_fast - fast version of lock_sock
+ * @sk: socket
+ *
+ * This version should be used for very small section, where process wont block
+ * return false if fast path is taken:
+ *
+ *   sk_lock.slock locked, owned = 0, BH disabled
+ *
+ * return true if slow path is taken:
+ *
+ *   sk_lock.slock unlocked, owned = 1, BH enabled
+ */
+static inline bool lock_sock_fast(struct sock *sk)
+{
+	/* The sk_lock has mutex_lock() semantics here. */
+	mutex_acquire(&sk->sk_lock.dep_map, 0, 0, _RET_IP_);
+
+	return __lock_sock_fast(sk);
+}
+
+/* fast socket lock variant for caller already helding a [different] socket lock */
+static inline bool lock_sock_fast_nested(struct sock *sk)
+{
+	mutex_acquire(&sk->sk_lock.dep_map, SINGLE_DEPTH_NESTING, 0, _RET_IP_);
+
+	return __lock_sock_fast(sk);
+}
 
 /**
  * unlock_sock_fast - complement of lock_sock_fast
diff --git a/net/core/sock.c b/net/core/sock.c
index 512e629f9780..7060d183216e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3210,24 +3210,8 @@ void release_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(release_sock);
 
-/**
- * lock_sock_fast - fast version of lock_sock
- * @sk: socket
- *
- * This version should be used for very small section, where process wont block
- * return false if fast path is taken:
- *
- *   sk_lock.slock locked, owned = 0, BH disabled
- *
- * return true if slow path is taken:
- *
- *   sk_lock.slock unlocked, owned = 1, BH enabled
- */
-bool lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock)
+bool __lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock)
 {
-	/* The sk_lock has mutex_lock() semantics here. */
-	mutex_acquire(&sk->sk_lock.dep_map, 0, 0, _RET_IP_);
-
 	might_sleep();
 	spin_lock_bh(&sk->sk_lock.slock);
 
@@ -3256,7 +3240,7 @@ bool lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock)
 	spin_unlock_bh(&sk->sk_lock.slock);
 	return true;
 }
-EXPORT_SYMBOL(lock_sock_fast);
+EXPORT_SYMBOL(__lock_sock_fast);
 
 int sock_gettstamp(struct socket *sock, void __user *userstamp,
 		   bool timeval, bool time32)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b334f9b6242..e521462016c5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2746,7 +2746,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
+		bool slow = lock_sock_fast_nested(ssk);
 
 		sock_orphan(ssk);
 		unlock_sock_fast(ssk, slow);
-- 
2.26.3

