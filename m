Content-Type: multipart/mixed; boundary="===============4287931408175168723=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Warn + crash in mptcp_sendmsg_frag()
Date: Fri, 15 Nov 2019 22:06:34 +0100
Message-ID: <6b5f90c3-aa06-baa1-15a0-29b69204e659@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2555

--===============4287931408175168723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

When testing some changes in the kselftests area, I initially saw the =

message:

   main_loop_s: timed out

in the middle of the tests. But just after, there was a "[ OK ]".
Anybody saw that?

I tried to understand why because the binary should returns 2 if the =

message is printed and the shell script should catch the error. Then I =

added debug in the script and launched it in a while-loop. I didn't get =

the initial error I was looking for but instead I got a WARN followed by =

an OOPS:


+ addr_port=3D10.0.3.1:10030
+ printf '%-4s %-5s -> %-4s (%-20s) %-5s\t' ns3-5dcee2db-MqSsUi MPTCP =

ns4-5dcee2db-MqSsUi 10.0.3.1:10030 MPTCP
ns3-5dcee2db-MqSsUi MPTCP -> ns4-5dcee2db-MqSsUi (10.0.3.1:10030      ) =

MPTCP
+ false
+ spid=3D28842
+ ip netns exec ns4-5dcee2db-MqSsUi ./mptcp_connect -t 30 -l -p 10030 -s =

MPTCP 0.0.0.0
+ sleep 1
++ date +%s%3N
+ start=3D1573839651723
+ cpid=3D28845
+ ip netns exec ns3-5dcee2db-MqSsUi ./mptcp_connect -t 30 -p 10030 -s =

MPTCP 10.0.3.1
+ wait 28845
[90317.510635] ------------[ cut here ]------------
[90317.511028] WARNING: CPU: 0 PID: 28845 at net/mptcp/protocol.c:317 =

mptcp_sendmsg_frag+0x51b/0x570
[90317.511028] Modules linked in:
[90317.511028] CPU: 0 PID: 28845 Comm: mptcp_connect Not tainted =

5.4.0-rc6+ #316
[90317.511028] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =

BIOS 1.10.2-1ubuntu1 04/01/2014
[90317.511028] RIP: 0010:mptcp_sendmsg_frag+0x51b/0x570
[90317.511028] Code: fc ff ff 49 63 53 18 49 03 53 10 48 3b 95 58 05 00 =

00 0f 85 0c fe ff ff c6 44 24 3f 01 c7 44 24 38 00 00 00 00 e9 5a fe ff =

ff <0f> 0b eb b0 48 8b 7c 24 48 4c 89 ce 44 89 44 24 30 48 29 ce 4c 89
[90317.511028] RSP: 0018:ffff979e40287cc8 EFLAGS: 00010246
[90317.511028] RAX: ffff921f1de56200 RBX: ffff921f1d430900 RCX: =

0000000000001fa0
[90317.511028] RDX: 0000000000001fa0 RSI: 0000000000000000 RDI: =

ffff921f1d430900
[90317.511028] RBP: ffff921f1d451380 R08: 0000000000001fa0 R09: =

0000000000001fa0
[90317.511028] R10: ffff921f1dc8eec0 R11: ffff921f1de58000 R12: =

ffff921f1d4518d8
[90317.511028] R13: ffff921f1de56200 R14: ffff921f1edcf6d0 R15: =

0000000000001fa0
[90317.511028] FS:  00007f53fa681500(0000) GS:ffff921f1f200000(0000) =

knlGS:0000000000000000
[90317.511028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[90317.511028] CR2: 00007f049c5dfe60 CR3: 000000001dc30000 CR4: =

00000000003406f0
[90317.511028] Call Trace:
[90317.511028]  mptcp_sendmsg+0x15b/0x230
[90317.511028]  sock_sendmsg+0x4f/0x60
[90317.511028]  sock_write_iter+0x8a/0xf0
[90317.511028]  new_sync_write+0x116/0x1b0
[90317.511028]  vfs_write+0xa8/0x1a0
[90317.511028]  ksys_write+0x9c/0xd0
[90317.511028]  do_syscall_64+0x43/0x120
[90317.511028]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[90317.511028] RIP: 0033:0x7f53fa180154
[90317.511028] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 =

00 00 00 66 90 48 8d 05 b1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f =

05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
[90317.511028] RSP: 002b:00007ffd5f71be78 EFLAGS: 00000246 ORIG_RAX: =

0000000000000001
[90317.511028] RAX: ffffffffffffffda RBX: 00007ffd5f71bea8 RCX: =

00007f53fa180154
[90317.511028] RDX: 0000000000002000 RSI: 00007ffd5f71beb0 RDI: =

0000000000000003
[90317.511028] RBP: 0000000000000003 R08: 00007f53fa45b1d0 R09: =

00007f53fa45b240
[90317.511028] R10: 00007f53fa1dad30 R11: 0000000000000246 R12: =

00007ffd5f71deb0
[90317.511028] R13: 0000000000002000 R14: 0000000000002000 R15: =

0000000000002000
[90317.511028] ---[ end trace 6d6ab3e3a5c67aed ]---
[90318.041976] BUG: kernel NULL pointer dereference, address: =

0000000000000014
[90318.042798] #PF: supervisor write access in kernel mode
[90318.042798] #PF: error_code(0x0002) - not-present page
[90318.042798] PGD 0 P4D 0
[90318.042798] Oops: 0002 [#1] SMP NOPTI
[90318.042798] CPU: 0 PID: 28845 Comm: mptcp_connect Tainted: G        W =

         5.4.0-rc6+ #316
[90318.042798] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =

BIOS 1.10.2-1ubuntu1 04/01/2014
[90318.042798] RIP: 0010:mptcp_sendmsg_frag+0x4d4/0x570
[90318.042798] Code: 00 e9 72 fc ff ff 48 c7 44 24 20 00 00 00 00 41 80 =

4d 37 02 c6 44 24 1c 00 e9 0f fc ff ff 80 7c 24 1c 00 74 4c 48 8b 44 24 =

20 <66> 44 01 78 14 48 83 3c 24 00 0f 85 d4 fc ff ff 45 01 46 08 e9 cb
[90318.042798] RSP: 0018:ffff979e40287cc8 EFLAGS: 00010246
[90318.042798] RAX: 0000000000000000 RBX: ffff921f1d430900 RCX: =

0000000000001fa0
[90318.042798] RDX: 0000000000001fa0 RSI: 0000000000000000 RDI: =

ffff921f1d430900
[90318.042798] RBP: ffff921f1d451380 R08: 0000000000001fa0 R09: =

0000000000001fa0
[90318.042798] R10: ffff921f1dc8eec0 R11: ffff921f1de58000 R12: =

ffff921f1d4518d8
[90318.042798] R13: ffff921f1de56200 R14: ffff921f1edcf6d0 R15: =

0000000000001fa0
[90318.042798] FS:  00007f53fa681500(0000) GS:ffff921f1f200000(0000) =

knlGS:0000000000000000
[90318.042798] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[90318.042798] CR2: 0000000000000014 CR3: 000000001dc30000 CR4: =

00000000003406f0
[90318.042798] Call Trace:
[90318.042798]  mptcp_sendmsg+0x15b/0x230
[90318.042798]  sock_sendmsg+0x4f/0x60
[90318.042798]  sock_write_iter+0x8a/0xf0
[90318.042798]  new_sync_write+0x116/0x1b0
[90318.042798]  vfs_write+0xa8/0x1a0
[90318.042798]  ksys_write+0x9c/0xd0
[90318.042798]  do_syscall_64+0x43/0x120
[90318.042798]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[90318.042798] RIP: 0033:0x7f53fa180154
[90318.042798] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 =

00 00 00 66 90 48 8d 05 b1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f =

05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
[90318.042798] RSP: 002b:00007ffd5f71be78 EFLAGS: 00000246 ORIG_RAX: =

0000000000000001
[90318.042798] RAX: ffffffffffffffda RBX: 00007ffd5f71bea8 RCX: =

00007f53fa180154
[90318.042798] RDX: 0000000000002000 RSI: 00007ffd5f71beb0 RDI: =

0000000000000003
[90318.042798] RBP: 0000000000000003 R08: 00007f53fa45b1d0 R09: =

00007f53fa45b240
[90318.042798] R10: 00007f53fa1dad30 R11: 0000000000000246 R12: =

00007ffd5f71deb0
[90318.042798] R13: 0000000000002000 R14: 0000000000002000 R15: =

0000000000002000
[90318.042798] Modules linked in:
[90318.042798] CR2: 0000000000000014
[90318.042798] ---[ end trace 6d6ab3e3a5c67aee ]---
[90318.042798] RIP: 0010:mptcp_sendmsg_frag+0x4d4/0x570
[90318.042798] Code: 00 e9 72 fc ff ff 48 c7 44 24 20 00 00 00 00 41 80 =

4d 37 02 c6 44 24 1c 00 e9 0f fc ff ff 80 7c 24 1c 00 74 4c 48 8b 44 24 =

20 <66> 44 01 78 14 48 83 3c 24 00 0f 85 d4 fc ff ff 45 01 46 08 e9 cb
[90318.042798] RSP: 0018:ffff979e40287cc8 EFLAGS: 00010246
[90318.042798] RAX: 0000000000000000 RBX: ffff921f1d430900 RCX: =

0000000000001fa0
[90318.042798] RDX: 0000000000001fa0 RSI: 0000000000000000 RDI: =

ffff921f1d430900
[90318.042798] RBP: ffff921f1d451380 R08: 0000000000001fa0 R09: =

0000000000001fa0
[90318.042798] R10: ffff921f1dc8eec0 R11: ffff921f1de58000 R12: =

ffff921f1d4518d8
[90318.042798] R13: ffff921f1de56200 R14: ffff921f1edcf6d0 R15: =

0000000000001fa0
[90318.042798] FS:  00007f53fa681500(0000) GS:ffff921f1f200000(0000) =

knlGS:0000000000000000
[90318.042798] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[90318.042798] CR2: 0000000000000014 CR3: 000000001dc30000 CR4: =

00000000003406f0


Of course, in parallel I did other stuffs, I no longer have the proper =

vmlinux and my MPTCP VM was not recent...

I suspect that "skb" is NULL and we then have an issue with this chunk:


         collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
         if (collapsed) {
                 WARN_ON_ONCE(!can_collapse);
                 /* when collapsing mpext always exists */
                 mpext->data_len +=3D ret;
                 goto out;
         }


Please also note that earlier in the function, skb is initialised with:

     skb =3D tcp_write_queue_tail(ssk);

So I guess collapsed is always true, no?

If skb is NULL, mpext is NULL too (even if it could unlikely also be =

even if skb is no NULL but sounds more like a bug I guess) and =

can_collapse is False.

I prefer to share this now as I might not be able to look at this before =

a few days, being off for a few days from now. Does someone interested =

by looking at this? :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4287931408175168723==--
