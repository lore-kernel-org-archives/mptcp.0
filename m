Content-Type: multipart/mixed; boundary="===============4868096370494924305=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 1/2] net: mptcp: randomness improvements for
 crypto.c
Date: Fri, 14 Jun 2019 16:20:04 -0700
Message-ID: <alpine.OSX.2.21.1906141507120.48543@skshiu-mobl1.amr.corp.intel.com>
In-Reply-To: fa10c90788df7e31a8c79a1e7c6683c9c3a2f5d6.1560544900.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1383

--===============4868096370494924305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 14 Jun 2019, Davide Caratti wrote:

> - use net_get_random_once() to defer initialization of the crypto secret,
>  instead of computing it at boot time, and remove 'crypto_init()'.
>
> - don't use siphash for nonces, and also remove crypto_get_nonce_v{4,6}.
>  They are not used on current MPTCP, and future users should suffice
>
>     get_random_bytes(&nonce, sizeof(u32));
>
>  like it's done by other protocols in the Linux kernel (like SCTP).
>
> - use tcp_cookie_time() instead of 'seed', like it's done in syncookies,
>  so that the initial value of 'seed' is time-dependent (not always 0).
>
> CC: Florian Westphal <fwestpha(a)redhat.com>
> CC: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/crypto.c   | 47 +++++---------------------------------------
> net/mptcp/protocol.c |  1 -
> net/mptcp/protocol.h |  6 ------
> 3 files changed, 5 insertions(+), 49 deletions(-)
>
> diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
> index 2dc453d1d5ab..48b6748a8d25 100644
> --- a/net/mptcp/crypto.c
> +++ b/net/mptcp/crypto.c
> @@ -29,47 +29,18 @@
> #include <linux/cryptohash.h>
> #include <linux/random.h>
> #include <linux/siphash.h>
> +#include <net/tcp.h>
> #include <asm/unaligned.h>
>
> static siphash_key_t crypto_key_secret __read_mostly;
> -static hsiphash_key_t crypto_nonce_secret __read_mostly;
> -static u32 crypto_seed;
> -
> -u32 crypto_v4_get_nonce(__be32 saddr, __be32 daddr, __be16 sport, __be16=
 dport)
> -{
> -	return hsiphash_4u32((__force u32)saddr, (__force u32)daddr,
> -			    (__force u32)sport << 16 | (__force u32)dport,
> -			    crypto_seed++, &crypto_nonce_secret);
> -}
>
> u64 crypto_v4_get_key(__be32 saddr, __be32 daddr, __be16 sport, __be16 dp=
ort)
> {
> 	pr_debug("src=3D%x:%d, dst=3D%x:%d", saddr, sport, daddr, dport);
> +	net_get_random_once(&crypto_key_secret, sizeof(crypto_key_secret));

Thanks for this fix, initializing this later also gives more time for =

get_random_bytes() to get properly seeded.

> 	return siphash_4u32((__force u32)saddr, (__force u32)daddr,
> 			    (__force u32)sport << 16 | (__force u32)dport,
> -			    crypto_seed++, &crypto_key_secret);
> -}
> -
> -u32 crypto_v6_get_nonce(const struct in6_addr *saddr,
> -			const struct in6_addr *daddr,
> -			__be16 sport, __be16 dport)
> -{
> -	const struct {
> -		struct in6_addr saddr;
> -		struct in6_addr daddr;
> -		u32 seed;
> -		__be16 sport;
> -		__be16 dport;
> -	} __aligned(SIPHASH_ALIGNMENT) combined =3D {
> -		.saddr =3D *saddr,
> -		.daddr =3D *daddr,
> -		.seed =3D crypto_seed++,
> -		.sport =3D sport,
> -		.dport =3D dport,
> -	};
> -
> -	return hsiphash(&combined, offsetofend(typeof(combined), dport),
> -			&crypto_nonce_secret);
> +			    tcp_cookie_time(), &crypto_key_secret);

tcp_cookie_time() adds a dependency on CONFIG_SYN_COOKIES. It also looks =

like tcp_cookie_time() only increments once per second, so the uniqueness =

of the key (within a 1-second interval) becomes totally dependent on the =

uniqueness of the 4-tuple. I think a different seed source is needed that =

won't repeat so predictably.

> }
>

Thanks,

--
Mat Martineau
Intel

--===============4868096370494924305==--
