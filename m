Content-Type: multipart/mixed; boundary="===============6149381889663832898=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next] mptcp: retransmit ADD_ADDR
 when timeout
Date: Wed, 16 Sep 2020 16:03:08 +0200
Message-ID: <d6a4d67e81b12056d9aa7da7d1b5ef741a5b7121.camel@redhat.com>
In-Reply-To: 25ffeeb7631ebe2285b2449b076d2a424523c721.1600258235.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5902

--===============6149381889663832898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-16 at 20:17 +0800, Geliang Tang wrote:
[...] =

> +static void mptcp_pm_add_timer(struct timer_list *timer)
> +{
> +	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, add_timer=
);
> +	struct mptcp_sock *msk =3D entry->sock;
> +	struct sock *sk =3D (struct sock *)msk;
> +
> +	pr_debug("msk=3D%p\n", msk);
> +
> +	if (!msk)
> +		return;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +
> +	if (entry->addr.id > 0) {
> +		pr_debug("retransmit ADD_ADDR id=3D%d\n", entry->addr.id);
> +		mptcp_pm_announce_addr(msk, &entry->addr, false);
> +		entry->retrans_times++;
> +	}
> +
> +	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
> +		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX);
> +
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	__sock_put(sk);
> +}
> +
> +void mptcp_pm_del_add_timer(struct mptcp_sock *msk, struct mptcp_addr_in=
fo *addr)
> +{
> +	struct mptcp_pm_add_entry *entry;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	list_for_each_entry(entry, &msk->pm.anno_list, list) {
> +		if (addresses_equal(&entry->addr, addr, false))
> +			sk_stop_timer((struct sock *)msk, &entry->add_timer);
> +	}
> +	spin_unlock_bh(&msk->pm.lock);

I fear this is still racy:

when sk_stop_timer() is called, mptcp_pm_add_timer() could be running,
and waiting for the pm spinlock.

After the above loop is completed, mptcp_pm_add_timer() may re-schedule =

itself.

> +}
> +
>  static bool lookup_anno_list_by_saddr(struct mptcp_sock *msk,
>  				      struct mptcp_addr_info *addr)
>  {
> -	struct mptcp_pm_addr_entry *entry;
> +	struct mptcp_pm_add_entry *entry;
>  =

>  	list_for_each_entry(entry, &msk->pm.anno_list, list) {
>  		if (addresses_equal(&entry->addr, addr, false))
> @@ -194,28 +242,36 @@ static bool lookup_anno_list_by_saddr(struct mptcp_=
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
> +	add_entry->retrans_times =3D 0;
> +
> +	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
> +	sk_reset_timer((struct sock *)msk, &add_entry->add_timer, jiffies + TCP=
_RTO_MAX);
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
> +		sk_stop_timer((struct sock *)msk, &entry->add_timer);
>  		list_del(&entry->list);
>  		kfree(entry);

Like the above, but additionally mptcp_pm_add_timer() can hit use-
after-free on the anno list entry, if kfree is executed
before mptcp_pm_add_timer() completes.

Sorry for not noticing the above before.

Note that TCP timers do not have the above issues, because the timers
structs are embedded into the sock, and the timer keep a reference to
the sock itself.

I think the a solution could be somethink alike:

---
	// in mptcp_pm_free_anno_list()
	LIST_HEAD(to_free);

	spin_lock_bh(&msk->pm.lock);
  	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
		/* avoid timer to rescheuling =

		 * as an alternative, here we could simply splicing
		 * 'anno_list' into 'to_free'
		 * and check msk sk_state in mptcp_pm_add_timer()
		 * avoiding re-scheduling if  TCP_CLOSE
		 */
		entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
		list_del(&entry->list);
		list_add(&entry->list, &to_free);
	}
	spin_unlock_bh(&msk->pm.lock);
	=

  	list_for_each_entry_safe(entry, tmp, &to_free, list) {
		if (del_timer_sync(&entry->add_timer))
			__sock_put(msk);
		kfree(entry);
	}

void mptcp_pm_del_add_timer(struct mptcp_sock *msk, struct mptcp_addr_info =
*addr)
{
	struct mptcp_pm_add_entry *entry;

	spin_lock_bh(&msk->pm.lock);
	entry =3D lookup_anno_list_by_saddr(msk, addr);
	if (entry)
		entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
	spin_unlock_bh(&msk->pm.lock);
	=

	if (entry && del_timer_sync(&entry->add_timer))
		__sock_put(msk);
}
---
beware: completely untested!!! Likely some bugs present && something
simpler is possible.

Anyway this looks less complex than the work-based solution (IMHO).
Other opinons more than welcome!

Cheers,

Paolo

--===============6149381889663832898==--
