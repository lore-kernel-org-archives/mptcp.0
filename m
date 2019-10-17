Content-Type: multipart/mixed; boundary="===============5506295506543498756=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 1/2] mptcp: Export low-level routines for IPv6
Date: Thu, 17 Oct 2019 12:11:42 +0200
Message-ID: <9a6e5452111c5480e3b38af37e61b36fcbe82f59.camel@redhat.com>
In-Reply-To: 20191017094047.GW25052@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2206

--===============5506295506543498756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-17 at 11:40 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > -static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buf=
f *skb)
> > > +void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
> > >  {
> > >  	struct dst_entry *dst =3D skb_dst(skb);
> > >  =

> > > @@ -111,6 +111,7 @@ static void inet6_sk_rx_dst_set(struct sock *sk, =
const struct sk_buff *skb)
> > >  		tcp_inet6_sk(sk)->rx_dst_cookie =3D rt6_get_cookie(rt);
> > >  	}
> > >  }
> > > +EXPORT_SYMBOL(inet6_sk_rx_dst_set);
> > =

> > I think this is not needed, as we don't build mptcp as a module.
> > Dropping the 'static' scope should suffice. This should apply also to
> > tcp_request_sock_ipv6_ops, tcp_v6_syn_recv_sock and ipv6_specific
> > below.
> =

> Yes, but ipv6 can be built as a module, i.e. mptcp cannot call any ipv6
> related symbol directly.

whoops, I always forgot about that :(

On the plus side, we don't actually need to touch the scope of
tcp_v6_syn_recv_sock and inet6_sk_rx_dst_set, as we can access them via
'ipv6_specific', which we need to access no-matter-what.

On the flip side, hooking mptcpv6_init() in the next patch looks even
more messy :(

What if we make MPTCP IPv6 support depending on IPV6 =3D y ?

Cheers,

Paolo

--===============5506295506543498756==--
