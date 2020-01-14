Content-Type: multipart/mixed; boundary="===============7493163498374200057=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: handle ipv4-mapped ipv6 address.
Date: Mon, 13 Jan 2020 18:39:43 -0800
Message-ID: <alpine.OSX.2.21.2001131832140.13253@ndoyal-mobl1.amr.corp.intel.com>
In-Reply-To: 2c77cd2ecb1d716642a453a82092899e9a1ba4d5.1578926050.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3351

--===============7493163498374200057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 13 Jan 2020, Paolo Abeni wrote:

> The TCP code unconditionally overwrite in a few places 'icsk->icsk_af_ops=
',
> which lead to the wrong oops being called for ipv4-mapped ipv6 address.
> e.g. Kasan notice a invalid slub access running packetdrill ipv4-mapped
> tests.
>
> This patch try to address the issue building ipv4-mapped  mptcp icsk ops
> and using it when appropriate. Still needs quite a bit of work:
>
> - kasan still notice an use after free at netns cleanup time
>  (for the ns struct ???)
> - squashing
>
> ANy feedback more than welcome!
> ---
> include/net/mptcp.h |  2 ++
> net/ipv6/tcp_ipv6.c |  5 ++++
> net/mptcp/subflow.c | 66 +++++++++++++++++++++++++++++++++++++++++----
> 3 files changed, 68 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index f65baeacf199..27627e2d1bc2 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -174,6 +174,8 @@ static inline bool mptcp_skb_can_collapse(const struc=
t sk_buff *to,
>
> #endif /* CONFIG_MPTCP */
>
> +void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped);
> +
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> int mptcpv6_init(void);
> #elif IS_ENABLED(CONFIG_IPV6)
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 60068ffde1d9..522d16d70210 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -238,6 +238,9 @@ static int tcp_v6_connect(struct sock *sk, struct soc=
kaddr *uaddr,
> 		sin.sin_addr.s_addr =3D usin->sin6_addr.s6_addr32[3];
>
> 		icsk->icsk_af_ops =3D &ipv6_mapped;
> +		if (sk_is_mptcp(sk))
> +			mptcp_handle_ipv6_mapped(sk, true);
> +

I think we could get maintainer feedback about assigning icsk->icsk_af_ops =

multiple times. An option is to create an inlineable helper function that =

returns the appropriate value to assign (and does the other =

mptcp_handle_ipv6_mapped() stuff).

Mat


> 		sk->sk_backlog_rcv =3D tcp_v4_do_rcv;
> #ifdef CONFIG_TCP_MD5SIG
> 		tp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
> @@ -252,6 +255,8 @@ static int tcp_v6_connect(struct sock *sk, struct soc=
kaddr *uaddr,
> #ifdef CONFIG_TCP_MD5SIG
> 			tp->af_specific =3D &tcp_sock_ipv6_specific;
> #endif
> +			if (sk_is_mptcp(sk))
> +				mptcp_handle_ipv6_mapped(sk, false);
> 			goto failure;
> 		}
> 		np->saddr =3D sk->sk_v6_rcv_saddr;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 2c0f2ed7a428..4898cb340659 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -20,6 +20,8 @@
> #include <net/mptcp.h>
> #include "protocol.h"
>
> +static void subflow_chk_mapped(struct sock *sk);
> +
> static int subflow_rebuild_header(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> @@ -149,6 +151,7 @@ static int subflow_v4_conn_request(struct sock *sk, s=
truct sk_buff *skb)
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
> static struct inet_connection_sock_af_ops subflow_v6_specific;
> +static struct inet_connection_sock_af_ops subflow_v6m_specific;
>
> static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
> {
> @@ -219,6 +222,8 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
> 		if (!ctx)
> 			return child;
>
> +		subflow_chk_mapped(child);
> +
> 		if (ctx->mp_capable) {
> 			if (mptcp_token_new_accept(ctx->token))
> 				goto close_child;
> @@ -237,6 +242,54 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
>
> static struct inet_connection_sock_af_ops subflow_specific;
>
> +static struct inet_connection_sock_af_ops *
> +subflow_default_af_ops(struct sock *sk)
> +{
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (sk->sk_family =3D=3D AF_INET6)
> +		return &subflow_v6_specific;
> +#endif
> +	return &subflow_specific;
> +}
> +
> +void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped)
> +{
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> +	struct inet_connection_sock *icsk =3D inet_csk(sk);
> +	struct inet_connection_sock_af_ops *target;
> +
> +	target =3D mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
> +
> +	pr_debug("subflow=3D%p family=3D%d ops=3D%p target=3D%p mapped=3D%d",
> +	         subflow, sk->sk_family, icsk->icsk_af_ops, target, mapped);
> +
> +	if (likely(icsk->icsk_af_ops =3D=3D target))
> +		return;
> +
> +	subflow->icsk_af_ops =3D icsk->icsk_af_ops;
> +	icsk->icsk_af_ops =3D target;
> +#endif
> +}
> +
> +static void subflow_chk_mapped(struct sock *sk)
> +{
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> +	struct inet_connection_sock *icsk =3D inet_csk(sk);
> +
> +	pr_debug("subflow=3D%p family=3D%d ops=3D%p default=3D%p mapped=3D%p",
> +	         subflow, sk->sk_family, icsk->icsk_af_ops,
> +	         subflow_default_af_ops(sk), &subflow_v6m_specific);
> +
> +	if (likely(icsk->icsk_af_ops =3D=3D subflow_default_af_ops(sk)))
> +		return;
> +
> +	subflow->icsk_af_ops =3D icsk->icsk_af_ops;
> +	icsk->icsk_af_ops =3D &subflow_v6m_specific;
> +#endif
> +}
> +
> enum mapping_status {
> 	MAPPING_OK,
> 	MAPPING_INVALID,
> @@ -688,11 +741,7 @@ static int subflow_ulp_init(struct sock *sk)
>
> 	tp->is_mptcp =3D 1;
> 	ctx->icsk_af_ops =3D icsk->icsk_af_ops;
> -	icsk->icsk_af_ops =3D &subflow_specific;
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	if (sk->sk_family =3D=3D AF_INET6)
> -		icsk->icsk_af_ops =3D &subflow_v6_specific;
> -#endif
> +	icsk->icsk_af_ops =3D subflow_default_af_ops(sk);
> 	ctx->tcp_data_ready =3D sk->sk_data_ready;
> 	ctx->tcp_state_change =3D sk->sk_state_change;
> 	ctx->tcp_write_space =3D sk->sk_write_space;
> @@ -815,6 +864,13 @@ void mptcp_subflow_init(void)
> 	subflow_v6_specific.syn_recv_sock =3D subflow_syn_recv_sock;
> 	subflow_v6_specific.sk_rx_dst_set =3D subflow_finish_connect;
> 	subflow_v6_specific.rebuild_header =3D subflow_rebuild_header;
> +
> +	subflow_v6m_specific =3D subflow_v6_specific;
> +	subflow_v6m_specific.queue_xmit =3D ipv4_specific.queue_xmit;
> +	subflow_v6m_specific.send_check =3D ipv4_specific.send_check;
> +	subflow_v6m_specific.net_header_len =3D ipv4_specific.net_header_len;
> +	subflow_v6m_specific.mtu_reduced =3D ipv4_specific.mtu_reduced;
> +	subflow_v6m_specific.net_frag_header_len =3D 0;
> #endif
>
> 	if (tcp_register_ulp(&subflow_ulp_ops) !=3D 0)
> -- =

> 2.21.0
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============7493163498374200057==--
