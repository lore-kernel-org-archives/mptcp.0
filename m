Content-Type: multipart/mixed; boundary="===============2493300779977156618=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v3 05/15] tcp: Make smc_parse_options return 1 on
 success
Date: Tue, 12 Dec 2017 16:37:49 -0800
Message-ID: <alpine.OSX.2.21.1712121630520.15459@sjweber-mobl.amr.corp.intel.com>
In-Reply-To: 20171211214218.35868-6-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 255

--===============2493300779977156618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Tag as "tcp_smc: ..." ?

On Mon, 11 Dec 2017, Christoph Paasch wrote:

> Will be needed to allow extra-options to parse experimental TCP options.
> That way, if the SMC-options don't match, we check the extra-options.

Similar to the earlier patch, the "extra-options" name is still unfamiliar =

to most on netdev.

>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> net/ipv4/tcp_input.c | 19 +++++++++++--------
> 1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index cba194a0222f..eedb355a0533 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3676,19 +3676,22 @@ static void tcp_parse_fastopen_option(int len, co=
nst unsigned char *cookie,
> 	foc->exp =3D exp_opt;
> }
>
> -static void smc_parse_options(const struct tcphdr *th,
> -			      struct tcp_options_received *opt_rx,
> -			      const unsigned char *ptr,
> -			      int opsize)
> +static int smc_parse_options(const struct tcphdr *th,
> +			     struct tcp_options_received *opt_rx,
> +			     const unsigned char *ptr,
> +			     int opsize)
> {
> #if IS_ENABLED(CONFIG_SMC)
> 	if (static_branch_unlikely(&tcp_have_smc)) {
> 		if (th->syn && !(opsize & 1) &&
> 		    opsize >=3D TCPOLEN_EXP_SMC_BASE &&
> -		    get_unaligned_be32(ptr) =3D=3D TCPOPT_SMC_MAGIC)
> +		    get_unaligned_be32(ptr) =3D=3D TCPOPT_SMC_MAGIC) {
> 			opt_rx->smc_ok =3D 1;
> +			return 1;
> +		}
> 	}
> #endif
> +	return 0;
> }
>
> /* Look for tcp options. Normally only called on SYN and SYNACK packets.
> @@ -3798,9 +3801,9 @@ void tcp_parse_options(const struct net *net,
> 					tcp_parse_fastopen_option(opsize -
> 						TCPOLEN_EXP_FASTOPEN_BASE,
> 						ptr + 2, th->syn, foc, true);
> -				else
> -					smc_parse_options(th, opt_rx, ptr,
> -							  opsize);
> +				else if (smc_parse_options(th, opt_rx, ptr,
> +							   opsize))
> +					break;
> 				break;

From a "standalone patch" perspective, I can see someone wondering why =

there would be an if statement when the break happens no matter what =

smc_parse_options returns. I'm not sure if it's best to set the stage for =

the next patch, as this does, or just leave this chunk of code alone until =

the next patch.

>
> 			}
> -- =

> 2.15.0
>
>

--
Mat Martineau
Intel OTC

--===============2493300779977156618==--
