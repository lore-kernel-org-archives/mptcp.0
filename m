Content-Type: multipart/mixed; boundary="===============0911399005763305136=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 05/10] mptcp: token: fold new_req_join into
 its caller
Date: Tue, 27 Aug 2019 17:14:05 -0700
Message-ID: <7acba77aabc4175c9919673d3dbd393d0099a686.camel@linux.intel.com>
In-Reply-To: 20190825185939.21596-6-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1728

--===============0911399005763305136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Same comment as previous patch, this could also be moved to subflow.c
and token_lookup_get() used.

Peter.

On Sun, 2019-08-25 at 20:59 +0200, Florian Westphal wrote:
> similar to the previous change.  Fold the (small) helper, then
> rename the function to carry an mptcp prefix.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.h |  3 ++-
>  net/mptcp/subflow.c  |  2 +-
>  net/mptcp/token.c    | 52 ++++++++++++++++++++++++--------------------
>  3 files changed, 32 insertions(+), 25 deletions(-)
> =

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 19dcc49202ba..4754cf456759 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -226,7 +226,8 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able);
>  void mptcp_finish_join(struct sock *sk);
>  =

>  void token_new_request(struct request_sock *req, const struct sk_buff *s=
kb);
> -int token_join_request(struct request_sock *req, const struct sk_buff *s=
kb);
> +bool mptcp_token_join_request(struct request_sock *req,
> +			      const struct sk_buff *skb);
>  bool mptcp_token_join_valid(const struct request_sock *req,
>  			    const struct tcp_options_received *rx_opt);
>  void token_destroy_request(u32 token);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 7e479c95e3e5..e30bd54adb1b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -89,7 +89,7 @@ static void subflow_v4_init_req(struct request_sock *re=
q,
>  		subflow_req->remote_nonce =3D rx_opt.mptcp.nonce;
>  		pr_debug("token=3D%u, remote_nonce=3D%u", subflow_req->token,
>  			 subflow_req->remote_nonce);
> -		if (token_join_request(req, skb)) {
> +		if (!mptcp_token_join_request(req, skb)) {
>  			subflow_req->mp_join =3D 0;
>  			// @@ need to trigger RST
>  		}
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 946a53496d47..def65cac5e63 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -75,23 +75,6 @@ static void new_req_token(struct request_sock *req,
>  		 subflow_req->token, subflow_req->idsn);
>  }
>  =

> -static void new_req_join(struct request_sock *req, struct sock *sk,
> -			 const struct sk_buff *skb)
> -{
> -	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
> -	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	u8 hmac[MPTCPOPT_HMAC_LEN];
> -
> -	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
> -	crypto_hmac_sha1(msk->local_key, msk->remote_key,
> -			 subflow_req->local_nonce, subflow_req->remote_nonce,
> -			 (u32 *)hmac);
> -
> -	subflow_req->thmac =3D get_unaligned_be64(hmac);
> -	pr_debug("local_nonce=3D%u, thmac=3D%llu", subflow_req->local_nonce,
> -		 subflow_req->thmac);
> -}
> -
>  static void new_token(const struct sock *sk)
>  {
>  	struct subflow_context *subflow =3D subflow_ctx(sk);
> @@ -175,10 +158,24 @@ void token_new_request(struct request_sock *req,
>  	spin_unlock_bh(&token_tree_lock);
>  }
>  =

> -/* validate received token and create truncated hmac and nonce for SYN-A=
CK */
> -int token_join_request(struct request_sock *req, const struct sk_buff *s=
kb)
> +/**
> + * mptcp_token_join_request - validate received token and create hmac
> + * @req - the request socket that received the ACK
> + * @skb - the syn packet received
> + *
> + * This function is called when a new SYN is received that indicates a
> + * join with an existing MPTCP flow.
> + * It will compute the HMAC and nonce that will be included in the SYN/A=
CK.
> + *
> + * Returns true on success and false if the join request indicated an in=
valid
> + * MPTCP connection (i.e., the mptcp token is not known to us).
> + */
> +bool mptcp_token_join_request(struct request_sock *req,
> +			      const struct sk_buff *skb)
>  {
>  	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
> +	u8 hmac[MPTCPOPT_HMAC_LEN];
> +	struct mptcp_sock *msk;
>  	struct sock *conn;
>  =

>  	pr_debug("subflow_req=3D%p, token=3D%u", subflow_req, subflow_req->toke=
n);
> @@ -189,17 +186,26 @@ int token_join_request(struct request_sock *req, co=
nst struct sk_buff *skb)
>  	spin_unlock_bh(&token_tree_lock);
>  =

>  	if (!conn)
> -		return -1;
> +		return false;
>  =

>  	if (pm_get_local_id(req, conn, skb)) {
>  		sock_put(conn);
> -		return -1;
> +		return false;
>  	}
>  =

> -	new_req_join(req, conn, skb);
> +	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
> +
> +	msk =3D mptcp_sk(conn);
> +	crypto_hmac_sha1(msk->local_key, msk->remote_key,
> +			 subflow_req->local_nonce, subflow_req->remote_nonce,
> +			 (u32 *)hmac);
> +
> +	subflow_req->thmac =3D get_unaligned_be64(hmac);
> +	pr_debug("local_nonce=3D%u, thmac=3D%llu", subflow_req->local_nonce,
> +		 subflow_req->thmac);
>  =

>  	sock_put(conn);
> -	return 0;
> +	return true;
>  }
>  =

>  /**


--===============0911399005763305136==--
