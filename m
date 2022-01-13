Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258EF2C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 23:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642115638; x=1673651638;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ws358sUkktn715RMgZSJaQqJb+bK+zDpxIRIiuc/uFk=;
  b=PeAaqz1Qua07tVgsw1jmVH6F0DnZ9cgGm3cOC+lDPJnLF24/ISHIQfA+
   keqhwHHmlQQpHwGm4zL6dAcBoRSI/phUhQ+9IGBO8KsL13tLi4wItWPRr
   DX27fiV0mzfemxKPuc5tp26QlA53ZYlkxnvIGzCiaeTL6MpyUOrjoWsve
   COOKyRUKZEPRaa9vOEBUSY8idmioMIdYH2fUZk5Mo+hX90pKp/PkmyZFJ
   ybIYWI0Ve2dFr48GEDxDwBl65usQElZY8QwlpleXcjLYLAhVCKmfEMavA
   s/zWDlccMp3oxxYs4l5o/o4MlmetALOtDKJz90TTpuecy6183s7rI2gQE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="307478245"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="307478245"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:13:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="624039487"
Received: from pialybar-mobl.amr.corp.intel.com ([10.212.252.249])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:13:57 -0800
Date: Thu, 13 Jan 2022 15:13:55 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>, Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 1/4] mptcp: set fullmesh flag in
 pm_netlink
In-Reply-To: <d51b8fd1d4d8171369d5105b708a02d787fcc9a7.1641978967.git.geliang.tang@suse.com>
Message-ID: <e5e7b35e-6286-48f4-67f2-7473b782d64a@linux.intel.com>
References: <cover.1641978967.git.geliang.tang@suse.com> <d51b8fd1d4d8171369d5105b708a02d787fcc9a7.1641978967.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 12 Jan 2022, Geliang Tang wrote:

> This patch added the fullmesh flag setting support in pm_netlink.
>
> If the fullmesh flag of the address is changed, remove all the related
> subflows, update the fullmesh flag and create subflows again.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm_netlink.c | 35 ++++++++++++++++++++++++++---------
> 1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 4c06cd6381ef..8c5a4be21e3d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1722,9 +1722,19 @@ mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct genl_info *info)
> 	return -EMSGSIZE;
> }
>
> -static int mptcp_nl_addr_backup(struct net *net,
> -				struct mptcp_addr_info *addr,
> -				u8 bkup)
> +static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
> +				 struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_rm_list list = { .nr = 0 };
> +
> +	list.ids[list.nr++] = addr->id;
> +
> +	mptcp_pm_nl_rm_subflow_received(msk, &list);
> +	mptcp_pm_create_subflow_or_signal_addr(msk);
> +}
> +
> +static int mptcp_nl_set_flags(struct net *net,
> +			      struct mptcp_pm_addr_entry *entry)
> {
> 	long s_slot = 0, s_num = 0;
> 	struct mptcp_sock *msk;
> @@ -1738,7 +1748,10 @@ static int mptcp_nl_addr_backup(struct net *net,
>
> 		lock_sock(sk);
> 		spin_lock_bh(&msk->pm.lock);
> -		ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
> +		ret = mptcp_pm_nl_mp_prio_send_ack(msk, &entry->addr,
> +						   entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> +		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> +			mptcp_pm_nl_fullmesh(msk, &entry->addr);

My concern here is that if MPTCP_PM_ADDR_FLAG_SIGNAL is not set for 
this entry, mptcp_pm_nl_fullmesh() gets called every time there's a 
MPTCP_PM_CMD_SET_FLAGS command for a valid endpoint.

Would it be better to pass a mask of *changed* flags to 
mptcp_nl_set_flags() so every change to a backup flag doesn't trigger a 
bunch of fullmesh processing, and vice-versa?

- Mat

> 		spin_unlock_bh(&msk->pm.lock);
> 		release_sock(sk);
>
> @@ -1756,15 +1769,13 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
> 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
> 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
> 	struct net *net = sock_net(skb->sk);
> -	u8 bkup = 0, lookup_by_id = 0;
> +	u8 lookup_by_id = 0;
> 	int ret;
>
> 	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
> 	if (ret < 0)
> 		return ret;
>
> -	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> -		bkup = 1;
> 	if (addr.addr.family == AF_UNSPEC) {
> 		lookup_by_id = 1;
> 		if (!addr.addr.id)
> @@ -1778,14 +1789,20 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
> 		return -EINVAL;
> 	}
>
> -	if (bkup)
> +	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> 		entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> 	else
> 		entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
> +
> +	if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
> +		entry->flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
> +	else
> +		entry->flags &= ~MPTCP_PM_ADDR_FLAG_FULLMESH;
> +
> 	addr = *entry;
> 	spin_unlock_bh(&pernet->lock);
>
> -	mptcp_nl_addr_backup(net, &addr.addr, bkup);
> +	mptcp_nl_set_flags(net, &addr);
> 	return 0;
> }
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
