Content-Type: multipart/mixed; boundary="===============7410322541088019114=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] subflow: don't increment msk refcount on join
 connect completion
Date: Mon, 25 Nov 2019 18:19:52 +0100
Message-ID: <ac92da450617b7fb9e59b3e9b508e339f87fd3da.camel@redhat.com>
In-Reply-To: 20191125150133.13185-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2690

--===============7410322541088019114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-25 at 16:01 +0100, Florian Westphal wrote:
> squashto: mptcp: Add handling of outgoing MP_JOIN requests
> =

> The connecting socket already has a refcount, this additional
> increase is never decremented, resulting in the mptcp socket to never get=
 freed.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/subflow.c | 1 -
>  1 file changed, 1 deletion(-)
> =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e6a512bf6230..ba46c0b3a6d7 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -38,7 +38,6 @@ static int subflow_rebuild_header(struct sock *sk)
>  		err =3D mptcp_token_new_connect(sk);
>  	} else if (subflow->request_join && !subflow->local_nonce) {
>  		pr_debug("subflow=3D%p", sk);
> -		mptcp_token_get_sock(subflow->token);
>  =

>  		do {
>  			get_random_bytes(&subflow->local_nonce, sizeof(u32));

yep, it looks like this refcnt is really leaked, ACK!

Paolo

--===============7410322541088019114==--
