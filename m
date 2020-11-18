Content-Type: multipart/mixed; boundary="===============0524322715032038960=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING in mptcp_reset_timer
Date: Wed, 18 Nov 2020 12:16:29 +0100
Message-ID: <ee5b7228-3387-b49a-6499-fd736d38dca7@tessares.net>
In-Reply-To: 000000000000b7f48605b45f80c5@google.com
X-Status: 
X-Keywords:                  
X-UID: 6772

--===============0524322715032038960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

(mptcp list only)

Hello,

On 18/11/2020 11:59, syzbot wrote:
> syzbot found the following issue on:

(...)

> Call Trace:
>   mptcp_push_pending+0x1351/0x17c0 net/mptcp/protocol.c:1266
>   mptcp_worker+0x385/0x1a10 net/mptcp/protocol.c:1877
>   process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
>   worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
>   kthread+0x3af/0x4a0 kernel/kthread.c:292
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


It looks like it is similar to issue #105:

   https://github.com/multipath-tcp/mptcp_net-next/issues/105

Here we have repos :)

WDYT?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0524322715032038960==--
