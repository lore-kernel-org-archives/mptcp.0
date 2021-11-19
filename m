Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35F68
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 00:45:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234276238"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="234276238"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 16:45:36 -0800
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="550870548"
Received: from asalter-mobl.amr.corp.intel.com ([10.209.63.232])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 16:45:24 -0800
Date: Thu, 18 Nov 2021 16:45:23 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Davide Caratti <dcaratti@redhat.com>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v2] mptcp: allow changing the "backup" bit by
 endpoint id
In-Reply-To: <bc909f9556f6696220611f4691913329624f0edc.1637243913.git.dcaratti@redhat.com>
Message-ID: <e38fcef-ef5c-c875-732b-f06502b7c65@linux.intel.com>
References: <bc909f9556f6696220611f4691913329624f0edc.1637243913.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 18 Nov 2021, Davide Caratti wrote:

> a non-zero 'id' is sufficient to identify MPTCP endpoints: allow changing
> the value of 'backup' bit by simply specifying the endpoint id.
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/158
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>
> Notes:
>    v2:
>     - remove poltergeist that handles id zero

Thanks Davide - this patch looks good to me. I just noticed today that I 
missed your reply to my v1 comment last Friday, sorry about that. The 
change I requested to the id 0 case was mostly about readability.


Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


>
> net/mptcp/pm_netlink.c | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 7b96be1e9f14..4ff8d55cbe82 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1702,22 +1702,28 @@ static int mptcp_nl_addr_backup(struct net *net,
>
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
> +			return -EOPNOTSUPP;
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
