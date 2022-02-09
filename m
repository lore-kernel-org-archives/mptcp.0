Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F0C2F28
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 01:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644369639; x=1675905639;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ItBy+6Ckrc4Q+fV2AsZ+opqcwW/3ji2ldn4I3lCD870=;
  b=Jvz7SVpvFgSW5geOSCtULaivsP1upxf5OmUIyts+HJMshu2cEXaAb34p
   5OHo920npOLxQH8ADwoNaRzKyd4yQ2iR9Nkf+8VwoZP3XoNJ+qie1RwPl
   7zyvhhOk5gG2t7Ji2muHRnvTRzvcjFcIUdLISHeX4bGct2QDOwijCm1Hf
   VAkeqk60JwUFQRVj41CYDcy4lW5eXtvX3zwpwOikZjrPyu/VRu1siaD6i
   On9KyT8LrSZNEs8A8fQ+p9cXuzSBea4gmrrtO/6cWcG1wJzd69Fj0P13V
   bXVT9b5ueT39ShNoMDANwDXP+WgZiQYtO+rDu9ZN95p2tGCMHO790ufWP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229743101"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="229743101"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 17:20:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="622099409"
Received: from tonysun-mobl.amr.corp.intel.com ([10.212.141.113])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 17:20:39 -0800
Date: Tue, 8 Feb 2022 17:20:38 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/4] mptcp: drop port parameter of
 mptcp_pm_add_addr_signal
In-Reply-To: <d34da01837f0f01060a0240c00870df9372c2e39.1644318561.git.geliang.tang@suse.com>
Message-ID: <1457fe5a-2037-6375-5b5d-1ae6c7dac871@linux.intel.com>
References: <cover.1644318561.git.geliang.tang@suse.com> <d34da01837f0f01060a0240c00870df9372c2e39.1644318561.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 8 Feb 2022, Geliang Tang wrote:

> Drop the port parameter of mptcp_pm_add_addr_signal() and reflect it to
> avoid passing too many parameters.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

For this patch, looks like a helpful bit of cleanup. Thanks!

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> net/mptcp/options.c  | 5 ++---
> net/mptcp/pm.c       | 7 ++++---
> net/mptcp/protocol.h | 2 +-
> 3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 7b615dc10897..4e516e88ab88 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -652,7 +652,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> 	bool drop_other_suboptions = false;
> 	unsigned int opt_size = *size;
> 	bool echo;
> -	bool port;
> 	int len;
>
> 	/* add addr will strip the existing options, be sure to avoid breaking
> @@ -661,12 +660,12 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> 	if (!mptcp_pm_should_add_signal(msk) ||
> 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
> 	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
> -		    &echo, &port, &drop_other_suboptions))
> +		    &echo, &drop_other_suboptions))
> 		return false;
>
> 	if (drop_other_suboptions)
> 		remaining += opt_size;
> -	len = mptcp_add_addr_len(opts->addr.family, echo, port);
> +	len = mptcp_add_addr_len(opts->addr.family, echo, !!opts->addr.port);
> 	if (remaining < len)
> 		return false;
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 1f8878cc29e3..99db7270e461 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -284,11 +284,12 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
> 			      unsigned int opt_size, unsigned int remaining,
> 			      struct mptcp_addr_info *addr, bool *echo,
> -			      bool *port, bool *drop_other_suboptions)
> +			      bool *drop_other_suboptions)
> {
> 	int ret = false;
> 	u8 add_addr;
> 	u8 family;
> +	bool port;
>
> 	spin_lock_bh(&msk->pm.lock);
>
> @@ -306,10 +307,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
> 	}
>
> 	*echo = mptcp_pm_should_add_signal_echo(msk);
> -	*port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
> +	port = !!(*echo ? msk->pm.remote.port : msk->pm.local.port);
>
> 	family = *echo ? msk->pm.remote.family : msk->pm.local.family;
> -	if (remaining < mptcp_add_addr_len(family, *echo, *port))
> +	if (remaining < mptcp_add_addr_len(family, *echo, port))
> 		goto out_unlock;
>
> 	if (*echo) {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f37f087caab3..0eebfc9f39bc 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -835,7 +835,7 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
> 			      unsigned int opt_size, unsigned int remaining,
> 			      struct mptcp_addr_info *addr, bool *echo,
> -			      bool *port, bool *drop_other_suboptions);
> +			      bool *drop_other_suboptions);
> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> 			     struct mptcp_rm_list *rm_list);
> int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
