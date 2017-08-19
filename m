Content-Type: multipart/mixed; boundary="===============4128227713123240386=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP upstreaming strategy and design
Date: Sat, 19 Aug 2017 16:55:30 -0700
Message-ID: <20170819235530.GB81310@Chimay.local>
In-Reply-To: CAKD1Yr1RpFoy-OjniVhn5=2cCc=p_xHByE8Ae1x8cqRAetCL6g@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 79

--===============4128227713123240386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Lorenzo,


thanks for chiming in. Please see inline:

On 19/08/17 - 13:43:38, Lorenzo Colitti wrote:
> Sorry I'm late to this thread. I've been thinking about this for a while,
> and wanted to share some of those thoughts in the hope that they are usef=
ul.
> =

> Reading through the 4.4 patch, many of the points made by Mat make sense =
to
> me. Especially, off-by-default is important (upstream cares deeply about
> backwards compatibility). In fact, personally I don't see a lot of
> advantage to enabling MPTCP on unmodified applications that directly call
> the socket API. But perhaps there are use cases there that I don't see.

I agree that we should have off-by-default and opt-in through a
socket-option (or similar mechanism).


Wrt., to using MPTCP on unmodified applications, Daniel Borkmann told me
once that a big use-case for MPTCP would be data-center applications where
one cannot change the application (e.g., because it's closed-source).
If I am not mistaken, at the time he was working on SCTP and they were
trying to do some magic with LD_PRELOAD to make these apps seamlessly use
SCTP.

But I would say bad luck for these apps then ;-)

> Having as much code in userspace as possible will help.  Moving path
> management to userspace seems like it could be an easy way to do that (and
> thinking specifically about how Android does networking, the kernel doesn=
't
> really have enough information to decide which subflows should go where,
> anyway). For a mobile device, the simplest approach seems to be to just to
> have zero or one subflows per interface, with explicit addition and remov=
al
> of subflows from userspace, and possibly a setsockopt to add and disable
> MP_PRIO.

+1

> =

> What I think that means is that there needs to be a subflow abstraction
> that userspace can see. One way to do this might be to expose the subflows
> as individual sockets on which read() and write() return EINVAL, but on
> which connect() and setsockopt() can operate as normal - connect() to
> establish a subflow, setsockopt() to do things like set subflows to backu=
p,
> ask the kernel to send the MP_PRIO option, and so on. Not sure what you'd
> do on a server to get the subflows for accepted connections, though. For
> blocking calls you could use accept() on the master socket, but really you
> want an asynchronous notification when a connection comes in. Perhaps give
> up support for urgent data and re-use POLLPRI? There is precedent for
> reusing POLLPRI for things that aren't urgent data, but such as solution
> might be seen as too hacky by upstream.
> =

> The alternative would be to expose only one filedescriptor and use
> subsetsockopts to affect the individual flows, like
> draft-hesmans-mptcp-socket-02
> does. On Android specifically, routing traffic on a particular network
> (e.g., wifi vs. cellular) requires that sk->sk_mark be set to an
> appropriate value, so there must be a way to do that for each subflow.

Yes, I think both approaches would be fine. Although, I'm not sure what
upstream's opinion is on adding more socket-options. Which is why the first
option might probably be better.

Wrt. to the asynchronous mechanism for accepting new subflows. What about
using the error-queue that is used today for SO_TIMESTAMP? This could wake
up the socket and signal that there is a new subflow. Then the app can do an
accept() to get the fd.


I have another question: How do you see the risk of "malicious" apps that
then create subflows on cell and just send plenty of data over the cellular
interface? Because, if we expose path-management at the user-space level an
app can take full control over the behavior of MPTCP.


> One general thing I've heard is that having the API flow be similar to the
> single-TCP-socket model is an advantage - for example, I hear that one of
> the reasons for the low adoption of TFO on Linux is that the API is
> different to standard TCP because it uses sendto() instead of connect, and
> that makes it hard to use lots of libraries such as openssl that want "a
> filedescriptor of a connected socket".
> =

> The scheduler seems like it could belong in the kernel, because it has to
> react quickly to events such as receiving packets. Perhaps this could use
> similar mechanisms to the existing pluggable congestion control algorithm=
s?

Yes, we already have this today where schedulers are implemented as
pluggable modules that can be selected either through sysctl or a
socket-option (exactly the same as congestion control).

These schedulers however currently don't have many configuration knobs to
tune them.

> Another option, for advanced clients, would be to have userspace pass in a
> scheduling algorithm written in EBPF. One thing that might be helpful is =
to
> have a "send all packets on all subflows" scheduler for cases, though I'm
> not sure if that's feasible.

I like that idea of an ebpf-style scheduler.


Cheers,
Christoph

> =

> Regards,
> Lorenzo
> =

> On Wed, Aug 2, 2017 at 2:09 PM, Christoph Paasch <cpaasch(a)apple.com> wr=
ote:
> =

> > Hello,
> >
> > I'm adding Lorenzo (in CC) from Google to this thread. Lorenzo works on=
 the
> > networking of Android at Google.
> > Lorenzo, you can subscribe to the mailing-list at
> > https://lists.01.org/mailman/listinfo/mptcp.
> >
> >
> > I discussed MPTCP with him at the IETF two weeks back, and he was
> > interested
> > in helping making MPTCP upstreamable.
> > I let him chime in on the discussion.
> >
> >
> >
> > Wrt. to the below, yes I agree with the appraoch Mat outlined.
> > On my side, I will be able to spend more cycles now on Linux. I will st=
art
> > by porting the code from multipath-tcp.org up to upstream's version (we
> > have
> > been lagging behind quite a bit again). That way we have a common base
> > where
> > we can easily see how well the RFC-patches (for example more generic
> > capabilities in TCP) would work with MPTCP.
> >
> >
> > Cheers,
> > Christoph
> >
> >
> >
> > On 18/07/17 - 17:31:51, Mat Martineau wrote:
> > >
> > > Hello everyone,
> > >
> > > Our goal on this mailing list is to add an MPTCP implementation to the
> > > upstream Linux kernel. There's a fair amount of work to be done to
> > achieve
> > > this, and a number of options for how to go about it. Some of this
> > revisits
> > > previous discussions on this list and elsewhere, but I want to be sur=
e we
> > > have some level of consensus about the direction to head in.
> > >
> > > A couple of us on this list have had discussions with the Linux net
> > > maintainers, and they have some some specific needs concerning
> > modifications
> > > to the Linux TCP stack:
> > >
> > >  * TCP complexity can't increase. It's already a complex,
> > > performance-sensitive piece of software that every Linux user depends=
 on.
> > > Intrusive changes have a risk of creating bugs or changing operation =
of
> > the
> > > stack in unexpected ways.
> > >
> > >  * sk_buff structure size can't get bigger. It's already large and, if
> > > anything, they hope to reduce it's size. Changes to the data structure
> > size
> > > are amplified by the large number of instances in a system handling a
> > lot of
> > > traffic.
> > >
> > >  * An additional protocol like MPTCP should be opt-in, so users of
> > regular
> > > TCP continue to get the same type of connection and performance unless
> > MPTCP
> > > is requested.
> > >
> > > I also recommend reading "On submitting kernel patches"
> > > (http://halobates.de/on-submitting-patches.pdf) to get an idea of the
> > > process and hurdles involved in merging major core functionality for =
the
> > > Linux kernel.
> > >
> > >
> > > Various Strategies
> > > ------------------
> > >
> > > One approach is to attempt to merge the multipath-tcp.org fork. This =
is
> > an
> > > implementation in which the multipath-tcp.org community has invested a
> > lot
> > > of time and effort, and it is in production for major applications (s=
ee
> > > https://tools.ietf.org/html/rfc8041). This is a tremendous amount of
> > code to
> > > review at once (even separating out modules), and currently doesn't f=
it
> > with
> > > what the maintainers have asked for (non-intrusive, sk_buff size, MPT=
CP
> > by
> > > default). I don't think the maintainers would consider merging such an
> > > extensive piece git history, especially where there are a fair number=
 of
> > > commits without an "mptcp:" label on the subject line or without a DCO
> > > signoff (https://www.kernel.org/doc/html/latest/process/
> > submitting-patches.html#sign-your-work-the-developer-s-
> > certificate-of-origin).
> > > Today, the fork is at kernel v4.4 and current upstream development is=
 at
> > > v4.13-rc1, so the fork would have to catch up and stay current.
> > >
> > > The other extreme is to rewrite from scratch. This would allow
> > incremental
> > > development with maintainer review from the start, but doesn't take
> > > advantage of existing code.
> > >
> > > The most realistic approach is somewhere in between, where we write n=
ew
> > code
> > > that fits maintainer expectations and utilize components from the fork
> > where
> > > licensing allows and the code fits. We'll have to find the right bala=
nce:
> > > over-reliance on new code could take extra time, but constantly rewor=
king
> > > the fork and keeping it up-to-date with net-next is also a lot of
> > overhead.
> > >
> > > To start with, we can create RFC patches (code that's ready for comme=
nt
> > > rather than merge -- not "RFC" in the IETF sense) that allow us to ex=
tend
> > > TCP in the ways that are useful for both MPTCP and other extended TCP
> > > features. The maintainers would be able to review those standalone
> > patches,
> > > and there's potential to backport the patches to prove them out with =
the
> > > multipath-tcp.org code. Does this sound sensible? Any other approaches
> > to
> > > consider, or details that we should discuss here?
> > >
> > >
> > > Design for Upstream
> > > -------------------
> > >
> > > As a starting point for discussion, here are some characteristics that
> > might
> > > make MPTCP more upstream-friendly:
> > >
> > >  * MPTCP is used when requested by the application, either through an
> > > IPPROTO_MPTCP parameter to socket() or by using the new ULP (Upper La=
yer
> > > Protocol) capability.
> > >
> > >  * Move away from meta-sockets, treating each subflow more like a reg=
ular
> > > TCP connection. The overall MPTCP connection is coordinated by an upp=
er
> > > layer socket that is distinct from tcp_sock.
> > >
> > >  * Move functionality to userspace where possible, like tracking
> > ADD_ADDRs
> > > received, initiating new subflows, or accepting new subflows.
> > >
> > >  * Avoid adding locks to coordinate access to data that's shared betw=
een
> > > subflows. Utilize capabilities like compare-and-swap (cmpxchg), atomi=
cs,
> > and
> > > RCU to deal with shared data efficiently.
> > >
> > >  * Add generic capabilities to the TCP stack where it looks useful to
> > other
> > > protocol extensions. Examples: dynamically register handlers for TCP
> > option
> > > headers, make it possible to pass TCP options to/from an upper layer.
> > >
> > > Any comment on these? Maybe each deserves a thread of its own.
> > >
> > >
> > > Thanks again to Rao, Christoph, Peter, and Ossama for your help, work,
> > and
> > > interest. I'm looking forward to your insights.
> > >
> > >
> > > --
> > > Mat Martineau
> > > Intel OTC
> > > _______________________________________________
> > > mptcp mailing list
> > > mptcp(a)lists.01.org
> > > https://lists.01.org/mailman/listinfo/mptcp
> >

--===============4128227713123240386==--
