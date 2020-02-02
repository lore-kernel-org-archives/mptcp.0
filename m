Content-Type: multipart/mixed; boundary="===============4865955428797241499=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [GIT] Sync with net-next on 20190131: a few conflicts
Date: Sun, 02 Feb 2020 09:38:22 +0100
Message-ID: <2b6d9285-a73e-047d-6b71-33b6a47f45e4@tessares.net>
In-Reply-To: ff82f12d-c1e3-e64f-95ba-fff450928c78@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3572

--===============4865955428797241499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 31/01/2020 18:42, Matthieu Baerts wrote:
> Hello,
> =

> It seems that recently, 'net-next' has been synced with 'net' which =

> contains some modifications in MPTCP code. We then had a few conflicts =

> due to Florian's patch-set, see: 55c6ab4b368 (Merge branch =

> 'mptcp-fix-sockopt-crash-and-lockdep-splats')
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Dd55c6ab4b368633f39f8fe059f3b877f978cfb4c =


FYI, I was not able to validate the new version after having resolved =

conflicts because it crashed before starting MPTCP:



[    0.306339] general protection fault, probably for non-canonical =

address 0x9896808086a201: 0000 [#1] SMP PTI
[    0.307326] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0+ #3
[    0.307326] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =

BIOS 1.10.2-1ubuntu1 04/01/2014
[    0.307326] RIP: 0010:__kmalloc+0x8e/0x200
[    0.307326] Code: 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 91 f0 =

dc 46 4d 8b 20 4d 85 e4 0f 84 42 01 00 00 8b 45 20 48 8b 7d 00 48 8d 4a =

01 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 c5 8b 45 20
[    0.307326] RSP: 0000:ffffb66780013db0 EFLAGS: 00010202
[    0.307326] RAX: 0000000000000000 RBX: ffffa2775f08d003 RCX: =

00000000000000dc
[    0.307326] RDX: 00000000000000db RSI: 0000000000000dc0 RDI: =

000000000002d3c0
[    0.307326] RBP: ffffa2775f001700 R08: ffffa2775f42d3c0 R09: =

ffffa2775f282600
[    0.307326] R10: ffffb66780013df8 R11: 0000000000000000 R12: =

009896808086a201
[    0.307326] R13: 0000000000000dc0 R14: 00000000000000fe R15: =

ffffffffb92dadf1
[    0.307326] FS:  0000000000000000(0000) GS:ffffa2775f400000(0000) =

knlGS:0000000000000000
[    0.307326] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.307326] CR2: 0000000000000000 CR3: 000000001d40a001 CR4: =

0000000000360ef0
[    0.307326] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =

0000000000000000
[    0.307326] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =

0000000000000400
[    0.307326] Call Trace:
[    0.307326]  __register_sysctl_table+0x411/0x5a0
[    0.307326]  ? kmem_cache_alloc_trace+0x36/0x1b0
[    0.307326]  __register_sysctl_paths+0x1bb/0x1e0
[    0.307326]  ? set_debug_rodata+0xc/0xc
[    0.307326]  dquot_init+0x2a/0x111
[    0.307326]  ? iomap_init+0x1b/0x1b
[    0.307326]  do_one_initcall+0x41/0x1e0
[    0.307326]  kernel_init_freeable+0x169/0x1c3
[    0.307326]  ? rest_init+0xb0/0xb0
[    0.307326]  kernel_init+0x5/0x100
[    0.307326]  ret_from_fork+0x35/0x40
[    0.307326] Modules linked in:
[    0.330667] ---[ end trace 6ebe1a517677856d ]---
[    0.331337] RIP: 0010:__kmalloc+0x8e/0x200
[    0.331935] Code: 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 91 f0 =

dc 46 4d 8b 20 4d 85 e4 0f 84 42 01 00 00 8b 45 20 48 8b 7d 00 48 8d 4a =

01 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 c5 8b 45 20
[    0.334699] RSP: 0000:ffffb66780013db0 EFLAGS: 00010202
[    0.335482] RAX: 0000000000000000 RBX: ffffa2775f08d003 RCX: =

00000000000000dc
[    0.336555] RDX: 00000000000000db RSI: 0000000000000dc0 RDI: =

000000000002d3c0
[    0.337626] RBP: ffffa2775f001700 R08: ffffa2775f42d3c0 R09: =

ffffa2775f282600
[    0.338701] R10: ffffb66780013df8 R11: 0000000000000000 R12: =

009896808086a201
[    0.339774] R13: 0000000000000dc0 R14: 00000000000000fe R15: =

ffffffffb92dadf1
[    0.340845] FS:  0000000000000000(0000) GS:ffffa2775f400000(0000) =

knlGS:0000000000000000
[    0.342067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.342935] CR2: 0000000000000000 CR3: 000000001d40a001 CR4: =

0000000000360ef0
[    0.344006] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =

0000000000000000
[    0.345074] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =

0000000000000400
[    0.346133] Kernel panic - not syncing: Attempted to kill init! =

exitcode=3D0x0000000b
[    0.347127] ---[ end Kernel panic - not syncing: Attempted to kill =

init! exitcode=3D0x0000000b ]---


It looks like it is similar to: https://lkml.org/lkml/2020/1/30/7

It seems patches to fix that have been shared. I guess net-next will be =

updated soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4865955428797241499==--
