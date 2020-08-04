Content-Type: multipart/mixed; boundary="===============8461900161722950196=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 3/4] mptcp: add the incoming
 RM_ADDR support
Date: Tue, 04 Aug 2020 12:44:01 +0200
Message-ID: <911cff69decd339673ab391c56406166e6e6ecf8.camel@redhat.com>
In-Reply-To: 154edfa5d5cef227c6c4a31a2d81e0fd7c5d0f6a.1596534832.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5459

--===============8461900161722950196==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-08-04 at 18:01 +0800, Geliang Tang wrote:
> This patch added the RM_ADDR option parsing logic:
> =

> We parsed the incoming options to find if the rm_addr option is received,
> and called mptcp_pm_rm_addr_received to schedule PM work to a new status,
> named MPTCP_PM_RM_ADDR_RECEIVED.
> =

> PM work got this status, and called mptcp_pm_nl_rm_addr_received to handle
> it.
> =

> In mptcp_pm_nl_rm_addr_received, we closed the subflow matching the rm_id,
> and updated PM counter.
> =

> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/options.c    |  5 +++++
>  net/mptcp/pm.c         | 12 ++++++++++++
>  net/mptcp/pm_netlink.c | 36 +++++++++++++++++++++++++++++++++++-
>  net/mptcp/protocol.c   | 12 ++++++++----
>  net/mptcp/protocol.h   |  7 +++++++
>  net/mptcp/subflow.c    |  1 +
>  6 files changed, 68 insertions(+), 5 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index bbc124876417..a52a05effac9 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -888,6 +888,11 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb,
>  		mp_opt.add_addr =3D 0;
>  	}
>  =

> +	if (mp_opt.rm_addr) {
> +		mptcp_pm_rm_addr_received(msk, mp_opt.rm_id);
> +		mp_opt.rm_addr =3D 0;
> +	}
> +
>  	if (!mp_opt.dss)
>  		return;
>  =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 81b07ae213b9..558462d87eb3 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -149,6 +149,18 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *m=
sk,
>  	spin_unlock_bh(&pm->lock);
>  }
>  =

> +void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
> +{
> +	struct mptcp_pm_data *pm =3D &msk->pm;
> +
> +	pr_debug("msk=3D%p remote_id=3D%d", msk, rm_id);
> +
> +	spin_lock_bh(&pm->lock);
> +	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
> +	pm->rm_id =3D rm_id;
> +	spin_unlock_bh(&pm->lock);
> +}
> +
>  /* path manager helpers */
>  =

>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index c8820c4156e6..7461933fb68b 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -173,7 +173,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
>  {
>  	struct sock *sk =3D (struct sock *)msk;
>  	struct mptcp_pm_addr_entry *local;
> -	struct mptcp_addr_info remote;
> +	struct mptcp_addr_info remote =3D { 0 };
>  	struct pm_nl_pernet *pernet;
>  =

>  	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> @@ -261,6 +261,40 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock=
 *msk)
>  	spin_lock_bh(&msk->pm.lock);
>  }
>  =

> +void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +	struct sock *sk =3D (struct sock *)msk;
> +
> +	pr_debug("rm_id %d", msk->pm.rm_id);
> +
> +	if (!msk->pm.rm_id)
> +		return;
> +
> +	if (list_empty(&msk->conn_list))
> +		return;
> +
> +	msk->pm.add_addr_accepted--;
> +	msk->pm.subflows--;
> +	WRITE_ONCE(msk->pm.accept_addr, true);
> +
> +	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {

I'm sorry, the following feedback was not likely clear enough in the
previous version:

msk->conn_list can be traversed only after acquiring the msk socket
lock. Should be something alike:

	rm_id =3D msk->pm.rm_id;
        spin_unlock_bh(&msk->pm.lock);

	lock_sock(sk);
	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
               struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
               int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
               long timeout =3D 0;

               if (rm_id !=3D subflow->remote_id &&
                   rm_id !=3D subflow->local_id)
                       continue;

               mptcp_subflow_shutdown(sk, ssk, how);
               __mptcp_close_ssk(sk, ssk, subflow, timeout);
               break;
       }
       release_sock(sk);
       spin_lock_bh(&msk->pm.lock);


note that we have to cache id before releasing the pm spin lock, access
to msk->pm.rm_id are not safe after releasing such lock.

/P

--===============8461900161722950196==--
