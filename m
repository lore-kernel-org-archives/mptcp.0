Content-Type: multipart/mixed; boundary="===============8603150127004908494=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Store 32 and 64-bit ACKs separately
Date: Mon, 20 Jan 2020 21:16:20 -0800
Message-ID: <3049613c433d1db6366bc987b6d7d8c589d82f52.camel@linux.intel.com>
In-Reply-To: 20200116011309.3202-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3440

--===============8603150127004908494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


We can drop this patch.

Peter.

On Wed, 2020-01-15 at 17:13 -0800, Peter Krystad wrote:
> Will be useful optimizing struct mptcp_options_received.
> =

> squashto: Implement MPTCP receive path
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  include/linux/tcp.h |  2 ++
>  net/mptcp/options.c | 24 ++++++++++++++++--------
>  2 files changed, 18 insertions(+), 8 deletions(-)
> =

> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 0d00dad4b85d..6abf8d9f1a42 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -82,6 +82,8 @@ struct tcp_sack_block {
>  struct mptcp_options_received {
>  	u64	sndr_key;
>  	u64	rcvr_key;
> +	u32	data_ack32;
> +	u32	data_seq32;
>  	u64	data_ack;
>  	u64	data_seq;
>  	u32	subflow_seq;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index db224e050666..b7f1892d8320 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -142,21 +142,23 @@ void mptcp_parse_option(const unsigned char *ptr, i=
nt opsize,
>  		if (mp_opt->use_ack) {
>  			if (mp_opt->ack64) {
>  				mp_opt->data_ack =3D get_unaligned_be64(ptr);
> +				pr_debug("data_ack=3D%llu", mp_opt->data_ack);
>  				ptr +=3D 8;
>  			} else {
> -				mp_opt->data_ack =3D get_unaligned_be32(ptr);
> +				mp_opt->data_ack32 =3D get_unaligned_be32(ptr);
> +				pr_debug("data_ack32=3D%u", mp_opt->data_ack32);
>  				ptr +=3D 4;
>  			}
> -
> -			pr_debug("data_ack=3D%llu", mp_opt->data_ack);
>  		}
>  =

>  		if (mp_opt->use_map) {
>  			if (mp_opt->dsn64) {
>  				mp_opt->data_seq =3D get_unaligned_be64(ptr);
> +				pr_debug("data_seq=3D%llu", mp_opt->data_seq);
>  				ptr +=3D 8;
>  			} else {
> -				mp_opt->data_seq =3D get_unaligned_be32(ptr);
> +				mp_opt->data_seq32 =3D get_unaligned_be32(ptr);
> +				pr_debug("data_seq32=3D%u", mp_opt->data_seq32);
>  				ptr +=3D 4;
>  			}
>  =

> @@ -166,9 +168,8 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
>  			mp_opt->data_len =3D get_unaligned_be16(ptr);
>  			ptr +=3D 2;
>  =

> -			pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u",
> -				 mp_opt->data_seq, mp_opt->subflow_seq,
> -				 mp_opt->data_len);
> +			pr_debug("subflow_seq=3D%u data_len=3D%u",
> +				 mp_opt->subflow_seq, mp_opt->data_len);
>  		}
>  =

>  		break;
> @@ -428,7 +429,10 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb,
>  	memset(mpext, 0, sizeof(*mpext));
>  =

>  	if (mp_opt->use_map) {
> -		mpext->data_seq =3D mp_opt->data_seq;
> +		if (mp_opt->dsn64)
> +			mpext->data_seq =3D mp_opt->data_seq;
> +		else
> +			mpext->data_seq =3D mp_opt->data_seq32;
>  		mpext->subflow_seq =3D mp_opt->subflow_seq;
>  		mpext->data_len =3D mp_opt->data_len;
>  		mpext->use_map =3D 1;
> @@ -436,6 +440,10 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb,
>  	}
>  =

>  	if (mp_opt->use_ack) {
> +		if (mp_opt->ack64)
> +			mpext->data_ack =3D mp_opt->data_ack;
> +		else
> +			mpext->data_ack =3D mp_opt->data_ack32;
>  		mpext->data_ack =3D mp_opt->data_ack;
>  		mpext->use_ack =3D 1;
>  		mpext->ack64 =3D mp_opt->ack64;

--===============8603150127004908494==--
