Content-Type: multipart/mixed; boundary="===============6062902410387989610=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/3] mptcp:basic: check for v6 family
Date: Wed, 16 Oct 2019 09:28:28 -0700
Message-ID: <d0182187ade8c29785e14115465146280842f420.camel@linux.intel.com>
In-Reply-To: 20191016161528.4336-4-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2186

--===============6062902410387989610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-16 at 18:15 +0200, Matthieu Baerts wrote:
> Instead of by default taking IPv6 if it is not v4.
> =

> I don't know exactly what are the recommendations about that but it
> seems we can often see code checking 'if v4' then 'else if v6', not
> checking 'if v4' then 'else it is v6'.

In this situation I think it is OK to use 'else it is v6' because this code=
 is
within the module and we know the field is set correctly (i.e. if local_val=
id
is set then local_family is set to one or the other). That has been my
approach: use "else if v6" when the value comes from elsewhere. But YMMV.

Peter.


> Anyway, that's a detail, more to know what we should do next time in
> this situation :)
> =

> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     To squash in "mptcp: Implement basic path manager"
> =

>  net/mptcp/basic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/basic.c b/net/mptcp/basic.c
> index 5520aae3a6e7..4710607a3fc2 100644
> --- a/net/mptcp/basic.c
> +++ b/net/mptcp/basic.c
> @@ -218,7 +218,7 @@ static void create_subflow_worker(struct work_struct =
*work)
>  	else if (pm->local_family =3D=3D AF_INET)
>  		mptcp_pm_create_subflow(pm->token, pm->remote_id, NULL);
>  #if IS_ENABLED(CONFIG_IPV6)
> -	else
> +	else if (pm->local_family =3D=3D AF_INET6)
>  		mptcp_pm_create_subflow6(pm->token, pm->remote_id, NULL);
>  #endif
> =20

--===============6062902410387989610==--
