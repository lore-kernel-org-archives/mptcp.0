Content-Type: multipart/mixed; boundary="===============1882696513782439167=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net 2/2] mptcp: cleanup for
 mptcp_pm_alloc_anno_list
Date: Mon, 09 Nov 2020 17:35:02 +0100
Message-ID: <8b1c6862-ad2f-f639-42e3-b793aefbfd78@tessares.net>
In-Reply-To: 0f17d2f60c188554d093e820c45caf20fe53aab0.1604930005.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6608

--===============1882696513782439167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 09/11/2020 14:59, Geliang Tang wrote:
> This patch added NULL pointer check for mptcp_pm_alloc_anno_list, and
> avoided similar static checker warnings in mptcp_pm_add_timer.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> Reviewed-by: Dan Carpenter <dan.carpenter(a)oracle.com>

I think Dan reviewed the v1 of your patch -- without some modifications =

below -- but not the v2 nor this one.

> ---
>   net/mptcp/pm_netlink.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 03f2c28f11f5..dfc1bed4a55f 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -266,7 +266,9 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_soc=
k *msk,
>   {
>   	struct mptcp_pm_add_entry *add_entry =3D NULL;
>   	struct sock *sk =3D (struct sock *)msk;
> -	struct net *net =3D sock_net(sk);
> +
> +	if (!msk)
> +		return false;

As Dan mentioned on MPTCP ML, this check is not required: "msk" cannot =

be NULL here.

We can maybe keep the cleanup (only move sock_net() below) but I don't =

think we need or want this in -net.
I am not even sure we want it in net-next but why not :)
This could also be part of other refactors.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1882696513782439167==--
