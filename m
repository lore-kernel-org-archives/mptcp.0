Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039762FB7
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 00:43:24 +0000 (UTC)
IronPort-SDR: +HrvosMoYcnSJ84TgaeY7QMtHRsCo6qpisP+Ut15nKGvdAtwLjJ3uj9SWXjyZ2/WqTjkJTqKkf
 n9k0BEKM6HyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="263766417"
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="263766417"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 17:43:16 -0700
IronPort-SDR: jxwR3ZcpbOkSB1xpVJiG79oZHsZ1oz79FuLtNS34nzqKz+BAOc76dNJL3YYBAwrLt/R5UiSPpD
 lxUJ1qW4RjYQ==
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="437435421"
Received: from bsirota-mobl.amr.corp.intel.com ([10.209.18.175])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 17:43:16 -0700
Date: Wed, 12 May 2021 17:43:16 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v5 mptcp-next 3/5] mptcp: add add_list in
 mptcp_pm_data
In-Reply-To: <b2a2ef7d225e72395055f34445968d25939b6b0f.1620469774.git.geliangtang@gmail.com>
Message-ID: <1189682-794-873a-6ebb-9b55cc4cc050@linux.intel.com>
References: <cover.1620469774.git.geliangtang@gmail.com> <0edd6a3ad45c1f67a350356298ed4333fc42dac3.1620469774.git.geliangtang@gmail.com> <04612972cea357bc84aa01e145ac689a8397f466.1620469774.git.geliangtang@gmail.com>
 <b2a2ef7d225e72395055f34445968d25939b6b0f.1620469774.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 8 May 2021, Geliang Tang wrote:

> Like the anno_list member in struct mptcp_pm_data, this patch added a
> new member named add_list in it, to save all the received ADD_ADDRs in
> this add_list.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/pm.c         |  1 +
> net/mptcp/pm_netlink.c | 74 ++++++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.c   |  1 +
> net/mptcp/protocol.h   |  2 ++
> 4 files changed, 78 insertions(+)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9d00fa6d22e9..9456fe17b6a3 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -324,6 +324,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>
> 	spin_lock_init(&msk->pm.lock);
> 	INIT_LIST_HEAD(&msk->pm.anno_list);
> +	INIT_LIST_HEAD(&msk->pm.add_list);
>
> 	mptcp_pm_nl_data_init(msk);
> }
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d094588afad8..47a515af2b0a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -483,6 +483,72 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
> 	mptcp_pm_create_subflow_or_signal_addr(msk);
> }
>
> +struct mptcp_pm_add_entry *
> +mptcp_lookup_add_list_by_id(struct mptcp_sock *msk, u8 id)
> +{
> +	struct mptcp_pm_add_entry *entry;
> +
> +	lockdep_assert_held(&msk->pm.lock);
> +
> +	list_for_each_entry(entry, &msk->pm.add_list, list) {
> +		if (entry->addr.id == id)
> +			return entry;
> +	}
> +
> +	return NULL;
> +}
> +
> +struct mptcp_pm_add_entry *
> +mptcp_lookup_add_list_by_saddr(struct mptcp_sock *msk,
> +			       struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_pm_add_entry *entry;
> +
> +	lockdep_assert_held(&msk->pm.lock);
> +
> +	list_for_each_entry(entry, &msk->pm.add_list, list) {
> +		if (addresses_equal(&entry->addr, addr, true))
> +			return entry;
> +	}
> +
> +	return NULL;
> +}
> +
> +static bool mptcp_pm_alloc_add_list(struct mptcp_sock *msk,
> +				    struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_pm_add_entry *add_entry = NULL;
> +
> +	lockdep_assert_held(&msk->pm.lock);
> +
> +	if (mptcp_lookup_add_list_by_saddr(msk, addr))
> +		return false;
> +
> +	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);

Hi Geliang -

Thanks for adding the list to track addresses announced by the peer. It 
will also be helpful for future in-kernel path manager functionality.

I think it's worthwhile to add a separate struct for this list instead of 
reusing struct mptcp_pm_add_entry. The timer_list is a large number of 
bytes to allocate and not use:

// from pahole

struct mptcp_pm_add_entry {
         struct list_head           list;                 /*     0    16 */
         struct mptcp_addr_info     addr;                 /*    16    24 */
         struct timer_list          add_timer;            /*    40    80 */
         /* --- cacheline 1 boundary (64 bytes) was 56 bytes ago --- */
         struct mptcp_sock *        sock;                 /*   120     8 */
         /* --- cacheline 2 boundary (128 bytes) --- */
         u8                         retrans_times;        /*   128     1 */

         /* size: 136, cachelines: 3, members: 5 */
         /* padding: 7 */
         /* last cacheline: 8 bytes */
};


-Mat


> +	if (!add_entry)
> +		return false;
> +
> +	list_add(&add_entry->list, &msk->pm.add_list);
> +	add_entry->addr = *addr;
> +
> +	return true;
> +}
> +
> +void mptcp_pm_free_add_list(struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_add_entry *entry, *tmp;
> +	LIST_HEAD(free_list);
> +
> +	pr_debug("msk=%p", msk);
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	list_splice_init(&msk->pm.add_list, &free_list);
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	list_for_each_entry_safe(entry, tmp, &free_list, list)
> +		kfree(entry);
> +}
> +
> static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> {
> 	struct sock *sk = (struct sock *)msk;
> @@ -513,6 +579,8 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> 	remote = msk->pm.remote;
> 	if (!remote.port)
> 		remote.port = sk->sk_dport;
> +	if (!mptcp_pm_alloc_add_list(msk, &remote))
> +		return;
> 	memset(&local, 0, sizeof(local));
> 	local.family = remote.family;
>
> @@ -612,6 +680,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> 		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
> +			struct mptcp_pm_add_entry *entry;
> 			u8 id = subflow->local_id;
>
> 			if (rm_type == MPTCP_MIB_RMADDR)
> @@ -631,6 +700,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> 			if (rm_type == MPTCP_MIB_RMADDR) {
> 				msk->pm.add_addr_accepted--;
> 				WRITE_ONCE(msk->pm.accept_addr, true);
> +				entry = mptcp_lookup_add_list_by_id(msk, id);
> +				if (entry) {
> +					list_del(&entry->list);
> +					kfree(entry);
> +				}
> 			} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
> 				msk->pm.local_addr_used--;
> 			}
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 652e55a0c6e8..446076388637 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2882,6 +2882,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
> 	skb_rbtree_purge(&msk->out_of_order_queue);
> 	mptcp_token_destroy(msk);
> 	mptcp_pm_free_anno_list(msk);
> +	mptcp_pm_free_add_list(msk);
> }
>
> static void mptcp_destroy(struct sock *sk)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index fd7ff2d28cb3..d19deee01896 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -185,6 +185,7 @@ struct mptcp_pm_data {
> 	struct mptcp_addr_info local;
> 	struct mptcp_addr_info remote;
> 	struct list_head anno_list;
> +	struct list_head add_list;
>
> 	spinlock_t	lock;		/*protects the whole PM data */
>
> @@ -693,6 +694,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> 				 struct mptcp_addr_info *addr,
> 				 u8 bkup);
> void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> +void mptcp_pm_free_add_list(struct mptcp_sock *msk);
> bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
> struct mptcp_pm_add_entry *
> mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
