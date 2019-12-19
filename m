Content-Type: multipart/mixed; boundary="===============4588195665243947238=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] Squash-to: "tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions"
Date: Thu, 19 Dec 2019 02:54:37 +0100
Message-ID: <20191219015437.GA795@breakpoint.cc>
In-Reply-To: 314e347a145fcfd34a69b7775aa162d46869a016.1576712629.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3170

--===============4588195665243947238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:

I think this looks good, thanks Paolo!

Some comments below.

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 43ddfdf9e4a3..8a702e7566e6 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -27,17 +27,55 @@ struct mptcp_ext {
>  =

>  #ifdef CONFIG_MPTCP
>  =

> +static inline void mptcp_skb_ext_move(struct sk_buff *to,
> +				      const struct sk_buff *from)
> +{
> +	skb_ext_put(to);
> +
> +	to->active_extensions =3D from->active_extensions;
> +	to->extensions =3D from->extensions;
> +	from->extensions =3D NULL;
> +	from->active_extensions =3D 0;
> +}

You can remove the '=3D NULL' assignment, @to is free'd and ext core
doesn't look at ->extensions if active_extensions =3D=3D 0.

>  static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
>  {
>  	return skb_ext_exist(skb, SKB_EXT_MPTCP);
>  }
>  =

> +static inline bool mptcp_ext_matches(const struct mptcp_ext *to_ext,
> +				     const struct mptcp_ext *from_ext)
> +{
> +	return !memcmp(&from_ext->data_seq, &to_ext->data_seq);

Is this supposed to be

	return !memcmp(from_ext, to_ext, sizeof(*to_ext));
or
	return from_ext->data_seq =3D=3D to_ext->data_seq;

?

I assume its the former?

Maybe make this

return to_ext =3D=3D from_ext ||
       (to_ext && from_ext && memcmp(...) =3D=3D 0);

> +static inline bool mptcp_skb_can_collapse(const struct sk_buff *to,
> +					  const struct sk_buff *from)
> +{
> +	const struct mptcp_ext *from_ext =3D skb_ext_find(from, SKB_EXT_MPTCP);
> +	const struct mptcp_ext *to_ext =3D skb_ext_find(to, SKB_EXT_MPTCP);
> +
> +	return !from_ext || (to_ext && mptcp_ext_matches(to_ext, from_ext));

I would prefer to handle 'to =3D=3D NULL' in mptcp_ext_matches, see below.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index c483c73b8d41..f4cddd42d52a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -983,7 +983,7 @@ static inline bool tcp_skb_can_collapse(const struct =
sk_buff *to,
>  					const struct sk_buff *from)
>  {
>  	return likely(tcp_skb_can_collapse_to(to) &&
> -		      !mptcp_skb_ext_exist(from));
> +		      mptcp_skb_can_collapse(to, from));
>  }
>  =

>  /* Events passed to congestion control interface */
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 55b460a2ece2..1c96c545a23a 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4420,7 +4420,7 @@ static bool tcp_try_coalesce(struct sock *sk,
>  	if (TCP_SKB_CB(from)->seq !=3D TCP_SKB_CB(to)->end_seq)
>  		return false;
>  =

> -	if (mptcp_skb_ext_exist(from))
> +	if (mptcp_skb_can_collapse(to, from))
>  		return false;
>  =

>  #ifdef CONFIG_TLS_DEVICE
> @@ -4931,12 +4931,12 @@ tcp_collapse(struct sock *sk, struct sk_buff_head=
 *list, struct rb_root *root,
>  =

>  		/* The first skb to collapse is:
>  		 * - not SYN/FIN and
> -		 * - does not include a MPTCP skb extension
> +		 * - MPTCP allow collapsing with the next one, if any
>  		 * - bloated or contains data before "start" or
>  		 *   overlaps to the next one.
>  		 */
>  		if (!(TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)) &&
> -		    !mptcp_skb_ext_exist(skb) &&
> +		    (!n || mptcp_skb_can_collapse(n, skb)) &&

mptcp_skb_can_collapse(skb, n)) ?
(n is the next skb in the tcp sequence space).

Also, there is a second check after this:

   if (end_of_skbs || mptcp_skb_ext_exist(skb) ||
      (TCP_SKB_CB(skb)->tcp_flags & (TCPHDR_SYN | TCPHDR_FIN)))
	  return;

I was worried about following scenario:

A)
1. skb has no mapping
2. next skb has one

B)
or
1. skb has no mapping
2. next skb has no mapping
3. but next skb has one

It took me some time to figure out that your mptcp_skb_can_collapse()
will not allow

'end_of_skbs =3D=3D false AND skb-has-no-mapping AND next-skb-has-one'

to happen, and last check in copy loop will allow coalesce of
1 and 2 in B), but will stop when encountering #3.

Maybe there should be a comment explaining mptcp coalesce rule/invariants
here or in mptcp_skb_can_collapse()?

Maybe something like:

/* mptcp_skb_can_collapse - check if skbs can be collapsed
 *
 * mptcp collapse is allowed if neither @to or @from
 * carry an mptcp data mapping, or if the extension of @to
 * is the same as @from.
 * Collapsing is not possible if @to lacks an extension, but
 * @from carries one.
 */

--===============4588195665243947238==--
