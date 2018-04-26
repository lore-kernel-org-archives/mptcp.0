Content-Type: multipart/mixed; boundary="===============0881777950295557044=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 16th of April 2018
Date: Thu, 26 Apr 2018 15:20:54 -0700
Message-ID: <20180426222054.GC19260@MacBook-Pro-6.local>
In-Reply-To: ab963222-29d5-d93d-ae42-f3fd6e3be948@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 559

--===============0881777950295557044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 26/04/18 - 14:25:24, Rao Shoaib wrote:
> =

> =

> On 04/26/2018 01:52 PM, Christoph Paasch wrote:
> > =

> > This kind of lock-taking also causes trouble with RCU LOCKDEP debugging=
 - as
> > I mentioned in a previous e-mail.
> I have not looked into it so I can not comment. I am sure we will find a =
way
> to address it.
> > =

> > And beyond that, it requires that everytime a TCP-change is being done,=
 one
> > needs to take MPTCP into account. E.g., when upstream added the SOCK_DE=
STROY
> > interface (and Samsung backported it to v4.4), there were panics on And=
roid
> > devices (https://github.com/multipath-tcp/mptcp/issues/170).
> > =

> > Avoid taking the meta-socket lock on subflow-work allows for much easier
> > maintenance in the long-term.
> The bug that you have pointed out is a run of the mill bug that we see
> everyday, there is nothing special about it.

Euh, you mean the issue #170 is happening frequently?

It shouldn't! If it does, that's a big concern.

> Taking meta lock actually simplifies things a lot and has reduced
> maintainable cost, not taking the meta lock will create timing issues left
> and right. So we are just trading one headache with another.
> =

> Holding meta lock should not be piped up unnecessarily. Yes, if possible =
if
> should be changed, plus our patch has only 6 cases in TCP.

I think, you are taking the MPTCP point-of-view here. Yes, taking the
meta-level lock does reduce maintainability of MPTCP (which is why we did it
that way in the first place ;-))

However, for upstreaming we have to think the other way around. TCP is the
common-case, and MPTCP is the exotic corner-case only few care about.

So, TCP-maintainability is of outmost importance. Way more important than
MPTCP's.


Christoph

> =

> Shoaib.
> =

> [1] If MPTCP is built on top of TCP, any change in TCP will always have to
> worry about MPTCP particularly in the control path. There is a overhead of
> adding MPTCP on TCP and no one can argue against it.
> =

> > =

> > =

> > Christoph
> > =

>=20

--===============0881777950295557044==--
