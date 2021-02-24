Content-Type: multipart/mixed; boundary="===============0986707313503138142=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: mptcp reset option
Date: Tue, 23 Feb 2021 16:41:42 -0800
Message-ID: <a4936e57-c3c-9f92-f351-433af57ed4b5@linux.intel.com>
In-Reply-To: 20210222124940.23943-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7925

--===============0986707313503138142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Feb 2021, Florian Westphal wrote:

> The MPTCP reset option allows to carry a mptcp-specific error code that
> provides more information on the nature of a connection reset.
>
> Reset option data received gets stored in the subflow context so it can
> be sent to userspace via the 'subflow closed' netlink event.
>
> When a subflow is closed, the desired error code that should be sent to
> the peer is also placed in the subflow context structure.
>
> If a reset is sent before subflow establishment could complete, e.g. on
> HMAC failure during an MP_JOIN operation, the mptcp skb extension is
> used to store the reset information.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> include/net/mptcp.h        | 18 +++++++++--
> include/uapi/linux/mptcp.h |  2 ++
> net/ipv4/tcp_ipv4.c        | 21 ++++++++++--
> net/ipv6/tcp_ipv6.c        | 14 +++++++-
> net/mptcp/options.c        | 66 +++++++++++++++++++++++++++++++++++---
> net/mptcp/pm_netlink.c     | 12 +++++++
> net/mptcp/protocol.c       | 12 +++++--
> net/mptcp/protocol.h       | 22 ++++++++++++-
> net/mptcp/subflow.c        | 37 ++++++++++++++++++---
> 9 files changed, 185 insertions(+), 19 deletions(-)
>

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 59ea64e5e914..e95bd8fa5e62 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1648,9 +1648,21 @@ static int mptcp_event_sub_closed(struct sk_buff *=
skb,
> 				  const struct mptcp_sock *msk,
> 				  const struct sock *ssk)
> {
> +	const struct mptcp_subflow_context *sf;
> +
> 	if (mptcp_event_put_token_and_ssk(skb, msk, ssk))
> 		return -EMSGSIZE;
>
> +	sf =3D mptcp_subflow_ctx(ssk);
> +	if (sf->reset_reason =3D=3D 0)
> +		return 0;

From what I see in the RFC, the T flag can be set even if the reason code =

is 'unspecified', so I don't think MPTCP_ATTR_RESET_FLAGS should be =

skipped if reset_reason =3D=3D 0.

I would suggest removing the above two lines and always including the =

reason & flags, but if it's worthwhile to optimize out either attribute =

then please explain.

> +
> +	if (nla_put_u32(skb, MPTCP_ATTR_RESET_REASON, sf->reset_reason))
> +		return -EMSGSIZE;
> +
> +	if (nla_put_u32(skb, MPTCP_ATTR_RESET_FLAGS, sf->reset_transient))
> +		return -EMSGSIZE;
> +
> 	return 0;
> }
>

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 593085610971..64ac8db5b673 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -26,6 +26,7 @@
> #define OPTION_MPTCP_RM_ADDR	BIT(8)
> #define OPTION_MPTCP_FASTCLOSE	BIT(9)
> #define OPTION_MPTCP_PRIO	BIT(10)
> +#define OPTION_MPTCP_RST	BIT(11)
>
> /* MPTCP option subtypes */
> #define MPTCPOPT_MP_CAPABLE	0
> @@ -36,6 +37,7 @@
> #define MPTCPOPT_MP_PRIO	5
> #define MPTCPOPT_MP_FAIL	6
> #define MPTCPOPT_MP_FASTCLOSE	7
> +#define MPTCPOPT_RST		8
>
> /* MPTCP suboption lengths */
> #define TCPOLEN_MPTCP_MPC_SYN		4
> @@ -64,6 +66,7 @@
> #define TCPOLEN_MPTCP_PRIO		3
> #define TCPOLEN_MPTCP_PRIO_ALIGN	4
> #define TCPOLEN_MPTCP_FASTCLOSE		12
> +#define TCPOLEN_MPTCP_RST		4
>
> /* MPTCP MP_JOIN flags */
> #define MPTCPOPT_BACKUP		BIT(0)
> @@ -93,6 +96,18 @@
> /* MPTCP MP_PRIO flags */
> #define MPTCP_PRIO_BKUP		BIT(0)
>
> +/* MPTCP TCPRST flags */
> +#define MPTCP_RST_TRANSIENT	BIT(0)
> +
> +/* MPTCP Reset reason codes, rfc8684 */
> +#define MPTCP_RST_EUNSPEC	0
> +#define MPTCP_RST_EMPTCP	1
> +#define MPTCP_RST_ERESOURCE	2
> +#define MPTCP_RST_EPROHIBIT	3
> +#define MPTCP_RST_EWQ2BIG	4
> +#define MPTCP_RST_EBADPERF	5
> +#define MPTCP_RST_EMIDDLEBOX	6
> +

The MSP_RST_* defines could be useful in include/uapi/linux/mptcp.h


> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e411be079c44..a59dd71deb3e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -187,8 +187,16 @@ static int subflow_check_req(struct request_sock *re=
q,
> 		subflow_req->msk =3D subflow_token_join_request(req);
>
> 		/* Can't fall back to TCP in this case. */
> -		if (!subflow_req->msk)
> +		if (!subflow_req->msk) {


> +			struct mptcp_ext *mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
> +
> +			if (mpext) {
> +				memset(mpext, 0, sizeof(*mpext));
> +				mpext->reset_reason =3D MPTCP_RST_EMPTCP;
> +			}

This chunk of code (with slight variation in the first line) is used in 3 =

places, worth adding a helper function in subflow.c?


Thanks,

Mat


> +
> 			return -EPERM;
> +		}
>
> 		if (subflow_use_different_sport(subflow_req->msk, sk_listener)) {
> 			pr_debug("syn inet_sport=3D%d %d",
> @@ -396,8 +404,10 @@ static void subflow_finish_connect(struct sock *sk, =
const struct sk_buff *skb)
> 	} else if (subflow->request_join) {
> 		u8 hmac[SHA256_DIGEST_SIZE];
>
> -		if (!mp_opt.mp_join)
> +		if (!mp_opt.mp_join) {
> +			subflow->reset_reason =3D MPTCP_RST_EMPTCP;
> 			goto do_reset;
> +		}
>
> 		subflow->thmac =3D mp_opt.thmac;
> 		subflow->remote_nonce =3D mp_opt.nonce;
> @@ -406,6 +416,7 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
>
> 		if (!subflow_thmac_valid(subflow)) {
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
> +			subflow->reset_reason =3D MPTCP_RST_EMPTCP;
> 			goto do_reset;
> 		}
>
> @@ -434,6 +445,7 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
> 	return;
>
> do_reset:
> +	subflow->reset_transient =3D 0;
> 	mptcp_subflow_reset(sk);
> }
>
> @@ -586,6 +598,7 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
> 	struct mptcp_options_received mp_opt;
> 	bool fallback, fallback_is_fatal;
> 	struct sock *new_msk =3D NULL;
> +	struct mptcp_ext *mpext;
> 	struct sock *child;
>
> 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->=
conn);
> @@ -645,8 +658,15 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
> 		 * to reset the context to non MPTCP status.
> 		 */
> 		if (!ctx || fallback) {
> -			if (fallback_is_fatal)
> +			if (fallback_is_fatal) {
> +				mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
> +				if (mpext) {
> +					memset(mpext, 0, sizeof(*mpext));
> +					mpext->reset_reason =3D MPTCP_RST_EMPTCP;
> +				}
> +
> 				goto dispose_child;
> +			}
>
> 			subflow_drop_ctx(child);
> 			goto out;
> @@ -681,8 +701,15 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
> 			struct mptcp_sock *owner;
>
> 			owner =3D subflow_req->msk;
> -			if (!owner)
> +			if (!owner) {
> +				mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
> +				if (mpext) {
> +					memset(mpext, 0, sizeof(*mpext));
> +					mpext->reset_reason =3D MPTCP_RST_EPROHIBIT;
> +				}
> +
> 				goto dispose_child;
> +			}
>
> 			/* move the msk reference ownership to the subflow */
> 			subflow_req->msk =3D NULL;
> @@ -1046,6 +1073,8 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
> 	smp_wmb();
> 	ssk->sk_error_report(ssk);
> 	tcp_set_state(ssk, TCP_CLOSE);
> +	subflow->reset_transient =3D 0;
> +	subflow->reset_reason =3D MPTCP_RST_EMPTCP;
> 	tcp_send_active_reset(ssk, GFP_ATOMIC);
> 	subflow->data_avail =3D 0;
> 	return false;
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============0986707313503138142==--
