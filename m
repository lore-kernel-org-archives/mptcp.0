Content-Type: multipart/mixed; boundary="===============2228546270731420729=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/4] mptcp: skip connecting
 the connected address
Date: Tue, 23 Feb 2021 16:57:52 -0800
Message-ID: <51833241-2a45-1664-aee7-b13688e63bd@linux.intel.com>
In-Reply-To: 67cd1eb6fbb530597c4a0cbdd2b8745da0f902a8.1614053997.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7926

--===============2228546270731420729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Feb 2021, Geliang Tang wrote:

> This patch added a new helper named mptcp_lookup_subflow_by_daddr to find
> whether the destination address is in the msk's conn_list.
>
> In mptcp_pm_add_addr_received, use mptcp_lookup_subflow_by_daddr to check
> whether the announced address is already connected. If it is, skip
> connecting this address and send out the echo.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm.c         |  3 ++-
> net/mptcp/pm_netlink.c | 20 +++++++++++++++++++-
> net/mptcp/protocol.h   |  2 ++
> 3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index db2ce84d250a..0d3ea9b45228 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -186,7 +186,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
>
> 	spin_lock_bh(&pm->lock);
>
> -	if (!READ_ONCE(pm->accept_addr)) {
> +	if (!READ_ONCE(pm->accept_addr) ||
> +	    mptcp_lookup_subflow_by_daddr(&msk->conn_list, addr)) {

The msk lock isn't held here, so it's not safe to iterate over conn_list.

I did point to this function as an example of what needs to happen to send =

the echo, but the old location (mptcp_pm_nl_add_addr_received()) is better =

in terms of locking.


Mat

> 		mptcp_pm_announce_addr(msk, addr, true, addr->port);
> 		mptcp_pm_add_addr_send_ack(msk);
> 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 55fdcb1b5281..4412a339e305 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -59,7 +59,7 @@ struct pm_nl_pernet {
> static void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk);
>
> static bool addresses_equal(const struct mptcp_addr_info *a,
> -			    struct mptcp_addr_info *b, bool use_port)
> +			    const struct mptcp_addr_info *b, bool use_port)
> {
> 	bool addr_equals =3D false;
>
> @@ -140,6 +140,24 @@ static bool lookup_subflow_by_saddr(const struct lis=
t_head *list,
> 	return false;
> }
>
> +bool mptcp_lookup_subflow_by_daddr(const struct list_head *list,
> +				   const struct mptcp_addr_info *daddr)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_addr_info cur;
> +	struct sock_common *skc;
> +
> +	list_for_each_entry(subflow, list, node) {
> +		skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
> +
> +		remote_address(skc, &cur);
> +		if (addresses_equal(&cur, daddr, daddr->port))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> static struct mptcp_pm_addr_entry *
> select_local_address(const struct pm_nl_pernet *pernet,
> 		     struct mptcp_sock *msk)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6af3e259fa05..aa44bc28c5a8 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -662,6 +662,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> struct mptcp_pm_add_entry *
> mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
> 				struct mptcp_addr_info *addr);
> +bool mptcp_lookup_subflow_by_daddr(const struct list_head *list,
> +				   const struct mptcp_addr_info *daddr);
>
> int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> 			   const struct mptcp_addr_info *addr,
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============2228546270731420729==--
