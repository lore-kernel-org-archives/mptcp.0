Content-Type: multipart/mixed; boundary="===============1355319590537834014=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC] mptcp: Implement interim path manager
Date: Tue, 27 Aug 2019 12:56:24 -0700
Message-ID: <664398745630274fd811f0704d299635002653fa.camel@linux.intel.com>
In-Reply-To: 73e8a5be4a72c404d0d2b956c361f0743594face.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1724

--===============1355319590537834014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo -

On Mon, 2019-08-26 at 17:20 +0200, Paolo Abeni wrote:
> On Wed, 2019-08-07 at 15:54 -0700, Peter Krystad wrote:
> > @@ -91,16 +95,32 @@ int pm_remove_subflow(u32 token, u8 remote_id)
> >  =

> >  void pm_new_connection(struct mptcp_sock *msk, int server_side)
> >  {
> > -	pr_debug("msk=3D%p", msk);
> > +	struct mptcp_pm_data *pm =3D &msk->pm;
> > +
> > +	pr_debug("msk=3D%p, token=3D%u", msk, msk->token);
> >  =

> > -	msk->pm.server_side =3D server_side;
> > +	pm->server_side =3D server_side;
> > +	pm->token =3D msk->token;
> > +
> > +	/* trigger announce address in interim local path manager */
> > +	if (pm->server_side) {
> > +		INIT_WORK(&pm->addr_work, announce_addr_worker);
> > +		queue_work(mptcp_wq, &pm->addr_work);
> =

> I think that here we need to acquire a reference to the related msk
> socket, or we can get use-after-free depending on socket shutdown and
> workqueue scheduling.

Thanks for the review, I'll add this and submit a v2.

Peter.

> Such reference should be releases by the worker itself.
> =

> Other workqueue usage below should need a similar change.
> =

> Cheers,
> =

> Paolo
> =



--===============1355319590537834014==--
