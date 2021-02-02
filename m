Content-Type: multipart/mixed; boundary="===============3025623353764772461=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: fix spurious retransmissions
Date: Tue, 02 Feb 2021 16:12:21 +0100
Message-ID: <e87be00f-886c-13ee-c6c9-536a43086339@tessares.net>
In-Reply-To: e9bf65f5e84ca731dd600ef97ca94d610a065410.1612265962.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7591

--===============3025623353764772461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 02/02/2021 12:55, Paolo Abeni wrote:
> Syzkaller was able to trigger again the following splat:
> =

> WARNING: CPU: 1 PID: 12512 at net/mptcp/protocol.c:761 mptcp_reset_timer+=
0x12a/0x160 net/mptcp/protocol.c:761
> Modules linked in:
> CPU: 1 PID: 12512 Comm: kworker/1:6 Not tainted 5.10.0-rc6 #52
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-=
gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> Workqueue: events mptcp_worker
> RIP: 0010:mptcp_reset_timer+0x12a/0x160 net/mptcp/protocol.c:761
> Code: e8 4b 0c ad ff e8 56 21 88 fe 48 b8 00 00 00 00 00 fc ff df 48 c7 0=
4 03 00 00 00 00 48 83 c4 40 5b 5d 41 5c c3 e8 36 21 88 fe <0f> 0b 41 bc c8=
 00 00 00 eb 98 e8 e7 b1 af fe e9 30 ff ff ff 48 c7
> RSP: 0018:ffffc900018c7c68 EFLAGS: 00010293
> RAX: ffff888108cb1c80 RBX: 1ffff92000318f8d RCX: ffffffff82ad0307
> RDX: 0000000000000000 RSI: ffffffff82ad036a RDI: 0000000000000007
> RBP: ffff888113e2d000 R08: ffff888108cb1c80 R09: ffffed10227c5ab7
> R10: ffff888113e2d5b7 R11: ffffed10227c5ab6 R12: 0000000000000000
> R13: ffff88801f100000 R14: ffff888113e2d5b0 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff88811b500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd76a874ef8 CR3: 000000001689c005 CR4: 0000000000170ee0
> Call Trace:
>   mptcp_worker+0xaa4/0x1560 net/mptcp/protocol.c:2334
>   process_one_work+0x8d3/0x1200 kernel/workqueue.c:2272
>   worker_thread+0x9c/0x1090 kernel/workqueue.c:2418
>   kthread+0x303/0x410 kernel/kthread.c:292
>   ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:296
> =

> The mptcp_worker tries to update the MPTCP retransmission timer
> even if such timer is not currently scheduled.
> =

> mptcp_check_data_fin_ack() can clear the rtx timer just before
> mptcp_rtx_head(), but leaving data in the rtx queue - that will
> be cleared at msk sock release_cb time.
> =

> The above may additionally cause spurious, unneeded MPTCP-level
> retransissions.
> =

> Fix the issue adding explicit clearing the rtx queue before
> trying to retransmit and dropping the unneeded timer stop.
> Additionally drop the unused mptcp_rtx_head() helper.

Small detail, it should be mptcp_rtx_tail(), not "head()".
I can fix it (with the "retrans(m)issions" typo above) when applying =

this patch if everything else is OK ;-)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3025623353764772461==--
