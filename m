Content-Type: multipart/mixed; boundary="===============9022605489755837229=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp v2] net: mptcp: don't leak 'slab' and
 'slab_name' on exit
Date: Thu, 23 May 2019 15:26:15 -0700
Message-ID: <alpine.OSX.2.21.1905231525190.41618@mjmartin-mac01.local>
In-Reply-To: c0a1d64bcfa56d3c2942c7ae182acfb43dbf1d9b.1558628033.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1236

--===============9022605489755837229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 23 May 2019, Davide Caratti wrote:

> fix leak of subflows' slab and slab_name in the (rare) case where
> proto_register(mptcp_prot, 1) returns -ENOBUFS.
>
> changes since v1:
> - use string literal for slab_name rather than allocating it with
>   kasprintf(), thanks to Mat Martineau

Ok, patch looks good!

Mat


>
> Fixes: e203b1359cf77 ("mptcp: Associate MPTCP context with TCP socket")
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
> net/mptcp/subflow.c | 13 +++----------
> 1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index bc8e1a0658ec..80784443d1dd 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -271,23 +271,15 @@ static struct tcp_ulp_ops subflow_ulp_ops __read_mo=
stly =3D {
> static int subflow_ops_init(struct request_sock_ops *subflow_ops)
> {
> 	subflow_ops->obj_size =3D sizeof(struct subflow_request_sock);
> -	subflow_ops->slab_name =3D NULL;
> -	subflow_ops->slab =3D NULL;
> -
> -	subflow_ops->slab_name =3D kasprintf(GFP_KERNEL, "request_sock_subflow"=
);
> -	if (!subflow_ops->slab_name)
> -		return -ENOMEM;
> +	subflow_ops->slab_name =3D "request_sock_subflow";
>
> 	subflow_ops->slab =3D kmem_cache_create(subflow_ops->slab_name,
> 					      subflow_ops->obj_size, 0,
> 					      SLAB_ACCOUNT |
> 					      SLAB_TYPESAFE_BY_RCU,
> 					      NULL);
> -
> -	if (!subflow_ops->slab) {
> -		kfree(subflow_ops->slab_name);
> +	if (!subflow_ops->slab)
> 		return -ENOMEM;
> -	}
>
> 	subflow_ops->destructor =3D subflow_req_destructor;
>
> @@ -318,6 +310,7 @@ int subflow_init(void)
> void subflow_exit(void)
> {
> 	tcp_unregister_ulp(&subflow_ulp_ops);
> +	kmem_cache_destroy(subflow_request_sock_ops.slab);
> }
>
> MODULE_LICENSE("GPL");
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

--===============9022605489755837229==--
