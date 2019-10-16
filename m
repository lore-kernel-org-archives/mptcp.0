Content-Type: multipart/mixed; boundary="===============2270678731154075558=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: just another recvmsg refactor
Date: Wed, 16 Oct 2019 18:48:21 +0200
Message-ID: <367074ea-8e11-9678-00c6-9bd9bd49ae5b@tessares.net>
In-Reply-To: d1db650e-e352-4cf9-11c7-d109da57c725@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2192

--===============2270678731154075558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 16/10/2019 16:07, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 16/10/2019 15:54, Paolo Abeni wrote:
>> On Wed, 2019-10-16 at 13:14 +0200, Matthieu Baerts wrote:
>>> Hi Paolo,
>>>
>>> On 16/10/2019 12:02, Matthieu Baerts wrote:
>>>> Hi Paolo,
>>>>
>>>> On 16/10/2019 10:58, Paolo Abeni wrote:
>>>>> On Wed, 2019-10-16 at 10:37 +0200, Matthieu Baerts wrote:
>>>>>> On 16/10/2019 10:22, Paolo Abeni wrote:
>>>>>>> Yes, I'm cooking patch && rebase right now. I hopefully will send =

>>>>>>> soon
>>>>>>> v2 of the patches with a reference to the rebase branch in the cover
>>>>>>> letter.
>>>>>>
>>>>>> If you only adds the line mentioned by Mat, I am fine if you =

>>>>>> update your
>>>>>> branch directly, no need to send new patches that we will not use
>>>>>> directly
>>>>>
>>>>> The new rebase branch is:
>>>>>
>>>>> https://github.com/pabeni/mptcp/tree/mptcp-proposal-recvmsg_rebase_8
>>>>
>>>> Great. I just used it to re-create the tree (not the export branch =

>>>> yet).
>>>>
>>>> [...]
>>>>
>>>>> It's based on top of net-next commit 77ffe33363c0 ("hv_sock: use
>>>>> HV_HYP_PAGE_SIZE for Hyper-V communication")
>>>>
>>>> Thank you for this rebase!
>>>>
>>>>> I checked for build issue only on the modified patches.
>>>>
>>>> I just asked the CI to validate each commit before doing the export.
>>>> I will notify you if there is an issue. With the build queue, it might
>>>> take ~1 hour.
>>>
>>> There was a small issue. I had to move some code to other topics:
>>>
>>> - 46ef07c43dd5: move code from "mptcp: add MIB counter infrastructure"..
>>> - 4e9c2cbc67c6: ..to "mptcp: increment MIB counters in a few places"
>>> - 44b3404b5062..9fd478f3331c: result (no diff)
>>>
>>> Now that the export is OK, I ran the selftests and I got:
>>>
>>>
>>> # ns4=C2=A0 TCP=C2=A0=C2=A0 -> ns2=C2=A0 (10.0.1.2:10059) MPTCP=C2=A0=
=C2=A0=C2=A0 [ OK ]
>>> # ns4=C2=A0 MPTCP -> ns2=C2=A0 (10.0.2.1:10060) MPTCP=C2=A0=C2=A0=C2=A0=
 [=C2=A0 162.412089] =

>>> ------------[
>>> cut here ]------------
>>> [=C2=A0 162.412863] Bad mapping: ssn=3D2827884 map_seq=3D2818916 =

>>> map_data_len=3D8318
>>> [=C2=A0 162.412878] WARNING: CPU: 0 PID: 0 at net/mptcp/subflow.c:333
>>> warn_bad_map.isra.7.part.8+0x1b/0x20
>>> [=C2=A0 162.415125] Modules linked in:
>>> [=C2=A0 162.415621] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc1=
+ #3
>>> [=C2=A0 162.416571] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6),
>>> BIOS 1.10.2-1ubuntu1 04/01/2014
>>> [=C2=A0 162.417931] RIP: 0010:warn_bad_map.isra.7.part.8+0x1b/0x20
>>> [=C2=A0 162.418768] Code: 00 5b e9 58 8b 30 00 0f 1f 84 00 00 00 00 00 =
89 d0
>>> 8b 0e 8b 17 89 c6 48 c7 c7 d0 f8 ac 85 c6 05 57 76 a4 00 01 e8 85 ce 5d
>>> ff <0f> 0b c3 66 90 48 8b 46 58 48 83 e0 fe f7 40 74 00 00 00 30 74 1d
>>> [=C2=A0 162.421622] RSP: 0018:ffffb3eb80003bc8 EFLAGS: 00010286
>>> [=C2=A0 162.422433] RAX: 0000000000000000 RBX: ffff93a51d6d44e0 RCX:
>>> 0000000000000000
>>> [=C2=A0 162.423524] RDX: 000000000000003a RSI: ffffffff8634c35a RDI:
>>> ffffffff8634c75a
>>> [=C2=A0 162.424619] RBP: ffff93a51d5bd9c0 R08: ffffffff8634c320 R09:
>>> 000000000000003a
>>> [=C2=A0 162.425710] R10: 0000000000000a4e R11: 0000000080000000 R12:
>>> ffff93a51d609200
>>> [=C2=A0 162.426794] R13: ffff93a51d5bd9c0 R14: ffff93a51d6092d0 R15:
>>> ffff93a51d5f8680
>>> [=C2=A0 162.427911] FS:=C2=A0 0000000000000000(0000) GS:ffff93a51f20000=
0(0000)
>>> knlGS:0000000000000000
>>> [=C2=A0 162.429110] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
>>> [=C2=A0 162.429931] CR2: 00007ffe5a15a000 CR3: 000000001d73a003 CR4:
>>> 00000000003606f0
>>> [=C2=A0 162.430983] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>> 0000000000000000
>>> [=C2=A0 162.432032] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>> 0000000000000400
>>> [=C2=A0 162.433104] Call Trace:
>>> [=C2=A0 162.433490]=C2=A0 <IRQ>
>>> [=C2=A0 162.433801]=C2=A0 mptcp_subflow_data_available+0x3c6/0x560
>>> [=C2=A0 162.434551]=C2=A0 subflow_data_ready+0x3b/0x70
>>> [=C2=A0 162.435169]=C2=A0 tcp_data_queue+0x3b1/0xc40
>>> [=C2=A0 162.435776]=C2=A0 tcp_rcv_state_process+0x5ec/0xce0
>>> [=C2=A0 162.436466]=C2=A0 ? security_sock_rcv_skb+0x25/0x40
>>> [=C2=A0 162.437156]=C2=A0 ? tcp_v4_do_rcv+0x110/0x1c0
>>> [=C2=A0 162.437767]=C2=A0 tcp_v4_do_rcv+0x110/0x1c0
>>> [=C2=A0 162.438351]=C2=A0 tcp_v4_rcv+0x9c7/0xa80
>>> [=C2=A0 162.438900]=C2=A0 ip_protocol_deliver_rcu+0x27/0x1a0
>>> [=C2=A0 162.439603]=C2=A0 ip_local_deliver_finish+0x3f/0x50
>>> [=C2=A0 162.440296]=C2=A0 ip_local_deliver+0x74/0xe0
>>> [=C2=A0 162.440895]=C2=A0 ? ip_rcv_finish_core.isra.15+0xed/0x340
>>> [=C2=A0 162.441662]=C2=A0 ip_rcv+0xb7/0xc0
>>> [=C2=A0 162.442129]=C2=A0 __netif_receive_skb_one_core+0x79/0x90
>>> [=C2=A0 162.442886]=C2=A0 process_backlog+0x82/0x120
>>> [=C2=A0 162.443483]=C2=A0 net_rx_action+0x138/0x3d0
>>> [=C2=A0 162.444068]=C2=A0 __do_softirq+0xd8/0x2cb
>>> [=C2=A0 162.444626]=C2=A0 irq_exit+0x9b/0xa0
>>> [=C2=A0 162.445113]=C2=A0 smp_apic_timer_interrupt+0x6f/0x120
>>> [=C2=A0 162.445820]=C2=A0 apic_timer_interrupt+0xf/0x20
>>> [=C2=A0 162.446458]=C2=A0 </IRQ>
>>> [=C2=A0 162.446793] RIP: 0010:default_idle+0x20/0x140
>>> [=C2=A0 162.447473] Code: ff eb c7 e8 22 bc 5b ff 90 90 41 55 41 54 55 =
53 65
>>> 8b 2d 43 59 cf 7a 0f 1f 44 00 00 e9 07 00 00 00 0f 00 2d a4 9b 4f 00 fb
>>> f4 <65> 8b 2d 29 59 cf 7a 0f 1f 44 00 00 5b 5d 41 5c 41 5d c3 65 8b 05
>>> [=C2=A0 162.450316] RSP: 0018:ffffffff85c03e98 EFLAGS: 00000246 ORIG_RA=
X:
>>> ffffffffffffff13
>>> [=C2=A0 162.451468] RAX: ffffffff8531aa00 RBX: 0000000000000000 RCX:
>>> 0000000000000000
>>> [=C2=A0 162.452476] RDX: 0000000000000001 RSI: 0000000000000083 RDI:
>>> 0000000000000000
>>> [=C2=A0 162.453534] RBP: 0000000000000000 R08: 0000004254d4a19e R09:
>>> 0000000000000004
>>> [=C2=A0 162.454546] R10: ffffb3eb80197d88 R11: 0000000000000000 R12:
>>> 0000000000000000
>>> [=C2=A0 162.455642] R13: 0000000000000000 R14: ffff93a51ffd6180 R15:
>>> 0000000000000000
>>> [=C2=A0 162.456728]=C2=A0 ? __sched_text_end+0x2/0x2
>>> [=C2=A0 162.457323]=C2=A0 do_idle+0x19a/0x230
>>> [=C2=A0 162.457832]=C2=A0 cpu_startup_entry+0x14/0x20
>>> [=C2=A0 162.458443]=C2=A0 start_kernel+0x4c0/0x4e2
>>> [=C2=A0 162.459016]=C2=A0 secondary_startup_64+0xa4/0xb0
>>> [=C2=A0 162.459669] ---[ end trace 869ccfaeaf536fdb ]---
>>> [ FAIL ] client exit code 0, server 141
>>> # \nnetns ns2 socket stat for 10060:
>>> # State=C2=A0=C2=A0 Recv-Q=C2=A0=C2=A0=C2=A0 Send-Q=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Local Address:Port=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Peer
>>> Address:Port
>>> # \nnetns ns4 socket stat for 10060:
>>> # State=C2=A0=C2=A0 Recv-Q=C2=A0=C2=A0=C2=A0 Send-Q=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Local Address:Port=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Peer
>>> Address:Port
>>> # ns4=C2=A0 MPTCP -> ns3=C2=A0 (10.0.2.2:10061) MPTCP=C2=A0=C2=A0=C2=A0=
 [ OK ]
>>>
>>> May you have a look at it because it looks linked to your =

>>> modification? :)
>>
>> I'm investigating this right now. It took a good deal of iterations to
>> reproduce it and I lack some info even then, so it looks like it will
>> take some time get to the bottom of it.
> =

> Thank you for looking at that. It seems the server was a bit busy (CPU =

> but mainly IO I think) with other tasks when executing the test. I don't =

> know if it would help for you to debug this. Also it is using virtme[1], =

> maybe some configurations are making the bug easier to reproduce.
> =

> [1] https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/ci
> ($ ./patches/Dockerfile.virtme.sh patches/virtme.sh)

It seems easier to reproduce with KASAN and PROVE_LOCKING:

   -e KASAN -e KASAN_OUTLINE -d TEST_KASAN -e PROVE_LOCKING -d DEBUG_LOCKDEP

Same warning but not the same path:



# ns3  MPTCP -> ns3  (10.0.2.2:10045) MPTCP	[  136.536881] ------------[ =

cut here ]------------
[  136.537926] Bad mapping: ssn=3D1995768 map_seq=3D1971326 map_data_len=3D=
16317
[  136.537954] WARNING: CPU: 0 PID: 885 at net/mptcp/subflow.c:333 =

warn_bad_map.isra.5.part.6+0x3a/0x50
[  136.540400] Modules linked in:
[  136.540893] CPU: 0 PID: 885 Comm: mptcp_connect Not tainted 5.4.0-rc1+ #4
[  136.541914] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =

BIOS 1.10.2-1ubuntu1 04/01/2014
[  136.543176] RIP: 0010:warn_bad_map.isra.5.part.6+0x3a/0x50
[  136.544045] Code: c6 05 c7 9f 2b 01 01 e8 74 a1 06 ff 8b 6d 00 48 89 =

df e8 69 a1 06 ff 8b 13 44 89 e6 48 c7 c7 40 89 ab 91 89 e9 e8 46 7e de =

fe <0f> 0b 5b 5d 41 5c c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00
[  136.546901] RSP: 0018:ffff88801766f888 EFLAGS: 00010282
[  136.547750] RAX: 0000000000000000 RBX: ffff88801874de38 RCX: =

ffffffff8fffb8cd
[  136.548860] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: =

ffff888019cfa044
[  136.549959] RBP: 0000000000003fbd R08: 0000000000000001 R09: =

fffffbfff267539b
[  136.550980] R10: 0000000000000001 R11: fffffbfff267539a R12: =

00000000001e73f8
[  136.552052] R13: ffff88801874de00 R14: ffff88801874de00 R15: =

ffff888017fb9780
[  136.553168] FS:  00007f24c9e9e500(0000) GS:ffff88801aa00000(0000) =

knlGS:0000000000000000
[  136.554430] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  136.555342] CR2: 00007ffea64cfe6e CR3: 0000000017142004 CR4: =

00000000003606f0
[  136.556450] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =

0000000000000000
[  136.557531] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =

0000000000000400
[  136.558632] Call Trace:
[  136.559039]  mptcp_subflow_data_available+0x818/0xa10
[  136.559791]  ? subflow_v4_init_req+0x490/0x490
[  136.560459]  ? tcp_read_sock+0x2db/0x490
[  136.561046]  ? dns_query+0x3c0/0x3c0
[  136.561603]  ? mark_held_locks+0x65/0x90
[  136.562227]  ? __local_bh_enable_ip+0x8f/0xf0
[  136.562915]  ? lock_sock_nested+0x39/0xa0
[  136.563564]  mptcp_recvmsg+0x43a/0x790
[  136.564175]  ? mptcp_retransmit_timer+0xe0/0xe0
[  136.564891]  ? mark_held_locks+0x1a/0x90
[  136.565513]  ? mark_lock+0x128/0x700
[  136.566084]  ? lockdep_hardirqs_on+0x17d/0x250
[  136.566796]  ? sock_has_perm+0x9b/0x170
[  136.567413]  ? selinux_secmark_relabel_packet+0x70/0x70
[  136.568237]  ? match_held_lock+0x1b/0x240
[  136.568889]  inet_recvmsg+0x2ad/0x350
[  136.569476]  ? inet_sendpage+0xb0/0xb0
[  136.570082]  ? security_socket_recvmsg+0x48/0x60
[  136.570814]  sock_read_iter+0x120/0x1b0
[  136.571413]  ? sock_recvmsg+0xb0/0xb0
[  136.571981]  ? iov_iter_init+0x8b/0xc0
[  136.572551]  new_sync_read+0x24a/0x360
[  136.573117]  ? generic_remap_file_range_prep+0x760/0x760
[  136.573918]  ? __fsnotify_parent+0x92/0x240
[  136.574557]  ? fsnotify+0x5d5/0x600
[  136.575114]  ? fsnotify_first_mark+0xe0/0xe0
[  136.575806]  ? security_file_permission+0xd1/0x170
[  136.576562]  vfs_read+0xa0/0x190
[  136.577088]  ksys_read+0x115/0x160
[  136.577636]  ? kernel_write+0xb0/0xb0
[  136.578225]  ? lockdep_hardirqs_off+0xb5/0x100
[  136.578926]  ? mark_held_locks+0x1a/0x90
[  136.579564]  do_syscall_64+0x63/0x250
[  136.580148]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  136.580942] RIP: 0033:0x7f24c999d081
[  136.581510] Code: fe ff ff 48 8d 3d 67 9c 0a 00 48 83 ec 08 e8 a6 4c =

02 00 66 0f 1f 44 00 00 48 8d 05 81 08 2e 00 8b 00 85 c0 75 13 31 c0 0f =

05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 41 54 55 49 89 d4 53
[  136.584367] RSP: 002b:00007ffc9e1604b8 EFLAGS: 00000246 ORIG_RAX: =

0000000000000000
[  136.585534] RAX: ffffffffffffffda RBX: 0000000000002000 RCX: =

00007f24c999d081
[  136.586633] RDX: 0000000000002000 RSI: 00007ffc9e1604d0 RDI: =

0000000000000006
[  136.587738] RBP: 00007ffc9e1604d0 R08: 00007f24c9c781e0 R09: =

00007f24c9c78240
[  136.588804] R10: 00007ffc9e1625c4 R11: 0000000000000246 R12: =

0000000000000006
[  136.589827] R13: 00007ffc9e1604c8 R14: 0000000000002000 R15: =

0000000000000000
[  136.590892] irq event stamp: 62002
[  136.591416] hardirqs last  enabled at (62001): [<ffffffff900160e5>] =

vprintk_emit+0xb5/0x2a0
[  136.592619] hardirqs last disabled at (62002): [<ffffffff8fe0273a>] =

trace_hardirqs_off_thunk+0x1a/0x20
[  136.594047] softirqs last  enabled at (61996): [<ffffffff9140049e>] =

__do_softirq+0x49e/0x570
[  136.595340] softirqs last disabled at (61989): [<ffffffff8ff767d4>] =

irq_exit+0xf4/0x100
[  136.596465] ---[ end trace 15817eda66b43ee4 ]---
write: Bad message
# [ FAIL ] client exit code 141, server 0
# \nnetns ns3 socket stat for 10045:
# State   Recv-Q    Send-Q        Local Address:Port         Peer =

Address:Port
# \nnetns ns3 socket stat for 10045:
# State   Recv-Q    Send-Q        Local Address:Port         Peer =

Address:Port
# ns3  MPTCP -> ns3  (10.0.3.2:10046) MPTCP	[ OK ]


Cheers,
Matt--
Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2270678731154075558==--
