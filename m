Content-Type: multipart/mixed; boundary="===============8431344835677684497=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v5 07/11] tcp: coalesce/collapse must
 respect MPTCP extensions
Date: Fri, 20 Dec 2019 08:17:44 -0800
Message-ID: <alpine.OSX.2.21.1912200741560.52347@mkavai-mobl.amr.corp.intel.com>
In-Reply-To: 90c0c531-45e4-4937-552a-898aff733756@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 3226

--===============8431344835677684497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Dec 2019, Eric Dumazet wrote:

>
>
> On 12/19/19 2:34 PM, Mat Martineau wrote:
>> Coalesce and collapse of packets carrying MPTCP extensions is allowed
>> when the newer packet has no extension or the extensions carried by both
>> packets are equal.
>>
>> This allows merging of TSO packet trains and even cross-TSO packets, and
>> does not require any additional action when moving data into existing
>> SKBs.
>>
>> v3 -> v4:
>>  - allow collapsing, under mptcp_skb_can_collapse() constraint
>>
>> Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>  include/net/mptcp.h   | 54 +++++++++++++++++++++++++++++++++++++++++++
>>  include/net/tcp.h     |  8 +++++++
>>  net/ipv4/tcp_input.c  | 11 ++++++---
>>  net/ipv4/tcp_output.c |  2 +-
>>  4 files changed, 71 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>> index f9f668ac4339..8e27e33861ab 100644
>> --- a/include/net/mptcp.h
>> +++ b/include/net/mptcp.h
>> @@ -8,6 +8,7 @@
>>  #ifndef __NET_MPTCP_H
>>  #define __NET_MPTCP_H
>>
>> +#include <linux/skbuff.h>
>>  #include <linux/types.h>
>>
>>  /* MPTCP sk_buff extension data */
>> @@ -24,4 +25,57 @@ struct mptcp_ext {
>>  			__unused:2;
>>  };
>>
>> +#ifdef CONFIG_MPTCP
>> +
>> +/* move the skb extension owership, with the assumption that 'to' is
>> + * newly allocated
>> + */
>> +static inline void mptcp_skb_ext_move(struct sk_buff *to,
>> +				      struct sk_buff *from)
>> +{
>> +	if (!skb_ext_exist(from, SKB_EXT_MPTCP))
>> +		return;
>> +
>> +	if (WARN_ON_ONCE(to->active_extensions))
>> +		skb_ext_put(to);
>> +
>> +	to->active_extensions =3D from->active_extensions;
>> +	to->extensions =3D from->extensions;
>> +	from->active_extensions =3D 0;
>> +}
>> +
>> +static inline bool mptcp_ext_matches(const struct mptcp_ext *to_ext,
>> +				     const struct mptcp_ext *from_ext)
>> +{
>> +	return !from_ext ||
>> +	       (to_ext && from_ext &&
>> +	        !memcmp(from_ext, to_ext, sizeof(struct mptcp_ext)));
>
> There is a hole at the end of struct mptcp_ext
>
> How is it properly cleared/initialized so that the memcmp() wont
> spuriously fail ?
>

Hi Eric,

Yes, that's important - we have code in part 2 that initializes the full =

sizeof(struct mptcp_ext) for exactly this reason:

         mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
         if (!mpext)
                 return;

         memset(mpext, 0, sizeof(*mpext));

(reference: =

https://github.com/multipath-tcp/mptcp_net-next/commit/0796b4a779d0c2a87e55=
2fdec801cb2596c23a1f =

)

Thank you very much for your review!

--
Mat Martineau
Intel
--===============8431344835677684497==--
