Content-Type: multipart/mixed; boundary="===============8983411499784625305=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 4/5] mptcp: trigger the
 RM_ADDR signal
Date: Thu, 30 Jul 2020 22:46:13 +0200
Message-ID: <0e98fc8be52b891fbb1f5c89385dbcdcb170ce3b.camel@redhat.com>
In-Reply-To: 0ef5ba7872c11dfec1288792361670e8ac5f723b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5404

--===============8983411499784625305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-07-30 at 22:26 +0200, Paolo Abeni wrote:
> On Thu, 2020-07-30 at 19:06 +0800, Geliang Tang wrote:
> > The patch adds a new list named anno_list in mptcp_pm_data, to record a=
ll
> > the announced addrs. When the PM netlink removes an address, we check if
> > it has been recorded. If it has been, we trigger the RM_ADDR signal.
> > =

> > Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> > Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> > Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> >  net/mptcp/pm.c         |  7 +++++-
> >  net/mptcp/pm_netlink.c | 49 +++++++++++++++++++++++++++++++++++++++++-
> >  net/mptcp/protocol.c   |  2 ++
> >  net/mptcp/protocol.h   |  2 ++
> >  4 files changed, 58 insertions(+), 2 deletions(-)
> > =

> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 558462d87eb3..b3712771f268 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -24,7 +24,11 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> >  =

> >  int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
> >  {
> > -	return -ENOTSUPP;
> > +	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
> > +
> > +	msk->pm.rm_id =3D local_id;
> > +	WRITE_ONCE(msk->pm.rm_addr_signal, true);
> > +	return 0;
> >  }
> >  =

> >  int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id)
> > @@ -229,6 +233,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
> >  	msk->pm.status =3D 0;
> >  =

> >  	spin_lock_init(&msk->pm.lock);
> > +	INIT_LIST_HEAD(&msk->pm.anno_list);
> >  =

> >  	mptcp_pm_nl_data_init(msk);
> >  }
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 74a18e463c3d..b9f0622e4082 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -169,6 +169,19 @@ static void check_work_pending(struct mptcp_sock *=
msk)
> >  		WRITE_ONCE(msk->pm.work_pending, false);
> >  }
> >  =

> > +void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
> > +{
> > +	struct mptcp_pm_addr_entry *entry, *tmp;
> > +
> > +	pr_debug("msk=3D%p\n", msk);
> > +	spin_lock_bh(&msk->pm.lock);
> > +	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
> > +		list_del(&entry->list);
> > +		kfree(entry);
> > +	}
> > +	spin_unlock_bh(&msk->pm.lock);
> > +}
> > +
> >  static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *=
msk)
> >  {
> >  	struct sock *sk =3D (struct sock *)msk;
> > @@ -189,8 +202,16 @@ static void mptcp_pm_create_subflow_or_signal_addr=
(struct mptcp_sock *msk)
> >  					      msk->pm.add_addr_signaled);
> >  =

> >  		if (local) {
> > +			struct mptcp_pm_addr_entry *clone =3D NULL;
> > +
> >  			msk->pm.add_addr_signaled++;
> >  			mptcp_pm_announce_addr(msk, &local->addr);
> > +
> > +			clone =3D kmemdup(local, sizeof(*local), GFP_ATOMIC);
> > +			if (!clone)
> > +				return;
> > +
> > +			list_add(&clone->list, &msk->pm.anno_list);
> >  		} else {
> >  			/* pick failed, avoid fourther attempts later */
> >  			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
> > @@ -548,6 +569,30 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, u=
nsigned int id)
> >  	return NULL;
> >  }
> >  =

> > +static void mptcp_nl_remove_addr(struct sk_buff *skb, struct mptcp_add=
r_info *addr)
> > +{
> > +	struct mptcp_sock *msk;
> > +	long s_slot =3D 0, s_num =3D 0;
> > +	struct net *net =3D sock_net(skb->sk);
> > +
> > +	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NUL=
L) {
> > +		struct mptcp_pm_addr_entry *entry, *tmp;
> > +		struct sock *sk =3D (struct sock *)msk;
> > +
> > +		pr_debug("msk=3D%p\n", msk);
> > +		spin_lock_bh(&msk->pm.lock);

You can skip acquiring the spinlock and all the following when:

		if (list_empty(&msk->pm.anno_list))
			continue; =


> > +		list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
> > +			if (addresses_equal(&entry->addr, addr, false)) {
> > +				mptcp_pm_remove_addr(msk, addr->id);
> > +				list_del(&entry->list);
> > +				kfree(entry);
> > +			}
> > +		}
> > +		spin_unlock_bh(&msk->pm.lock);
> > +		sock_put(sk);
> =

> it would be better add a =

> 		cond_resched();
> =

> here, since traversing the hash table could potentially starve the
> scheduler for long time otherwise.

additionally I think here is necessary also to shutdown the subflow
using addr as source, if present - alike what mptcp_nl_remove_subflow()
does in the next patch.

Perhaps is easier merge the two helpers (mptcp_nl_remove_subflow()
and mptcp_nl_remove_addr()) - not sure without writing the actual code.

/P

--===============8983411499784625305==--
