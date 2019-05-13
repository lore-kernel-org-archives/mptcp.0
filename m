Content-Type: multipart/mixed; boundary="===============4297848659591886201=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp] net: mptcp: fix memory leak in case slab
 allocation fails
Date: Mon, 13 May 2019 16:36:25 -0700
Message-ID: <alpine.OSX.2.21.1905131632540.11725@mjmartin-mac01.local>
In-Reply-To: c30f4ffaed7419c634a1eb733339f0e2fa36a936.1557766409.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1154

--===============4297848659591886201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 13 May 2019, Davide Caratti wrote:

> slab_name is allocated, but not freed, when slab allocation fails: ensure
> it is freed in the error path of kmem_cache_create(...). While at it, fix
> reverse christmas tree in subflow_ops-init() local variable declarations.

Davide -

Thanks for the leak fix. Looks good to me.


Mat


>
> Fixes: aedec94346fb ("mptcp: Create SUBFLOW socket for incoming connectio=
ns")
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/subflow.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e72492bfb5a7..032424c61ba9 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -269,8 +269,8 @@ static struct tcp_ulp_ops subflow_ulp_ops __read_most=
ly =3D {
> static int subflow_ops_init(struct request_sock_ops *subflow_ops)
> {
> 	subflow_ops->obj_size =3D sizeof(struct subflow_request_sock);
> -	subflow_ops->slab =3D NULL;
> 	subflow_ops->slab_name =3D NULL;
> +	subflow_ops->slab =3D NULL;
>
> 	subflow_ops->slab_name =3D kasprintf(GFP_KERNEL, "request_sock_subflow");
> 	if (!subflow_ops->slab_name)
> @@ -283,6 +283,7 @@ static int subflow_ops_init(struct request_sock_ops *=
subflow_ops)
> 					      NULL);
>
> 	if (!subflow_ops->slab) {
> +		kfree(subflow_ops->slab_name);
> 		return -ENOMEM;
> 	}
>
> -- =

> 2.20.1
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============4297848659591886201==--
