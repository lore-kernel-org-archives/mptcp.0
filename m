Content-Type: multipart/mixed; boundary="===============1381714804369598218=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP upstreaming introduction
Date: Mon, 17 Apr 2017 07:29:45 -0700
Message-ID: <20170417142945.GH11821@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1704111002110.40519@mlee4-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3

--===============1381714804369598218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat,

On 11/04/17 - 15:52:06, Mat Martineau wrote:
> =

> Hi Christoph,
> =

> Rao and I talked with David Miller and Eric Dumazet. They aren't
> enthusiastic about MPTCP from a protocol perpective, and pointed to the
> example of kcm as something that builds on top of multiple TCP connections
> rather than modifying TCP itself. I think they're a little skeptical that
> there's a committment to put in the necessary effort to upstream.
> =

> A few specific points of our discussions:
> =

> * Intrusive changes to TCP are not acceptable, the code is already complex
> and they don't want to introduce bugs or create additional maintenance
> burden. Given the need to tie in to TCP for option parsing (and other
> changed behaviors), they're willing to look at adding hooks - but of cour=
se
> reserved judgment until there are actual patches to look at.
> =

> * Related to that, skb size cannot increase.
> =

> * Regular TCP connections should remain the default and should work like
> they do now.

That's good info. So we will have to make it opt-in through a socket-option
or even create a new socket-type.

> =

> * Expect the review process to take a while.
> =

> These points are what drives the goals I listed below. Identifying the ri=
ght
> (limited) set of hooks in to the TCP code is going to be an important ear=
ly
> step.

sounds great! Do you have a public git repo where the development happens?
Might be good to set this up.


Cheers,
Christoph

> =

> Best regards,
> Mat
> =

> =

> On Mon, 10 Apr 2017, Christoph Paasch wrote:
> =

> > Hi Mat,
> > =

> > what was the feedback/info you got from netdev 2.1 ?
> > =

> > =

> > Christoph
> > =

> > On 09/04/17 - 13:12:26, Mat Martineau wrote:
> > > Welcome to the MPTCP upstreaming mailing list!
> > > =

> > > This list (mptcp(a)lists.01.org) is focused on integrating MPTCP (RFC=
 6824 /
> > > RFC 6824bis) as part of the standard Linux kernel. In speaking with t=
he
> > > Linux networking / TCP maintainers, it is important that MPTCP does n=
ot
> > > interfere with the performance or reliability of the TCP stack, or
> > > complicate the existing TCP code.
> > > =

> > > Given the Linux netdev maintainer's needs, we have the following high=
-level
> > > design goals in mind:
> > > =

> > > * Minimize changes to core TCP.
> > > =

> > > * Favor atomic operations and RCU synchronization over more expensive
> > > options like mutexes or spinlocks.
> > > =

> > > * Implement features in userspace where latency isn't important and d=
ata
> > > flow is not affected
> > > =

> > > * TCP operates as "normal TCP" by default. Individual sockets may opt=
-in, or
> > > systemwide configuration can be used to broadly enable MPTCP.
> > > =

> > > The role of this list is to coordinate upstreaming efforts and share =
code
> > > prior to upstream submission on netdev(a)lists.01.org . This list is =
separate
> > > from the mptcp-dev list associated with the multipath-tcp.org kernel =
in
> > > order to avoid confusion between netdev-focused efforts and work rela=
ted to
> > > multipath-tcp.org . Anyone interested in MPTCP for the upstream kerne=
l is
> > > welcome on mptcp(a)lists.01.org, we appreciate your expertise and
> > > contributions!
> > > =

> > > You can manage your subscription or view list archives at
> > > https://lists.01.org/mailman/listinfo/mptcp
> > > =

> > > Best regards,
> > > =

> > > --
> > > Mat Martineau
> > > Intel OTC
> > =

> =

> --
> Mat Martineau
> Intel OTC

--===============1381714804369598218==--
