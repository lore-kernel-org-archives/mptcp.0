Content-Type: multipart/mixed; boundary="===============6522893985242503614=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2] mptcp: be careful on MPTCP-level ack.
Date: Wed, 02 Dec 2020 17:51:41 +0100
Message-ID: <0c400986125dfdd42990ee4203a60d9b309d29c8.camel@redhat.com>
In-Reply-To: e2e9500c-f2cc-2e08-6ecc-68ed50e64cd1@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7016

--===============6522893985242503614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-12-02 at 17:45 +0100, Eric Dumazet wrote:
> =

> On 12/2/20 5:32 PM, Eric Dumazet wrote:
> > =

> > On 12/2/20 5:30 PM, Eric Dumazet wrote:
> > > =

> > > On 12/2/20 5:10 PM, Eric Dumazet wrote:
> > > > =

> > > > On 12/2/20 4:37 PM, Paolo Abeni wrote:
> > > > > On Wed, 2020-12-02 at 14:18 +0100, Eric Dumazet wrote:
> > > > > > On 11/24/20 10:51 PM, Paolo Abeni wrote:
> > > > > > > We can enter the main mptcp_recvmsg() loop even when
> > > > > > > no subflows are connected. As note by Eric, that would
> > > > > > > result in a divide by zero oops on ack generation.
> > > > > > > =

> > > > > > > Address the issue by checking the subflow status before
> > > > > > > sending the ack.
> > > > > > > =

> > > > > > > Additionally protect mptcp_recvmsg() against invocation
> > > > > > > with weird socket states.
> > > > > > > =

> > > > > > > v1 -> v2:
> > > > > > >  - removed unneeded inline keyword - Jakub
> > > > > > > =

> > > > > > > Reported-and-suggested-by: Eric Dumazet <eric.dumazet(a)gmail=
.com>
> > > > > > > Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack schedulin=
g")
> > > > > > > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > > > > > > ---
> > > > > > >  net/mptcp/protocol.c | 67 ++++++++++++++++++++++++++++++++--=
----------
> > > > > > >  1 file changed, 49 insertions(+), 18 deletions(-)
> > > > > > > =

> > > > > > =

> > > > > > Looking at mptcp recvmsg(), it seems that a read(fd, ..., 0) wi=
ll
> > > > > > trigger an infinite loop if there is available data in receive =
queue ?
> > > > > =

> > > > > Thank you for looking into this!
> > > > > =

> > > > > I can't reproduce the issue with the following packetdrill ?!?
> > > > > =

> > > > > +0.0  connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in p=
rogress)
> > > > > +0.1   > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8,=
mpcapable v1 fflags[flag_h] nokey>
> > > > > +0.1   < S. 0:0(0) ack 1 win 65535 <mss 1460,sackOK,TS val 700 ec=
r 100,nop,wscaale 8,mpcapable v1 flags[flag_h] key[skey=3D2] >
> > > > > +0.1  > . 1:1(0) ack 1 <nop, nop, TS val 100 ecr 700,mpcapable v1=
 flags[flag_h]] key[ckey,skey]>
> > > > > +0.1 fcntl(3, F_SETFL, O_RDWR) =3D 0
> > > > > +0.1   < .  1:201(200) ack 1 win 225 <dss dack8=3D1 dsn8=3D1 ssn=
=3D1 dll=3D200 nocs,  nop, nop>
> > > > > +0.1   > .  1:1(0) ack 201 <nop, nop, TS val 100 ecr 700, dss dac=
k8=3D201 dll=3D00 nocs>
> > > > > +0.1 read(3, ..., 0) =3D 0
> > > > > =

> > > > > The main recvmsg() loop is interrupted by the following check:
> > > > > =

> > > > >                 if (copied >=3D target)
> > > > >                         break;
> > > > =

> > > > @copied should be 0, and @target should be 1
> > > > =

> > > > Are you sure the above condition is triggering ?
> > > > =

> > > > Maybe read(fd, ..., 0) does not reach recvmsg() at all.
> > > =

> > > Yes, sock_read_iter() has a shortcut :
> > > =

> > > if (!iov_iter_count(to))    /* Match SYS5 behaviour */
> > >      res =3D sock_recvmsg(sock, &msg, msg.msg_flags);
> > =

> > No idea what went wrong with my copy/paste.
> > =

> > The real code is more like :
> > =

> > if (!iov_iter_count(to))    /* Match SYS5 behaviour */
> >     return 0;
> > =

> =

> Packetdrill recvmsg syntax would be something like
> =

>    +0	recvmsg(3, {msg_name(...)=3D...,
> 		    msg_iov(1)=3D[{..., 0}],
> 		    msg_flags=3D0
> 		    }, 0) =3D 0

Thank you very much for all the effort!

Yes, with recvmsg() the packet drill hangs. I agree your proposed fix
is correct.

I can test it explicitly later today.

(and sorry for the initial confusing/confused reply)

Paolo



--===============6522893985242503614==--
