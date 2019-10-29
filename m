Content-Type: multipart/mixed; boundary="===============7550376179374650220=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 2/2] mptcp: Add IPv6 support
Date: Tue, 29 Oct 2019 12:22:13 +0100
Message-ID: <8a35c580f3019f83fdf3298bb178005e57a60ef8.camel@redhat.com>
In-Reply-To: 774e1784ee86e7e33753ccbc693dffc50225ec7c.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2343

--===============7550376179374650220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-28 at 16:37 -0700, Peter Krystad wrote:
> Hi Paolo -
> =

> Thanks for the review, sorry for the slow response.
> =

> On Thu, 2019-10-17 at 12:36 +0200, Paolo Abeni wrote:
> > Hi,
> > =

> > On Wed, 2019-10-16 at 17:02 -0700, Peter Krystad wrote:
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 4fdcbb0f4285..bc38527209c9 100644
> > > @@ -1182,6 +1214,53 @@ static int mptcp_getname(struct socket *sock, =
struct sockaddr *uaddr,
> > >  	return ret;
> > >  }
> > >  =

> > > +#if IS_ENABLED(CONFIG_IPV6)
> > > +static int mptcp_v6_getname(struct socket *sock, struct sockaddr *ua=
ddr,
> > > +			    int peer)
> > > +{
> > > +	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
> > > +	struct socket *ssock;
> > > +	struct sock *ssk;
> > > +	int ret;
> > > +
> > > +	if (sock->sk->sk_prot =3D=3D &tcpv6_prot) {
> > > +		/* we are being invoked from __sys_accept4, after
> > > +		 * mptcp_accept() has just accepted a non-mp-capable
> > > +		 * flow: sk is a tcp_sk, not an mptcp one.
> > > +		 *
> > > +		 * Hand the socket over to tcp so all further socket ops
> > > +		 * bypass mptcp.
> > > +		 */
> > > +		sock->ops =3D &inet_stream_ops;
> > =

> > Should we have &inet6_stream_ops  here ^^^^^^ ???
> > Possibly the comments should be adjusted as well.
> =

> Yes, nice catch. Comment, at least the __sys_accept4 part, is OK, I think=
 the
> 4 refers to a version of accept, not the protocol.

Oh, nice! I really missed the real meaning of the trailing '4' in
__sys_accept4(), thanks for pointing that out.

Switching to inet6_stream_ops should be ok anyway, right?

> =

> > [...]
> > =

> > > @@ -1311,3 +1409,33 @@ void mptcp_proto_init(void)
> > >  =

> > >  	inet_register_protosw(&mptcp_protosw);
> > >  }
> > > +
> > > +#if IS_ENABLED(CONFIG_IPV6)
> > > +static struct proto_ops mptcp_v6_stream_ops;
> > > +
> > > +static struct inet_protosw mptcp_v6_protosw =3D {
> > > +	.type		=3D SOCK_STREAM,
> > > +	.protocol	=3D IPPROTO_MPTCP,
> > > +	.prot		=3D &mptcp_prot,
> > > +	.ops		=3D &mptcp_v6_stream_ops,
> > > +	.flags		=3D INET_PROTOSW_ICSK,
> > > +};
> > > +
> > > +int mptcp_proto_v6_init(void)
> > > +{
> > > +	int err;
> > > +
> > > +	mptcp_v6_stream_ops =3D inet6_stream_ops;
> > > +	mptcp_v6_stream_ops.bind =3D mptcp_v6_bind;
> > > +	mptcp_v6_stream_ops.connect =3D mptcp_v6_stream_connect;
> > > +	mptcp_v6_stream_ops.poll =3D mptcp_poll;
> > > +	mptcp_v6_stream_ops.accept =3D mptcp_stream_accept;
> > > +	mptcp_v6_stream_ops.getname =3D mptcp_v6_getname;
> > > +	mptcp_v6_stream_ops.listen =3D mptcp_v6_listen;
> > > +	mptcp_v6_stream_ops.shutdown =3D mptcp_shutdown;
> > > +
> > > +	err =3D inet6_register_protosw(&mptcp_v6_protosw);
> > =

> > For IPv4 we currently do panic, if we can't register the protosw
> > struct, possibly we could explicitly handle the failure even there?
> =

> Sorry, are suggesting getting rid of the panic()'s in IPv4? Or adding them
> here?

In my previous email I suggested getting rid of the panic in IPv4 -
just to harmoize the ipv4 and ipv6 behavior - but it's not a big deal:
for simplicity we can stick to the current implementation.

> > Overall this looks nice and clean! What about moving the ipv6
> > protocol.c support into a separate file, to reduce the preprocessor
> > conditionals?
> =

> Thanks. Next step to is split the IPv6 into a seperate file, then I'll su=
bmit
> as a PATCH.

Excellent! looking forward to it!

Paolo

--===============7550376179374650220==--
