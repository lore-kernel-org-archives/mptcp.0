Content-Type: multipart/mixed; boundary="===============8644455993617877330=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: add REMOVE_ADDR support v1
Date: Wed, 22 Jul 2020 17:02:48 +0800
Message-ID: <20200722090248.GA573@OptiPlex>
In-Reply-To: 84f200774b99870e17072244c5d17caa89a89dba.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5174

--===============8644455993617877330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 04:41:52PM +0200, Paolo Abeni wrote:
> Hi,
> =

> On Thu, 2020-07-16 at 16:45 +0800, Geliang Tang wrote:
> > Add REMOVE_ADDR support.
> > =

> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> >  This is the first version of REMOVE_ADDR support. It's not finished ye=
t but
> >  it works. I'll add selftest case and patch commit description later. P=
lease
> >  give me some advice on how to improve it. Thanks.
> =

> I think this code could be split in a few patches:
> =

> * one renaming the existing add_addr related functions
> * one doing the rm_addr option parsing/writing
> * one implementing the rm addr logic
> =

> This latter part is the least clear to me. If I read the code
> correctly, the idea is having each msk checking in the data path if any
> address has been removed via the PM netlink APIs. Is the above correct?
> =

> I think it would be better triggering the remove addr in the reverse
> way: when the PM netlink removes an address it should traverse all the
> existing msk sockets - using the recently introduced
> mptcp_token_iter_next() helper - and set 'rm_addr_signal' on the
> relevant sockets - the ones that already announced it.
> =

> This latter condition is possibly a bit hard to track. As far as I read
> the RFC, we could use a simpler one: send the RM_ADDR on the msk with a
> subflows using the relevant addr.
> =

> The idea behind the above is that servers should not usually send
> RM_ADDR, while clients should have a limited number of open MPTCP
> connections, so traversing all the token table should not be a
> problem. =

> =

> Not sure if the above is somewhat readable - we can discuss it in the
> mtg soon!
> =

> Please see also:
> =

> https://github.com/multipath-tcp/mptcp_net-next/issues/19
> =

> which is somewhat related.
> =

> Cheers,
> =

> Paolo

Hi Paolo,

Thanks for your suggestions. I have updated my patches, and sent out patchs=
et v2 to you.

-Geliang

> =

> > ---
> >  net/mptcp/options.c    | 49 +++++++++++++++++++++++++----
> >  net/mptcp/pm.c         | 71 ++++++++++++++++++++++++++++++++++++++----
> >  net/mptcp/pm_netlink.c | 47 +++++++++++++++++++++++++++-
> >  net/mptcp/protocol.c   | 12 +++++--
> >  net/mptcp/protocol.h   | 26 +++++++++++++---
> >  net/mptcp/subflow.c    |  1 +
> >  6 files changed, 187 insertions(+), 19 deletions(-)
> > =

> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 19707c07efc1..0d4d334fbc08 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -572,10 +572,10 @@ static u64 add_addr6_generate_hmac(u64 key1, u64 =
key2, u8 addr_id,
> >  }
> >  #endif
> >  =

> > -static bool mptcp_established_options_addr(struct sock *sk,
> > -					   unsigned int *size,
> > -					   unsigned int remaining,
> > -					   struct mptcp_out_options *opts)
> > +static bool mptcp_established_options_add_addr(struct sock *sk,
> > +					       unsigned int *size,
> > +					       unsigned int remaining,
> > +					       struct mptcp_out_options *opts)
> >  {
> >  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> >  	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> > @@ -583,7 +583,7 @@ static bool mptcp_established_options_addr(struct s=
ock *sk,
> >  	int len;
> >  =

> >  	if (!mptcp_pm_should_signal(msk) ||
> > -	    !(mptcp_pm_addr_signal(msk, remaining, &saddr)))
> > +	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr)))
> >  		return false;
> >  =

> >  	len =3D mptcp_add_addr_len(saddr.family);
> > @@ -615,6 +615,31 @@ static bool mptcp_established_options_addr(struct =
sock *sk,
> >  	return true;
> >  }
> >  =

> > +static bool mptcp_established_options_rm_addr(struct sock *sk,
> > +					      unsigned int *size,
> > +					      unsigned int remaining,
> > +					      struct mptcp_out_options *opts)
> > +{
> > +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> > +	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> > +	u8 rm_id;
> > +
> > +	if (!mptcp_pm_should_rm_signal(msk) ||
> > +	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_id)))
> > +		return false;
> > +
> > +	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
> > +		return false;
> > +
> > +	*size =3D TCPOLEN_MPTCP_RM_ADDR_BASE;
> > +	opts->suboptions |=3D OPTION_MPTCP_RM_ADDR;
> > +	opts->rm_id =3D rm_id;
> > +
> > +	pr_debug("rm_id=3D%d", opts->rm_id);
> > +
> > +	return true;
> > +}
> > +
> >  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> >  			       unsigned int *size, unsigned int remaining,
> >  			       struct mptcp_out_options *opts)
> > @@ -641,7 +666,13 @@ bool mptcp_established_options(struct sock *sk, st=
ruct sk_buff *skb,
> >  =

> >  	*size +=3D opt_size;
> >  	remaining -=3D opt_size;
> > -	if (mptcp_established_options_addr(sk, &opt_size, remaining, opts)) {
> > +	if (mptcp_established_options_add_addr(sk, &opt_size, remaining, opts=
)) {
> > +		*size +=3D opt_size;
> > +		remaining -=3D opt_size;
> > +		ret =3D true;
> > +	}
> > +
> > +	if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)=
) {
> >  		*size +=3D opt_size;
> >  		remaining -=3D opt_size;
> >  		ret =3D true;
> > @@ -729,6 +760,7 @@ static bool check_fully_established(struct mptcp_so=
ck *msk, struct sock *sk,
> >  	subflow->can_ack =3D 1;
> >  =

> >  fully_established:
> > +	mptcp_pm_addr_update(msk);
> >  	if (likely(subflow->pm_notified))
> >  		return true;
> >  =

> > @@ -845,6 +877,11 @@ void mptcp_incoming_options(struct sock *sk, struc=
t sk_buff *skb,
> >  		mp_opt.add_addr =3D 0;
> >  	}
> >  =

> > +	if (mp_opt.rm_addr) {
> > +		mptcp_pm_rm_addr_received(msk, mp_opt.rm_id);
> > +		mp_opt.rm_addr =3D 0;
> > +	}
> > +
> >  	if (!mp_opt.dss)
> >  		return;
> >  =

> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index a8ad20559aaa..c811559ca78f 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -18,13 +18,17 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> >  	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
> >  =

> >  	msk->pm.local =3D *addr;
> > -	WRITE_ONCE(msk->pm.addr_signal, true);
> > +	WRITE_ONCE(msk->pm.add_addr_signal, true);
> >  	return 0;
> >  }
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
> > @@ -81,6 +85,24 @@ static bool mptcp_pm_schedule_work(struct mptcp_sock=
 *msk,
> >  	return true;
> >  }
> >  =

> > +void mptcp_pm_addr_update(struct mptcp_sock *msk)
> > +{
> > +	struct mptcp_pm_data *pm =3D &msk->pm;
> > +
> > +	pr_debug("msk=3D%p", msk);
> > +
> > +	/* try to avoid acquiring the lock below */
> > +	if (!READ_ONCE(pm->work_pending))
> > +		return;
> > +
> > +	spin_lock_bh(&pm->lock);
> > +
> > +	if (READ_ONCE(pm->work_pending))
> > +		mptcp_pm_schedule_work(msk, MPTCP_PM_ADDR_UPDATE);
> > +
> > +	spin_unlock_bh(&pm->lock);
> > +}
> > +
> >  void mptcp_pm_fully_established(struct mptcp_sock *msk)
> >  {
> >  	struct mptcp_pm_data *pm =3D &msk->pm;
> > @@ -151,8 +173,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *=
msk,
> >  =

> >  /* path manager helpers */
> >  =

> > -bool mptcp_pm_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
> > -			  struct mptcp_addr_info *saddr)
> > +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int rem=
aining,
> > +			      struct mptcp_addr_info *saddr)
> >  {
> >  	int ret =3D false;
> >  =

> > @@ -166,7 +188,42 @@ bool mptcp_pm_addr_signal(struct mptcp_sock *msk, =
unsigned int remaining,
> >  		goto out_unlock;
> >  =

> >  	*saddr =3D msk->pm.local;
> > -	WRITE_ONCE(msk->pm.addr_signal, false);
> > +	WRITE_ONCE(msk->pm.add_addr_signal, false);
> > +	ret =3D true;
> > +
> > +out_unlock:
> > +	spin_unlock_bh(&msk->pm.lock);
> > +	return ret;
> > +}
> > +
> > +void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
> > +{
> > +	struct mptcp_pm_data *pm =3D &msk->pm;
> > +
> > +	pr_debug("msk=3D%p remote_id=3D%d", msk, rm_id);
> > +
> > +	spin_lock_bh(&pm->lock);
> > +	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
> > +	pm->rm_id =3D rm_id;
> > +	spin_unlock_bh(&pm->lock);
> > +}
> > +
> > +bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int rema=
ining,
> > +			     u8 *rm_id)
> > +{
> > +	int ret =3D false;
> > +
> > +	spin_lock_bh(&msk->pm.lock);
> > +
> > +	/* double check after the lock is acquired */
> > +	if (!mptcp_pm_should_rm_signal(msk))
> > +		goto out_unlock;
> > +
> > +	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
> > +		goto out_unlock;
> > +
> > +	*rm_id =3D msk->pm.rm_id;
> > +	WRITE_ONCE(msk->pm.rm_addr_signal, false);
> >  	ret =3D true;
> >  =

> >  out_unlock:
> > @@ -186,9 +243,11 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
> >  	msk->pm.local_addr_used =3D 0;
> >  	msk->pm.subflows =3D 0;
> >  	WRITE_ONCE(msk->pm.work_pending, false);
> > -	WRITE_ONCE(msk->pm.addr_signal, false);
> > +	WRITE_ONCE(msk->pm.add_addr_signal, false);
> > +	WRITE_ONCE(msk->pm.rm_addr_signal, false);
> >  	WRITE_ONCE(msk->pm.accept_addr, false);
> >  	WRITE_ONCE(msk->pm.accept_subflow, false);
> > +	WRITE_ONCE(msk->pm.addr_updated, false);
> >  	msk->pm.status =3D 0;
> >  =

> >  	spin_lock_init(&msk->pm.lock);
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index c8820c4156e6..c9933387be09 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -39,6 +39,7 @@ struct pm_nl_pernet {
> >  	unsigned int		local_addr_max;
> >  	unsigned int		subflows_max;
> >  	unsigned int		next_id;
> > +	unsigned int		rm_id;
> >  };
> >  =

> >  #define MPTCP_PM_ADDR_MAX	8
> > @@ -165,7 +166,7 @@ static void check_work_pending(struct mptcp_sock *m=
sk)
> >  {
> >  	if (msk->pm.add_addr_signaled =3D=3D msk->pm.add_addr_signal_max &&
> >  	    (msk->pm.local_addr_used =3D=3D msk->pm.local_addr_max ||
> > -	     msk->pm.subflows =3D=3D msk->pm.subflows_max))
> > +	     msk->pm.subflows =3D=3D msk->pm.subflows_max) && msk->pm.addr_up=
dated)
> >  		WRITE_ONCE(msk->pm.work_pending, false);
> >  }
> >  =

> > @@ -196,6 +197,11 @@ static void mptcp_pm_create_subflow_or_signal_addr=
(struct mptcp_sock *msk)
> >  			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
> >  		}
> >  =

> > +		check_work_pending(msk);
> > +	} else if (msk->pm.add_addr_signaled > msk->pm.add_addr_signal_max) {
> > +		msk->pm.add_addr_signaled--;
> > +		mptcp_pm_remove_addr(msk, pernet->rm_id);
> > +
> >  		check_work_pending(msk);
> >  	}
> >  =

> > @@ -261,6 +267,26 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_so=
ck *msk)
> >  	spin_lock_bh(&msk->pm.lock);
> >  }
> >  =

> > +void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
> > +{
> > +	struct mptcp_subflow_context *subflow, *tmp;
> > +
> > +	pr_debug("remote_id %d", msk->pm.rm_id);
> > +
> > +	msk->pm.add_addr_accepted--;
> > +	msk->pm.subflows--;
> > +	WRITE_ONCE(msk->pm.accept_addr, true);
> > +
> > +	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> > +		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
> > +
> > +		if (msk->pm.rm_id =3D=3D subflow->remote_id) {
> > +			mptcp_subflow_shutdown(tcp_sk, 1, 1, msk->write_seq);
> > +			list_del(&subflow->node);
> > +		}
> > +	}
> > +}
> > +
> >  static bool address_use_port(struct mptcp_pm_addr_entry *entry)
> >  {
> >  	return (entry->flags &
> > @@ -354,6 +380,24 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *ms=
k, struct sock_common *skc)
> >  	return ret;
> >  }
> >  =

> > +void mptcp_pm_nl_addr_update(struct mptcp_sock *msk)
> > +{
> > +	struct mptcp_pm_data *pm =3D &msk->pm;
> > +	struct pm_nl_pernet *pernet;
> > +
> > +	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> > +
> > +	if (pm->add_addr_signal_max !=3D pernet->add_addr_signal_max) {
> > +		pm->add_addr_signal_max =3D READ_ONCE(pernet->add_addr_signal_max);
> > +		pm->add_addr_accept_max =3D READ_ONCE(pernet->add_addr_accept_max);
> > +
> > +		mptcp_pm_create_subflow_or_signal_addr(msk);
> > +		WRITE_ONCE(pm->addr_updated, true);
> > +	} else {
> > +		WRITE_ONCE(pm->addr_updated, false);
> > +	}
> > +}
> > +
> >  void mptcp_pm_nl_data_init(struct mptcp_sock *msk)
> >  {
> >  	struct mptcp_pm_data *pm =3D &msk->pm;
> > @@ -541,6 +585,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *sk=
b, struct genl_info *info)
> >  		pernet->local_addr_max--;
> >  =

> >  	pernet->addrs--;
> > +	pernet->rm_id =3D addr.addr.id;
> >  	list_del_rcu(&entry->list);
> >  	kfree_rcu(entry, rcu);
> >  out:
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index dbe43e0cd734..31b836ed0786 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1225,6 +1225,14 @@ static void pm_work(struct mptcp_sock *msk)
> >  		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
> >  		mptcp_pm_nl_add_addr_received(msk);
> >  	}
> > +	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
> > +		pm->status &=3D ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
> > +		mptcp_pm_nl_rm_addr_received(msk);
> > +	}
> > +	if (pm->status & BIT(MPTCP_PM_ADDR_UPDATE)) {
> > +		pm->status &=3D ~BIT(MPTCP_PM_ADDR_UPDATE);
> > +		mptcp_pm_nl_addr_update(msk);
> > +	}
> >  	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
> >  		pm->status &=3D ~BIT(MPTCP_PM_ESTABLISHED);
> >  		mptcp_pm_nl_fully_established(msk);
> > @@ -1381,8 +1389,8 @@ static void mptcp_cancel_work(struct sock *sk)
> >  		sock_put(sk);
> >  }
> >  =

> > -static void mptcp_subflow_shutdown(struct sock *ssk, int how,
> > -				   bool data_fin_tx_enable, u64 data_fin_tx_seq)
> > +void mptcp_subflow_shutdown(struct sock *ssk, int how,
> > +			    bool data_fin_tx_enable, u64 data_fin_tx_seq)
> >  {
> >  	lock_sock(ssk);
> >  =

> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index e5baaef5ec89..5587613f5b03 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -150,6 +150,8 @@ struct mptcp_addr_info {
> >  =

> >  enum mptcp_pm_status {
> >  	MPTCP_PM_ADD_ADDR_RECEIVED,
> > +	MPTCP_PM_RM_ADDR_RECEIVED,
> > +	MPTCP_PM_ADDR_UPDATE,
> >  	MPTCP_PM_ESTABLISHED,
> >  	MPTCP_PM_SUBFLOW_ESTABLISHED,
> >  };
> > @@ -160,11 +162,13 @@ struct mptcp_pm_data {
> >  =

> >  	spinlock_t	lock;		/*protects the whole PM data */
> >  =

> > -	bool		addr_signal;
> > +	bool		add_addr_signal;
> > +	bool		rm_addr_signal;
> >  	bool		server_side;
> >  	bool		work_pending;
> >  	bool		accept_addr;
> >  	bool		accept_subflow;
> > +	bool		addr_updated;
> >  	u8		add_addr_signaled;
> >  	u8		add_addr_accepted;
> >  	u8		local_addr_used;
> > @@ -174,6 +178,7 @@ struct mptcp_pm_data {
> >  	u8		local_addr_max;
> >  	u8		subflows_max;
> >  	u8		status;
> > +	u8		rm_id;
> >  };
> >  =

> >  struct mptcp_data_frag {
> > @@ -344,6 +349,8 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_sub=
flow_context *subflow)
> >  int mptcp_is_enabled(struct net *net);
> >  bool mptcp_subflow_data_available(struct sock *sk);
> >  void __init mptcp_subflow_init(void);
> > +void mptcp_subflow_shutdown(struct sock *ssk, int how,
> > +			    bool data_fin_tx_enable, u64 data_fin_tx_seq);
> >  =

> >  /* called with sk socket lock held */
> >  int __mptcp_subflow_connect(struct sock *sk, int ifindex,
> > @@ -419,8 +426,10 @@ void mptcp_pm_connection_closed(struct mptcp_sock =
*msk);
> >  void mptcp_pm_subflow_established(struct mptcp_sock *msk,
> >  				  struct mptcp_subflow_context *subflow);
> >  void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
> > +void mptcp_pm_addr_update(struct mptcp_sock *msk);
> >  void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> >  				const struct mptcp_addr_info *addr);
> > +void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
> >  =

> >  int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> >  			   const struct mptcp_addr_info *addr);
> > @@ -429,7 +438,12 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk=
, u8 remote_id);
> >  =

> >  static inline bool mptcp_pm_should_signal(struct mptcp_sock *msk)
> >  {
> > -	return READ_ONCE(msk->pm.addr_signal);
> > +	return READ_ONCE(msk->pm.add_addr_signal);
> > +}
> > +
> > +static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
> > +{
> > +	return READ_ONCE(msk->pm.rm_addr_signal);
> >  }
> >  =

> >  static inline unsigned int mptcp_add_addr_len(int family)
> > @@ -439,15 +453,19 @@ static inline unsigned int mptcp_add_addr_len(int=
 family)
> >  	return TCPOLEN_MPTCP_ADD_ADDR6;
> >  }
> >  =

> > -bool mptcp_pm_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
> > -			  struct mptcp_addr_info *saddr);
> > +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int rem=
aining,
> > +			      struct mptcp_addr_info *saddr);
> > +bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int rema=
ining,
> > +			     u8 *rm_id);
> >  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *=
skc);
> >  =

> >  void __init mptcp_pm_nl_init(void);
> >  void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
> > +void mptcp_pm_nl_addr_update(struct mptcp_sock *msk);
> >  void mptcp_pm_nl_fully_established(struct mptcp_sock *msk);
> >  void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk);
> >  void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk);
> > +void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
> >  int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_commo=
n *skc);
> >  =

> >  static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 9f7f3772c13c..326c2df256b7 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -989,6 +989,7 @@ int __mptcp_subflow_connect(struct sock *sk, int if=
index,
> >  	subflow->remote_key =3D msk->remote_key;
> >  	subflow->local_key =3D msk->local_key;
> >  	subflow->token =3D msk->token;
> > +	subflow->remote_id =3D remote->id;
> >  	mptcp_info2sockaddr(loc, &addr);
> >  =

> >  	addrlen =3D sizeof(struct sockaddr_in);
>=20
--===============8644455993617877330==--
