Content-Type: multipart/mixed; boundary="===============0934420486618088663=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 4/4] mptcp: remove addr and
 subflow in PM netlink
Date: Tue, 04 Aug 2020 12:56:46 +0200
Message-ID: <e4e6d9b1e33f4113dfacf1a3d978bc3dacd84f0f.camel@redhat.com>
In-Reply-To: bbfc5de08176adb91aca942aca83928bede0dfbd.1596534832.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5461

--===============0934420486618088663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-08-04 at 18:01 +0800, Geliang Tang wrote:
> The patch adds a new list named anno_list in mptcp_pm_data, to record all
> the announced addrs. When the PM netlink removes an address, we check if
> it has been recorded. If it has been, we trigger the RM_ADDR signal.
> =

> We also check if this address is in conn_list. If it is, we remove the
> subflow which using this local address.
> =

> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm.c         |  7 +++-
>  net/mptcp/pm_netlink.c | 93 ++++++++++++++++++++++++++++++++++++++++--
>  net/mptcp/protocol.c   |  2 +
>  net/mptcp/protocol.h   |  2 +
>  4 files changed, 99 insertions(+), 5 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 558462d87eb3..b3712771f268 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -24,7 +24,11 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>  =

>  int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
>  {
> -	return -ENOTSUPP;
> +	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
> +
> +	msk->pm.rm_id =3D local_id;
> +	WRITE_ONCE(msk->pm.rm_addr_signal, true);
> +	return 0;
>  }
>  =

>  int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id)
> @@ -229,6 +233,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>  	msk->pm.status =3D 0;
>  =

>  	spin_lock_init(&msk->pm.lock);
> +	INIT_LIST_HEAD(&msk->pm.anno_list);
>  =

>  	mptcp_pm_nl_data_init(msk);
>  }
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 7461933fb68b..7336f3f95f94 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -169,6 +169,19 @@ static void check_work_pending(struct mptcp_sock *ms=
k)
>  		WRITE_ONCE(msk->pm.work_pending, false);
>  }
>  =

> +void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	pr_debug("msk=3D%p\n", msk);
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
> @@ -189,8 +202,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(s=
truct mptcp_sock *msk)
>  					      msk->pm.add_addr_signaled);
>  =

>  		if (local) {
> +			struct mptcp_pm_addr_entry *clone =3D NULL;
> +
>  			msk->pm.add_addr_signaled++;
>  			mptcp_pm_announce_addr(msk, &local->addr);
> +
> +			clone =3D kmemdup(local, sizeof(*local), GFP_ATOMIC);
> +			if (!clone)
> +				return;
> +
> +			list_add(&clone->list, &msk->pm.anno_list);
>  		} else {
>  			/* pick failed, avoid fourther attempts later */
>  			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
> @@ -551,6 +572,68 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, uns=
igned int id)
>  	return NULL;
>  }
>  =

> +static bool lookup_anno_list_by_saddr(struct mptcp_sock *msk,
> +				      struct mptcp_addr_info *addr,
> +				      struct mptcp_pm_addr_entry **ret)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
> +		if (addresses_equal(&entry->addr, addr, false)) {
> +			*ret =3D entry;
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static int mptcp_nl_remove_subflow_or_signal_addr(struct net *net,
> +						  struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_sock *msk;
> +	long s_slot =3D 0, s_num =3D 0;
> +
> +	pr_debug("remove_id=3D%d\n", addr->id);
> +
> +	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL)=
 {
> +		struct sock *sk =3D (struct sock *)msk;
> +		struct mptcp_pm_addr_entry *entry;
> +		bool ret =3D false;
> +
> +		/* check first for announced addr */
> +		if (list_empty(&msk->pm.anno_list))
> +			goto remove_subflow;
> +
> +		spin_lock_bh(&msk->pm.lock);
> +		ret =3D lookup_anno_list_by_saddr(msk, addr, &entry);
> +		spin_unlock_bh(&msk->pm.lock);
> +		if (ret) {
> +			mptcp_pm_remove_addr(msk, addr->id);
> +			list_del(&entry->list);

list_del() should be called under msk->pm.lock or the anno list will be
corrupted. Perhaps you can rename the 'lookup_anno_list_by_saddr'
helper to 'remove_anno_list_by_saddr' and do the list_del(),
 mptcp_pm_remove_addr(), free() inside such function.

> +			kfree(entry);
> +			goto next;

My understanding of the RFC is that any msk subflows using this address
should be closed, too - so no need for a goto here.

> +		}
> +
> +		/* check if should remove a subflow */
> +remove_subflow:
> +		if (list_empty(&msk->conn_list))
> +			goto next;
> +
> +		spin_lock_bh(&msk->pm.lock);
> +		ret =3D lookup_subflow_by_saddr(&msk->conn_list, addr);
> +		spin_unlock_bh(&msk->pm.lock);

here you need to acquire the msk socket lock, and you shoud release
after calling mptcp_pm_rm_addr_received(). The msk->pm.lock is not
needed to traverse msk->conn_list.

Thanks

Paolo


--===============0934420486618088663==--
