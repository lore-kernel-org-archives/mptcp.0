Content-Type: multipart/mixed; boundary="===============3205990906782192847=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/8] mptcp: add ADD_ADDR port
 support for writing options
Date: Thu, 29 Oct 2020 17:42:14 -0700
Message-ID: <9f367861-1410-e87-546a-b33c211f5f7d@linux.intel.com>
In-Reply-To: cf1bf5352d467144523d8b06b5d0cbb95b90407d.1603952836.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6481

--===============3205990906782192847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 29 Oct 2020, Geliang Tang wrote:

> This patch added ADD_ADDR port support for writing options.
>
> In rfc8684, the length of ADD_ADDR suboption with IPv4 address and port
> is 18 octets:
>
>                       1                   2                   3
>   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>  +---------------+---------------+-------+-------+---------------+
>  |     Kind      |     Length    |Subtype|(rsv)|E|  Address ID   |
>  +---------------+---------------+-------+-------+---------------+
>  |           Address (IPv4: 4 octets / IPv6: 16 octets)          |
>  +-------------------------------+-------------------------------+
>  |   Port (2 octets, optional)   |                               |
>  +-------------------------------+                               |
>  |                Truncated HMAC (8 octets, if E=3D0)              |
>  |                               +-------------------------------+
>  |                               |
>  +-------------------------------+
>
> But mptcp_write_options is 32-bit aligned, so we need to pad it to 20
> octets.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> include/net/mptcp.h  |  1 +
> net/mptcp/options.c  | 64 +++++++++++++++++++++++++++++++++++++-------
> net/mptcp/protocol.h | 10 +++----
> 3 files changed, 60 insertions(+), 15 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index b6cf07143a8a..bb8b7b931490 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -46,6 +46,7 @@ struct mptcp_out_options {
> #endif
> 	};
> 	u8 addr_id;
> +	__be16 port;

This should be a u16 (all the members in this struct use CPU byte order). =

The put_unaligned_be16() calls below also assume this is in CPU order.

> 	u64 ahmac;
> 	u8 rm_id;
> 	u8 join_id;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 248e3930c0cb..7c928286c0da 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1067,39 +1067,83 @@ void mptcp_write_options(__be32 *ptr, const struc=
t tcp_sock *tp,
>
> mp_capable_done:
> 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> +		int add_len, echo_len;
> +
> +		if (!opts->port) {
> +			add_len =3D TCPOLEN_MPTCP_ADD_ADDR;
> +			echo_len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> +		} else {
> +			add_len =3D TCPOLEN_MPTCP_ADD_ADDR_PORT;
> +			echo_len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT;
> +		}
> +
> 		if (opts->ahmac)
> 			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> -					      TCPOLEN_MPTCP_ADD_ADDR, 0,
> +					      add_len, 0,
> 					      opts->addr_id);
> 		else
> 			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> -					      TCPOLEN_MPTCP_ADD_ADDR_BASE,
> +					      echo_len,
> 					      MPTCP_ADDR_ECHO,
> 					      opts->addr_id);
> 		memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
> 		ptr +=3D 1;
> -		if (opts->ahmac) {
> -			put_unaligned_be64(opts->ahmac, ptr);
> -			ptr +=3D 2;
> +
> +		if (!opts->port) {
> +			if (opts->ahmac) {
> +				put_unaligned_be64(opts->ahmac, ptr);
> +				ptr +=3D 2;
> +			}
> +		} else {
> +			if (opts->ahmac) {
> +				put_unaligned_be32(opts->port << 16 | opts->ahmac >> 48, ptr);

It doesn't work to bitwise-or these values before the endianness =

conversion. They need to have endianness converted first, then populate =

the headers in network byte order.

> +				ptr +=3D 1;
> +				put_unaligned_be64(opts->ahmac << 16 | TCPOPT_NOP, ptr);

Same issue here - need to make sure the byte order conversion happens =

first. For two bytes of padding, will need two bytes of TCPOPT_NOP.

> +				ptr +=3D 2;
> +			} else {
> +				put_unaligned_be16(opts->port, ptr);
> +				ptr +=3D 1;

Will need padding here too.

> +			}
> 		}
> 	}
>
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
> +		int add_len, echo_len;
> +
> +		if (!opts->port) {
> +			add_len =3D TCPOLEN_MPTCP_ADD_ADDR6;
> +			echo_len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> +		} else {
> +			add_len =3D TCPOLEN_MPTCP_ADD_ADDR6_PORT;
> +			echo_len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT;
> +		}
> 		if (opts->ahmac)
> 			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> -					      TCPOLEN_MPTCP_ADD_ADDR6, 0,
> +					      add_len, 0,
> 					      opts->addr_id);
> 		else
> 			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> -					      TCPOLEN_MPTCP_ADD_ADDR6_BASE,
> +					      echo_len,
> 					      MPTCP_ADDR_ECHO,
> 					      opts->addr_id);
> 		memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
> 		ptr +=3D 4;
> -		if (opts->ahmac) {
> -			put_unaligned_be64(opts->ahmac, ptr);
> -			ptr +=3D 2;
> +		if (!opts->port) {
> +			if (opts->ahmac) {
> +				put_unaligned_be64(opts->ahmac, ptr);
> +				ptr +=3D 2;
> +			}
> +		} else {
> +			if (opts->ahmac) {
> +				put_unaligned_be32(opts->port << 16 | opts->ahmac >> 48, ptr);
> +				ptr +=3D 1;
> +				put_unaligned_be64(opts->ahmac << 16 | TCPOPT_NOP, ptr);
> +				ptr +=3D 2;
> +			} else {
> +				put_unaligned_be16(opts->port, ptr);
> +				ptr +=3D 1;

Same issues as above with bitwise operations and byte order conversion. =

Maybe a new helper function to populate these bytes? The helper could use =

a local u8 pointer to make it easier to align the values using separate =

put_unaligned_* calls rather than using the bitwise-or.

> +			}
> 		}
> 	}
> #endif
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d29c6a4749eb..f303c46bcc29 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -49,14 +49,14 @@
> #define TCPOLEN_MPTCP_DSS_MAP64		14
> #define TCPOLEN_MPTCP_DSS_CHECKSUM	2
> #define TCPOLEN_MPTCP_ADD_ADDR		16
> -#define TCPOLEN_MPTCP_ADD_ADDR_PORT	18
> +#define TCPOLEN_MPTCP_ADD_ADDR_PORT	20
> #define TCPOLEN_MPTCP_ADD_ADDR_BASE	8
> -#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT	10
> +#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT	12
> #define TCPOLEN_MPTCP_ADD_ADDR6		28
> -#define TCPOLEN_MPTCP_ADD_ADDR6_PORT	30
> +#define TCPOLEN_MPTCP_ADD_ADDR6_PORT	32
> #define TCPOLEN_MPTCP_ADD_ADDR6_BASE	20
> -#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	22
> -#define TCPOLEN_MPTCP_PORT_LEN		2
> +#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	24
> +#define TCPOLEN_MPTCP_PORT_LEN		4
> #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
>
> /* MPTCP MP_JOIN flags */
> -- =

> 2.26.2

Thanks for the patches.

(Note: I haven't reviewed the rest of the series yet, will continue =

tomorrow)


--
Mat Martineau
Intel
--===============3205990906782192847==--
