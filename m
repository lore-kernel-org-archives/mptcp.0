Content-Type: multipart/mixed; boundary="===============3144841840855112978=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 2/4] mptcp: unify RM_ADDR and
 RM_SUBFLOW receiving
Date: Wed, 03 Mar 2021 11:11:32 +0100
Message-ID: <367d7b1b83b907b5cfc4e4dd8bb63fa5bceabf35.camel@redhat.com>
In-Reply-To: 06d4bf11abca96d8b060d8ffec7923c54ece2654.1614757087.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7991

--===============3144841840855112978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I'm sorry for the late feedback... I have a couple of minor comments,
see below.

On Wed, 2021-03-03 at 15:48 +0800, Geliang Tang wrote:
> There are some duplicate code in mptcp_pm_nl_rm_addr_received and
> mptcp_pm_nl_rm_subflow_received. This patch unifies them into a new
> function named mptcp_pm_nl_rm_addr_or_subflow. In it, use the input
> parameter type to identify it's now removing an address or a subflow.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm_netlink.c | 88 +++++++++++++++++++-----------------------
>  1 file changed, 40 insertions(+), 48 deletions(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 1cad39edde31..419b643bd6fe 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -594,45 +594,75 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock =
*msk,
>  	return -EINVAL;
>  }
>  =

> -static void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
> +enum rm_type {
> +	RM_ADDR,
> +	RM_SUBFLOW,
> +};
> +
> +static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> +					   struct mptcp_rm_list rm_list,

passing a struct by value will cause the whole struct being copied on
the stack at call time, and copied back at return time. That is not
tragic, but likely it would be better use a

'const struct mptcp_rm_list *rm_list'

argument instead. (here and in the callers below).

> +					   enum rm_type type)
>  {
>  	struct mptcp_subflow_context *subflow, *tmp;
>  	struct sock *sk =3D (struct sock *)msk;
>  	u8 i;
>  =

> -	pr_debug("address rm_list_nr %d", msk->pm.rm_list_rx.nr);
> +	pr_debug("%s rm_list_nr %d", type =3D=3D RM_ADDR ? "address" : "subflow=
", rm_list.nr);
>  =

>  	msk_owned_by_me(msk);
>  =

> -	if (!msk->pm.rm_list_rx.nr)
> +	if (!rm_list.nr)
>  		return;
>  =

>  	if (list_empty(&msk->conn_list))
>  		return;
>  =

> -	for (i =3D 0; i < msk->pm.rm_list_rx.nr; i++) {
> +	for (i =3D 0; i < rm_list.nr; i++) {
>  		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
>  			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>  			int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
> +			u8 id =3D subflow->local_id;
> +
> +			if (type =3D=3D RM_ADDR)
> +				id =3D subflow->remote_id;
>  =

> -			if (msk->pm.rm_list_rx.ids[i] !=3D subflow->remote_id)
> +			if (rm_list.ids[i] !=3D id)
>  				continue;
>  =

> -			pr_debug(" -> address rm_list_ids[%d]=3D%u", i, msk->pm.rm_list_rx.id=
s[i]);
> +			pr_debug(" -> %s rm_list_ids[%d]=3D%u local_id=3D%u remote_id=3D%u",
> +				 type =3D=3D RM_ADDR ? "address" : "subflow", i, rm_list.ids[i],
> +				 subflow->local_id, subflow->remote_id);
>  			spin_unlock_bh(&msk->pm.lock);
>  			mptcp_subflow_shutdown(sk, ssk, how);
>  			mptcp_close_ssk(sk, ssk, subflow);
>  			spin_lock_bh(&msk->pm.lock);
>  =

> -			msk->pm.add_addr_accepted--;
> -			msk->pm.subflows--;
> -			WRITE_ONCE(msk->pm.accept_addr, true);
> +			if (type =3D=3D RM_ADDR) {
> +				msk->pm.add_addr_accepted--;
> +				msk->pm.subflows--;

This last statement is present in both 'if' branches, so it could moved
ouside (before) the 'if' itself.

> +				WRITE_ONCE(msk->pm.accept_addr, true);
>  =

> -			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);
> +				__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMADDR);

Not sure if the following is worthy, but if you replace 'enum rm_type'
with 'enum linux_mptcp_mib_field', passing
in MPTCP_MIB_RMSUBFLOW, MPTCP_MIB_RMADDR as possible value, and
updating the 'type =3D=3D ' test accordingly you could move the:

	 __MPTCP_INC_STATS(sock_net(sk), type);

statement outside (before) the 'if'.

/P

--===============3144841840855112978==--
