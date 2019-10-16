Content-Type: multipart/mixed; boundary="===============1562977251042888354=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: just another recvmsg refactor
Date: Wed, 16 Oct 2019 11:09:24 -0700
Message-ID: <alpine.OSX.2.21.1910161104530.1547@rtgarci1-mobl2.amr.corp.intel.com>
In-Reply-To: 367074ea-8e11-9678-00c6-9bd9bd49ae5b@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2193

--===============1562977251042888354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 16 Oct 2019, Matthieu Baerts wrote:

> On 16/10/2019 16:07, Matthieu Baerts wrote:
>> On 16/10/2019 15:54, Paolo Abeni wrote:
>>> On Wed, 2019-10-16 at 13:14 +0200, Matthieu Baerts wrote:
>>>> On 16/10/2019 12:02, Matthieu Baerts wrote:
>>>> May you have a look at it because it looks linked to your modification=
? =

>>>> :)
>>> =

>>> I'm investigating this right now. It took a good deal of iterations to
>>> reproduce it and I lack some info even then, so it looks like it will
>>> take some time get to the bottom of it.
>> =

>> Thank you for looking at that. It seems the server was a bit busy (CPU b=
ut =

>> mainly IO I think) with other tasks when executing the test. I don't kno=
w =

>> if it would help for you to debug this. Also it is using virtme[1], mayb=
e =

>> some configurations are making the bug easier to reproduce.
>> =

>> [1] https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/ci
>> ($ ./patches/Dockerfile.virtme.sh patches/virtme.sh)
>
> It seems easier to reproduce with KASAN and PROVE_LOCKING:
>
>  -e KASAN -e KASAN_OUTLINE -d TEST_KASAN -e PROVE_LOCKING -d DEBUG_LOCKDEP
>

I saw it with KASAN and PROVE_LOCKING as well, same call stack as Matthieu =

first reported. It was the ns4->ns3 MPTCP/MPTCP test (one of the =

reordering and packet loss cases).

[  255.643758] Bad mapping: ssn=3D258285 map_seq=3D225143 map_data_len=3D32=
660
[  255.643795] WARNING: CPU: 1 PID: 0 at net/mptcp/subflow.c:332 warn_bad_m=
ap.isra.0.part.0+0x1d/0x20
[  255.647284] Modules linked in:
[  255.647921] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.4.0-rc1+ #8
[  255.649191] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.12.0-2.fc30 04/01/2014
[  255.651030] RIP: 0010:warn_bad_map.isra.0.part.0+0x1d/0x20
[  255.652157] Code: c9 aa 00 5d e9 b4 92 33 00 0f 1f 40 00 49 89 f0 89 d6 =
8b 17 48 c7 c7 08 74 2e be 41 8b 08 c6 05 12 bf a6 00 01 e8 a9 d5 59 ff <0f=
> 0b c3 41 55 49 89 f5 41 54 49 89 fc 0f 1f 44 00 00 49 8b 45 58
[  255.655927] RSP: 0018:ffff9c19400acbe0 EFLAGS: 00010282
[  255.656998] RAX: 0000000000000000 RBX: ffff9635f5f6c800 RCX: 00000000000=
00000
[  255.658441] RDX: 0000000000000039 RSI: ffffffffbeb50359 RDI: ffffffffbeb=
50759
[  255.659892] RBP: ffff9635f3cbb540 R08: 0000003b858e3036 R09: 00000000000=
00039
[  255.661336] R10: ffff9c19400aca38 R11: ffffffffbeb50359 R12: ffff9635f3c=
bb540
[  255.662762] R13: ffff9635f600ba80 R14: ffff9635f5f6c8d0 R15: ffff9635f69=
916e0
[  255.664193] FS:  0000000000000000(0000) GS:ffff9635fba80000(0000) knlGS:=
0000000000000000
[  255.665844] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  255.667015] CR2: 00007ffff8c61ec0 CR3: 0000000133c62004 CR4: 00000000003=
60ee0
[  255.668507] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  255.669918] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  255.671332] Call Trace:
[  255.671853]  <IRQ>
[  255.672294]  mptcp_subflow_data_available+0x5cb/0x730
[  255.673382]  subflow_data_ready+0x3b/0x70
[  255.674185]  tcp_data_queue+0x376/0xc40
[  255.674950]  tcp_rcv_state_process+0x317/0xd9a
[  255.675862]  ? sk_filter_trim_cap+0x3c/0x1e0
[  255.676739]  ? tcp_v4_inbound_md5_hash+0x3f/0x160
[  255.677685]  tcp_v4_do_rcv+0xb3/0x1f0
[  255.678442]  tcp_v4_rcv+0xacf/0xbd0
[  255.679152]  ip_protocol_deliver_rcu+0x26/0x1b0
[  255.680058]  ip_local_deliver_finish+0x3f/0x50
[  255.680991]  ip_local_deliver+0xe0/0xf0
[  255.681772]  ? ip_rcv_finish_core.isra.0+0xef/0x340
[  255.682745]  ip_rcv+0xb7/0xc0
[  255.683340]  ? dev_hard_start_xmit+0x88/0x1d0
[  255.684212]  __netif_receive_skb_one_core+0x7b/0x90
[  255.685177]  process_backlog+0x8b/0x120
[  255.685960]  net_rx_action+0x12c/0x360
[  255.686710]  __do_softirq+0xdb/0x2d8
[  255.687517]  irq_exit+0x9b/0xa0
[  255.688149]  smp_apic_timer_interrupt+0x69/0x130
[  255.689090]  apic_timer_interrupt+0xf/0x20
[  255.689934]  </IRQ>
[  255.690369] RIP: 0010:default_idle+0x1e/0x140
[  255.691358] Code: ee 99 ff eb c9 e8 e2 ba 57 ff 90 90 41 54 55 65 8b 2d =
66 6e 52 42 53 0f 1f 44 00 00 e9 07 00 00 00 0f 00 2d c6 bc 51 00 fb f4 <65=
> 8b 2d 4b 6e 52 42 0f 1f 44 00 00 5b 5d 41 5c c3 65 8b 05 3a 6e
[  255.695190] RSP: 0018:ffff9c1940067eb8 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[  255.696787] RAX: ffffffffbdae94e0 RBX: 0000000000000001 RCX: ffff9635fba=
96000
[  255.698185] RDX: 0000000000000001 RSI: 7fffffc4722984a4 RDI: ffff9635fba=
9ca80
[  255.699577] RBP: 0000000000000001 R08: 000000cd42e4dffb R09: 0000003b95d=
328db
[  255.701108] R10: 0000000000000000 R11: 0000000000002000 R12: ffff9635fb1=
29c00
[  255.702501] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9635fb1=
29c00
[  255.703897]  ? __sched_text_end+0x2/0x2
[  255.704662]  do_idle+0x1dd/0x230
[  255.705334]  cpu_startup_entry+0x14/0x20
[  255.706149]  start_secondary+0x152/0x1a0
[  255.706944]  secondary_startup_64+0xa4/0xb0



--
Mat Martineau
Intel
--===============1562977251042888354==--
