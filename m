Content-Type: multipart/mixed; boundary="===============0466583691738334459=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 8/9] mptcp: Add handling of outgoing MP_JOIN
 requests
Date: Thu, 18 Jul 2019 10:04:11 +0200
Message-ID: <b4a80d24babfeb7d2747a4db85505d5b4134af0a.camel@redhat.com>
In-Reply-To: 20190717221256.7358-9-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1527

--===============0466583691738334459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-17 at 15:12 -0700, Peter Krystad wrote:
> @@ -329,6 +381,17 @@ int token_new_join(struct sock *sk)
>  	return -1;
>  }
>  =

> +struct sock *token_lookup(u32 token)
> +{
> +	struct sock *conn;
> +

Possibly some locking is missing ??? like:

	spin_lock_bh(&token_tree_lock);
> +	conn =3D lookup_token(token);
> +	if (conn)
> +		sock_hold(conn);
> +
	spin_unlock_bh(&token_tree_lock);

Sorry for not noticing earlier,

Paolo


--===============0466583691738334459==--
