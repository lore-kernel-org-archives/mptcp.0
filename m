Content-Type: multipart/mixed; boundary="===============0546640911162123018=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/6] Batch of fixes
Date: Fri, 14 Sep 2018 18:19:39 +0200
Message-ID: <391c5364-038b-ef4e-8d87-b556d703bf09@tessares.net>
In-Reply-To: 20180914002527.29479-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 722

--===============0546640911162123018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 14/09/2018 02:25, Christoph Paasch wrote:
> All should go into mptcp_trunk, besides "mptcp: Restart
> subflow-selection when we force a re-evaluation" which is a candidate
> for being back-ported.

Thank you for all these patches and your reply!

I just applied all of them in mptcp_trunk. I am going to check next week
to backport the 4th patch!

Note for mptcp_net-next: I can also check to cherry-pick this patch and
the 5th one in mptcp_net-next but not the others as they all depend on
the lockless sf patch-set :)

Have a good day,
Matt

> Christoph Paasch (6):
>   mptcp: Build-Fix
>   mptcp: Reset sk_it to NULL as we keep on iterating
>   mptcp: Close remaining subflows when falling back in
>     mptcp_verif_dss_csum
>   mptcp: Restart subflow-selection when we force a re-evaluation
>   mptcp: Don't free skb when tcp_transmit_skb without cloning
>   mptcp: Use spin_lock_bh where appropriate for mpcb_list_lock
> =

>  include/net/mptcp.h      |  5 +++++
>  net/mptcp/mptcp_ctrl.c   | 10 ++++------
>  net/mptcp/mptcp_input.c  |  4 ++++
>  net/mptcp/mptcp_output.c |  4 +---
>  net/mptcp/mptcp_sched.c  | 11 +++++++++--
>  5 files changed, 23 insertions(+), 11 deletions(-)
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0546640911162123018==--
