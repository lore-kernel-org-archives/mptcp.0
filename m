Content-Type: multipart/mixed; boundary="===============1491577616929168940=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC mptcp-next] tcp: mptcp: use mptcp receive buffer
 space to select rcv window
Date: Wed, 18 Mar 2020 10:59:12 -0700
Message-ID: <48933c49-0889-5dba-29e2-62640e47797a@gmail.com>
In-Reply-To: 20200318141917.2612-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3982

--===============1491577616929168940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 3/18/20 7:19 AM, Florian Westphal wrote:
> In MPTCP, the receive windo is shared across all subflows, because it
> refers to the mptcp-level sequence space.
> =

> This commit doesn't change choice of initial window for passive or active
> connections.
> While it would be possible to change those as well, this adds complexity
> (especially when handling MP_JOIN requests).
> =

> However, the MPTCP RFC specifically says that a MPTCP sender
> 'MUST NOT use the RCV.WND field of a TCP segment at the connection level =
if
> it does not also carry a DSS option with a Data ACK field.'
> =

> SYN/SYNACK packets do not carry a DSS option with a Data ACK field.
> =

> CC: Eric Dumazet <edumazet(a)google.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  This patch would add additional direct call in __tcp_select_window().
> =

>  I looked at mptcp option writing to check if it could be done there but
>  that seemed worse.
> =

>  include/net/mptcp.h   |  3 +++
>  net/ipv4/tcp_output.c |  5 +++++
>  net/mptcp/subflow.c   | 17 +++++++++++++++++
>  3 files changed, 25 insertions(+)
> =

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 7489f9267640..1ef4520f45c3 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -66,6 +66,8 @@ static inline bool rsk_is_mptcp(const struct request_so=
ck *req)
>  	return tcp_rsk(req)->is_mptcp;
>  }
>  =

> +void mptcp_space(const struct sock *ssk, int *space, int *full_space);
> +
>  void mptcp_parse_option(const struct sk_buff *skb, const unsigned char *=
ptr,
>  			int opsize, struct tcp_options_received *opt_rx);
>  bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
> @@ -195,6 +197,7 @@ static inline bool mptcp_sk_is_subflow(const struct s=
ock *sk)
>  	return false;
>  }
>  =

> +static inline void mptcp_space(const struct sock *ssk, int *s, int *fs) =
{ }
>  static inline void mptcp_seq_show(struct seq_file *seq) { }
>  #endif /* CONFIG_MPTCP */
>  =

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 306e25d743e8..1a829536a115 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2771,6 +2771,11 @@ u32 __tcp_select_window(struct sock *sk)
>  	int full_space =3D min_t(int, tp->window_clamp, allowed_space);
>  	int window;
>  =

> +	if (sk_is_mptcp(sk)) {
> +		mptcp_space(sk, &free_space, &allowed_space);
> +		full_space =3D min_t(int, tp->window_clamp, allowed_space);
> +	}

You could move the full_space =3D min_t(int, tp->window_clamp, allowed_spac=
e);
after this block factorize it.


> +
>  	if (unlikely(mss > full_space)) {
>  		mss =3D full_space;
>  		if (mss <=3D 0)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 40ad7995b13b..aefcbb8bb737 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -745,6 +745,23 @@ bool mptcp_subflow_data_available(struct sock *sk)
>  	return subflow->data_avail;
>  }
>  =

> +/* If ssk has an mptcp parent socket, use the mptcp rcvbuf occupancy,
> + * not the ssk one.
> + *
> + * In mptcp, rwin is about the mptcp-level connection data.
> + *
> + * Data that is still on the ssk rx queue can thus be ignored,
> + * as far as mptcp peer is concerened that data is still inflight.
> + */
> +void mptcp_space(const struct sock *ssk, int *space, int *full_space)
> +{
> +	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	const struct sock *sk =3D READ_ONCE(subflow->conn);

What are the rules protecting subflow->conn lifetime ?

Why dereferencing sk after this line is safe ?

> +
> +	*space =3D tcp_space(sk);
> +	*full_space =3D tcp_full_space(sk);
> +}
> +
>  static void subflow_data_ready(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>=20
--===============1491577616929168940==--
