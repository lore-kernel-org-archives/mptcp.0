Content-Type: multipart/mixed; boundary="===============0406097885237028176=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: BUG: KASAN: slab-out-of-bounds in
 subflow_ulp_init+0xa6/0x190
Date: Fri, 06 Mar 2020 15:18:25 -0800
Message-ID: <alpine.OSX.2.22.394.2003061514480.63163@mlee22-mobl.amr.corp.intel.com>
In-Reply-To: 20200306230850.GQ33310@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 3893

--===============0406097885237028176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 6 Mar 2020, Christoph Paasch wrote:

> Hello,
>
> I wanted to do some testing on netnext so I did a little hack to
> force-enable MPTCP without the need for the app to use IPPROTO_MPTCP:
>
> diff --git a/net/socket.c b/net/socket.c
> index b79a05de7c6e..56c656b4f867 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1374,6 +1374,9 @@ int __sock_create(struct net *net, int family, int =
type, int protocol,
> 	if (type < 0 || type >=3D SOCK_MAX)
> 		return -EINVAL;
>
> +	if (protocol =3D=3D IPPROTO_TCP && type =3D=3D SOCK_STREAM && (family =
=3D=3D AF_INET || family =3D=3D AF_INET6))
> +		protocol =3D IPPROTO_MPTCP;
> +

I think the subflow kernel sockets go down this code path too, maybe add =

!kern to the conditions?


Mat


> 	/* Compatibility.
>
> 	   This uglymoron is moved from INET layer to here to avoid
>
>
>
> Now, when I boot I panic right away because sshd binds a socket:
>
> [   14.759548] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   14.760746] BUG: KASAN: slab-out-of-bounds in subflow_ulp_init+0xa6/0x=
190
> [   14.762025] Write of size 1 at addr ffff888114e40f04 by task sshd/1229
> [   14.763222]
> [   14.763506] CPU: 3 PID: 1229 Comm: sshd Not tainted 5.6.0-rc3.mptcp #67
> [   14.764546] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [   14.766340] Call Trace:
> [   14.766716]  dump_stack+0x76/0xa0
> [   14.767302]  print_address_description.constprop.0+0x36/0x50
> [   14.768309]  ? subflow_ulp_init+0xa6/0x190
> [   14.768916]  __kasan_report.cold+0x1c/0x3f
> [   14.769805]  ? subflow_ulp_init+0xa6/0x190
> [   14.770450]  ? subflow_ulp_init+0xa6/0x190
> [   14.771014]  kasan_report+0xe/0x20
> [   14.771537]  subflow_ulp_init+0xa6/0x190
> [   14.772095]  tcp_set_ulp+0xeb/0x180
> [   14.772605]  mptcp_subflow_create_socket+0x178/0x260
> [   14.773337]  ? mptcpv6_handle_mapped+0x90/0x90
> [   14.773965]  ? __kasan_kmalloc.constprop.0+0xc2/0xd0
> [   14.774687]  ? __might_sleep+0x2c/0xc0
> [   14.775448]  ? mptcp_release_cb+0x3b/0x110
> [   14.776030]  __mptcp_socket_create+0x11c/0x1e0
> [   14.776685]  ? _raw_spin_lock_bh+0x80/0xd0
> [   14.777282]  ? mptcp_shutdown+0x150/0x150
> [   14.778136]  ? __might_sleep+0x2c/0xc0
> [   14.778912]  ? ___might_sleep+0xb5/0xd0
> [   14.779687]  mptcp_bind+0x3a/0xc0
> [   14.780350]  __sys_bind+0x13b/0x160
> [   14.780886]  ? __x64_sys_socketpair+0x60/0x60
> [   14.781565]  ? __sys_setsockopt+0x15b/0x170
> [   14.782211]  ? __x64_sys_fcntl+0x76c/0x890
> [   14.782870]  ? kernel_accept+0x140/0x140
> [   14.783493]  ? f_getown+0x70/0x70
> [   14.784017]  ? __sys_socket+0xf0/0x160
> [   14.784614]  ? move_addr_to_kernel+0x20/0x20
> [   14.785212]  __x64_sys_bind+0x39/0x40
> [   14.785732]  do_syscall_64+0xbc/0x790
> [   14.786247]  ? syscall_return_slowpath+0x320/0x320
> [   14.786924]  ? up_read+0x10/0x70
> [   14.787400]  ? do_page_fault+0x447/0x5ef
> [   14.787960]  ? fpregs_assert_state_consistent+0x4d/0x60
> [   14.788690]  ? prepare_exit_to_usermode+0xab/0x1c0
> [   14.789391]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   14.790281] RIP: 0033:0x7f420ce3e497
> [   14.790927] Code: ff ff ff ff c3 48 8b 15 f7 09 0c 00 f7 d8 64 89 02 b=
8 ff ff ff ff eb ba 66 2e 0f 1f 84 00 00 00 00 00 90 b8 31 008
> [   14.793565] RSP: 002b:00007ffed3aab688 EFLAGS: 00000206 ORIG_RAX: 0000=
000000000031
> [   14.793574] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f420=
ce3e497
> [   14.793575] RDX: 0000000000000010 RSI: 0000559b2d76c720 RDI: 000000000=
0000003
> [   14.793576] RBP: 00007ffed3aaba70 R08: 0000000000000004 R09: 00007ffed=
3aaad76
> [   14.793577] R10: 00007ffed3aab664 R11: 0000000000000206 R12: 00007ffed=
3aabb70
> [   14.793579] R13: 0000559b2d76f410 R14: 0000559b2d76c6f0 R15: 0000559b2=
d57c5c0
> [   14.793581]
> [   14.793586] Allocated by task 0:
> [   14.715787] k[   14.793586] (stack is not available)
> dump-tools[   14.793587]
> [   14.793590] Freed by task 0:
> [   14.793590] (stack is not available)
> [   14.793591]
> [   14.793593] The buggy address belongs to the object at ffff888114e40d00
> [   14.793593]  which belongs to the cache MPTCP of size 1480
> [1200]: [   14.793594] The buggy address is located 516 bytes inside of
> [   14.793594]  1480-byte region [ffff888114e40d00, ffff888114e412c8)
> [   14.793595] The buggy address belongs to the page:
> [   14.793602] page:ffffea0004539000 refcount:1 mapcount:0 mapping:ffff88=
811a645cc0 index:0x0 compound_mapcount: 0
> [   14.793609] flags: 0x8000000000010200(slab|head)
> Starting kdump-t[   14.809675] raw: 8000000000010200 dead000000000100 dea=
d000000000122 ffff88811a645cc0
> ools: no crashke[   14.809677] raw: 0000000000000000 0000000080130013 000=
00001ffffffff 0000000000000000
> rnel=3D parameter [   14.809678] page dumped because: kasan: bad access d=
etected
> in the kernel cm[   14.809679]
> dline ... failed[   14.809679] Memory state around the buggy address:
> ![   14.809682]  ffff888114e40e00: fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc fc
> [   14.809683]  ffff888114e40e80: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   14.809685] >ffff888114e40f00: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   14.809686]                    ^
> [   14.809687]  ffff888114e40f80: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
>
> [   14.809689]  ffff888114e41000: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   14.809689] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Do you think this is just due to me forcing IPPROTO_MPTCP ?
>
>
> Christoph
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============0406097885237028176==--
