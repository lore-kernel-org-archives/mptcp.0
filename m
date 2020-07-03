Content-Type: multipart/mixed; boundary="===============2612060688251084344=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] diag: fix use-after-free Read in
 inet_diag_lock_handler
Date: Fri, 03 Jul 2020 21:06:56 +0200
Message-ID: <20200703190656.2611535-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4909

--===============2612060688251084344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Paasch <cpaasch(a)apple.com>

Syzkaller reported this:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: use-after-free in inet_diag_lock_handler.part.0+0xae/0xb0 net/i=
pv4/inet_diag.c:58
Read of size 8 at addr ffff888118a1f808 by task syz-executor863/1271

CPU: 0 PID: 1271 Comm: syz-executor863 Not tainted 5.8.0-rc2 #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf=
21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xbe/0xfe lib/dump_stack.c:118
 print_address_description.constprop.0+0x3a/0x60 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 inet_diag_lock_handler.part.0+0xae/0xb0 net/ipv4/inet_diag.c:58
 inet_diag_lock_handler net/ipv4/inet_diag.c:55 [inline]
 inet_diag_cmd_exact+0x1a1/0x2f0 net/ipv4/inet_diag.c:578
 inet_diag_get_exact_compat+0x226/0x2a0 net/ipv4/inet_diag.c:1267
 inet_diag_rcv_msg_compat+0x15b/0x2c0 net/ipv4/inet_diag.c:1289
 __sock_diag_cmd net/core/sock_diag.c:235 [inline]
 sock_diag_rcv_msg+0x2ca/0x3e0 net/core/sock_diag.c:264
 netlink_rcv_skb+0x156/0x420 net/netlink/af_netlink.c:2469
 sock_diag_rcv+0x24/0x40 net/core/sock_diag.c:275
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x53a/0x750 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x809/0xd50 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg net/socket.c:672 [inline]
 ____sys_sendmsg+0x774/0x8e0 net/socket.c:2363
 ___sys_sendmsg+0xff/0x170 net/socket.c:2417
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2450
 do_syscall_64+0x3e/0x70 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7ff0c5cf0469
Code: Bad RIP value.
RSP: 002b:00007ffdac0e7988 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffdac0e7998 RCX: 00007ff0c5cf0469
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000401110
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401034
R13: 00007ffdac0e7b20 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 1235:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:467
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc_node mm/slub.c:2824 [inline]
 slab_alloc mm/slub.c:2832 [inline]
 kmem_cache_alloc+0xb7/0x220 mm/slub.c:2837
 __build_skb+0x21/0x60 net/core/skbuff.c:311
 build_skb+0x1a/0x1d0 net/core/skbuff.c:327
 e1000_clean_rx_irq+0x9e5/0x1340 drivers/net/ethernet/intel/e1000/e1000_mai=
n.c:4378
 e1000_clean+0x8cb/0x1b20 drivers/net/ethernet/intel/e1000/e1000_main.c:3800
 napi_poll net/core/dev.c:6690 [inline]
 net_rx_action+0x402/0xde0 net/core/dev.c:6760
 __do_softirq+0x18c/0x61a kernel/softirq.c:292

Freed by task 1235:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x12f/0x180 mm/kasan/common.c:455
 slab_free_hook mm/slub.c:1474 [inline]
 slab_free_freelist_hook mm/slub.c:1507 [inline]
 slab_free mm/slub.c:3072 [inline]
 kmem_cache_free+0x80/0x290 mm/slub.c:3088
 napi_skb_finish net/core/dev.c:5997 [inline]
 napi_gro_receive+0x37c/0x410 net/core/dev.c:6020
 e1000_receive_skb drivers/net/ethernet/intel/e1000/e1000_main.c:4000 [inli=
ne]
 e1000_clean_rx_irq+0x894/0x1340 drivers/net/ethernet/intel/e1000/e1000_mai=
n.c:4455
 e1000_clean+0x8cb/0x1b20 drivers/net/ethernet/intel/e1000/e1000_main.c:3800
 napi_poll net/core/dev.c:6690 [inline]
 net_rx_action+0x402/0xde0 net/core/dev.c:6760
 __do_softirq+0x18c/0x61a kernel/softirq.c:292

The buggy address belongs to the object at ffff888118a1f780
 which belongs to the cache skbuff_head_cache of size 216
The buggy address is located 136 bytes inside of
 216-byte region [ffff888118a1f780, ffff888118a1f858)
The buggy address belongs to the page:
page:ffffea00046287c0 refcount:1 mapcount:0 mapping:0000000000000000 index:=
0x0
flags: 0x200000000000200(slab)
raw: 0200000000000200 dead000000000100 dead000000000122 ffff88811aa2ea00
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888118a1f700: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888118a1f780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888118a1f800: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
                      ^
 ffff888118a1f880: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
 ffff888118a1f900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/44
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "inet_diag: support for wider protocol numbers"

 net/ipv4/inet_diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index a3a7ef3fada6..44a7c2dddd33 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -52,7 +52,7 @@ static DEFINE_MUTEX(inet_diag_table_mutex);
 =

 static const struct inet_diag_handler *inet_diag_lock_handler(int proto)
 {
-	if (proto >=3D IPPROTO_MAX)
+	if (proto < 0 || proto >=3D IPPROTO_MAX)
 		return ERR_PTR(-ENOENT);
 =

 	if (!inet_diag_table[proto])
-- =

2.27.0

--===============2612060688251084344==--
