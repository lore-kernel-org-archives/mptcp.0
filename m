Content-Type: multipart/mixed; boundary="===============6174530705733181834=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [syzkaller] general protection fault in
 __mptcp_flush_join_list
Date: Sun, 29 Mar 2020 11:14:12 -0700
Message-ID: <20200329181412.GB14672@MacBook-Pro-64.local>
X-Status: 
X-Keywords:                  
X-UID: 4104

--===============6174530705733181834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

another one - on top of 402d1b0dc2e1 (yes, it's a week old - I wanted to
let syzkaller deep-dive a bit).

general protection fault, probably for non-canonical address 0xfe85e717fe88=
a633: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 2874 Comm: syz-executor072 Not tainted 5.6.0-rc5 #62
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga=
5cab58e9a3f-prebuilt.qemu.org 04/01/2014
RIP: 0010:__write_once_size include/linux/compiler.h:226 [inline]
RIP: 0010:__pv_queued_spin_lock_slowpath+0x1b3/0x2f0 kernel/locking/qspinlo=
ck.c:471
Code: c5 c1 ea 12 41 bf 01 00 00 00 8d 42 ff 41 83 e5 03 4c 8d 73 14 49 c1 =
e5 05 48 98 49 81 c5 00 bf 02 00 4c 03 2c c5 a0 11 86 82 <49> 89 5d 00 b8 0=
0 80 00 00 eb 14 84 c0 75 09 41 0f b6 55 14 84 d2
RSP: 0018:ffffc9000017bdf8 EFLAGS: 00010286
RAX: 000000000000130d RBX: ffff88807dc2bf00 RCX: 0000000000000001
RDX: 000000000000130e RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffffc9000017be30 R08: ffff88807b6a11c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807b783844
R13: fe85e717fe88a633 R14: ffff88807dc2bf14 R15: 0000000000000001
FS:  00007f8886bbe700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558feddd6040 CR3: 000000007d668002 CR4: 0000000000160ef0
Call Trace:
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:645 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:81 [inline]
 do_raw_spin_lock include/linux/spinlock.h:181 [inline]
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
 _raw_spin_lock_bh+0x36/0x40 kernel/locking/spinlock.c:175
 spin_lock_bh include/linux/spinlock.h:343 [inline]
 __mptcp_flush_join_list+0x44/0xb0 net/mptcp/protocol.c:278
 mptcp_shutdown+0xb3/0x230 net/mptcp/protocol.c:1882
 __sys_shutdown+0x58/0xc0 net/socket.c:2206
 __do_sys_shutdown net/socket.c:2214 [inline]
 __se_sys_shutdown net/socket.c:2212 [inline]
 __x64_sys_shutdown+0x1a/0x20 net/socket.c:2212
 do_syscall_64+0x91/0x2f0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f88864cb469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe7ee181e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000030
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f88864cb469
RDX: 00007f88864cb469 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000400720 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000040063f
R13: 00007ffe7ee182d0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 36f808cc99a201d3 ]---
RIP: 0010:__write_once_size include/linux/compiler.h:226 [inline]
RIP: 0010:__pv_queued_spin_lock_slowpath+0x1b3/0x2f0 kernel/locking/qspinlo=
ck.c:471
Code: c5 c1 ea 12 41 bf 01 00 00 00 8d 42 ff 41 83 e5 03 4c 8d 73 14 49 c1 =
e5 05 48 98 49 81 c5 00 bf 02 00 4c 03 2c c5 a0 11 86 82 <49> 89 5d 00 b8 0=
0 80 00 00 eb 14 84 c0 75 09 41 0f b6 55 14 84 d2
RSP: 0018:ffffc9000017bdf8 EFLAGS: 00010286
RAX: 000000000000130d RBX: ffff88807dc2bf00 RCX: 0000000000000001
RDX: 000000000000130e RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffffc9000017be30 R08: ffff88807b6a11c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807b783844
R13: fe85e717fe88a633 R14: ffff88807dc2bf14 R15: 0000000000000001
FS:  00007f8886bbe700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558feddd6040 CR3: 000000007d668002 CR4: 0000000000160ef0

Syzkaller reproducer:

# {Threaded:false Collide:false Repeat:false RepeatTimes:0 Procs:1 Sandbox:=
 Fault:false FaultCall:-1 FaultNth:0 Leak:false NetInjection:false NetDevic=
es:false NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN=
:false DevlinkPCI:false UseTmpDir:false HandleSegv:false Repro:false Trace:=
false}
r0 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
r1 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
bind$inet(r1, &(0x7f00000013c0)=3D{0x2, 0x4e20, @multicast2}, 0x10)
connect$inet(r1, &(0x7f0000000040)=3D{0x2, 0x0, @loopback}, 0x10)
listen(r1, 0x0)
connect$inet(r0, &(0x7f0000000040)=3D{0x2, 0x4e20, @loopback}, 0x10)
r2 =3D accept(r1, 0x0, 0x0)
shutdown(r2, 0x0)

C-repro:
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

uint64_t r[3] =3D {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffff=
ff};

int main(void)
{
  syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0ul);
  intptr_t res =3D 0;
  res =3D syscall(__NR_socket, 2ul, 1ul, 0x106);
  if (res !=3D -1)
    r[0] =3D res;
  res =3D syscall(__NR_socket, 2ul, 1ul, 0x106);
  if (res !=3D -1)
    r[1] =3D res;
  *(uint16_t*)0x200013c0 =3D 2;
  *(uint16_t*)0x200013c2 =3D htobe16(0x4e20);
  *(uint32_t*)0x200013c4 =3D htobe32(0xe0000002);
  syscall(__NR_bind, r[1], 0x200013c0ul, 0x10ul);
  *(uint16_t*)0x20000040 =3D 2;
  *(uint16_t*)0x20000042 =3D htobe16(0);
  *(uint32_t*)0x20000044 =3D htobe32(0x7f000001);
  syscall(__NR_connect, r[1], 0x20000040ul, 0x10ul);
  syscall(__NR_listen, r[1], 0);
  *(uint16_t*)0x20000040 =3D 2;
  *(uint16_t*)0x20000042 =3D htobe16(0x4e20);
  *(uint32_t*)0x20000044 =3D htobe32(0x7f000001);
  syscall(__NR_connect, r[0], 0x20000040ul, 0x10ul);
  res =3D syscall(__NR_accept, r[1], 0ul, 0ul);
  if (res !=3D -1)
    r[2] =3D res;
  syscall(__NR_shutdown, r[2], 0ul);
  return 0;
}


Cheers,
Christoph

--===============6174530705733181834==--
