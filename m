Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B033FC8
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 19:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632340729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1YWmFpOvMVID4ziuWhp2MbsFC+VRMkCe4j5Vk8pAww=;
	b=bwWUciRA7rSyUnzrOFmmrVTL82TbeR+oA2wt9GO00HF3ESNqD4x9m6cNprNUBFuyk5JdOP
	Nlt7JBT5/YbWn0vgvKZc+iNgtSR+eKh1ArGc26woHpa873eH3swUJGRoDWXN9Z8KQOrV6D
	K2ooBPO4DggLX5EDD94kEdyxuL71H54=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-Js0VMuMcOgGrSFCcCm8zBA-1; Wed, 22 Sep 2021 15:58:37 -0400
X-MC-Unique: Js0VMuMcOgGrSFCcCm8zBA-1
Received: by mail-wr1-f71.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so3224614wrh.0
        for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 12:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=l1YWmFpOvMVID4ziuWhp2MbsFC+VRMkCe4j5Vk8pAww=;
        b=Cxlqo7Uek/eHxbPDOfQwMSbT+EptSA+LMfrsjRzlo+OJON+L7dSb5GoXvf3+SGXSRM
         LPIdB9hovxnXciJS2aYfgJgTtjqJZBAzefOWoU1gHirF9Mz6XQqsBP8SvP3bh2WngO4W
         7OGXWNyq5slAcnwuH/GNy4vrIb4qO4pp0Rv91VJaPJBPL6vzxERHHe6W9kXzcl/mcBsL
         B5FrrsfTDxPT5sLIsemsMt/Oys6J5VEEvm8TFpuhdYYBR9iThtzeeD301nI3hjd9Ar3Y
         vryIQh74siHXnHz9PXjuhZiqMSjxawhbl37Gz4C3n4VlqCc/PrbMI8kqg7K70i92Zz4v
         ARgg==
X-Gm-Message-State: AOAM532mIq68BwOKH1pZ2M8y2nnZFwcQPukaFc4lGM0dUYzmjG5OQ0q9
	gUuPX2dI7DWG0IaRpm6Uv/hPneb8IQt1d1TytlKswEjBpxGSFz8FdYHQPDqlh+o2/NFC+CX71T1
	9lESyJ39Ql20zipQ=
X-Received: by 2002:a1c:800e:: with SMTP id b14mr12734674wmd.54.1632340715911;
        Wed, 22 Sep 2021 12:58:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysqSNoVN4ZXYKXDn6wgD1UgB8DlRXtIU3gAyzH0pCN0w/2kIUzCN8oJs6+Dcet+2msuAbd3Q==
X-Received: by 2002:a1c:800e:: with SMTP id b14mr12734657wmd.54.1632340715570;
        Wed, 22 Sep 2021 12:58:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-102-46.dyn.eolo.it. [146.241.102.46])
        by smtp.gmail.com with ESMTPSA id v8sm3106135wrt.12.2021.09.22.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 12:58:35 -0700 (PDT)
Message-ID: <f8b3bfc6173a9dca9b72ead1681cd6d052350170.camel@redhat.com>
Subject: Re: [syzbot] possible deadlock in mptcp_close
From: Paolo Abeni <pabeni@redhat.com>
To: syzbot <syzbot+1dd53f7a89b299d59eaf@syzkaller.appspotmail.com>, 
	mptcp@lists.linux.dev, syzkaller-bugs@googlegroups.com
Date: Wed, 22 Sep 2021 21:58:19 +0200
In-Reply-To: <0000000000005183b005cc74779a@google.com>
References: <0000000000005183b005cc74779a@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-09-20 at 15:04 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e30cd812dffa selftests: net: af_unix: Fix makefile to use ..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=1689d3e7300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
> dashboard link: https://syzkaller.appspot.com/bug?extid=1dd53f7a89b299d59eaf
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11adc1d7300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a351ab300000
> 
> The issue was bisected to:
> 
> commit 2dcb96bacce36021c2f3eaae0cef607b5bb71ede
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Sat Sep 18 12:42:35 2021 +0000
> 
>     net: core: Correct the sock::sk_lock.owned lockdep annotations
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a511f3300000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a511f3300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a511f3300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1dd53f7a89b299d59eaf@syzkaller.appspotmail.com
> Fixes: 2dcb96bacce3 ("net: core: Correct the sock::sk_lock.owned lockdep annotations")
> 
> MPTCP: kernel_bind error, err=-98
> ============================================
> WARNING: possible recursive locking detected
> 5.15.0-rc1-syzkaller #0 Not tainted
> --------------------------------------------
> syz-executor998/6520 is trying to acquire lock:
> ffff8880795718a0 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x267/0x7b0 net/mptcp/protocol.c:2738
> 
> but task is already holding lock:
> ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1612 [inline]
> ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x23/0x7b0 net/mptcp/protocol.c:2720
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(k-sk_lock-AF_INET);
>   lock(k-sk_lock-AF_INET);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by syz-executor998/6520:
>  #0: ffffffff8d176c50 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40 net/netlink/genetlink.c:802
>  #1: ffffffff8d176d08 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
>  #1: ffffffff8d176d08 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x3e0/0x580 net/netlink/genetlink.c:790
>  #2: ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1612 [inline]
>  #2: ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x23/0x7b0 net/mptcp/protocol.c:2720
> 
> stack backtrace:
> CPU: 1 PID: 6520 Comm: syz-executor998 Not tainted 5.15.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_deadlock_bug kernel/locking/lockdep.c:2944 [inline]
>  check_deadlock kernel/locking/lockdep.c:2987 [inline]
>  validate_chain kernel/locking/lockdep.c:3776 [inline]
>  __lock_acquire.cold+0x149/0x3ab kernel/locking/lockdep.c:5015
>  lock_acquire kernel/locking/lockdep.c:5625 [inline]
>  lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
>  lock_sock_fast+0x36/0x100 net/core/sock.c:3229
>  mptcp_close+0x267/0x7b0 net/mptcp/protocol.c:2738
>  inet_release+0x12e/0x280 net/ipv4/af_inet.c:431
>  __sock_release net/socket.c:649 [inline]
>  sock_release+0x87/0x1b0 net/socket.c:677
>  mptcp_pm_nl_create_listen_socket+0x238/0x2c0 net/mptcp/pm_netlink.c:900
>  mptcp_nl_cmd_add_addr+0x359/0x930 net/mptcp/pm_netlink.c:1170
>  genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
>  genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
>  genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:792
>  netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
>  genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
>  netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
>  netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
>  sock_sendmsg_nosec net/socket.c:704 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:724
>  sock_no_sendpage+0x101/0x150 net/core/sock.c:2980
>  kernel_sendpage.part.0+0x1a0/0x340 net/socket.c:3504
>  kernel_sendpage net/socket.c:3501 [inline]
>  sock_sendpage+0xe5/0x140 net/socket.c:1003
>  pipe_to_sendpage+0x2ad/0x380 fs/splice.c:364
>  splice_from_pipe_feed fs/splice.c:418 [inline]
>  __splice_from_pipe+0x43e/0x8a0 fs/splice.c:562
>  splice_from_pipe fs/splice.c:597 [inline]
>  generic_splice_sendpage+0xd4/0x140 fs/splice.c:746
>  do_splice_from fs/splice.c:767 [inline]
>  direct_splice_actor+0x110/0x180 fs/splice.c:936
>  splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
>  do_splice_direct+0x1b3/0x280 fs/splice.c:979
>  do_sendfile+0xae9/0x1240 fs/read_write.c:1249
>  __do_sys_sendfile64 fs/read_write.c:1314 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1300 [inline]
>  __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f215cb69969
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc96bb3868 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007f215cbad072 RCX: 00007f215cb69969
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 00007ffc96bb3a08 R09: 00007ffc96bb3a08
> R10: 0000000100000002 R11: 0000000000000246 R12: 00007ffc96bb387c
> R13: 431bde82d7b634db R14: 0000000000000000 R15: 000000000000000

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git master

whoops, a chunk was lost in my previous attempt...
---
commit 189a9054edbe8be3fe312ac6f0e5ce9e13eee1b6
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Wed Sep 22 19:36:47 2021 +0200

    net: introduce and use lock_sock_fast_nested()
    
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/include/net/sock.h b/include/net/sock.h
index c005c3c750e8..3111b6f0882b 100644
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
+static inline bool lock_sock_fast_nested(struct sock *sk)
+{
+	/* The sk_lock has mutex_lock() semantics here. */
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
index 6b334f9b6242..dcfc2186a583 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2746,8 +2746,12 @@ static void mptcp_close(struct sock *sk, long timeout)
 	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
+		bool slow;
 
+		/* can be nested in netlink mutex, when invoked by
+		 * the PM
+		 */
+		slow = lock_sock_fast_nested(ssk);
 		sock_orphan(ssk);
 		unlock_sock_fast(ssk, slow);
 	}

