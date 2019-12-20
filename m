Content-Type: multipart/mixed; boundary="===============0463644019258272910=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 1/4] Squash-to: "mptcp: Handle MP_CAPABLE
 options for outgoing connections"
Date: Fri, 20 Dec 2019 13:43:05 -0800
Message-ID: <alpine.OSX.2.21.1912201334300.52347@mkavai-mobl.amr.corp.intel.com>
In-Reply-To: a91929d1327d846a715ef6655311acae49285ae5.1576867317.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3239

--===============0463644019258272910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 20 Dec 2019, Paolo Abeni wrote:

> After upstream feedback, I just noticed that we actually
> don't clear the is_mptcp field on clone allocation failure.
>
> Do that and additionally don't allocate at all the subflow if MPC handsha=
ke
> failed.
>
> Note: we need to update accordingly accept on later patch
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/subflow.c | 20 ++++++++------------
> 1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index b9aca17b0b91..7dd8733dc72a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -262,23 +262,19 @@ static void subflow_ulp_clone(const struct request_=
sock *req,
> 	struct mptcp_subflow_context *old_ctx =3D mptcp_subflow_ctx(newsk);
> 	struct mptcp_subflow_context *new_ctx;
>
> -	/* newsk->sk_socket is NULL at this point */
> -	new_ctx =3D subflow_create_ctx(newsk, priority);
> -	if (!new_ctx)
> +	if (!subflow_req->mp_capable ||
> +	    (new_ctx =3D subflow_create_ctx(newsk, priority)) =3D=3D NULL) {
> +		tcp_sk(newsk)->is_mptcp =3D 0;
> 		return;
> +	}
>
> 	new_ctx->conn =3D NULL;

subflow_create_ctx() uses kzalloc, so we can also drop this initialization =

of new_ctx->conn.

> 	new_ctx->conn_finished =3D 1;
> 	new_ctx->icsk_af_ops =3D old_ctx->icsk_af_ops;
> -
> -	if (subflow_req->mp_capable) {
> -		new_ctx->mp_capable =3D 1;
> -		new_ctx->fourth_ack =3D 1;
> -		new_ctx->remote_key =3D subflow_req->remote_key;
> -		new_ctx->local_key =3D subflow_req->local_key;
> -	} else {
> -		tcp_sk(newsk)->is_mptcp =3D 0;
> -	}
> +	new_ctx->mp_capable =3D 1;
> +	new_ctx->fourth_ack =3D 1;
> +	new_ctx->remote_key =3D subflow_req->remote_key;
> +	new_ctx->local_key =3D subflow_req->local_key;
> }
>
> static struct tcp_ulp_ops subflow_ulp_ops __read_mostly =3D {
> -- =

> 2.21.0

--
Mat Martineau
Intel
--===============0463644019258272910==--
