Content-Type: multipart/mixed; boundary="===============4508925710697028708=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/9] mptcp: cope better with mp_join storm
Date: Mon, 13 Jul 2020 15:18:20 +0200
Message-ID: <16245d3ac0f492b31a4b654c61530b9a7dda597e.camel@redhat.com>
In-Reply-To: alpine.OSX.2.23.453.2007101125230.34362@apander1-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4994

--===============4508925710697028708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2020-07-10 at 11:31 -0700, Mat Martineau wrote:
> On Fri, 10 Jul 2020, Paolo Abeni wrote:
> =

> > This is a rebase of the RFC, dropping old 5/5 and including a few somew=
hat
> > related bugfixes - all targeting net-next because the fixed commit is o=
nly
> > there or the buggy behavior can be triggered only enabling non backup s=
ubflows
> > =

> > Paolo Abeni (9):
> >  subflow: always init 'rel_write_seq'
> >  mptcp: avoid data corruption on reinsert
> >  mptcp: mark as fallback even early ones
> >  mptcp: zero token hash at creation time.
> >  mptcp: make msk established at remote key reception time
> >  mptcp: cleanup subflow_finish_connect()
> >  subflow: explicitly check for plain tcp rsk
> >  subflow: use rsk_ops->send_reset()
> >  subflow: introduce and use mptcp_can_accept_new_subflow()
> > =

> > net/mptcp/options.c  |  4 +-
> > net/mptcp/protocol.c | 20 +++++++---
> > net/mptcp/protocol.h |  2 +
> > net/mptcp/subflow.c  | 87 +++++++++++++++++++++++++-------------------
> > net/mptcp/token.c    |  2 +-
> > 5 files changed, 69 insertions(+), 46 deletions(-)
> > =

> > -- =

> > 2.26.2
> =

> Thanks Paolo, the changes look good. Should these go in mptcp_net-next fo=
r =

> a testing pass before upstreaming?

Sorry for lagging behind. This whole week I'll be half off, so expect
added latency.

Yes, the idea is staging this changes a bit in the export branch before
pushing them upstream.

Additional note: the fixes commits included here have been found using
a staging local self-test using multiple concurrent xmit subflows. I
tried to spool them as I expect/fear to found some/many more before
obtaining somewhat stable results in the mentioned scenario.

Cheers,

Paolo

--===============4508925710697028708==--
