Content-Type: multipart/mixed; boundary="===============5305310510892761576=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use mptcp worker for path
 management
Date: Fri, 19 Jun 2020 16:27:10 +0200
Message-ID: <b512db36ca6823b3108e11073376bcddad4d6648.camel@redhat.com>
In-Reply-To: 20200619115710.2571-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4751

--===============5305310510892761576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-06-19 at 13:57 +0200, Florian Westphal wrote:
> @@ -181,35 +179,6 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, st=
ruct sock_common *skc)
>  	return mptcp_pm_nl_get_local_id(msk, skc);
>  }
>  =

> -static void pm_worker(struct work_struct *work)
> -{
> -	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
> -						work);
> -	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
> -	struct sock *sk =3D (struct sock *)msk;
> -
> -	lock_sock(sk);
> -	spin_lock_bh(&msk->pm.lock);
> -
> -	pr_debug("msk=3D%p status=3D%x", msk, pm->status);
> -	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
> -		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
> -		mptcp_pm_nl_add_addr_received(msk);
> -	}
> -	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
> -		pm->status &=3D ~BIT(MPTCP_PM_ESTABLISHED);
> -		mptcp_pm_nl_fully_established(msk);
> -	}
> -	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
> -		pm->status &=3D ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
> -		mptcp_pm_nl_subflow_established(msk);
> -	}
> -
> -	spin_unlock_bh(&msk->pm.lock);
> -	release_sock(sk);
> -	sock_put(sk);
> -}
> -
>  void mptcp_pm_data_init(struct mptcp_sock *msk)
>  {
>  	msk->pm.add_addr_signaled =3D 0;
> @@ -223,22 +192,11 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>  	msk->pm.status =3D 0;
>  =

>  	spin_lock_init(&msk->pm.lock);
> -	INIT_WORK(&msk->pm.work, pm_worker);
>  =

>  	mptcp_pm_nl_data_init(msk);
>  }
>  =

> -void mptcp_pm_close(struct mptcp_sock *msk)
> -{
> -	if (cancel_work_sync(&msk->pm.work))
> -		sock_put((struct sock *)msk);
> -}
> -
>  void __init mptcp_pm_init(void)
>  {
> -	pm_wq =3D alloc_workqueue("pm_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 8);
> -	if (!pm_wq)
> -		panic("Failed to allocate workqueue");
> -

I'm wondering if we should keep using an MPTCP-specific workqueue.
Server side, we don't expect the work to trigger very often, but should
that ever happen, top will tell easily.

WDYT?

Thanks!

Paolo

--===============5305310510892761576==--
