Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A17470
	for <mptcp@lists.linux.dev>; Wed, 17 Jul 2024 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721185456; cv=none; b=GbSXlJ+IE6nF5Aim9/mcTAZwvn+P4Ky9HmjXwmvIPng5JAE+f8FHqU1KW9AaDXeOiKsK/Jb5g7I3neUv08jkE1paaJMI0zp8QkoAY7BE43ElAZ8G1bxVHQOcNhRCjra69k57vbGkRKHZwatxPpdL+6kW4X/9Os5QAwgJcUlHjsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721185456; c=relaxed/simple;
	bh=ykWdRUIBpgHQNrk8aKSig/Q0LHxdyPsqLi4SN1hSU20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ83htWDhgR/yzfZEZp8VUFf3+ojszD13YOvvVapO30VKHK4yvTgMSoIrWh6uIS74YFwh/dnQvV2pAVdF7RA8YQ1IgHIyvBc0zBrQQPKYuCySPBmola4Wjqz3Rz7ZArqnIfJZpg/LmOXiuzP/mB+sU5cXjLddSIa88jSyr35JvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf9706Rg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf9706Rg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3502C116B1;
	Wed, 17 Jul 2024 03:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721185455;
	bh=ykWdRUIBpgHQNrk8aKSig/Q0LHxdyPsqLi4SN1hSU20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xf9706Rg9DsOKm6ZhhrU7+bL5NwjukRk57Ea13Y2mNBh4xZuTmvhLgeFfSE/sHzbS
	 osIoKIM1xvezREsPJeecFY1PWmcF0kOPL+UyHvpoqlvwO4yacDd/EX6uwaAHfq3aMz
	 qH7r4tOH2eY5XNJCvdAKpnteFdpasMlVaaEr4rgcv+kmFhKHhQVJnzYlUyeB4UeUvW
	 9tubdhVSOMpNgUCvQcpHkyq86k1eAXI6InjrLyKzP3VJEFWpH8PArRaKMCD88JsME2
	 mIWYk/9SSAgK4fu6KeMC4W+C3Gp65Xt9Rv4QWrJ3GjOHahnieimESDtwYMHoU/4vcN
	 DQ/NqGZj3ccQA==
Date: Wed, 17 Jul 2024 11:04:10 +0800
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 6/9] mptcp: pm: fix backup support in signal
 endpoints
Message-ID: <Zpc0qmOTE4ykQ1lr@T480>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
 <20240716-mptcp-backup-mpj-v2-6-4d50247405fb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716-mptcp-backup-mpj-v2-6-4d50247405fb@kernel.org>

Hi Matt,

On Tue, Jul 16, 2024 at 10:53:18PM +0200, Matthieu Baerts (NGI0) wrote:
> There was a support for signal endpoints, but only when the endpoint's
> flag was changed during a connection. If an endpoint with the signal and
> backup was already present, the MP_JOIN reply was not containing the
> backup flag as expected.
> 
> That's confusing to have this inconsistent behaviour. On the other hand,
> the infrastructure to set the backup flag in the SYN + ACK + MP_JOIN was
> already there, it was just never set before. Now when requesting the
> local ID from the path-manager, the backup status is also requested.
> 
> There is a special case for the ID0: the PM has to return this ID0 if
> the local address of the initial subflow is being used, and not the ID
> of the related endpoint. Still, it is required to look at the different
> endpoints to find if one has been defined for this address with the
> backup flag.
> 
> Note that when the userspace PM is used, the backup flag can be set if
> the local address was already used before with a backup flag, e.g. if
> the address was announced with the 'backup' flag, or a subflow was
> created with the 'backup' flag.
> 
> Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/507
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - v2:
>    - Only set *backup on success (Mat).
>    - Support MPJ to/from ID0 with backup.
>    - Split the tests in a new dedicated commit to ease the backports.
> ---
>  net/mptcp/pm.c           | 15 +++++++++++----
>  net/mptcp/pm_netlink.c   | 23 ++++++++++++++++++++++-
>  net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++--
>  net/mptcp/protocol.h     | 11 ++++++++---
>  net/mptcp/subflow.c      |  9 +++++++--
>  5 files changed, 71 insertions(+), 12 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 55406720c607..359738b8826e 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -405,7 +405,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  	return ret;
>  }
>  
> -int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
> +int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc,
> +			  bool *backup)
>  {
>  	struct mptcp_addr_info skc_local;
>  	struct mptcp_addr_info msk_local;
> @@ -418,12 +419,18 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  	 */
>  	mptcp_local_address((struct sock_common *)msk, &msk_local);
>  	mptcp_local_address((struct sock_common *)skc, &skc_local);
> -	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
> +	if (mptcp_addresses_equal(&msk_local, &skc_local, false)) {
> +		if (mptcp_pm_is_userspace(msk))
> +			*backup = mptcp_userspace_pm_is_backup(msk, &skc_local);
> +		else
> +			*backup = mptcp_pm_nl_is_backup(msk, &skc_local);
> +
>  		return 0;
> +	}
>  
>  	if (mptcp_pm_is_userspace(msk))
> -		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
> -	return mptcp_pm_nl_get_local_id(msk, &skc_local);
> +		return mptcp_userspace_pm_get_local_id(msk, &skc_local, backup);
> +	return mptcp_pm_nl_get_local_id(msk, &skc_local, backup);
>  }

I think that instead of mixing "backup" into get_local_id() interface, it is much
better to add a new interface is_backup() for PM in pm.c:

bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
{
       struct mptcp_addr_info skc_local;

       mptcp_local_address((struct sock_common *)skc, &skc_local);

       if (mptcp_pm_is_userspace(msk))
               return mptcp_userspace_pm_is_backup(msk, &skc_local);
       return mptcp_pm_nl_is_backup(msk, &skc_local);
}

No need to test whether the two addresses msk_local and skc_local are the same
in mptcp_pm_is_backup(), just invoke mptcp_pm_nl_is_backup() or
mptcp_userspace_pm_is_backup() with skc_local.

>  
>  int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 7635fac91539..796800a7fe96 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1064,7 +1064,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>  	return err;
>  }
>  
> -int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
> +int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc,
> +			     bool *backup)
>  {
>  	struct mptcp_pm_addr_entry *entry;
>  	struct pm_nl_pernet *pernet;
> @@ -1076,6 +1077,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
>  	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
>  		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
>  			ret = entry->addr.id;
> +			*backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
>  			break;
>  		}
>  	}
> @@ -1094,6 +1096,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
>  	entry->ifindex = 0;
>  	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
>  	entry->lsk = NULL;
> +	*backup = false;
>  	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
>  	if (ret < 0)
>  		kfree(entry);
> @@ -1101,6 +1104,24 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
>  	return ret;
>  }
>  
> +bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
> +{
> +	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
> +	struct mptcp_pm_addr_entry *entry;
> +	bool backup = false;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> +		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
> +			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return backup;
> +}
> +
>  #define MPTCP_PM_CMD_GRP_OFFSET       0
>  #define MPTCP_PM_EV_GRP_OFFSET        1
>  
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index f0a4590506c6..4e3829f96c88 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -137,7 +137,7 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
>  }
>  
>  int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
> -				    struct mptcp_addr_info *skc)
> +				    struct mptcp_addr_info *skc, bool *backup)
>  {
>  	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
>  	__be16 msk_sport =  ((struct inet_sock *)
> @@ -151,13 +151,16 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
>  		}
>  	}
>  	spin_unlock_bh(&msk->pm.lock);
> -	if (entry)
> +	if (entry) {
> +		*backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
>  		return entry->addr.id;
> +	}
>  
>  	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
>  	new_entry.addr = *skc;
>  	new_entry.addr.id = 0;
>  	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> +	*backup = false;
>  
>  	if (new_entry.addr.port == msk_sport)
>  		new_entry.addr.port = 0;
> @@ -165,6 +168,24 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
>  	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, true);
>  }
>  
> +bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
> +				  struct mptcp_addr_info *skc)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +	bool backup = false;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
> +		if (mptcp_addresses_equal(&entry->addr, skc, false)) {
> +			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> +			break;
> +		}
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	return backup;
> +}
> +
>  int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6b6b76152db5..e6cc7111f843 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1111,9 +1111,14 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
>  			      bool *drop_other_suboptions);
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  			     struct mptcp_rm_list *rm_list);
> -int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
> -int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
> -int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
> +int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc,
> +			  bool *backup);
> +int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc,
> +			     bool *backup);
> +int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc,
> +				    bool *backup);
> +bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
> +bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
>  int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb);
>  int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
>  			  struct netlink_callback *cb);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index be406197b1c4..e60ba0327e4d 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -87,6 +87,7 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
>  	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
>  	struct mptcp_sock *msk;
>  	int local_id;
> +	bool backup;
>  
>  	msk = mptcp_token_get_sock(sock_net(req_to_sk(req)), subflow_req->token);
>  	if (!msk) {
> @@ -94,12 +95,13 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
>  		return NULL;
>  	}
>  
> -	local_id = mptcp_pm_get_local_id(msk, (struct sock_common *)req);
> +	local_id = mptcp_pm_get_local_id(msk, (struct sock_common *)req, &backup);
>  	if (local_id < 0) {
>  		sock_put((struct sock *)msk);
>  		return NULL;
>  	}
>  	subflow_req->local_id = local_id;
> +	subflow_req->request_bkup = backup;

Always invoke is_backup() after get_local_id():
	
	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);

>  
>  	return msk;
>  }
> @@ -610,16 +612,19 @@ static int subflow_chk_local_id(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +	bool backup;
>  	int err;
>  
>  	if (likely(subflow->local_id >= 0))
>  		return 0;
>  
> -	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
> +	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk, &backup);
>  	if (err < 0)
>  		return err;
>  
>  	subflow_set_local_id(subflow, err);
> +	subflow->request_bkup = backup;

	subflow->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)sk);

WDYT?

Thanks,
-Geliang

> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.45.2
> 
