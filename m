Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C407082F
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736996818; cv=none; b=eSC0+4iQpHMNExt4dRaF1s2s9tE7NUPGAY38QFhgm72yYhXLj9Gr94V2aYQSCZSYxgT7wOJM5HiTwqvxypfbVrWcHAXVn7d2Vg+nnVeHeS2QXJ9H/DT2Wz8DYgKzLd0j4RgdpxZk1gfhfsDDZy79+cB7cpxEUjexQ2C085OJ6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736996818; c=relaxed/simple;
	bh=WHvt6lDslUzZd4crtptEoNaiw5jBtsaOVfUBLIBPP+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pbfh1poqEW/TLy+k9lKm91id9zsvvFcg6OyLxMvnx+WeTijhjRvZ++bg+aaem7kNZ9rP5d1WKW53XfaJUfbGSwCUoqHidCqopgKJU0lkd5fuXZobbuis9wZd91XyJV02aJWdtwYzZ/H5cRzPPdg1J04GUrL8FuDMDXPH2f6XT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/mG8GzM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/mG8GzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA3AC4CED1;
	Thu, 16 Jan 2025 03:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736996817;
	bh=WHvt6lDslUzZd4crtptEoNaiw5jBtsaOVfUBLIBPP+4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=M/mG8GzMJQgnmaclVJKBMzbq1lxWuh48V9sGpYw7SWV2ubNcjbX54w6pDRfKl1FWZ
	 k88wgqilg8VUXVE3F6/Z3i16p1AXszFTjaCZuTjjcS9BMY9tadR6C+n0qdJ1Jcrv8Q
	 9n4Tfm2A95o2qeMWdtUtdsJUgxzJzwjBVYPc5mCn9n1Fzy2hGRg4HtLXEG+/FGu3wE
	 v6tHSjtDipgTwQzrTpy5yPyDCpH3k4UQ9MkrcgtJfoAFx3uH3EcO0DrqxNVog31xjf
	 Xv9MM7duYju9cu+TCQqM7dcl8AYsD8ebliZM21woSZwyiYnWXzVgdI4acJHJx9bhfe
	 X2JNFB0B+PpMg==
Message-ID: <0d4373d9a4e51e856cccdf93d0c55aaaf318eacf.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/3] mptcp: register default userspace pm
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 16 Jan 2025 11:06:54 +0800
In-Reply-To: <3f09e1c56ab34f1d2d5b2c149d7ba624cec0538b.1736935433.git.tanggeliang@kylinos.cn>
References: <cover.1736935433.git.tanggeliang@kylinos.cn>
	 <3f09e1c56ab34f1d2d5b2c149d7ba624cec0538b.1736935433.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-01-15 at 18:09 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch defines the original userspace pm as the default path
> manager,
> named mptcp_userspace_pm, and register it in mptcp_pm_data_init().
> 
> Extract address_announce() interface of the userspace PM from the
> handler
> of netlink commond MPTCP_PM_CMD_ANNOUNCE mptcp_pm_nl_announce_doit(),
> only
> leave the code for obtaining msk through "info" and parsing address
> entry
> in the handler.
> 
> Extract address_remove() interface of the userspace PM from the
> handler
> of netlink commond MPTCP_PM_CMD_REMOVE mptcp_pm_nl_remove_doit(),
> only
> leave the code for parsing address id and obtaining msk through
> "info"
> in the handler.
> 
> Extract subflow_create() interface of the userspace PM from the
> handler of
> netlink commond MPTCP_PM_CMD_SUBFLOW_CREATE
> 
> 	mptcp_pm_nl_subflow_create_doit(),
> 
> only leave the code for obtaining msk through "info", parsing local
> address
> entry and parsing remote address info in the handler.
> 
> Extract subflow_destroy() interface of the userspace PM from the
> handler of
> netlink commond MPTCP_PM_CMD_SUBFLOW_DESTROY
> 
> 	mptcp_pm_nl_subflow_destroy_doit(),
> 
> only leave the code for obtaining msk through "info", parsing local
> address
> entry and parsing remote address info in the handler.
> 
> Extract set_flags() interface of the userspace PM from function
> mptcp_userspace_pm_set_flags(), only leave the code for obtaining
> msk through "info" in this function.
> 
> All fives interfaces are invoked under holding the msk socket lock.
> 
> Extract get_local_id() interface of the userspace PM from function
> mptcp_userspace_pm_get_local_id(), only leave the code for setting
> new address entry in this function.
> 
> get_flags() interface of the userspace PM is defined as the same as
> the function mptcp_userspace_pm_get_flags(), then this function
> becomes a wrapper.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c           |   1 +
>  net/mptcp/pm_userspace.c | 275 ++++++++++++++++++++++++-------------
> --
>  net/mptcp/protocol.h     |   1 +
>  3 files changed, 173 insertions(+), 104 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index e275be73b963..3b47c2380a44 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -646,4 +646,5 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>  void __init mptcp_pm_init(void)
>  {
>  	mptcp_pm_nl_init();
> +	mptcp_userspace_pm_init();
>  }
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 2fdee6f22113..c03201c95fea 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -135,32 +135,40 @@ mptcp_userspace_pm_lookup_addr_by_id(struct
> mptcp_sock *msk, unsigned int id)
>  	return NULL;
>  }
>  
> -int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
> -				    struct mptcp_addr_info *skc)
> +static int userspace_pm_get_local_id(struct mptcp_sock *msk,
> +				     struct mptcp_pm_addr_entry
> *local)
>  {
> -	struct mptcp_pm_addr_entry *entry = NULL, new_entry;
>  	__be16 msk_sport =  ((struct inet_sock *)
>  			     inet_sk((struct sock *)msk))-
> >inet_sport;
> +	struct mptcp_pm_addr_entry *entry;
>  
>  	spin_lock_bh(&msk->pm.lock);
> -	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
> +	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
>  	spin_unlock_bh(&msk->pm.lock);
>  	if (entry)
>  		return entry->addr.id;
>  
> +	if (local->addr.port == msk_sport)
> +		local->addr.port = 0;
> +
> +	return mptcp_userspace_pm_append_new_local_addr(msk, local,
> true);
> +}
> +
> +int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
> +				    struct mptcp_addr_info *skc)
> +{
> +	struct mptcp_pm_addr_entry new_entry;
> +
>  	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
>  	new_entry.addr = *skc;
>  	new_entry.addr.id = 0;
>  	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
>  
> -	if (new_entry.addr.port == msk_sport)
> -		new_entry.addr.port = 0;
> -
> -	return mptcp_userspace_pm_append_new_local_addr(msk,
> &new_entry, true);
> +	return userspace_pm_get_local_id(msk, &new_entry);
>  }
>  
> -u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
> -				struct mptcp_addr_info *skc)
> +static u8 userspace_pm_get_flags(struct mptcp_sock *msk,
> +				 struct mptcp_addr_info *skc)
>  {
>  	struct mptcp_pm_addr_entry *entry;
>  	u8 flags;
> @@ -173,6 +181,12 @@ u8 mptcp_userspace_pm_get_flags(struct
> mptcp_sock *msk,
>  	return flags;
>  }
>  
> +u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
> +				struct mptcp_addr_info *skc)
> +{
> +	return userspace_pm_get_flags(msk, skc);
> +}
> +
>  static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct
> genl_info *info)
>  {
>  	struct mptcp_sock *msk;
> @@ -198,6 +212,28 @@ static struct mptcp_sock
> *mptcp_userspace_pm_get_sock(const struct genl_info *in
>  	return msk;
>  }
>  
> +static int userspace_pm_address_announce(struct mptcp_sock *msk,
> +					 struct mptcp_pm_addr_entry
> *local)
> +{
> +	int err;
> +
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, local,
> false);
> +	if (err < 0)
> +		return err;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +
> +	if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
> +		msk->pm.add_addr_signaled++;
> +		mptcp_pm_announce_addr(msk, &local->addr, false);
> +		mptcp_pm_nl_addr_send_ack(msk);
> +	}
> +
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	return 0;
> +}
> +
>  int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info
> *info)
>  {
>  	struct mptcp_pm_addr_entry addr_val;
> @@ -232,26 +268,13 @@ int mptcp_pm_nl_announce_doit(struct sk_buff
> *skb, struct genl_info *info)
>  		goto announce_err;
>  	}
>  
> -	err = mptcp_userspace_pm_append_new_local_addr(msk,
> &addr_val, false);
> -	if (err < 0) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, addr,
> -				    "did not match address and id");
> -		goto announce_err;
> -	}
> -
>  	lock_sock(sk);
> -	spin_lock_bh(&msk->pm.lock);
> -
> -	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
> -		msk->pm.add_addr_signaled++;
> -		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
> -		mptcp_pm_nl_addr_send_ack(msk);
> -	}
> -
> -	spin_unlock_bh(&msk->pm.lock);
> +	err = userspace_pm_address_announce(msk, &addr_val);
>  	release_sock(sk);
> +	if (err)
> +		NL_SET_ERR_MSG_ATTR(info->extack, addr,
> +				    "did not match address and id");
>  
> -	err = 0;
>   announce_err:
>  	sock_put(sk);
>  	return err;
> @@ -301,9 +324,32 @@ void mptcp_pm_remove_addr_entry(struct
> mptcp_sock *msk,
>  	spin_unlock_bh(&msk->pm.lock);
>  }
>  
> +static int userspace_pm_address_remove(struct mptcp_sock *msk, u8
> id)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +
> +	if (id == 0)
> +		return
> mptcp_userspace_pm_remove_id_zero_address(msk);
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
> +	if (!entry) {
> +		spin_unlock_bh(&msk->pm.lock);
> +		return -EINVAL;
> +	}
> +
> +	list_del_rcu(&entry->list);
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	mptcp_pm_remove_addr_entry(msk, entry);
> +
> +	sock_kfree_s((struct sock *)msk, entry, sizeof(*entry));
> +
> +	return 0;
> +}
> +
>  int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info
> *info)
>  {
> -	struct mptcp_pm_addr_entry *match;
>  	struct mptcp_sock *msk;
>  	struct nlattr *id;
>  	int err = -EINVAL;
> @@ -323,32 +369,8 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb,
> struct genl_info *info)
>  	sk = (struct sock *)msk;
>  
>  	lock_sock(sk);
> -
> -	if (id_val == 0) {
> -		err =
> mptcp_userspace_pm_remove_id_zero_address(msk);
> -		release_sock(sk);
> -		goto out;
> -	}
> -
> -	spin_lock_bh(&msk->pm.lock);
> -	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
> -	if (!match) {
> -		spin_unlock_bh(&msk->pm.lock);
> -		release_sock(sk);
> -		goto out;
> -	}
> -
> -	list_del_rcu(&match->list);
> -	spin_unlock_bh(&msk->pm.lock);
> -
> -	mptcp_pm_remove_addr_entry(msk, match);
> -
> +	err = userspace_pm_address_remove(msk, id_val);
>  	release_sock(sk);
> -
> -	sock_kfree_s(sk, match, sizeof(*match));
> -
> -	err = 0;
> -out:
>  	if (err)
>  		NL_SET_ERR_MSG_ATTR_FMT(info->extack, id,
>  					"address with id %u not
> found",
> @@ -358,12 +380,38 @@ int mptcp_pm_nl_remove_doit(struct sk_buff
> *skb, struct genl_info *info)
>  	return err;
>  }
>  
> +static int userspace_pm_subflow_create(struct mptcp_sock *msk,
> +				       struct mptcp_pm_addr_entry
> *entry,
> +				       struct mptcp_addr_info
> *remote)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +	struct mptcp_pm_local local;
> +	int err;
> +
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, entry,
> false);
> +	if (err < 0)
> +		return err;
> +
> +	local.addr = entry->addr;
> +	local.flags = entry->flags;
> +	local.ifindex = entry->ifindex;
> +
> +	err = __mptcp_subflow_connect(sk, &local, remote);
> +	spin_lock_bh(&msk->pm.lock);
> +	if (err)
> +		mptcp_userspace_pm_delete_local_addr(msk, entry);
> +	else
> +		msk->pm.subflows++;
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	return 0;

Should be 'return err;' here.

Will update it in the next version.

Thanks,
-Geliang

> +}
> +
>  int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct
> genl_info *info)
>  {
>  	struct mptcp_pm_addr_entry entry = { 0 };
>  	struct mptcp_addr_info addr_r;
>  	struct nlattr *raddr, *laddr;
> -	struct mptcp_pm_local local;
>  	struct mptcp_sock *msk;
>  	int err = -EINVAL;
>  	struct sock *sk;
> @@ -401,31 +449,13 @@ int mptcp_pm_nl_subflow_create_doit(struct
> sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> -	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry,
> false);
> -	if (err < 0) {
> -		NL_SET_ERR_MSG_ATTR(info->extack, laddr,
> -				    "did not match address and id");
> -		goto create_err;
> -	}
> -
> -	local.addr = entry.addr;
> -	local.flags = entry.flags;
> -	local.ifindex = entry.ifindex;
> -
>  	lock_sock(sk);
> -	err = __mptcp_subflow_connect(sk, &local, &addr_r);
> +	err = userspace_pm_subflow_create(msk, &entry, &addr_r);
>  	release_sock(sk);
>  
>  	if (err)
>  		GENL_SET_ERR_MSG_FMT(info, "connect error: %d",
> err);
>  
> -	spin_lock_bh(&msk->pm.lock);
> -	if (err)
> -		mptcp_userspace_pm_delete_local_addr(msk, &entry);
> -	else
> -		msk->pm.subflows++;
> -	spin_unlock_bh(&msk->pm.lock);
> -
>   create_err:
>  	sock_put(sk);
>  	return err;
> @@ -477,14 +507,34 @@ static struct sock *mptcp_nl_find_ssk(struct
> mptcp_sock *msk,
>  	return NULL;
>  }
>  
> +static int userspace_pm_subflow_destroy(struct mptcp_sock *msk,
> +					struct mptcp_pm_addr_entry
> *local,
> +					struct mptcp_addr_info
> *remote)
> +{
> +	struct sock *ssk, *sk = (struct sock *)msk;
> +
> +	ssk = mptcp_nl_find_ssk(msk, &local->addr, remote);
> +	if (!ssk)
> +		return -ESRCH;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	mptcp_userspace_pm_delete_local_addr(msk, local);
> +	spin_unlock_bh(&msk->pm.lock);
> +	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN |
> SEND_SHUTDOWN);
> +	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
> +
> +	return 0;
> +}
> +
>  int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct
> genl_info *info)
>  {
>  	struct mptcp_pm_addr_entry addr_l;
>  	struct mptcp_addr_info addr_r;
>  	struct nlattr *raddr, *laddr;
>  	struct mptcp_sock *msk;
> -	struct sock *sk, *ssk;
>  	int err = -EINVAL;
> +	struct sock *sk;
>  
>  	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR) ||
>  	    GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
> @@ -535,37 +585,47 @@ int mptcp_pm_nl_subflow_destroy_doit(struct
> sk_buff *skb, struct genl_info *info
>  	}
>  
>  	lock_sock(sk);
> -	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
> -	if (!ssk) {
> -		GENL_SET_ERR_MSG(info, "subflow not found");
> -		err = -ESRCH;
> -		goto release_sock;
> -	}
> -
> -	spin_lock_bh(&msk->pm.lock);
> -	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
> -	spin_unlock_bh(&msk->pm.lock);
> -	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN |
> SEND_SHUTDOWN);
> -	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
> -	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
> -release_sock:
> +	err = userspace_pm_subflow_destroy(msk, &addr_l, &addr_r);
>  	release_sock(sk);
> +	if (err)
> +		GENL_SET_ERR_MSG(info, "subflow not found");
>  
>  destroy_err:
>  	sock_put(sk);
>  	return err;
>  }
>  
> +static int userspace_pm_set_flags(struct mptcp_sock *msk,
> +				  struct mptcp_pm_addr_entry *local,
> +				  struct mptcp_addr_info *remote)
> +{
> +	struct mptcp_pm_addr_entry *entry;
> +	u8 bkup = 0;
> +
> +	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> +		bkup = 1;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
> +	if (entry) {
> +		if (bkup)
> +			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> +		else
> +			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	return mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr,
> remote, bkup);
> +}
> +
>  int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
>  				 struct genl_info *info)
>  {
>  	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
> -	struct mptcp_pm_addr_entry *entry;
>  	struct nlattr *attr, *attr_rem;
>  	struct mptcp_sock *msk;
>  	int ret = -EINVAL;
>  	struct sock *sk;
> -	u8 bkup = 0;
>  
>  	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR_REMOTE))
>  		return ret;
> @@ -596,21 +656,8 @@ int mptcp_userspace_pm_set_flags(struct
> mptcp_pm_addr_entry *local,
>  		goto set_flags_err;
>  	}
>  
> -	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
> -		bkup = 1;
> -
> -	spin_lock_bh(&msk->pm.lock);
> -	entry = mptcp_userspace_pm_lookup_addr(msk, &local->addr);
> -	if (entry) {
> -		if (bkup)
> -			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
> -		else
> -			entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
> -	}
> -	spin_unlock_bh(&msk->pm.lock);
> -
>  	lock_sock(sk);
> -	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &local->addr, &rem,
> bkup);
> +	ret = userspace_pm_set_flags(msk, local, &rem);
>  	release_sock(sk);
>  
>  	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
> @@ -687,6 +734,18 @@ int mptcp_userspace_pm_get_addr(u8 id, struct
> mptcp_pm_addr_entry *addr,
>  	return ret;
>  }
>  
> +static struct mptcp_pm_ops mptcp_userspace_pm = {
> +	.address_announce	= userspace_pm_address_announce,
> +	.address_remove		=
> userspace_pm_address_remove,
> +	.subflow_create		=
> userspace_pm_subflow_create,
> +	.subflow_destroy	= userspace_pm_subflow_destroy,
> +	.get_local_id		= userspace_pm_get_local_id,
> +	.get_flags		= userspace_pm_get_flags,
> +	.set_flags		= userspace_pm_set_flags,
> +	.type			= MPTCP_PM_TYPE_USERSPACE,
> +	.owner			= THIS_MODULE,
> +};
> +
>  /* Must be called with rcu read lock held */
>  struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type)
>  {
> @@ -734,7 +793,15 @@ int mptcp_register_path_manager(struct
> mptcp_pm_ops *pm)
>  
>  void mptcp_unregister_path_manager(struct mptcp_pm_ops *pm)
>  {
> +	if (pm == &mptcp_userspace_pm)
> +		return;
> +
>  	spin_lock(&mptcp_pm_list_lock);
>  	list_del_rcu(&pm->list);
>  	spin_unlock(&mptcp_pm_list_lock);
>  }
> +
> +void __init mptcp_userspace_pm_init(void)
> +{
> +	mptcp_register_path_manager(&mptcp_userspace_pm);
> +}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 64254c57be01..2492354e34dd 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1160,6 +1160,7 @@ static inline u8 subflow_get_local_id(const
> struct mptcp_subflow_context *subflo
>  }
>  
>  void __init mptcp_pm_nl_init(void);
> +void __init mptcp_userspace_pm_init(void);
>  void mptcp_pm_nl_work(struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_add_addr_signal_max(const struct
> mptcp_sock *msk);
>  unsigned int mptcp_pm_get_add_addr_accept_max(const struct
> mptcp_sock *msk);

