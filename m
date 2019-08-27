Content-Type: multipart/mixed; boundary="===============8912276132727365938=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 09/10] mptcp: token: fold destroy_token helper
Date: Tue, 27 Aug 2019 19:00:54 +0200
Message-ID: <ebf2bdc7-8133-664e-c4d0-bb68c33e566c@tessares.net>
In-Reply-To: 20190825185939.21596-10-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1717

--===============8912276132727365938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 25/08/2019 20:59, Florian Westphal wrote:
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c |  2 +-
>  net/mptcp/protocol.h |  4 ++--
>  net/mptcp/subflow.c  |  2 +-
>  net/mptcp/token.c    | 50 +++++++++++++++++++-------------------------
>  4 files changed, 25 insertions(+), 33 deletions(-)
> =


(...)

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

yey? or "yay!!!"? maybe more "yet" I guess :-D

> + * by @token. If the connection isn't found, no action is taken.

Is it to explain why we don't do anything with *cur?

> + */
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

Is it no longer needed to check "conn !=3D &token_used" here?

>  		sock_put(conn);
>  	spin_unlock_bh(&token_tree_lock);
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8912276132727365938==--
