Content-Type: multipart/mixed; boundary="===============1228969679632808705=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Using struct socket for subflows
Date: Wed, 28 Mar 2018 11:34:46 +0200
Message-ID: <20180328093446.GO71178@MacBook-Pro-6.lan>
In-Reply-To: alpine.OSX.2.21.1803271541260.6111@shhwang-mobl3.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 435

--===============1228969679632808705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 27/03/18 - 16:29:26, Mat Martineau wrote:
> =

> Hi Christoph,
> =

> On Tue, 27 Mar 2018, Christoph Paasch wrote:
> =

> > Hello,
> > =

> > =

> > (first, sorry for the long e-mail)
> > =

> > =

> > I now started working on cleaning up the input path to prepare it for
> > input-processing without holding the MPTCP-level lock.
> > =

> > To do this, I go through all the places where we access data-structures=
 from
> > the meta-socket and see if I can move it to mptcp_data_ready or
> > mptcp_write_space (the callbacks that are called from
> > sk_data_ready/sk_write_space).
> > =

> > In tcp_check_space() we have the following:
> >                if (mptcp(tcp_sk(sk)) ||
> >                    (sk->sk_socket &&
> >                     test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))) {
> >                        tcp_new_space(sk);
> >                        if (sk->sk_socket && !test_bit(SOCK_NOSPACE, &sk=
->sk_socket->flags))
> >                                tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LI=
MITED);
> >                }
> > =

> > We do the if (mptcp(...)), because currently subflow's sk_socket is poi=
nting to
> > application's struct socket. Thus, we need to avoid the check for
> > SOCK_NOSPACE, as otherwise we might end up not calling sk_write_space.
> > =

> > =

> > Other kernel-modules that create TCP-connections rather have an in-kern=
el
> > struct socket. And modules like RDS even force SOCK_NOSPACE to be set, =
such
> > that the TCP-stack keeps on up-calling. I thought that this was a good =
thing
> > to do in MPTCP as well.
> > =

> > So, my goal became to have a fully functional struct socket for subflow=
s.
> > The benefit is also that we can end up using kernel_sendmsg,
> > kernel_recvmsg,... in the future. It also allows to do kernel_accept() =
on
> > the MPTCP-level socket to receive new subflows (a problem I mentioned i=
n an
> > earlier mail).
> =

> I think we'll have a patch set illustrating this approach ready to post
> tomorrow.

Awesome! I am waiting for your patch :)

> Peter and I have been working on this net-next-based code with
> in-kernel sockets for many months now. I missed the SOCK_NOSPACE detail
> though - I'll take a look at that.
> =

> Rather than using kernel_sendmsg and kernel_recvmsg, I use do_tcp_sendpag=
es
> (to reduce copying and let the MPTCP connection layer share data across s=
kbs
> and subflows as it needs to) and tcp_read_sock (to read intact skbs out of
> the rx queue). The kernel_* functions are used for most everything else
> though.

Do you also handle kernel_accept ?
If yes, how do you do it? Because, it's quite complex to avoid races.

> > It also would allow us to expose subflows as file-descriptors to the
> > user-space. That way the user-space can do setsockopt, getsockopt,... o=
n the
> > subflows. An idea that came up in the past when we were thinking on how=
 to
> > expose an MPTCP API that allows apps to control certain things on the
> > subflows.
> =

> I like that idea too. We hadn't come up with a good design idea for
> propagating many of the getsockopt/setsockopt operations from the
> connection-level socket to all of the subflows.
> =

> > =

> > To get there, there are a few places where things would need to change:
> > =

> > * mptcp_init4_subsockets - Here, this works perfectly. It also allows to
> >  avoid "faking" the struct socket, as we are currently doing.
> > * mptcp_alloc_mpcb for the active opener - This is the first problem. m=
ptcp_alloc_mpcb() can be
> >  called with bh disabled. But sock_create_lite() assumes that bh is ena=
bled
> >  as it ends up doing an alloc with GFP_KERNEL.
> >  A few ways this could be solved:
> >  - Schedule a work-queue item in mptcp_alloc_mpcb that creates the stru=
ct
> >    socket. This looks a bit racy to me. Not sure what side-effects this
> >    might have.
> >  - Change things entirely, such that the master-sock is being allocated
> >    when the connection is created. That way, we allocate all the necess=
ary
> >    struct socket's right away.
> >    In the past, we decided to allocate the master-sk only when receiving
> >    the SYN/ACK. We did that so as to minimize the impact on regular TCP
> >    when the server does not support MPTCP. But, as we are moving towards
> >    explicitly exposing MPTCP at the socket-layer, we can rethink that
> >    decision.
> >    Any thoughts? Is it ok to pay the cost of allocating a master-sk bef=
ore
> >    we know whether the server supports MPTCP?
> >    I think, we should do this, and transition to that model.
> =

> I prefer the latter. If MPTCP is exposed at the socket layer, it's only
> MPTCP sockets that experience the overhead (relative to a regular TCP
> socket) when regular TCP is used.

Are you doing the latter in your implementation?


Christoph

> =

> > * mptcp_alloc_mpcb for the passive opener - same problem as above but o=
n the
> >  other side. We could allocate the master's struct socket upon the acce=
pt()
> >  call from the application. This again sounds a bit racy to me. The str=
uct
> >  socket will be there for the subflow potentially much later than it has
> >  been established. What happens if the peer sends data or an
> >  MP_FASTCLOSE,... ?
> > * New subflows on the passive opener side - again, we are receiving tho=
se
> >  subflows while bh is disabled. So, we have to schedule a work-queue to
> >  do a kerne_accept() on the MPTCP-socket.
> >  Again something that can potentially be racy.
> > =

> > In general, subflow-establishment on the passive-opener side again seem=
s to
> > be a major pain-point. I think, we really need to redesign that.
> > =

> > =

> > Any thoughts, feedback, suggestions?
> > Or maybe, using real struct socket for subflows is not worth it? :)
> =

> Using the struct socket for subflows will take some work, but I think it's
> an important part of shaping the code for upstream. If the subflows look
> more like regular TCP sockets I think that will help keep the MPTCP code
> well partitioned from TCP.
> =

> =

> --
> Mat Martineau
> Intel OTC

--===============1228969679632808705==--
