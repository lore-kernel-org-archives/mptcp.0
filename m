Content-Type: multipart/mixed; boundary="===============8115938596838839219=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 1/2] mptcp: move to next addr
 when subflow creation fail
Date: Thu, 18 Feb 2021 17:49:49 -0800
Message-ID: <7e2fc81-1c7c-d437-9e3-2fef4b182f2@linux.intel.com>
In-Reply-To: 6c7bfe691300545ab0b1d1cda2782f8b330a1d82.1613635984.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7853

--===============8115938596838839219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Feb 2021, Geliang Tang wrote:

> When an invalid address was announced, the subflow couldn't be created
> for this address. Therefore mptcp_pm_nl_subflow_established couldn't be
> invoked. Then the next addresses in the local address list didn't have a
> chance to be announced.
>
> This patch invokes the new function mptcp_pm_add_addr_echoed when the
> address is echoed. In it, use lookup_anno_list_by_saddr to check whether
> this address is in the anno_list. If it is, PM schedules the status
> MPTCP_PM_SUBFLOW_ESTABLISHED to invoke mptcp_pm_create_subflow_or_signal
> _addr to deal with the next address in the local address list.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/options.c    |  1 +
> net/mptcp/pm.c         | 15 +++++++++++++++
> net/mptcp/pm_netlink.c |  2 +-
> net/mptcp/protocol.h   |  5 +++++
> 4 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index b252aadad3fc..e3ba04044561 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1036,6 +1036,7 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb)
> 			mptcp_pm_add_addr_received(msk, &addr);
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
> 		} else {
> +			mptcp_pm_add_addr_echoed(msk, &addr);
> 			mptcp_pm_del_add_timer(msk, &addr);
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
> 		}
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index b559e06757f7..53c1e03b36a3 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -196,6 +196,21 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *m=
sk,
> 	spin_unlock_bh(&pm->lock);
> }
>
> +void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
> +			      struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_pm_data *pm =3D &msk->pm;
> +
> +	pr_debug("msk=3D%p", msk);
> +
> +	spin_lock_bh(&pm->lock);
> +
> +	if (lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
> +		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
> +
> +	spin_unlock_bh(&pm->lock);
> +}
> +
> void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
> {
> 	if (!mptcp_pm_should_add_signal(msk))
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 59ea64e5e914..c556a353eee0 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -245,7 +245,7 @@ static void check_work_pending(struct mptcp_sock *msk)
> 		WRITE_ONCE(msk->pm.work_pending, false);
> }
>
> -static struct mptcp_pm_add_entry *
> +struct mptcp_pm_add_entry *
> lookup_anno_list_by_saddr(struct mptcp_sock *msk,
> 			  struct mptcp_addr_info *addr)
> {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b92bb3972cb7..bd8f7fb731b4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -646,6 +646,8 @@ void mptcp_pm_subflow_established(struct mptcp_sock *=
msk);
> void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
> void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> 				const struct mptcp_addr_info *addr);
> +void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
> +			      struct mptcp_addr_info *addr);
> void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
> void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, struct mptcp_rm_li=
st rm_list);
> void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
> @@ -657,6 +659,9 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *m=
sk, const struct sock *sk);
> struct mptcp_pm_add_entry *
> mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> 		       struct mptcp_addr_info *addr);
> +struct mptcp_pm_add_entry *
> +lookup_anno_list_by_saddr(struct mptcp_sock *msk,
> +			  struct mptcp_addr_info *addr);

Since this symbol is no longer static, it needs to be renamed to =

mptcp_lookup_anno_list_by_saddr().

The rest of the patch looks ok. Thanks!

>
> int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> 			   const struct mptcp_addr_info *addr,
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============8115938596838839219==--
