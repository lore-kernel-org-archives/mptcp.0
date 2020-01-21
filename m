Content-Type: multipart/mixed; boundary="===============1693159749782342558=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: cope with later TCP fallback"
Date: Tue, 21 Jan 2020 08:53:29 -0800
Message-ID: <3c60e4ffcb6e32ce17113dab876dc21d9d6358df.camel@linux.intel.com>
In-Reply-To: alpine.OSX.2.21.2001210847330.4301@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 3448

--===============1693159749782342558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-21 at 08:49 -0800, Mat Martineau wrote:
> On Tue, 21 Jan 2020, Paolo Abeni wrote:
> =

> > kbuildbot reported a build breakage with IPV6 disabled.
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redha.com>
> > ---
> > net/mptcp/protocol.c | 12 ++++++++++--
> > 1 file changed, 10 insertions(+), 2 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 6da609791c7a..4e289ff748ad 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -26,6 +26,15 @@
> > =

> > static void __mptcp_close(struct sock *sk, long timeout);
> > =

> > +static const struct proto_ops * tcp_proto_ops(struct sock *sk)
> > +{
> > +#if IS_ENABLED(IPV6)
> =

> Does this need to be IS_ENABLED(CONFIG_IPV6) ?

Or IS_ENABLED(CONFIG_MPTCP_IPV6)?

Peter.

> > +	if (sk->sk_family =3D=3D AF_INET6)
> > +		return &inet6_stream_ops;
> > +#endif
> > +	return &inet_stream_ops;
> > +}
> > +
> > /* MP_CAPABLE handshake failed, convert msk to plain tcp, replacing
> >  * socket->sk and stream ops and destroying msk
> >  * return the msk socket, as we can't access msk anymore after this fun=
ction
> > @@ -60,8 +69,7 @@ static struct socket *__mptcp_fallback_to_tcp(struct =
mptcp_sock *msk,
> > 		subflow->conn =3D NULL;
> > 	}
> > 	release_sock(ssk);
> > -	sock->ops =3D sk->sk_family =3D=3D AF_INET6 ? &inet6_stream_ops :
> > -						&inet_stream_ops;
> > +	sock->ops =3D tcp_proto_ops(ssk);
> > =

> > 	/* destroy the left-over msk sock */
> > 	__mptcp_close(sk, 0);
> > -- =

> > 2.21.0
> =

> --
> Mat Martineau
> Intel
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org

--===============1693159749782342558==--
