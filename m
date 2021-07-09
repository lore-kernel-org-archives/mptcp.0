Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53972
	for <mptcp@lists.linux.dev>; Fri,  9 Jul 2021 17:38:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="190120470"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="190120470"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 10:38:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="411337912"
Received: from eefrey-mobl.amr.corp.intel.com ([10.212.193.182])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 10:38:30 -0700
Date: Fri, 9 Jul 2021 10:38:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] mptcp: drop unuse rcu in
 mptcp_pm_addr_entry
In-Reply-To: <75536cfb651328a9c8446676ec123b84e5f4c35f.1625829674.git.geliangtang@gmail.com>
Message-ID: <fe2a31fc-6681-f0e9-317f-e1fc48c5b27c@linux.intel.com>
References: <75536cfb651328a9c8446676ec123b84e5f4c35f.1625829674.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 9 Jul 2021, Geliang Tang wrote:

> kfree_rcu() had been removed from pm_netlink.c, so this rcu field in
> struct mptcp_pm_addr_entry became useless. Let's drop it.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thanks for spotting this!

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> ---
> net/mptcp/pm_netlink.c | 1 -
> 1 file changed, 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d2591ebf01d9..56263c2c4014 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -27,7 +27,6 @@ struct mptcp_pm_addr_entry {
> 	struct mptcp_addr_info	addr;
> 	u8			flags;
> 	int			ifindex;
> -	struct rcu_head		rcu;
> 	struct socket		*lsk;
> };
>
> -- 
> 2.31.1

--
Mat Martineau
Intel
