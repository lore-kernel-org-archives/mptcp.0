Content-Type: multipart/mixed; boundary="===============1897537819018790939=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 1/2] mptcp: Export low-level routines for IPv6
Date: Thu, 17 Oct 2019 11:40:47 +0200
Message-ID: <20191017094047.GW25052@breakpoint.cc>
In-Reply-To: 6d88a1f22660614c3b22f2cb892386af6244e76f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2205

--===============1897537819018790939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > -static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff =
*skb)
> > +void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
> >  {
> >  	struct dst_entry *dst =3D skb_dst(skb);
> >  =

> > @@ -111,6 +111,7 @@ static void inet6_sk_rx_dst_set(struct sock *sk, co=
nst struct sk_buff *skb)
> >  		tcp_inet6_sk(sk)->rx_dst_cookie =3D rt6_get_cookie(rt);
> >  	}
> >  }
> > +EXPORT_SYMBOL(inet6_sk_rx_dst_set);
> =

> I think this is not needed, as we don't build mptcp as a module.
> Dropping the 'static' scope should suffice. This should apply also to
> tcp_request_sock_ipv6_ops, tcp_v6_syn_recv_sock and ipv6_specific
> below.

Yes, but ipv6 can be built as a module, i.e. mptcp cannot call any ipv6
related symbol directly.

This will need rather ugly indirections, similar to
include/linux/netfilter_ipv6.h / "struct nf_ipv6_ops".
--===============1897537819018790939==--
