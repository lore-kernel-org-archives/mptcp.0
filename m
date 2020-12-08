Content-Type: multipart/mixed; boundary="===============4887861681188807812=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/2] mptcp: add the address
 ID assignment bitmap
Date: Mon, 07 Dec 2020 17:24:03 -0800
Message-ID: <be294d1-8267-6a94-729b-332db383eb4f@linux.intel.com>
In-Reply-To: 0ba36019c2f3679be412fba62830237c2a40fa66.1607174930.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7066

--===============4887861681188807812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Dec 2020, Geliang Tang wrote:

> Currently the address ID set by the netlink PM from user-space is
> overridden by the kernel. This patch added the address ID assignment
> bitmap to allow user-space to set the address ID.
>
> Use a per netns bitmask id_bitmap (256 bits) to keep track of in-use IDs.
> And use next_id to keep track of the highest ID currently in use. If the
> user-space provides an ID at endpoint creation time, try to use it. If
> already in use, endpoint creation fails. Otherwise pick the first ID
> available after the highest currently in use, with wrap-around.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 60 +++++++++++++++++++++++++++++-------------
> 1 file changed, 42 insertions(+), 18 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index a6d983d80576..54db51f4b3cb 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -36,6 +36,9 @@ struct mptcp_pm_add_entry {
> 	u8			retrans_times;
> };
>
> +#define MAX_ADDR_ID		255
> +#define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, BITS_PER_LONG)
> +
> struct pm_nl_pernet {
> 	/* protects pernet updates */
> 	spinlock_t		lock;
> @@ -46,6 +49,7 @@ struct pm_nl_pernet {
> 	unsigned int		local_addr_max;
> 	unsigned int		subflows_max;
> 	unsigned int		next_id;
> +	unsigned long		id_bitmap[BITMAP_SZ];
> };
>
> #define MPTCP_PM_ADDR_MAX	8
> @@ -524,10 +528,12 @@ static int mptcp_pm_nl_append_new_local_addr(struct=
 pm_nl_pernet *pernet,
> 	/* to keep the code simple, don't do IDR-like allocation for address ID,
> 	 * just bail when we exceed limits
> 	 */
> -	if (pernet->next_id > 255)
> -		goto out;
> +	if (pernet->next_id =3D=3D MAX_ADDR_ID)
> +		pernet->next_id =3D 1;
> 	if (pernet->addrs >=3D MPTCP_PM_ADDR_MAX)
> 		goto out;
> +	if (test_bit(entry->addr.id, pernet->id_bitmap))
> +		goto out;
>
> 	/* do not insert duplicate address, differentiate on port only
> 	 * singled addresses
> @@ -544,7 +550,14 @@ static int mptcp_pm_nl_append_new_local_addr(struct =
pm_nl_pernet *pernet,
> 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
> 		pernet->local_addr_max++;
>
> -	entry->addr.id =3D pernet->next_id++;
> +	if (!entry->addr.id) {
> +		entry->addr.id =3D find_next_zero_bit(pernet->id_bitmap,
> +						    MAX_ADDR_ID + 1,
> +						    pernet->next_id);
> +	}

find_next_zero_bit() will return MAX_ADDR_ID + 1 if it can't find a zero =

bit in the specified range. When pernet->next_id is a large value this =

could easily happen. In that case, need to call find_next_zero_bit() again =

to make the search wrap around to the lower bits and ensure that =

entry->addr.id is valid before calling __set_bit().


> +	__set_bit(entry->addr.id, pernet->id_bitmap);
> +	if (entry->addr.id > pernet->next_id)
> +		pernet->next_id =3D entry->addr.id;
> 	pernet->addrs++;
> 	list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
> 	ret =3D entry->addr.id;
> @@ -857,6 +870,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb,=
 struct genl_info *info)
>
> 	pernet->addrs--;
> 	list_del_rcu(&entry->list);
> +	__clear_bit(entry->addr.id, pernet->id_bitmap);
> 	spin_unlock_bh(&pernet->lock);
>
> 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
> @@ -894,6 +908,8 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff *s=
kb, struct genl_info *info)
> 	spin_lock_bh(&pernet->lock);
> 	list_splice_init(&pernet->local_addr_list, &free_list);
> 	__reset_counters(pernet);
> +	pernet->next_id =3D 1;
> +	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
> 	spin_unlock_bh(&pernet->lock);
> 	__flush_addrs(sock_net(skb->sk), &free_list);
> 	return 0;
> @@ -994,27 +1010,34 @@ static int mptcp_nl_cmd_dump_addrs(struct sk_buff =
*msg,
> 	struct pm_nl_pernet *pernet;
> 	int id =3D cb->args[0];
> 	void *hdr;
> +	int i;
>
> 	pernet =3D net_generic(net, pm_nl_pernet_id);
>
> 	spin_lock_bh(&pernet->lock);
> -	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> -		if (entry->addr.id <=3D id)
> -			continue;
> -
> -		hdr =3D genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
> -				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
> -				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
> -		if (!hdr)
> -			break;
> +	for (i =3D 0; i < MAX_ADDR_ID + 1; i++) {

If this was "for (i =3D id; ..." instead, it would skip a lot of unnecessar=
y =

calls to __lookup_addr_by_id().

Either that, or maintain local_addr_list in sorted order and keep the old =

dump code.

Mat


> +		if (test_bit(i, pernet->id_bitmap)) {
> +			entry =3D __lookup_addr_by_id(pernet, i);
> +			if (!entry)
> +				break;
> +
> +			if (entry->addr.id <=3D id)
> +				continue;
> +
> +			hdr =3D genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
> +					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
> +					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
> +			if (!hdr)
> +				break;
> +
> +			if (mptcp_nl_fill_addr(msg, entry) < 0) {
> +				genlmsg_cancel(msg, hdr);
> +				break;
> +			}
>
> -		if (mptcp_nl_fill_addr(msg, entry) < 0) {
> -			genlmsg_cancel(msg, hdr);
> -			break;
> +			id =3D entry->addr.id;
> +			genlmsg_end(msg, hdr);
> 		}
> -
> -		id =3D entry->addr.id;
> -		genlmsg_end(msg, hdr);
> 	}
> 	spin_unlock_bh(&pernet->lock);
>
> @@ -1148,6 +1171,7 @@ static int __net_init pm_nl_init_net(struct net *ne=
t)
> 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
> 	__reset_counters(pernet);
> 	pernet->next_id =3D 1;
> +	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
> 	spin_lock_init(&pernet->lock);
> 	return 0;
> }
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============4887861681188807812==--
