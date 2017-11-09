Content-Type: multipart/mixed; boundary="===============2636056989990135648=="
MIME-Version: 1.0
From: cpaasch at apple.com
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Thu, 09 Nov 2017 13:48:03 +0900
Message-ID: <20171109044803.GA87737@Chimay.local>
In-Reply-To: HE1PR0501MB223522222BDDAE746291152BB0570@HE1PR0501MB2235.eurprd05.prod.outlook.com
X-Status: 
X-Keywords:                  
X-UID: 167

--===============2636056989990135648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/11/17 - 04:32:54, Boris Pismenny wrote:
> +Ilya and Liran
> =

> Hi,
> =

> > -----Original Message-----
> > From: cpaasch(a)apple.com [mailto:cpaasch(a)apple.com]
> > Sent: Thursday, November 09, 2017 13:13
> > To: Mat Martineau <mathew.j.martineau(a)linux.intel.com>; Boris Pismenny
> > <borisp(a)mellanox.com>
> > Cc: mptcp(a)lists.01.org
> > Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
> > =

> > +Boris
> > =

> > On 20/10/17 - 16:02:31, Mat Martineau wrote:
> > > The sk_buff control buffer is of limited size, and cannot be enlarged
> > > without significant impact on systemwide memory use. However, additio=
nal
> > > per-packet state is needed for some protocols, like Multipath TCP.
> > >
> > > An optional shared control buffer placed after the normal struct
> > > skb_shared_info can accomodate the necessary state without imposing
> > > extra memory usage or code changes on normal struct sk_buff
> > > users. __alloc_skb will now place a skb_shared_info_ext structure at
> > > skb->end when given the SKB_ALLOC_SHINFO_EXT flag. Most users of stru=
ct
> > > sk_buff continue to use the skb_shinfo() macro to access shared
> > > info. skb_shinfo(skb)->is_ext is set if the extended structure is
> > > available, and cleared if it is not.
> > >
> > > pskb_expand_head will preserve the shared control buffer if it is pre=
sent.
> > >
> > > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > > ---
> > >  include/linux/skbuff.h | 24 +++++++++++++++++++++-
> > >  net/core/skbuff.c      | 56 ++++++++++++++++++++++++++++++++++++++--=
-----
> > -----
> > >  2 files changed, 66 insertions(+), 14 deletions(-)
> > =

> > Boris, below is the change I mentioned to you.
> > =

> > It allows to allocate 48 additional bytes on-demand after skb_shared_in=
fo.
> > As it is on-demand, it won't increase the size of the skb for other use=
rs.
> > =

> > For example, TLS could start using it when it creates the skb that it
> > pushes down to the TCP-stack. That way you don't need to handle the
> > tls_record lists.
> > =

> =

> One small problem is that TLS doesn't create SKBs. As a ULP it calls the =
transport send
> Functions (do_tcp_sendpages for TLS). This function receives a page and n=
ot a SKB.

yes, that's a good point. Mat has another patch as part of this series,
that adds an skb-arg to sendpages
(https://lists.01.org/pipermail/mptcp/2017-October/000130.html)

That should do the job for you.

> We decided not to create the SKB outside of the TCP layer to reduce the n=
umber of
> changes we made to TCP.
> =

> It would be nice if we could use something like that. Did you talk to Dav=
eM about
> upstreaming this?

No, we didn't talk yet to anyone outside of this list here about it.

We were looking for a user of it outside of MPTCP but couldn't find one.
Now, it seems like we found one that would be interested :)


I think this infrastructure here would simplify your code quite a bit, no?

> We will definitely find it useful for the receive side, there we allocate=
 the SKB in the driver.

Interesting! So even there you could use it. We were under the impression
that it would be of less interest for the receive-side.


Christoph

> =

> > See below for the rest of the patch.
> > =

> > =

> > Christoph
> > =

> > =

> > >
> > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > index 03634ec2f918..873910c66df9 100644
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -489,7 +489,8 @@ int skb_zerocopy_iter_stream(struct sock *sk, str=
uct
> > sk_buff *skb,
> > >   * the end of the header data, ie. at skb->end.
> > >   */
> > >  struct skb_shared_info {
> > > -	__u8		__unused;
> > > +	__u8		is_ext:1,
> > > +			__unused:7;
> > >  	__u8		meta_len;
> > >  	__u8		nr_frags;
> > >  	__u8		tx_flags;
> > > @@ -530,6 +531,24 @@ struct skb_shared_info {
> > >  #define SKB_DATAREF_MASK ((1 << SKB_DATAREF_SHIFT) - 1)
> > >
> > >
> > > +/* This is an extended version of skb_shared_info, also invariant ac=
ross
> > > + * clones and living at the end of the header data.
> > > + */
> > > +struct skb_shared_info_ext {
> > > +	/* skb_shared_info must be the first member */
> > > +	struct skb_shared_info	shinfo;
> > > +
> > > +	/* This is the shared control buffer. It is similar to sk_buff's
> > > +	 * control buffer, but is shared across clones. It must not be
> > > +	 * modified when multiple sk_buffs are referencing this structure.
> > > +	 */
> > > +	char			shcb[48];
> > > +};
> > > +
> > > +#define SKB_SHINFO_EXT_OVERHEAD	\
> > > +	(SKB_DATA_ALIGN(sizeof(struct skb_shared_info_ext)) - \
> > > +	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
> > > +
> > >  enum {
> > >  	SKB_FCLONE_UNAVAILABLE,	/* skb has no fclone (from head_cache)
> > */
> > >  	SKB_FCLONE_ORIG,	/* orig skb (from fclone_cache) */
> > > @@ -856,6 +875,7 @@ struct sk_buff {
> > >  #define SKB_ALLOC_FCLONE	0x01
> > >  #define SKB_ALLOC_RX		0x02
> > >  #define SKB_ALLOC_NAPI		0x04
> > > +#define SKB_ALLOC_SHINFO_EXT	0x08
> > >
> > >  /* Returns true if the skb was allocated from PFMEMALLOC reserves */
> > >  static inline bool skb_pfmemalloc(const struct sk_buff *skb)
> > > @@ -1271,6 +1291,8 @@ static inline unsigned int skb_end_offset(const
> > struct sk_buff *skb)
> > >
> > >  /* Internal */
> > >  #define skb_shinfo(SKB)	((struct skb_shared_info
> > *)(skb_end_pointer(SKB)))
> > > +#define skb_shinfo_ext(SKB)	\
> > > +	((struct skb_shared_info_ext *)(skb_end_pointer(SKB)))
> > >
> > >  static inline struct skb_shared_hwtstamps *skb_hwtstamps(struct sk_b=
uff
> > *skb)
> > >  {
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index 40717501cbdd..397edd5c0613 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -166,6 +166,8 @@ static void *__kmalloc_reserve(size_t size, gfp_t
> > flags, int node,
> > >   *		instead of head cache and allocate a cloned (child) skb.
> > >   *		If SKB_ALLOC_RX is set, __GFP_MEMALLOC will be used for
> > >   *		allocations in case the data is required for writeback
> > > + *		If SKB_ALLOC_SHINFO_EXT is set, the skb will be allocated
> > > + *		with an extended shared info struct.
> > >   *	@node: numa node to allocate memory on
> > >   *
> > >   *	Allocate a new &sk_buff. The returned buffer has no headroom and a
> > > @@ -179,9 +181,9 @@ struct sk_buff *__alloc_skb(unsigned int size, gf=
p_t
> > gfp_mask,
> > >  			    int flags, int node)
> > >  {
> > >  	struct kmem_cache *cache;
> > > -	struct skb_shared_info *shinfo;
> > >  	struct sk_buff *skb;
> > >  	u8 *data;
> > > +	unsigned int shinfo_size;
> > >  	bool pfmemalloc;
> > >
> > >  	cache =3D (flags & SKB_ALLOC_FCLONE)
> > > @@ -199,18 +201,22 @@ struct sk_buff *__alloc_skb(unsigned int size,
> > gfp_t gfp_mask,
> > >  	/* We do our best to align skb_shared_info on a separate cache
> > >  	 * line. It usually works because kmalloc(X > SMP_CACHE_BYTES) gives
> > >  	 * aligned memory blocks, unless SLUB/SLAB debug is enabled.
> > > -	 * Both skb->head and skb_shared_info are cache line aligned.
> > > +	 * Both skb->head and skb_shared_info (or skb_shared_info_ext) are
> > > +	 * cache line aligned.
> > >  	 */
> > >  	size =3D SKB_DATA_ALIGN(size);
> > > -	size +=3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > -	data =3D kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
> > > +	if (flags & SKB_ALLOC_SHINFO_EXT)
> > > +		shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct
> > skb_shared_info_ext));
> > > +	else
> > > +		shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct
> > skb_shared_info));
> > > +	data =3D kmalloc_reserve(size + shinfo_size, gfp_mask, node,
> > &pfmemalloc);
> > >  	if (!data)
> > >  		goto nodata;
> > >  	/* kmalloc(size) might give us more room than requested.
> > >  	 * Put skb_shared_info exactly at the end of allocated zone,
> > >  	 * to allow max possible filling before reallocation.
> > >  	 */
> > > -	size =3D SKB_WITH_OVERHEAD(ksize(data));
> > > +	size =3D ksize(data) - shinfo_size;
> > >  	prefetchw(data + size);
> > >
> > >  	/*
> > > @@ -220,7 +226,10 @@ struct sk_buff *__alloc_skb(unsigned int size, g=
fp_t
> > gfp_mask,
> > >  	 */
> > >  	memset(skb, 0, offsetof(struct sk_buff, tail));
> > >  	/* Account for allocated memory : skb + skb->head */
> > > -	skb->truesize =3D SKB_TRUESIZE(size);
> > > +	if (flags & SKB_ALLOC_SHINFO_EXT)
> > > +		skb->truesize =3D SKB_TRUESIZE(size) +
> > SKB_SHINFO_EXT_OVERHEAD;
> > > +	else
> > > +		skb->truesize =3D SKB_TRUESIZE(size);
> > >  	skb->pfmemalloc =3D pfmemalloc;
> > >  	refcount_set(&skb->users, 1);
> > >  	skb->head =3D data;
> > > @@ -231,10 +240,21 @@ struct sk_buff *__alloc_skb(unsigned int size,
> > gfp_t gfp_mask,
> > >  	skb->transport_header =3D (typeof(skb->transport_header))~0U;
> > >
> > >  	/* make sure we initialize shinfo sequentially */
> > > -	shinfo =3D skb_shinfo(skb);
> > > -	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
> > > -	atomic_set(&shinfo->dataref, 1);
> > > -	kmemcheck_annotate_variable(shinfo->destructor_arg);
> > > +	if (flags & SKB_ALLOC_SHINFO_EXT) {
> > > +		struct skb_shared_info_ext *shinfo_ext =3D skb_shinfo_ext(skb);
> > > +		shinfo_ext->shinfo.is_ext =3D 1;
> > > +		memset(&shinfo_ext->shinfo.meta_len, 0,
> > > +		       offsetof(struct skb_shared_info, dataref) -
> > > +		       offsetof(struct skb_shared_info, meta_len));
> > > +		atomic_set(&shinfo_ext->shinfo.dataref, 1);
> > > +		kmemcheck_annotate_variable(shinfo_ext-
> > >shinfo.destructor_arg);
> > > +		memset(&shinfo_ext->shcb, 0, sizeof(shinfo_ext->shcb));
> > > +	} else {
> > > +		struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > > +		memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
> > > +		atomic_set(&shinfo->dataref, 1);
> > > +		kmemcheck_annotate_variable(shinfo->destructor_arg);
> > > +	}
> > >
> > >  	if (flags & SKB_ALLOC_FCLONE) {
> > >  		struct sk_buff_fclones *fclones;
> > > @@ -1443,6 +1463,7 @@ int pskb_expand_head(struct sk_buff *skb, int
> > nhead, int ntail,
> > >  {
> > >  	int i, osize =3D skb_end_offset(skb);
> > >  	int size =3D osize + nhead + ntail;
> > > +	int shinfo_size;
> > >  	long off;
> > >  	u8 *data;
> > >
> > > @@ -1454,11 +1475,14 @@ int pskb_expand_head(struct sk_buff *skb, int
> > nhead, int ntail,
> > >
> > >  	if (skb_pfmemalloc(skb))
> > >  		gfp_mask |=3D __GFP_MEMALLOC;
> > > -	data =3D kmalloc_reserve(size + SKB_DATA_ALIGN(sizeof(struct
> > skb_shared_info)),
> > > -			       gfp_mask, NUMA_NO_NODE, NULL);
> > > +	if (skb_shinfo(skb)->is_ext)
> > > +		shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct
> > skb_shared_info_ext));
> > > +	else
> > > +		shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct
> > skb_shared_info));
> > > +	data =3D kmalloc_reserve(size + shinfo_size, gfp_mask,
> > NUMA_NO_NODE, NULL);
> > >  	if (!data)
> > >  		goto nodata;
> > > -	size =3D SKB_WITH_OVERHEAD(ksize(data));
> > > +	size =3D ksize(data) - shinfo_size;
> > >
> > >  	/* Copy only real data... and, alas, header. This should be
> > >  	 * optimized for the cases when header is void.
> > > @@ -1468,6 +1492,12 @@ int pskb_expand_head(struct sk_buff *skb, int
> > nhead, int ntail,
> > >  	memcpy((struct skb_shared_info *)(data + size),
> > >  	       skb_shinfo(skb),
> > >  	       offsetof(struct skb_shared_info, frags[skb_shinfo(skb)->nr_f=
rags]));
> > > +	if (skb_shinfo(skb)->is_ext) {
> > > +		int offset =3D offsetof(struct skb_shared_info_ext, shcb);
> > > +		memcpy((struct skb_shared_info_ext *)(data + size + offset),
> > > +		       &skb_shinfo_ext(skb)->shcb,
> > > +		       sizeof(skb_shinfo_ext(skb)->shcb));
> > > +	}
> > >
> > >  	/*
> > >  	 * if shinfo is shared we must drop the old head gracefully, but if=
 it
> > > --
> > > 2.14.2
> > >
> > > _______________________________________________
> > > mptcp mailing list
> > > mptcp(a)lists.01.org
> > >
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli=
sts.0
> > 1.org%2Fmailman%2Flistinfo%2Fmptcp&data=3D02%7C01%7Cborisp%40mellano
> > x.com%7C57765cda687e4c3ab8ed08d527283bd5%7Ca652971c7d2e4d9ba6a4
> > d149256f461b%7C0%7C0%7C636457976113353851&sdata=3DRtZwfWQx%2FSw
> > HoF9miFLpa2r4kA4pf0ta7la6k7F3OZI%3D&reserved=3D0

--===============2636056989990135648==--
