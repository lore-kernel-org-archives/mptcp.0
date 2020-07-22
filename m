Content-Type: multipart/mixed; boundary="===============3798197570399331942=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 4/4] mptcp: trigger the
 RM_ADDR signal
Date: Wed, 22 Jul 2020 13:12:32 +0200
Message-ID: <c5a7af2044a9f9fc395579f4a10de9f2888f9556.camel@redhat.com>
In-Reply-To: c794e8ba159e98f1a22d279a05cc913a7b5f803b.1595407078.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5176

--===============3798197570399331942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-07-22 at 16:42 +0800, Geliang Tang wrote:
> Trigger the RM_ADDR signal when the PM netlink removes an address.
> =

> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm.c         |  6 +++++-
>  net/mptcp/pm_netlink.c | 32 +++++++++++++++++++++++++++++++-
>  net/mptcp/protocol.c   |  1 +
>  net/mptcp/protocol.h   |  1 +
>  4 files changed, 38 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 84fad1fec28b..4194fd2591c5 100644
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
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 2ee7227f5f2b..646398f16ce8 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -23,6 +23,7 @@ static int pm_nl_pernet_id;
>  =

>  struct mptcp_pm_addr_entry {
>  	struct list_head	list;
> +	struct list_head	alist;

I think this new field is not needed, see below...

>  	unsigned int		flags;
>  	int			ifindex;
>  	struct mptcp_addr_info	addr;
> @@ -169,6 +170,13 @@ static void check_work_pending(struct mptcp_sock *ms=
k)
>  		WRITE_ONCE(msk->pm.work_pending, false);
>  }
>  =

> +static int mptcp_pm_add_announce_list(struct mptcp_sock *msk,
> +				      struct mptcp_pm_addr_entry *entry)
> +{
> +	list_add(&entry->alist, &msk->anno_list);
> +	return 0;
> +}
> +
>  static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *ms=
k)
>  {
>  	struct sock *sk =3D (struct sock *)msk;
> @@ -191,6 +199,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
>  		if (local) {
>  			msk->pm.add_addr_signaled++;
>  			mptcp_pm_announce_addr(msk, &local->addr);
> +			mptcp_pm_add_announce_list(msk, local);

Here we need to allocate a new mptcp_pm_addr_entry struct, copy the
data from local, and finally add the new entry to anno_list. I guess
all the logic could be encapsulated
into mptcp_pm_create_subflow_or_signal_addr(), which could return a
bool indicating if the allocation was successful.

In cause of memory allocation failure the announce addr should not be
performed.

The same address can be signaled from multiple msks. If we always use
the same struct we will see data corruption.

I *think* dynamically allocation of announced address could be ok, I'd
like to ear opinions from others.

>  		} else {
>  			/* pick failed, avoid fourther attempts later */
>  			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
> @@ -537,6 +546,25 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, uns=
igned int id)
>  	return NULL;
>  }
>  =

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
> +
> +		pr_debug("msk=3D%p\n", msk);
> +		list_for_each_entry_safe(entry, tmp, &msk->anno_list, alist) {
> +			if (addresses_equal(&entry->addr, addr, false)) {
> +				mptcp_pm_remove_addr(msk, addr->id);
> +				list_del(&entry->alist);
> +			}
> +		}
> +	}
> +}

Here you need to acquire the msk pm lock before traversing the
anno_list and eventually removing the entry.

Additionally, we should also shutdown the subflows with the local
address matching the removed one. Note that the 'id' could not be used
for the first subflow, being always 0, and we should to this for any
removed address, regardless of the 'MPTCP_PM_ADDR_FLAG_SIGNAL' flag.

Cheers,

Paolo

--===============3798197570399331942==--
