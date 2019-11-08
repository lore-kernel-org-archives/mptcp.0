Content-Type: multipart/mixed; boundary="===============8748626056992579918=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 0/4] four small cleanups and fixes
Date: Fri, 08 Nov 2019 16:17:31 +0100
Message-ID: <e03624a1-5f2d-d11d-5d1f-71146945f46c@tessares.net>
In-Reply-To: 20191105170531.30407-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2445

--===============8748626056992579918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 05/11/2019 18:05, Florian Westphal wrote:
> 1. cleanup: mptcp_subflow_get_map_offset arg can be const.
> 2. fix: don't advance snd_una past the write sequence.
> 3. cleanup: use existing helper rather than open-coding it
> 4. fix: avoid blocking kworker forever when polling mptcp socket.
> =

> All paches can be squashed, I've added squashto hints.
> =

> The following changes since commit 512f0321ae8a2679c15915b68f8a5cd98f1902=
88:
> =

>    subflow: wake parent mptcp socket on subflow state change (2019-11-05 =
02:27:34 +0000)
> =

> are available in the Git repository at:
> =

>    git://git.breakpoint.cc/fw/mptcp-next.git mptcp_fixes_04
> =

> for you to fetch changes up to 50a570bb03f61cb5e2344e1d3f8d959c40d7b520:
> =

>    poll: release lock before waiting (2019-11-05 17:58:28 +0100)
> =

> ----------------------------------------------------------------
> Florian Westphal (4):
>        protocol.h: mptcp_subflow_get_map_offset arg can be const
>        options: ignore mptcp-level ack that is ahead of write_seq
>        protocol: use sk_wait_event helper
>        poll: release lock before waiting
Thank you for the patches and the reviews!
And sorry for the delay!

- 1bf1608f7df8: "squashed" patch 1/4 in "mptcp: Implement MPTCP receive =

path"
- signed-off already there
- 127eee209f8e: "squashed" patch 2/4 in "mptcp: update per unacked =

sequence on pkt reception"
- ede08521c3e3: "Signed-off-by" + "Co-developed-by"
- a6260f7b8cab..ece8d606ffaf: result
- 8f7fc74888c8: "squashed" patch 3/4 in "mptcp: recvmsg() can drain data =

from multiple subflows"
- d8bfdd33c229: "Signed-off-by" + "Co-developed-by"
- ece8d606ffaf..4c99cd06d954: result
- 230846c72398: "squashed" patch 4/4 in "mptcp: add mptcp_poll"
- signed-off already there
- 4c99cd06d954..6b3052b58e78: result

Tests are in progress. The export of the branch will be done in max ~10 =

minutes.
(Note that some intermediate commits don't compile but I will check that!)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8748626056992579918==--
