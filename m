Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A897F
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 01:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672796138; x=1704332138;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y2gjcHxf3UXRK4oi6rE7fcF97QWEREQt5muHXEI6GCI=;
  b=CeUjhBk7Lh4meoDwy90TiRHnSCf7WQPvbqWhUXt7nA1ZJJ2E+1avlwl9
   wf8SVukUEwjHzY86DmEcxUyM9VhUM8Wna7Jfwkn+Dtrn71hHlzfzpqra6
   RiK+l4gM4CeBh3a+bZAIuNLw0GWCN37q3gWBIR/CdzhgVZZ4eLcEWJ2uC
   XznBV8JTwUiWah/bmZUzRpK/X6S8lW2DjQ3iSjgujaOlS9M1KD4XeLbmL
   DfdBPppJG+btiPe6Cnq5WIkz0bRVbOsYOfCSvN3f9KElBAsrnmw/3D0LA
   ExW1CpoUl5iFxiIbzKFBvHFW6EAKF0VKq3B814tL0ktV0TAZMEu9147ZQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="301492449"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="301492449"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 17:35:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="797367429"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="797367429"
Received: from ticela-or-138.amr.corp.intel.com ([10.212.169.215])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 17:35:38 -0800
Date: Tue, 3 Jan 2023 17:35:37 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v4 02/12] mptcp: netlink: respect v4/v6-only
 sockets
In-Reply-To: <20221228101748.2518303-3-matthieu.baerts@tessares.net>
Message-ID: <454ad691-ca73-f9d0-79b3-9760893bcdf4@linux.intel.com>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net> <20221228101748.2518303-3-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 28 Dec 2022, Matthieu Baerts wrote:

> If an MPTCP socket has been created with AF_INET6 and the IPV6_V6ONLY
> option has been set, the userspace PM would allow creating subflows
> using IPv4 addresses, e.g. mapped in v6.
>
> The userspace PM will also accept creating subflows with local and
> remote addresses having different families resulting in the creation
> of non expected subflows.
>

Could you clarify the consequences of a userspace PM allowing these 
subflows on unpatched kernels? Are resources leaked, or undefined behavior 
caused?


> It is then required to check the given families can be accepted. This is
> done by using a new helper for addresses family matching, taking care of
> IPv4 vs IPv4-mapped-IPv6 addresses. This helper will be re-used later by
> the in-kernel path-manager to use mixed IPv4 and IPv6 addresses.
>
> While at it, a clear error message is now reported if there are some
> conflicts with the families that have been passed by the userspace.
>
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> net/mptcp/pm.c           | 25 +++++++++++++++++++++++++
> net/mptcp/pm_userspace.c |  7 +++++++
> net/mptcp/protocol.h     |  3 +++
> 3 files changed, 35 insertions(+)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index cdeb7280ac76..083f3f8322c0 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -413,6 +413,31 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
> 	}
> }
>
> +/* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
> + * otherwise allow any matching local/remote pair
> + */
> +bool mptcp_pm_addr_families_match(const struct sock *sk,
> +				  const struct mptcp_addr_info *loc,
> +				  const struct mptcp_addr_info *rem)
> +{
> +	bool mptcp_is_v4 = sk->sk_family == AF_INET;
> +
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	bool loc_is_v4 = loc->family == AF_INET || ipv6_addr_v4mapped(&loc->addr6);
> +	bool rem_is_v4 = rem->family == AF_INET || ipv6_addr_v4mapped(&rem->addr6);
> +
> +	if (mptcp_is_v4)
> +		return loc_is_v4 && rem_is_v4;
> +
> +	if (ipv6_only_sock(sk))
> +		return !loc_is_v4 && !rem_is_v4;
> +
> +	return loc_is_v4 == rem_is_v4;
> +#else
> +	return mptcp_is_v4 && loc->family == AF_INET && rem->family && AF_INET;

                                                                     ^^

Looks like you intended:

+     return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;

Correct?


- Mat


> +#endif
> +}
> +
> void mptcp_pm_data_reset(struct mptcp_sock *msk)
> {
> 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 65dcc55a8ad8..ea6ad9da7493 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -294,6 +294,13 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
> 	}
>
> 	sk = (struct sock *)msk;
> +
> +	if (!mptcp_pm_addr_families_match(sk, &addr_l, &addr_r)) {
> +		GENL_SET_ERR_MSG(info, "families mismatch");
> +		err = -EINVAL;
> +		goto create_err;
> +	}
> +
> 	lock_sock(sk);
>
> 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b2b56a80e817..871ec3e93314 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -793,6 +793,9 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
> int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
> 			 bool require_family,
> 			 struct mptcp_pm_addr_entry *entry);
> +bool mptcp_pm_addr_families_match(const struct sock *sk,
> +				  const struct mptcp_addr_info *loc,
> +				  const struct mptcp_addr_info *rem);
> void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
> void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk);
> void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int server_side);
> -- 
> 2.37.2
>
>
>

--
Mat Martineau
Intel
