Content-Type: multipart/mixed; boundary="===============7800657882292102619=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [syzkaller] KASAN: slab-out-of-bounds Write in
 tcp_mstamp_refresh
Date: Fri, 24 Jan 2020 11:20:18 -0800
Message-ID: <20200124192018.GK60524@MacBook-Pro-64.local>
In-Reply-To: 20200124175550.GX795@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3503

--===============7800657882292102619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 24/01/20 - 18:55:50, Florian Westphal wrote:
> Christoph Paasch <cpaasch(a)apple.com> wrote:
> > One more:
> > =

> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-out-of-bounds in tcp_mstamp_refresh+0x80/0xa0 net/ipv4=
/tcp_output.c:57
> > Write of size 8 at addr ffff888116aa21d0 by task syz-executor.0/5478
> =

> Ugh.
> =

> >  tcp_mstamp_refresh+0x80/0xa0 net/ipv4/tcp_output.c:57
> >  tcp_rcv_space_adjust+0x72/0x7f0 net/ipv4/tcp_input.c:612
> >  tcp_read_sock+0x622/0x990 net/ipv4/tcp.c:1674
> >  __tcp_splice_read net/ipv4/tcp.c:749 [inline]
> >  tcp_splice_read+0x20b/0xb40 net/ipv4/tcp.c:791
> >  sock_splice_read+0xb9/0x120 net/socket.c:962
> >  do_splice_to+0x111/0x160 fs/splice.c:892
> >  do_splice+0x1259/0x1560 fs/splice.c:1205
> >  __do_sys_splice fs/splice.c:1447 [inline]
> >  __se_sys_splice fs/splice.c:1427 [inline]
> >  __x64_sys_splice+0x2b7/0x320 fs/splice.c:1427
> >  do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
> =

> mptcp allows calls into tcp proto ops on mptcp socket.
> =

> I'm trying a fix shortly.

Got another one:
BUG: KASAN: slab-out-of-bounds in tcp_rcv_space_adjust+0x75a/0x7f0 net/ipv4=
/tcp_input.c:613

(full trace at the bottom)

I guess it's the same


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in tcp_rcv_space_adjust+0x75a/0x7f0 net/ipv4=
/tcp_input.c:613
Read of size 8 at addr ffff8880aa8d1ca0 by task syz-executor.6/5975

CPU: 1 PID: 5975 Comm: syz-executor.6 Not tainted 5.5.0-rc6 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga=
5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
 __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:639
 tcp_rcv_space_adjust+0x75a/0x7f0 net/ipv4/tcp_input.c:613
 tcp_read_sock+0x622/0x990 net/ipv4/tcp.c:1674
 __tcp_splice_read net/ipv4/tcp.c:749 [inline]
 tcp_splice_read+0x20b/0xb40 net/ipv4/tcp.c:791
 sock_splice_read+0xb9/0x120 net/socket.c:962
 do_splice_to+0x111/0x160 fs/splice.c:892
 do_splice+0x1259/0x1560 fs/splice.c:1205
 __do_sys_splice fs/splice.c:1447 [inline]
 __se_sys_splice fs/splice.c:1427 [inline]
 __x64_sys_splice+0x2b7/0x320 fs/splice.c:1427
 do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fe662b1d469
Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
syz-executor.2 (5985) used greatest stack depth: 22656 bytes left
RSP: 002b:00007fe6631ecdd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 000000000066bfa8 RCX: 00007fe662b1d469
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000ffffffff R08: 0000000000080007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000b38
R13: 000000000041e1c1 R14: 00007fe6631ed5c0 R15: 0000000000000003

Allocated by task 0:
(stack is not available)

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8880aa8d1b00
 which belongs to the cache MPTCPv6 of size 2160
The buggy address is located 416 bytes inside of
 2160-byte region [ffff8880aa8d1b00, ffff8880aa8d2370)
The buggy address belongs to the page:
page:ffffea0002aa3400 refcount:1 mapcount:0 mapping:ffff888115fc3400 index:=
0x0 compound_mapcount: 0
raw: 0100000000010200 dead000000000100 dead000000000122 ffff888115fc3400
raw: 0000000000000000 00000000800e000e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880aa8d1b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880aa8d1c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880aa8d1c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff8880aa8d1d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880aa8d1d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--===============7800657882292102619==--
