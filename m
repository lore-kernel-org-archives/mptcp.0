Content-Type: multipart/mixed; boundary="===============1259188831270794601=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH] Squash-to: "mptcp: remove addr and subflow
 in PM netlink v9"
Date: Mon, 14 Sep 2020 11:45:49 +0200
Message-ID: <aa5a64e5e300f743a9b9ed0dd3496b73b84d7fae.camel@redhat.com>
In-Reply-To: ad4ee3dabbf15a02ee73388e79ef0d037acd9eaf.1599461190.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5846

--===============1259188831270794601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm sorry for lagging behind with the reviews.

On Mon, 2020-09-07 at 14:48 +0800, Geliang Tang wrote:
> Commit message should be rewritten enterily:
> '''
> This patch implements the remove announced addr and subflow logic in PM
> netlink.
> =

> When the PM netlink removes an address, we traverse all the existing msk
> sockets to find the relevant sockets.
> =

> If this removing address is a signaled address, we deal it like this:
> =

> We add a new list named anno_list in mptcp_pm_data, to record all the
> announced addrs. In the traversing, we check if it has been recorded. If =
it
> has been, we trigger the RM_ADDR signal to remove the remote subflow. Then
> we check if this address is in conn_list. If it is, we remove the local
> subflow which using this local address.
> =

> If this removing address is a subflow address, we deal it like this:
> =

> In the traversing, we check if this address is in conn_list. If it is, we
> trigger the RM_ADDR signal to remove the remote subflow and remove the lo=
cal
> subflow which using this local address.
> '''
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm.c         |   1 +
>  net/mptcp/pm_netlink.c | 106 +++++++++++++++++++++++++++++++++++++----
>  net/mptcp/protocol.c   |   2 +
>  net/mptcp/protocol.h   |   2 +
>  4 files changed, 102 insertions(+), 9 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 511996bf4838..f450bf0d49aa 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -235,6 +235,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>  	msk->pm.status =3D 0;
>  =

>  	spin_lock_init(&msk->pm.lock);
> +	INIT_LIST_HEAD(&msk->pm.anno_list);
>  =

>  	mptcp_pm_nl_data_init(msk);
>  }
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 16709939f767..f0981f332081 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -167,6 +167,50 @@ static void check_work_pending(struct mptcp_sock *ms=
k)
>  		WRITE_ONCE(msk->pm.work_pending, false);
>  }
>  =

> +static bool lookup_anno_list_by_saddr(struct mptcp_sock *msk,
> +				      struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +
> +	list_for_each_entry(entry, &msk->pm.anno_list, list) {
> +		if (addresses_equal(&entry->addr, addr, false))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
> +				     struct mptcp_pm_addr_entry *entry)
> +{
> +	struct mptcp_pm_addr_entry *clone =3D NULL;
> +
> +	if (lookup_anno_list_by_saddr(msk, &entry->addr))
> +		return false;
> +
> +	clone =3D kmemdup(entry, sizeof(*entry), GFP_ATOMIC);
> +	if (!clone)
> +		return false;
> +
> +	list_add(&clone->list, &msk->pm.anno_list);
> +
> +	return true;
> +}
> +
> +void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	pr_debug("msk=3D%p\n", msk);
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
> +		list_del(&entry->list);
> +		kfree(entry);
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +}
> +
>  static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *ms=
k)
>  {
>  	struct sock *sk =3D (struct sock *)msk;
> @@ -187,8 +231,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(s=
truct mptcp_sock *msk)
>  					      msk->pm.add_addr_signaled);
>  =

>  		if (local) {
> -			msk->pm.add_addr_signaled++;
> -			mptcp_pm_announce_addr(msk, &local->addr, false);
> +			if (mptcp_pm_alloc_anno_list(msk, local)) {
> +				msk->pm.add_addr_signaled++;
> +				mptcp_pm_announce_addr(msk, &local->addr, false);
> +			}
>  		} else {
>  			/* pick failed, avoid fourther attempts later */
>  			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
> @@ -554,6 +600,22 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, uns=
igned int id)
>  	return NULL;
>  }
>  =

> +static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
> +				      struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
> +		if (addresses_equal(&entry->addr, addr, false)) {
> +			list_del(&entry->list);
> +			kfree(entry);
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
>  						   struct mptcp_addr_info *addr)
>  {
> @@ -565,15 +627,41 @@ static int mptcp_nl_remove_subflow_and_signal_addr(=
struct net *net,
>  	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL)=
 {
>  		struct sock *sk =3D (struct sock *)msk;
>  =

> -		if (list_empty(&msk->conn_list))
> -			goto next;
> +		if (addr->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
> +			bool ret =3D false;

I think it would be better to ignore the flags from the provided
address, and always try to lookup inside anno_list and conn_list:
the user-space may remove the address giving no flags at all, and that
will still have effect.

Additionally mptcp_pm_remove_addr() should be invoked under the PM spin
lock. So overall it would be something alike the following:


static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk, bool force)
{
	bool ret;

	spin_lock_bh(&msk->pm.lock);
	ret =3D remove_anno_list_by_saddr(msk, addr);
	if (ret || force)
		mptcp_pm_remove_addr(msk, addr->id);
	spin_unlock_bh(&msk->pm.lock);
	return ret;
}


// ... inside mptcp_nl_remove_subflow_and_signal_addr() iter loop ...
			bool remove_subflow;

			if (list_empty(&msk->conn_list)) {
				// no need to acquire the sk lock here.
				mptcp_pm_remove_anno_addr(msk, false);
				continue;
			}

			// here you could possibly use "fast" version
			lock_sock(sk); =

			remove_subflow =3D lookup_subflow_by_saddr(&msk->conn_list, addr);
			mptcp_pm_remove_anno_addr(msk, remove_subflow);
			if (remove_subflow)
				mptcp_pm_remove_subflow(msk, addr->id);
			release_sock(sk);

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index eb833ecbba9e..e68e94738661 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1979,6 +1979,8 @@ static void mptcp_close(struct sock *sk, long timeo=
ut)
>  		__mptcp_close_ssk(sk, ssk, subflow, timeout);
>  	}
>  =

> +	mptcp_pm_free_anno_list(msk);
> +

I think this should be moved into (both): mptcp_destroy()
and mptcp_sock_destruct(). Possibly the best thing would be create a
new helper named mptcp_destroy_common() containing the shared code
between mptcp_destroy() and mptcp_sock_destruct().

Cheers,

Paolo

--===============1259188831270794601==--
