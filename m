Content-Type: multipart/mixed; boundary="===============3320310988605222140=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 25/25] tcp_md5: Use TCP extra-options on the
 input path
Date: Wed, 29 Nov 2017 10:21:04 -0800
Message-ID: <20171129182104.GS94116@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1711281801250.17380@ddombrow-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 217

--===============3320310988605222140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28/11/17 - 18:04:40, Mat Martineau wrote:
> =

> On Mon, 27 Nov 2017, Christoph Paasch wrote:
> =

> > The checks are now being done through the extra-option framework. For
> > TCP MD5 this means that the check happens a bit later than usual.
> > =

> > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > ---
> > include/linux/tcp_md5.h | 23 +----------------------
> > net/ipv4/tcp_ipv4.c     |  9 ---------
> > net/ipv4/tcp_md5.c      | 29 ++++++++++++++++++++++++-----
> > net/ipv6/tcp_ipv6.c     |  9 ---------
> > 4 files changed, 25 insertions(+), 45 deletions(-)
> =

> There's a lingering #ifdef CONFIG_TCP_MD5SIG in tcp_input.c as well, shou=
ld
> that go away too?

Damn, nice catch :)

As you see, I hadn't tested yet ;-)


Christoph

> =

> Mat
> =

> =

> > =

> > diff --git a/include/linux/tcp_md5.h b/include/linux/tcp_md5.h
> > index 377552b2396b..b28534831483 100644
> > --- a/include/linux/tcp_md5.h
> > +++ b/include/linux/tcp_md5.h
> > @@ -30,30 +30,9 @@ struct tcp_md5sig_key {
> > int tcp_md5_parse_keys(struct sock *sk, int optname, char __user *optva=
l,
> > 		       int optlen);
> > =

> > -bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> > -			     const struct sk_buff *skb);
> > -
> > -bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> > -			     const struct sk_buff *skb);
> > -
> > int tcp_md5_diag_get_aux(struct sock *sk, bool net_admin, struct sk_buf=
f *skb);
> > =

> > int tcp_md5_diag_get_aux_size(struct sock *sk, bool net_admin);
> > =

> > -#else
> > -
> > -static inline bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> > -					   const struct sk_buff *skb)
> > -{
> > -	return false;
> > -}
> > -
> > -static inline bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> > -					   const struct sk_buff *skb)
> > -{
> > -	return false;
> > -}
> > -
> > -#endif
> > -
> > +#endif /* CONFIG_TCP_MD5SIG */
> > #endif /* _LINUX_TCP_MD5_H */
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 6987003f2db7..c578eb16b388 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -62,7 +62,6 @@
> > #include <linux/init.h>
> > #include <linux/times.h>
> > #include <linux/slab.h>
> > -#include <linux/tcp_md5.h>
> > =

> > #include <net/net_namespace.h>
> > #include <net/icmp.h>
> > @@ -1238,11 +1237,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > 		struct sock *nsk;
> > =

> > 		sk =3D req->rsk_listener;
> > -		if (unlikely(tcp_v4_inbound_md5_hash(sk, skb))) {
> > -			sk_drops_add(sk, skb);
> > -			reqsk_put(req);
> > -			goto discard_it;
> > -		}
> > 		if (unlikely(sk->sk_state !=3D TCP_LISTEN)) {
> > 			inet_csk_reqsk_queue_drop_and_put(sk, req);
> > 			goto lookup;
> > @@ -1277,9 +1271,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > 	if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb))
> > 		goto discard_and_relse;
> > =

> > -	if (tcp_v4_inbound_md5_hash(sk, skb))
> > -		goto discard_and_relse;
> > -
> > 	nf_reset(skb);
> > =

> > 	if (tcp_filter(sk, skb))
> > diff --git a/net/ipv4/tcp_md5.c b/net/ipv4/tcp_md5.c
> > index f25504c822e7..c9400b7b96ea 100644
> > --- a/net/ipv4/tcp_md5.c
> > +++ b/net/ipv4/tcp_md5.c
> > @@ -29,6 +29,10 @@ static DEFINE_PER_CPU(struct tcp_md5sig_pool, tcp_md=
5sig_pool);
> > static DEFINE_MUTEX(tcp_md5sig_mutex);
> > static bool tcp_md5sig_pool_populated;
> > =

> > +static bool tcp_inbound_md5_hash(struct sock *sk, const struct sk_buff=
 *skb,
> > +				 struct tcp_options_received *opt_rx,
> > +				 struct tcp_extra_option_store *store);
> > +
> > static unsigned int tcp_md5_extra_option_prepare(struct sk_buff *skb, u=
8 flags,
> > 						 unsigned int remaining,
> > 						 struct tcp_out_options *opts,
> > @@ -71,6 +75,7 @@ struct tcp_md5_extra_option {
> > =

> > static const struct tcp_extra_option_ops tcp_md5_extra_ops =3D {
> > 	.option_kind		=3D TCPOPT_MD5SIG,
> > +	.check			=3D tcp_inbound_md5_hash,
> > 	.prepare		=3D tcp_md5_extra_option_prepare,
> > 	.write			=3D tcp_md5_extra_option_write,
> > 	.response_prepare	=3D tcp_md5_send_response_prepare,
> > @@ -902,8 +907,8 @@ static struct tcp_md5sig_key *tcp_v4_md5_lookup(con=
st struct sock *sk,
> > }
> > =

> > /* Called with rcu_read_lock() */
> > -bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> > -			     const struct sk_buff *skb)
> > +static bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> > +				    const struct sk_buff *skb)
> > {
> > 	/* This gets called for each TCP segment that arrives
> > 	 * so we want to be efficient.
> > @@ -957,8 +962,8 @@ bool tcp_v4_inbound_md5_hash(const struct sock *sk,
> > }
> > =

> > #if IS_ENABLED(CONFIG_IPV6)
> > -bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> > -			     const struct sk_buff *skb)
> > +static bool tcp_v6_inbound_md5_hash(const struct sock *sk,
> > +				    const struct sk_buff *skb)
> > {
> > 	const __u8 *hash_location =3D NULL;
> > 	struct tcp_md5sig_key *hash_expected;
> > @@ -1000,7 +1005,6 @@ bool tcp_v6_inbound_md5_hash(const struct sock *s=
k,
> > =

> > 	return false;
> > }
> > -EXPORT_SYMBOL_GPL(tcp_v6_inbound_md5_hash);
> > =

> > static struct tcp_md5sig_key *tcp_v6_md5_lookup(const struct sock *sk,
> > 						const struct sock *addr_sk)
> > @@ -1010,6 +1014,21 @@ static struct tcp_md5sig_key *tcp_v6_md5_lookup(=
const struct sock *sk,
> > EXPORT_SYMBOL_GPL(tcp_v6_md5_lookup);
> > #endif
> > =

> > +static bool tcp_inbound_md5_hash(struct sock *sk, const struct sk_buff=
 *skb,
> > +				 struct tcp_options_received *opt_rx,
> > +				 struct tcp_extra_option_store *store)
> > +{
> > +	if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> > +		return tcp_v4_inbound_md5_hash(sk, skb);
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +	} else {
> > +		return tcp_v6_inbound_md5_hash(sk, skb);
> > +#endif
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > static void tcp_diag_md5sig_fill(struct tcp_diag_md5sig *info,
> > 				 const struct tcp_md5sig_key *key)
> > {
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index 6e5bd3c51b4b..367db77b8bf2 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -43,7 +43,6 @@
> > #include <linux/ipv6.h>
> > #include <linux/icmpv6.h>
> > #include <linux/random.h>
> > -#include <linux/tcp_md5.h>
> > =

> > #include <net/tcp.h>
> > #include <net/ndisc.h>
> > @@ -1174,11 +1173,6 @@ static int tcp_v6_rcv(struct sk_buff *skb)
> > =

> > 		sk =3D req->rsk_listener;
> > 		tcp_v6_fill_cb(skb, hdr, th);
> > -		if (tcp_v6_inbound_md5_hash(sk, skb)) {
> > -			sk_drops_add(sk, skb);
> > -			reqsk_put(req);
> > -			goto discard_it;
> > -		}
> > 		if (unlikely(sk->sk_state !=3D TCP_LISTEN)) {
> > 			inet_csk_reqsk_queue_drop_and_put(sk, req);
> > 			goto lookup;
> > @@ -1213,9 +1207,6 @@ static int tcp_v6_rcv(struct sk_buff *skb)
> > =

> > 	tcp_v6_fill_cb(skb, hdr, th);
> > =

> > -	if (tcp_v6_inbound_md5_hash(sk, skb))
> > -		goto discard_and_relse;
> > -
> > 	if (tcp_filter(sk, skb))
> > 		goto discard_and_relse;
> > 	th =3D (const struct tcphdr *)skb->data;
> > -- =

> > 2.15.0
> > =

> > =

> =

> --
> Mat Martineau
> Intel OTC

--===============3320310988605222140==--
