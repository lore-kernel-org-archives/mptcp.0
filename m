Content-Type: multipart/mixed; boundary="===============2239061094382423873=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next] mptcp: avoid using the main
 socket to send ack
Date: Fri, 04 Dec 2020 13:37:35 +0100
Message-ID: <70528f5ec27387eb6af3de9858d30b43dd3fc5c7.camel@redhat.com>
In-Reply-To: CA+WQbwu3ut5NEznc=4cvgF2ctZSbWbh6kK0_dxuefkUvNhuXew@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7048

--===============2239061094382423873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-12-04 at 20:02 +0800, Geliang Tang wrote:
> Hi Paolo,
> =

> Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B412=E6=9C=884=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:14=E5=86=99=E9=81=93=EF=BC=9A
> > On Fri, 2020-12-04 at 12:14 +0800, Geliang Tang wrote:
> > > This patch fixed the following syzkaller BUG:
> > > =

> > > [   15.223006] BUG: unable to handle page fault for address: 00000000=
00223b10
> > > [   15.223700] #PF: supervisor read access in kernel mode
> > > [   15.224209] #PF: error_code(0x0000) - not-present page
> > > [   15.224724] PGD b8d5067 P4D b8d5067 PUD c0a5067 PMD 0
> > > [   15.225237] Oops: 0000 [#1] SMP
> > > [   15.225556] CPU: 0 PID: 7747 Comm: syz-executor Not tainted 5.10.0=
-rc6+ #24
> > > [   15.226281] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.10.2-1ubuntu1 04/01/2014
> > > [   15.227292] RIP: 0010:skb_release_data+0x89/0x1e0
> > > [   15.227816] Code: 5b 5d 41 5c 41 5d 41 5e 41 5f e9 02 06 8a ff e8 =
fd 05 8a ff 45 31 ed 80 7d 02 00 4c 8d 65 30 74 55 e8 eb 05 8a ff 49 8b 1c =
24 <4c> 8b 7b 08 41 f6 c7 01 0f 85 18 01 00 00 e8 d4 05 8a ff 8b 43 34
> > > [   15.229669] RSP: 0018:ffffc900019c7c08 EFLAGS: 00010293
> > > [   15.230188] RAX: ffff88800daad900 RBX: 0000000000223b08 RCX: 00000=
00000000006
> > > [   15.230895] RDX: 0000000000000000 RSI: ffffffff818e06c5 RDI: ffff8=
8807f6dc700
> > > [   15.231593] RBP: ffff88807f71a4c0 R08: 0000000000000001 R09: 00000=
00000000001
> > > [   15.232299] R10: ffffc900019c7c18 R11: 0000000000000000 R12: ffff8=
8807f71a4f0
> > > [   15.233007] R13: 0000000000000000 R14: ffff88807f6dc700 R15: 00000=
00000000002
> > > [   15.233714] FS:  00007f65d9b5f700(0000) GS:ffff88807c400000(0000) =
knlGS:0000000000000000
> > > [   15.234509] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   15.235081] CR2: 0000000000223b10 CR3: 000000000b883000 CR4: 00000=
000000006f0
> > > [   15.235788] Call Trace:
> > > [   15.236042]  skb_release_all+0x28/0x30
> > > [   15.236419]  __kfree_skb+0x11/0x20
> > > [   15.236768]  tcp_data_queue+0x270/0x1240
> > > [   15.237161]  ? tcp_urg+0x50/0x2a0
> > > [   15.237496]  tcp_rcv_established+0x39a/0x890
> > > [   15.237997]  ? mark_held_locks+0x49/0x70
> > > [   15.238467]  tcp_v4_do_rcv+0xb9/0x270
> > > [   15.238915]  __release_sock+0x8a/0x160
> > > [   15.239365]  release_sock+0x32/0xd0
> > > [   15.239793]  __inet_stream_connect+0x1d2/0x400
> > > [   15.240313]  ? do_wait_intr_irq+0x80/0x80
> > > [   15.240791]  inet_stream_connect+0x36/0x50
> > > [   15.241275]  mptcp_stream_connect+0x69/0x1b0
> > > [   15.241787]  __sys_connect+0x122/0x140
> > > [   15.242236]  ? syscall_enter_from_user_mode+0x17/0x50
> > > [   15.242836]  ? lockdep_hardirqs_on_prepare+0xd4/0x170
> > > [   15.243436]  __x64_sys_connect+0x1a/0x20
> > > [   15.243924]  do_syscall_64+0x33/0x40
> > > [   15.244313]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [   15.244821] RIP: 0033:0x7f65d946e469
> > > [   15.245183] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 =
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
> > > [   15.247019] RSP: 002b:00007f65d9b5eda8 EFLAGS: 00000246 ORIG_RAX: =
000000000000002a
> > > [   15.247770] RAX: ffffffffffffffda RBX: 000000000049bf00 RCX: 00007=
f65d946e469
> > > [   15.248471] RDX: 0000000000000010 RSI: 00000000200000c0 RDI: 00000=
00000000005
> > > [   15.249205] RBP: 000000000049bf00 R08: 0000000000000000 R09: 00000=
00000000000
> > > [   15.249908] R10: 0000000000000000 R11: 0000000000000246 R12: 00000=
0000049bf0c
> > > [   15.250603] R13: 00007fffe8a25cef R14: 00007f65d9b3f000 R15: 00000=
00000000003
> > > [   15.251312] Modules linked in:
> > > [   15.251626] CR2: 0000000000223b10
> > > [   15.251965] BUG: kernel NULL pointer dereference, address: 0000000=
000000048
> > > [   15.252005] ---[ end trace f5c51fe19123c773 ]---
> > > [   15.252822] #PF: supervisor read access in kernel mode
> > > [   15.252823] #PF: error_code(0x0000) - not-present page
> > > [   15.252825] PGD c6c6067 P4D c6c6067 PUD c0d8067
> > > [   15.253294] RIP: 0010:skb_release_data+0x89/0x1e0
> > > [   15.253910] PMD 0
> > > [   15.253914] Oops: 0000 [#2] SMP
> > > [   15.253917] CPU: 1 PID: 7746 Comm: syz-executor Tainted: G      D =
          5.10.0-rc6+ #24
> > > [   15.253920] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.10.2-1ubuntu1 04/01/2014
> > > [   15.254435] Code: 5b 5d 41 5c 41 5d 41 5e 41 5f e9 02 06 8a ff e8 =
fd 05 8a ff 45 31 ed 80 7d 02 00 4c 8d 65 30 74 55 e8 eb 05 8a ff 49 8b 1c =
24 <4c> 8b 7b 08 41 f6 c7 01 0f 85 18 01 00 00 e8 d4 05 8a ff 8b 43 34
> > > [   15.254899] RIP: 0010:skb_release_data+0x89/0x1e0
> > > [   15.254902] Code: 5b 5d 41 5c 41 5d 41 5e 41 5f e9 02 06 8a ff e8 =
fd 05 8a ff 45 31 ed 80 7d 02 00 4c 8d 65 30 74 55 e8 eb 05 8a ff 49 8b 1c =
24 <4c> 8b 7b 08 41 f6 c7 01 0f 85 18 01 00 00 e8 d4 05 8a ff 8b 43 34
> > > [   15.254905] RSP: 0018:ffffc900019bfc08 EFLAGS: 00010293
> > > [   15.255376] RSP: 0018:ffffc900019c7c08 EFLAGS: 00010293
> > > [   15.255580]
> > > [   15.255583] RAX: ffff888004a7ac80 RBX: 0000000000000040 RCX: 00000=
00000000000
> > > [   15.255912]
> > > [   15.256724] RDX: 0000000000000000 RSI: ffffffff818e06c5 RDI: ffff8=
8807f6ddd00
> > > [   15.257620] RAX: ffff88800daad900 RBX: 0000000000223b08 RCX: 00000=
00000000006
> > > [   15.259817] RBP: ffff88800e9006c0 R08: 0000000000000000 R09: 00000=
00000000000
> > > [   15.259818] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8=
8800e9006f0
> > > [   15.259820] R13: 0000000000000000 R14: ffff88807f6ddd00 R15: 00000=
00000000002
> > > [   15.259822] FS:  00007fae4a60a700(0000) GS:ffff88807c500000(0000) =
knlGS:0000000000000000
> > > [   15.259826] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   15.260296] RDX: 0000000000000000 RSI: ffffffff818e06c5 RDI: ffff8=
8807f6dc700
> > > [   15.262514] CR2: 0000000000000048 CR3: 000000000b89c000 CR4: 00000=
000000006e0
> > > [   15.262515] Call Trace:
> > > [   15.262519]  skb_release_all+0x28/0x30
> > > [   15.262523]  __kfree_skb+0x11/0x20
> > > [   15.263054] RBP: ffff88807f71a4c0 R08: 0000000000000001 R09: 00000=
00000000001
> > > [   15.263680]  tcp_data_queue+0x270/0x1240
> > > [   15.263843] R10: ffffc900019c7c18 R11: 0000000000000000 R12: ffff8=
8807f71a4f0
> > > [   15.264693]  ? tcp_urg+0x50/0x2a0
> > > [   15.264856] R13: 0000000000000000 R14: ffff88807f6dc700 R15: 00000=
00000000002
> > > [   15.265720]  tcp_rcv_established+0x39a/0x890
> > > [   15.266438] FS:  00007f65d9b5f700(0000) GS:ffff88807c400000(0000) =
knlGS:0000000000000000
> > > [   15.267283]  ? __schedule+0x3fa/0x880
> > > [   15.267287]  tcp_v4_do_rcv+0xb9/0x270
> > > [   15.267290]  __release_sock+0x8a/0x160
> > > [   15.268049] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   15.268788]  release_sock+0x32/0xd0
> > > [   15.268791]  __inet_stream_connect+0x1d2/0x400
> > > [   15.268795]  ? do_wait_intr_irq+0x80/0x80
> > > [   15.269593] CR2: 0000000000223b10 CR3: 000000000b883000 CR4: 00000=
000000006f0
> > > [   15.270246]  inet_stream_connect+0x36/0x50
> > > [   15.270250]  mptcp_stream_connect+0x69/0x1b0
> > > [   15.270253]  __sys_connect+0x122/0x140
> > > [   15.271097] Kernel panic - not syncing: Fatal exception
> > > [   15.271820]  ? syscall_enter_from_user_mode+0x17/0x50
> > > [   15.283542]  ? lockdep_hardirqs_on_prepare+0xd4/0x170
> > > [   15.284275]  __x64_sys_connect+0x1a/0x20
> > > [   15.284853]  do_syscall_64+0x33/0x40
> > > [   15.285369]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [   15.286105] RIP: 0033:0x7fae49f19469
> > > [   15.286638] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 =
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
> > > [   15.289295] RSP: 002b:00007fae4a609da8 EFLAGS: 00000246 ORIG_RAX: =
000000000000002a
> > > [   15.290375] RAX: ffffffffffffffda RBX: 000000000049bf00 RCX: 00007=
fae49f19469
> > > [   15.291403] RDX: 0000000000000010 RSI: 00000000200000c0 RDI: 00000=
00000000005
> > > [   15.292437] RBP: 000000000049bf00 R08: 0000000000000000 R09: 00000=
00000000000
> > > [   15.293456] R10: 0000000000000000 R11: 0000000000000246 R12: 00000=
0000049bf0c
> > > [   15.294473] R13: 00007fff0004b6bf R14: 00007fae4a5ea000 R15: 00000=
00000000003
> > > [   15.295492] Modules linked in:
> > > [   15.295944] CR2: 0000000000000048
> > > [   15.296567] Kernel Offset: disabled
> > > [   15.296941] ---[ end Kernel panic - not syncing: Fatal exception ]=
---
> > > =

> > > In mptcp_pm_nl_add_addr_send_ack, we should avoid using the main sock=
et
> > =

> > main socket =3D=3D first subflow ?
> > =

> > Why we should avoid using it?
> > =

> > It's not clear to me why we get a corrupted skb in the other end.
> > =

> =

> I found that the number of shinfo->nr_frags is changed. On the send side,
> nr_frags is 0, but on the receive side, nr_frags became 32. Here is the l=
og:
> =

> [   17.119404] MPTCP: mptcp_pm_nl_add_addr_send_ack send ack for add_addr6
> [   17.119417] TCP: __tcp_send_ack skb=3D00000000c2cc7e53 shinfo->nr_frag=
s=3D0
> [   17.120133] MPTCP: mptcp_established_options_add_addr drop other
> suboptions sk=3D0000000024ceb3e0 skb=3D00000000c2cc7e53 shinfo->nr_frags=
=3D0
> [   17.120144] MPTCP: addr_id=3D1, ahmac=3D16458031074140092818, echo=3D0
> [   17.120160] MPTCP: msk=3D000000005f38d064 snd_data_fin_enable=3D0
> pending=3D0 snd_nxt=3D2475584656035918830 write_seq=3D2475584656035918830
> [   17.164666] TCP: tcp_rcv_established sk=3D000000008ceda60c
> skb=3D00000000c2cc7e53 shinfo->nr_frags=3D32
> [   17.165777] TCP: tcp_data_queue sk=3D000000008ceda60c
> skb=3D00000000c2cc7e53 shinfo->nr_frags=3D32
> [   17.166653] MPTCP: ADD_ADDR6: id=3D1, echo=3D0
> [   17.166661] MPTCP: msk=3D00000000489e84dc,
> ahmac=3D16458031074140092818, mp_opt->ahmac=3D16458031074140092818
> [   17.166665] MPTCP: msk=3D00000000489e84dc remote_id=3D1 accept=3D0
> [   17.166676] MPTCP: msk=3D00000000489e84dc, local_id=3D1
> [   17.166686] MPTCP: mptcp_pm_add_addr_send_ack call
> mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK)
> [   17.166690] skbuff: skb_release_data skb=3D00000000c2cc7e53 shinfo->nr=
_frags=3D32

Great work! What about skb->len? is that changed, too?

How many iteration do you need to see this corruption? if it pops-up
easily in your testbed, you could try to detect where/when exactly the
corruption happens with an appropriate high number of printk all over
the place ;)

Thanks!

Paolo

--===============2239061094382423873==--
