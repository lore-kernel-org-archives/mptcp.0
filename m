Content-Type: multipart/mixed; boundary="===============3189812736488407633=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Crashers on netnext with apache-benchmark
Date: Wed, 27 May 2020 12:38:19 +0200
Message-ID: <b4d8b4d7fc991e2dcba11b7772b0e4ad18516f54.camel@redhat.com>
In-Reply-To: 20200527002822.GT81884@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4512

--===============3189812736488407633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-05-26 at 17:28 -0700, Christoph Paasch wrote:
> [  142.001017] ------------[ cut here ]------------
> [  142.002079] refcount_t: saturated; leaking memory.
> [  142.002226] WARNING: CPU: 0 PID: 1400 at lib/refcount.c:22 refcount_wa=
rn_saturate+0x65/0x110
> [  142.003085] refcount_t: addition on 0; use-after-free.
> [...]
> [  142.004121] RIP: 0010:refcount_warn_saturate+0x65/0x110
> [  142.004125] Code: 00 0f 84 b1 00 00 00 5b 5d c3 85 db 74 40 80 3d 50 0=
2 8d 01 00 75 f0 48 c7 c7 20 62 39 82 c6 05 40 02 8d 01 01 e8 d0 64 aa ff <=
0f> 0b eb d9 80 3d 2f 02 8d 01 00 75 d0 48 c7 c7 c0 62 39 82 c6 05
> [  142.004130] RSP: 0018:ffff88810d26fb78 EFLAGS: 00010282
> [  142.004138] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000=
0000000
> [  142.004141] RDX: 00000000fffffff8 RSI: 0000000000000004 RDI: ffffed102=
1a4df61
> [  142.004143] RBP: ffff8880aac11740 R08: ffffffff8120b958 R09: ffffed102=
36843c9
> [  142.004146] R10: ffff88811b421e43 R11: ffffed10236843c8 R12: ffff8880a=
1cc0d00
> [  142.004149] R13: ffff88810c273100 R14: ffff8880aac11740 R15: ffff88810=
669b458
> [  142.004178]  mptcp_accept+0x2ca/0x300
> [  142.004213]  inet_accept+0xaa/0x3b0
> [  142.004256]  mptcp_stream_accept+0x124/0x350
> [  142.004272]  __sys_accept4_file+0x260/0x330
> [  142.004324]  __sys_accept4+0x6d/0xb0
> [  142.004343]  __x64_sys_accept4+0x4b/0x60
> [  142.004353]  do_syscall_64+0xc1/0xa10
> [  142.004381]  entry_SYSCALL_64_after_hwframe+0x49/0xb3

I've looked a little bit at this one and it puzzle me... Is this the
only refcount_t related oops you splat you observe? e.g. no previous
underflow/decrement hit 0?

If so it looks like refcount growed above MAX_INT !?! that should
require quite a lot of time ... more likely uninitialized memory/UaF?!?
I'm wondering why KASAN did not detect such UaF?!?

can you please add some local dbg code alike:
---
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 0e3ee25eb156..eba047c8dad9 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -202,8 +202,10 @@ static inline void refcount_add(int i, refcount_t *r)
 =

        if (unlikely(!old))
                refcount_warn_saturate(r, REFCOUNT_ADD_UAF);
-       else if (unlikely(old < 0 || old + i < 0))
+       else if (unlikely(old < 0 || old + i < 0)) {
+               pr_warn("old %d old + i %d\n", old, old + 1);
                refcount_warn_saturate(r, REFCOUNT_ADD_OVF);
+       }
 }
 =

 /**
---

> And another one:
> =

> [   62.586401] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   62.588813] BUG: KASAN: use-after-free in inet_twsk_bind_unhash+0x5f/0=
xe0
> [   62.589975] Write of size 8 at addr ffff88810f155a20 by task ksoftirqd=
/2/21
> [   62.591194]
> [   62.591485] CPU: 2 PID: 21 Comm: ksoftirqd/2 Kdump: loaded Not tainted=
 5.7.0-rc6.mptcp #36
> [   62.593067] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [   62.595268] Call Trace:
> [   62.595775]  dump_stack+0x76/0xa0
> [   62.596448]  print_address_description.constprop.0+0x3a/0x60
> [   62.600581]  __kasan_report.cold+0x20/0x3b
> [   62.602968]  kasan_report+0x38/0x50
> [   62.603561]  inet_twsk_bind_unhash+0x5f/0xe0
> [   62.604282]  inet_twsk_kill+0x195/0x200
> [   62.604945]  inet_twsk_deschedule_put+0x25/0x30
> [   62.605731]  tcp_v4_rcv+0xa79/0x15e0
> [   62.607139]  ip_protocol_deliver_rcu+0x37/0x270
> [   62.607980]  ip_local_deliver_finish+0xb0/0xd0
> [   62.608758]  ip_local_deliver+0x1c9/0x1e0
> [   62.611162]  ip_sublist_rcv_finish+0x84/0xa0
> [   62.611894]  ip_sublist_rcv+0x22c/0x320
> [   62.616143]  ip_list_rcv+0x1e4/0x225
> [   62.619427]  __netif_receive_skb_list_core+0x439/0x460
> [   62.622771]  netif_receive_skb_list_internal+0x3ea/0x570
> [   62.625320]  gro_normal_list.part.0+0x14/0x50
> [   62.626088]  napi_gro_receive+0x6a/0xb0
> [   62.626787]  receive_buf+0x371/0x1d50
> [   62.632092]  virtnet_poll+0x2be/0x5b0
> [   62.634099]  net_rx_action+0x1ec/0x4c0
> [   62.636132]  __do_softirq+0xfc/0x29c
> [   62.638180]  run_ksoftirqd+0x15/0x30
> [   62.638787]  smpboot_thread_fn+0x1fc/0x380
> [   62.642009]  kthread+0x1f1/0x210
> [   62.643478]  ret_from_fork+0x35/0x40
> [   62.644094]
> [   62.644371] Allocated by task 1355:
> [   62.644980]  save_stack+0x1b/0x40
> [   62.645539]  __kasan_kmalloc.constprop.0+0xc2/0xd0
> [   62.646347]  kmem_cache_alloc+0xb8/0x190
> [   62.647006]  getname_flags+0x6b/0x2b0
> [   62.647627]  user_path_at_empty+0x1b/0x40
> [   62.648306]  vfs_statx+0xba/0x140
> [   62.648875]  __do_sys_newstat+0x8c/0xf0
> [   62.649518]  do_syscall_64+0xbc/0x790
> [   62.650199]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   62.651091]
> [   62.651360] Freed by task 1355:
> [   62.651903]  save_stack+0x1b/0x40
> [   62.652460]  __kasan_slab_free+0x12f/0x180
> [   62.653147]  kmem_cache_free+0x87/0x240
> [   62.653795]  filename_lookup+0x183/0x250
> [   62.654447]  vfs_statx+0xba/0x140
> [   62.655001]  __do_sys_newstat+0x8c/0xf0
> [   62.655640]  do_syscall_64+0xbc/0x790
> [   62.656246]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   62.657089]
> [   62.657351] The buggy address belongs to the object at ffff88810f155500
>                 which belongs to the cache names_cache of size 4096
> [   62.659420] The buggy address is located 1312 bytes inside of
>                 4096-byte region [ffff88810f155500, ffff88810f156500)
> [   62.661358] The buggy address belongs to the page:
> [   62.662175] page:ffffea00043c5400 refcount:1 mapcount:0 mapping:000000=
0000000000 index:0x0 head:ffffea00043c5400 order:3 compound_mapcount:0 comp=
ound_pincount:0
> [   62.664523] flags: 0x8000000000010200(slab|head)
> [   62.665342] raw: 8000000000010200 0000000000000000 0000000400000001 ff=
ff88811ac772c0
> [   62.666713] raw: 0000000000000000 0000000000070007 00000001ffffffff 00=
00000000000000
> [   62.667984] page dumped because: kasan: bad access detected
> [   62.668904]
> [   62.669171] Memory state around the buggy address:
> [   62.669975]  ffff88810f155900: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   62.671163]  ffff88810f155980: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   62.672363] >ffff88810f155a00: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   62.673559]                                ^
> [   62.674349]  ffff88810f155a80: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   62.675531]  ffff88810f155b00: fb fb fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb
> [   62.676723] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This one is even more puzzling: the chunk of memory triggering UAF via
the tw sock was originally used by the filesystem, as 'struct
filename'. We haven't touched any of the relevant code path here ??! =


Dumb question... can we exclude a broken memory bank here ?? (not sure
if ";)" :)

Cheers,

Paolo

--===============3189812736488407633==--
