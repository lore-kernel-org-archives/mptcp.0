Content-Type: multipart/mixed; boundary="===============0532261023033806315=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 3/5] mptcp: deal with
 MPTCP_PM_ADDR_FLAG_BACKUP in PM netlink
Date: Fri, 20 Nov 2020 17:17:15 -0800
Message-ID: <a42e6599-d722-656a-78dd-a2737a9a2913@linux.intel.com>
In-Reply-To: 07602c6f5da430c0adabdd775380572427a16306.1605855783.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6888

--===============0532261023033806315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Nov 2020, Geliang Tang wrote:

> This patch added the MP_PRIO support for PM netlink:
>
> When PM netlink adds an address, check whether the
> MPTCP_PM_ADDR_FLAG_BACKUP flag is set. If it is, check whether this
> address had been added in the local address list. If it had been, then
> call mptcp_nl_addr_backup to deal with this address.
>
> In mptcp_nl_addr_backup, we traverse all the existing msk sockets to find
> the relevant sockets, and get the backup value according to whether the
> MPTCP_PM_ADDR_FLAG_BACKUP flag is set, then call
> mptcp_pm_nl_mp_prio_send_ack to send out a MP_PRIO ACK packet.
>
> In mptcp_pm_nl_mp_prio_send_ack, we set or clear the
> MPTCP_PM_ADDR_FLAG_BACKUP flag.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 41 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index dd48af3c5ed5..58960e1cdc32 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -535,6 +535,11 @@ void mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock =
*msk,
> 			return;
> 		}
>
> +		if (addr->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> +			addr->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
> +		else
> +			addr->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
> +

Why is the backup bit inverted here? It's not clear why it's changed, and =

why bkup is passed in based on the value of the bit when read by the =

calling function.

> 		subflow->backup =3D bkup;
> 		mptcp_schedule_work(sk);
>
> @@ -847,17 +852,53 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct =
genl_info *info)
> 	return net_generic(genl_info_net(info), pm_nl_pernet_id);
> }
>
> +static int mptcp_nl_addr_backup(struct net *net,
> +				struct mptcp_addr_info *addr)
> +{
> +	long s_slot =3D 0, s_num =3D 0;
> +	struct mptcp_sock *msk;
> +
> +	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL)=
 {
> +		u8 bkup =3D !(addr->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> +		struct sock *sk =3D (struct sock *)msk;
> +
> +		if (list_empty(&msk->conn_list))
> +			goto next;
> +
> +		lock_sock(sk);
> +		spin_lock_bh(&msk->pm.lock);
> +		mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
> +		spin_unlock_bh(&msk->pm.lock);
> +		release_sock(sk);
> +
> +next:
> +		sock_put(sk);
> +		cond_resched();
> +	}
> +
> +	return 0;
> +}
> +
> static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *i=
nfo)
> {
> 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> 	struct mptcp_pm_addr_entry addr, *entry;
> +	struct net *net =3D sock_net(skb->sk);
> 	int ret;
>
> 	ret =3D mptcp_pm_parse_addr(attr, info, true, &addr);
> 	if (ret < 0)
> 		return ret;
>
> +	if (addr.addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP) {
> +		list_for_each_entry(entry, &pernet->local_addr_list, list) {
> +			if (addresses_equal(&entry->addr, &addr.addr, false))
> +				mptcp_nl_addr_backup(net, &entry->addr);

I think a more strict match should be required here that includes the =

'id' as well. There may be multiple endpoints with the same address but =

different port numbers.

> +		}
> +		return 0;
> +	}
> +
> 	entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> 	if (!entry) {
> 		GENL_SET_ERR_MSG(info, "can't allocate addr");
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============0532261023033806315==--
