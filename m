Content-Type: multipart/mixed; boundary="===============2800334814125329317=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 3/4] mptcp: add the incoming
 RM_ADDR support
Date: Thu, 30 Jul 2020 19:49:20 +0800
Message-ID: <20200730114920.GA26992@OptiPlex>
In-Reply-To: alpine.OSX.2.23.453.2007291711290.1985@ltd-ie-desk02.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5399

--===============2800334814125329317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On Wed, Jul 29, 2020 at 05:27:40PM -0700, Mat Martineau wrote:
> =

> Hi Geliang -
> =

> On Wed, 29 Jul 2020, Geliang Tang wrote:
> =

> > This patch added the RM_ADDR option parsing logic:
> > =

> > We parsed the incoming options to find if the rm_addr option is receive=
d,
> > and called mptcp_pm_rm_addr_received to schedule PM work to a new statu=
s,
> > named MPTCP_PM_RM_ADDR_RECEIVED.
> > =

> > PM work got this status, and called mptcp_pm_nl_rm_addr_received to han=
dle
> > it.
> > =

> > In mptcp_pm_nl_rm_addr_received, we closed the subflow matching the rm_=
id,
> > and updated pm counter.
> > =

> > Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> > Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/options.c    |  5 +++++
> > net/mptcp/pm.c         | 12 ++++++++++++
> > net/mptcp/pm_netlink.c | 27 ++++++++++++++++++++++++++-
> > net/mptcp/protocol.c   | 14 +++++++++-----
> > net/mptcp/protocol.h   |  8 ++++++++
> > net/mptcp/subflow.c    |  1 +
> > 6 files changed, 61 insertions(+), 6 deletions(-)
> > =

> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index f067980dc49a..8a66848c888e 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -873,6 +873,11 @@ void mptcp_incoming_options(struct sock *sk, struc=
t sk_buff *skb,
> > 		mp_opt.add_addr =3D 0;
> > 	}
> > =

> > +	if (mp_opt.rm_addr) {
> > +		mptcp_pm_rm_addr_received(msk, mp_opt.rm_id);
> > +		mp_opt.rm_addr =3D 0;
> > +	}
> > +
> > 	if (!mp_opt.dss)
> > 		return;
> > =

> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 91b74ca47fa1..84fad1fec28b 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -149,6 +149,18 @@ void mptcp_pm_add_addr_received(struct mptcp_sock =
*msk,
> > 	spin_unlock_bh(&pm->lock);
> > }
> > =

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
> > /* path manager helpers */
> > =

> > bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int rema=
ining,
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index c8820c4156e6..bcf4fccaf7d0 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -173,7 +173,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(=
struct mptcp_sock *msk)
> > {
> > 	struct sock *sk =3D (struct sock *)msk;
> > 	struct mptcp_pm_addr_entry *local;
> > -	struct mptcp_addr_info remote;
> > +	struct mptcp_addr_info remote =3D { 0 };
> > 	struct pm_nl_pernet *pernet;
> > =

> > 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> > @@ -261,6 +261,31 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_so=
ck *msk)
> > 	spin_lock_bh(&msk->pm.lock);
> > }
> > =

> > +void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
> > +{
> > +	struct mptcp_subflow_context *subflow, *tmp;
> > +	struct sock *sk =3D (struct sock *)msk;
> > +
> > +	pr_debug("remote_id %d", msk->pm.rm_id);
> > +
> > +	msk->pm.add_addr_accepted--;
> > +	msk->pm.subflows--;
> > +	WRITE_ONCE(msk->pm.accept_addr, true);
> > +
> > +	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> > +		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> > +		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
> > +		long timeout =3D 0;
> > +
> > +		if (msk->pm.rm_id =3D=3D subflow->remote_id) {
> > +			spin_unlock_bh(&msk->pm.lock);
> > +			mptcp_subflow_shutdown(ssk, how, 0, msk->write_seq);
> =

> mptcp_subflow_shutdown() has different args in the net-next branch now
> (after DATA_FIN got merged), so you'll need to change this to
> mptcp_subflow_shutdown(sk, ssk, how)
>
> What happens if the peer sends RM_ADDR and every subflow in conn_list uses
> that remote_id? We haven't tried any "break before make" scenarios (where
> all subflows are closed and then an MP_JOIN establishes a new subflow aft=
er
> some amount of time), and I'm not sure how well an empty conn_list will be
> handled by the current code.
> =


Thanks for your suggestions. I have fixed them in patchset v4.

-Geliang

> =

> Mat
> =

> =

> > +			__mptcp_close_ssk(sk, ssk, subflow, timeout);
> > +			spin_lock_bh(&msk->pm.lock);
> > +		}
> > +	}
> > +}
> > +
> > static bool address_use_port(struct mptcp_pm_addr_entry *entry)
> > {
> > 	return (entry->flags &
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 4189fc9df764..e7c7b8794868 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1197,9 +1197,9 @@ static struct sock *mptcp_subflow_get_retrans(con=
st struct mptcp_sock *msk)
> >  * so we need to use tcp_close() after detaching them from the mptcp
> >  * parent socket.
> >  */
> > -static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> > -			      struct mptcp_subflow_context *subflow,
> > -			      long timeout)
> > +void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> > +		       struct mptcp_subflow_context *subflow,
> > +		       long timeout)
> > {
> > 	struct socket *sock =3D READ_ONCE(ssk->sk_socket);
> > =

> > @@ -1230,6 +1230,10 @@ static void pm_work(struct mptcp_sock *msk)
> > 		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
> > 		mptcp_pm_nl_add_addr_received(msk);
> > 	}
> > +	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
> > +		pm->status &=3D ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
> > +		mptcp_pm_nl_rm_addr_received(msk);
> > +	}
> > 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
> > 		pm->status &=3D ~BIT(MPTCP_PM_ESTABLISHED);
> > 		mptcp_pm_nl_fully_established(msk);
> > @@ -1386,8 +1390,8 @@ static void mptcp_cancel_work(struct sock *sk)
> > 		sock_put(sk);
> > }
> > =

> > -static void mptcp_subflow_shutdown(struct sock *ssk, int how,
> > -				   bool data_fin_tx_enable, u64 data_fin_tx_seq)
> > +void mptcp_subflow_shutdown(struct sock *ssk, int how,
> > +			    bool data_fin_tx_enable, u64 data_fin_tx_seq)
> > {
> > 	lock_sock(ssk);
> > =

> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index b673e741f192..b9058675cbf6 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -150,6 +150,7 @@ struct mptcp_addr_info {
> > =

> > enum mptcp_pm_status {
> > 	MPTCP_PM_ADD_ADDR_RECEIVED,
> > +	MPTCP_PM_RM_ADDR_RECEIVED,
> > 	MPTCP_PM_ESTABLISHED,
> > 	MPTCP_PM_SUBFLOW_ESTABLISHED,
> > };
> > @@ -349,6 +350,11 @@ void mptcp_subflow_fully_established(struct mptcp_=
subflow_context *subflow,
> > 				     struct mptcp_options_received *mp_opt);
> > bool mptcp_subflow_data_available(struct sock *sk);
> > void __init mptcp_subflow_init(void);
> > +void mptcp_subflow_shutdown(struct sock *ssk, int how,
> > +			    bool data_fin_tx_enable, u64 data_fin_tx_seq);
> > +void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> > +		       struct mptcp_subflow_context *subflow,
> > +		       long timeout);
> > =

> > /* called with sk socket lock held */
> > int __mptcp_subflow_connect(struct sock *sk, int ifindex,
> > @@ -420,6 +426,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock=
 *msk,
> > void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
> > void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> > 				const struct mptcp_addr_info *addr);
> > +void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
> > =

> > int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> > 			   const struct mptcp_addr_info *addr);
> > @@ -454,6 +461,7 @@ void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
> > void mptcp_pm_nl_fully_established(struct mptcp_sock *msk);
> > void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk);
> > void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk);
> > +void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
> > int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common=
 *skc);
> > =

> > static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index e645483d1200..199a5eaef5fc 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1007,6 +1007,7 @@ int __mptcp_subflow_connect(struct sock *sk, int =
ifindex,
> > 	subflow->remote_key =3D msk->remote_key;
> > 	subflow->local_key =3D msk->local_key;
> > 	subflow->token =3D msk->token;
> > +	subflow->remote_id =3D remote->id;
> > 	mptcp_info2sockaddr(loc, &addr);
> > =

> > 	addrlen =3D sizeof(struct sockaddr_in);
> > -- =

> > 2.17.1
> =

> --
> Mat Martineau
> Intel
--===============2800334814125329317==--
