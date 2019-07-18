Content-Type: multipart/mixed; boundary="===============2051033282886698942=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 8/9] mptcp: Add handling of outgoing MP_JOIN
 requests
Date: Thu, 18 Jul 2019 09:50:53 +0200
Message-ID: <19a9b1bf594828a7fe016576ce03cd0b2f35ea52.camel@redhat.com>
In-Reply-To: 20190717221256.7358-9-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1526

--===============2051033282886698942==
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
> +	conn =3D lookup_token(token);
> +	if (conn)
> +		sock_hold(conn);
> +
> +	return conn;
> +}
> +

Really not a big deal, but this is small, unused in this patch and
looks unrelated to the code added here. As it will be used by the next
one, possibly it's cleaner move definition and declaration there.

Paolo




--===============2051033282886698942==--
