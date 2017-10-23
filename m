Content-Type: multipart/mixed; boundary="===============1809706180587644519=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Mon, 23 Oct 2017 13:13:19 -0700
Message-ID: <4ed240f3-404f-862d-e00b-844f9d32098b@oracle.com>
In-Reply-To: 7887be8b-1d52-f077-02d5-87cf342a3937@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 136

--===============1809706180587644519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 10/23/2017 12:49 PM, Rao Shoaib wrote:
>
> On 10/20/2017 04:02 PM, Mat Martineau wrote:
>> The sk_buff control buffer is of limited size, and cannot be enlarged
>> without significant impact on systemwide memory use. However, additional
>> per-packet state is needed for some protocols, like Multipath TCP.
>>
>> An optional shared control buffer placed after the normal struct
>> skb_shared_info can accomodate the necessary state without imposing
>> extra memory usage or code changes on normal struct sk_buff
>> users. __alloc_skb will now place a skb_shared_info_ext structure at
>> skb->end when given the SKB_ALLOC_SHINFO_EXT flag. Most users of struct
>> sk_buff continue to use the skb_shinfo() macro to access shared
>> info. skb_shinfo(skb)->is_ext is set if the extended structure is
>> available, and cleared if it is not.
>>
>> pskb_expand_head will preserve the shared control buffer if it is =

>> present.
>
> Hi Matt,
>
> I personally think the change looks good. It does have some minor =

> issues that still need to be resolved.
>
> Like Christoph stated the use of sizeof() is something to think about, =

> for example Solarflare driver on the Tx side uses sizeof(). See =

> efx_enqueue_skb_pio. Maybe create a macro so that the code can be =

> replaced by a call to the MACRO which looks at the flag and returns =

> the correct size.
>
> There are some issues to look at connection establishment time and =

> fallback to regular tcp. What if the other side does not support MPTCP =

> ? Will we be able to switch to an allocation that does not allocate =

> these extra 48 bytes. BTW we really do not need this change for MPTCP, =

> overloading current fields just works fine, however the enhacement =

> does open other possibilities.
>
> FYI. I am working on restructuring MPTCP code so it's not intrusive to =

> main TCP code. I will probably try a few other techniques but can use =

> this as well. I will post the changes at the appropriate time.
>
> Shoaib

BTW do handled and other smaller devices that are more likely to use =

MPTCP use shared_skb, or do they optimize and do not use it ?

Shoaib

>
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>> =C2=A0 include/linux/skbuff.h | 24 +++++++++++++++++++++-
>> =C2=A0 net/core/skbuff.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 56 =

>> ++++++++++++++++++++++++++++++++++++++------------
>> =C2=A0 2 files changed, 66 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 03634ec2f918..873910c66df9 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -489,7 +489,8 @@ int skb_zerocopy_iter_stream(struct sock *sk, =

>> struct sk_buff *skb,
>> =C2=A0=C2=A0 * the end of the header data, ie. at skb->end.
>> =C2=A0=C2=A0 */
>> =C2=A0 struct skb_shared_info {
>> -=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __unu=
sed;
>> +=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_ex=
t:1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __un=
used:7;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 meta_len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nr_frags;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tx_flags;
>> @@ -530,6 +531,24 @@ struct skb_shared_info {
>> =C2=A0 #define SKB_DATAREF_MASK ((1 << SKB_DATAREF_SHIFT) - 1)
>> =C2=A0 =C2=A0 +/* This is an extended version of skb_shared_info, also =

>> invariant across
>> + * clones and living at the end of the header data.
>> + */
>> +struct skb_shared_info_ext {
>> +=C2=A0=C2=A0=C2=A0 /* skb_shared_info must be the first member */
>> +=C2=A0=C2=A0=C2=A0 struct skb_shared_info=C2=A0=C2=A0=C2=A0 shinfo;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* This is the shared control buffer. It is similar =
to sk_buff's
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * control buffer, but is shared across clones.=
 It must not be
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * modified when multiple sk_buffs are referenc=
ing this structure.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 char=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 shcb[48];
>> +};
>> +
>> +#define SKB_SHINFO_EXT_OVERHEAD=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 (SKB_DATA_ALIGN(sizeof(struct skb_shared_info_ext)) =
- \
>> +=C2=A0=C2=A0=C2=A0=C2=A0 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
>> +
>> =C2=A0 enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SKB_FCLONE_UNAVAILABLE,=C2=A0=C2=A0=C2=A0=
 /* skb has no fclone (from =

>> head_cache) */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SKB_FCLONE_ORIG,=C2=A0=C2=A0=C2=A0 /* ori=
g skb (from fclone_cache) */
>> @@ -856,6 +875,7 @@ struct sk_buff {
>> =C2=A0 #define SKB_ALLOC_FCLONE=C2=A0=C2=A0=C2=A0 0x01
>> =C2=A0 #define SKB_ALLOC_RX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
02
>> =C2=A0 #define SKB_ALLOC_NAPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0x04
>> +#define SKB_ALLOC_SHINFO_EXT=C2=A0=C2=A0=C2=A0 0x08
>> =C2=A0 =C2=A0 /* Returns true if the skb was allocated from PFMEMALLOC r=
eserves */
>> =C2=A0 static inline bool skb_pfmemalloc(const struct sk_buff *skb)
>> @@ -1271,6 +1291,8 @@ static inline unsigned int skb_end_offset(const =

>> struct sk_buff *skb)
>> =C2=A0 =C2=A0 /* Internal */
>> =C2=A0 #define skb_shinfo(SKB)=C2=A0=C2=A0=C2=A0 ((struct skb_shared_inf=
o =

>> *)(skb_end_pointer(SKB)))
>> +#define skb_shinfo_ext(SKB)=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 ((struct skb_shared_info_ext *)(skb_end_pointer(SKB)=
))
>> =C2=A0 =C2=A0 static inline struct skb_shared_hwtstamps *skb_hwtstamps(s=
truct =

>> sk_buff *skb)
>> =C2=A0 {
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 40717501cbdd..397edd5c0613 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -166,6 +166,8 @@ static void *__kmalloc_reserve(size_t size, gfp_t =

>> flags, int node,
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 instead of head=
 cache and allocate a cloned (child) skb.
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If SKB_ALLOC_RX=
 is set, __GFP_MEMALLOC will be used for
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 allocations in =
case the data is required for writeback
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If SKB_ALLOC_SHINFO_EXT is=
 set, the skb will be allocated
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with an extended shared in=
fo struct.
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 @node: numa node to allocate memory on
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 Allocate a new &sk_buff. The returned b=
uffer has no headroom =

>> and a
>> @@ -179,9 +181,9 @@ struct sk_buff *__alloc_skb(unsigned int size, =

>> gfp_t gfp_mask,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int flags, int node)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kmem_cache *cache;
>> -=C2=A0=C2=A0=C2=A0 struct skb_shared_info *shinfo;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *data;
>> +=C2=A0=C2=A0=C2=A0 unsigned int shinfo_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool pfmemalloc;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache =3D (flags & SKB_ALLOC_FCLON=
E)
>> @@ -199,18 +201,22 @@ struct sk_buff *__alloc_skb(unsigned int size, =

>> gfp_t gfp_mask,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We do our best to align skb_shared_inf=
o on a separate cache
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * line. It usually works because km=
alloc(X > SMP_CACHE_BYTES) =

>> gives
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * aligned memory blocks, unless SLU=
B/SLAB debug is enabled.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Both skb->head and skb_shared_info are cache=
 line aligned.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Both skb->head and skb_shared_info (or skb_s=
hared_info_ext) are
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cache line aligned.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D SKB_DATA_ALIGN(size);
>> -=C2=A0=C2=A0=C2=A0 size +=3D SKB_DATA_ALIGN(sizeof(struct skb_shared_in=
fo));
>> -=C2=A0=C2=A0=C2=A0 data =3D kmalloc_reserve(size, gfp_mask, node, &pfme=
malloc);
>> +=C2=A0=C2=A0=C2=A0 if (flags & SKB_ALLOC_SHINFO_EXT)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shinfo_size =3D SKB_DATA_ALI=
GN(sizeof(struct =

>> skb_shared_info_ext));
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shinfo_size =3D SKB_DATA_ALI=
GN(sizeof(struct skb_shared_info));
>> +=C2=A0=C2=A0=C2=A0 data =3D kmalloc_reserve(size + shinfo_size, gfp_mas=
k, node, =

>> &pfmemalloc);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto nodata;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* kmalloc(size) might give us more room =
than requested.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Put skb_shared_info exactly at th=
e end of allocated zone,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to allow max possible filling bef=
ore reallocation.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 size =3D SKB_WITH_OVERHEAD(ksize(data));
>> +=C2=A0=C2=A0=C2=A0 size =3D ksize(data) - shinfo_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prefetchw(data + size);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> @@ -220,7 +226,10 @@ struct sk_buff *__alloc_skb(unsigned int size, =

>> gfp_t gfp_mask,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(skb, 0, offsetof(struct sk_buff, t=
ail));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Account for allocated memory : skb + s=
kb->head */
>> -=C2=A0=C2=A0=C2=A0 skb->truesize =3D SKB_TRUESIZE(size);
>> +=C2=A0=C2=A0=C2=A0 if (flags & SKB_ALLOC_SHINFO_EXT)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->truesize =3D SKB_TRUESI=
ZE(size) + SKB_SHINFO_EXT_OVERHEAD;
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->truesize =3D SKB_TRUESI=
ZE(size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->pfmemalloc =3D pfmemalloc;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount_set(&skb->users, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->head =3D data;
>> @@ -231,10 +240,21 @@ struct sk_buff *__alloc_skb(unsigned int size, =

>> gfp_t gfp_mask,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->transport_header =3D (typeof(skb->tr=
ansport_header))~0U;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* make sure we initialize shinfo =
sequentially */
>> -=C2=A0=C2=A0=C2=A0 shinfo =3D skb_shinfo(skb);
>> -=C2=A0=C2=A0=C2=A0 memset(shinfo, 0, offsetof(struct skb_shared_info, d=
ataref));
>> -=C2=A0=C2=A0=C2=A0 atomic_set(&shinfo->dataref, 1);
>> -=C2=A0=C2=A0=C2=A0 kmemcheck_annotate_variable(shinfo->destructor_arg);
>> +=C2=A0=C2=A0=C2=A0 if (flags & SKB_ALLOC_SHINFO_EXT) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct skb_shared_info_ext *=
shinfo_ext =3D skb_shinfo_ext(skb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shinfo_ext->shinfo.is_ext =
=3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&shinfo_ext->shinfo.m=
eta_len, 0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offsetof(struct skb_shared_info, dataref) -
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 offsetof(struct skb_shared_info, meta_len));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&shinfo_ext->shin=
fo.dataref, 1);
>> + kmemcheck_annotate_variable(shinfo_ext->shinfo.destructor_arg);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&shinfo_ext->shcb, 0,=
 sizeof(shinfo_ext->shcb));
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct skb_shared_info *shin=
fo =3D skb_shinfo(skb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(shinfo, 0, offsetof(s=
truct skb_shared_info, dataref));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&shinfo->dataref,=
 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmemcheck_annotate_variable(=
shinfo->destructor_arg);
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags & SKB_ALLOC_FCLONE) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff_fc=
lones *fclones;
>> @@ -1443,6 +1463,7 @@ int pskb_expand_head(struct sk_buff *skb, int =

>> nhead, int ntail,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, osize =3D skb_end_offset(skb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int size =3D osize + nhead + ntail;
>> +=C2=A0=C2=A0=C2=A0 int shinfo_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long off;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *data;
>> =C2=A0 @@ -1454,11 +1475,14 @@ int pskb_expand_head(struct sk_buff *skb, =

>> int nhead, int ntail,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (skb_pfmemalloc(skb))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfp_mask |=3D __G=
FP_MEMALLOC;
>> -=C2=A0=C2=A0=C2=A0 data =3D kmalloc_reserve(size + SKB_DATA_ALIGN(sizeo=
f(struct =

>> skb_shared_info)),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfp_mask, NUMA_NO_NODE, NULL);
>> +=C2=A0=C2=A0=C2=A0 if (skb_shinfo(skb)->is_ext)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shinfo_size =3D SKB_DATA_ALI=
GN(sizeof(struct =

>> skb_shared_info_ext));
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shinfo_size =3D SKB_DATA_ALI=
GN(sizeof(struct skb_shared_info));
>> +=C2=A0=C2=A0=C2=A0 data =3D kmalloc_reserve(size + shinfo_size, gfp_mas=
k, =

>> NUMA_NO_NODE, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto nodata;
>> -=C2=A0=C2=A0=C2=A0 size =3D SKB_WITH_OVERHEAD(ksize(data));
>> +=C2=A0=C2=A0=C2=A0 size =3D ksize(data) - shinfo_size;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Copy only real data... and, ala=
s, header. This should be
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * optimized for the cases when head=
er is void.
>> @@ -1468,6 +1492,12 @@ int pskb_expand_head(struct sk_buff *skb, int =

>> nhead, int ntail,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy((struct skb_shared_info *)(data + =
size),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 skb_shinfo(skb),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 offsetof(struct skb_shared_info, =

>> frags[skb_shinfo(skb)->nr_frags]));
>> +=C2=A0=C2=A0=C2=A0 if (skb_shinfo(skb)->is_ext) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int offset =3D offsetof(stru=
ct skb_shared_info_ext, shcb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy((struct skb_shared_in=
fo_ext *)(data + size + offset),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 &skb_shinfo_ext(skb)->shcb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sizeof(skb_shinfo_ext(skb)->shcb));
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if shinfo is shared we must drop =
the old head gracefully, =

>> but if it
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============1809706180587644519==--
