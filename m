Content-Type: multipart/mixed; boundary="===============4974403626693871574=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/9] mptcp: cope better with mp_join storm
Date: Fri, 10 Jul 2020 14:35:12 -0700
Message-ID: <20200710213512.GD60489@MacBook-Pro-64.local>
In-Reply-To: alpine.OSX.2.23.453.2007101125230.34362@apander1-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4988

--===============4974403626693871574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/10/20 - 11:31, Mat Martineau wrote:
> =

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
r a
> testing pass before upstreaming?

I picked these patches on top of export and am running syzkaller on top of
it. I will try to do an mptcp.org-interop run later or Monday.


Christoph

--===============4974403626693871574==--
