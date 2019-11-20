Content-Type: multipart/mixed; boundary="===============0793908266368794356=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/2] mptcp: parse and emit MP_CAPABLE option
 according to v1 spec.
Date: Wed, 20 Nov 2019 15:56:04 +0100
Message-ID: <64565434-92a6-b298-dd24-bde57ecb5c5d@tessares.net>
In-Reply-To: 20191107152827.54549-2-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2613

--===============0793908266368794356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 07/11/2019 16:28, Christoph Paasch wrote:
> Local key is sent on syn/ack, and both keys are sent on 3rd ack.
> MP_CAPABLE messages len are updated accordingly.
> We need the skbuff to emit correctly the above, so we push the skbuff
> struct as an argument all the way from tcp code to the relevant mptcp
> callbacks.
> =

> When processing incoming MP_CAPABLE + data, build a full blown DSS-like
> map info, to simplify later processing.
> On child socket creation, we need to record the remote key, if available.
> =

> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>

Thank you for sharing this! It looks very nice!

I just have a small question, please see below:

[...]

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1b08e1193991..9cdbd617c49a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c

[...]

> @@ -24,12 +24,24 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
>   	 * 10-17: Receiver key (optional)
>   	 */
>   	case MPTCPOPT_MP_CAPABLE:
> -		if (opsize !=3D TCPOLEN_MPTCP_MPC_SYN &&
> -		    opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
> +		/* strict size checking */
> +		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
> +			if (skb->len > tcp_hdr(skb)->doff << 2)
> +				expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK_DATA;
> +			else
> +				expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK;
> +		} else {
> +			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK)
> +				expected_opsize =3D TCPOLEN_MPTCP_MPC_SYNACK;
> +			else
> +				expected_opsize =3D TCPOLEN_MPTCP_MPC_SYN;
> +		}
> +		if (opsize !=3D expected_opsize)
>   			break;
>   =

> +		/* only support V1 of the protocol */
>   		mp_opt->version =3D *ptr++ & MPTCP_VERSION_MASK;
> -		if (mp_opt->version !=3D 0)
> +		if (mp_opt->version !=3D 1)

Should we not only "break" here is the version is < 1? To be compatible =

with possible newer versions.

It seems confirmed by the RFC, section 3.1:

    If a host supports multiple versions of MPTCP,
    the sender of the MP_CAPABLE option SHOULD signal the highest version
    number it supports.  In return, in its MP_CAPABLE option, the
    receiver will signal the version number it wishes to use, which MUST
    be equal to or lower than the version number indicated in the initial
    MP_CAPABLE.

detail: maybe we need a #define for this minimal version that we support?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0793908266368794356==--
