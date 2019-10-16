Content-Type: multipart/mixed; boundary="===============5877640272439174035=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: just another recvmsg refactor
Date: Wed, 16 Oct 2019 16:07:43 +0200
Message-ID: <d1db650e-e352-4cf9-11c7-d109da57c725@tessares.net>
In-Reply-To: 15706d0e108b0e1d17e2951a073ddac125615826.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2173

--===============5877640272439174035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 16/10/2019 15:54, Paolo Abeni wrote:
> On Wed, 2019-10-16 at 13:14 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 16/10/2019 12:02, Matthieu Baerts wrote:
>>> Hi Paolo,
>>>
>>> On 16/10/2019 10:58, Paolo Abeni wrote:
>>>> On Wed, 2019-10-16 at 10:37 +0200, Matthieu Baerts wrote:
>>>>> On 16/10/2019 10:22, Paolo Abeni wrote:
>>>>>> Yes, I'm cooking patch && rebase right now. I hopefully will send so=
on
>>>>>> v2 of the patches with a reference to the rebase branch in the cover
>>>>>> letter.
>>>>>
>>>>> If you only adds the line mentioned by Mat, I am fine if you update y=
our
>>>>> branch directly, no need to send new patches that we will not use
>>>>> directly
>>>>
>>>> The new rebase branch is:
>>>>
>>>> https://github.com/pabeni/mptcp/tree/mptcp-proposal-recvmsg_rebase_8
>>>
>>> Great. I just used it to re-create the tree (not the export branch yet).
>>>
>>> [...]
>>>
>>>> It's based on top of net-next commit 77ffe33363c0 ("hv_sock: use
>>>> HV_HYP_PAGE_SIZE for Hyper-V communication")
>>>
>>> Thank you for this rebase!
>>>
>>>> I checked for build issue only on the modified patches.
>>>
>>> I just asked the CI to validate each commit before doing the export.
>>> I will notify you if there is an issue. With the build queue, it might
>>> take ~1 hour.
>>
>> There was a small issue. I had to move some code to other topics:
>>
>> - 46ef07c43dd5: move code from "mptcp: add MIB counter infrastructure"..
>> - 4e9c2cbc67c6: ..to "mptcp: increment MIB counters in a few places"
>> - 44b3404b5062..9fd478f3331c: result (no diff)
>>
>> Now that the export is OK, I ran the selftests and I got:
>>
>>
>> # ns4  TCP   -> ns2  (10.0.1.2:10059) MPTCP	[ OK ]
>> # ns4  MPTCP -> ns2  (10.0.2.1:10060) MPTCP	[  162.412089] ------------[
>> cut here ]------------
>> [  162.412863] Bad mapping: ssn=3D2827884 map_seq=3D2818916 map_data_len=
=3D8318
>> [  162.412878] WARNING: CPU: 0 PID: 0 at net/mptcp/subflow.c:333
>> warn_bad_map.isra.7.part.8+0x1b/0x20
>> [  162.415125] Modules linked in:
>> [  162.415621] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc1+ #3
>> [  162.416571] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.10.2-1ubuntu1 04/01/2014
>> [  162.417931] RIP: 0010:warn_bad_map.isra.7.part.8+0x1b/0x20
>> [  162.418768] Code: 00 5b e9 58 8b 30 00 0f 1f 84 00 00 00 00 00 89 d0
>> 8b 0e 8b 17 89 c6 48 c7 c7 d0 f8 ac 85 c6 05 57 76 a4 00 01 e8 85 ce 5d
>> ff <0f> 0b c3 66 90 48 8b 46 58 48 83 e0 fe f7 40 74 00 00 00 30 74 1d
>> [  162.421622] RSP: 0018:ffffb3eb80003bc8 EFLAGS: 00010286
>> [  162.422433] RAX: 0000000000000000 RBX: ffff93a51d6d44e0 RCX:
>> 0000000000000000
>> [  162.423524] RDX: 000000000000003a RSI: ffffffff8634c35a RDI:
>> ffffffff8634c75a
>> [  162.424619] RBP: ffff93a51d5bd9c0 R08: ffffffff8634c320 R09:
>> 000000000000003a
>> [  162.425710] R10: 0000000000000a4e R11: 0000000080000000 R12:
>> ffff93a51d609200
>> [  162.426794] R13: ffff93a51d5bd9c0 R14: ffff93a51d6092d0 R15:
>> ffff93a51d5f8680
>> [  162.427911] FS:  0000000000000000(0000) GS:ffff93a51f200000(0000)
>> knlGS:0000000000000000
>> [  162.429110] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  162.429931] CR2: 00007ffe5a15a000 CR3: 000000001d73a003 CR4:
>> 00000000003606f0
>> [  162.430983] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [  162.432032] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [  162.433104] Call Trace:
>> [  162.433490]  <IRQ>
>> [  162.433801]  mptcp_subflow_data_available+0x3c6/0x560
>> [  162.434551]  subflow_data_ready+0x3b/0x70
>> [  162.435169]  tcp_data_queue+0x3b1/0xc40
>> [  162.435776]  tcp_rcv_state_process+0x5ec/0xce0
>> [  162.436466]  ? security_sock_rcv_skb+0x25/0x40
>> [  162.437156]  ? tcp_v4_do_rcv+0x110/0x1c0
>> [  162.437767]  tcp_v4_do_rcv+0x110/0x1c0
>> [  162.438351]  tcp_v4_rcv+0x9c7/0xa80
>> [  162.438900]  ip_protocol_deliver_rcu+0x27/0x1a0
>> [  162.439603]  ip_local_deliver_finish+0x3f/0x50
>> [  162.440296]  ip_local_deliver+0x74/0xe0
>> [  162.440895]  ? ip_rcv_finish_core.isra.15+0xed/0x340
>> [  162.441662]  ip_rcv+0xb7/0xc0
>> [  162.442129]  __netif_receive_skb_one_core+0x79/0x90
>> [  162.442886]  process_backlog+0x82/0x120
>> [  162.443483]  net_rx_action+0x138/0x3d0
>> [  162.444068]  __do_softirq+0xd8/0x2cb
>> [  162.444626]  irq_exit+0x9b/0xa0
>> [  162.445113]  smp_apic_timer_interrupt+0x6f/0x120
>> [  162.445820]  apic_timer_interrupt+0xf/0x20
>> [  162.446458]  </IRQ>
>> [  162.446793] RIP: 0010:default_idle+0x20/0x140
>> [  162.447473] Code: ff eb c7 e8 22 bc 5b ff 90 90 41 55 41 54 55 53 65
>> 8b 2d 43 59 cf 7a 0f 1f 44 00 00 e9 07 00 00 00 0f 00 2d a4 9b 4f 00 fb
>> f4 <65> 8b 2d 29 59 cf 7a 0f 1f 44 00 00 5b 5d 41 5c 41 5d c3 65 8b 05
>> [  162.450316] RSP: 0018:ffffffff85c03e98 EFLAGS: 00000246 ORIG_RAX:
>> ffffffffffffff13
>> [  162.451468] RAX: ffffffff8531aa00 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> [  162.452476] RDX: 0000000000000001 RSI: 0000000000000083 RDI:
>> 0000000000000000
>> [  162.453534] RBP: 0000000000000000 R08: 0000004254d4a19e R09:
>> 0000000000000004
>> [  162.454546] R10: ffffb3eb80197d88 R11: 0000000000000000 R12:
>> 0000000000000000
>> [  162.455642] R13: 0000000000000000 R14: ffff93a51ffd6180 R15:
>> 0000000000000000
>> [  162.456728]  ? __sched_text_end+0x2/0x2
>> [  162.457323]  do_idle+0x19a/0x230
>> [  162.457832]  cpu_startup_entry+0x14/0x20
>> [  162.458443]  start_kernel+0x4c0/0x4e2
>> [  162.459016]  secondary_startup_64+0xa4/0xb0
>> [  162.459669] ---[ end trace 869ccfaeaf536fdb ]---
>> [ FAIL ] client exit code 0, server 141
>> # \nnetns ns2 socket stat for 10060:
>> # State   Recv-Q    Send-Q        Local Address:Port         Peer
>> Address:Port
>> # \nnetns ns4 socket stat for 10060:
>> # State   Recv-Q    Send-Q        Local Address:Port         Peer
>> Address:Port
>> # ns4  MPTCP -> ns3  (10.0.2.2:10061) MPTCP	[ OK ]
>>
>> May you have a look at it because it looks linked to your modification? =
:)
> =

> I'm investigating this right now. It took a good deal of iterations to
> reproduce it and I lack some info even then, so it looks like it will
> take some time get to the bottom of it.

Thank you for looking at that. It seems the server was a bit busy (CPU =

but mainly IO I think) with other tasks when executing the test. I don't =

know if it would help for you to debug this. Also it is using virtme[1], =

maybe some configurations are making the bug easier to reproduce.

[1] https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/ci
($ ./patches/Dockerfile.virtme.sh patches/virtme.sh)

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5877640272439174035==--
