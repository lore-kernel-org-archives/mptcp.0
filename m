Content-Type: multipart/mixed; boundary="===============2495926812964767643=="
MIME-Version: 1.0
From: Stephen Brennan <stephen at brennan.io>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Using struct socket for subflows
Date: Wed, 28 Mar 2018 14:33:03 -0700
Message-ID: <20180328213303.GB31782@greed.cult>
In-Reply-To: 634b848f-cc34-43c7-93ee-1906b9534f6a@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 440

--===============2495926812964767643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rao et al.,

On Tue, Mar 27, 2018 at 06:53:46PM -0700, Rao Shoaib wrote:
> =

> =

> On 03/27/2018 05:04 AM, Lorenzo Colitti wrote:
> > On Tue, Mar 27, 2018 at 11:18 AM, Christoph Paasch <cpaasch(a)apple.com
> > <mailto:cpaasch(a)apple.com>> wrote:
> > =

> >     It also would allow us to expose subflows as file-descriptors to the
> >     user-space. That way the user-space can do setsockopt,
> >     getsockopt,... on the
> >     subflows. An idea that came up in the past when we were thinking
> >     on how to
> >     expose an MPTCP API that allows apps to control certain things on t=
he
> >     subflows.
> > =

> > =

> > +1 to this since it will allow client platforms to use setsockopt to,
> > for example, bind subflows to interfaces (e.g., with SO_BINDTODEVICE, or
> > with SO_MARK as used by Android).
> May I ask why it can not be done=C2=A0 -- Only flow id should be needed.

It sounds like you're referring to the proposed MPTCP_SUB_GETSOCKOPT and
MPTCP_SUB_SETSOCKOPT operations in this IETF draft [1], correct?

[1]: https://tools.ietf.org/html/draft-hesmans-mptcp-socket-00

> Plus for
> policy enforcement the meta socket would have to be consulted. I am new to
> Linux but based on what I have read SO_BINDTODEVICE does not guarantee mu=
ch
> for Tx if the routing says otherwise, quick check of ip_queue_xmit() shows
> it first consults the routing table. I understand policy routing can be u=
sed
> to steer the packets. Perhaps my understanding is incorrect.
>
> IMHO this whole idea of exposing individual flows to the application seems
> to go against the basic design of MPTCP. I am not sure what the use case =
is
> as TCP is streams based and MPTCP will spread out data on multiple flows.=
 I
> am not a involved in the cellular space so I don' know, feel free to
> enlighten me.

I'm also a bit confused at this. I've read the Socket API drafts from IETF,
which seem to be motivated by the idea that mobile apps will want to
directly control which subflows and paths are created (similar to the iOS
APIs released recently). It sounds like we have two approaches: (1) MPTCP
as a drop-in replacement for TCP, so unmodified applications may use it,
and (2) MPTCP as an explicitly requested protocol which user-space
applications request, and then manipulate via socket options. Given the
amount of drafts and other work put in so far, it seems that use case (2)
has enough demand that it ought to be supported.

Going slightly off topic from this discussion, it seems that a lot of what
is desired in use case (2) is allowing the application to manage its own
paths. We now have a Netlink API for userspace path managers. Have we
thought about the possibility of a userspace application creating an MPTCP
socket, and also a netlink socket, so that it could manage its own paths?
Just an off-the-wall idea. If such a thing were possible, it could give the
userspace app much more control over its own path management, while
reducing duplication of functionality in-kernel (e.g. wouldn't have both
socket option for opening a subflow, plus a netlink command for opening a
subflow). A userspace library could hide some of this complexity for users
of use-case (2), while still allowing use-case (1) to exist through the
normal socket API.

Stephen



--===============2495926812964767643==--
