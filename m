Content-Type: multipart/mixed; boundary="===============1176011870075106050=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 4/4] mptcp: trigger the
 RM_ADDR signal
Date: Wed, 29 Jul 2020 17:33:01 -0700
Message-ID: <alpine.OSX.2.23.453.2007291730010.1985@ltd-ie-desk02.amr.corp.intel.com>
In-Reply-To: 17efd13bba7cf64cb1df85dba5e338fb43b03863.1596012283.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5385

--===============1176011870075106050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jul 2020, Geliang Tang wrote:

> The patch adds a new list named anno_list in msk, to record all the
> announced addrs. When the PM netlink removes an address, we check if it h=
as
> been recorded. If it has been, we trigger the RM_ADDR signal.
>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm.c         |  6 +++++-
> net/mptcp/pm_netlink.c | 49 +++++++++++++++++++++++++++++++++++++++++-
> net/mptcp/protocol.c   |  3 +++
> net/mptcp/protocol.h   |  2 ++
> 4 files changed, 58 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 84fad1fec28b..4194fd2591c5 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -24,7 +24,11 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>
> int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
> {
> -	return -ENOTSUPP;
> +	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
> +
> +	msk->pm.rm_id =3D local_id;
> +	WRITE_ONCE(msk->pm.rm_addr_signal, true);
> +	return 0;
> }
>
> int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id)
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index bcf4fccaf7d0..a6885a22cf1a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -169,6 +169,19 @@ static void check_work_pending(struct mptcp_sock *ms=
k)
> 		WRITE_ONCE(msk->pm.work_pending, false);
> }
>
> +void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	pr_debug("msk=3D%p\n", msk);
> +	spin_lock_bh(&msk->pm.lock);
> +	list_for_each_entry_safe(entry, tmp, &msk->anno_list, list) {
> +		list_del(&entry->list);
> +		kfree(entry);
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +}
> +
> static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> {
> 	struct sock *sk =3D (struct sock *)msk;
> @@ -189,8 +202,16 @@ static void mptcp_pm_create_subflow_or_signal_addr(s=
truct mptcp_sock *msk)
> 					      msk->pm.add_addr_signaled);
>
> 		if (local) {
> +			struct mptcp_pm_addr_entry *clone =3D NULL;
> +
> 			msk->pm.add_addr_signaled++;
> 			mptcp_pm_announce_addr(msk, &local->addr);
> +
> +			clone =3D kmemdup(local, sizeof(*local), GFP_ATOMIC);
> +			if (!clone)
> +				return;
> +
> +			list_add(&clone->list, &msk->anno_list);
> 		} else {
> 			/* pick failed, avoid fourther attempts later */
> 			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
> @@ -542,6 +563,30 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, uns=
igned int id)
> 	return NULL;
> }
>
> +static void mptcp_nl_remove_addr(struct sk_buff *skb, struct mptcp_addr_=
info *addr)
> +{
> +	struct mptcp_sock *msk;
> +	long s_slot =3D 0, s_num =3D 0;
> +	struct net *net =3D sock_net(skb->sk);
> +
> +	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL)=
 {
> +		struct mptcp_pm_addr_entry *entry, *tmp;
> +		struct sock *sk =3D (struct sock *)msk;
> +
> +		pr_debug("msk=3D%p\n", msk);
> +		spin_lock_bh(&msk->pm.lock);
> +		list_for_each_entry_safe(entry, tmp, &msk->anno_list, list) {
> +			if (addresses_equal(&entry->addr, addr, false)) {
> +				mptcp_pm_remove_addr(msk, addr->id);
> +				list_del(&entry->list);
> +				kfree(entry);
> +			}
> +		}
> +		spin_unlock_bh(&msk->pm.lock);
> +		sock_put(sk);
> +	}
> +}
> +
> static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *i=
nfo)
> {
> 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> @@ -560,8 +605,10 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb=
, struct genl_info *info)
> 		ret =3D -EINVAL;
> 		goto out;
> 	}
> -	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
> +	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
> 		pernet->add_addr_signal_max--;
> +		mptcp_nl_remove_addr(skb, &entry->addr);
> +	}
> 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
> 		pernet->local_addr_max--;
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e7c7b8794868..fed0f5c4f215 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1330,6 +1330,7 @@ static int __mptcp_init_sock(struct sock *sk)
>
> 	INIT_LIST_HEAD(&msk->conn_list);
> 	INIT_LIST_HEAD(&msk->join_list);
> +	INIT_LIST_HEAD(&msk->anno_list);
> 	INIT_LIST_HEAD(&msk->rtx_queue);
> 	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
> 	INIT_WORK(&msk->work, mptcp_worker);
> @@ -1454,6 +1455,8 @@ static void mptcp_close(struct sock *sk, long timeo=
ut)
> 		__mptcp_close_ssk(sk, ssk, subflow, timeout);
> 	}
>
> +	mptcp_pm_free_anno_list(msk);
> +
> 	mptcp_cancel_work(sk);
>
> 	__skb_queue_purge(&sk->sk_receive_queue);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b9058675cbf6..2714d59307de 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -207,6 +207,7 @@ struct mptcp_sock {
> 	struct list_head conn_list;
> 	struct list_head rtx_queue;
> 	struct list_head join_list;
> +	struct list_head anno_list;

I think anno_list would fit better in struct mptcp_pm_data, since it's =

relevant for the in-kernel PM but won't necessarily be for userspace path =

managers.

> 	struct skb_ext	*cached_ext;	/* for the next sendmsg */
> 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
> 	struct sock	*first;
> @@ -432,6 +433,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> 			   const struct mptcp_addr_info *addr);
> int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
> int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id);
> +void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
>
> static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
> {
> -- =

> 2.17.1

--
Mat Martineau
Intel
--===============1176011870075106050==--
