Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCB470
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 22:50:09 +0000 (UTC)
IronPort-SDR: VqTsqiUnAJ6zgdTBAgL9jbK2ZPRHBPEYLVjk9Cdl/sb0Hn+goXUMs//jUjJBISup50UcNs7Tn4
 4jLiSy4KJ/aw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="262577965"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262577965"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 15:50:08 -0700
IronPort-SDR: urG9MI8iV0vniG7mQOL9SFwkvzfegzL59nUWyBZK+2EniCqTIfYQ0N93Il1IfNWAfv4IRFiwjc
 ZF88rws+J4MA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="631577909"
Received: from srfejes-mobl4.amr.corp.intel.com ([10.209.82.208])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 15:50:08 -0700
Date: Thu, 20 May 2021 15:50:07 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 4/6] mptcp: add add_list in
 mptcp_pm_data
In-Reply-To: <850406b0f49fa0a76b4825b36c55426a0d033d52.1621002341.git.geliangtang@gmail.com>
Message-ID: <5780c0a9-add7-5f1f-3aa2-66ec280fca1@linux.intel.com>
References: <cover.1621002341.git.geliangtang@gmail.com> <d051657e9c51ccb27b32d443777896c6ae519444.1621002341.git.geliangtang@gmail.com> <2a6a925510a7d79f0c2101d5d353f6b74f0e69bb.1621002341.git.geliangtang@gmail.com>
 <ae0d32922128771f09b230e5718774472a088207.1621002341.git.geliangtang@gmail.com> <850406b0f49fa0a76b4825b36c55426a0d033d52.1621002341.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 14 May 2021, Geliang Tang wrote:

> Like the anno_list member in struct mptcp_pm_data, this patch added a
> new member named add_list in it, to save all the received ADD_ADDRs in
> this add_list.

Hi Geliang -

How to handle MP_JOIN with 'C==1' connections was a topic in today's 
community meeting, and Paolo made a strong case that reception of 
ADD_ADDRs from a peer should not be tracked in a linked list (to avoid 
resource issues in servers with lots of connections).

My concern is that preventing any call to __mptcp_subflow_connect() from 
mptcp_pm_create_subflow_or_signal_addr() when the peer sent C==1, would be 
a confusing/unexpected silent failure to establish subflows.


For v7, could you:

1. Drop patches 3/6 & 4/6

2. Track the most recent received ADD_ADDR information in new struct 
members of mptcp_pm_data (also, be sure to invalidate if a matching 
REMOVE_ADDR is received).

3. If C==1 was received, used the stored ADD_ADDR address for the remote 
address in mptcp_pm_create_subflow_or_signal_addr(). If C==1 and there is 
no stored address, skip subflow creation. If C==0 was received, keep 
existing behavior.


I've captured what I recall from the discussion - if anyone has 
corrections, clarifications, or a better proposal, please follow up!


-Mat


>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/pm.c         |  1 +
> net/mptcp/pm_netlink.c | 89 +++++++++++++++++++++++++++++++++++++++---
> net/mptcp/protocol.c   |  1 +
> net/mptcp/protocol.h   |  2 +
> 4 files changed, 87 insertions(+), 6 deletions(-)
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
> index 4fff8aef45e4..3fcc167ea702 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -39,6 +39,11 @@ struct mptcp_pm_anno_entry {
> 	u8			retrans_times;
> };
>
> +struct mptcp_pm_add_entry {
> +	struct list_head	list;
> +	struct mptcp_addr_info	addr;
> +};
> +
> #define MAX_ADDR_ID		255
> #define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, BITS_PER_LONG)
>
> @@ -483,6 +488,69 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
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
> +
> +	pr_debug("msk=%p", msk);
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	list_for_each_entry_safe(entry, tmp, &msk->pm.add_list, list)
> +		kfree(entry);
> +	spin_unlock_bh(&msk->pm.lock);
> +}
> +
> static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> {
> 	struct sock *sk = (struct sock *)msk;
> @@ -501,12 +569,6 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> 	if (lookup_subflow_by_daddr(&msk->conn_list, &msk->pm.remote))
> 		goto add_addr_echo;
>
> -	msk->pm.add_addr_accepted++;
> -	msk->pm.subflows++;
> -	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
> -	    msk->pm.subflows >= subflows_max)
> -		WRITE_ONCE(msk->pm.accept_addr, false);
> -
> 	/* connect to the specified remote address, using whatever
> 	 * local address the routing configuration will pick.
> 	 */
> @@ -516,6 +578,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> 	memset(&local, 0, sizeof(local));
> 	local.family = remote.family;
>
> +	if (!mptcp_pm_alloc_add_list(msk, &remote))
> +		return;
> +
> +	msk->pm.add_addr_accepted++;
> +	msk->pm.subflows++;
> +	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
> +	    msk->pm.subflows >= subflows_max)
> +		WRITE_ONCE(msk->pm.accept_addr, false);
> +
> 	spin_unlock_bh(&msk->pm.lock);
> 	__mptcp_subflow_connect(sk, &local, &remote, 0, 0);
> 	spin_lock_bh(&msk->pm.lock);
> @@ -612,6 +683,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> 		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
> +			struct mptcp_pm_add_entry *entry;
> 			u8 id = subflow->local_id;
>
> 			if (rm_type == MPTCP_MIB_RMADDR)
> @@ -631,6 +703,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
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
> index 35c0b1ca95c3..05ceba3972f6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2888,6 +2888,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
> 	skb_rbtree_purge(&msk->out_of_order_queue);
> 	mptcp_token_destroy(msk);
> 	mptcp_pm_free_anno_list(msk);
> +	mptcp_pm_free_add_list(msk);
> }
>
> static void mptcp_destroy(struct sock *sk)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 5ccc0d3e5693..1df8da3da695 100644
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
> struct mptcp_pm_anno_entry *
> mptcp_pm_del_anno_timer(struct mptcp_sock *msk,
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
