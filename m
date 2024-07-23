Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1A73D6A
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729946; cv=none; b=GV9MfIzZMN4t3cRJmwYAE6xgyFebicgpf9ub/Xwr2i9WJ8kU6Ai6AsJ0wKk+9H1Phnqlvo/WQsO99K07A5V9AQISgOtzHKJp2cuOhnm8l42hyiBHHZw7VAlAX5In6p2CbTr305dELUNGW1hxrd30zlsS3h6UNBh3MZJS8URoXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729946; c=relaxed/simple;
	bh=qEi7FhbcT34vEQkzShUOFbD1DOTnKvQEKuiv1X2ljug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqZinCfDYA1QpuwRreURUrcpHhNr22U9gxTA7nBk3HVPKQZA/V06WbvSAkGXaDC3SsYBz/OiuopAnlipHyroIiuS9stEtmVi4O4RPsBqNGWG/oHfJ4XPKxPagCKnnMGfl6X4snGXXL7NTjgj8YbNhOOjQUB5vvy0HNrDWR1COWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIvCcID0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIvCcID0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7077C4AF0A;
	Tue, 23 Jul 2024 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721729945;
	bh=qEi7FhbcT34vEQkzShUOFbD1DOTnKvQEKuiv1X2ljug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AIvCcID0+9l4lSwnuIiYLDSwSLUDjzb9Rq9H7/ObY838A1Gec8WVn8tRx8plU1svY
	 R7lc2ZRD/HNV+/J+BzIDgncunTD+VGMlW1NeXhz1/pFjc7JFxYJ+l+XYT9j0h6ZQZL
	 dpCBrGoqctelVgvbURRW7XiqKGURlk73shbEFOsy2RkCosYfNoZ4oV+f+hwvY/f/pI
	 6cgP3tyXTGLiT7+0czphwJ9ERGXlk8bf1ebFWBOolP8vKd5YrAUTf4Jca0WGUkfyoW
	 eu8rCt3KLqlpw4c2cCTG4YQ9NkRfQTvNGMXtotCp16oJYiUu+eFl/cYtSufEy1oZ0V
	 ZFjqCy5jZ5AKg==
Message-ID: <6cdba282-24e9-4011-aa7e-30898d031963@kernel.org>
Date: Tue, 23 Jul 2024 12:19:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v4 23/23] mptcp: pm: reduce entries iterations
 on connect
Content-Language: en-GB
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
 <20240722-mptcp-pm-avail-v4-23-15bfd73de384@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240722-mptcp-pm-avail-v4-23-15bfd73de384@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2024 21:36, Matthieu Baerts (NGI0) wrote:
> __mptcp_subflow_connect() is currently called from the path-managers,
> which have all the required information to create subflows. No need to
> call the PM again to re-iterate over the list of entries with RCU lock
> to get more info.
> 
> Instead, it is possible to pass a mptcp_pm_addr_entry structure, instead
> of a mptcp_addr_info one. The former contains the ifindex and the flags
> that are required when creating the new subflow.
> 
> This is a partial revert of commit ee285257a9c1 ("mptcp: drop flags and
> ifindex arguments").
> 
> While at it, the local ID can also be set if it is known and 0, to avoid
> having to set it in the 'rebuild_header' hook, which will cause a new
> iteration of the endpoint entries.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - This patch is for net-next
>  - v4:
>    - Avoid multiple copies of an addr entry in
>      fill_local_addresses_vec().
>    - Rebased on top of "mptcp: fix endpoints with 'signal' and 'subflow'
>      flags", v4.
> ---
>  net/mptcp/pm.c           | 11 -----------
>  net/mptcp/pm_netlink.c   | 48 ++++++++++++------------------------------------
>  net/mptcp/pm_userspace.c | 19 +------------------
>  net/mptcp/protocol.h     | 10 +---------
>  net/mptcp/subflow.c      | 29 ++++++++++++++++++-----------
>  5 files changed, 32 insertions(+), 85 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index ddad51210971..54fabd386b04 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -416,17 +416,6 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  	return mptcp_pm_nl_get_local_id(msk, &skc_local);
>  }
>  
> -int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
> -					 u8 *flags, int *ifindex)
> -{
> -	*flags = 0;
> -	*ifindex = 0;
> -
> -	if (mptcp_pm_is_userspace(msk))
> -		return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
> -	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
> -}
> -
>  int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
>  {
>  	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 45a1aa0a40bf..a316951f8762 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -625,7 +625,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>  
>  		spin_unlock_bh(&msk->pm.lock);
>  		for (i = 0; i < nr; i++)
> -			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
> +			__mptcp_subflow_connect(sk, &local, &addrs[i]);
>  		spin_lock_bh(&msk->pm.lock);
>  	}
>  	mptcp_pm_nl_check_work_pending(msk);
> @@ -646,7 +646,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
>   */
>  static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>  					     struct mptcp_addr_info *remote,
> -					     struct mptcp_addr_info *addrs)
> +					     struct mptcp_pm_addr_entry *entries)
>  {
>  	struct sock *sk = (struct sock *)msk;
>  	struct mptcp_pm_addr_entry *entry;
> @@ -670,14 +670,14 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>  			continue;
>  
>  		if (msk->pm.subflows < subflows_max) {
> -			msk->pm.subflows++;
> -			addrs[i] = entry->addr;
> +			memcpy(&entries[i], entry, sizeof(entries[i]));
>  
>  			/* Special case for ID0: set the correct ID */
>  			if (msk->first &&
>  			    mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
> -				addrs[i].id = 0;
> +				entries[i].addr.id = 0;
>  
> +			msk->pm.subflows++;
>  			i++;
>  		}
>  	}
> @@ -687,21 +687,19 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>  	 * 'IPADDRANY' local address
>  	 */
>  	if (!i) {
> -		struct mptcp_addr_info local;
> -
> -		memset(&local, 0, sizeof(local));
> -		local.family =
> +		memset(&entries[i], 0, sizeof(entries[i]));
> +		entries[i].addr.family =
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  			       remote->family == AF_INET6 &&
>  			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
>  #endif
>  			       remote->family;
>  
> -		if (!mptcp_pm_addr_families_match(sk, &local, remote))
> +		if (!mptcp_pm_addr_families_match(sk, &entries[i].addr, remote))
>  			return 0;
>  
>  		msk->pm.subflows++;
> -		addrs[i++] = local;
> +		i++;
>  	}
>  
>  	return i;
> @@ -709,7 +707,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>  
>  static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  {
> -	struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
> +	struct mptcp_pm_addr_entry entries[MPTCP_PM_ADDR_MAX];
>  	struct sock *sk = (struct sock *)msk;
>  	unsigned int add_addr_accept_max;
>  	struct mptcp_addr_info remote;
> @@ -738,13 +736,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  	/* connect to the specified remote address, using whatever
>  	 * local address the routing configuration will pick.
>  	 */
> -	nr = fill_local_addresses_vec(msk, &remote, addrs);
> +	nr = fill_local_addresses_vec(msk, &remote, entries);
>  	if (nr == 0)
>  		return;
>  
>  	spin_unlock_bh(&msk->pm.lock);
>  	for (i = 0; i < nr; i++)
> -		if (__mptcp_subflow_connect(sk, &addrs[i], &remote) == 0)
> +		if (__mptcp_subflow_connect(sk, &entries[i], &remote) == 0)
>  			sf_created = true;
>  	spin_lock_bh(&msk->pm.lock);
>  
> @@ -1395,28 +1393,6 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
>  	return ret;
>  }
>  
> -int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
> -					    u8 *flags, int *ifindex)
> -{
> -	struct mptcp_pm_addr_entry *entry;
> -	struct sock *sk = (struct sock *)msk;
> -	struct net *net = sock_net(sk);
> -
> -	/* No entries with ID 0 */
> -	if (id == 0)
> -		return 0;
> -
> -	rcu_read_lock();
> -	entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
> -	if (entry) {
> -		*flags = entry->flags;
> -		*ifindex = entry->ifindex;
> -	}
> -	rcu_read_unlock();
> -
> -	return 0;
> -}
> -
>  static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
>  				      const struct mptcp_addr_info *addr)
>  {
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index f0a4590506c6..97b09dffff6d 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -119,23 +119,6 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
>  	return NULL;
>  }
>  
> -int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> -						   unsigned int id,
> -						   u8 *flags, int *ifindex)
> -{
> -	struct mptcp_pm_addr_entry *match;
> -
> -	spin_lock_bh(&msk->pm.lock);
> -	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
> -	spin_unlock_bh(&msk->pm.lock);
> -	if (match) {
> -		*flags = match->flags;
> -		*ifindex = match->ifindex;
> -	}
> -
> -	return 0;
> -}
> -
>  int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
>  				    struct mptcp_addr_info *skc)
>  {
> @@ -394,7 +377,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	lock_sock(sk);
>  
> -	err = __mptcp_subflow_connect(sk, &local.addr, &addr_r);
> +	err = __mptcp_subflow_connect(sk, &local, &addr_r);
>  
>  	release_sock(sk);
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f2eb5273d752..259e247b0862 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -722,7 +722,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
>  void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
>  
>  /* called with sk socket lock held */
> -int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> +int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_entry *local,
>  			    const struct mptcp_addr_info *remote);
>  int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
>  				struct socket **new_sock);
> @@ -1015,14 +1015,6 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>  struct mptcp_pm_add_entry *
>  mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
>  				const struct mptcp_addr_info *addr);
> -int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> -					 unsigned int id,
> -					 u8 *flags, int *ifindex);
> -int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
> -					    u8 *flags, int *ifindex);
> -int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
> -						   unsigned int id,
> -						   u8 *flags, int *ifindex);
>  int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
>  int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
>  int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 39e2cbdf3801..0835e71118b9 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1544,26 +1544,24 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
>  #endif
>  }
>  
> -int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> +int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_entry *local,
>  			    const struct mptcp_addr_info *remote)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct mptcp_subflow_context *subflow;
> +	int local_id = local->addr.id;
>  	struct sockaddr_storage addr;
>  	int remote_id = remote->id;
> -	int local_id = loc->id;
>  	int err = -ENOTCONN;
>  	struct socket *sf;
>  	struct sock *ssk;
>  	u32 remote_token;
>  	int addrlen;
> -	int ifindex;
> -	u8 flags;
>  
>  	if (!mptcp_is_fully_established(sk))
>  		goto err_out;
>  
> -	err = mptcp_subflow_create_socket(sk, loc->family, &sf);
> +	err = mptcp_subflow_create_socket(sk, local->addr.family, &sf);
>  	if (err)
>  		goto err_out;
>  
> @@ -1573,23 +1571,32 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>  		get_random_bytes(&subflow->local_nonce, sizeof(u32));
>  	} while (!subflow->local_nonce);
>  
> -	if (local_id)
> +	/* if 'IPADDRANY', the ID will be set later, after the routing */
> +	if (local->addr.family == AF_INET) {
> +		if (!local->addr.addr.s_addr)
> +			local_id = -1;
> +#if IS_ENABLED(CONFIG_IPV6)

As reported by kbot, it should be

-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)

I will not send a v5 just for that, I think there are already enough
versions and the series became too large :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

