Content-Type: multipart/mixed; boundary="===============5659625426478974385=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 1/4] Squash-to: "mptcp: Handle MP_CAPABLE
 options for outgoing connections"
Date: Fri, 03 Jan 2020 19:29:50 +0100
Message-ID: <d0f7ae07c28b9c256d455fcad92328c946500d72.camel@redhat.com>
In-Reply-To: a91929d1327d846a715ef6655311acae49285ae5.1576867317.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3255

--===============5659625426478974385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-20 at 19:45 +0100, Paolo Abeni wrote:
> After upstream feedback, I just noticed that we actually
> don't clear the is_mptcp field on clone allocation failure.
> =

> Do that and additionally don't allocate at all the subflow if MPC handsha=
ke
> failed.
> =

> Note: we need to update accordingly accept on later patch
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/subflow.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index b9aca17b0b91..7dd8733dc72a 100644
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
 =

We have an additional problem here.

When the MPC handshake and/or allocation fail, we need to clear the
icsk ulp fields, or we will get double free on the old_ctx.

Still trying to clean this thing up...

/P

--===============5659625426478974385==--
