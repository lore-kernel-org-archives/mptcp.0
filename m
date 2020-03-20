Content-Type: multipart/mixed; boundary="===============3692604155592128212=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squash-to: mptcp: Add path manager interface
Date: Fri, 20 Mar 2020 02:01:09 +0100
Message-ID: <f44a47eaa3bb3f5bb222201201406ae1d9b86268.camel@redhat.com>
In-Reply-To: 20200320004122.91365-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4013

--===============3692604155592128212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-19 at 17:41 -0700, Mat Martineau wrote:
> Move some minor changes from "mptcp: Implement path manager interface
> commands" to reduce churn within the patch set. Does not cause conflicts
> later in the series.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  net/mptcp/pm.c       | 2 +-
>  net/mptcp/protocol.h | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index f17db5517544..ad837da0193d 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -99,7 +99,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>  	WRITE_ONCE(msk->pm.addr_signal, false);
>  	WRITE_ONCE(msk->pm.accept_addr, false);
>  	WRITE_ONCE(msk->pm.accept_subflow, false);
> -	msk->pm.status =3D MPTCP_PM_IDLE;
> +	msk->pm.status =3D 0;
>  =

>  	spin_lock_init(&msk->pm.lock);
>  	INIT_WORK(&msk->pm.work, pm_worker);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 9f9e397eee1e..8d4761ae3951 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -99,7 +99,6 @@ struct mptcp_addr_info {
>  };
>  =

>  enum mptcp_pm_status {
> -	MPTCP_PM_IDLE,
>  	MPTCP_PM_ADD_ADDR_RECEIVED,
>  	MPTCP_PM_ESTABLISHED,
>  	MPTCP_PM_SUBFLOW_ESTABLISHED,
> @@ -124,7 +123,7 @@ struct mptcp_pm_data {
>  	u8		add_addr_accept_max;
>  	u8		local_addr_max;
>  	u8		subflows_max;
> -	enum mptcp_pm_status status;
> +	u8		status;
>  =

>  	struct		work_struct work;
>  };

LGTM, thanks!

(My intention was to squash changes this way when I posted the patches,
but I was likely too low on coffee :)

/P

--===============3692604155592128212==--
