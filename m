Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7529CA
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 22:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641940758; x=1673476758;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VmW7+vNkYW4vFXAGrAe38bbV4LjZ71mw+311BG6WMuY=;
  b=CYt76Hr5tBa5j4AwhBiTgSsINvwPw3Xr+1z9AdjrzzNS6EkhXKG+4c3/
   NMbqSlX5l0V/p3hmkLDV82ftLWChUrlA03wr6b4FL+lAI8S9+0Vf5/f1W
   6E53IOQE1cD16S3thA/pocIkJr/Rdx+s0sgO6f3SPb88S9jRt0QtW7LIP
   lO6oH43/nbCs/WqfCGAc6nMMuSOK9+dFdCIa53jHl9Xi9DgmYOpOcvgfK
   XE3UMpSBXRKAyQvWQqZWjecKEVrbYX0hYTU5bctxn/1ry9/rWEZ6lZjwI
   cmpxfWS90wSv4kvg9H5GqHW9qXIPKO68Vm2WLudrPeMFT7bIB+Cu0sAt2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="306951270"
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="306951270"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 14:39:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="623224123"
Received: from tcastee-mobl.amr.corp.intel.com ([10.209.73.84])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 14:39:17 -0800
Date: Tue, 11 Jan 2022 14:39:17 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix msk traversal in
 mptcp_nl_cmd_set_flags()
In-Reply-To: <a73b5ff4e26150d7db36a639ab671cb66c566e20.1641902813.git.pabeni@redhat.com>
Message-ID: <9cf63ac2-fe98-e2a9-8285-64188115ae4@linux.intel.com>
References: <a73b5ff4e26150d7db36a639ab671cb66c566e20.1641902813.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 11 Jan 2022, Paolo Abeni wrote:

> The MPTCP endpoint list is under RCU protection, guarded by the
> pernet spinlock. mptcp_nl_cmd_set_flags() traverses the list
> without acquiring the spin-lock nor under the RCU critical section.
>
> This change addresses the issue performing the lookup and the endpoint
> update under the pernet spinlock.
>
> Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Looks good to me. There's a slight change to the number of loop iterations 
since the new code only walks through the local_addr_list until the first 
match is found - but there aren't supposed to be duplicates in the list so 
this should be an optimization.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/pm_netlink.c | 37 +++++++++++++++++++++++++++----------
> 1 file changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index f12effa71942..20b9037c4906 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -478,6 +478,20 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
> 	return NULL;
> }
>
> +static struct mptcp_pm_addr_entry *
> +__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
> +	      bool lookup_by_id)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +
> +	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> +		if ((!lookup_by_id && addresses_equal(&entry->addr, info, true)) ||
> +		    (lookup_by_id && entry->addr.id == info->id))
> +			return entry;
> +	}
> +	return NULL;
> +}
> +
> static int
> lookup_id_by_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *addr)
> {
> @@ -1757,18 +1771,21 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
> 			return -EOPNOTSUPP;
> 	}
>
> -	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> -		if ((!lookup_by_id && addresses_equal(&entry->addr, &addr.addr, true)) ||
> -		    (lookup_by_id && entry->addr.id == addr.addr.id)) {
> -			mptcp_nl_addr_backup(net, &entry->addr, bkup);
> -
> -			if (bkup)
> -				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> -			else
> -				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
> -		}
> +	spin_lock_bh(&pernet->lock);
> +	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
> +	if (!entry) {
> +		spin_unlock_bh(&pernet->lock);
> +		return -EINVAL;
> 	}
>
> +	if (bkup)
> +		entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> +	else
> +		entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
> +	addr = *entry;
> +	spin_unlock_bh(&pernet->lock);
> +
> +	mptcp_nl_addr_backup(net, &addr.addr, bkup);
> 	return 0;
> }
>
> -- 
> 2.33.1
>
>
>

--
Mat Martineau
Intel
