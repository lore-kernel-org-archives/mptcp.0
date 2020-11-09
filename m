Content-Type: multipart/mixed; boundary="===============1042755636190823915=="
MIME-Version: 1.0
From: Dan Carpenter <dan.carpenter at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 net] mptcp: fix static checker warnings
 in mptcp_pm_add_timer
Date: Mon, 09 Nov 2020 14:26:23 +0300
Message-ID: <20201109112623.GM18329@kadam>
In-Reply-To: 6bedbef3c2cb93ab9f3d15e78bd023043a83acbe.1604918403.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6595

--===============1042755636190823915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 06:44:09PM +0800, Geliang Tang wrote:
> Fix the following Smatch complaint:
> =

>      net/mptcp/pm_netlink.c:213 mptcp_pm_add_timer()
>      warn: variable dereferenced before check 'msk' (see line 208)
> =

>  net/mptcp/pm_netlink.c
>     207          struct mptcp_sock *msk =3D entry->sock;
>     208          struct sock *sk =3D (struct sock *)msk;
>     209          struct net *net =3D sock_net(sk);
>                                            ^^
>  "msk" dereferenced here.
> =

>     210
>     211          pr_debug("msk=3D%p", msk);
>     212
>     213          if (!msk)
>                     ^^^^
>  Too late.
> =

>     214                  return;
>     215
> =

> Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
> Reported-by: Dan Carpenter <dan.carpenter(a)oracle.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  v2:
>  - fix mptcp_pm_alloc_anno_list too

This is no required.

> ---
>  net/mptcp/pm_netlink.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 6180a8b39a3f..59678e59ff46 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -206,7 +206,6 @@ static void mptcp_pm_add_timer(struct timer_list *tim=
er)
>  	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, add_timer=
);
>  	struct mptcp_sock *msk =3D entry->sock;
>  	struct sock *sk =3D (struct sock *)msk;
> -	struct net *net =3D sock_net(sk);
>  =

>  	pr_debug("msk=3D%p", msk);
>  =

> @@ -235,7 +234,7 @@ static void mptcp_pm_add_timer(struct timer_list *tim=
er)
>  =

>  	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
>  		sk_reset_timer(sk, timer,
> -			       jiffies + mptcp_get_add_addr_timeout(net));
> +			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
>  =

>  	spin_unlock_bh(&msk->pm.lock);
>  =

> @@ -267,7 +266,6 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_soc=
k *msk,


1)  "msk" is never NULL when we call this function.

>  {
>  	struct mptcp_pm_add_entry *add_entry =3D NULL;
>  	struct sock *sk =3D (struct sock *)msk;
> -	struct net *net =3D sock_net(sk);
>  =

>  	if (lookup_anno_list_by_saddr(msk, &entry->addr))
                                      ^^^
2) If it were then this would Oops.

This change is nice, as a clean up but it's not required as a fix.

regards,
dan carpenter

--===============1042755636190823915==--
