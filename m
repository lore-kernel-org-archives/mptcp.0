Content-Type: multipart/mixed; boundary="===============1022728493637103148=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC] net/mptcp: rcu-ify the subflow context
Date: Thu, 19 Sep 2019 18:08:00 +0200
Message-ID: <2ae1030d601a904f1484c3a384845866ff589845.camel@redhat.com>
In-Reply-To: 529de6ddb5b240acb2c62067e1ea93a8b6188ef2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1886

--===============1022728493637103148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-13 at 17:54 +0200, Paolo Abeni wrote:
> On Mon, 2019-09-02 at 17:24 +0200, Davide Caratti wrote:
> > make sure to wait a grace period before freeing the subflow context. See
> > also net-next commit 72f21c741e86 ("net/tls: use RCU protection on
> > icsk->icsk_ulp_data")
> > =

> > Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> > --

[...]

> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 991ad288b892..b201e1410219 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -197,13 +197,14 @@ struct subflow_context {
> >  	struct  sock *conn;        /* parent mptcp_sock */
> >  =

> >  	void	(*tcp_sk_data_ready)(struct sock *sk);
> > +	struct	rcu_head rcu;
> >  };
> >  =

> >  static inline struct subflow_context *subflow_ctx(const struct sock *s=
k)
> >  {
> >  	struct inet_connection_sock *icsk =3D inet_csk(sk);
> > -
> > -	return (struct subflow_context *)icsk->icsk_ulp_data;
> > +	/* Use RCU on icsk_ulp_data only for sock diag code */
> > +	return (__force struct subflow_context *)icsk->icsk_ulp_data;
> >  }
> >  =

> >  static inline struct socket *
> =

> The patch looks fine, but I'm still wondering if we should try to be
> more conservative here, using something alike:
> =

> 	return rcu_dereference_protected(icsk->icsk_ulp_data,
> 		lockdep_sock_is_held((struct sock *)icsk))
> =

> and fixing the eventual lockdep splat explcitily
> =

> (possibly we may need a different/additional condition for
> rcu_dereference_protected() based  on icsk refcnt)

this is for sure, because the socket lock for icsk is often not held when
subflow_ctx() is called. Nevertheless, icsk_ulp_data is a valid pointer in
all the traffic path of MPTCP (and it keeps the same value until it's
freed at the enf of the grace period). Should we do a function that does
the atomic read of sk_refcnt when lockdep is on? =


--
davide


--===============1022728493637103148==--
