Content-Type: multipart/mixed; boundary="===============2445347952228368052=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: handle ipv4-mapped ipv6 address.
Date: Tue, 14 Jan 2020 18:40:27 +0100
Message-ID: <8316dd7d4d80251bf962e82209f69eb42e4fd332.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.2001131832140.13253@ndoyal-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3353

--===============2445347952228368052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-01-13 at 18:39 -0800, Mat Martineau wrote:
> On Mon, 13 Jan 2020, Paolo Abeni wrote:
> =

> > The TCP code unconditionally overwrite in a few places 'icsk->icsk_af_o=
ps',
> > which lead to the wrong oops being called for ipv4-mapped ipv6 address.
> > e.g. Kasan notice a invalid slub access running packetdrill ipv4-mapped
> > tests.
> > =

> > This patch try to address the issue building ipv4-mapped  mptcp icsk ops
> > and using it when appropriate. Still needs quite a bit of work:
> > =

> > - kasan still notice an use after free at netns cleanup time
> >  (for the ns struct ???)
> > - squashing
> > =

> > ANy feedback more than welcome!
> > ---
> > include/net/mptcp.h |  2 ++
> > net/ipv6/tcp_ipv6.c |  5 ++++
> > net/mptcp/subflow.c | 66 +++++++++++++++++++++++++++++++++++++++++----
> > 3 files changed, 68 insertions(+), 5 deletions(-)
> > =

> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index f65baeacf199..27627e2d1bc2 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -174,6 +174,8 @@ static inline bool mptcp_skb_can_collapse(const str=
uct sk_buff *to,
> > =

> > #endif /* CONFIG_MPTCP */
> > =

> > +void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped);
> > +
> > #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > int mptcpv6_init(void);
> > #elif IS_ENABLED(CONFIG_IPV6)
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 60068ffde1d9..522d16d70210 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -238,6 +238,9 @@ static int tcp_v6_connect(struct sock *sk, struct s=
ockaddr *uaddr,
> > 		sin.sin_addr.s_addr =3D usin->sin6_addr.s6_addr32[3];
> > =

> > 		icsk->icsk_af_ops =3D &ipv6_mapped;
> > +		if (sk_is_mptcp(sk))
> > +			mptcp_handle_ipv6_mapped(sk, true);
> > +
> =

> I think we could get maintainer feedback about assigning icsk->icsk_af_op=
s =

> multiple times. An option is to create an inlineable helper function that =

> returns the appropriate value to assign (and does the other =

> mptcp_handle_ipv6_mapped() stuff).

double checking I got the obove correctly. Your suggestion is something
alike the following lines:
---
static inline struct inet_connection_sock_af_ops *
tcp_ipv6_mapped_ops(struct sock *sk)
{
	if (!sk_is_mptcp(sk))
		return &ipv6_mapped;
	return mptcp_mapped_ops(sk);
}


// ...
	icsk->icsk_af_ops =3D tcp_ipv6_mapped_ops(sk);
---

plus something similar to reset the ops on error, right?

I personally don't think setting twice icsk_af_ops should be an issue:
it happens only when the socket can't receive/transmit any packet under
the socket lock - should be safe - and in a somewhat uncommon control
path scenario - performances do not matter much. Do you have strong
feeling about this?

Thanks,

Paolo

--===============2445347952228368052==--
