Content-Type: multipart/mixed; boundary="===============2607750308241944151=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Fwd: possible deadlock in ipv6_sock_mc_close
Date: Mon, 01 Mar 2021 14:58:53 +0100
Message-ID: <5e22fa38-59be-397b-e800-db5f3de0c6b1@tessares.net>
In-Reply-To: 0000000000001d8e2c05bc79e2fd@google.com
X-Status: 
X-Keywords:                  
X-UID: 7971

--===============2607750308241944151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

This report from syzbot mentioned an possible deadlock with MPTCP =

socket. I don't know if the commit from nfsd is really causing that.

I'm then sharing this with the list just in case someone saw similar =

issues :)

Cheers,
Matt


-------- Forwarded Message --------
Subject: possible deadlock in ipv6_sock_mc_close
Date: Mon, 01 Mar 2021 05:49:14 -0800
From: syzbot <syzbot+e2fa57709a385e6db10f(a)syzkaller.appspotmail.com>
To: bfields(a)fieldses.org, chuck.lever(a)oracle.com, davem(a)davemloft.net=
, =

dsahern(a)kernel.org, kuba(a)kernel.org, linux-kernel(a)vger.kernel.org, =

linux-nfs(a)vger.kernel.org, netdev(a)vger.kernel.org, =

syzkaller-bugs(a)googlegroups.com, yoshfuji(a)linux-ipv6.org

Hello,

syzbot found the following issue on:

HEAD commit:    eee7ede6 Merge branch 'bnxt_en-error-recovery-bug-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=3D123ad632d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3De2d5ba72abae4f14
dashboard link: https://syzkaller.appspot.com/bug?extid=3De2fa57709a385e6db=
10f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D109d89b6d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12e9e0dad00000

The issue was bisected to:

commit c8e88e3aa73889421461f878cd569ef84f231ceb
Author: Chuck Lever <chuck.lever(a)oracle.com>
Date:   Tue Nov 3 20:06:04 2020 +0000

     NFSD: Replace READ* macros in nfsd4_decode_layoutget()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13bef9ccd000=
00
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D107ef9ccd000=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D17bef9ccd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2fa57709a385e6db10f(a)syzkaller.appspotmail.com
Fixes: c8e88e3aa738 ("NFSD: Replace READ* macros in =

nfsd4_decode_layoutget()")

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
5.11.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor905/8822 is trying to acquire lock:
ffffffff8d678fe8 (rtnl_mutex){+.+.}-{3:3}, at: =

ipv6_sock_mc_close+0xd7/0x110 net/ipv6/mcast.c:323

but task is already holding lock:
ffff888024390120 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock =

include/net/sock.h:1600 [inline]
ffff888024390120 (sk_lock-AF_INET6){+.+.}-{0:0}, at: =

mptcp6_release+0x57/0x130 net/mptcp/protocol.c:3507

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
        lock_sock_nested+0xca/0x120 net/core/sock.c:3071
        lock_sock include/net/sock.h:1600 [inline]
        gtp_encap_enable_socket+0x277/0x4a0 drivers/net/gtp.c:824
        gtp_encap_enable drivers/net/gtp.c:855 [inline]
        gtp_newlink+0x2b3/0xc60 drivers/net/gtp.c:683
        __rtnl_newlink+0x1059/0x1710 net/core/rtnetlink.c:3443
        rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3491
        rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5553
        netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2502
        netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
        netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
        netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1927
        sock_sendmsg_nosec net/socket.c:654 [inline]
        sock_sendmsg+0xcf/0x120 net/socket.c:674
        ____sys_sendmsg+0x6e8/0x810 net/socket.c:2350
        ___sys_sendmsg+0xf3/0x170 net/socket.c:2404
        __sys_sendmsg+0xe5/0x1b0 net/socket.c:2437
        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
        entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (rtnl_mutex){+.+.}-{3:3}:
        check_prev_add kernel/locking/lockdep.c:2936 [inline]
        check_prevs_add kernel/locking/lockdep.c:3059 [inline]
        validate_chain kernel/locking/lockdep.c:3674 [inline]
        __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
        lock_acquire kernel/locking/lockdep.c:5510 [inline]
        lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
        __mutex_lock_common kernel/locking/mutex.c:946 [inline]
        __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1093
        ipv6_sock_mc_close+0xd7/0x110 net/ipv6/mcast.c:323
        mptcp6_release+0xb9/0x130 net/mptcp/protocol.c:3515
        __sock_release+0xcd/0x280 net/socket.c:599
        sock_close+0x18/0x20 net/socket.c:1258
        __fput+0x288/0x920 fs/file_table.c:280
        task_work_run+0xdd/0x1a0 kernel/task_work.c:140
        tracehook_notify_resume include/linux/tracehook.h:189 [inline]
        exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
        exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:208
        __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
        syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:301
        entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(sk_lock-AF_INET6);
                                lock(rtnl_mutex);
                                lock(sk_lock-AF_INET6);
   lock(rtnl_mutex);

  *** DEADLOCK ***

2 locks held by syz-executor905/8822:
  #0: ffff888033080750 (&sb->s_type->i_mutex_key#13){+.+.}-{3:3}, at: =

inode_lock include/linux/fs.h:775 [inline]
  #0: ffff888033080750 (&sb->s_type->i_mutex_key#13){+.+.}-{3:3}, at: =

__sock_release+0x86/0x280 net/socket.c:598
  #1: ffff888024390120 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock =

include/net/sock.h:1600 [inline]
  #1: ffff888024390120 (sk_lock-AF_INET6){+.+.}-{0:0}, at: =

mptcp6_release+0x57/0x130 net/mptcp/protocol.c:3507

stack backtrace:
CPU: 1 PID: 8822 Comm: syz-executor905 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =

Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:79 [inline]
  dump_stack+0xfa/0x151 lib/dump_stack.c:120
  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2127
  check_prev_add kernel/locking/lockdep.c:2936 [inline]
  check_prevs_add kernel/locking/lockdep.c:3059 [inline]
  validate_chain kernel/locking/lockdep.c:3674 [inline]
  __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
  lock_acquire kernel/locking/lockdep.c:5510 [inline]
  lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
  __mutex_lock_common kernel/locking/mutex.c:946 [inline]
  __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1093
  ipv6_sock_mc_close+0xd7/0x110 net/ipv6/mcast.c:323
  mptcp6_release+0xb9/0x130 net/mptcp/protocol.c:3515
  __sock_release+0xcd/0x280 net/socket.c:599
  sock_close+0x18/0x20 net/socket.c:1258
  __fput+0x288/0x920 fs/file_table.c:280
  task_work_run+0xdd/0x1a0 kernel/task_work.c:140
  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
  exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
  exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:208
  __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
  syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x405b73
Code: c7 c2 c0 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f =

00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 =

f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
RSP: 002b:00007ffdbac4d208 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000405b73
RDX: 000000000000002a RSI: 0000000000000029 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000088 R09: 0000000000f0b5ff
R10: 00000000200001c0 R11: 0000000000000246 R12: 0000000000010bda
R13: 00007ffdbac4d230 R14: 00007ffdbac4d220 R15: 00007ffdbac4d214


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller(a)googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
--===============2607750308241944151==--
