Content-Type: multipart/mixed; boundary="===============7101800841508379318=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 9/9] mptcp: Implement interim path manager
Date: Wed, 24 Jul 2019 16:02:17 -0700
Message-ID: <54284ef097c3eadd87236b33207e05e94c2329e4.camel@linux.intel.com>
In-Reply-To: b0c11cdc27f3de8a799608111a3dfe6f97e08176.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1551

--===============7101800841508379318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Sorry for not responding to these last few comments Paolo, here we are:

On Thu, 2019-07-18 at 10:17 +0200, Paolo Abeni wrote:
> On Wed, 2019-07-17 at 15:12 -0700, Peter Krystad wrote:
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 0d53a0f23d2d..69df6332b4d0 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -8,21 +8,84 @@
> [...]
> >  int pm_create_subflow(u32 token, u8 local_id, u8 remote_id)
> >  {
> > -	return -ENOTSUPP;
> > +	struct mptcp_sock *msk =3D mptcp_sk(token_lookup(token));
> > +	struct sockaddr_in remote;
> > +	struct sockaddr_in local;
> > +	int err;
> > +
> > +	if (!msk)
> > +		return -EINVAL;
> > +
> > +	pr_debug("msk=3D%p", msk);
> > +	if (!msk->pm.local_valid || local_id !=3D msk->pm.local_id) {
> > +		err =3D -EBADR;
> > +		goto create_put;
> > +	}
> > +	local.sin_family =3D AF_INET;
> > +	local.sin_port =3D 0;
> > +	local.sin_addr.s_addr =3D INADDR_ANY;
> =

> It's unclear to me the 'local_id' usage here. I thought 'local_id =3D=3D
> msk->pm.local_id' would imply 'local.sin_addr.s_addr =3D=3D msk-
> > pm.local_addr.s_addr' ???
> =

> Is the PM supposed to validate the local address vs. the known one? or
> should it allow binding to arbitrary local address? I thought the local
> address should be usually unspecified - otherwise the PM should have a
> deep knowledge of the routing tables/policies to get the correct local
> address for a given destination, likely resorting to a route lookup
> before pm_create_subflow() ???

Yes, for our purposes I agree the bind address should always be unspecified=
. I
will remove the local_id parameter and the check against it.
 =

> =

> > @@ -37,12 +100,22 @@ void pm_new_connection(struct mptcp_sock *msk, int=
 server_side)
> >  	pr_debug("msk=3D%p", msk);
> >  =

> >  	msk->pm.server_side =3D server_side;
> > +
> > +	/* trigger announce address in interim local path manager */
> > +	INIT_WORK(&msk->pm.addr_work, announce_addr_worker);
> > +	msk->pm.token =3D msk->token;
> > +	queue_work(mptcp_wq, &msk->pm.addr_work);
> =

> IIRC we not going to support subflow opening from the server towards
> the client - at least initially. Can we restrict announce to server
> side only?

Good point, I'll add this restriction.

> =

> > @@ -126,4 +199,25 @@ int pm_get_local_id(struct request_sock *req, stru=
ct sock *sk,
> >  =

> >  void pm_init(void)
> >  {
> > +	mptcp_wq =3D alloc_workqueue("mptcp_wq", WQ_UNBOUND | WQ_MEM_RECLAIM,=
 8);
> > +	if (!mptcp_wq)
> > +		panic("Failed to allocate workqueue");
> > +}
> > +
> > +static void announce_addr_worker(struct work_struct *work)
> > +{
> > +	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
> > +						addr_work);
> > +	struct in_addr addr;
> > +
> > +	/* @@ hard-code address to announce here... */
> > +	pm_announce_addr(pm->token, AF_INET, 1, &addr);
> > +}
> =

> What about a temporary (to be dropped with a later patch when a saner
> interface will be available) boot parameter/sysctl/other nasty and
> quick hack to select/disable/enable the announce address, so that we
> can start self-testing this code early?

How about once Matthieu's sysctl change is merged I will add such fields (a
value field and a enable/disable field) to the interim path manager patch?
I plan to separate that patch from this patchset so it stands alone as the
"throwaway" patch.

Peter.

> =

> Thanks!
> =

> Paolo
> =



--===============7101800841508379318==--
