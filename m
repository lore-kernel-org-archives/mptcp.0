Content-Type: multipart/mixed; boundary="===============5322257225194325679=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 5/5] mptcp: Update basic path manager for IPv6
Date: Wed, 16 Oct 2019 17:47:34 +0200
Message-ID: <08ba0fe2-d38f-b655-0034-f873335f3d22@tessares.net>
In-Reply-To: 20191015230613.16981-6-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2180

--===============5322257225194325679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 16/10/2019 01:06, Peter Krystad wrote:
> squashto: Implement basic path manager
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>   net/mptcp/basic.c | 40 ++++++++++++++++++++++++++--------------
>   1 file changed, 26 insertions(+), 14 deletions(-)
> =

> diff --git a/net/mptcp/basic.c b/net/mptcp/basic.c
> index 193d6a01f51a..5520aae3a6e7 100644
> --- a/net/mptcp/basic.c
> +++ b/net/mptcp/basic.c

[...]

> @@ -204,12 +207,21 @@ static void create_subflow_worker(struct work_struc=
t *work)
>   =

>   	pernet =3D net_generic(sock_net((struct sock *)msk), basic_pernet_id);
>   =

> -	if (pernet->has_announce_v4) {
> -		mptcp_pm_create_subflow(pm->token, pm->remote_id, AF_INET,
> +	if (pernet->has_announce_v4)
> +		mptcp_pm_create_subflow(pm->token, pm->remote_id,
>   					&pernet->announce_v4_addr);
> -	} else {
> -		mptcp_pm_create_subflow(pm->token, pm->remote_id, 0, NULL);
> -	}
> +#if IS_ENABLED(CONFIG_IPV6)
> +	else if (pernet->has_announce_v6)
> +		mptcp_pm_create_subflow6(pm->token, pm->remote_id,
> +					 &pernet->announce_v6_addr);
> +#endif
> +	else if (pm->local_family =3D=3D AF_INET)
> +		mptcp_pm_create_subflow(pm->token, pm->remote_id, NULL);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	else

Small detail here: I don't know what are the recommendations on the =

subject but is it not better to have another if statement here for IPv6:

     else if (pm->local_family =3D=3D AF_INET6)

instead of:

     else

> +		mptcp_pm_create_subflow6(pm->token, pm->remote_id, NULL);
> +#endif
> +
>   	sock_put((struct sock *)msk);
>   }
>   =


Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5322257225194325679==--
