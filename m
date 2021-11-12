Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027E72
	for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 00:09:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="256757488"
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="256757488"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 16:09:17 -0800
X-IronPort-AV: E=Sophos;i="5.87,227,1631602800"; 
   d="scan'208";a="643277229"
Received: from neelchat-mobl2.amr.corp.intel.com ([10.209.109.125])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 16:09:13 -0800
Date: Thu, 11 Nov 2021 16:09:13 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Davide Caratti <dcaratti@redhat.com>
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: allow changing the "backup" bit by
 endpoint id
In-Reply-To: <434d58757c972252e5af7ac2574c3791a9778441.1636628783.git.dcaratti@redhat.com>
Message-ID: <f468c1e1-ec26-763a-bc3-0b080b7a9db@linux.intel.com>
References: <434d58757c972252e5af7ac2574c3791a9778441.1636628783.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Nov 2021, Davide Caratti wrote:

> a non-zero 'id' is sufficient to identify MPTCP endpoints: allow changing
> the value of 'backup' bit by simply specifying the endpoint id.
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/158
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
> net/mptcp/pm_netlink.c | 19 +++++++++++++++----
> 1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 7b96be1e9f14..b4c647e67930 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1700,24 +1700,35 @@ static int mptcp_nl_addr_backup(struct net *net,
> 	return ret;
> }
>
> +static int mptcp_nl_set_flags_idzero(u8 flags)
> +{
> +	return -EOPNOTSUPP;
> +}

Hi Davide -

Is the above function added as a placeholder for something in the future? 
Seems like a direct return below would be clearer.

- Mat


> +
> static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
> {
> +	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
> 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
> 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
> -	struct mptcp_pm_addr_entry addr, *entry;
> 	struct net *net = sock_net(skb->sk);
> -	u8 bkup = 0;
> +	u8 bkup = 0, lookup_by_id = 0;
> 	int ret;
>
> -	ret = mptcp_pm_parse_addr(attr, info, true, &addr);
> +	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
> 	if (ret < 0)
> 		return ret;
>
> 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> 		bkup = 1;
> +	if (addr.addr.family == AF_UNSPEC) {
> +		lookup_by_id = 1;
> +		if (!addr.addr.id)
> +			return mptcp_nl_set_flags_idzero(addr.flags);
> +	}
>
> 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> -		if (addresses_equal(&entry->addr, &addr.addr, true)) {
> +		if ((!lookup_by_id && addresses_equal(&entry->addr, &addr.addr, true)) ||
> +		    (lookup_by_id && entry->addr.id == addr.addr.id)) {
> 			mptcp_nl_addr_backup(net, &entry->addr, bkup);
>
> 			if (bkup)
> -- 
> 2.31.1
>
>

--
Mat Martineau
Intel
