Content-Type: multipart/mixed; boundary="===============2611152739897379418=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 03/10] mptcp: token: rename token_join_response
Date: Tue, 27 Aug 2019 17:14:09 -0700
Message-ID: <06717d437cc8e881e2714591404d11a9d5c3f9f9.camel@linux.intel.com>
In-Reply-To: 20190825185939.21596-4-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1729

--===============2611152739897379418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-08-25 at 20:59 +0200, Florian Westphal wrote:
> This function validates the truncated hmac and computes a hmac for use
> in the ack packet.  Rename it and place it where its used.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.h |  1 -
>  net/mptcp/subflow.c  | 28 +++++++++++++++++++++++++++-
>  net/mptcp/token.c    | 31 -------------------------------
>  3 files changed, 27 insertions(+), 33 deletions(-)
> =

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1655283dbd6a..89bd68f85856 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -227,7 +227,6 @@ void mptcp_finish_join(struct sock *sk);
>  =

>  void token_new_request(struct request_sock *req, const struct sk_buff *s=
kb);
>  int token_join_request(struct request_sock *req, const struct sk_buff *s=
kb);
> -int token_join_response(struct sock *sk);
>  int token_join_valid(struct request_sock *req,
>  		     struct tcp_options_received *rx_opt);
>  void token_destroy_request(u32 token);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index fc507e091cf5..72ad9a324677 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -96,6 +96,32 @@ static void subflow_v4_init_req(struct request_sock *r=
eq,
>  	}
>  }
>  =

> +/* validate received truncated hmac and create hmac for third ACK */
> +static bool subflow_hmac_ok(struct subflow_context *subflow)

Consider subflow_thmac_valid for this name? The routine is similiar in
function to token_join_valid so maintain 'valid' naming convention? And
'thmac' is what is being validated, hmac is a different field in subflow.
 =

> +{
> +	u8 hmac[MPTCPOPT_HMAC_LEN];
> +	u64 thmac;
> +
> +	pr_debug("subflow=3D%p, token=3D%u", subflow, subflow->token);
> +
> +	crypto_hmac_sha1(subflow->remote_key, subflow->local_key,
> +			 subflow->remote_nonce, subflow->local_nonce,
> +			 (u32 *)hmac);
> +
> +	thmac =3D get_unaligned_be64(hmac);
> +	pr_debug("thmac=3D%llu", thmac);
> +
> +	if (thmac !=3D subflow->thmac) {
> +		pr_info("HMAC FAILURE: %llx vs %llx\n", thmac, subflow->thmac);
> +		return false;
> +	}
> +
> +	crypto_hmac_sha1(subflow->local_key, subflow->remote_key,
> +			 subflow->local_nonce, subflow->remote_nonce,
> +			 (u32 *)subflow->hmac);

Consider moving this call to the successful branch of the caller so this
routine does one thing: validate thmac.

Peter.

> +	return true;
> +}
> +
>  static void subflow_finish_connect(struct sock *sk, const struct sk_buff=
 *skb)
>  {
>  	struct subflow_context *subflow =3D subflow_ctx(sk);
> @@ -119,7 +145,7 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
>  		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u",
>  			 subflow_ctx(sk), subflow->thmac,
>  			 subflow->remote_nonce);
> -		if (token_join_response(sk)) {
> +		if (!subflow_hmac_ok(subflow)) {
>  			subflow->mp_join =3D 0;
>  			// @@ need to trigger RST
>  		} else {
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 329ea407adf2..fc0cbd76d7a1 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -91,28 +91,6 @@ static void new_req_join(struct request_sock *req, str=
uct sock *sk,
>  		 subflow_req->thmac);
>  }
>  =

> -static int new_rsp_join(struct sock *sk)
> -{
> -	struct subflow_context *subflow =3D subflow_ctx(sk);
> -	u8 hmac[MPTCPOPT_HMAC_LEN];
> -	u64 thmac;
> -
> -	crypto_hmac_sha1(subflow->remote_key, subflow->local_key,
> -			 subflow->remote_nonce, subflow->local_nonce,
> -			 (u32 *)hmac);
> -
> -	thmac =3D get_unaligned_be64(hmac);
> -	pr_debug("thmac=3D%llu", thmac);
> -	if (thmac !=3D subflow->thmac)
> -		return -1;
> -
> -	crypto_hmac_sha1(subflow->local_key, subflow->remote_key,
> -			 subflow->local_nonce, subflow->remote_nonce,
> -			 (u32 *)subflow->hmac);
> -
> -	return 0;
> -}
> -
>  static int new_join_valid(struct request_sock *req, struct sock *sk,
>  			  struct tcp_options_received *rx_opt)
>  {
> @@ -237,15 +215,6 @@ int token_join_request(struct request_sock *req, con=
st struct sk_buff *skb)
>  	return 0;
>  }
>  =

> -/* validate received truncated hmac and create hmac for third ACK */
> -int token_join_response(struct sock *sk)
> -{
> -	struct subflow_context *subflow =3D subflow_ctx(sk);
> -
> -	pr_debug("subflow=3D%p, token=3D%u", subflow, subflow->token);
> -	return new_rsp_join(sk);
> -}
> -
>  /* validate hmac received in third ACK */
>  int token_join_valid(struct request_sock *req,
>  		     struct tcp_options_received *rx_opt)


--===============2611152739897379418==--
