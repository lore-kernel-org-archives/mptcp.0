Content-Type: multipart/mixed; boundary="===============4432997740076360410=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v2 2/3] mptcp: Add ADD_ADDR handling
Date: Thu, 13 Jun 2019 14:53:06 +0200
Message-ID: <6dc0d86f0e276deffda1d23b0a9f033f91906d69.camel@redhat.com>
In-Reply-To: 20190612232127.3647-3-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1356

--===============4432997740076360410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for following up on this!

On Wed, 2019-06-12 at 16:21 -0700, Peter Krystad wrote:
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 5f3784989d85..393e9be41c8e 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -122,6 +122,12 @@ struct tcp_options_received {
>  			use_ack:1,
>  			ack64:1,
>  			__unused:2;
> +		u8	add_addr : 1,
> +			rm_addr : 1,
> +			family : 4;
> +		u8	addr_id;
> +		struct	in_addr	addr;
> +		struct	in6_addr addr6;

I'm unsure if it's too early for ipv6 bit ?!? =

What about an union for addr and addr6? Or perhaps use directly 'struct
inetpeer_addr'? The same consideration for mptcp_out_options below.

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 0e939724b22c..6de16196d4aa 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -221,6 +221,9 @@ void tcp_time_wait(struct sock *sk, int state, int ti=
meo);
>  #define TCPOLEN_MPTCP_DSS_MAP32		10
>  #define TCPOLEN_MPTCP_DSS_MAP64		14
>  #define TCPOLEN_MPTCP_DSS_CHECKSUM	2
> +#define TCPOLEN_MPTCP_ADD_ADDR		8
> +#define TCPOLEN_MPTCP_ADD_ADDR6		20
> +#define TCPOLEN_MPTCP_RM_ADDR		4

Not related to this patch, but possibly we can move this definition to
net/mptcp/protocol.h ? tcp core code shold not need to be aware of
them.

>  =

>  /* Flags in tp->nonagle */
>  #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index d285a33cd480..469f384ff108 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -161,12 +161,41 @@ void mptcp_parse_option(const unsigned char *ptr, i=
nt opsize,
>  	 * 4 or 16 bytes of address (depending on ip version)
>  	 * 0 or 2 bytes of port (depending on length)
>  	 */
> +	case MPTCPOPT_ADD_ADDR:
> +		if (opsize !=3D TCPOLEN_MPTCP_ADD_ADDR &&
> +		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
> +			break;
> +
> +		mp_opt->family =3D *ptr++ & MPTCP_ADDR_FAMILY_MASK;
> +		if (mp_opt->family !=3D MPTCP_ADDR_IPVERSION_4 &&
> +		    mp_opt->family !=3D MPTCP_ADDR_IPVERSION_6)
> +			break;
>  =

> -	/* MPTCPOPT_REMOVE_ADDR
> +		mp_opt->add_addr =3D 1;
> +		mp_opt->addr_id =3D *ptr++;
> +		if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR) {
> +			mp_opt->addr.s_addr =3D get_unaligned_be32(ptr);
> +			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
> +				 mp_opt->addr.s_addr, mp_opt->addr_id);
> +		} else {
> +			memcpy(mp_opt->addr6.s6_addr, (u8 *) ptr, 16);
> +			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
> +		}
> +		break;

I think we should also check that mp_opt->family matches opsize, or we
could end-up with e.g. mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6 and
only mp_opt->addr set.

[...]
> @@ -441,6 +490,34 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_o=
ut_options *opts)
>  		}
>  	}
>  =

> +	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> +		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
> +			       (TCPOLEN_MPTCP_ADD_ADDR << 16) |
> +			       (MPTCPOPT_ADD_ADDR << 12) |
> +			       (MPTCP_ADDR_IPVERSION_4 <<  8) |
> +			       (opts->addr_id));

Perhaps add a macro/inline function for the above?

> +		*ptr++ =3D htonl(opts->addr.s_addr);
> +	}
> +
> +#if IS_ENABLED(CONFIG_MPTCP)

IS_ENABLED(CONFIG_MPTCP) should be always 1 here, right ? :-P

> +	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
> +		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
> +			       (TCPOLEN_MPTCP_ADD_ADDR6 << 16) |
> +			       (MPTCPOPT_ADD_ADDR << 12) |
> +			       (MPTCP_ADDR_IPVERSION_6 <<  8) |
> +			       (opts->addr_id));
> +		memcpy((u8 *) ptr, opts->addr6.s6_addr, 16);
> +		ptr +=3D 4;
> +	}
> +#endif
> +
> +	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
> +		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) |
> +			       (TCPOLEN_MPTCP_RM_ADDR << 16) |
> +			       (MPTCPOPT_RM_ADDR << 12) |
> +			       (opts->addr_id));
> +	}
> +
>  	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
>  		struct mptcp_ext *mpext =3D &opts->ext_copy;
>  		u8 len =3D TCPOLEN_MPTCP_DSS_BASE;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 954360a3af2f..9458ced2c9f4 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -51,7 +51,17 @@ void pm_rm_addr(struct mptcp_sock *msk, u8 id)
>  bool pm_addr_signal(struct mptcp_sock *msk, unsigned *size,
>  		    unsigned int remaining, struct mptcp_out_options *opts)
>  {
> -	pr_debug("msk=3D%p", msk);
> +	if (msk && msk->addr_signal) {
> +		pr_debug("msk=3D%p", msk);
> +		if (msk->pm.family =3D=3D AF_INET &&
> +		    remaining >=3D TCPOLEN_MPTCP_ADD_ADDR) {
> +			msk->addr_signal =3D 0;
> +			opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> +			opts->addr_id =3D msk->pm.addr_id;
> +			opts->addr.s_addr =3D msk->pm.addr.s_addr;
> +			return true;

I think upstream prefers keeping the expected/main code path with no
indentation; something alike:

    if (!msk || !msk->addr_signal)
	return false

    if (msk->pm.family !=3D AF_INET ||
        remaining < TCPOLEN_MPTCP_ADD_ADDR)
	return false

    msk->addr_signal =3D 0;
    opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
    opts->addr_id =3D msk->pm.addr_id;
    opts->addr.s_addr =3D msk->pm.addr.s_addr;
    return true;

Cheers,

Paolo


--===============4432997740076360410==--
