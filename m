Content-Type: multipart/mixed; boundary="===============6773945911634968345=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] KSelftests: warnings last night (20190703)
Date: Wed, 03 Jul 2019 13:56:08 +0200
Message-ID: <890b358c-71ce-8039-791b-f387792ec05d@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1466

--===============6773945911634968345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Here is just a small note to say that I got one warning last night. It
seems not related to MPTCP but I prefer to share it, it might be useful
for some people, just in case.

[    9.380277] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    9.380836] WARNING: suspicious RCU usage
[    9.381454] 5.2.0-rc6+ #4 Not tainted
[    9.382003] -----------------------------
[    9.382628] ./include/linux/rtnetlink.h:85 suspicious
rcu_dereference_protected() usage!
[    9.383798]
[    9.383798] other info that might help us debug this:
[    9.383798]
[    9.384910]
[    9.384910] rcu_scheduler_active =3D 2, debug_locks =3D 1
[    9.385819] no locks held by swapper/0/1.
[    9.386437]
[    9.386437] stack backtrace:
[    9.387087] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc6+ #4
[    9.387425] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1ubuntu1 04/01/2014
[    9.387425] Call Trace:
[    9.387425]  dump_stack+0x7c/0xbb
[    9.387425]  dev_init_scheduler+0x162/0x1a0
[    9.387425]  ? net_olddevs_init+0x58/0x58
[    9.387425]  ? set_debug_rodata+0xc/0xc
[    9.387425]  blackhole_netdev_init+0x3d/0x7e
[    9.387425]  do_one_initcall+0x9d/0x32f
[    9.387425]  ? trace_event_raw_event_initcall_finish+0x140/0x140
[    9.387425]  ? retint_kernel+0x10/0x10
[    9.387425]  ? loglevel+0xd/0xb6
[    9.387425]  ? set_debug_rodata+0xc/0xc
[    9.387425]  ? set_debug_rodata+0xc/0xc
[    9.387425]  kernel_init_freeable+0x29b/0x331
[    9.387425]  ? rest_init+0x250/0x250
[    9.387425]  kernel_init+0xa/0x120
[    9.387425]  ? _raw_spin_unlock_irq+0x24/0x30
[    9.387425]  ? rest_init+0x250/0x250
[    9.387425]  ret_from_fork+0x3a/0x50


Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6773945911634968345==--
