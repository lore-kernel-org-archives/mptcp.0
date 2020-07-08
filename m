Content-Type: multipart/mixed; boundary="===============4675983819132015961=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: inet_diag: support for wider protocol
 numbers
Date: Tue, 07 Jul 2020 17:01:56 -0700
Message-ID: <20200708000156.88520-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 4941

--===============4675983819132015961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now running syzkaller with lockdep enabled:
Syzkaller hit 'WARNING: bad unlock balance in inet_diag_cmd_exact' bug.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
WARNING: bad unlock balance detected!
5.8.0-rc2 #11 Not tainted
-------------------------------------
syz-executor685/1264 is trying to release lock (inet_diag_table_mutex) at:
[<ffffffff81b9e922>] inet_diag_unlock_handler net/ipv4/inet_diag.c:70 [inli=
ne]
[<ffffffff81b9e922>] inet_diag_cmd_exact+0xb2/0x1d0 net/ipv4/inet_diag.c:593
but there are no more locks to release!

other info that might help us debug this:
2 locks held by syz-executor685/1264:
 #0: ffffffff826d3408 (sock_diag_mutex){+.+.}-{3:3}, at: sock_diag_rcv+0x17=
/0x40 net/core/sock_diag.c:274
 #1: ffffffff826d34a8 (sock_diag_table_mutex){+.+.}-{3:3}, at: sock_diag_rc=
v_msg net/core/sock_diag.c:254 [inline]
 #1: ffffffff826d34a8 (sock_diag_table_mutex){+.+.}-{3:3}, at: sock_diag_rc=
v_msg+0x160/0x1f0 net/core/sock_diag.c:243

stack backtrace:
CPU: 1 PID: 1264 Comm: syz-executor685 Not tainted 5.8.0-rc2 #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf=
21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd4/0x13e lib/dump_stack.c:118
 __lock_release kernel/locking/lockdep.c:4669 [inline]
 lock_release+0x1a9/0x260 kernel/locking/lockdep.c:4977
 __mutex_unlock_slowpath+0x40/0x2a0 kernel/locking/mutex.c:1228
 inet_diag_unlock_handler net/ipv4/inet_diag.c:70 [inline]
 inet_diag_cmd_exact+0xb2/0x1d0 net/ipv4/inet_diag.c:593
 inet_diag_get_exact_compat+0xcf/0xf0 net/ipv4/inet_diag.c:1267
 inet_diag_rcv_msg_compat+0x89/0x120 net/ipv4/inet_diag.c:1289
 __sock_diag_cmd net/core/sock_diag.c:235 [inline]
 sock_diag_rcv_msg+0x17c/0x1f0 net/core/sock_diag.c:264
 netlink_rcv_skb+0x61/0x1d0 net/netlink/af_netlink.c:2469
 sock_diag_rcv+0x26/0x40 net/core/sock_diag.c:275
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x2cd/0x3e0 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x33a/0x640 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x3fb/0x460 net/socket.c:2363
 ___sys_sendmsg+0x97/0xe0 net/socket.c:2417
 __sys_sendmsg+0x88/0x100 net/socket.c:2450
 do_syscall_64+0x56/0xa0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f8859496469
Code: Bad RIP value.
RSP: 002b:00007ffdcedb3448 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8859496469
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 0000000000400ba0 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000400951
R13: 00007ffdcedb3530 R14: 0000000000000000 R15: 0000000000000000

inet_diag_lock_handler is supposed to exit always with the lock held.
So, even if proto is out-of-bounds let's take the lock.

Another way to fix that would be to teach to the callers whether or not
inet_diag_lock_handler ended up taking the lock or not (by returning
-EINVAL instead). But that looks more brittle to me as the intention of
inet_diag_lock_handler really is to take the lock.

Fixes: fb8fdf47ab59 ("inet_diag: support for wider protocol numbers")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/inet_diag.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 44a7c2dddd33..4a98dd736270 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -52,8 +52,10 @@ static DEFINE_MUTEX(inet_diag_table_mutex);
 =

 static const struct inet_diag_handler *inet_diag_lock_handler(int proto)
 {
-	if (proto < 0 || proto >=3D IPPROTO_MAX)
+	if (proto < 0 || proto >=3D IPPROTO_MAX) {
+		mutex_lock(&inet_diag_table_mutex);
 		return ERR_PTR(-ENOENT);
+	}
 =

 	if (!inet_diag_table[proto])
 		sock_load_diag_module(AF_INET, proto);
-- =

2.23.0

--===============4675983819132015961==--
