Content-Type: multipart/mixed; boundary="===============6337552077470560632=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 9/9] don't flag parent socket as RCV_SHUTDOWN
 if one one subflow has closed
Date: Fri, 06 Dec 2019 16:52:34 +0100
Message-ID: <a0204fbd-6678-c9ce-1273-9f6183892615@tessares.net>
In-Reply-To: 7ffecd01-f428-b74b-4cc9-4ae9c642a788@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2822

--===============6337552077470560632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo, Mat,

On 03/12/2019 10:13, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 03/12/2019 10:05, Paolo Abeni wrote:
>> On Tue, 2019-12-03 at 08:44 +0100, Matthieu Baerts wrote:
>>> Hi Florian, Paolo, Mat,
>>>
>>> On 02/12/2019 22:21, Paolo Abeni wrote:
>>>> On Mon, 2019-12-02 at 20:10 +0100, Florian Westphal wrote:
>>>
>>> [...]
>>>
>>>> Thanks for addressing my comments.
>>>>
>>>> With 9/9 v2 the series is IMHO ready to me merged.
>>>
>>> Thank you for the nice patch series and the reviews!
>>> Related to what we discussed yesterday, is it OK if I merge this after:
>>>
>>> =C2=A0=C2=A0 1) DATA_FIN
>>> =C2=A0=C2=A0 2) MPTCPv1 =E2=86=92 wait a bit for a review
>>> =C2=A0=C2=A0 3) SendMsg "refactor" =E2=86=92 if reviewed
>>>
>>> Or can I do that after the patches for MPTCPv1 if the patches to fix
>>> sendmsg() have not been reviewed yet?
>>
>> I think/hope this and sendmsg patches should not conflict much - but
>> sendmsg patches do create quite of conflict with the following patches.
>>
>> I think that appling this series after v1 could be a good option, will
>> give extra time to review the sendmsg() patches, and I can rebase my
>> tree to help the merging.
> =

> Thank you for your reply!
> =

> Sounds good to me. If there is nothing to change in sendmsg() patches =

> after the review, I can also start applying them. If I am blocked, I can =

> ask for help.

Thank you again for the patches and the reviews!

- 192c07c3fe9b: "squashed" patch 1/9 in "mptcp: Add handling of incoming =

MP_JOIN requests"
- d6c1939a16c5..2cc726803b47: result
- 0c24eaeadf60: "squashed" patch 2/9, part 1, in "mptcp: Add handling of =

incoming MP_JOIN requests"
- f2a1eeb27eab: "squashed" patch 2/9, part 2, in "mptcp: Add handling of =

outgoing MP_JOIN requests"
- 216b0b82f102: conflict in t/mptcp-introduce-MPTCP-retransmission-timer
- e1012595cc3d: conflict in t/mptcp-add-and-use-mptcp-RTX-flag
- 2cc726803b47..48f66afb6a81: result
- the other patches have been added at the end. I had some conflicts with:
  - "copy connection id from first subflow to mptcp socket"
  - "make accept not allocate kernel socket struct"
  - "subflow: place further subflows on new 'join_list'"

Tests on top of the commit introducing the kselftests are OK but not the =

one at the end of the series (export branch). Here is the trace (without =

CONFIG_KASAN nor PROVE_LOCKING)



00:07:55.647 # INFO: set ns3-5dea74bc-S7alT1 dev ns3eth2: ethtool -K tso =

off gro off
00:07:55.658 # INFO: set ns4-5dea74bc-S7alT1 dev ns4eth3: ethtool -K =

gro off
00:07:55.685 # Created /tmp/tmp.FSDFbTHqEa (size 3070486) containing =

data sent by client
00:07:55.694 # Created /tmp/tmp.klmXQh5uiX (size 375225) containing data =

sent by server
00:07:55.742 # New MPTCP socket can be blocked via sysctl		[ OK ]
00:07:55.763 # setsockopt(..., TCP_ULP, "mptcp", ...) blocked	[ OK ]
00:07:55.770 # INFO: validating network environment with pings
00:07:56.500 [   11.837548] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth1: link =

becomes ready
00:07:58.413 # INFO: Using loss of 0.10% delay 87 ms reorder 96% 42% on =

ns3eth4
00:07:58.420 # ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration =

  19ms) [ OK ]
00:07:58.471 # ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration =

  18ms) [ OK ]
00:07:58.518 # ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP	(duration =

  18ms) [ OK ]
00:07:58.566 # ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP	(duration =

  17ms) [ OK ]
00:07:58.612 # ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP  	(duration =

  18ms) [ OK ]
00:07:58.660 # ns1 TCP   -> ns1 (dead:beef:1::1:10005) MPTCP	[ =

14.024584] BUG: unable to handle page fault for address: 00000003435d11af
00:07:58.688 [   14.025780] #PF: supervisor read access in kernel mode
00:07:58.689 [   14.026588] #PF: error_code(0x0000) - not-present page
00:07:58.690 [   14.027394] PGD 0 P4D 0
00:07:58.690 [   14.027801] Oops: 0000 [#1] SMP PTI
00:07:58.691 [   14.028355] CPU: 0 PID: 731 Comm: mptcp_connect Not =

tainted 5.4.0+ #5
00:07:58.692 [   14.029365] Hardware name: QEMU Standard PC (i440FX + =

PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
00:07:58.693 [   14.030752] RIP: 0010:mptcp_stream_accept+0x8d/0x160
00:07:58.694 [   14.031533] Code: 8b 9c 24 b0 05 00 00 49 81 c4 b0 05 00 =

00 4c 39 e3 74 71 49 8d 76 40 48 89 74 24 08 eb 08 48 8b 1b 4c 39 e3 74 =

5e 48 8b 6b 78 <48> 83 bd 78 02 00 00 00 75 ea 4c 8d bd 28 02 00 00 89 =

44 24 04 4c
00:07:58.697 [   14.034405] RSP: 0018:ffffad8d8044bdf0 EFLAGS: 00010283
00:07:58.698 [   14.035218] RAX: 0000000000000000 RBX: ffff96f35d0d9928 =

RCX: 0000000000000001
00:07:58.699 [   14.036317] RDX: 0000000000000001 RSI: ffff96f35eaffb40 =

RDI: ffffffffb6199b8a
00:07:58.700 [   14.037423] RBP: 00000003435d0f37 R08: ffff96f35f42e690 =

R09: ffffad8d8044bdb0
00:07:58.701 [   14.038528] R10: ffff96f35e375340 R11: ffff96f35d0d0740 =

R12: ffff96f35d0d9930
00:07:58.702 [   14.039622] R13: ffff96f35eafe300 R14: ffff96f35eaffb00 =

R15: ffff96f35eaffb00
00:07:58.703 [   14.040721] FS:  00007fad7081d500(0000) =

GS:ffff96f35f400000(0000) knlGS:0000000000000000
00:07:58.704 [   14.041973] CS:  0010 DS: 0000 ES: 0000 CR0: =

0000000080050033
00:07:58.738 [   14.042879] CR2: 00000003435d11af CR3: 000000001e3f4006 =

CR4: 00000000003606f0
00:07:58.738 [   14.043987] DR0: 0000000000000000 DR1: 0000000000000000 =

DR2: 0000000000000000
00:07:58.738 [   14.045098] DR3: 0000000000000000 DR6: 00000000fffe0ff0 =

DR7: 0000000000000400
00:07:58.738 [   14.046204] Call Trace:
00:07:58.738 [   14.046599]  ? selinux_socket_accept+0x41/0x80
00:07:58.738 [   14.047294]  __sys_accept4_file+0xf7/0x1c0
00:07:58.738 [   14.047937]  ? mptcp_bind+0x38/0xa0
00:07:58.738 [   14.048487]  ? __inet_hash+0x120/0x2c0
00:07:58.738 [   14.049084]  ? kvm_clock_get_cycles+0xd/0x10
00:07:58.738 [   14.049751]  ? ktime_get_ts64+0x47/0xe0
00:07:58.738 [   14.050351]  __sys_accept4+0x3b/0x70
00:07:58.738 [   14.050911]  __x64_sys_accept+0x13/0x20
00:07:58.738 [   14.051510]  do_syscall_64+0x43/0x160
00:07:58.738 [   14.052084]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
00:07:58.738 [   14.052864] RIP: 0033:0x7fad7032e7e4
00:07:58.738 [   14.053428] Code: 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 =

2e 0f 1f 84 00 00 00 00 00 48 8d 05 21 e1 2c 00 8b 00 85 c0 75 13 b8 2b =

00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 =

53 48 89 f5
00:07:58.738 [   14.056279] RSP: 002b:00007fffba32c8e8 EFLAGS: 00000246 =

ORIG_RAX: 000000000000002b
00:07:58.738 [   14.057447] RAX: ffffffffffffffda RBX: 0000000000000005 =

RCX: 00007fad7032e7e4
00:07:58.738 [   14.058544] RDX: 00007fffba32c900 RSI: 00007fffba32c910 =

RDI: 0000000000000005
00:07:58.738 [   14.059640] RBP: 0000000000000005 R08: 0000000000000004 =

R09: 0000000000000000
00:07:58.738 [   14.060742] R10: 00007fffba32cb24 R11: 0000000000000246 =

R12: 00007fffba32c910
00:07:58.738 [   14.061863] R13: 000055e3b0610b4d R14: 00000000ffffffff =

R15: 0000000000000000
00:07:58.738 [   14.062974] Modules linked in:
00:07:58.738 [   14.063459] CR2: 00000003435d11af
00:07:58.738 [   14.063984] ---[ end trace 5eeeab694e375d46 ]---
00:07:58.738 [   14.064707] RIP: 0010:mptcp_stream_accept+0x8d/0x160
00:07:58.738 [   14.065487] Code: 8b 9c 24 b0 05 00 00 49 81 c4 b0 05 00 =

00 4c 39 e3 74 71 49 8d 76 40 48 89 74 24 08 eb 08 48 8b 1b 4c 39 e3 74 =

5e 48 8b 6b 78 <48> 83 bd 78 02 00 00 00 75 ea 4c 8d bd 28 02 00 00 89 =

44 24 04 4c
00:07:58.738 [   14.068351] RSP: 0018:ffffad8d8044bdf0 EFLAGS: 00010283
00:07:58.738 [   14.069169] RAX: 0000000000000000 RBX: ffff96f35d0d9928 =

RCX: 0000000000000001
00:07:58.738 [   14.070274] RDX: 0000000000000001 RSI: ffff96f35eaffb40 =

RDI: ffffffffb6199b8a
00:07:58.738 [   14.071378] RBP: 00000003435d0f37 R08: ffff96f35f42e690 =

R09: ffffad8d8044bdb0
00:07:58.738 [   14.072478] R10: ffff96f35e375340 R11: ffff96f35d0d0740 =

R12: ffff96f35d0d9930
00:07:58.738 [   14.073582] R13: ffff96f35eafe300 R14: ffff96f35eaffb00 =

R15: ffff96f35eaffb00
00:07:58.738 [   14.074685] FS:  00007fad7081d500(0000) =

GS:ffff96f35f400000(0000) knlGS:0000000000000000
00:07:58.738 [   14.075912] CS:  0010 DS: 0000 ES: 0000 CR0: =

0000000080050033
00:07:58.739 [   14.076805] CR2: 00000003435d11af CR3: 000000001e3f4006 =

CR4: 00000000003606f0
00:07:58.740 [   14.077853] DR0: 0000000000000000 DR1: 0000000000000000 =

DR2: 0000000000000000
00:07:58.741 [   14.078927] DR3: 0000000000000000 DR6: 00000000fffe0ff0 =

DR7: 0000000000000400
00:08:28.978 copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 4)
00:08:28.979 # ./mptcp_connect.sh: line 392:   731 Killed =

   ip netns exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port =

-s ${srv_proto} $extra_args $local_addr < "$sin" > "$sout"
00:08:28.988 # (duration 30308ms) [ FAIL ] client exit code 2, server 137
00:08:28.989 # \nnetns ns1-5dea74bc-S7alT1 socket stat for 10005:
00:08:29.013 # State  Recv-Q   Send-Q         Local Address:Port =

  Peer Address:Port
00:08:29.013 # ESTAB  94728    0           [dead:beef:1::1]:10005 =

[dead:beef:1::1]:40964    rto:0.2 ato:0.04 cwnd:10 reordering:0
00:08:29.015 # \nnetns ns1-5dea74bc-S7alT1 socket stat for 10005:
00:08:29.027 # State      Recv-Q  Send-Q        Local Address:Port =

   Peer Address:Port
00:08:29.027 # FIN-WAIT-1 0       1691129    [dead:beef:1::1]:40964 =

[dead:beef:1::1]:10005   timer:(persist,21sec,0) rto:0.2 cwnd:10 =

reordering:0
00:08:29.031 # FAIL: Could not even run loopback v6 test
00:08:29.062 not ok 1 selftests: net/mptcp: mptcp_connect.sh # exit=3D1


I guess it is not the top priority because part 1 and 2 are OK.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6337552077470560632==--
