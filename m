Content-Type: multipart/mixed; boundary="===============2676310270571726248=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/3] mptcp: process MP_CAPABLE data option.
Date: Wed, 04 Dec 2019 18:06:37 -0800
Message-ID: <3e1d01ddcc7c9f499fdcca012698d8282761e03c.camel@linux.intel.com>
In-Reply-To: 20191202171504.88739-4-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2789

--===============2676310270571726248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi, uh, Christoph,

On Mon, 2019-12-02 at 09:15 -0800, Christoph Paasch wrote:
> This patch implement the handling of MP_CAPABLE + data option, as
> per RFC 6824 bis - MPTCP v1.
> =

> On the server side we can receive the remote key after that the connection
> is established. We need to explicitly track the 'missing remote key'
> status and avoid emtting mptcp ack till we get such info.
> =

> When a late/retransmitted/OoO pkt carrying MP_CAPABLE[+data] option
> is received, we have to propagate the mptcp seq number info to
> the msk socket. To avoid ABBA locking issue, explicitly check for
> that in recvmsg(), where we own msk and subflow sock locks.
> =

> The above also means that an established mp_capable subflow - still
> waiting for the remote key - can be 'downgraded' to plain TCP.
> =

> Such change could potentially block forever reader waiting for new
> data - as they hook to msk, while later wake-up after the downgrade
> will be on subflow only.
> =

> The above issue is not handled here, we likely have to get rid of
> msk->fallback to handle that cleanly.
> =

> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
>  net/mptcp/options.c  | 48 +++++++++++++++++++++++++++++++++++---------
>  net/mptcp/protocol.c | 20 ++++++++++++------
>  net/mptcp/protocol.h |  8 ++++++--
>  net/mptcp/subflow.c  | 37 +++++++++++++++++++++++++++++-----
>  4 files changed, 91 insertions(+), 22 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 299af8e5456d..0b80a24c34b4 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -299,6 +299,7 @@ void mptcp_rcv_synsent(struct sock *sk)
>  	pr_debug("subflow=3D%p", subflow);
>  	if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
>  		subflow->mp_capable =3D 1;
> +		subflow->can_ack =3D 1;
>  		subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
>  	}
>  }
> @@ -365,6 +366,7 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
>  					  unsigned int remaining,
>  					  struct mptcp_out_options *opts)
>  {
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>  	unsigned int dss_size =3D 0;
>  	struct mptcp_ext *mpext;
>  	struct mptcp_sock *msk;
> @@ -383,6 +385,11 @@ static bool mptcp_established_options_dss(struct soc=
k *sk, struct sk_buff *skb,
>  			opts->ext_copy =3D *mpext;
>  	}
>  =

> +	opts->ext_copy.use_ack =3D 0;
> +	msk =3D mptcp_sk(subflow->conn);
> +	if (!msk || !READ_ONCE(msk->can_ack))
> +		return false;
> +
>  	ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
>  =

>  	/* Add kind/length/subtype/flag overhead if mapping is not populated */
> @@ -391,15 +398,7 @@ static bool mptcp_established_options_dss(struct soc=
k *sk, struct sk_buff *skb,
>  =

>  	dss_size +=3D ack_size;
>  =

> -	msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> -	if (msk) {
> -		opts->ext_copy.data_ack =3D msk->ack_seq;
> -	} else {
> -		mptcp_crypto_key_sha(mptcp_subflow_ctx(sk)->remote_key,
> -				     NULL, &opts->ext_copy.data_ack);
> -		opts->ext_copy.data_ack++;
> -	}
> -
> +	opts->ext_copy.data_ack =3D msk->ack_seq;
>  	opts->ext_copy.ack64 =3D 1;
>  	opts->ext_copy.use_ack =3D 1;
>  =

> @@ -451,6 +450,35 @@ bool mptcp_synack_options(const struct request_sock =
*req, unsigned int *size,
>  	return false;
>  }
>  =

> +static bool check_fourth_ack(struct mptcp_subflow_context *subflow,
> +			     struct sk_buff *skb,
> +			     struct mptcp_options_received *mp_opt)
> +{
> +	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
> +	 * are relevant
> +	 */
> +	if (likely(subflow->fourth_ack ||
> +		   TCP_SKB_CB(skb)->seq !=3D subflow->ssn_offset + 1))
> +		return true;
> +
> +	if (mp_opt->use_ack)
> +		subflow->fourth_ack =3D 1;
> +
> +	if (subflow->can_ack)
> +		return true;
> +
> +	/* if still waiting for remote/client key, we exepct an
> +	 * MP_CAPABLE + data as first establish packet
> +	 */

Maybe this comment can clearly state that this is a fallback?
"If the first established packet does not contain MP_CAPABLE + data then
fallback to TCP". =

 =

> +	if (!mp_opt->mp_capable) {
> +		subflow->mp_capable =3D 0;
> +		return false;
> +	}
> +	subflow->remote_key =3D mp_opt->sndr_key;
> +	subflow->can_ack =3D 1;
> +	return true;
> +}
> +
>  void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
>  			    struct tcp_options_received *opt_rx)
>  {
> @@ -462,6 +490,8 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
>  		return;
>  =

>  	mp_opt =3D &opt_rx->mptcp;
> +	if (!check_fourth_ack(subflow, skb, mp_opt))
> +		return;
>  =

>  	if (!mp_opt->dss)
>  		return;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4b000f842d6b..1076f0887cd5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -347,6 +347,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>  =

>  		lock_sock(ssk);
>  		while (mptcp_subflow_data_available(ssk) && !done) {
> +			if (unlikely(!msk->can_ack)) {
> +				msk->remote_key =3D subflow->remote_key;
> +				msk->ack_seq =3D subflow->map_seq;
> +				msk->can_ack =3D true;
> +			}
> +
>  			/* try to read as much data as available */
>  			map_remaining =3D subflow->map_data_len -
>  					mptcp_subflow_get_map_offset(subflow);
> @@ -505,17 +511,20 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
>  		__mptcp_init_sock(new_mptcp_sock);
>  =

>  		msk =3D mptcp_sk(new_mptcp_sock);
> -		msk->remote_key =3D subflow->remote_key;
>  		msk->local_key =3D subflow->local_key;
>  		msk->token =3D subflow->token;
>  =

>  		mptcp_token_update_accept(new_sock->sk, new_mptcp_sock);
>  		msk->subflow =3D NULL;
>  =

> -		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
>  		msk->write_seq =3D subflow->idsn + 1;
> -		ack_seq++;
> -		msk->ack_seq =3D ack_seq;
> +		if (subflow->can_ack) {
> +			msk->can_ack =3D true;
> +			msk->remote_key =3D subflow->remote_key;
> +			mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
> +			ack_seq++;
> +			msk->ack_seq =3D ack_seq;
> +		}
>  		newsk =3D new_mptcp_sock;
>  		list_add(&subflow->node, &msk->conn_list);
>  		bh_unlock_sock(new_mptcp_sock);
> @@ -527,8 +536,6 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
>  		 * the receive path and process the pending ones
>  		 */
>  		lock_sock(new_sock->sk);
> -		subflow->map_seq =3D ack_seq;
> -		subflow->map_subflow_seq =3D 1;
>  		subflow->rel_write_seq =3D 1;
>  		subflow->tcp_sock =3D new_sock;
>  		subflow->conn =3D new_mptcp_sock;
> @@ -656,6 +663,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
>  		msk->write_seq =3D subflow->idsn + 1;
>  		ack_seq++;
>  		msk->ack_seq =3D ack_seq;
> +		msk->can_ack =3D 1;
>  		subflow->map_seq =3D ack_seq;
>  		subflow->map_subflow_seq =3D 1;
>  		subflow->rel_write_seq =3D 1;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index bdff743cf2b3..7630d8860319 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -66,6 +66,7 @@ struct mptcp_sock {
>  	u64		ack_seq;
>  	u32		token;
>  	unsigned long	flags;
> +	bool		can_ack;
>  	struct list_head conn_list;
>  	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
>  };
> @@ -80,9 +81,10 @@ static inline struct mptcp_sock *mptcp_sk(const struct=
 sock *sk)
>  =

>  struct mptcp_subflow_request_sock {
>  	struct	tcp_request_sock sk;
> -	u8	mp_capable : 1,
> +	u16	mp_capable : 1,
>  		mp_join : 1,
>  		backup : 1,
> +		remote_key_valid : 1,
>  		version : 4;
>  	u64	local_key;
>  	u64	remote_key;
> @@ -116,8 +118,10 @@ struct mptcp_subflow_context {
>  		fourth_ack : 1,	    /* send initial DSS */
>  		conn_finished : 1,
>  		map_valid : 1,
> +		mp_capable_map : 1,
>  		data_avail : 1,
> -		rx_eof : 1;
> +		rx_eof : 1,
> +		can_ack : 1;	    /* only after processing the remote a key */
>  =

>  	struct	socket *tcp_sock;   /* underlying tcp_sock */
>  	struct	sock *conn;	    /* parent mptcp_sock */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 96cc80f8d751..255e3762b39c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -61,6 +61,7 @@ static void subflow_init_req(struct request_sock *req,
>  	mptcp_get_options(skb, &rx_opt);
>  =

>  	subflow_req->mp_capable =3D 0;
> +	subflow_req->remote_key_valid =3D 0;
>  =

>  #ifdef CONFIG_TCP_MD5SIG
>  	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> @@ -188,17 +189,28 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
>  =

>  	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener-=
>conn);
>  =

> -	/* if the sk is MP_CAPABLE, we need to fetch the client key */
> +	/* if the sk is MP_CAPABLE, we try to fetch the client key */

Maybe this comment should be moved down to where the code fetching the
remote key is now that more code has been added here.

>  	subflow_req =3D mptcp_subflow_rsk(req);
>  	if (subflow_req->mp_capable) {
> +		if (TCP_SKB_CB(skb)->seq !=3D subflow_req->ssn_offset + 1) {
> +			/* here we can receive and accept an in-window,
> +			 * out-of-order pkt, which will not carry the MP_CAPABLE
> +			 * opt even on mptcp enabled paths
> +			 */
> +			goto create_child;
> +		}

So this means we will create the child socket even without receiving the
MP_CAPABLE ACK? Will there be side-effects of there are a lot of such packe=
ts?

> +
>  		opt_rx.mptcp.mp_capable =3D 0;
>  		mptcp_get_options(skb, &opt_rx);
> -		if (!opt_rx.mptcp.mp_capable)
> -			subflow_req->mp_capable =3D 0;
> -		else
> +		if (opt_rx.mptcp.mp_capable) {
>  			subflow_req->remote_key =3D opt_rx.mptcp.sndr_key;
> +			subflow_req->remote_key_valid =3D 1;
> +		} else {
> +			subflow_req->mp_capable =3D 0;
> +		}
>  	}
>  =

> +create_child:
>  	child =3D listener->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
>  						     req_unhash, own_req);
>  =

> @@ -363,6 +375,7 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk)
>  	subflow->map_subflow_seq =3D mpext->subflow_seq;
>  	subflow->map_data_len =3D mpext->data_len;
>  	subflow->map_valid =3D 1;
> +	subflow->mp_capable_map =3D mpext->mp_capable_map;
>  	pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u",
>  		 subflow->map_seq, subflow->map_subflow_seq,
>  		 subflow->map_data_len);
> @@ -414,6 +427,16 @@ static bool subflow_check_data_avail(struct sock *ss=
k)
>  		if (WARN_ON_ONCE(!skb))
>  			return false;
>  =

> +		/* if msk lacks the remote key, this subflow must provide an
> +		 * MP_CAPABLE-based mapping
> +		 */
> +		if (unlikely(!READ_ONCE(msk->ack_seq))) {
> +			if (subflow->mp_capable_map)
> +				break;
> +			ssk->sk_err =3D EBADMSG;
> +			goto fatal;
> +		}
> +
>  		old_ack =3D READ_ONCE(msk->ack_seq);
>  		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
>  		pr_debug("msk ack_seq=3D%llx subflow ack_seq=3D%llx", old_ack,
> @@ -651,8 +674,12 @@ static void subflow_ulp_clone(const struct request_s=
ock *req,
>  	new_ctx->tcp_sk_data_ready =3D old_ctx->tcp_sk_data_ready;
>  =

>  	if (subflow_req->mp_capable) {
> +		/* see comments in subflow_syn_recv_sock(), MPTCP connection
> +		 * is fully establishged only after we receive the remote key

Detail: "established".

Peter.

> +		 */
>  		new_ctx->mp_capable =3D 1;
> -		new_ctx->fourth_ack =3D 1;
> +		new_ctx->fourth_ack =3D subflow_req->remote_key_valid;
> +		new_ctx->can_ack =3D subflow_req->remote_key_valid;
>  		new_ctx->remote_key =3D subflow_req->remote_key;
>  		new_ctx->local_key =3D subflow_req->local_key;
>  		new_ctx->token =3D subflow_req->token;

--===============2676310270571726248==--
