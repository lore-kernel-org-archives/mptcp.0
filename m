Content-Type: multipart/mixed; boundary="===============6512999651146623794=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Mon, 30 Oct 2017 21:17:11 -0700
Message-ID: <20171031041711.GV29152@da0602a-dhcp227.apple.com>
In-Reply-To: alpine.OSX.2.21.1710301530530.5798@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 145

--===============6512999651146623794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 30/10/17 - 15:44:03, Mat Martineau wrote:
> =

> On Sun, 29 Oct 2017, Christoph Paasch wrote:
> =

> > On 23/10/17 - 15:51:26, Mat Martineau wrote:
> > > =

> > > Hi Christoph,
> > > =

> > > On Mon, 23 Oct 2017, Christoph Paasch wrote:
> > > =

> > > > Hello Mat,
> > > > =

> > > > On 20/10/17 - 16:02:31, Mat Martineau wrote:
> > > > > The sk_buff control buffer is of limited size, and cannot be enla=
rged
> > > > > without significant impact on systemwide memory use. However, add=
itional
> > > > > per-packet state is needed for some protocols, like Multipath TCP.
> > > > > =

> > > > > An optional shared control buffer placed after the normal struct
> > > > > skb_shared_info can accomodate the necessary state without imposi=
ng
> > > > > extra memory usage or code changes on normal struct sk_buff
> > > > > users. __alloc_skb will now place a skb_shared_info_ext structure=
 at
> > > > > skb->end when given the SKB_ALLOC_SHINFO_EXT flag. Most users of =
struct
> > > > > sk_buff continue to use the skb_shinfo() macro to access shared
> > > > > info. skb_shinfo(skb)->is_ext is set if the extended structure is
> > > > > available, and cleared if it is not.
> > > > > =

> > > > > pskb_expand_head will preserve the shared control buffer if it is=
 present.
> > > > > =

> > > > > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.co=
m>
> > > > > ---
> > > > >  include/linux/skbuff.h | 24 +++++++++++++++++++++-
> > > > >  net/core/skbuff.c      | 56 ++++++++++++++++++++++++++++++++++++=
++------------
> > > > >  2 files changed, 66 insertions(+), 14 deletions(-)
> > > > =

> > > > While digging through your patch, I realized that there could be on=
e issue.
> > > > =

> > > > In many places in the code we use sizeof(struct skb_shared_info) to=
 compute
> > > > the overhead (e.g., see tcp_sndbuf_expand).
> > > > =

> > > > There are also countless users of (sizeof(struct skb_shared_info) i=
n the
> > > > drivers. They all seem to be in the rx-path, so it should be fine.
> > > > =

> > > > But the prevalent use of skb_shared_info throughout the stack seems=
 a bit
> > > > scary to me. My concern here is that the driver assumes that the ov=
erhead is
> > > > always sizeof(skb_shared_info) and thus underestimates the size of =
the skb.
> > > > =

> > > > At least, in tcp_sndbuf_expand() the overhead-estimation would be w=
rong. I
> > > > don't think the consequences will be catastrophic, but it's somethi=
ng to
> > > > think about.
> > > > =

> > > > =

> > > > What do you think?
> > > > =

> > > =

> > > I saw two typical cases when I looked around existing code:
> > > =

> > > 1. Drivers doing calculations before calling build_skb() on the rx pa=
th.
> > > =

> > > 2. Various code making size estimates before creating skbs.
> > > =

> > > =

> > > For #1, build_skb() is still creating "normal" skbs with skb_shared_i=
nfo, so
> > > their calculations remain valid.
> > > =

> > > Similarly, code that uses size estimates for #2 goes on to allocate "=
normal"
> > > skbs, so their estimates remains valid. Code that allocates extended =
skbs
> > > would need another set of extended skb macros to make better estimate=
s.
> > > =

> > > tcp_sndbuf_expand() is a little different, since it changes sk_sndbuf=
 which
> > > could impact behavior when longer skbs are in use. In this case, it s=
till
> > > seems like a fairly coarse estimate (rounding up to a power of two an=
d then
> > > multiplying). I'm not worried about this use, but I do want to unders=
tand it
> > > better before upstreaming. If it's important to add in the extra spac=
e for
> > > sockets using skb_shared_info_ext, that could be accounted for in
> > > tcp_sndbuf_expand by adding a flag to tcp_sock.
> > =

> > I agree that tcp_sndbuf_expand() should be fine.
> > =

> > > Anywhere that allocates extended skbs will involve new code, and if t=
hat
> > > code needs to make size estimates it should take the extra overhead i=
n to
> > > account. For existing code that may handle (rather than allocate) skb=
s with
> > > extended shared data, these skbs will be truthful about their truesiz=
e and
> > > will be freed correctly.
> > > =

> > > I still want to review this approach carefully and do additional test=
ing. I
> > > should run the patch by some network driver authors too.
> > =

> > How do you want to proceed for submitting it upstream? I fear that with=
out a
> > user of skb_shared_info_ext, netdev won't accept it.
> > =

> > Shouldn't we try to find a user that would benefit from it?
> =

> I was expecting to wait for an MPTCP patch set that would make use of the
> shared control block, but I agree it would be better to find an existing
> struct sk_buff user that would benefit. I'll look around for a protocol w=
ith
> a crowded skb->cb - there could be some cases where there are painful work
> arounds for the size constraints.

Yes, having another user of it is definitely better. I looked a bit through
the code, but couldn't find a good use-case though.


Christoph

> =

> > =

> > Btw., I am trying to get the MD5-changes/extra-option changes ready. Bu=
t I
> > got hooked up in other pieces last week...
> =

> Thanks!
> =

> Mat
> =

> =

> > =

> > Christoph
> > =

> > > =

> > > =

> > > Thanks,
> > > Mat
> > > =

> > > =

> > > > > =

> > > > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > > > index 03634ec2f918..873910c66df9 100644
> > > > > --- a/include/linux/skbuff.h
> > > > > +++ b/include/linux/skbuff.h
> > > > > @@ -489,7 +489,8 @@ int skb_zerocopy_iter_stream(struct sock *sk,=
 struct sk_buff *skb,
> > > > >   * the end of the header data, ie. at skb->end.
> > > > >   */
> > > > >  struct skb_shared_info {
> > > > > -	__u8		__unused;
> > > > > +	__u8		is_ext:1,
> > > > > +			__unused:7;
> > > > >  	__u8		meta_len;
> > > > >  	__u8		nr_frags;
> > > > >  	__u8		tx_flags;
> > > > > @@ -530,6 +531,24 @@ struct skb_shared_info {
> > > > >  #define SKB_DATAREF_MASK ((1 << SKB_DATAREF_SHIFT) - 1)
> > > > > =

> > > > > =

> > > > > +/* This is an extended version of skb_shared_info, also invarian=
t across
> > > > > + * clones and living at the end of the header data.
> > > > > + */
> > > > > +struct skb_shared_info_ext {
> > > > > +	/* skb_shared_info must be the first member */
> > > > > +	struct skb_shared_info	shinfo;
> > > > > +
> > > > > +	/* This is the shared control buffer. It is similar to sk_buff's
> > > > > +	 * control buffer, but is shared across clones. It must not be
> > > > > +	 * modified when multiple sk_buffs are referencing this structu=
re.
> > > > > +	 */
> > > > > +	char			shcb[48];
> > > > > +};
> > > > > +
> > > > > +#define SKB_SHINFO_EXT_OVERHEAD	\
> > > > > +	(SKB_DATA_ALIGN(sizeof(struct skb_shared_info_ext)) - \
> > > > > +	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
> > > > > +
> > > > >  enum {
> > > > >  	SKB_FCLONE_UNAVAILABLE,	/* skb has no fclone (from head_cache) =
*/
> > > > >  	SKB_FCLONE_ORIG,	/* orig skb (from fclone_cache) */
> > > > > @@ -856,6 +875,7 @@ struct sk_buff {
> > > > >  #define SKB_ALLOC_FCLONE	0x01
> > > > >  #define SKB_ALLOC_RX		0x02
> > > > >  #define SKB_ALLOC_NAPI		0x04
> > > > > +#define SKB_ALLOC_SHINFO_EXT	0x08
> > > > > =

> > > > >  /* Returns true if the skb was allocated from PFMEMALLOC reserve=
s */
> > > > >  static inline bool skb_pfmemalloc(const struct sk_buff *skb)
> > > > > @@ -1271,6 +1291,8 @@ static inline unsigned int skb_end_offset(c=
onst struct sk_buff *skb)
> > > > > =

> > > > >  /* Internal */
> > > > >  #define skb_shinfo(SKB)	((struct skb_shared_info *)(skb_end_poin=
ter(SKB)))
> > > > > +#define skb_shinfo_ext(SKB)	\
> > > > > +	((struct skb_shared_info_ext *)(skb_end_pointer(SKB)))
> > > > > =

> > > > >  static inline struct skb_shared_hwtstamps *skb_hwtstamps(struct =
sk_buff *skb)
> > > > >  {
> > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > index 40717501cbdd..397edd5c0613 100644
> > > > > --- a/net/core/skbuff.c
> > > > > +++ b/net/core/skbuff.c
> > > > > @@ -166,6 +166,8 @@ static void *__kmalloc_reserve(size_t size, g=
fp_t flags, int node,
> > > > >   *		instead of head cache and allocate a cloned (child) skb.
> > > > >   *		If SKB_ALLOC_RX is set, __GFP_MEMALLOC will be used for
> > > > >   *		allocations in case the data is required for writeback
> > > > > + *		If SKB_ALLOC_SHINFO_EXT is set, the skb will be allocated
> > > > > + *		with an extended shared info struct.
> > > > >   *	@node: numa node to allocate memory on
> > > > >   *
> > > > >   *	Allocate a new &sk_buff. The returned buffer has no headroom =
and a
> > > > > @@ -179,9 +181,9 @@ struct sk_buff *__alloc_skb(unsigned int size=
, gfp_t gfp_mask,
> > > > >  			    int flags, int node)
> > > > >  {
> > > > >  	struct kmem_cache *cache;
> > > > > -	struct skb_shared_info *shinfo;
> > > > >  	struct sk_buff *skb;
> > > > >  	u8 *data;
> > > > > +	unsigned int shinfo_size;
> > > > >  	bool pfmemalloc;
> > > > > =

> > > > >  	cache =3D (flags & SKB_ALLOC_FCLONE)
> > > > > @@ -199,18 +201,22 @@ struct sk_buff *__alloc_skb(unsigned int si=
ze, gfp_t gfp_mask,
> > > > >  	/* We do our best to align skb_shared_info on a separate cache
> > > > >  	 * line. It usually works because kmalloc(X > SMP_CACHE_BYTES) =
gives
> > > > >  	 * aligned memory blocks, unless SLUB/SLAB debug is enabled.
> > > > > -	 * Both skb->head and skb_shared_info are cache line aligned.
> > > > > +	 * Both skb->head and skb_shared_info (or skb_shared_info_ext) =
are
> > > > > +	 * cache line aligned.
> > > > >  	 */
> > > > >  	size =3D SKB_DATA_ALIGN(size);
> > > > > -	size +=3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > > -	data =3D kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
> > > > > +	if (flags & SKB_ALLOC_SHINFO_EXT)
> > > > > +		shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info_e=
xt));
> > > > > +	else
> > > > > +		shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > > +	data =3D kmalloc_reserve(size + shinfo_size, gfp_mask, node, &p=
fmemalloc);
> > > > >  	if (!data)
> > > > >  		goto nodata;
> > > > >  	/* kmalloc(size) might give us more room than requested.
> > > > >  	 * Put skb_shared_info exactly at the end of allocated zone,
> > > > >  	 * to allow max possible filling before reallocation.
> > > > >  	 */
> > > > > -	size =3D SKB_WITH_OVERHEAD(ksize(data));
> > > > > +	size =3D ksize(data) - shinfo_size;
> > > > >  	prefetchw(data + size);
> > > > > =

> > > > >  	/*
> > > > > @@ -220,7 +226,10 @@ struct sk_buff *__alloc_skb(unsigned int siz=
e, gfp_t gfp_mask,
> > > > >  	 */
> > > > >  	memset(skb, 0, offsetof(struct sk_buff, tail));
> > > > >  	/* Account for allocated memory : skb + skb->head */
> > > > > -	skb->truesize =3D SKB_TRUESIZE(size);
> > > > > +	if (flags & SKB_ALLOC_SHINFO_EXT)
> > > > > +		skb->truesize =3D SKB_TRUESIZE(size) + SKB_SHINFO_EXT_OVERHEAD;
> > > > > +	else
> > > > > +		skb->truesize =3D SKB_TRUESIZE(size);
> > > > >  	skb->pfmemalloc =3D pfmemalloc;
> > > > >  	refcount_set(&skb->users, 1);
> > > > >  	skb->head =3D data;
> > > > > @@ -231,10 +240,21 @@ struct sk_buff *__alloc_skb(unsigned int si=
ze, gfp_t gfp_mask,
> > > > >  	skb->transport_header =3D (typeof(skb->transport_header))~0U;
> > > > > =

> > > > >  	/* make sure we initialize shinfo sequentially */
> > > > > -	shinfo =3D skb_shinfo(skb);
> > > > > -	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
> > > > > -	atomic_set(&shinfo->dataref, 1);
> > > > > -	kmemcheck_annotate_variable(shinfo->destructor_arg);
> > > > > +	if (flags & SKB_ALLOC_SHINFO_EXT) {
> > > > > +		struct skb_shared_info_ext *shinfo_ext =3D skb_shinfo_ext(skb);
> > > > > +		shinfo_ext->shinfo.is_ext =3D 1;
> > > > > +		memset(&shinfo_ext->shinfo.meta_len, 0,
> > > > > +		       offsetof(struct skb_shared_info, dataref) -
> > > > > +		       offsetof(struct skb_shared_info, meta_len));
> > > > > +		atomic_set(&shinfo_ext->shinfo.dataref, 1);
> > > > > +		kmemcheck_annotate_variable(shinfo_ext->shinfo.destructor_arg);
> > > > > +		memset(&shinfo_ext->shcb, 0, sizeof(shinfo_ext->shcb));
> > > > > +	} else {
> > > > > +		struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > > > > +		memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
> > > > > +		atomic_set(&shinfo->dataref, 1);
> > > > > +		kmemcheck_annotate_variable(shinfo->destructor_arg);
> > > > > +	}
> > > > > =

> > > > >  	if (flags & SKB_ALLOC_FCLONE) {
> > > > >  		struct sk_buff_fclones *fclones;
> > > > > @@ -1443,6 +1463,7 @@ int pskb_expand_head(struct sk_buff *skb, i=
nt nhead, int ntail,
> > > > >  {
> > > > >  	int i, osize =3D skb_end_offset(skb);
> > > > >  	int size =3D osize + nhead + ntail;
> > > > > +	int shinfo_size;
> > > > >  	long off;
> > > > >  	u8 *data;
> > > > > =

> > > > > @@ -1454,11 +1475,14 @@ int pskb_expand_head(struct sk_buff *skb,=
 int nhead, int ntail,
> > > > > =

> > > > >  	if (skb_pfmemalloc(skb))
> > > > >  		gfp_mask |=3D __GFP_MEMALLOC;
> > > > > -	data =3D kmalloc_reserve(size + SKB_DATA_ALIGN(sizeof(struct sk=
b_shared_info)),
> > > > > -			       gfp_mask, NUMA_NO_NODE, NULL);
> > > > > +	if (skb_shinfo(skb)->is_ext)
> > > > > +		shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info_e=
xt));
> > > > > +	else
> > > > > +		shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > > +	data =3D kmalloc_reserve(size + shinfo_size, gfp_mask, NUMA_NO_=
NODE, NULL);
> > > > >  	if (!data)
> > > > >  		goto nodata;
> > > > > -	size =3D SKB_WITH_OVERHEAD(ksize(data));
> > > > > +	size =3D ksize(data) - shinfo_size;
> > > > > =

> > > > >  	/* Copy only real data... and, alas, header. This should be
> > > > >  	 * optimized for the cases when header is void.
> > > > > @@ -1468,6 +1492,12 @@ int pskb_expand_head(struct sk_buff *skb, =
int nhead, int ntail,
> > > > >  	memcpy((struct skb_shared_info *)(data + size),
> > > > >  	       skb_shinfo(skb),
> > > > >  	       offsetof(struct skb_shared_info, frags[skb_shinfo(skb)->=
nr_frags]));
> > > > > +	if (skb_shinfo(skb)->is_ext) {
> > > > > +		int offset =3D offsetof(struct skb_shared_info_ext, shcb);
> > > > > +		memcpy((struct skb_shared_info_ext *)(data + size + offset),
> > > > > +		       &skb_shinfo_ext(skb)->shcb,
> > > > > +		       sizeof(skb_shinfo_ext(skb)->shcb));
> > > > > +	}
> > > > > =

> > > > >  	/*
> > > > >  	 * if shinfo is shared we must drop the old head gracefully, bu=
t if it
> > > > > --
> > > > > 2.14.2
> > > > > =

> > > > > _______________________________________________
> > > > > mptcp mailing list
> > > > > mptcp(a)lists.01.org
> > > > > https://lists.01.org/mailman/listinfo/mptcp
> > > > =

> > > =

> > > --
> > > Mat Martineau
> > > Intel OTC
> > =

> =

> --
> Mat Martineau
> Intel OTC

--===============6512999651146623794==--
