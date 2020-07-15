Content-Type: multipart/mixed; boundary="===============1797739074744222609=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 08/11] tcp: syncookies: keep mptcp option
 enabled
Date: Wed, 15 Jul 2020 07:50:20 -0700
Message-ID: <20200715145020.GJ73500@MacBook-Pro-64.local>
In-Reply-To: 377c3773a4003f9667c9f03fad2e7537a3fdb1ba.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5018

--===============1797739074744222609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/15/20 - 15:22, Paolo Abeni wrote:
> On Tue, 2020-07-14 at 20:25 +0200, Florian Westphal wrote:
> > If SYN packet contains MP_CAPABLE option, keep it enabled.
> > The mptcp relevant code is changed to detect the new 'sycookie' flag
> > in the request socket.  If it is set, the socket isn't inserted into
> > the token tree.  This will only be done when the cookie ACK comes back.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> >  net/ipv4/syncookies.c | 21 +++++++++++++++++----
> >  net/ipv4/tcp_input.c  |  4 +---
> >  net/ipv6/syncookies.c | 17 ++++++++++++++---
> >  3 files changed, 32 insertions(+), 10 deletions(-)
> > =

> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index ee17f55401ef..5da49dc126f9 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -289,6 +289,7 @@ struct sock *cookie_v4_check(struct sock *sk, struc=
t sk_buff *skb)
> >  	struct tcp_sock *tp =3D tcp_sk(sk);
> >  	const struct tcphdr *th =3D tcp_hdr(skb);
> >  	__u32 cookie =3D ntohl(th->ack_seq) - 1;
> > +	const struct request_sock_ops *ops;
> >  	struct sock *ret =3D sk;
> >  	struct request_sock *req;
> >  	int mss;
> > @@ -326,12 +327,27 @@ struct sock *cookie_v4_check(struct sock *sk, str=
uct sk_buff *skb)
> >  		goto out;
> >  =

> >  	ret =3D NULL;
> > -	req =3D inet_reqsk_alloc(&tcp_request_sock_ops, sk, false); /* for sa=
fety */
> > +	ops =3D &tcp_request_sock_ops;
> > +#ifdef CONFIG_MPTCP
> > +	if (sk_is_mptcp(sk))
> > +		ops =3D &mptcp_subflow_request_sock_ops;
> > +#endif
> > +
> > +	req =3D inet_reqsk_alloc(ops, sk, false); /* for safety */
> >  	if (!req)
> >  		goto out;
> >  =

> >  	ireq =3D inet_rsk(req);
> >  	treq =3D tcp_rsk(req);
> > +	treq->is_mptcp =3D sk_is_mptcp(sk);
> > +
> > +	if (treq->is_mptcp) {
> > +		int err =3D mptcp_subflow_init_cookie_req(req, sk, skb);
> > +
> > +		if (err)
> > +			goto out_free;
> > +	}
> > +
> >  	treq->rcv_isn		=3D ntohl(th->seq) - 1;
> >  	treq->snt_isn		=3D cookie;
> >  	treq->ts_off		=3D 0;
> > @@ -350,9 +366,6 @@ struct sock *cookie_v4_check(struct sock *sk, struc=
t sk_buff *skb)
> >  	treq->snt_synack	=3D 0;
> >  	treq->tfo_listener	=3D false;
> >  =

> > -	if (IS_ENABLED(CONFIG_MPTCP))
> > -		treq->is_mptcp =3D 0;
> > -
> >  	if (IS_ENABLED(CONFIG_SMC))
> >  		ireq->smc_ok =3D 0;
> >  =

> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index d8b9d09eb472..5ae612902806 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -6669,6 +6669,7 @@ int tcp_conn_request(struct request_sock_ops *rsk=
_ops,
> >  #if IS_ENABLED(CONFIG_MPTCP)
> >  	tcp_rsk(req)->is_mptcp =3D 0;
> >  #endif
> > +	tcp_rsk(req)->syncookie =3D want_cookie;
> >  =

> >  	tcp_clear_options(&tmp_opt);
> >  	tmp_opt.mss_clamp =3D af_ops->mss_clamp;
> > @@ -6691,9 +6692,6 @@ int tcp_conn_request(struct request_sock_ops *rsk=
_ops,
> >  =

> >  	af_ops->init_req(req, sk, skb);
> >  =

> > -	if (IS_ENABLED(CONFIG_MPTCP) && want_cookie)
> > -		tcp_rsk(req)->is_mptcp =3D 0;
> > -
> >  	if (security_inet_conn_request(sk, skb, req))
> >  		goto drop_and_free;
> >  =

> > diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> > index 13235a012388..0a05c3c1e776 100644
> > --- a/net/ipv6/syncookies.c
> > +++ b/net/ipv6/syncookies.c
> > @@ -134,6 +134,7 @@ struct sock *cookie_v6_check(struct sock *sk, struc=
t sk_buff *skb)
> >  	struct tcp_sock *tp =3D tcp_sk(sk);
> >  	const struct tcphdr *th =3D tcp_hdr(skb);
> >  	__u32 cookie =3D ntohl(th->ack_seq) - 1;
> > +	const struct request_sock_ops *ops;
> >  	struct sock *ret =3D sk;
> >  	struct request_sock *req;
> >  	int mss;
> > @@ -170,7 +171,13 @@ struct sock *cookie_v6_check(struct sock *sk, stru=
ct sk_buff *skb)
> >  		goto out;
> >  =

> >  	ret =3D NULL;
> > -	req =3D inet_reqsk_alloc(&tcp6_request_sock_ops, sk, false);
> > +	ops =3D &tcp6_request_sock_ops;
> > +#ifdef CONFIG_MPTCP
> > +	if (sk_is_mptcp(sk))
> > +		ops =3D &mptcp_subflow_request_sock_ops;
> > +#endif
> > +
> > +	req =3D inet_reqsk_alloc(ops, sk, false);
> >  	if (!req)
> >  		goto out;
> >  =

> > @@ -178,8 +185,12 @@ struct sock *cookie_v6_check(struct sock *sk, stru=
ct sk_buff *skb)
> >  	treq =3D tcp_rsk(req);
> >  	treq->tfo_listener =3D false;
> >  =

> > -	if (IS_ENABLED(CONFIG_MPTCP))
> > -		treq->is_mptcp =3D 0;
> > +	if (treq->is_mptcp) {
> > +		int err =3D mptcp_subflow_init_cookie_req(req, sk, skb);
> > +
> > +		if (err)
> > +			goto out_free;
> > +	}
> =

> It looks like 'treq->is_mptcp' is not initialized here ?

Yep, I just hit a "KASAN: slab-out-of-bounds in __subflow_init_req" due to =
that.


Christoph

> =

> What about moving the whole oops selection, init_reqsk_alloc() call,
> is_mptcp init and mptcp_subflow_init_cookie_req() call in an header
> only helper? (say tcp_reqsk_alloc() or the like)
> =

> Thanks,
> =

> Paolo
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============1797739074744222609==--
