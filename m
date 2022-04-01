Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8B7C
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648840417; x=1680376417;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/sz5Z4MoVRtUfQ1DtpAPqMfj8XvW7Mr7bLwtRei4E6M=;
  b=iX3NZmTNstrNvLnW6P511Scr9oDcUp6UhzH0t1KIfZ3y7p1BCDGuZB4L
   adz85X6l+jMl/NqqPb5BUoE8Wh7m08RIN2CPGmGHaLXM94HNW886NDbAi
   1frV9FnC8Lv5XaiqOOT3+UQz+0+BfSAfh1WhyIJg6PFQedOclInmqmItr
   jvb0IBNhbQqTpg7ZBue8Yp3PJ0RK+TwQ6CVyqwNDB8xho0b86OU5khZff
   tLg8lH0KfJfYHKi5XLD/jgmvIaz70ygJe1L3+B68CP7rKIqujDXv/sZxa
   8E6XD4zlz+GRN/qztVfPdsPhfADgDrkTQSW4H+w2A4KINbQAuQz+hgUUS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259041838"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="259041838"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:13:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="567731961"
Received: from nidhikum-mobl.amr.corp.intel.com ([10.209.9.23])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:13:36 -0700
Date: Fri, 1 Apr 2022 12:13:36 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 03/14] mptcp: read attributes of addr
 entries managed by userspace PMs
In-Reply-To: <20220329021437.1196552-4-kishen.maloor@intel.com>
Message-ID: <2ec27254-4b37-e4ed-94c-fbb81af7438f@linux.intel.com>
References: <20220329021437.1196552-1-kishen.maloor@intel.com> <20220329021437.1196552-4-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 28 Mar 2022, Kishen Maloor wrote:

> This change introduces a parallel path in the kernel for retrieving
> the local id, flags, if_index for an addr entry in the context of
> an MPTCP connection that's being managed by a userspace PM. The
> userspace and in-kernel PM modes deviate in their procedures for
> obtaining this information.
>
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> net/mptcp/pm_netlink.c | 95 ++++++++++++++++++++++++++++--------------
> net/mptcp/protocol.h   |  3 +-
> net/mptcp/subflow.c    |  2 +-
> 3 files changed, 67 insertions(+), 33 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 836f6df9f744..a258593f2cb1 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1036,31 +1036,47 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>
> 	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
>
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> -		if (mptcp_addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
> -			ret = entry->addr.id;
> -			break;
> +	if (mptcp_pm_is_kernel(msk)) {
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> +			if (mptcp_addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
> +				ret = entry->addr.id;
> +				break;
> +			}
> 		}
> +		rcu_read_unlock();
> +		if (ret >= 0)
> +			return ret;
> +
> +		/* address not found, add to local list */
> +		entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
> +		if (!entry)
> +			return -ENOMEM;
> +
> +		entry->addr = skc_local;
> +		entry->addr.id = 0;
> +		entry->addr.port = 0;
> +		entry->ifindex = 0;
> +		entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> +		entry->lsk = NULL;
> +		ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
> +		if (ret < 0)
> +			kfree(entry);
> +	} else if (mptcp_pm_is_userspace(msk)) {
> +		struct mptcp_pm_addr_entry new_entry;
> +		__be16 msk_sport =  ((struct inet_sock *)
> +				     inet_sk((struct sock *)msk))->inet_sport;
> +
> +		memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
> +		new_entry.addr = skc_local;
> +		new_entry.addr.id = 0;
> +		new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> +
> +		if (new_entry.addr.port == msk_sport)
> +			new_entry.addr.port = 0;
> +
> +		ret = mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
> 	}
> -	rcu_read_unlock();
> -	if (ret >= 0)
> -		return ret;
> -
> -	/* address not found, add to local list */
> -	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
> -	if (!entry)
> -		return -ENOMEM;
> -
> -	entry->addr = skc_local;
> -	entry->addr.id = 0;
> -	entry->addr.port = 0;
> -	entry->ifindex = 0;
> -	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> -	entry->lsk = NULL;
> -	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
> -	if (ret < 0)
> -		kfree(entry);
>
> 	return ret;
> }
> @@ -1298,22 +1314,39 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
> 	return 0;
> }
>
> -int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
> +int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
> 					 u8 *flags, int *ifindex)
> {
> -	struct mptcp_pm_addr_entry *entry;
> +	struct mptcp_pm_addr_entry *entry, *match = NULL;
> +	struct sock *sk = (struct sock *)msk;
> +	struct net *net = sock_net(sk);
>
> 	*flags = 0;
> 	*ifindex = 0;
>
> 	if (id) {
> -		rcu_read_lock();
> -		entry = __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
> -		if (entry) {
> -			*flags = entry->flags;
> -			*ifindex = entry->ifindex;
> +		if (mptcp_pm_is_kernel(msk)) {
> +			rcu_read_lock();
> +			entry = __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);

Another conflict here due to the "mptcp: add pm_nl_pernet helpers" 
commit, the changes in existing code would be avoided with Paolo's 
suggestion to add a thin layer to call this function (unmodified) or a 
separate version for the userspace PM.

But also be sure to use the new pm_nl_pernet helpers in the new userspace 
PM code.


--
Mat Martineau
Intel
