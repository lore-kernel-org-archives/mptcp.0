Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACDE15C9E
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 21:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670275866; x=1701811866;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MvZfvlBPBsUUem7tn7y0spPPlHxnwlHugxgM6Nhj7TQ=;
  b=U+4f1Uw+OyOYT1gzMtDBCxRrWT4+woQlHM9meckwJ2/Hem0ywMZOvOEE
   pK/ygVmy/iZulsnsWgOEJCy+gaL2xABwblQHLcyVrVugRMC0FmRaR2Rh4
   ceQNvueycVVwIhVOSC1Bi0MqhEr3n/34Qr6SmLSMfr3JmHdbHw4BuH10D
   IgU+ZyTjXdtt1nggPx4nMZWz2abLFg4rsZufGMWPzm4ZAJjm/XM+lpweT
   AwMgWFXNcXa4553XFd6WsFB+KO42ZmcOikuOxTQFnV7LGAnukjat5Gfif
   NbhPgFxD87zAgMtfzPb76whvzu5gkvcVhTTG7JIPEGBBR5FNoog/fCjTK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="343486018"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="343486018"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:31:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="676741852"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="676741852"
Received: from psjohns1-mobl.amr.corp.intel.com ([10.209.67.116])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:31:05 -0800
Date: Mon, 5 Dec 2022 13:31:05 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, kernel test robot <lkp@intel.com>, 
    Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH mptcp-next] mptcp: return 0 instead of 'err' var
In-Reply-To: <20221205101002.2620762-1-matthieu.baerts@tessares.net>
Message-ID: <4ca7e8d1-4d93-0e23-45a5-2084f7df982e@linux.intel.com>
References: <20221205101002.2620762-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 5 Dec 2022, Matthieu Baerts wrote:

> When 'err' is 0, it looks clearer to return '0' instead of the variable
> called 'err'.
>
> The behaviour is then not modified, just a clearer code.
>
> By doing this, we can also avoid false positive smatch warnings like
> this one:
>
>  net/mptcp/pm_netlink.c:1169 mptcp_pm_parse_pm_addr_attr() warn: missing error code? 'err'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Thanks for the cleanup Matthieu. Looks good to me.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/pm_netlink.c | 4 ++--
> net/mptcp/sockopt.c    | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 39b0f054f39f..d20f1d969900 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1187,7 +1187,7 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
>
> 	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
> 		if (!require_family)
> -			return err;
> +			return 0;
>
> 		NL_SET_ERR_MSG_ATTR(info->extack, attr,
> 				    "missing family");
> @@ -1221,7 +1221,7 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
> 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
> 		addr->port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
>
> -	return err;
> +	return 0;
> }
>
> int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index a47423ebb33a..d4b1e6ec1b36 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -740,7 +740,7 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
> 	}
> 	release_sock(sk);
>
> -	return err;
> +	return 0;
> }
>
> static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
>
> base-commit: 9324c815f96dd77d23679e999edb875d9f4acd34
> -- 
> 2.37.2
>
>

--
Mat Martineau
Intel
