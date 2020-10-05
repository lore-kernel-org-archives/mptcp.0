Content-Type: multipart/mixed; boundary="===============8758305362990984391=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: INFO: task hung in lock_sock_nested (3)
Date: Mon, 05 Oct 2020 22:22:56 +0200
Message-ID: <003589e3dce1ed8d9b9970bbf8ed1661ced8d2cc.camel@redhat.com>
In-Reply-To: 00000000000009067705b0ef9cbd@google.com
X-Status: 
X-Keywords:                  
X-UID: 6205

--===============8758305362990984391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-10-05 at 10:14 -0700, syzbot wrote:
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 2648 Comm: kworker/1:3 Not tainted 5.9.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
> Workqueue: events mptcp_worker
> RIP: 0010:check_memory_region+0x134/0x180 mm/kasan/generic.c:193
> Code: 85 d2 75 0b 48 89 da 48 29 c2 e9 55 ff ff ff 49 39 d2 75 17 49 0f b=
e 02 41 83 e1 07 49 39 c1 7d 0a 5b b8 01 00 00 00 5d 41 5c <c3> 44 89 c2 e8=
 e3 ef ff ff 5b 83 f0 01 5d 41 5c c3 48 29 c3 48 89
> RSP: 0018:ffffc90008d4f868 EFLAGS: 00000046
> RAX: 0000000000000001 RBX: 0000000000000002 RCX: ffffffff815bc144
> RDX: fffffbfff1a21b52 RSI: 0000000000000008 RDI: ffffffff8d10da88
> RBP: ffff88809f3ee100 R08: 0000000000000000 R09: ffffffff8d10da8f
> R10: fffffbfff1a21b51 R11: 0000000000000000 R12: 0000000000000579
> R13: 0000000000000004 R14: dffffc0000000000 R15: ffff88809f3eea08
> FS:  0000000000000000(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000558030ecfd70 CR3: 0000000091828000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  instrument_atomic_read include/linux/instrumented.h:56 [inline]
>  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inlin=
e]
>  hlock_class kernel/locking/lockdep.c:179 [inline]
>  check_wait_context kernel/locking/lockdep.c:4140 [inline]
>  __lock_acquire+0x704/0x5780 kernel/locking/lockdep.c:4391
>  lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5029
>  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
>  _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
>  spin_lock_bh include/linux/spinlock.h:359 [inline]
>  lock_sock_nested+0x3b/0x110 net/core/sock.c:3041
>  lock_sock include/net/sock.h:1581 [inline]
>  __mptcp_move_skbs+0x1fb/0x510 net/mptcp/protocol.c:1469
>  mptcp_worker+0x19f/0x15b0 net/mptcp/protocol.c:1726
>  process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>  kthread+0x3b5/0x4a0 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Looks like we are looping in __mptcp_move_skbs(), so let's try another
attempt.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git=
 master
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f483eab0081a..42928db28351 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -471,8 +471,15 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 				mptcp_subflow_get_map_offset(subflow);
 =

 		skb =3D skb_peek(&ssk->sk_receive_queue);
-		if (!skb)
+		if (!skb) {
+			/* if no data is found, a racing workqueue/recvmsg
+			 * already processed the new data, stop here or we
+			 * can enter an infinite loop
+			 */
+			if (!moved)
+				done =3D true;
 			break;
+		}
 =

 		if (__mptcp_check_fallback(msk)) {
 			/* if we are running under the workqueue, TCP could have

--===============8758305362990984391==--
