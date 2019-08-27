Content-Type: multipart/mixed; boundary="===============2424361398380968548=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 02/10] mptcp: token: remove two unneeded
 helpers
Date: Tue, 27 Aug 2019 18:59:28 +0200
Message-ID: <56c025d7-b7ec-c34b-8b7f-30784c661f5f@tessares.net>
In-Reply-To: 20190825185939.21596-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1715

--===============2424361398380968548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 25/08/2019 20:59, Florian Westphal wrote:
> There were three flavours of almost the same function:
> =

> token_lookup_get, the base function that takes a token value and
> looks up the mptcp socket associated with it.
> =

> token_new_subflow, same function, but will also set
> subflow->local_nonce.
> =

> token_new_join, just like lookup_get, but assigns the
> looked-up socket to subflow->conn.
> =

> This renames token_lookup_get to mptcp_token_get_sock to avoid
> make it clear this belongs to mptcp namespace, and then
> changes the callers of token_new_subflow to also init the nonce
> and token_new_join to do the assignment in the caller.

Good idea!

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/pm.c       |  6 +++---
>  net/mptcp/protocol.h |  4 +---
>  net/mptcp/subflow.c  | 16 ++++++++++----
>  net/mptcp/token.c    | 51 +++++++++++---------------------------------
>  4 files changed, 29 insertions(+), 48 deletions(-)

(...)

> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 10d0c2341792..329ea407adf2 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c

(...)

> @@ -328,36 +311,28 @@ void token_update_accept(struct sock *sk, struct so=
ck *conn)
>  	spin_unlock_bh(&token_tree_lock);
>  }
>  =

> -int token_new_join(struct sock *sk)
> -{
> -	struct subflow_context *subflow =3D subflow_ctx(sk);
> -	struct sock *conn;
> -
> -	spin_lock_bh(&token_tree_lock);
> -	conn =3D __token_lookup(subflow->token);
> -	if (conn)
> -		sock_hold(conn);
> -	spin_unlock_bh(&token_tree_lock);
> -
> -	if (!conn)
> -		return -1;
> -
> -	subflow->conn =3D conn;
> -
> -	return 0;
> -}
> -
> -struct sock *token_lookup_get(u32 token)
> +/**
> + * mptcp_token_get_sock - retrieve mptcp connection sock using its token
> + * @token - token of the mptcp connection to retrieve
> + *
> + * This function returns the mptcp connection structure with the given t=
oken.
> + * A reference count on the mptcp socket returned is taken.
> + *
> + * returns NULL if no connection with the given token value exists.
> + */
> +struct mptcp_sock *mptcp_token_get_sock(u32 token)
>  {
>  	struct sock *conn;
>  =

>  	spin_lock_bh(&token_tree_lock);
>  	conn =3D __token_lookup(token);
> +	if (conn && WARN_ON_ONCE(conn =3D=3D (struct sock *)&token_used))

Why do we need to do this check after each lookup?

> +		conn =3DNULL;

(detail: a space is missing here).

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2424361398380968548==--
