Content-Type: multipart/mixed; boundary="===============2424074390054462618=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP upstreaming strategy and design
Date: Tue, 01 Aug 2017 22:16:22 -0700
Message-ID: <20170802051622.GG66276@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1708011457080.12055@ftee-mobl1.gar.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 69

--===============2424074390054462618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

(+Lorenzo)

On 01/08/17 - 16:39:53, Mat Martineau wrote:
> =

> On Mon, 31 Jul 2017, Rao Shoaib wrote:
> =

> > Hi Mat,
> > =

> > Thanks for writing this up. See my comments in line
> > =

> > =

> > On 07/18/2017 05:31 PM, Mat Martineau wrote:
> > > =

> > > Hello everyone,
> > > =

> > > Our goal on this mailing list is to add an MPTCP implementation to
> > > the upstream Linux kernel. There's a fair amount of work to be done
> > > to achieve this, and a number of options for how to go about it.
> > > Some of this revisits previous discussions on this list and
> > > elsewhere, but I want to be sure we have some level of consensus
> > > about the direction to head in.
> > > =

> > > A couple of us on this list have had discussions with the Linux net
> > > maintainers, and they have some some specific needs concerning
> > > modifications to the Linux TCP stack:
> > > =

> > >  * TCP complexity can't increase. It's already a complex,
> > > performance-sensitive piece of software that every Linux user
> > > depends on. Intrusive changes have a risk of creating bugs or
> > > changing operation of the stack in unexpected ways.
> > > =

> > >  * sk_buff structure size can't get bigger. It's already large and,
> > > if anything, they hope to reduce it's size. Changes to the data
> > > structure size are amplified by the large number of instances in a
> > > system handling a lot of traffic.
> > > =

> > >  * An additional protocol like MPTCP should be opt-in, so users of
> > > regular TCP continue to get the same type of connection and
> > > performance unless MPTCP is requested.
> > > =

> > > I also recommend reading "On submitting kernel patches"
> > > (http://halobates.de/on-submitting-patches.pdf) to get an idea of
> > > the process and hurdles involved in merging major core functionality
> > > for the Linux kernel.
> > > =

> > > =

> > > Various Strategies
> > > ------------------
> > > =

> > > One approach is to attempt to merge the multipath-tcp.org fork. This
> > > is an implementation in which the multipath-tcp.org community has
> > > invested a lot of time and effort, and it is in production for major
> > > applications (see https://tools.ietf.org/html/rfc8041). This is a
> > > tremendous amount of code to review at once (even separating out
> > > modules), and currently doesn't fit with what the maintainers have
> > > asked for (non-intrusive, sk_buff size, MPTCP by default). I don't
> > > think the maintainers would consider merging such an extensive piece
> > > git history, especially where there are a fair number of commits
> > > without an "mptcp:" label on the subject line or without a DCO
> > > signoff (https://www.kernel.org/doc/html/latest/process/submitting-pa=
tches.html#sign-your-work-the-developer-s-certificate-of-origin).
> > > Today, the fork is at kernel v4.4 and current upstream development
> > > is at v4.13-rc1, so the fork would have to catch up and stay
> > > current.
> > > =

> > > The other extreme is to rewrite from scratch. This would allow
> > > incremental development with maintainer review from the start, but
> > > doesn't take advantage of existing code.
> > > =

> > > The most realistic approach is somewhere in between, where we write
> > > new code that fits maintainer expectations and utilize components
> > > from the fork where licensing allows and the code fits. We'll have
> > > to find the right balance: over-reliance on new code could take
> > > extra time, but constantly reworking the fork and keeping it
> > > up-to-date with net-next is also a lot of overhead.
> > > =

> > > To start with, we can create RFC patches (code that's ready for
> > > comment rather than merge -- not "RFC" in the IETF sense) that allow
> > > us to extend TCP in the ways that are useful for both MPTCP and
> > > other extended TCP features. The maintainers would be able to review
> > > those standalone patches, and there's potential to backport the
> > > patches to prove them out with the multipath-tcp.org code. Does this
> > > sound sensible? Any other approaches to consider, or details that we
> > > should discuss here?
> > I agree with the above approach but want to expand on the initial goal.
> > =

> > Our initial goal must be to put a minimal (bare bones) MPTCP
> > implementation in main stream Linux. That could mean no fancy scheduling
> > schemes, just simple round robin or just active/standby. Implementing
> > minimal MPTCP functionality will pretty much expose how main TCP code
> > will be impacted. Any future work to add features will be confined to
> > changes within MPTCP and should not be a concern right now. Such an
> > implementation will also be fully RFC compliant.
> =

> Reaching a bare-bones upstream MPTCP implementation is a very important
> milestone to reach, and it will take several steps to get there. I'm
> suggesting that initial patches for TCP extensibility are the first steps
> toward the bare-bones upstream implementation.

+1 on the minimal implementation

Things that can be "removed" are IMO:
* Path-management outsourced to user-space via an API
* All the scheduling algorithms, with a basic API exposed ot user-space
* Congestion-controls
* Address management (ADD_ADDR, REMOVE_ADDR)
* subflow-priorities
* We can consider shipping without TSO-support, splice-support,... (if it
  makes the code-base simpler)


Christoph

> =

> > I agree with you that upstream folks would want an opt-in option. I am
> > in favor of a completely different socket family as that would leave tcp
> > socket code untouched. However we should talk to upstream folks once
> > again.
> =

> We can still use AF_INET or AF_INET6 without interfering with TCP socket
> code. MPTCP is layered on IP, like TCP and UDP, so it makes some sense to
> group it there.
> =

> One technique is to define a new IPPROTO_MPTCP value to pass in to
> socket()'s third arg. The catch is that most IPPROTO_* definitions use the
> IANA-defined IP protocol numbers, and MPTCP packets use protocol 6 like T=
CP.
> IP packets have a single byte for the protocol, but socket() takes a wider
> int, so there's some room to use a larger integer (>255). I have some
> prototype code that does this.
> =

> Another option is to leverage the new ULP infrastructure for setting
> upper-layer protocols. It looks like Tom Herbert is making some changes to
> improve ULP, maybe he will address Christoph's safety concerns.
> =

> The best way to engage with the maintainers on this is to post it to netd=
ev
> in patch form - for example, an RFC patch with just the uapi header chang=
es
> and a thorough explanation.
> =

> > =

> > I would like us to use as much code as possible from the current
> > implementation.
> =

> Where it saves effort and testing, we should definitely consider code reu=
se.
> =

> > In fact if for some reason (I don't see one) we can not ship a minimal
> > implementation than I prefer that we just port the current
> > implementation and worry about architectural issues later.
> =

> I also don't see a reason a minimal implementation won't work.
> =

> > In short, I would like our focus to be on putting a minimal MPTCP
> > implementation in Linux so that we have a stake in the ground.
> > Performance and Features can come later.
> =

> Agreed.
> =

> > That does not mean that the quality of our implementation is so bad that
> > it is unusable.
> =

> I suggest we aim for high quality :)
> =

> My team has some prototype code that I'm getting in shape to post on this
> list. I'll separate out the user API so we can settle on a proposal for
> netdev.
> =

> =

> Mat
> =

> =

> > =

> > Shoaib
> > =

> > =

> > > =

> > > Design for Upstream
> > > -------------------
> > > =

> > > As a starting point for discussion, here are some characteristics
> > > that might make MPTCP more upstream-friendly:
> > > =

> > >  * MPTCP is used when requested by the application, either through
> > > an IPPROTO_MPTCP parameter to socket() or by using the new ULP
> > > (Upper Layer Protocol) capability.
> > > =

> > >  * Move away from meta-sockets, treating each subflow more like a
> > > regular TCP connection. The overall MPTCP connection is coordinated
> > > by an upper layer socket that is distinct from tcp_sock.
> > > =

> > >  * Move functionality to userspace where possible, like tracking
> > > ADD_ADDRs received, initiating new subflows, or accepting new
> > > subflows.
> > > =

> > >  * Avoid adding locks to coordinate access to data that's shared
> > > between subflows. Utilize capabilities like compare-and-swap
> > > (cmpxchg), atomics, and RCU to deal with shared data efficiently.
> > > =

> > >  * Add generic capabilities to the TCP stack where it looks useful
> > > to other protocol extensions. Examples: dynamically register
> > > handlers for TCP option headers, make it possible to pass TCP
> > > options to/from an upper layer.
> > > =

> > > Any comment on these? Maybe each deserves a thread of its own.
> > > =

> > > =

> > > Thanks again to Rao, Christoph, Peter, and Ossama for your help,
> > > work, and interest. I'm looking forward to your insights.
> > > =

> > > =

> > > -- =

> > > Mat Martineau
> > > Intel OTC
> > > _______________________________________________
> > > mptcp mailing list
> > > mptcp(a)lists.01.org
> > > https://lists.01.org/mailman/listinfo/mptcp
> > =

> > _______________________________________________
> > mptcp mailing list
> > mptcp(a)lists.01.org
> > https://lists.01.org/mailman/listinfo/mptcp
> > =

> =

> --
> Mat Martineau
> Intel OTC
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============2424074390054462618==--
