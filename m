Content-Type: multipart/mixed; boundary="===============5415312756012900513=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [mptcp-dev] [PATCH 0/6] Batch of fixes
Date: Fri, 14 Sep 2018 10:04:08 -0700
Message-ID: <20180914170408.GJ3125@MacBook-Pro-19.local>
In-Reply-To: 391c5364-038b-ef4e-8d87-b556d703bf09@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 723

--===============5415312756012900513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 14/09/18 - 18:19:39, Matthieu Baerts wrote:
> Hi Christoph,
> =

> On 14/09/2018 02:25, Christoph Paasch wrote:
> > All should go into mptcp_trunk, besides "mptcp: Restart
> > subflow-selection when we force a re-evaluation" which is a candidate
> > for being back-ported.
> =

> Thank you for all these patches and your reply!
> =

> I just applied all of them in mptcp_trunk. I am going to check next week
> to backport the 4th patch!
> =

> Note for mptcp_net-next: I can also check to cherry-pick this patch and
> the 5th one in mptcp_net-next but not the others as they all depend on
> the lockless sf patch-set :)

I will take care of the forward-ports for this set because of the
dependency.


Thanks,
Christoph

> =

> Have a good day,
> Matt
> =

> > Christoph Paasch (6):
> >   mptcp: Build-Fix
> >   mptcp: Reset sk_it to NULL as we keep on iterating
> >   mptcp: Close remaining subflows when falling back in
> >     mptcp_verif_dss_csum
> >   mptcp: Restart subflow-selection when we force a re-evaluation
> >   mptcp: Don't free skb when tcp_transmit_skb without cloning
> >   mptcp: Use spin_lock_bh where appropriate for mpcb_list_lock
> > =

> >  include/net/mptcp.h      |  5 +++++
> >  net/mptcp/mptcp_ctrl.c   | 10 ++++------
> >  net/mptcp/mptcp_input.c  |  4 ++++
> >  net/mptcp/mptcp_output.c |  4 +---
> >  net/mptcp/mptcp_sched.c  | 11 +++++++++--
> >  5 files changed, 23 insertions(+), 11 deletions(-)
> > =

> =

> -- =

> Matthieu Baerts | R&D Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

> MPTCP-developpers Mailing-List
> Visit http://multipath-tcp.org to access the source-code of MPTCP in the =
Linux Kernel
> =

> To Unsubscribe, visit https://listes-2.sipr.ucl.ac.be/sympa/info/mptcp-dev
> =



--===============5415312756012900513==--
