Content-Type: multipart/mixed; boundary="===============6832152593879770215=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 2/9] Squash-to: "mptcp: Add path manager
 interface"
Date: Fri, 21 Feb 2020 19:32:44 +0100
Message-ID: <05a0035395ea62d8c99ae42ba8ec68eba8906100.camel@redhat.com>
In-Reply-To: 3eabe4a7-75b8-ec1f-a40c-46459de40160@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3740

--===============6832152593879770215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-02-21 at 18:59 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> Thank you for looking at that!
> =

> On 21/02/2020 17:48, Paolo Abeni wrote:
> > Factor out PM addr info to simplify PM data definition and
> > simplify the PM hooks/APIs.
> > =

> > The PM will carry a single local and remote addrs - the one
> > currently being processed, if any. It's up to the PM impl,
> > e.g. netlink, maintain additional per msk data, if needed.
> > =

> > Account the number of created subflow and received addresses,
> > to enforce limits.
> > =

> > Add a spinlock to protect PM datas, so that we can manipulate
> > them from subflow BH.
> > =

> > Delegate events handling to a workqueue, so that PM events can
> > be processed with both the above spinlock and the msk socket
> > lock held. The PM impl should hook inside the worker.
> > =

> > v1 -> v2:
> >   - be sure to initialize the address port before calling
> >     mptcp_pm_add_addr()
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> >   net/mptcp/options.c  |  46 ++++++++++--------
> >   net/mptcp/pm.c       | 112 ++++++++++++++-----------------------------
> >   net/mptcp/protocol.c |   2 +
> >   net/mptcp/protocol.h |  98 ++++++++++++++++++++++---------------
> >   4 files changed, 123 insertions(+), 135 deletions(-)
> > =

> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index c9f508451f2e..08f00f251838 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -8,38 +8,22 @@
> =

> [...]
> =

> > +void mptcp_pm_data_init(struct mptcp_sock *msk)
> > +{
> > +	msk->pm.add_addr_signaled =3D 0;
> > +	msk->pm.add_addr_accepted =3D 0;
> > +	msk->pm.local_addr_used =3D 0;
> > +	WRITE_ONCE(msk->pm.work_pending, false);
> > +	WRITE_ONCE(msk->pm.addr_signal, false);
> > +	WRITE_ONCE(msk->pm.fully_established, false);
> > +	WRITE_ONCE(msk->pm.accept_addr, false);
> > +	msk->pm.status =3D MPTCP_PM_IDLE;
> Just by curiosity, why do we need to reset those fields to 0? Is this =

> msk not already init to 0? Can we not memset the whole pm part?

Uhm... we don't need that for sk_alloc(), but we need the above after
mptcp_sk_clone_lock().

memset() could be more efficient than direct assigment if clearing a
wider memory area, see 236222d39347e0e486010f10c1493e83dbbdfba8.

For a bunch of fields we are better off explicitly setting them, I
think.

> > -int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
> > -			 struct sockaddr_storage *saddr);
> > -int mptcp_pm_get_local_id(struct request_sock *req, struct sock *sk,
> > -			  const struct sk_buff *skb);
> > +bool mptcp_pm_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
> > +			  struct mptcp_addr_info *saddr);
> > +int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *=
skc);
> =

> I guess I will see that in another patch but why "struct sock_common" =

> instead of "struc sock"?

I guess you are already there, anyway mptcp_pm_get_local_id() must be
called on both request_sock and tcp_sock.

Cheers,

Paolo

--===============6832152593879770215==--
