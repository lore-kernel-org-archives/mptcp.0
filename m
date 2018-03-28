Content-Type: multipart/mixed; boundary="===============7904530432273680917=="
MIME-Version: 1.0
From: Stephen Brennan <stephen at brennan.io>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Status and what's next
Date: Wed, 28 Mar 2018 13:39:42 -0700
Message-ID: <20180328203942.GA31782@greed.cult>
In-Reply-To: alpine.OSX.2.21.1803241236490.21805@siradov-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 439

--===============7904530432273680917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

I've been catching up a bit on the patches and discussion going on, so
please excuse my late reply. Please see my inline question.

On Sat, Mar 24, 2018 at 12:47:46PM -0700, Mat Martineau wrote:
>
> Hello everyone -
>
> In our recent web conference call, we thought it would be helpful to
> summarize what is coming up for MPTCP upstreaming. To start, I'd like to
> review work that's already been done and is underway.
>
> Previous work:
>
> * Mat developed an extensible TCP option framework patch, and Christoph
> refactored upstream TCP-MD5 and SMC functionality to use it. The idea was=
 to
> integrate some extensions in to TCP that had utility for existing
> functionality, but would also help integrate MPTCP. This RFC patch set was
> turned down by Dave Miller, but did give us useful guidance.
>
> * Mat published a proposal for optionally extending sk_buff shared info to
> carry MPTCP metadata.
>
>
> Ongoing work:
>
> * Christoph keeps the multipath-tcp.org kernel merged with recent kernel
> releases as part of his maintainership role for the multipath-tcp.org
> project, and is refactoring parts of the MPTCP implementation to take
> advantage of newer kernel or TCP features and to align with upstreaming
> goals.
>
> * Rao has published an RFC patch set based on the multipath-tcp.org MPTCP
> implementation and the current upstream kernel, with modifications to make
> the TCP implementation extensible in a way that's useful for MPTCP. It is
> currently under review by community members.
>
> * Matthieu has sent a generic netlink patch set to mptcp-dev.
>
> * Ossama shared a generic netlink path management API proposal. The Intel
> group developed this before we knew Matthieu would be sharing an
> implementation.
>
> * Stephan shared a userspace path manager draft implementation at
> https://github.com/brenns10/pathmand
>
> * Peter and Mat are preparing a patch set showing an MPTCP architecture w=
ith
> a separate socket type for the MPTCP connection and using in-kernel TCP
> sockets for subflows. The extended sk_buff structure patch is part of thi=
s.
>
> * Ossama has made significant progress on a userspace path manager
> implementation with the goal to open source it
>
> That gives us quite a bit to discuss and review on the list in the near
> term. The bigger and longer-term challenge is to take these pieces and
> develop a strategy and patches for upstream submissions.
>
>
> There are a few things the MPTCP upstreaming community members on this li=
st
> seem aligned on:
>
> * MPTCP belongs in the upstream kernel
>
> * The multipath-tcp.org implementation is not upstream-ready as-is
>
> * Implementing 100% from scratch is not the preferred strategy
>
>
> How do we get to upstreamable patch sets from here? I think if we can agr=
ee
> on what an upstreamable MPTCP architecture looks we can evaluate patch se=
ts
> accordingly. I've proposed these design characteristics before, but the
> mailing list has expanded significantly since then:
>
> * MPTCP is used when requested by the application, either through an
> IPPROTO_MPTCP parameter to socket() or by using the new ULP (Upper Layer
> Protocol) capability.

I'm curious why this is listed as a strategy for upstreaming. It sounds
like the only way to create a userspace MPTCP socket would be the calls:

    sk =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP)
    sk =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_MPTCP)

Whereas most TCP users use

    sk =3D socket(AF_INET, SOCK_STREAM, 0)
    sk =3D socket(AF_INET6, SOCK_STREAM, 0)

or

    sk =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
    sk =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_TCP)

Isn't part of the goal of MPTCP to be compatible with unmodified
applications? Requiring IPPROTO_MPTCP means that existing TCP apps won't
benefit from MPTCP.

Or is this simply an initial strategy for getting into the mainline, with
the hopes of making MPTCP the default for TCP apps later on?

Thanks,
Stephen

>
> * Move away from meta-sockets, treating each subflow more like a regular =
TCP
> connection. The overall MPTCP connection is coordinated by an upper layer
> socket that is distinct from tcp_sock.
>
> * Move functionality to userspace where possible, like tracking ADD_ADDRs
> received, initiating new subflows, or accepting new subflows.
>
> * Avoid adding locks to coordinate access to data that's shared between
> subflows. Utilize capabilities like compare-and-swap (cmpxchg), atomics, =
and
> RCU to deal with shared data efficiently.
>
> Are these the right place to start? Anyone want to expand the list?
>
>
> Thanks,
>
> --
> Mat Martineau
> Intel OTC
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============7904530432273680917==--
