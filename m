Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DF329CA
	for <mptcp@lists.linux.dev>; Sat, 15 Jan 2022 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642206607; x=1673742607;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=t02bf37Ci7fNwr8peSLh9cvjvyz+o4+FA752Ezn0pn8=;
  b=QiuRcVoEyZBvoxxU3EEvVoA8bYJhQWH30ChmtI/imaYRhLewzQNAGjPx
   Dlnw0q0Ejxa3bN8ZU1Voqipmtm/PAHVIn2/ezp1WIXD09EBljXo9/gMGA
   9X4WB7R7XKVQUzxblna46CqTnZtlwmpMBagHtAWOHzgTu2iuB/d2/WD8s
   /eKxwG1X6xSdMSRo45A5yGKvxAEBXbN/eYtpH8JQfGsX/CMB9f10L/b7m
   uWfJ1Q2Rm7VJ9YUD+rnGZjiCSCrnem/KVIVVJoLpBXlTJsHLTn0SAH1cf
   pg00lJHJ8XOUQEzmWnF6y51MH+1YUD/SLdgfIpgELo32Zegr3vzz2ha2L
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="268727038"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="268727038"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 16:30:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="692417093"
Received: from shajisur-mobl.amr.corp.intel.com ([10.209.76.214])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 16:30:02 -0800
Date: Fri, 14 Jan 2022 16:30:01 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 01/11] mptcp: set fullmesh flag in
 pm_netlink
In-Reply-To: <73d69473106598109da2db398f9eb57ca1a3947a.1642154579.git.geliang.tang@suse.com>
Message-ID: <41bade19-55ef-bbc3-f99b-f2c62bd780d5@linux.intel.com>
References: <cover.1642154579.git.geliang.tang@suse.com> <73d69473106598109da2db398f9eb57ca1a3947a.1642154579.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 14 Jan 2022, Geliang Tang wrote:

> This patch added the fullmesh flag setting support in pm_netlink.
>
> If the fullmesh flag of the address is changed, remove all the related
> subflows, update the fullmesh flag and create subflows again.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm_netlink.c | 38 +++++++++++++++++++++++++++++++++-----
> 1 file changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 4c06cd6381ef..b86bdb6cd0ee 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1722,9 +1722,20 @@ mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct genl_info *info)
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
> +			      struct mptcp_addr_info *addr,
> +			      u8 bkup, u8 fmesh)
> {
> 	long s_slot = 0, s_num = 0;
> 	struct mptcp_sock *msk;
> @@ -1738,7 +1749,10 @@ static int mptcp_nl_addr_backup(struct net *net,
>
> 		lock_sock(sk);
> 		spin_lock_bh(&msk->pm.lock);
> -		ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
> +		if (bkup || !fmesh)
> +			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
> +		if (fmesh || !bkup)
> +			mptcp_pm_nl_fullmesh(msk, addr);

These two conditions don't detect whether fmesh or bkup changed, and will 
still call mptcp_pm_nl_mp_prio_send_ack() or mptcp_pm_nl_fullmesh() when 
the backup or fullmesh flags are unmodified. The *updated values of the 
flags* and *which flags changed* are two separate things to store, see 
below.

> 		spin_unlock_bh(&msk->pm.lock);
> 		release_sock(sk);
>
> @@ -1757,6 +1771,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
> 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
> 	struct net *net = sock_net(skb->sk);
> 	u8 bkup = 0, lookup_by_id = 0;
> +	u8 fmesh = 0;
> 	int ret;
>
> 	ret = mptcp_pm_parse_addr(attr, info, false, &addr);
> @@ -1765,6 +1780,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
>
> 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> 		bkup = 1;
> +	if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
> +		fmesh = 1;
> 	if (addr.addr.family == AF_UNSPEC) {
> 		lookup_by_id = 1;
> 		if (!addr.addr.id)
> @@ -1778,14 +1795,25 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
> 		return -EINVAL;
> 	}
>
> +	if ((fmesh || !bkup) && (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
> +		spin_unlock_bh(&pernet->lock);
> +		return -EINVAL;
> +	}
> +
> 	if (bkup)
> 		entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> 	else
> 		entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
> +
> +	if (fmesh)
> +		entry->flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
> +	else
> +		entry->flags &= ~MPTCP_PM_ADDR_FLAG_FULLMESH;
> +
> 	addr = *entry;
> 	spin_unlock_bh(&pernet->lock);
>
> -	mptcp_nl_addr_backup(net, &addr.addr, bkup);
> +	mptcp_nl_set_flags(net, &addr.addr, bkup, fmesh);
> 	return 0;
> }

To check which flags have changed, I suggest something like this (based on 
the previous rev of this patch):

 	u8 changed;
 	u8 mask = MPTCP_PM_ADDR_FLAG_BACKUP | MPTCP_PM_ADDR_FLAG_FULLMESH;

 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}

 	changed = (addr.flags ^ entry->flags) & mask;
 	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);

 	addr = *entry;
 	spin_unlock_bh(&pernet->lock);

 	mptcp_nl_set_flags(net, &addr, changed);

Then you can use the bits in 'changed' to determine when to call 
mptcp_pm_nl_mp_prio_send_ack() or mptcp_pm_nl_fullmesh() in 
mptcp_nl_set_flags():

> +		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
> +			ret = mptcp_pm_nl_mp_prio_send_ack(msk, &entry->addr,
> +							   entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> +		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
> +			mptcp_pm_nl_fullmesh(msk, &entry->addr);



--
Mat Martineau
Intel
