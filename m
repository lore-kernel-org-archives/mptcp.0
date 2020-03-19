Content-Type: multipart/mixed; boundary="===============3397913147184514014=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/2] mptcp: fix compilation error without IPV6
Date: Thu, 19 Mar 2020 10:24:11 +0100
Message-ID: <dcc47c28e0e3ea621774c0d3eaf999ed4171e1d4.camel@redhat.com>
In-Reply-To: 20200319090502.2275907-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3990

--===============3397913147184514014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2020-03-19 at 10:05 +0100, Matthieu Baerts wrote:
>   net/mptcp/options.c: In function =E2=80=98add_addr_hmac_valid=E2=80=99:
>   net/mptcp/options.c:796:39: error: =E2=80=98struct mptcp_options_receiv=
ed=E2=80=99 has no member named =E2=80=98addr6=E2=80=99; did you mean =E2=
=80=98addr=E2=80=99?
>     796 |             mp_opt->addr_id, &mp_opt->addr6);
>         |                                       ^~~~~
>         |                                       addr
> =

> Fixes: 8536089ea875 (mptcp: v1 ADD_ADDR changes: add_addr_hmac_valid)
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     to be squashed in "mptcp: Add path manager interface"
> =

>  net/mptcp/options.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1f64619be5c0..919f727cc7de 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -781,7 +781,7 @@ static void update_una(struct mptcp_sock *msk,
>  static bool add_addr_hmac_valid(struct mptcp_subflow_context *subflow,
>  				struct mptcp_options_received *mp_opt)
>  {
> -	u64 hmac;
> +	u64 hmac =3D 0;
>  =

>  	if (mp_opt->echo)
>  		return true;
> @@ -790,10 +790,12 @@ static bool add_addr_hmac_valid(struct mptcp_subflo=
w_context *subflow,
>  		hmac =3D add_addr_generate_hmac(subflow->remote_key,
>  					      subflow->local_key,
>  					      mp_opt->addr_id, &mp_opt->addr);
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  	else
>  		hmac =3D add_addr6_generate_hmac(subflow->remote_key,
>  					       subflow->local_key,
>  					       mp_opt->addr_id, &mp_opt->addr6);
> +#endif
>  =

>  	pr_debug("subflow=3D%p, ahmac=3D%llu, mp_opt->ahmac=3D%llu\n",
>  		 subflow, (unsigned long long)hmac,
> -- =

> 2.25.1
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org

Both patches LGTM, thanks!

Paolo

--===============3397913147184514014==--
