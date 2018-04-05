Content-Type: multipart/mixed; boundary="===============7699384711564253752=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 5th of April 2018
Date: Thu, 05 Apr 2018 16:03:22 -0700
Message-ID: <20180405230322.GO1847@MacBook-Pro-6.local>
In-Reply-To: alpine.OSX.2.21.1804051533490.56457@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 515

--===============7699384711564253752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/04/18 - 15:39:24, Mat Martineau wrote:
> =

> On Thu, 5 Apr 2018, Christoph Paasch wrote:
> =

> > Hello,
> > =

> > On 05/04/18 - 15:17:59, Mat Martineau wrote:
> > > =

> > > On Thu, 5 Apr 2018, Matthieu Baerts wrote:
> > > =

> > > > Branches on Github (multipath-tcp/mptcp):
> > > >     - keep mptcp_trunk "clean", following official Linux versions =
=E2=86=92 goal
> > > > is at least to reach the next LTS (4.18?). We will see what to do a=
fter.
> > > >     - we still need a "usable" version, fully functional for both t=
he
> > > > client and server with almost the same performances while the "vers=
ion
> > > > for upstream" is still in progress in parallel
> > > >     - next stable version should then contain Netlink PM, lockless
> > > > subflows, etc..
> > > >     - a new branch will be created (mptcp-net-next) following net-n=
ext.
> > > >     - all final patches shared, reviewed and accepted in MPTCP upst=
ream
> > > > ML would be integrated in this branch if they cannot be directly
> > > > integrated upstream in net-next
> > > =

> > > To spread the workload around, I can help by keeping the new mptcp-ne=
t-next
> > > branch merged with net-next. Christoph has a lot of experience doing =
this
> > > type of merge for MPTCP but the addition of this branch shouldn't cre=
ate
> > > more work for him by default.
> > =

> > Thanks, that would be great!
> > =

> > > (Note that I'm not requesting push access to the github repo, I can p=
ush to
> > > git.kernel.org and someone with permissions can transfer the commits =
from
> > > there)
> > =

> > Actually, back in the days, we already had an mptcp_net-next repo on the
> > github at https://github.com/multipath-tcp/mptcp_net-next.
> > =

> > I will simply give you write-access to this one. Then you can remove th=
e old
> > branches there and put there the merge with net-next.
> =

> Ok, thanks. Seems like that's a good place for the upstreaming wiki too.

Yes, it definitely is the best place for the wiki.

I completely forgot about that repo.


Christoph

> =

> =

> Mat
> =

> > =

> > > =

> > > > netdevconf:
> > > >     - new ideas? =E2=86=92 not really
> > > >     - seems the tutorial is what is the best for us for now (becaus=
e the
> > > > maintainer will not be there)
> > > >     - Matthieu: will ask colleagues for ideas
> > > >     - for the tutorial, we mostly need a description of max 350 wor=
ds:
> > > > not too much to prepare before the 1st of May
> > > >     - we need to check Linux Plumbers participation guidelines (Mat=
 will
> > > > try to have a look):
> > > > https://www.linuxplumbersconf.org/2017/participate.1.html#cfp &
> > > > https://www.linuxplumbersconf.org/2018/participate/ (not ready)
> > > =

> > > One promising option is a microconference discussion topic, which wou=
ld be a
> > > more interactive session than a traditional presentation. There would=
 likely
> > > be a good cross-section of networking contributors and maintainers in=
 the
> > > room. I haven't been to LPC before, so I'll chat with some coworkers =
who
> > > have attended.
> > > =

> > > Given the lead times last year, I'm guessing the LPC proposal deadlin=
es will
> > > be around July.
> > > =

> > > =

> > > --
> > > Mat Martineau
> > > Intel OTC
> > =

> > =

> =

> --
> Mat Martineau
> Intel OTC


--===============7699384711564253752==--
