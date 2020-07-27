Content-Type: multipart/mixed; boundary="===============9081922158731890872=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 08/11] tcp: syncookies: keep mptcp option
 enabled
Date: Mon, 27 Jul 2020 11:13:40 +0200
Message-ID: <28ecf3fe8093764e1e81ec9158b95b2a441b6e78.camel@redhat.com>
In-Reply-To: 20200727085728.GH23458@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 5304

--===============9081922158731890872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-07-27 at 10:57 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > >  	treq =3D tcp_rsk(req);
> > >  	treq->tfo_listener =3D false;
> > >  =

> > > -	if (IS_ENABLED(CONFIG_MPTCP))
> > > -		treq->is_mptcp =3D 0;
> > > +	if (treq->is_mptcp) {
> > > +		int err =3D mptcp_subflow_init_cookie_req(req, sk, skb);
> > > +
> > > +		if (err)
> > > +			goto out_free;
> > > +	}
> > =

> > It looks like 'treq->is_mptcp' is not initialized here ?
> =

> Yes, this is resolved now.
> =

> > What about moving the whole oops selection, init_reqsk_alloc() call,
> > is_mptcp init and mptcp_subflow_init_cookie_req() call in an header
> > only helper? (say tcp_reqsk_alloc() or the like)
> =

> ipv6 uses tcp6_request_sock_ops, so they are not 100% the same,
> unfortunately.
> =

> What did you have in mind?

Something alike the following (untested):

struct request_sock *tcp_reqsk_alloc(const struct request_sock_ops *ops,
				     struct sock *sk)
{
	struct tcp_request_sock *treq;
	struct request_sock * req;
	=

#ifdef CONFIG_MPTCP
	if (sk_is_mptcp(sk))
		ops =3D &mptcp_subflow_request_sock_ops;
#endif
	req =3D inet_reqsk_alloc(ops, sk, false);
	if (!req)
		return req;
	treq =3D tcp_rsk(req);
	treq->is_mptcp =3D sk_is_mptcp(sk);
	if (treq->is_mptcp &&
	    mptcp_subflow_init_cookie_req(req, sk, skb)) {
		reqsk_free(req);
		return NULL;
	}
	return req;
}

than ipv4 may call tcp_reqsk_alloc(tcp_request_sock_ops, sk) and
ipv6 tcp_reqsk_alloc(tcp6_request_sock_ops, sk). That could possibly
remove the need for patch "tcp: syncookies: use single reqsk_free
location"

Not sure if I missed something more...

Cheers,

Paolo

--===============9081922158731890872==--
