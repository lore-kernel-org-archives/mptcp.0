Content-Type: multipart/mixed; boundary="===============5648192652669538997=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 1/4] mptcp: move to next addr
 when subflow creation fail
Date: Tue, 09 Feb 2021 14:51:43 -0800
Message-ID: <aefb8d4d-3b51-e329-73ac-d1f1aa3b92c9@linux.intel.com>
In-Reply-To: 727f616706d0c2e06c020a39096ef958ababa73c.1612882099.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7726

--===============5648192652669538997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Feb 2021, Geliang Tang wrote:

> When an invalid address was announced, the subflow couldn't be created
> for this address. Therefore mptcp_pm_nl_subflow_established couldn't be
> invoked. Then the next addresses in the local address list didn't have a
> chance to be announced.
>
> This patch invokes the new function mptcp_pm_add_addr_echoed when the
> address is echoed. In it, use lookup_subflow_by_saddr to check whether
> this address is in the conn_list. If it isn't, PM schedules the status
> MPTCP_PM_ESTABLISHED to invoke mptcp_pm_create_subflow_or_signal_addr
> to deal with the next address in the local address list.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/options.c    |  1 +
> net/mptcp/pm.c         | 18 ++++++++++++++++++
> net/mptcp/pm_netlink.c |  4 ++--
> net/mptcp/protocol.h   |  3 +++
> 4 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index b63574d6b812..41bcfcc3afe2 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1022,6 +1022,7 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb)
> 			mptcp_pm_add_addr_received(msk, &addr);
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
> 		} else {
> +			mptcp_pm_add_addr_echoed(msk, &addr);
> 			mptcp_pm_del_add_timer(msk, &addr);
> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
> 		}
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6fd4b2c1b076..280cc7758f31 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -197,6 +197,24 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *m=
sk,
> 	spin_unlock_bh(&pm->lock);
> }
>
> +void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk, struct mptcp_addr_=
info *addr)
> +{
> +	struct sock *sk =3D (struct sock *)msk;
> +	struct mptcp_pm_data *pm =3D &msk->pm;
> +
> +	pr_debug("msk=3D%p", msk);
> +
> +	spin_lock_bh(&pm->lock);
> +
> +	bh_lock_sock(sk);

Adding the msk lock is more complex than this, because acquiring the msk =

lock while a subflow lock is held risks deadlock - and the subflow lock is =

already held here. This is why we need the deferred events or workqueue =

for things like retransmit.

Is the conn_list / join_list check really needed? Would it work to check =

against the anno_list to validate that that the echo matches an ADD_ADDR =

that was sent, before scheduling the worker? The path manager on the peer =

doesn't have to immediately connect when it receives an ADD_ADDR - it =

doesn't seem to make sense to wait for a connection except as a way to =

deal with a peer that doesn't send ADD_ADDR echoes (or if there are lost =

echoes).

Mat


> +	__mptcp_flush_join_list(msk);
> +	if (!lookup_subflow_by_saddr(&msk->conn_list, addr))
> +		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
> +	bh_unlock_sock(sk);
> +
> +	spin_unlock_bh(&pm->lock);
> +}
> +
> void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
> {
> 	if (!mptcp_pm_should_add_signal(msk))
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 8e8e35fa4002..97adae0c3b0e 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -122,8 +122,8 @@ static void remote_address(const struct sock_common *=
skc,
> #endif
> }
>
> -static bool lookup_subflow_by_saddr(const struct list_head *list,
> -				    struct mptcp_addr_info *saddr)
> +bool lookup_subflow_by_saddr(const struct list_head *list,
> +			     struct mptcp_addr_info *saddr)
> {
> 	struct mptcp_subflow_context *subflow;
> 	struct mptcp_addr_info cur;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 91827d949766..192dd30a85fe 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -651,6 +651,9 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bk=
up);
> int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> 				 struct mptcp_addr_info *addr,
> 				 u8 bkup);
> +void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk, struct mptcp_addr_=
info *addr);
> +bool lookup_subflow_by_saddr(const struct list_head *list,
> +			     struct mptcp_addr_info *saddr);
> void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct soc=
k *sk);
> struct mptcp_pm_add_entry *
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============5648192652669538997==--
