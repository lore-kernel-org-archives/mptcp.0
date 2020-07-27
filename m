Content-Type: multipart/mixed; boundary="===============6479905664088186051=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 09/11] tcp: handle want_cookie clause via
 reqsk_put
Date: Mon, 27 Jul 2020 11:00:45 +0200
Message-ID: <20200727090045.GI23458@breakpoint.cc>
In-Reply-To: a49c792cc84ebd17c336f6fca9b6dd6f83b641b8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5302

--===============6479905664088186051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Tue, 2020-07-14 at 20:25 +0200, Florian Westphal wrote:
> > This will allow the syn_recv_sock callback to keep the request
> > socket around even when syncookies are used.
> > =

> > This will be needed to make MPTCP JOIN requests work in cookie mode.
> > =

> > When a JOIN request is received, we cannot use cookies because
> > we need to remember the peers nonce value for HMAC validation.
> > =

> > Next patch will handle the cookie+join case by allowing the
> > rsk to stay around provided:
> >  1. We can find a valid mptcp socket for the 32bit token provided
> >     by the join and
> >  2. the found mptcp socket doesn't exceed the maximum number of
> >     subflows.
> > =

> > To handle 2) the request socket will not only be accounted with the
> > listener but also with the mptcp (parent) socket.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> >  net/ipv4/tcp_input.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > =

> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 5ae612902806..f45ca689bfa7 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -6690,6 +6690,7 @@ int tcp_conn_request(struct request_sock_ops *rsk=
_ops,
> >  	/* Note: tcp_v6_init_req() might override ir_iif for link locals */
> >  	inet_rsk(req)->ir_iif =3D inet_request_bound_dev_if(sk, skb);
> >  =

> > +	refcount_set(&req->rsk_refcnt, 1);
> =

> I could not find easily where sk_refcnt is increment/how is handled
> currently/before this patch. Can you please give some pointers?

Its 0 and set to 3 on insert via reqsk_queue_hash_req().

> >  	af_ops->init_req(req, sk, skb);
> >  =

> >  	if (security_inet_conn_request(sk, skb, req))
> > @@ -6760,10 +6761,6 @@ int tcp_conn_request(struct request_sock_ops *rs=
k_ops,
> >  		af_ops->send_synack(sk, dst, &fl, req, &foc,
> >  				    !want_cookie ? TCP_SYNACK_NORMAL :
> >  						   TCP_SYNACK_COOKIE);
> > -		if (want_cookie) {
> > -			reqsk_free(req);
> > -			return 0;
> > -		}
> >  	}
> >  	reqsk_put(req);
> =

> This means all syn cookied req (even plain TCP ones, even on non MPTCP
> build) will get an additional atomic decrement, correct?

Yes.

> I fear the overhead could be measurable - even if the testbed is not
> trivial at all!

The alternative is to allow ->init_req to say 'I do want the req to be
inserted anyway', e.g. via a bit in req.

> What if we avoid touching this code path, and instead store a - very
> limited, possibly only 1 - number of hmacs into the msk?

Would need to duplicate timeout logic and so on which I wanted to
avoid.

But yes, thats another alternative.
--===============6479905664088186051==--
