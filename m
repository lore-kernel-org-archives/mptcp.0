Content-Type: multipart/mixed; boundary="===============6486235362388068549=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: Basic single-subflow DATA_FIN
Date: Tue, 19 Nov 2019 12:20:43 +0100
Message-ID: <5e039794348488bfe1d6206efde86bddcc449e0c.camel@redhat.com>
In-Reply-To: 20191119003121.26945-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2600

--===============6486235362388068549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm sorry for lagging behind with the reviews...

On Mon, 2019-11-18 at 16:31 -0800, Mat Martineau wrote:
> @@ -405,6 +435,10 @@ static bool mptcp_established_options_dss(struct soc=
k *sk, struct sk_buff *skb,
>  			dss_size =3D map_size;
>  			if (mpext)
>  				opts->ext_copy =3D *mpext;
> +
> +			if (skb && tcp_fin &&
> +			    subflow->conn->sk_state !=3D TCP_ESTABLISHED)
> +				mptcp_write_data_fin(subflow, &opts->ext_copy);
>  		} else {
>  			opts->ext_copy.use_map =3D 0;
>  			WARN_ONCE(1, "MPTCP: Map dropped");

Don't we need some additional check to avoid sending multiple DATA_FIN
on all subflows ?!? e.g. fiddling with some bit status bit on msk.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1a432abfb176..910cf26037b7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1284,6 +1284,10 @@ static int mptcp_shutdown(struct socket *sock, int=
 how)
>  	pr_debug("sk=3D%p, how=3D%d", msk, how);
>  =

>  	lock_sock(sock->sk);
> +
> +	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
> +		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
> +
>  	ssock =3D __mptcp_fallback_get_ref(msk);
>  	if (ssock) {
>  		release_sock(sock->sk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ff38d54392cd..89e6533c97b6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -422,6 +422,7 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk)
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
>  	struct mptcp_ext *mpext;
>  	struct sk_buff *skb;
> +	u16 data_len;
>  	u64 map_seq;
>  =

>  	skb =3D skb_peek(&ssk->sk_receive_queue);
> @@ -446,26 +447,39 @@ static enum mapping_status get_mapping_status(struc=
t sock *ssk)
>  =

>  		if (!subflow->map_valid)
>  			return MAPPING_INVALID;
> +
>  		goto validate_seq;
>  	}
>  =

> -	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u", mpext->data_seq,
> -		 mpext->dsn64, mpext->subflow_seq, mpext->data_len);
> +	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u data_fin=3D%d",
> +		 mpext->data_seq, mpext->dsn64, mpext->subflow_seq,
> +		 mpext->data_len, mpext->data_fin);
>  =

> -	if (mpext->data_len =3D=3D 0) {
> +	data_len =3D mpext->data_len;
> +	if (data_len =3D=3D 0) {
>  		pr_err("Infinite mapping not handled");
>  		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
>  		return MAPPING_INVALID;
> -	} else if (mpext->subflow_seq =3D=3D 0 &&
> -		   mpext->data_fin =3D=3D 1) {
> -		if (WARN_ON_ONCE(mpext->data_len !=3D 1))
> -			return false;
> +	}
>  =

> -		/* do not try hard to handle this any better, till we have
> -		 * real data_fin support
> -		 */
> -		pr_debug("DATA_FIN with no payload");
> -		return MAPPING_DATA_FIN;
> +	if (mpext->data_fin =3D=3D 1) {
> +		if (data_len =3D=3D 1) {
> +			pr_debug("DATA_FIN with no payload");
> +			if (subflow->map_valid) {
> +				/* A DATA_FIN might arrive in a DSS
> +				 * option before the previous mapping
> +				 * has been fully consumed. Continue
> +				 * handling the existing mapping.
> +				 */
> +				skb_ext_del(skb, SKB_EXT_MPTCP);
> +				return MAPPING_OK;
> +			} else {
> +				return MAPPING_DATA_FIN;
> +			}

Can we instead:
	data_len--;
	WRITE_ONCE(msk->data_fin_set, 1);
	WRITE_ONCE(msk->data_fin_seq, mpext->data_seq + data_len);

and than in mptcp_recvmsg():

	if (READ_ONCE(msk->data_fin_seq) &&
	    msk->ack_seq =3D=3D msk->data_fin_seq)
		msk->ack_seq++;

(or something along these lines)

?

Thanks,

Paolo

--===============6486235362388068549==--
