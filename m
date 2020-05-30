Content-Type: multipart/mixed; boundary="===============8306070669637997390=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Crashers on netnext with apache-benchmark
Date: Fri, 29 May 2020 17:41:00 -0700
Message-ID: <20200530004100.GR64606@MacBook-Pro-64.local>
In-Reply-To: 20200529201955.GP64606@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4565

--===============8306070669637997390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/29/20 - 13:19, Christoph Paasch wrote:
> On 05/29/20 - 13:11, Christoph Paasch wrote:
> > On 05/29/20 - 22:04, Paolo Abeni wrote:
> > > On Tue, 2020-05-26 at 17:28 -0700, Christoph Paasch wrote:
> > > > And another one:
> > > > =

> > > > [   62.586401] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > [   62.588813] BUG: KASAN: use-after-free in inet_twsk_bind_unhash+=
0x5f/0xe0
> > > > [   62.589975] Write of size 8 at addr ffff88810f155a20 by task kso=
ftirqd/2/21
> > > > [   62.591194]
> > > > [   62.591485] CPU: 2 PID: 21 Comm: ksoftirqd/2 Kdump: loaded Not t=
ainted 5.7.0-rc6.mptcp #36
> > > > [   62.593067] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> > > > [   62.595268] Call Trace:
> > > > [   62.595775]  dump_stack+0x76/0xa0
> > > > [   62.596448]  print_address_description.constprop.0+0x3a/0x60
> > > > [   62.600581]  __kasan_report.cold+0x20/0x3b
> > > > [   62.602968]  kasan_report+0x38/0x50
> > > > [   62.603561]  inet_twsk_bind_unhash+0x5f/0xe0
> > > > [   62.604282]  inet_twsk_kill+0x195/0x200
> > > > [   62.604945]  inet_twsk_deschedule_put+0x25/0x30
> > > > [   62.605731]  tcp_v4_rcv+0xa79/0x15e0
> > > > [   62.607139]  ip_protocol_deliver_rcu+0x37/0x270
> > > > [   62.607980]  ip_local_deliver_finish+0xb0/0xd0
> > > > [   62.608758]  ip_local_deliver+0x1c9/0x1e0
> > > > [   62.611162]  ip_sublist_rcv_finish+0x84/0xa0
> > > > [   62.611894]  ip_sublist_rcv+0x22c/0x320
> > > > [   62.616143]  ip_list_rcv+0x1e4/0x225
> > > > [   62.619427]  __netif_receive_skb_list_core+0x439/0x460
> > > > [   62.622771]  netif_receive_skb_list_internal+0x3ea/0x570
> > > > [   62.625320]  gro_normal_list.part.0+0x14/0x50
> > > > [   62.626088]  napi_gro_receive+0x6a/0xb0
> > > > [   62.626787]  receive_buf+0x371/0x1d50
> > > > [   62.632092]  virtnet_poll+0x2be/0x5b0
> > > > [   62.634099]  net_rx_action+0x1ec/0x4c0
> > > > [   62.636132]  __do_softirq+0xfc/0x29c
> > > > [   62.638180]  run_ksoftirqd+0x15/0x30
> > > > [   62.638787]  smpboot_thread_fn+0x1fc/0x380
> > > > [   62.642009]  kthread+0x1f1/0x210
> > > > [   62.643478]  ret_from_fork+0x35/0x40
> > > > [   62.644094]
> > > > [   62.644371] Allocated by task 1355:
> > > > [   62.644980]  save_stack+0x1b/0x40
> > > > [   62.645539]  __kasan_kmalloc.constprop.0+0xc2/0xd0
> > > > [   62.646347]  kmem_cache_alloc+0xb8/0x190
> > > > [   62.647006]  getname_flags+0x6b/0x2b0
> > > > [   62.647627]  user_path_at_empty+0x1b/0x40
> > > > [   62.648306]  vfs_statx+0xba/0x140
> > > > [   62.648875]  __do_sys_newstat+0x8c/0xf0
> > > > [   62.649518]  do_syscall_64+0xbc/0x790
> > > > [   62.650199]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > [   62.651091]
> > > > [   62.651360] Freed by task 1355:
> > > > [   62.651903]  save_stack+0x1b/0x40
> > > > [   62.652460]  __kasan_slab_free+0x12f/0x180
> > > > [   62.653147]  kmem_cache_free+0x87/0x240
> > > > [   62.653795]  filename_lookup+0x183/0x250
> > > > [   62.654447]  vfs_statx+0xba/0x140
> > > > [   62.655001]  __do_sys_newstat+0x8c/0xf0
> > > > [   62.655640]  do_syscall_64+0xbc/0x790
> > > > [   62.656246]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > [   62.657089]
> > > > [   62.657351] The buggy address belongs to the object at ffff88810=
f155500
> > > >                 which belongs to the cache names_cache of size 4096
> > > > [   62.659420] The buggy address is located 1312 bytes inside of
> > > >                 4096-byte region [ffff88810f155500, ffff88810f15650=
0)
> > > > [   62.661358] The buggy address belongs to the page:
> > > > [   62.662175] page:ffffea00043c5400 refcount:1 mapcount:0 mapping:=
0000000000000000 index:0x0 head:ffffea00043c5400 order:3 compound_mapcount:=
0 compound_pincount:0
> > > > [   62.664523] flags: 0x8000000000010200(slab|head)
> > > > [   62.665342] raw: 8000000000010200 0000000000000000 0000000400000=
001 ffff88811ac772c0
> > > > [   62.666713] raw: 0000000000000000 0000000000070007 00000001fffff=
fff 0000000000000000
> > > > [   62.667984] page dumped because: kasan: bad access detected
> > > > [   62.668904]
> > > > [   62.669171] Memory state around the buggy address:
> > > > [   62.669975]  ffff88810f155900: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
> > > > [   62.671163]  ffff88810f155980: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
> > > > [   62.672363] >ffff88810f155a00: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
> > > > [   62.673559]                                ^
> > > > [   62.674349]  ffff88810f155a80: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
> > > > [   62.675531]  ffff88810f155b00: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
> > > > [   62.676723] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =

> > > Could you please try booting with "slab_nomerge" on the kernel command
> > > line?
> > > =

> > > Possibly kasan could track better the really relevant UAF cycle that
> > > way.
> > > =

> > > Thanks!
> > =

> > Sure, will try that!
> > =

> > Some more info from my crash-analysis: the next-pointer in the bindhash=
-table
> > is pointing to free'd memory. That free'd memory seems to be a tcp_sock=
 in state CLOSED.
> > =

> > =

> > So, I guess the bind_node is not unlinked when a socket is being free'd=
. I'm
> > adding debugging code to see if that is true.

Here is where I got today:

As mentioned above, the next-pointer in the timewait-sock's bind-hash-node
points to a struct sock (to the sk_bind_node-element) that has been free'd.

I found that __sk_destruct ends up freeing a socket that still is in the
bind-hash-table.

The socket under question here is the one that goes through the error-path
in subflow_syn_recv_sock when mptcp_finish_join() fails. So, somehow the
cleanup for that socket is not working correctly.


Now, from here on I'm less sure about what is happening:

I see that on the subflow at the end of tcp_done() (called from
subflow_syn_recv_sock()), icsk_bind_hash is NULL, but the sk_bind_node still
is in the list (I changed __sk_del_bind_node to use hlist_del_init to be
able to really check that).

That does not make a whole lot of sense to me...

Anyway, that's how far I got. I'm calling it a day ;-)


Christoph

--===============8306070669637997390==--
