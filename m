Content-Type: multipart/mixed; boundary="===============0121806513619169311=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC netnext] mptcp: Use 32-bit DATA_ACK when possible
Date: Wed, 13 May 2020 09:16:54 +0200
Message-ID: <3a636384bca3ce15e087158cc109663301227160.camel@redhat.com>
In-Reply-To: 20200513053257.8836-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 4378

--===============0121806513619169311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-05-12 at 22:32 -0700, Christoph Paasch wrote:
> RFC8684 allows to send 32-bit DATA_ACKs as long as the peer is not
> sending 64-bit data-sequence numbers. The 64-bit DSN is only there for
> extreme scenarios when a very high throughput subflow is combined with a
> long-RTT subflow such that the high-throughput subflow wraps around the
> 32-bit sequence number space within an RTT of the high-RTT subflow.
> =

> It is thus a rare scenario and we should try to use the 32-bit DATA_ACK
> instead as long as possible. It allows to reduce the TCP-option overhead
> by 4 bytes, thus makes space for an additional SACK-block. It also makes
> tcpdumps much easier to read when the DSN and DATA_ACK are both either
> 32 or 64-bit.
> =

> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
>  include/net/mptcp.h  |  1 +
>  net/mptcp/options.c  | 33 ++++++++++++++++++++++++---------
>  net/mptcp/protocol.h |  1 +
>  net/mptcp/subflow.c  |  2 ++
>  4 files changed, 28 insertions(+), 9 deletions(-)
> =

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index e60275659de6..25d8b36ed94f 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -17,6 +17,7 @@ struct seq_file;
>  /* MPTCP sk_buff extension data */
>  struct mptcp_ext {
>  	u64		data_ack;
> +	u32		data_ack32;

I think the above 2 fields could be "union-ed".
I think it's preferrable to avoid growing mptcp_ext size.

>  	u64		data_seq;
>  	u32		subflow_seq;
>  	u16		data_len;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 45497af23906..ece6f92cf7d1 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -516,7 +516,16 @@ static bool mptcp_established_options_dss(struct soc=
k *sk, struct sk_buff *skb,
>  		return ret;
>  	}
>  =

> -	ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
> +	if (subflow->use_64bit_ack) {
> +		ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
> +		opts->ext_copy.data_ack =3D msk->ack_seq;
> +		opts->ext_copy.ack64 =3D 1;
> +	} else {
> +		ack_size =3D TCPOLEN_MPTCP_DSS_ACK32;
> +		opts->ext_copy.data_ack32 =3D (uint32_t)(msk->ack_seq);
> +		opts->ext_copy.ack64 =3D 0;
> +	}
> +	opts->ext_copy.use_ack =3D 1;

If I read correctly, 'use_64bit_ack' is initialized with 0 and only set
if the peer sends 64bits sequence number. When interacting with impl
using 32bits DSN, our stack will flip the behavior at least once for
passive socket:

MPC+data is internally translated into DSS with 64bit DSN, so first
passive socket ack will use 64 bits.

Later, if the client uses 32 bits acks, it will switch to 32 bit acks.

Is that ok?

>  	/* Add kind/length/subtype/flag overhead if mapping is not populated */
>  	if (dss_size =3D=3D 0)
> @@ -524,10 +533,6 @@ static bool mptcp_established_options_dss(struct soc=
k *sk, struct sk_buff *skb,
>  =

>  	dss_size +=3D ack_size;
>  =

> -	opts->ext_copy.data_ack =3D msk->ack_seq;
> -	opts->ext_copy.ack64 =3D 1;
> -	opts->ext_copy.use_ack =3D 1;
> -
>  	*size =3D ALIGN(dss_size, 4);
>  	return true;
>  }
> @@ -986,8 +991,13 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_o=
ut_options *opts)
>  		u8 flags =3D 0;
>  =

>  		if (mpext->use_ack) {
> -			len +=3D TCPOLEN_MPTCP_DSS_ACK64;
> -			flags =3D MPTCP_DSS_HAS_ACK | MPTCP_DSS_ACK64;
> +			flags =3D MPTCP_DSS_HAS_ACK;
> +			if (mpext->ack64) {
> +				len +=3D TCPOLEN_MPTCP_DSS_ACK64;
> +				flags |=3D MPTCP_DSS_ACK64;
> +			} else {
> +				len +=3D TCPOLEN_MPTCP_DSS_ACK32;
> +			}
>  		}
>  =

>  		if (mpext->use_map) {
> @@ -1004,8 +1014,13 @@ void mptcp_write_options(__be32 *ptr, struct mptcp=
_out_options *opts)
>  		*ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
>  =

>  		if (mpext->use_ack) {
> -			put_unaligned_be64(mpext->data_ack, ptr);
> -			ptr +=3D 2;
> +			if (mpext->ack64) {
> +				put_unaligned_be64(mpext->data_ack, ptr);
> +				ptr +=3D 2;
> +			} else {
> +				put_unaligned_be32(mpext->data_ack32, ptr);
> +				ptr +=3D 1;
> +			}
>  		}
>  =

>  		if (mpext->use_map) {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index e4ca6320ce76..f5adca93e8fb 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -290,6 +290,7 @@ struct mptcp_subflow_context {
>  		data_avail : 1,
>  		rx_eof : 1,
>  		data_fin_tx_enable : 1,
> +		use_64bit_ack : 1, /* Set when we received a 64-bit DSN */
>  		can_ack : 1;	    /* only after processing the remote a key */
>  	u64	data_fin_tx_seq;
>  	u32	remote_nonce;

Possibly with a wider scope than this patch, but the above bitfields
contains both fields that are rarely changed (data_fin_tx_enable,
can_ack, request_mptcp, etc...) and fields that are set on every packet
/every DSS (map_vaild, data_avail, the newly added use_64bit_ack).

At least 'data_avail' is accessed without holding the ssk socket lock
by mptcp_subflow_recv_lookup(). Perhaps we could revisit the binary
layout of this struct?

Other than the above LGTM!

Cheers,

Paolo

--===============0121806513619169311==--
