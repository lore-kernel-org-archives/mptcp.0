Content-Type: multipart/mixed; boundary="===============4904389103452410717=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] kselftests: IPv6 crash when testing end of part 2
Date: Wed, 20 Nov 2019 20:49:05 +0100
Message-ID: <fbf10b11-60a7-8d44-f019-d4d9e4a4a9a3@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2629

--===============4904389103452410717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Since the move of 3 commits from part 2 to part 3 (see "[GIT] reduce =

patchset 2 (up to kselftests)" thread), the first IPv6 test, on the =

commit introducing the kselftests, causes a crash.

It is easy to reproduce:

   $ git checkout $(git log -1 --format=3D%H --grep "mptcp: add basic =

kselftest for mptcp" origin/net-next..origin/export)
   $ make -C tools/testing/selftests TARGETS=3Dnet/mptcp run_tests
   ## or if you have the scripts from the "scripts" branch:
   $ ./Dockerfile.virtme.sh virtme.sh

Here is what I got:



ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP   [   59.569727] general =

protection fault: 0000 [#1] SMP NOPTI
[   59.570060] CPU: 0 PID: 354 Comm: mptcp_connect Not tainted =

5.4.0-rc7+ #321
[   59.570060] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =

BIOS 1.10.2-1ubuntu1 04/01/2014
[   59.570060] RIP: 0010:__ipv6_sock_mc_close+0x82/0x100
[   59.570060] Code: 4c 89 fa e8 d0 e3 ff ff 4d 85 ff 75 44 3e 41 83 2c =

24 40 48 8d 7b 30 be 30 00 00 00 e8 47 b8 75 ff 48 8b 5d 58 48 85 db 74 =

34 <48> 8b 43 18 4c 89 f7 48 89 45 58 8b 73 10 e8 5b 9f ec ff 48 85 c0
[   59.570060] RSP: 0018:ffffa8948021be20 EFLAGS: 00010206
[   59.570060] RAX: 0000000000000001 RBX: 2185dbe0e23218d4 RCX: =

0000000000000001
[   59.570060] RDX: ffffa0c39edcd280 RSI: ffffa0c39e6b0380 RDI: =

ffffffff9c8fde20
[   59.570060] RBP: ffffa0c39df244f8 R08: 0000000000000000 R09: =

0000000000000000
[   59.570060] R10: ffffa0c39e6b0380 R11: ffffa0c39deb3f10 R12: =

ffffa0c39df24140
[   59.570060] R13: ffffa0c39df24000 R14: ffffa0c39ddb8000 R15: =

ffffa0c39e676c00
[   59.570060] FS:  00007f09acb80500(0000) GS:ffffa0c39f200000(0000) =

knlGS:0000000000000000
[   59.570060] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.570060] CR2: 00007fb168761e60 CR3: 000000001deda000 CR4: =

00000000003406f0
[   59.570060] Call Trace:
[   59.570060]  ipv6_sock_mc_close+0x37/0x40
[   59.570060]  inet6_release+0x16/0x30
[   59.570060]  __sock_release+0x38/0xb0
[   59.570060]  sock_close+0xc/0x10
[   59.570060]  __fput+0xb1/0x240
[   59.570060]  task_work_run+0x79/0xa0
[   59.570060]  exit_to_usermode_loop+0xa5/0xb0
[   59.570060]  do_syscall_64+0xf4/0x120
[   59.570060]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   59.570060] RIP: 0033:0x7f09ac67f8d4
[   59.570060] Code: eb 89 e8 cf 43 02 00 66 2e 0f 1f 84 00 00 00 00 00 =

0f 1f 44 00 00 48 8d 05 31 00 2e 00 8b 00 85 c0 75 13 b8 03 00 00 00 0f =

05 <48> 3d 00 f0 ff ff 77 3c f3 c3 66 90 53 89 fb 48 83 ec 10 e8 f4 fd
[   59.570060] RSP: 002b:00007ffcf9398688 EFLAGS: 00000246 ORIG_RAX: =

0000000000000003
[   59.570060] RAX: 0000000000000000 RBX: 00007ffcf93986b8 RCX: =

00007f09ac67f8d4
[   59.570060] RDX: 0000000000000000 RSI: 00007ffcf939a6c0 RDI: =

0000000000000003
[   59.570060] RBP: 0000000000000003 R08: 00007f09ac95a20c R09: =

00007f09ac95a240
[   59.570060] R10: fffffffffffff7e5 R11: 0000000000000246 R12: =

00007ffcf939a6c0
[   59.570060] R13: 0000000000000000 R14: 0000000000000000 R15: =

000000000000008f
[   59.570060] Modules linked in:
[   60.149224] ---[ end trace 5333410f2d3e653b ]---
[   60.162408] RIP: 0010:__ipv6_sock_mc_close+0x82/0x100
[   60.176519] Code: 4c 89 fa e8 d0 e3 ff ff 4d 85 ff 75 44 3e 41 83 2c =

24 40 48 8d 7b 30 be 30 00 00 00 e8 47 b8 75 ff 48 8b 5d 58 48 85 db 74 =

34 <48> 8b 43 18 4c 89 f7 48 89 45 58 8b 73 10 e8 5b 9f ec ff 48 85 c0
[   60.227674] RSP: 0018:ffffa8948021be20 EFLAGS: 00010206
[   60.242295] RAX: 0000000000000001 RBX: 2185dbe0e23218d4 RCX: =

0000000000000001
[   60.262192] RDX: ffffa0c39edcd280 RSI: ffffa0c39e6b0380 RDI: =

ffffffff9c8fde20
[   60.281343] RBP: ffffa0c39df244f8 R08: 0000000000000000 R09: =

0000000000000000
[   60.300763] R10: ffffa0c39e6b0380 R11: ffffa0c39deb3f10 R12: =

ffffa0c39df24140
[   60.320332] R13: ffffa0c39df24000 R14: ffffa0c39ddb8000 R15: =

ffffa0c39e676c00
[   60.339678] FS:  00007f09acb80500(0000) GS:ffffa0c39f200000(0000) =

knlGS:0000000000000000
[   60.361732] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   60.377509] CR2: 00007fb168761e60 CR3: 000000001deda000 CR4: =

00000000003406f0
./mptcp_connect.sh: line 360:   354 Segmentation fault      ip netns =

exec ${connector_ns} ./mptcp_connect -t $timeout -p $port -s ${cl_proto} =

$connect_addr < "$cin" > "$cout"
(duration   980ms) [ FAIL ] client exit code 139, server 0
\nnetns ns1-5dd5919f-pDmJLu socket stat for 10003:
State            Recv-Q          Send-Q                       Local =

Address:Port                        Peer Address:Port
TIME-WAIT        0               0 =

[dead:beef:1::1]:10003                   [dead:beef:1::1]:36930 =

timer:(timewait,58sec,0) cwnd:2 reordering:0
\nnetns ns1-5dd5919f-pDmJLu socket stat for 10003:
State          Recv-Q           Send-Q                        Local =

Address:Port                       Peer Address:Port
FAIL: Could not even run loopback v6 test



Is there someone who would like to have a look? :-)

Thank you!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4904389103452410717==--
