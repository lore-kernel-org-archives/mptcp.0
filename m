Content-Type: multipart/mixed; boundary="===============4652447671096358819=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next] mptcp: add receive buffer
 auto-tuning
Date: Fri, 29 May 2020 22:10:05 +0200
Message-ID: <20200529201005.GA12873@breakpoint.cc>
In-Reply-To: 20200529165603.GN64606@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4561

--===============4652447671096358819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph Paasch <cpaasch(a)apple.com> wrote:
> > After:
> > ns4 MPTCP -> ns3 (10.0.3.2:10108      ) MPTCP   (duration  5417ms) [ OK=
 ]
> > ns4 MPTCP -> ns3 (10.0.3.2:10109      ) TCP     (duration  5429ms) [ OK=
 ]
> > ns4 TCP   -> ns3 (10.0.3.2:10110      ) MPTCP   (duration  5418ms) [ OK=
 ]
> > ns4 MPTCP -> ns3 (dead:beef:3::2:10111) MPTCP   (duration  5423ms) [ OK=
 ]
> > ns4 MPTCP -> ns3 (dead:beef:3::2:10112) TCP     (duration  5715ms) [ OK=
 ]
> > ns4 TCP   -> ns3 (dead:beef:3::2:10113) MPTCP   (duration  5415ms) [ OK=
 ]
> > Time: 275 seconds
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> Need to also handle the fallback to TCP-case. Otherwise there is a
> divide-by-0:
> =

> server login: [ 1998.037445] divide error: 0000 [#1] SMP KASAN PTI
> [ 1998.038321] CPU: 3 PID: 1671 Comm: http Kdump: loaded Not tainted 5.7.=
0-rc6.mptcp #43
> [ 1998.039599] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [ 1998.041526] RIP: 0010:mptcp_recvmsg+0x6ae/0xa40
> [ 1998.042370] Code: 44 89 e0 89 da 4c 8b 44 24 08 45 8d b4 24 40 03 00 0=
0 c1 e0 04 48 8d 0c 50 89 d8 49 8d b8 60 04 00 00 31 d2 29 e8 48 0f af c1 <=
48> f7 f5 4c 8d 2c 41 e8 66 6b 6a ff 4c 8b 44 24 08 41 8b a8 64
> [ 1998.045394] RSP: 0018:ffff8881174bf968 EFLAGS: 00010206
> [ 1998.046237] RAX: 0000000140764000 RBX: 000000000000b500 RCX: 000000000=
001c540
> [ 1998.047397] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff8=
291b460
> [ 1998.048564] RBP: 0000000000000000 R08: ffffffff8291b000 R09: ffffffff8=
2f1d0c8
> [ 1998.049724] R10: ffffffff82f1d0c3 R11: fffffbfff05e3a18 R12: 000000000=
00005b4
> [ 1998.050872] R13: 000000000022b368 R14: 00000000000008f4 R15: ffff88811=
8740000
> [ 1998.052059] FS:  00007f081dd1ea40(0000) GS:ffff88811b980000(0000) knlG=
S:0000000000000000
> [ 1998.053357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1998.054189] CR2: 000055b5364a7000 CR3: 0000000115d5e000 CR4: 000000000=
00006e0
> [ 1998.055231] Call Trace:
> [ 1998.057574]  inet_recvmsg+0x207/0x220
> [ 1998.058832]  sock_read_iter+0x1fe/0x230
> [ 1998.060656]  new_sync_read+0x33a/0x350
> [ 1998.063934]  vfs_read+0xbc/0x1b0
> [ 1998.064466]  ksys_read+0x11b/0x150
> [ 1998.066975]  do_syscall_64+0xbc/0x790
> [ 1998.070940]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

WTF?  How can this happen? All TCP -> MPTCP tests passed for me.
This would mean we call mptcp_recvmsg *without* gping through
either mptcp_finish_connect or mptcp_accept?

> @@ -259,8 +259,10 @@ static void subflow_finish_connect(struct sock *sk, =
const struct sk_buff *skb)
>  				MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
>  	}
> =

> -	if (mptcp_check_fallback(sk))
> +	if (mptcp_check_fallback(sk)) {
> +		mptcp_rcv_space_init(mptcp_sk(parent), sk);
>  		return;
> +	}

Oh, wait.  That code is not present in net-next.

In that case I will wait until this has propagated to net-next; i assume
I would see the crash with the self test too.
--===============4652447671096358819==--
