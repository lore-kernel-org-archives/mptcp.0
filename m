Content-Type: multipart/mixed; boundary="===============1102215795463209445=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] Interim Path Manager
Date: Mon, 14 Oct 2019 21:40:26 -0700
Message-ID: <bedc79ee21616f46822aa74d9076014ab00afe24.camel@linux.intel.com>
In-Reply-To: 7d7d6eae-f038-27d0-427e-571b0811e5f2@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2132

--===============1102215795463209445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-14 at 18:36 +0200, Matthieu Baerts wrote:
> Hi Peter, Paolo,
> =

> On 14/10/2019 13:29, Paolo Abeni wrote:
> > Hi,
> > =

> > On Tue, 2019-09-17 at 11:37 -0700, Peter Krystad wrote:
> > > Patchset includes the interim path manager plus sysctl setting of
> > > the announce address and binding local address when creating subflows.
> > > I also split the path manager into a seperate file.
> > > =

> > > v2:
> > >    rename to 'basic' path manager
> > >    remove pm_init definition
> > >      =

> > > Peter Krystad (2):
> > >    mptcp: Minor changes to path manager interface
> > >    mptcp: Implement basic path manager
> > > =

> > >   net/mptcp/Makefile   |   2 +-
> > >   net/mptcp/basic.c    | 247 ++++++++++++++++++++++++++++++++++++++++=
+++
> > >   net/mptcp/pm.c       |  38 +++++--
> > >   net/mptcp/protocol.c |   2 +-
> > >   net/mptcp/protocol.h |  14 ++-
> > >   5 files changed, 290 insertions(+), 13 deletions(-)
> > >   create mode 100644 net/mptcp/basic.c
> > =

> > I'm sorry for lagging behind so much.
> > =

> > I'm ok with the patches in the current status - even if I fear some
> > rebasing will be now need, perhaps good Matt can take that bourden, too
> >   - since he called me 'lawyer' I feel less guilty asking that ;)
> =

> Yes my Lord!
> =

> Thank you for the patch and the plea (review?)!
> =

> - e3c637f02e45: "squashed" (including a rebase) the first part of the =

> first patch in "mptcp: Add path manager interface"
> - 232953cffb3b: "squashed" (including a rebase) the second part of the =

> first patch in "mptcp: Implement path manager interface commands". Note =

> I had a conflict: addr->s_addr is stored in network bytes order.
> - 250376a152f7: added (including a rebase) the second patch at the end =

> (should I move it somewhere else?)
> - 5cfa9c11a52f: fix compilation errors (due to changes made since the =

> patch has been sent here)
> =

> Tests are still OK!

Thanks Matthieu for this rebase and merge. I had some changes locally to ad=
apt
these patches for IPv6, I will rebase and post them tomorrow to prepare for
sharing IPv6 RFC this week.

Peter.



> Cheers,
> Matt

--===============1102215795463209445==--
