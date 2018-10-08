Content-Type: multipart/mixed; boundary="===============4358232992553641692=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v3 12/16] skbuff: Add private data pointer
Date: Mon, 08 Oct 2018 11:18:55 -0700
Message-ID: <20181008181855.GW36310@MacBook-Pro-19.local>
In-Reply-To: 20181005225918.9786-13-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 781

--===============4358232992553641692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/10/18 - 15:59:14, Mat Martineau wrote:
> Allow struct sk_buff to be optionally extended when the control buffer
> space is insufficient. New pointers for the extended data and associated
> destructor are placed at the end of the data structure and left
> uninitialized so cache behavior of struct sk_buff is unchanged when the
> new pointers are not accessed.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  include/linux/skbuff.h | 16 +++++++++++++++-
>  net/core/skbuff.c      |  5 +++++
>  net/ipv4/tcp_output.c  |  3 +++
>  3 files changed, 23 insertions(+), 1 deletion(-)
> =

> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 17a13e4785fc..5b1f302b1b0f 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -631,6 +631,7 @@ typedef unsigned char *sk_buff_data_t;
>   *	@queue_mapping: Queue mapping for multiqueue devices
>   *	@xmit_more: More SKBs are pending for this queue
>   *	@pfmemalloc: skbuff was allocated from PFMEMALLOC reserves
> + *	@priv_used: priv, priv_copy, and priv_destructor contain valid data
>   *	@ndisc_nodetype: router type (from link layer)
>   *	@ooo_okay: allow the mapping of a socket to a queue to be changed
>   *	@l4_hash: indicate hash is a canonical 4-tuple hash over transport
> @@ -660,6 +661,9 @@ typedef unsigned char *sk_buff_data_t;
>   *	@data: Data head pointer
>   *	@truesize: Buffer size
>   *	@users: User count - see {datagram,tcp}.c
> + *	@priv: Optional pointer to skb private data
> + *	@priv_copy: Private data copy function
> + *	@priv_destructor: Private data destruct function
>   */
>  =

>  struct sk_buff {
> @@ -741,7 +745,8 @@ struct sk_buff {
>  				peeked:1,
>  				head_frag:1,
>  				xmit_more:1,
> -				pfmemalloc:1;
> +				pfmemalloc:1,
> +				priv_used:1;
>  =

>  	/* fields enclosed in headers_start/headers_end are copied
>  	 * using a single memcpy() in __copy_skb_header()
> @@ -856,6 +861,15 @@ struct sk_buff {
>  				*data;
>  	unsigned int		truesize;
>  	refcount_t		users;
> +
> +	/* Uninitialized private pointers. At the very end so they do not
> +	 * affect cache behavior of the rest of struct sk_buff when left
> +	 * unused. All three must be initialized when priv_used is set.
> +	 */
> +	void			*priv;
> +	void			(*priv_copy)(const struct sk_buff *from,
> +					     struct sk_buff *to);
> +	void			(*priv_destructor)(struct sk_buff *skb);
>  };
>  =

>  #ifdef __KERNEL__
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c996c09d095f..b508e9e5e855 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -611,6 +611,10 @@ void skb_release_head_state(struct sk_buff *skb)
>  		WARN_ON(in_irq());
>  		skb->destructor(skb);
>  	}
> +	if (skb->priv_used && skb->priv_destructor) {
> +		WARN_ON(in_irq());
> +		skb->priv_destructor(skb);
> +	}
>  #if IS_ENABLED(CONFIG_NF_CONNTRACK)
>  	nf_conntrack_put(skb_nfct(skb));
>  #endif
> @@ -859,6 +863,7 @@ static struct sk_buff *__skb_clone(struct sk_buff *n,=
 struct sk_buff *skb)
>  	n->nohdr =3D 0;
>  	n->peeked =3D 0;
>  	C(pfmemalloc);
> +	n->priv_used =3D 0;
>  	n->destructor =3D NULL;
>  	C(tail);
>  	C(end);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 780abb11dffd..9e07afd084c3 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1129,6 +1129,9 @@ static int __tcp_transmit_skb(struct sock *sk, stru=
ct sk_buff *skb,
>  				skb =3D pskb_copy(oskb, gfp_mask);
>  			else
>  				skb =3D skb_clone(oskb, gfp_mask);
> +
> +			if (oskb->priv_used && oskb->priv_copy)
> +				oskb->priv_copy(oskb, skb);

Shouldn't this rather be called inside pskb_copy, skb_clone, and friends...=
 ?


Christoph

>  		} tcp_skb_tsorted_restore(oskb);
>  =

>  		if (unlikely(!skb))
> -- =

> 2.19.1
> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============4358232992553641692==--
