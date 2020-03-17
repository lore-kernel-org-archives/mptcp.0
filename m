Content-Type: multipart/mixed; boundary="===============3192737280252349505=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 1/3] Squash-to: "mptcp: Implement path manager
 interface commands"
Date: Tue, 17 Mar 2020 14:59:42 -0700
Message-ID: <alpine.OSX.2.22.394.2003171453080.25711@fvaldivi-mobl1.amr.corp.intel.com>
In-Reply-To: 3d1b52f58bd216727592d9758b6a4ed5d828f961.1584370791.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3970

--===============3192737280252349505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Mar 2020, Paolo Abeni wrote:

> currently the PM events are mutually exclusive: the PM will
> e.g. ignore ADD_ADDR till a 'fully_established' event is
> completely processed.
>
> The above can give somewhat randomic self-tests results
> because we sometimes do not start additional subflows
> as expected, because the PM workqueue is still running.
>
> Address the above allowing the PM to process simult the
> currently available different kind of events.
>
> Additionally:
>
> - move the locking from NL PM to the pm_worker(), so that
>  the latter will be simpler
>
> - cancel the eventually pending PM work at socket shutdown
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/pm.c       | 40 ++++++++++++++++++++++++++++++----------
> net/mptcp/protocol.c |  1 +
> net/mptcp/protocol.h |  4 ++--
> 3 files changed, 33 insertions(+), 12 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index a3fe2371d41b..9af0833f1b2c 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -64,18 +64,21 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *ms=
k)
> 	return ret;
> }
>
> +/* return true if the new status bit is currenty cleared, that is, this =
event
> + * can be server, eventually by an already scheduled work
> + */
> static bool mptcp_pm_schedule_work(struct mptcp_sock *msk,
> 				   enum mptcp_pm_status new_status)
> {
> -	if (msk->pm.status !=3D MPTCP_PM_IDLE)
> +	pr_debug("msk=3D%p status=3D%x new=3D%lx", msk, msk->pm.status,
> +		 BIT(new_status));
> +	if (msk->pm.status & BIT(new_status))
> 		return false;
>
> -	if (queue_work(pm_wq, &msk->pm.work)) {
> -		msk->pm.status =3D new_status;
> +	msk->pm.status |=3D BIT(new_status);
> +	if (queue_work(pm_wq, &msk->pm.work))
> 		sock_hold((struct sock *)msk);
> -		return true;
> -	}
> -	return false;
> +	return true;

Does it make sense to skip the queue_work() call if any pm.status bits =

were already set, not just the one matching new_status?


Mat


> }
>
> void mptcp_pm_fully_established(struct mptcp_sock *msk)
> @@ -183,11 +186,22 @@ static void pm_worker(struct work_struct *work)
> 	struct mptcp_sock *msk =3D container_of(pm, struct mptcp_sock, pm);
> 	struct sock *sk =3D (struct sock *)msk;
>
> -	switch (READ_ONCE(pm->status)) {
> -	default:
> -		break;
> +	lock_sock(sk);
> +	spin_lock_bh(&msk->pm.lock);
> +
> +	pr_debug("msk=3D%p status=3D%x", msk, pm->status);
> +	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
> +		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
> +	}
> +	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
> +		pm->status &=3D ~BIT(MPTCP_PM_ESTABLISHED);
> +	}
> +	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
> +		pm->status &=3D ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
> 	}
>
> +	spin_unlock_bh(&msk->pm.lock);
> +	release_sock(sk);
> 	sock_put(sk);
> }
>
> @@ -201,12 +215,18 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
> 	WRITE_ONCE(msk->pm.addr_signal, false);
> 	WRITE_ONCE(msk->pm.accept_addr, false);
> 	WRITE_ONCE(msk->pm.accept_subflow, false);
> -	msk->pm.status =3D MPTCP_PM_IDLE;
> +	msk->pm.status =3D 0;
>
> 	spin_lock_init(&msk->pm.lock);
> 	INIT_WORK(&msk->pm.work, pm_worker);
> }
>
> +void mptcp_pm_close(struct mptcp_sock *msk)
> +{
> +	if (cancel_work_sync(&msk->pm.work))
> +		sock_put((struct sock *)msk);
> +}
> +
> void mptcp_pm_init(void)
> {
> 	pm_wq =3D alloc_workqueue("pm_wq", WQ_UNBOUND | WQ_MEM_RECLAIM, 8);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6d950a46619d..c8501fdff68b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -815,6 +815,7 @@ static void mptcp_close(struct sock *sk, long timeout)
> 	}
>
> 	mptcp_cancel_work(sk);
> +	mptcp_pm_close(msk);
>
> 	__skb_queue_purge(&sk->sk_receive_queue);
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8a42a35ebe8d..9a2f33f7affa 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -102,7 +102,6 @@ struct mptcp_addr_info {
> };
>
> enum mptcp_pm_status {
> -	MPTCP_PM_IDLE,
> 	MPTCP_PM_ADD_ADDR_RECEIVED,
> 	MPTCP_PM_ESTABLISHED,
> 	MPTCP_PM_SUBFLOW_ESTABLISHED,
> @@ -127,7 +126,7 @@ struct mptcp_pm_data {
> 	u8		add_addr_accept_max;
> 	u8		local_addr_max;
> 	u8		subflows_max;
> -	enum mptcp_pm_status status;
> +	u8		status;
>
> 	struct		work_struct work;
> };
> @@ -322,6 +321,7 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 no=
nce1, u32 nonce2,
>
> void mptcp_pm_init(void);
> void mptcp_pm_data_init(struct mptcp_sock *msk);
> +void mptcp_pm_close(struct mptcp_sock *msk);
> void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side);
> void mptcp_pm_fully_established(struct mptcp_sock *msk);
> bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
> -- =

> 2.21.1

--
Mat Martineau
Intel
--===============3192737280252349505==--
