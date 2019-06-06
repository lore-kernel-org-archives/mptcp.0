Content-Type: multipart/mixed; boundary="===============3401824889801750290=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/7] mptcp: reduce number of pr_debug() calls.
Date: Thu, 06 Jun 2019 09:11:25 +0200
Message-ID: <67805a2bb3dd3cc47fbd40f6650a47d7bb2de298.camel@redhat.com>
In-Reply-To: 20190606003632.2863-2-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1303

--===============3401824889801750290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thank you for the great effort!

I have a few comments, see below...

On Wed, 2019-06-05 at 17:36 -0700, Peter Krystad wrote:
> squash to: Handle MPTCP TCP options
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  net/mptcp/options.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 9b9b9c9390c1..964e73b6b48b 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -13,7 +13,7 @@
>  void mptcp_parse_option(const unsigned char *ptr, int opsize,
>  			struct tcp_options_received *opt_rx)
>  {
> -	struct mptcp_options_received *mp_opt;
> +	struct mptcp_options_received *mp_opt =3D &opt_rx->mptcp;
>  	u8 subtype =3D *ptr >> 4;
>  	int expected_opsize;
>  =

> @@ -25,25 +25,28 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
>  	 * 10-17: Receiver key (optional)
>  	 */
>  	case MPTCPOPT_MP_CAPABLE:
> -		if (opsize !=3D TCPOLEN_MPTCP_MPC_SYN &&
> -		    opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
> -			break;
> -
> -		pr_debug("MP_CAPABLE");
> -		opt_rx->mptcp.version =3D *ptr++ & MPTCPOPT_VERSION_MASK;
> -		if (opt_rx->mptcp.version !=3D 0)
> +		mp_opt->version =3D *ptr++ & MPTCPOPT_VERSION_MASK;
> +		if (mp_opt->version !=3D 0)
>  			break;

I think we need to check the optsize before accessiong the option data,
or we could end-up reading after the packet end, for
malformed/malicious pkts.

>  =

> -		opt_rx->mptcp.mp_capable =3D 1;
> -		pr_debug("flags=3D%02x", *ptr);
> -		opt_rx->mptcp.flags =3D *ptr++;
> -		opt_rx->mptcp.sndr_key =3D get_unaligned_be64(ptr);
> -		pr_debug("sndr_key=3D%llu", opt_rx->mptcp.sndr_key);
> +		mp_opt->mp_capable =3D 1;
> +		mp_opt->flags =3D *ptr++;
> +		mp_opt->sndr_key =3D get_unaligned_be64(ptr);
>  		ptr +=3D 8;
> -		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
> -			opt_rx->mptcp.rcvr_key =3D get_unaligned_be64(ptr);
> -			pr_debug("rcvr_key=3D%llu", opt_rx->mptcp.rcvr_key);
> +
> +		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYN) {
> +			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu",
> +				 mp_opt->flags, mp_opt->sndr_key);
> +		} else if ((opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) ||
> +			   (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK)) {

Since TCPOLEN_MPTCP_MPC_ACK =3D=3D TCPOLEN_MPTCP_MPC_SYNACK, possibly some
compilers may emit a warning here?!? perhpas we can just drop the
second comparison, with a comment.
 =

Thanks,

Paolo


--===============3401824889801750290==--
