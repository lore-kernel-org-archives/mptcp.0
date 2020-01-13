Content-Type: multipart/mixed; boundary="===============5784403250894648568=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: handle ipv4-mapped ipv6 address.
Date: Mon, 13 Jan 2020 17:09:51 +0100
Message-ID: <7c4cab8ee8ecd0df818f79c13126d7c29fef1788.camel@redhat.com>
In-Reply-To: 2c77cd2ecb1d716642a453a82092899e9a1ba4d5.1578926050.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3347

--===============5784403250894648568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-01-13 at 15:34 +0100, Paolo Abeni wrote:
> The TCP code unconditionally overwrite in a few places 'icsk->icsk_af_ops=
',
> which lead to the wrong oops being called for ipv4-mapped ipv6 address.
> e.g. Kasan notice a invalid slub access running packetdrill ipv4-mapped
> tests.
> =

> This patch try to address the issue building ipv4-mapped  mptcp icsk ops
> and using it when appropriate. Still needs quite a bit of work:
> =

> - kasan still notice an use after free at netns cleanup time
>   (for the ns struct ???)

Actually, I can reproduce the UAF with the current git (unpatched) tree
running the packetdrill test v1_connect_tcpfallback_wrongver.pkt with
ipv4 addresses.

So it looks like we have UAF in MPTCP ipv4.

The full splat is as follow:

[  133.498790] subflow_create_ctx:616: MPTCP: subflow=3D00000000b82781fb
[  133.498794] subflow_ulp_init:687: MPTCP: subflow=3D00000000b82781fb, fam=
ily=3D2
[  133.499845] mptcp_subflow_create_socket:595: MPTCP: subflow=3D00000000b8=
2781fb
[  133.500939] subflow_rebuild_header:29: MPTCP: subflow=3D00000000a3080487
[  133.501868] mptcp_token_new_connect:109: MPTCP: ssk=3D00000000a3080487, =
local_key=3D14090005032543291656, token=3D470185988, idsn=3D667233618602560=
0666
[  133.504546] mptcp_syn_options:291: local_key=3D14090005032543291656
[  133.506686] mptcp_rcv_synsent:305: subflow=3D00000000b82781fb
[  133.507624] subflow_finish_connect:116: MPTCP: subflow=3D00000000b82781f=
b, remote_key=3D0
[  133.508373] subflow_finish_connect:122: MPTCP: synack seq=3D0
[  133.698080] mptcp_sendmsg:329: MPTCP: fallback passthrough
[  133.903468] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  133.904836] BUG: KASAN: use-after-free in fib_get_table+0xfa/0x120
[  133.905968] Read of size 8 at addr ffff8880a938f7f8 by task swapper/1/0

[  133.907509] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.5.0-rc4.mptcp_81=
918d92317d+ #526
[  133.908952] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.12.0-2.fc30 04/01/2014
[  133.910624] Call Trace:
[  133.911157]  <IRQ>
[  133.911614]  dump_stack+0x97/0xe0
[  133.912227]  print_address_description.constprop.0+0x1b/0x210
[  133.913268]  ? fib_get_table+0xfa/0x120
[  133.913993]  ? fib_get_table+0xfa/0x120
[  133.914710]  __kasan_report.cold+0x37/0x7d
[  133.915481]  ? inet_lookup_ifaddr_rcu+0x100/0x1e0
[  133.916346]  ? fib_get_table+0xfa/0x120
[  133.917086]  kasan_report+0xe/0x20
[  133.917734]  fib_get_table+0xfa/0x120
[  133.918433]  __ip_dev_find+0x265/0x2f0
[  133.919144]  ? inet_lookup_ifaddr_rcu+0x1e0/0x1e0
[  133.920012]  ? mark_lock+0xbc/0x1190
[  133.920679]  ? mark_held_locks+0x65/0xf0
[  133.921437]  ip_route_output_key_hash_rcu+0x135d/0x22e0
[  133.922401]  ? ip_route_input_noref+0x1b0/0x1b0
[  133.923228]  ? ip_route_output_key_hash+0x123/0x270
[  133.924132]  ip_route_output_key_hash+0x176/0x270
[  133.925008]  ? ip_route_output_key_hash_rcu+0x22e0/0x22e0
[  133.926020]  ip_route_output_flow+0x1e/0x90
[  133.926779]  inet_sk_rebuild_header+0x769/0x1c90
[  133.927656]  ? inet_sk_set_state+0x330/0x330
[  133.928461]  ? __pskb_trim_head+0x9d0/0x9d0
[  133.929237]  __tcp_retransmit_skb+0x274/0x15e0
[  133.930088]  ? tcp_retrans_try_collapse+0x12c0/0x12c0
[  133.930766]  ? mark_held_locks+0x65/0xf0
[  133.931310]  tcp_send_loss_probe+0x3fb/0x770
[  133.931906]  tcp_write_timer_handler+0x585/0x710
[  133.932527]  tcp_write_timer+0x7e/0x1c0
[  133.933048]  call_timer_fn+0x1b1/0x640
[  133.933576]  ? tcp_write_timer_handler+0x710/0x710
[  133.934205]  ? timer_fixup_init+0x40/0x40
[  133.934752]  ? lock_downgrade+0x720/0x720
[  133.935295]  ? rcu_read_lock_sched_held+0xa1/0xe0
[  133.935926]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  133.936530]  ? _raw_spin_unlock_irq+0x24/0x30
[  133.937114]  __run_timers.part.0+0x4a5/0x9a0
[  133.937701]  ? tcp_write_timer_handler+0x710/0x710
[  133.938346]  ? call_timer_fn+0x640/0x640
[  133.938873]  ? lock_downgrade+0x720/0x720
[  133.939445]  ? rcu_read_lock_sched_held+0xa1/0xe0
[  133.940069]  run_timer_softirq+0x6a/0x100
[  133.940618]  __do_softirq+0x24c/0xa6e
[  133.941127]  irq_exit+0x275/0x2c0
[  133.941603]  smp_apic_timer_interrupt+0x1b0/0x650
[  133.942222]  apic_timer_interrupt+0xf/0x20
[  133.942777]  </IRQ>
[  133.943090] RIP: 0010:default_idle+0x2d/0x390
[  133.943676] Code: 00 00 41 56 41 55 41 54 65 44 8b 25 c5 56 2c 79 55 53 =
0f 1f 44 00 00 e8 b1 95 7c fe e9 07 00 00 00 0f 00 2d 35 80 4c 00 fb f4 <65=
> 44 8b 25 a3 56 2c 79 0f 1f 44 00 00 5b 5d 41 5c 41 5d 41 5e c3
[  133.945969] RSP: 0018:ffff88810746fda8 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[  133.946932] RAX: 0000000000000007 RBX: ffff888107463480 RCX: 00000000000=
00000
[  133.947835] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8881074=
6417c
[  133.948741] RBP: dffffc0000000000 R08: 0000000000000001 R09: 00000000000=
00000
[  133.949698] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00001
[  133.950618] R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff883=
e7820
[  133.951573]  ? default_idle+0x1f/0x390
[  133.952088]  do_idle+0x44b/0x5a0
[  133.952553]  ? arch_cpu_idle_exit+0x40/0x40
[  133.953120]  ? _raw_spin_unlock_irqrestore+0x3e/0x50
[  133.953811]  cpu_startup_entry+0x19/0x20
[  133.954353]  start_secondary+0x2f4/0x400
[  133.954918]  ? set_cpu_sibling_map+0x2420/0x2420
[  133.955556]  secondary_startup_64+0xb6/0xc0

[  133.956401] Allocated by task 3288:
[  133.956901]  save_stack+0x1b/0x80
[  133.957400]  __kasan_kmalloc.constprop.0+0xc2/0xd0
[  133.958037]  kmem_cache_alloc_trace+0x160/0x390
[  133.958664]  fib_net_init+0x133/0x300
[  133.959180]  ops_init+0x96/0x360
[  133.959644]  setup_net+0x2c5/0x790
[  133.960117]  copy_net_ns+0x24f/0x490
[  133.960625]  create_new_namespaces+0x35e/0x6e0
[  133.961219]  unshare_nsproxy_namespaces+0x87/0x1a0
[  133.961863]  ksys_unshare+0x306/0x680
[  133.962390]  __x64_sys_unshare+0x2d/0x40
[  133.962925]  do_syscall_64+0x99/0x500
[  133.963434]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  133.964327] Freed by task 36:
[  133.964763]  save_stack+0x1b/0x80
[  133.965217]  __kasan_slab_free+0x12c/0x170
[  133.965768]  kfree+0x103/0x370
[  133.966195]  ip_fib_net_exit+0x231/0x340
[  133.966760]  ops_exit_list.isra.0+0x90/0x140
[  133.967368]  cleanup_net+0x44a/0x930
[  133.967854]  process_one_work+0x889/0x15b0
[  133.968421]  worker_thread+0x91/0xcb0
[  133.968922]  kthread+0x2f2/0x3f0
[  133.969387]  ret_from_fork+0x24/0x30
[  133.970115] The buggy address belongs to the object at ffff8880a938f000
 which belongs to the cache kmalloc-2k of size 2048

[  133.971699] The buggy address is located 2040 bytes inside of
 2048-byte region [ffff8880a938f000, ffff8880a938f800)
[  133.973173] The buggy address belongs to the page:
[  133.973810] page:ffffea0002a4e200 refcount:1 mapcount:0 mapping:ffff8881=
07c0c000 index:0x0 compound_mapcount: 0
[  133.975077] raw: 000fffffc0010200 dead000000000100 dead000000000122 ffff=
888107c0c000
[  133.976093] raw: 0000000000000000 0000000000080008 00000001ffffffff 0000=
000000000000
[  133.977090] page dumped because: kasan: bad access detected
[  133.978073] Memory state around the buggy address:
[  133.978723]  ffff8880a938f680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  133.979672]  ffff8880a938f700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  133.980597] >ffff8880a938f780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  133.981551]                                                             =
    ^
[  133.982498]  ffff8880a938f800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  133.983481]  ffff8880a938f880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  133.984404] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  133.985413] Disabling lock debugging due to kernel taint

--===============5784403250894648568==--
