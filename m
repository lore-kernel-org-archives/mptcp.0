Content-Type: multipart/mixed; boundary="===============4735702010904047256=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 18/25] tcp_extra_options: Allow to parse
 experimental options
Date: Tue, 28 Nov 2017 18:00:03 -0800
Message-ID: <alpine.OSX.2.21.1711281759060.17380@ddombrow-mobl1.amr.corp.intel.com>
In-Reply-To: 20171128055726.430-19-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 209

--===============4735702010904047256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Nov 2017, Christoph Paasch wrote:

> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
> include/net/tcp.h    | 7 ++++---
> net/ipv4/tcp.c       | 4 ++--
> net/ipv4/tcp_input.c | 6 ++++++
> 3 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 63fe6e02a963..f2708d69bb43 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -202,6 +202,7 @@ void tcp_time_wait(struct sock *sk, int state, int ti=
meo);
> #define TCPOLEN_FASTOPEN_BASE  2
> #define TCPOLEN_EXP_FASTOPEN_BASE  4
> #define TCPOLEN_EXP_SMC_BASE   6
> +#define TCPOLEN_EXP_BASE	6

Minor formatting note: other TCPOLEN_EXP_* defines here use spaces rather =

than tabs.

Mat


>
> /* But this is what stacks really send out. */
> #define TCPOLEN_TSTAMP_ALIGNED		12
> @@ -2069,7 +2070,7 @@ extern struct static_key_false tcp_extra_options_en=
abled;
> struct tcp_extra_option_store;
>
> struct tcp_extra_option_ops {
> -	unsigned char		option_kind;
> +	u32			option_kind;
> 	unsigned char		priority;
> 	void (*parse)(int opsize, const unsigned char *opptr,
> 		      const struct sk_buff *skb,
> @@ -2122,10 +2123,10 @@ struct tcp_extra_option_store {
> 	const struct tcp_extra_option_ops	*ops;
> };
>
> -struct tcp_extra_option_store *tcp_extra_options_find_kind(unsigned char=
 kind,
> +struct tcp_extra_option_store *tcp_extra_options_find_kind(u32 kind,
> 							   const struct sock *sk);
>
> -void tcp_extra_options_parse(int opcode, int opsize, const unsigned char=
 *opptr,
> +void tcp_extra_options_parse(u32 opcode, int opsize, const unsigned char=
 *opptr,
> 			     const struct sk_buff *skb,
> 			     struct tcp_options_received *opt_rx,
> 			     struct sock *sk);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index bc7f471bcf96..6d4e87aa1bbf 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3491,7 +3491,7 @@ static struct list_head *tcp_extra_options_get_list=
(const struct sock *sk)
> 	return NULL;
> }
>
> -struct tcp_extra_option_store *tcp_extra_options_find_kind(unsigned char=
 kind,
> +struct tcp_extra_option_store *tcp_extra_options_find_kind(u32 kind,
> 							   const struct sock *sk)
> {
> 	struct tcp_extra_option_store *entry;
> @@ -3507,7 +3507,7 @@ struct tcp_extra_option_store *tcp_extra_options_fi=
nd_kind(unsigned char kind,
> 	return entry;
> }
>
> -void tcp_extra_options_parse(int opcode, int opsize, const unsigned char=
 *opptr,
> +void tcp_extra_options_parse(u32 opcode, int opsize, const unsigned char=
 *opptr,
> 			     const struct sk_buff *skb,
> 			     struct tcp_options_received *opt_rx,
> 			     struct sock *sk)
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 23c62d8e4e06..2a3debb2c7fe 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3796,6 +3796,12 @@ void tcp_parse_options(const struct net *net,
> 				else if (smc_parse_options(th, opt_rx, ptr,
> 							   opsize))
> 					break;
> +				else if (static_branch_unlikely(&tcp_extra_options_enabled) &&
> +					 opsize >=3D TCPOLEN_EXP_BASE)
> +					tcp_extra_options_parse(get_unaligned_be32(ptr),
> +								opsize, ptr,
> +								skb, opt_rx,
> +								sk);
> 				break;
>
> 			default:
> -- =

> 2.15.0
>
>

--
Mat Martineau
Intel OTC

--===============4735702010904047256==--
