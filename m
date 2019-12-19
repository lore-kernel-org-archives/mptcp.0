Content-Type: multipart/mixed; boundary="===============6643607937643841735=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] Squash-to: "tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions"
Date: Thu, 19 Dec 2019 09:49:20 +0100
Message-ID: <95f7be0ae459a86156125ab08887e7455151a14d.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1912181557200.32925@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 3172

--===============6643607937643841735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-18 at 16:37 -0800, Mat Martineau wrote:
> On Thu, 19 Dec 2019, Paolo Abeni wrote:
> =

> > Allow coalescing when mptcp extensions are equal or 'from' lacks such e=
xtensions.
> > =

> > Note: we could be a little less restrictive allowing coalescing with
> > different data_ack, but this simplify the code a bit, we can improve
> > later and at least mptcp_net-next do not generate almost identical
> > DSS with different data_ack.
> =

> Right, could use the newer data_ack if they're close enough to each other =

> that it's unambiguous. Would have to potentially handle a mix of 32- and =

> 64-bit data_acks though (I've had to work through some details with that =

> for DATA_FIN).
> =

> > With the above assumption, we don't need any special action when
> > moving bits from skb1 to skb2, as the mapping in skb2 will already
> > fit, and mapping in skb1 will be dropped as/if needed.
> > =

> > When coalescing to a newly allocated skb, we transfer the relevant
> > extension to. An MPTCP specific helper is added for that goal,
> > possibly we could use/create a generic one.
> > =

> > Completely untested, just to collect early feedback.
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > include/net/mptcp.h  | 38 ++++++++++++++++++++++++++++++++++++++
> > include/net/tcp.h    |  2 +-
> > net/ipv4/tcp_input.c |  9 +++++----
> > 3 files changed, 44 insertions(+), 5 deletions(-)
> > =

> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index 43ddfdf9e4a3..8a702e7566e6 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -27,17 +27,55 @@ struct mptcp_ext {
> > =

> > #ifdef CONFIG_MPTCP
> > =

> > +static inline void mptcp_skb_ext_move(struct sk_buff *to,
> > +				      const struct sk_buff *from)
> > +{
> > +	skb_ext_put(to);
> =

> We don't want to accidentally free the ext. Since the refcount is part of =

> the ext (not the skb), better to leave it unchanged. It may or may not be =

> referenced by other skbs.
> =

> > +
> > +	to->active_extensions =3D from->active_extensions;
> > +	to->extensions =3D from->extensions;
> > +	from->extensions =3D NULL;
> > +	from->active_extensions =3D 0;
> > +}
> =

> For the "move" case, do we care if there are active non-MPTCP extensions?

Note that we call/use the move helper when 'to' is newly allocated,
perhaps better make it clear with a:

if (WARN_ON_ONCE(to->active_extensions))
	skb_ext_put(to);

?

> =

> > +
> > static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
> > {
> > 	return skb_ext_exist(skb, SKB_EXT_MPTCP);
> > }
> > =

> > +static inline bool mptcp_ext_matches(const struct mptcp_ext *to_ext,
> > +				     const struct mptcp_ext *from_ext)
> > +{
> > +	return !memcmp(&from_ext->data_seq, &to_ext->data_seq);
> =

> Going to chalk this one up to late-night coding :) (missing size param).
> =

> Is the intent to check the whole struct? Should be safe since we clear al=
l =

> the bits in mptcp_incoming_options.
> =

> > +}
> > +
> > +static inline bool mptcp_skb_can_collapse(const struct sk_buff *to,
> > +					  const struct sk_buff *from)
> > +{
> > +	const struct mptcp_ext *from_ext =3D skb_ext_find(from, SKB_EXT_MPTCP=
);
> > +	const struct mptcp_ext *to_ext =3D skb_ext_find(to, SKB_EXT_MPTCP);
> > +
> > +	return !from_ext || (to_ext && mptcp_ext_matches(to_ext, from_ext));
> > +}
> > +
> > #else
> > =

> > +static inline void mptcp_skb_ext_move(struct sk_buff *to,
> > +				      const struct sk_buff *from)
> > +{
> > +}
> > +
> > static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
> > {
> > 	return false;
> > }
> > =

> > +static inline bool mptcp_skb_can_collapse(const struct sk_buff *to,
> > +					  const struct sk_buff *from)
> > +{
> > +	return true;
> > +}
> > +
> > +
> > #endif /* CONFIG_MPTCP */
> > #endif /* __NET_MPTCP_H */
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index c483c73b8d41..f4cddd42d52a 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -983,7 +983,7 @@ static inline bool tcp_skb_can_collapse(const struc=
t sk_buff *to,
> > 					const struct sk_buff *from)
> > {
> > 	return likely(tcp_skb_can_collapse_to(to) &&
> > -		      !mptcp_skb_ext_exist(from));
> > +		      mptcp_skb_can_collapse(to, from));
> > }
> > =

> > /* Events passed to congestion control interface */
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 55b460a2ece2..1c96c545a23a 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -4420,7 +4420,7 @@ static bool tcp_try_coalesce(struct sock *sk,
> > 	if (TCP_SKB_CB(from)->seq !=3D TCP_SKB_CB(to)->end_seq)
> > 		return false;
> > =

> > -	if (mptcp_skb_ext_exist(from))
> > +	if (mptcp_skb_can_collapse(to, from))
> =

> if (!mptcp_skb_can_collapse(to, from))
> =

> > 		return false;
> > =

> > #ifdef CONFIG_TLS_DEVICE
> > @@ -4931,12 +4931,12 @@ tcp_collapse(struct sock *sk, struct sk_buff_he=
ad *list, struct rb_root *root,
> > =

> > 		/* The first skb to collapse is:
> > 		 * - not SYN/FIN and
> > -		 * - does not include a MPTCP skb extension
> > +		 * - MPTCP allow collapsing with the next one, if any
> > 		 * - bloated or contains data before "start" or
> > 		 *   overlaps to the next one.
> > 		 */
> > 		if (!(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
> > -		    !mptcp_skb_ext_exist(skb) &&
> > +		    (!n || mptcp_skb_can_collapse(n, skb)) &&
> =

> The !n check could be inside mptcp_skb_can_collapse, it's inline so more =

> readable and no overhead.
> =

> > 		    (tcp_win_from_space(sk, skb->truesize) > skb->len ||
> > 		     before(TCP_SKB_CB(skb)->seq, start))) {
> > 			end_of_skbs =3D false;
> > @@ -4976,6 +4976,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
> > 		else
> > 			__skb_queue_tail(&tmp, nskb); /* defer rbtree insertion */
> > 		skb_set_owner_r(nskb, sk);
> > +		mptcp_skb_ext_move(nskb, skb);
> > =

> > 		/* Copy data, releasing collapsed skbs. */
> > 		while (copy > 0) {
> > @@ -4995,7 +4996,7 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
> > 				skb =3D tcp_collapse_one(sk, skb, list, root);
> > 				if (!skb ||
> > 				    skb =3D=3D tail ||
> > -				    mptcp_skb_ext_exist(skb) ||
> > +				    !mptcp_skb_can_collapse(nskb, skb) ||
> > 				    (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
> > 					goto end;
> > #ifdef CONFIG_TLS_DEVICE
> > -- =

> > 2.21.0
> =

> I think there may have also been a question on the list about coalescing =

> DSS records. =


My take is: don't handle such scenario right now: that will delay part
1, 2 and 3 too much. With this simpler approach I think we can be ready
to re-post by this evening  Mat's time.

Thanks,

Paolo

--===============6643607937643841735==--
