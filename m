Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFFF33D6
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 22:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656457073; x=1687993073;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w/igDRh1IAbaYeGDsoYkqIQ3MnPXG22D7+IR23Hs7BU=;
  b=PgKAl4blYhq2AQts3v/hDUF20lxS92sOsgip86HdyC+YDT2YCW+9MrnR
   tp3ZirI3iXcoIM5nt2y71gIsRtli8oimH50aNrPdz3INgeSGlcLfYz17Z
   ZNFSek08CqqfPFMOBdTFsyErDdNJp9U5v58wMiyEz44ThFdu+9z68ehkA
   EkzYz9O92W4fZMBuLHiRVCTqRJp6dMUOBirwzIk+VDEAUiorpIrCIr8tD
   PLUDCZCU6U+bOef/ruEDvEpXu3/J7OQAIaU9FfQxmm7j2qYnVbSF3clan
   F/pGm89FAeKvGlY5L0pIh+hXc5HzNGuatcUQDu1AG6Yd3i30iNzvGeECB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282603312"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="282603312"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:57:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="623098872"
Received: from hmok-mobl1.amr.corp.intel.com ([10.209.98.71])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:57:53 -0700
Date: Tue, 28 Jun 2022 15:57:52 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3 1/2] mptcp: netlink: issue MP_PRIO signals
 from userspace PMs
In-Reply-To: <20220628212918.417515-2-kishen.maloor@intel.com>
Message-ID: <cd551eb2-fff8-718d-3c3f-382cbf22a020@linux.intel.com>
References: <20220628212918.417515-1-kishen.maloor@intel.com> <20220628212918.417515-2-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 28 Jun 2022, Kishen Maloor wrote:

> This change updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
> to issue MP_PRIO signals over a specific subflow selected by
> the connection token, local and remote address+port.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/286
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> v3:
> -use local and remote address+port (instead of address ID) alongwith the
> connection token to select a subflow.
> ---
> net/mptcp/pm_netlink.c   | 30 +++++++++++++++++++++++++-----
> net/mptcp/pm_userspace.c | 30 ++++++++++++++++++++++++++++++
> net/mptcp/protocol.h     |  8 +++++++-
> 3 files changed, 62 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 05c6a95e9c28..602892f2f921 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -717,9 +717,10 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
> 	}
> }
>
> -static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> -					struct mptcp_addr_info *addr,
> -					u8 bkup)
> +int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> +				 struct mptcp_addr_info *addr,
> +				 struct mptcp_addr_info *rem,
> +				 u8 bkup)
> {
> 	struct mptcp_subflow_context *subflow;
>
> @@ -728,7 +729,7 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 		struct sock *sk = (struct sock *)msk;
> -		struct mptcp_addr_info local;
> +		struct mptcp_addr_info local, remote;
> 		bool slow;
>
> 		local_address((struct sock_common *)ssk, &local);
> @@ -736,6 +737,12 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> 			continue;
>
> 		slow = lock_sock_fast(ssk);
> +		if (rem && rem->family != AF_UNSPEC) {
> +			remote_address((struct sock_common *)ssk, &remote);
> +			if (!mptcp_addresses_equal(&remote, rem, rem->port))
> +				continue;
> +		}

Hi Kishen -

Thanks for the v3!

The CI build failed because the ssk lock is not released before this 
'continue' statement. The sparse error message was pretty vague, though.

remote_address() is only checking sock_common fields that don't change, I 
don't think the ssk lock is required (it's used this way elsewhere in the 
code). So this new hunk of code should be before the lock_sock_fast() 
call.


- Mat



> +
> 		if (subflow->backup != bkup)
> 			msk->last_snd = NULL;
> 		subflow->backup = bkup;
> @@ -1839,7 +1846,7 @@ static int mptcp_nl_set_flags(struct net *net,
>
> 		lock_sock(sk);
> 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
> -			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
> +			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
> 		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
> 			mptcp_pm_nl_fullmesh(msk, addr);
> 		release_sock(sk);
> @@ -1855,6 +1862,9 @@ static int mptcp_nl_set_flags(struct net *net,
> static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
> {
> 	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
> +	struct mptcp_pm_addr_entry remote = { .addr = { .family = AF_UNSPEC }, };
> +	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
> +	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
> 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
> 	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
> @@ -1867,6 +1877,12 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
> 	if (ret < 0)
> 		return ret;
>
> +	if (attr_rem) {
> +		ret = mptcp_pm_parse_entry(attr_rem, info, false, &remote);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> 		bkup = 1;
> 	if (addr.addr.family == AF_UNSPEC) {
> @@ -1875,6 +1891,10 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
> 			return -EOPNOTSUPP;
> 	}
>
> +	if (token)
> +		return mptcp_userspace_pm_set_flags(sock_net(skb->sk),
> +						    token, &addr, &remote, bkup);
> +
> 	spin_lock_bh(&pernet->lock);
> 	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
> 	if (!entry) {
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 26212bebc5ed..51e2f066d54f 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -420,3 +420,33 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
> 	sock_put((struct sock *)msk);
> 	return err;
> }
> +
> +int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
> +				 struct mptcp_pm_addr_entry *loc,
> +				 struct mptcp_pm_addr_entry *rem, u8 bkup)
> +{
> +	struct mptcp_sock *msk;
> +	int ret = -EINVAL;
> +	u32 token_val;
> +
> +	token_val = nla_get_u32(token);
> +
> +	msk = mptcp_token_get_sock(net, token_val);
> +	if (!msk)
> +		return ret;
> +
> +	if (!mptcp_pm_is_userspace(msk))
> +		goto set_flags_err;
> +
> +	if (loc->addr.family == AF_UNSPEC ||
> +	    rem->addr.family == AF_UNSPEC)
> +		goto set_flags_err;
> +
> +	lock_sock((struct sock *)msk);
> +	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
> +	release_sock((struct sock *)msk);
> +
> +set_flags_err:
> +	sock_put((struct sock *)msk);
> +	return ret;
> +}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 033c995772dc..480c5320b86e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -772,6 +772,10 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
> 			       const struct mptcp_rm_list *rm_list);
> void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
> void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
> +int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> +				 struct mptcp_addr_info *addr,
> +				 struct mptcp_addr_info *rem,
> +				 u8 bkup);
> bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
> 			      const struct mptcp_pm_addr_entry *entry);
> void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> @@ -788,7 +792,9 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> 						   unsigned int id,
> 						   u8 *flags, int *ifindex);
> -
> +int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
> +				 struct mptcp_pm_addr_entry *loc,
> +				 struct mptcp_pm_addr_entry *rem, u8 bkup);
> int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> 			   const struct mptcp_addr_info *addr,
> 			   bool echo);
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
