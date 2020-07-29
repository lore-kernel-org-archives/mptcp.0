Content-Type: multipart/mixed; boundary="===============1539264921282846833=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 4/4] mptcp: trigger the
 RM_ADDR signal
Date: Wed, 29 Jul 2020 17:33:32 +0800
Message-ID: <20200729093332.GA26613@OptiPlex>
In-Reply-To: c5a7af2044a9f9fc395579f4a10de9f2888f9556.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5367

--===============1539264921282846833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

I have sent out REMOVE_ADDR patchset v3 to you.

On Wed, Jul 22, 2020 at 01:34:25PM +0200, Paolo Abeni wrote:
> On Wed, 2020-07-22 at 12:41 +0200, Paolo Abeni wrote:
> > > +void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
> > > +{
> > > + struct mptcp_subflow_context *subflow, *tmp;
> > > +
> > > + pr_debug("remote_id %d", msk->pm.rm_id);
> > > +
> > > + msk->pm.add_addr_accepted--;
> > > + msk->pm.subflows--;
> > > + WRITE_ONCE(msk->pm.accept_addr, true);
> > > +
> > > + list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> > > +         struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
> > > +
> > > +         if (msk->pm.rm_id =3D=3D subflow->remote_id) {
> > > +                 mptcp_subflow_shutdown(tcp_sk, 1, 1, msk->write_seq=
);
> > =

> > the 2nd argument for mptcp_subflow_shutdown() should be something alike
> > 'RCV_SHUTDOWN|SEND_SHUTDOWN' - we are closing the subflow in both
> > direction - and the third argument '0' - the msk will remain
> > open/established.
> >

I have updated these arguments in patchset v3.

> > I think here the subflow socket will be leaked. Can you please double
> > check that with a CONFIG_DEBUG_KMEMLEAK enabled build?
> > =

> > Likely something alike what __mptcp_close_ssk() is currently doing
> > should be added here, but that will not fit nicely with a proper
> > shutdown, so I'm unsure how to address this correctly.

Yes, there is a memory leak here. I have fixed it in patchset v3 by
calling __mptcp_close_ssk.

And there is another memory leak in mptcp_nl_remove_addr, and I fixed it
by calling sock_put in patchset v3.

> =

> Whoops... some additional things I missed before:
> =

> You must release the msk.pm lock before
> invoking mptcp_subflow_shutdown() and re-acquiring it after the
> function call completes (some CONFIG_DEBUG_ know should warn you at run
> time).

Fixed in patchset v3.

> =

> And the RFC states:
> =

> """
>    if a host receives a REMOVE_ADDR option, it
>    must ensure that the affected path or paths are no longer in use
>    before it instigates closure.  The receipt of REMOVE_ADDR SHOULD
>    first trigger the sending of a TCP keepalive [RFC1122] on the path,
>    and if a response is received, the path SHOULD NOT be removed.  If
>    the path is found to still be alive, the receiving host SHOULD no
>    longer use the specified address for future connections, but it is
>    the responsibility of the host that sent the REMOVE_ADDR to shut down
>    the subflow.
> """
> =

> I'm unsure what "the affected path or paths are no longer in use" means
> here. @Christoph: how is mptcp.org handling this? With a quick glance
> it looks like it unconditionally remove the subflow[s] ???

On Wed, Jul 22, 2020 at 01:12:32PM +0200, Paolo Abeni wrote:
> On Wed, 2020-07-22 at 16:42 +0800, Geliang Tang wrote:
> > Trigger the RM_ADDR signal when the PM netlink removes an address.
> > =

> > Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> > Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> >  net/mptcp/pm.c         |  6 +++++-
> >  net/mptcp/pm_netlink.c | 32 +++++++++++++++++++++++++++++++-
> >  net/mptcp/protocol.c   |  1 +
> >  net/mptcp/protocol.h   |  1 +
> >  4 files changed, 38 insertions(+), 2 deletions(-)
> > =

> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 84fad1fec28b..4194fd2591c5 100644
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
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 2ee7227f5f2b..646398f16ce8 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -23,6 +23,7 @@ static int pm_nl_pernet_id;
> >  =

> >  struct mptcp_pm_addr_entry {
> >  	struct list_head	list;
> > +	struct list_head	alist;
> =

> I think this new field is not needed, see below...
> =

> >  	unsigned int		flags;
> >  	int			ifindex;
> >  	struct mptcp_addr_info	addr;
> > @@ -169,6 +170,13 @@ static void check_work_pending(struct mptcp_sock *=
msk)
> >  		WRITE_ONCE(msk->pm.work_pending, false);
> >  }
> >  =

> > +static int mptcp_pm_add_announce_list(struct mptcp_sock *msk,
> > +				      struct mptcp_pm_addr_entry *entry)
> > +{
> > +	list_add(&entry->alist, &msk->anno_list);
> > +	return 0;
> > +}
> > +
> >  static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *=
msk)
> >  {
> >  	struct sock *sk =3D (struct sock *)msk;
> > @@ -191,6 +199,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(=
struct mptcp_sock *msk)
> >  		if (local) {
> >  			msk->pm.add_addr_signaled++;
> >  			mptcp_pm_announce_addr(msk, &local->addr);
> > +			mptcp_pm_add_announce_list(msk, local);
> =

> Here we need to allocate a new mptcp_pm_addr_entry struct, copy the
> data from local, and finally add the new entry to anno_list. I guess
> all the logic could be encapsulated
> into mptcp_pm_create_subflow_or_signal_addr(), which could return a
> bool indicating if the allocation was successful.
> =

> In cause of memory allocation failure the announce addr should not be
> performed.
> =

> The same address can be signaled from multiple msks. If we always use
> the same struct we will see data corruption.
> =

> I *think* dynamically allocation of announced address could be ok, I'd
> like to ear opinions from others.
> =


Fixed in patchset v3.

> >  		} else {
> >  			/* pick failed, avoid fourther attempts later */
> >  			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
> > @@ -537,6 +546,25 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, u=
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
> > +
> > +		pr_debug("msk=3D%p\n", msk);
> > +		list_for_each_entry_safe(entry, tmp, &msk->anno_list, alist) {
> > +			if (addresses_equal(&entry->addr, addr, false)) {
> > +				mptcp_pm_remove_addr(msk, addr->id);
> > +				list_del(&entry->alist);
> > +			}
> > +		}
> > +	}
> > +}
> =

> Here you need to acquire the msk pm lock before traversing the
> anno_list and eventually removing the entry.
> =


Fixed in patchset v3.

> Additionally, we should also shutdown the subflows with the local
> address matching the removed one. Note that the 'id' could not be used
> for the first subflow, being always 0, and we should to this for any
> removed address, regardless of the 'MPTCP_PM_ADDR_FLAG_SIGNAL' flag.

I'll add a new function mptcp_nl_remove_subflow to handle the
'MPTCP_PM_ADDR_FLAG_SUBFLOW' flag case. Do the local subflow removing
in this function. I'll send out this patch later.

Thanks.

-Geliang

> =

> Cheers,
> =

> Paolo
--===============1539264921282846833==--
