Content-Type: multipart/mixed; boundary="===============7160735272706695748=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 3/3] mptcp: retransmit
 ADD_ADDR when timeout
Date: Mon, 21 Sep 2020 12:24:36 +0200
Message-ID: <b70fa4b2babfb3753750c89b0f3d0298f3c5e121.camel@redhat.com>
In-Reply-To: 201c99be5aeb750b74a9b2710a5674dc700e6c48.1600672866.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5958

--===============7160735272706695748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the prompt turn-over. There is still a somewhat relevant
item - the last comment in this patch. The others comments are mostly
nit picking, but nice to have.

On Mon, 2020-09-21 at 15:30 +0800, Geliang Tang wrote:
> This patch implemented the retransmition of ADD_ADDR when no ADD_ADDR
> echo
> is received. It added a timer with the announced address. When
> timeout
> occurs, ADD_ADDR will be retransmitted.
> =

> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/options.c    |   1 +
>  net/mptcp/pm_netlink.c | 113 ++++++++++++++++++++++++++++++++++-----
> --
>  net/mptcp/protocol.h   |   3 ++
>  3 files changed, 98 insertions(+), 19 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 171039cbe9c4..14a290fae767 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -893,6 +893,7 @@ void mptcp_incoming_options(struct sock *sk,
> struct sk_buff *skb,
>  			mptcp_pm_add_addr_received(msk, &addr);
>  			MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_ADDADDR);
>  		} else {
> +			mptcp_pm_del_add_timer(msk, &addr);
>  			MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_ECHOADD);
>  		}
>  		mp_opt.add_addr =3D 0;
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 701972b55a45..6fad2cc4cf5d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -31,6 +31,9 @@ struct mptcp_pm_addr_entry {
>  struct mptcp_pm_add_entry {
>  	struct list_head	list;
>  	struct mptcp_addr_info	addr;
> +	struct timer_list	add_timer;
> +	struct mptcp_sock	*sock;
> +	u8			retrans_times;
>  };
>  =

>  struct pm_nl_pernet {
> @@ -46,6 +49,7 @@ struct pm_nl_pernet {
>  };
>  =

>  #define MPTCP_PM_ADDR_MAX	8
> +#define ADD_ADDR_RETRANS_MAX	3
>  =

>  static bool addresses_equal(const struct mptcp_addr_info *a,
>  			    struct mptcp_addr_info *b, bool use_port)
> @@ -183,23 +187,83 @@ static void check_work_pending(struct
> mptcp_sock *msk)
>  		WRITE_ONCE(msk->pm.work_pending, false);
>  }
>  =

> -static bool lookup_anno_list_by_saddr(struct mptcp_sock *msk,
> -				      struct mptcp_addr_info *addr)
> +static struct mptcp_pm_add_entry *
> +lookup_anno_list_by_saddr(struct mptcp_sock *msk,
> +			  struct mptcp_addr_info *addr)
>  {
> -	struct mptcp_pm_add_entry *entry;
> +	struct mptcp_pm_add_entry *entry, *ret =3D NULL;
>  =

>  	list_for_each_entry(entry, &msk->pm.anno_list, list) {
> -		if (addresses_equal(&entry->addr, addr, false))
> -			return true;
> +		if (addresses_equal(&entry->addr, addr, false)) {
> +			ret =3D entry;
> +			break;

Or simply:
			return entry;

No braches, no break, no local variable.
> +		}
>  	}
>  =

> -	return false;
> +	return ret;

[with the above change]
	return NULL;
> +}
> +
> +static void mptcp_pm_add_timer(struct timer_list *timer)
> +{
> +	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer,
> add_timer);
> +	struct mptcp_sock *msk =3D entry->sock;
> +	struct sock *sk =3D (struct sock *)msk;
> +
> +	pr_debug("msk=3D%p", msk);
> +
> +	if (!msk)
> +		return;
> +
> +	if (sk->sk_state =3D=3D TCP_CLOSE)

Since this is a lockless context (sorry for not noticing it before):

	if (inet_sk_state_load(sk))

> +		return;
> +
> +	if (!entry->addr.id)
> +		return;
> +
> +	if (mptcp_pm_should_add_signal(msk)) {
> +		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
> +		goto out;
> +	}
> +
> +	spin_lock_bh(&msk->pm.lock);
> +
> +	if (!mptcp_pm_should_add_signal(msk)) {
> +		pr_debug("retransmit ADD_ADDR id=3D%d", entry->addr.id);
> +		mptcp_pm_announce_addr(msk, &entry->addr, false);
> +		entry->retrans_times++;
> +	}
> +
> +	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
> +		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX);
> +
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +out:
> +	__sock_put(sk);
> +}
> +
> +struct mptcp_pm_add_entry *
> +mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> +		       struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_pm_add_entry *entry;
> +	struct sock *sk =3D (struct sock *)msk;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	entry =3D lookup_anno_list_by_saddr(msk, addr);

here it's additionally needed:

	entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;

to prevent the timer re-scheduling, or bad things could happen!


Cheers,

Paolo

--===============7160735272706695748==--
