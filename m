Content-Type: multipart/mixed; boundary="===============6310314127746176867=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 8/9] mptcp: remove a list of
 addrs when flushing
Date: Thu, 04 Feb 2021 17:53:35 -0800
Message-ID: <c4fa9252-3d92-18df-53e9-89c9adcaed26@linux.intel.com>
In-Reply-To: 8fa90a27985eac53a009842d2aa922a5ce79e0ad.1612250255.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7629

--===============6310314127746176867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Feb 2021, Geliang Tang wrote:

> This patch invoked mptcp_nl_remove_addrs_and_subflows to remove a list
> of addresses when the netlink flushes addresses, instead of using
> mptcp_nl_remove_subflow_and_signal_addr to remove them one by one.
>
> Since mptcp_nl_remove_subflow_and_signal_addr was dropped from
> __flush_addrs, __flush_addrs could be invoked under the locks. So
> dropped the useless free_list in mptcp_nl_cmd_flush_addrs and the unused
> parameter net in __flush_addrs.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index e942b4ccaa76..6b6dacd0e03a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1287,14 +1287,13 @@ static void mptcp_nl_remove_addrs_and_subflows(st=
ruct net *net, u8 rm_ids[])
> 	}
> }
>
> -static void __flush_addrs(struct net *net, struct list_head *list)
> +static void __flush_addrs(struct list_head *list)
> {
> 	while (!list_empty(list)) {
> 		struct mptcp_pm_addr_entry *cur;
>
> 		cur =3D list_entry(list->next,
> 				 struct mptcp_pm_addr_entry, list);
> -		mptcp_nl_remove_subflow_and_signal_addr(net, &cur->addr);
> 		list_del_rcu(&cur->list);
> 		mptcp_pm_free_addr_entry(cur);
> 	}
> @@ -1311,15 +1310,23 @@ static void __reset_counters(struct pm_nl_pernet =
*pernet)
> static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info=
 *info)
> {
> 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
> -	LIST_HEAD(free_list);
> +	u8 rm_ids[MPTCP_RM_IDS_MAX] =3D { 0 }, i =3D 0;
> +	struct mptcp_pm_addr_entry *entry;
> +
> +	spin_lock_bh(&pernet->lock);
> +	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> +		if (entry->addr.id && i < MPTCP_RM_IDS_MAX)
> +			rm_ids[i++] =3D entry->addr.id;
> +	}
> +	spin_unlock_bh(&pernet->lock);
> +	mptcp_nl_remove_addrs_and_subflows(sock_net(skb->sk), rm_ids);
>
> 	spin_lock_bh(&pernet->lock);
> -	list_splice_init(&pernet->local_addr_list, &free_list);
> +	__flush_addrs(&pernet->local_addr_list);
> 	__reset_counters(pernet);
> 	pernet->next_id =3D 1;
> 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
> 	spin_unlock_bh(&pernet->lock);
> -	__flush_addrs(sock_net(skb->sk), &free_list);

With the pernet lock reacquired so many times, there's a lot of room for =

the local_addr_list to change while the lock is not held. And the pernet =

lock is held for a longer time.

It looks like the main idea is to change from this -

// Old code
for each announced address id:
   for each msk:
     close one subflow matching the announced address id


to this -

// New code
get the list of announced address ids
for each msk:
   send rm_addr with list of subflow ids
   close subflows matching list of subflow ids
free list of address ids directly from pernet


My suggestion is to instead keep mptcp_nl_cmd_flush_addrs() mostly =

unchanged. free_list can then be used for two things at the end of the =

function:

1. It can be passed to a mptcp_nl_* function that will iterate over each =

msk. Use free_list instead of pernet->local_addr_list for each msk to =

build the list of rm_ids, and also to remove the necessary subflows. The =

pernet lock won't be needed.

2. After iterating over all the msks, deallocate the free_list (like your =

modified __flush_addrs() does).


> 	return 0;
> }
>
> @@ -1916,7 +1923,7 @@ static void __net_exit pm_nl_exit_net(struct list_h=
ead *net_list)
> 		/* net is removed from namespace list, can't race with
> 		 * other modifiers
> 		 */
> -		__flush_addrs(net, &pernet->local_addr_list);
> +		__flush_addrs(&pernet->local_addr_list);
> 	}
> }
>
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============6310314127746176867==--
