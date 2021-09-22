Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278072
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 22:33:06 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="246161388"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="246161388"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 15:32:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="513170137"
Received: from vtallapa-mobl.amr.corp.intel.com ([10.212.134.230])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 15:32:50 -0700
Date: Wed, 22 Sep 2021 15:32:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Davide Caratti <dcaratti@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@gmail.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: allow changing the 'backup' bit when
 no sockets are open
In-Reply-To: <6fada33a17044e54f0ba5b3a5dc35987cbea3b54.1632318877.git.dcaratti@redhat.com>
Message-ID: <6f5df69-cffa-6d5d-a957-f93f2ff0e9b6@linux.intel.com>
References: <6fada33a17044e54f0ba5b3a5dc35987cbea3b54.1632318877.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 22 Sep 2021, Davide Caratti wrote:

> current Linux refuses to change the 'backup' bit of MPTCP endpoints, i.e.
> using MPTCP_PM_CMD_SET_FLAGS, unless it finds (at least) one subflow that
> matches the endpoint address. There is no reason for that, so we can just
> ignore the return value of mptcp_nl_addr_backup(). In this way, endpoints
> can reconfigure their 'backup' flag even if no MPTCP sockets are open (or
> more generally, in case the MP_PRIO message is not sent out).
>
> Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>
> Notes:
>    v2:
>     - ignore the return value of mptcp_nl_addr_backup() rather than just
>       gixing the case of 0 open sockets, from Mat Martineau
>
> net/mptcp/pm_netlink.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index c4f9a5ce3815..c3722eedc671 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1718,10 +1718,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
>
> 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
> 		if (addresses_equal(&entry->addr, &addr.addr, true)) {
> -			ret = mptcp_nl_addr_backup(net, &entry->addr, bkup);
> -			if (ret)
> -				return ret;
> -
> +			mptcp_nl_addr_backup(net, &entry->addr, bkup);

Strictly speaking, should leave a blank line before this 'if' statement, 
but other than that it looks good. I can fix it up before sending to 
netdev.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> 			if (bkup)
> 				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> 			else
> -- 
> 2.31.1
>
>

--
Mat Martineau
Intel
