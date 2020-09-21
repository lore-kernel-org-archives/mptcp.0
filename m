Content-Type: multipart/mixed; boundary="===============2147914004916489366=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash-to: "mptcp: retransmit
 ADD_ADDR when timeout v5"
Date: Mon, 21 Sep 2020 19:05:25 +0200
Message-ID: <45d2421a56322607cf4be3cebda2874a0f304e89.camel@redhat.com>
In-Reply-To: 2d76ae315befc6be09e25e17a5640c53189e293c.1600690408.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5969

--===============2147914004916489366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-09-21 at 20:16 +0800, Geliang Tang wrote:
> Improving patch "mptcp: retransmit ADD_ADDR when timeout" v5 as Paolo
> suggested. No commit message needs to update.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm_netlink.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 6fad2cc4cf5d..5a0e4d11bcc3 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -191,16 +191,14 @@ static struct mptcp_pm_add_entry *
>  lookup_anno_list_by_saddr(struct mptcp_sock *msk,
>  			  struct mptcp_addr_info *addr)
>  {
> -	struct mptcp_pm_add_entry *entry, *ret =3D NULL;
> +	struct mptcp_pm_add_entry *entry;
>  =

>  	list_for_each_entry(entry, &msk->pm.anno_list, list) {
> -		if (addresses_equal(&entry->addr, addr, false)) {
> -			ret =3D entry;
> -			break;
> -		}
> +		if (addresses_equal(&entry->addr, addr, false))
> +			return entry;
>  	}
>  =

> -	return ret;
> +	return NULL;
>  }
>  =

>  static void mptcp_pm_add_timer(struct timer_list *timer)
> @@ -214,7 +212,7 @@ static void mptcp_pm_add_timer(struct timer_list
> *timer)
>  	if (!msk)
>  		return;
>  =

> -	if (sk->sk_state =3D=3D TCP_CLOSE)
> +	if (inet_sk_state_load(sk) =3D=3D TCP_CLOSE)
>  		return;
>  =

>  	if (!entry->addr.id)
> @@ -251,6 +249,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>  =

>  	spin_lock_bh(&msk->pm.lock);
>  	entry =3D lookup_anno_list_by_saddr(msk, addr);
> +	if (entry)
> +		entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
>  	spin_unlock_bh(&msk->pm.lock);
>  =

>  	if (entry)


LGTM, thanks!

I think can be merged (togethar with  mptcp: retransmit ADD_ADDR when
timeout and others v5)

Cheers,

Paolo

--===============2147914004916489366==--
