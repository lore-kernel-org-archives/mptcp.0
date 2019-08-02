Content-Type: multipart/mixed; boundary="===============6312905038234831421=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 09/10] Use pm_get_local_id() to get the real
 local address id.
Date: Fri, 02 Aug 2019 16:42:51 +0200
Message-ID: <85a5ecdc57fdf6ec3dc2f1bf3ff3eaf405408327.camel@redhat.com>
In-Reply-To: 20190726015827.10637-10-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1580

--===============6312905038234831421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-25 at 18:58 -0700, Peter Krystad wrote:
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index b31d98ba5c0d..8e4da2d05f45 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -223,13 +223,15 @@ int token_join_request(struct request_sock *req, co=
nst struct sk_buff *skb)
>  	spin_lock_bh(&token_tree_lock);
>  	conn =3D lookup_token(subflow_req->token);
>  	spin_unlock_bh(&token_tree_lock);
> -	if (conn) {
> -		// @@ get real local address id for this skb->saddr
> -		subflow_req->local_id =3D 0;
> -		new_req_join(req, conn, skb);
> -		return 0;
> -	}
> -	return -1;
> +	if (!conn)
> +		return -1;
> +
> +	if (pm_get_local_id(req, conn, skb))
> +		return -1;
> +
> +	new_req_join(req, conn, skb);
> +
> +	return 0;
>  }

I'm sorry for the late doubt, but I think we should acquire a refcnt to
conn while holding the token_tree_lock to protect vs cuncurrent
shutdown of the 'conn' socket after the lookup.

Perhaps adding a new helper, alike 'token_lookup_get()' would help.

token_join_valid() has possibly the same issue.

/P


--===============6312905038234831421==--
