Content-Type: multipart/mixed; boundary="===============8386349345841888631=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 1/4] Squash-to: "mptcp: Handle MP_CAPABLE
 options for outgoing connections"
Date: Sat, 21 Dec 2019 02:05:51 +0100
Message-ID: <20191221010551.GE795@breakpoint.cc>
In-Reply-To: a91929d1327d846a715ef6655311acae49285ae5.1576867317.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3242

--===============8386349345841888631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -262,23 +262,19 @@ static void subflow_ulp_clone(const struct request_=
sock *req,
>  	struct mptcp_subflow_context *old_ctx =3D mptcp_subflow_ctx(newsk);
>  	struct mptcp_subflow_context *new_ctx;
>  =

> -	/* newsk->sk_socket is NULL at this point */
> -	new_ctx =3D subflow_create_ctx(newsk, priority);
> -	if (!new_ctx)
> +	if (!subflow_req->mp_capable ||
> +	    (new_ctx =3D subflow_create_ctx(newsk, priority)) =3D=3D NULL) {
> +		tcp_sk(newsk)->is_mptcp =3D 0;
>  		return;
> +	}

I would prefer to avoid assignment inside a conditional.

Otherwise change looks useful to me.
--===============8386349345841888631==--
