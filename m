Content-Type: multipart/mixed; boundary="===============6919477519770428458=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP upstreaming introduction
Date: Tue, 18 Apr 2017 18:13:03 -0700
Message-ID: <20170419011303.GE37219@da0602a-dhcp151.apple.com>
In-Reply-To: alpine.OSX.2.21.1704181045580.3492@sehampsh-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5

--===============6919477519770428458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 18/04/17 - 10:59:28, Mat Martineau wrote:
> =

> Hi Christoph,
> =

> On Mon, 17 Apr 2017, Christoph Paasch wrote:
> =

> > Hello Mat,
> > =

> > On 11/04/17 - 15:52:06, Mat Martineau wrote:
> > > =

> > > Hi Christoph,
> > > =

> > > Rao and I talked with David Miller and Eric Dumazet. They aren't
> > > enthusiastic about MPTCP from a protocol perpective, and pointed to t=
he
> > > example of kcm as something that builds on top of multiple TCP connec=
tions
> > > rather than modifying TCP itself. I think they're a little skeptical =
that
> > > there's a committment to put in the necessary effort to upstream.
> > > =

> > > A few specific points of our discussions:
> > > =

> > > * Intrusive changes to TCP are not acceptable, the code is already co=
mplex
> > > and they don't want to introduce bugs or create additional maintenance
> > > burden. Given the need to tie in to TCP for option parsing (and other
> > > changed behaviors), they're willing to look at adding hooks - but of =
course
> > > reserved judgment until there are actual patches to look at.
> > > =

> > > * Related to that, skb size cannot increase.
> > > =

> > > * Regular TCP connections should remain the default and should work l=
ike
> > > they do now.
> > =

> > That's good info. So we will have to make it opt-in through a socket-op=
tion
> > or even create a new socket-type.
> =

> I experimented with two approaches: AF_MPTCP and IPPROTO_MPTCP (the latter
> using either AF_INET or AF_INET6). IPPROTO_MPTCP worked a lot better with
> existing code (especially Python's socket module!). I'll tidy up the patch
> set and post it.

great! Looking forward to it.

> =

> > > =

> > > * Expect the review process to take a while.
> > > =

> > > These points are what drives the goals I listed below. Identifying th=
e right
> > > (limited) set of hooks in to the TCP code is going to be an important=
 early
> > > step.
> > =

> > sounds great! Do you have a public git repo where the development happe=
ns?
> > Might be good to set this up.
> =

> My plan is to share patches on this list, and I will publish a mptcp bran=
ch
> on my git.kernel.org repo:
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/
> =

> Since we'll be posting patches to netdev, I think it will work well to use
> the typical kernel mailing list 'git send-email' workflow.

Sounds good!


Christoph


--===============6919477519770428458==--
