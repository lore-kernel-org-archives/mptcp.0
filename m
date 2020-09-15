Content-Type: multipart/mixed; boundary="===============1600183573840053185=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] mptcp: retransmit ADD_ADDR
 when timeout
Date: Tue, 15 Sep 2020 17:10:15 +0200
Message-ID: <b68f6b1b98ed886c54f1f6266793f4230b1b8a79.camel@redhat.com>
In-Reply-To: 10263bb42eac2f1c27c77e5e61552d067c63dc52.1600171893.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5886

--===============1600183573840053185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-09-15 at 20:16 +0800, Geliang Tang wrote:
> This patch implemented the retransmition of ADD_ADDR when no ADD_ADDR echo
> is received. It added a delayed_work with the announced address. When tim=
eout
> occurs, ADD_ADDR will be retransmitted.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> v2:
>  - Use delayed_work instead of timer.
>  - This patch depends on my another patch named 'Squash-to: "mptcp: remove
>    addr and subflow in PM netlink"'.
> ---
>  net/mptcp/options.c    |  1 +
>  net/mptcp/pm_netlink.c | 68 +++++++++++++++++++++++++++++++++++++-----
>  net/mptcp/protocol.h   |  1 +
>  3 files changed, 63 insertions(+), 7 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 171039cbe9c4..283bd891b2b0 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -893,6 +893,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
>  			mptcp_pm_add_addr_received(msk, &addr);
>  			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
>  		} else {
> +			mptcp_pm_del_add_work(msk, &addr);
>  			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
>  		}
>  		mp_opt.add_addr =3D 0;
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 8780d618a05a..55766367bb6e 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -28,6 +28,14 @@ struct mptcp_pm_addr_entry {
>  	struct rcu_head		rcu;
>  };
>  =

> +struct mptcp_subflow_active {
> +	struct list_head	list;
> +	struct mptcp_addr_info	addr;
> +	struct delayed_work	add_work;
> +	struct mptcp_sock	*sock;
> +	u8			retrans_times;
> +};

I have some concerns we will end-up allocating quite a bit of extra
memory for each msk socket, when configured to announce one or more
addrs (delayed_work should be ~88 bytes, the whole mptcp_subflow_active
should be almost 3 times mptcp_pm_addr_entry).

Anyhow I guess we can start this way and see if triggers any real
issue.

[...]

> @@ -194,28 +240,36 @@ static bool lookup_anno_list_by_saddr(struct mptcp_=
sock *msk,
>  static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  				     struct mptcp_pm_addr_entry *entry)
>  {
> -	struct mptcp_pm_addr_entry *clone =3D NULL;
> +	struct mptcp_pm_add_entry *add_entry =3D NULL;
>  =

>  	if (lookup_anno_list_by_saddr(msk, &entry->addr))
>  		return false;
>  =

> -	clone =3D kmemdup(entry, sizeof(*entry), GFP_ATOMIC);
> -	if (!clone)
> +	add_entry =3D kmalloc(sizeof(*add_entry), GFP_ATOMIC);
> +	if (!add_entry)
>  		return false;
>  =

> -	list_add(&clone->list, &msk->pm.anno_list);
> +	list_add(&add_entry->list, &msk->pm.anno_list);
> +
> +	add_entry->addr =3D entry->addr;
> +	add_entry->sock =3D msk;

Uhm... the reference counting here is not trivial. See below...

> +	add_entry->retrans_times =3D 0;
> +
> +	INIT_DELAYED_WORK(&add_entry->add_work, mptcp_pm_add_expire);
> +	schedule_delayed_work(&add_entry->add_work, TCP_RTO_MAX);
>  =

>  	return true;
>  }
>  =

>  void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>  {
> -	struct mptcp_pm_addr_entry *entry, *tmp;
> +	struct mptcp_pm_add_entry *entry, *tmp;
>  =

>  	pr_debug("msk=3D%p\n", msk);
>  =

>  	spin_lock_bh(&msk->pm.lock);
>  	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
> +		cancel_delayed_work(&entry->add_work);
>  		list_del(&entry->list);
>  		kfree(entry);

Here the associated work could be running on another
CPU: cancel_delayed_work() don't wait for that to complete.
We can't call cancel_delayed_work_sync under spinlock.

Additionally, IIRC, we will be always in atomic context when called via
mptcp_sock_destruct().

So we can't kfree the list just after cancel_delayed_work(), we can hit
use after free for 'entry'.

And we risk use after free on msk, too, for the same reasons.

I think/hope a solution would be acquiring an msk referece when the
entry is created or rescheduled, and drop it when the work is completed
or cancelled. The anno work should be cancelled at close time and the
anno_list should be freed by mptcp_destroy(). Additionally we must
prevent the msk socket from creating anno list entry when still
unaccepted - otherwise correctly cancelling the anno work would be
quite difficult/impossible, I fear.

All in all the above is quite complex, so I'll be more than happy with
anything working and simpler ;)


@@ -654,7 +708,7 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet,
unsigned int id)
>  static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
>  				      struct mptcp_addr_info *addr)
>  {
> -	struct mptcp_pm_addr_entry *entry, *tmp;
> +	struct mptcp_pm_add_entry *entry, *tmp;
>  =

>  	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
>  		if (addresses_equal(&entry->addr, addr, false)) {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index db1e5de2fee7..16db6ea10a00 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -444,6 +444,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
>  				const struct mptcp_addr_info *addr);
>  void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
>  void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> +void mptcp_pm_del_add_work(struct mptcp_sock *msk, struct mptcp_addr_inf=
o *addr);
>  =

>  int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>  			   const struct mptcp_addr_info *addr,


--===============1600183573840053185==--
