Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277370
	for <mptcp@lists.linux.dev>; Fri, 30 Jul 2021 18:14:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="298733569"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="298733569"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 11:14:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="457239294"
Received: from jamiso1x-mobl1.amr.corp.intel.com ([10.212.135.164])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 11:14:37 -0700
Date: Fri, 30 Jul 2021 11:14:37 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [MPTCP][PATCH v4 mptcp-next] Squash to "mptcp: drop flags and
 ifindex arguments"
In-Reply-To: <7353b0ca7f73188dbbb24b9e1fcb0fd4620a8d25.1627559076.git.geliangtang@xiaomi.com>
Message-ID: <ca6c9e81-d273-207e-9449-b34ef6a8db39@linux.intel.com>
References: <7353b0ca7f73188dbbb24b9e1fcb0fd4620a8d25.1627559076.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 29 Jul 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> Fix rcu section and add the non-zero id check.
>

Looks good to squash, thanks.

-Mat


> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
> net/mptcp/pm_netlink.c | 21 +++++++++++----------
> 1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 94c68d6093de..47200ae451b9 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1107,16 +1107,17 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int id,
> {
> 	struct mptcp_pm_addr_entry *entry;
>
> -	rcu_read_lock();
> -	entry = __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
> -	rcu_read_unlock();
> -
> -	if (entry) {
> -		*flags = entry->flags;
> -		*ifindex = entry->ifindex;
> -	} else {
> -		*flags = 0;
> -		*ifindex = 0;
> +	*flags = 0;
> +	*ifindex = 0;
> +
> +	if (id) {
> +		rcu_read_lock();
> +		entry = __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
> +		if (entry) {
> +			*flags = entry->flags;
> +			*ifindex = entry->ifindex;
> +		}
> +		rcu_read_unlock();
> 	}
>
> 	return 0;
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
