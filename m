Content-Type: multipart/mixed; boundary="===============2080143812951536067=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 1/4] net: tcp: drop unused function argument
 from mptcp_incoming_options
Date: Thu, 24 Sep 2020 17:38:07 -0700
Message-ID: <alpine.OSX.2.23.453.2009241736060.62831@mmahler-mobl1.amr.corp.intel.com>
In-Reply-To: 20200924143505.27641-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6041

--===============2080143812951536067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 24 Sep 2020, Florian Westphal wrote:

> Since commit cfde141ea3faa30e ("mptcp: move option parsing into mptcp_inc=
oming_options()"), the 3rd
> function argument is no longer used.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> include/net/mptcp.h  | 6 ++----
> net/ipv4/tcp_input.c | 4 ++--
> net/mptcp/options.c  | 3 +--
> 3 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index a7fc486e1035..6e706d838e4e 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -86,8 +86,7 @@ bool mptcp_synack_options(const struct request_sock *re=
q, unsigned int *size,
> bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> 			       unsigned int *size, unsigned int remaining,
> 			       struct mptcp_out_options *opts);
> -void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
> -			    struct tcp_options_received *opt_rx);
> +void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>
> void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts);
>
> @@ -199,8 +198,7 @@ static inline bool mptcp_established_options(struct s=
ock *sk,
> }
>
> static inline void mptcp_incoming_options(struct sock *sk,
> -					  struct sk_buff *skb,
> -					  struct tcp_options_received *opt_rx)
> +					  struct sk_buff *skb)
> {
> }
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 50834e7f958e..8afa4af30fdc 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4908,7 +4908,7 @@ static void tcp_data_queue(struct sock *sk, struct =
sk_buff *skb)
> 	int eaten;
>
> 	if (sk_is_mptcp(sk))
> -		mptcp_incoming_options(sk, skb, &tp->rx_opt);
> +		mptcp_incoming_options(sk, skb);
>
> 	if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
> 		__kfree_skb(skb);
> @@ -6487,7 +6487,7 @@ int tcp_rcv_state_process(struct sock *sk, struct s=
k_buff *skb)
> 	case TCP_LAST_ACK:
> 		if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
> 			if (sk_is_mptcp(sk))
> -				mptcp_incoming_options(sk, skb, &tp->rx_opt);
> +				mptcp_incoming_options(sk, skb);
> 			break;
> 		}
> 		fallthrough;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 14a290fae767..411fd4a41796 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -859,8 +859,7 @@ static bool add_addr_hmac_valid(struct mptcp_sock *ms=
k,
> 	return hmac =3D=3D mp_opt->ahmac;
> }
>
> -void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
> -			    struct tcp_options_received *opt_rx)
> +void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> {
> 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> -- =

> 2.26.2

I agree with Paolo, this can go to net-next soon.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>


--
Mat Martineau
Intel
--===============2080143812951536067==--
