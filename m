Content-Type: multipart/mixed; boundary="===============3220662826982931710=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 09/10] mptcp: token: fold destroy_token helper
Date: Tue, 27 Aug 2019 17:13:58 -0700
Message-ID: <ed018bb6679ca32d82f9df985a697e9c031113bf.camel@linux.intel.com>
In-Reply-To: 20190825185939.21596-10-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1727

--===============3220662826982931710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-08-25 at 20:59 +0200, Florian Westphal wrote:
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c |  2 +-
>  net/mptcp/protocol.h |  4 ++--
>  net/mptcp/subflow.c  |  2 +-
>  net/mptcp/token.c    | 50 +++++++++++++++++++-------------------------
>  4 files changed, 25 insertions(+), 33 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f900303a1531..6a2dc2111316 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -704,7 +704,7 @@ static void mptcp_destroy(struct sock *sk)
>  =

>  	pr_debug("msk=3D%p, subflow=3D%p", sk, msk->subflow->sk);
>  =

> -	token_destroy(msk->token);
> +	mptcp_token_destroy(msk->token);
>  }
>  =

>  /* Only pass a small subset of level/optnames that are considered safe.
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a1e207db6703..94b06ec168ff 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -230,13 +230,13 @@ bool mptcp_token_join_request(struct request_sock *=
req,
>  			      const struct sk_buff *skb);
>  bool mptcp_token_join_valid(const struct request_sock *req,
>  			    const struct tcp_options_received *rx_opt);
> -void token_destroy_request(u32 token);
> +void mptcp_token_destroy_request(u32 token);
>  int mptcp_token_new_connect(struct sock *sk);
>  int mptcp_token_new_accept(u32 token);
>  void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
>  struct mptcp_sock *mptcp_token_get_sock(u32 token);
>  void token_release(u32 token);
> -void token_destroy(u32 token);
> +void mptcp_token_destroy(u32 token);
>  =

>  void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
>  static inline void crypto_key_gen_sha1(u64 *key, u32 *token, u64 *idsn)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 85fb7a52e274..1cfd18e74486 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -45,7 +45,7 @@ static void subflow_req_destructor(struct request_sock =
*req)
>  	pr_debug("subflow_req=3D%p", subflow_req);
>  =

>  	if (subflow_req->mp_capable)
> -		token_destroy_request(subflow_req->token);
> +		mptcp_token_destroy_request(subflow_req->token);
>  	tcp_request_sock_ops.destructor(req);
>  }
>  =

> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index a0779fd0ae7c..3c1f43542e1e 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -39,31 +39,7 @@ static int token_used __read_mostly;
>  =

>  static struct sock *__token_lookup(u32 token)
>  {
> -	void *conn;
> -
> -	pr_debug("token=3D%u", token);
> -	conn =3D radix_tree_lookup(&token_tree, token);
> -	return (struct sock *)conn;
> -}
> -
> -static void destroy_req_token(u32 token)
> -{
> -	void *cur;
> -
> -	cur =3D radix_tree_delete(&token_req_tree, token);
> -	if (!cur)
> -		pr_warn("token NOT FOUND!");
> -}
> -
> -static struct sock *destroy_token(u32 token)
> -{
> -	void *conn;
> -
> -	pr_debug("token=3D%u", token);
> -	conn =3D radix_tree_delete(&token_tree, token);
> -	if (conn && conn !=3D &token_used)
> -		return (struct sock *)conn;
> -	return NULL;
> +	return radix_tree_lookup(&token_tree, token);
>  }
>  =

>  /**
> @@ -321,12 +297,21 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
>  	return mptcp_sk(conn);
>  }
>  =

> -void token_destroy_request(u32 token)
> +/**
> + * mptcp_token_destroy_request - remove mptcp connection/token
> + * @token - token of mptcp connection to remove
> + *
> + * Remove the not-yey-fully-established incoming connection identified
> + * by @token. If the connection isn't found, no action is taken.
> + */

I would reword these comments to refer to a "connection request", there isn=
't
a connection to remove.

Peter.


> +void mptcp_token_destroy_request(u32 token)
>  {
> +	const void *cur;
> +
>  	pr_debug("token=3D%u", token);
>  =

>  	spin_lock_bh(&token_tree_lock);
> -	destroy_req_token(token);
> +	cur =3D radix_tree_delete(&token_req_tree, token);
>  	spin_unlock_bh(&token_tree_lock);
>  }
>  =

> @@ -342,13 +327,20 @@ void token_release(u32 token)
>  	spin_unlock_bh(&token_tree_lock);
>  }
>  =

> -void token_destroy(u32 token)
> +/**
> + * mptcp_token_destroy - remove mptcp connection/token
> + * @token - token of mptcp connection to remove
> + *
> + * Remove the connection identified by @token.
> + * If the connection isn't found, no action is taken.
> + */
> +void mptcp_token_destroy(u32 token)
>  {
>  	struct sock *conn;
>  =

>  	pr_debug("token=3D%u", token);
>  	spin_lock_bh(&token_tree_lock);
> -	conn =3D destroy_token(token);
> +	conn =3D radix_tree_delete(&token_tree, token);
>  	if (conn)
>  		sock_put(conn);
>  	spin_unlock_bh(&token_tree_lock);


--===============3220662826982931710==--
