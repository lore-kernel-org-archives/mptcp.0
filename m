Content-Type: multipart/mixed; boundary="===============6997492119561734354=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: retransmit ADD_ADDR when
 timeout
Date: Wed, 16 Sep 2020 11:42:03 +0200
Message-ID: <383d605b74c7e87276c27c58824c89d6731287d6.camel@redhat.com>
In-Reply-To: d1a8db14df26e17744c94809cc353dbdc7953896.1599652267.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5894

--===============6997492119561734354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

reviewing even the old v1, as per discussion on the later v2.

On Wed, 2020-09-09 at 19:53 +0800, Geliang Tang wrote:
> This patch implemented the retransmition of ADD_ADDR when no ADD_ADDR echo
> is received. It added a timer with the announced address. When timeout
> occurs, ADD_ADDR will be retransmitted.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/options.c    |  1 +
>  net/mptcp/pm_netlink.c | 71 +++++++++++++++++++++++++++++++++++++-----
>  net/mptcp/protocol.h   |  1 +
>  3 files changed, 66 insertions(+), 7 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 171039cbe9c4..8445d292776b 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -893,6 +893,7 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
>  			mptcp_pm_add_addr_received(msk, &addr);
>  			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
>  		} else {
> +			mptcp_pm_del_add_addr_timer(msk, &addr);
>  			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
>  		}
>  		mp_opt.add_addr =3D 0;
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 6bd5fe9ec086..d2303a3e356d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -28,6 +28,14 @@ struct mptcp_pm_addr_entry {
>  	struct rcu_head		rcu;
>  };
>  =

> +struct mptcp_pm_add_addr_entry {
> +	struct list_head	list;
> +	struct mptcp_addr_info	addr;
> +	struct timer_list	add_addr_timer;
> +	struct mptcp_sock	*sock;
> +	u8			add_addr_retrans_times;
> +};
> +
>  struct pm_nl_pernet {
>  	/* protects pernet updates */
>  	spinlock_t		lock;
> @@ -41,6 +49,7 @@ struct pm_nl_pernet {
>  };
>  =

>  #define MPTCP_PM_ADDR_MAX	8
> +#define ADD_ADDR_RETRANS_MAX	3
>  =

>  static bool addresses_equal(const struct mptcp_addr_info *a,
>  			    struct mptcp_addr_info *b, bool use_port)
> @@ -178,10 +187,50 @@ static void check_work_pending(struct mptcp_sock *m=
sk)
>  		WRITE_ONCE(msk->pm.work_pending, false);
>  }
>  =

> +static void mptcp_pm_add_addr_timer(struct timer_list *timer)
> +{
> +	struct mptcp_pm_add_addr_entry *entry =3D from_timer(entry, timer, add_=
addr_timer);
> +	struct mptcp_sock *msk =3D entry->sock;
> +	struct sock *sk =3D (struct sock *)msk;
> +
> +	pr_debug("msk=3D%p\n", msk);
> +
> +	if (!msk)
> +		return;
> +
> +	bh_lock_sock(sk);
> +	spin_lock_bh(&msk->pm.lock);

Calling 'bh_lock_sock(sk);' does not protect vs concurrent socket level
modification, as some other thread could have acquired the msk socket
lock. See e.g. tcp_write_timer().

Anyway I think here only 'spin_lock_bh(&msk->pm.lock);' is required, as
the following code only touches PM-related data. I think you can simply
drop the bh_lock_sock().

> +
> +	__sock_put(sk);

This should be called after accessing the entry and/or the socket, or a
comment should be added explaining why is safe. The easir/safer thing
is just moving the put call at the end of the function ;)

Otherwise looks good to me!

Cheers,

Paolo

--===============6997492119561734354==--
