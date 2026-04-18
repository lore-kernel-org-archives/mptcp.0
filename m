Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F622B8C5
	for <mptcp@lists.linux.dev>; Sat, 18 Apr 2026 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536839; cv=none; b=Eel1H3ecFuVopl9wKCl46mX/nSvuDZT3gMkpMipzWv1AxXwbCXGhne4fmI0/WIpvaAFXTZyYgUFdO/cNpinOHtikoXktHtMB4GOrkb0BU24C5ZG7Y9tWFT0kgJgzqjEb2xevwmWd2dTJ7gjAyH12ypPI6WIiJuBAOT97mu9gtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536839; c=relaxed/simple;
	bh=B8DiPoeAGWzAK0hSQJ3JvrAnc9TaCfLoD8WPgQpf13k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dS/TONs5kbYFNM1HxV4x1Q1yzDWcQ1z6VYX5DoGyFg7xExQOuwdyhxMuh6XxxsXNped//HQh7Dw8B2mMh8eDVzkUJx2YJrRIJLVC8iQNXK+gTRAoa793zX6v1HVSvYgNVXRbkd77y1cR4XBc96veRpI+sDCeiEvxMINRHX6Rvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYHfU5n9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYHfU5n9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF974C19424;
	Sat, 18 Apr 2026 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776536838;
	bh=B8DiPoeAGWzAK0hSQJ3JvrAnc9TaCfLoD8WPgQpf13k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oYHfU5n96NS7Bax3XpcuYk/weyG5NjWbwJ7KB1GNEB8qHk0g0ksLafSNKj3X439cQ
	 sxZ6CKngJ77EpJ5i7MWNgKjyodX6Up2MBoNjXVVypAo8hncSi7izznQr7CgJgRegFA
	 tDsu/3HkKJ3lmJGkCrjnjYWUeH6GbiXVZFn0eelUMc5jtmhQWbbZmPM922q7VYa49d
	 1fpkWrVpl8a1lfAvzNW3LD1jzkB6eDgMa7DEAduvtodIAX5vLsovG7XX4IO1jKk94Q
	 Ig7DQvEbo0ze/uoZPAABPdn4QtATlJ2JHctP/JaySP72Gj9wkSgs88ljLnt+1ZACAE
	 SQRf7oG1ei7YA==
Date: Sat, 18 Apr 2026 11:27:18 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v5 20/20] mptcp: pm: clearer ADD_ADDR related
 helpers names
In-Reply-To: <20260415-mptcp-inc-limits-v5-20-e54c3bf80e4e@kernel.org>
Message-ID: <3919ba71-1f12-cd8e-2674-9e49dbcd8285@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org> <20260415-mptcp-inc-limits-v5-20-e54c3bf80e4e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 15 Apr 2026, Matthieu Baerts (NGI0) wrote:

> Here is a suggestion, and if it is OK, I will split this in multiple
> commits: it is not the first time the 'add' and 'anno' names to describe
> ADD_ADDR related functions are confusing. Eric already pointed that in
> [1].
>
> I started by renaming only the internal helper names, then while at it,
> I tried to uniform everything linked to ADD_ADDR.
>
> WDYT?
>

I do think the new names are clearer, but for stable backports the renames 
might create a lot more work in the future. I slightly lean towards "leave 
as is" but it's not a strong opinion :)

- Mat

> Link: https://lore.kernel.org/20251117100745.1913963-1-edumazet@google.com [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/options.c      |   2 +-
> net/mptcp/pm.c           | 131 ++++++++++++++++++++++++-----------------------
> net/mptcp/pm_kernel.c    |  20 ++++----
> net/mptcp/pm_userspace.c |   6 +--
> net/mptcp/protocol.h     |  19 +++----
> net/mptcp/subflow.c      |   4 +-
> 6 files changed, 92 insertions(+), 90 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4cc583fdc7a9..8282e666167d 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1211,7 +1211,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
> 			} else {
> 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
> -				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
> +				mptcp_pm_add_addr_del_timer(msk, &mp_opt.addr, true);
> 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
> 			}
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 0bbb6054f0b1..3d6389c5fd5e 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -12,12 +12,12 @@
>
> #define ADD_ADDR_RETRANS_MAX	3
>
> -struct mptcp_pm_add_entry {
> +struct mptcp_pm_add_addr {
> 	struct list_head	list;
> 	struct mptcp_addr_info	addr;
> 	u8			retrans_times;
> 	bool			timer_done;
> -	struct timer_list	add_timer;
> +	struct timer_list	timer;
> 	struct mptcp_sock	*sock;
> 	struct rcu_head		rcu;
> };
> @@ -115,14 +115,14 @@ static bool mptcp_pm_is_init_remote_addr(struct mptcp_sock *msk,
> 	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
> }
>
> -bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
> -				   const struct mptcp_addr_info *saddr)
> +bool mptcp_pm_subflow_lookup_by_saddr(struct mptcp_sock *msk,
> +				      const struct mptcp_addr_info *saddr)
> {
> 	struct mptcp_subflow_context *subflow;
> 	struct mptcp_addr_info cur;
> 	struct sock_common *skc;
>
> -	list_for_each_entry(subflow, list, node) {
> +	mptcp_for_each_subflow(msk, subflow) {
> 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
>
> 		mptcp_local_address(skc, &cur);
> @@ -133,38 +133,39 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
> 	return false;
> }
>
> -static struct mptcp_pm_add_entry *
> -mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
> -				const struct mptcp_addr_info *addr)
> +static struct mptcp_pm_add_addr *
> +mptcp_pm_add_addr_lookup_by_addr(const struct mptcp_sock *msk,
> +				 const struct mptcp_addr_info *addr)
> {
> -	struct mptcp_pm_add_entry *entry;
> +	struct mptcp_pm_add_addr *add_addr;
>
> 	lockdep_assert_held(&msk->pm.lock);
>
> -	list_for_each_entry(entry, &msk->pm.anno_list, list) {
> -		if (mptcp_addresses_equal(&entry->addr, addr, true))
> -			return entry;
> +	list_for_each_entry(add_addr, &msk->pm.anno_list, list) {
> +		if (mptcp_addresses_equal(&add_addr->addr, addr, true))
> +			return add_addr;
> 	}
>
> 	return NULL;
> }
>
> -bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
> -				     const struct mptcp_addr_info *addr)
> +bool mptcp_pm_add_addr_remove(struct mptcp_sock *msk,
> +			      const struct mptcp_addr_info *addr)
> {
> -	struct mptcp_pm_add_entry *entry;
> +	struct mptcp_pm_add_addr *add_addr;
> 	bool ret;
>
> -	entry = mptcp_pm_del_add_timer(msk, addr, false);
> -	ret = entry;
> -	kfree_rcu(entry, rcu);
> +	add_addr = mptcp_pm_add_addr_del_timer(msk, addr, false);
> +	ret = add_addr;
> +	kfree_rcu(add_addr, rcu);
>
> 	return ret;
> }
>
> -bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
> +bool mptcp_pm_add_addr_lookup_by_sk(struct mptcp_sock *msk,
> +				    const struct sock *sk)
> {
> -	struct mptcp_pm_add_entry *entry;
> +	struct mptcp_pm_add_addr *entry;
> 	struct mptcp_addr_info saddr;
> 	bool ret = false;
>
> @@ -335,11 +336,11 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
> 	return max_stale && max_stale < rto ? max_stale : rto;
> }
>
> -static void mptcp_pm_add_timer(struct timer_list *timer)
> +static void mptcp_pm_add_addr_timer(struct timer_list *timer)
> {
> -	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
> -							      add_timer);
> -	struct mptcp_sock *msk = entry->sock;
> +	struct mptcp_pm_add_addr *add_addr = timer_container_of(add_addr, timer,
> +								timer);
> +	struct mptcp_sock *msk = add_addr->sock;
> 	struct sock *sk = (struct sock *)msk;
> 	unsigned int timeout = 0;
>
> @@ -362,20 +363,20 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
> 	spin_lock_bh(&msk->pm.lock);
>
> 	if (!mptcp_pm_should_add_signal_addr(msk)) {
> -		pr_debug("retransmit ADD_ADDR id=%d\n", entry->addr.id);
> -		mptcp_pm_announce_addr(msk, &entry->addr, false);
> +		pr_debug("retransmit ADD_ADDR id=%d\n", add_addr->addr.id);
> +		mptcp_pm_announce_addr(msk, &add_addr->addr, false);
> 		mptcp_pm_add_addr_send_ack(msk);
> -		entry->retrans_times++;
> +		add_addr->retrans_times++;
> 	}
>
> -	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
> -		timeout <<= entry->retrans_times;
> +	if (add_addr->retrans_times < ADD_ADDR_RETRANS_MAX)
> +		timeout <<= add_addr->retrans_times;
> 	else
> 		timeout = 0;
>
> 	spin_unlock_bh(&msk->pm.lock);
>
> -	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
> +	if (add_addr->retrans_times == ADD_ADDR_RETRANS_MAX)
> 		mptcp_pm_subflow_established(msk);
>
> out:
> @@ -383,82 +384,81 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
> 		sk_reset_timer(sk, timer, jiffies + timeout);
> 	else
> 		/* if sock_put calls sk_free: avoid waiting for this timer */
> -		entry->timer_done = true;
> +		add_addr->timer_done = true;
> 	bh_unlock_sock(sk);
> 	sock_put(sk);
> }
>
> -struct mptcp_pm_add_entry *
> -mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> -		       const struct mptcp_addr_info *addr, bool check_id)
> +struct mptcp_pm_add_addr *
> +mptcp_pm_add_addr_del_timer(struct mptcp_sock *msk,
> +			    const struct mptcp_addr_info *addr, bool check_id)
> {
> -	struct mptcp_pm_add_entry *entry;
> +	struct mptcp_pm_add_addr *add_addr;
> 	struct sock *sk = (struct sock *)msk;
> 	bool stop_timer = false;
>
> 	rcu_read_lock();
>
> 	spin_lock_bh(&msk->pm.lock);
> -	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
> -	if (entry && (!check_id || entry->addr.id == addr->id)) {
> -		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
> +	add_addr = mptcp_pm_add_addr_lookup_by_addr(msk, addr);
> +	if (add_addr && (!check_id || add_addr->addr.id == addr->id)) {
> +		add_addr->retrans_times = ADD_ADDR_RETRANS_MAX;
> 		stop_timer = true;
> 	}
> -	if (!check_id && entry)
> -		list_del(&entry->list);
> +	if (!check_id && add_addr)
> +		list_del(&add_addr->list);
> 	spin_unlock_bh(&msk->pm.lock);
>
> 	/* Note: entry might have been removed by another thread.
> 	 * We hold rcu_read_lock() to ensure it is not freed under us.
> 	 */
> 	if (stop_timer)
> -		sk_stop_timer_sync(sk, &entry->add_timer);
> +		sk_stop_timer_sync(sk, &add_addr->timer);
>
> 	rcu_read_unlock();
> -	return entry;
> +	return add_addr;
> }
>
> -bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
> -			      const struct mptcp_addr_info *addr)
> +bool mptcp_pm_add_addr_alloc(struct mptcp_sock *msk,
> +			     const struct mptcp_addr_info *addr)
> {
> -	struct mptcp_pm_add_entry *add_entry = NULL;
> +	struct mptcp_pm_add_addr *add_addr = NULL;
> 	struct sock *sk = (struct sock *)msk;
> 	unsigned int timeout;
>
> 	lockdep_assert_held(&msk->pm.lock);
>
> -	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
> -
> -	if (add_entry) {
> +	add_addr = mptcp_pm_add_addr_lookup_by_addr(msk, addr);
> +	if (add_addr) {
> 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
> 			return false;
>
> 		goto reset_timer;
> 	}
>
> -	add_entry = kmalloc_obj(*add_entry, GFP_ATOMIC);
> -	if (!add_entry)
> +	add_addr = kmalloc_obj(*add_addr, GFP_ATOMIC);
> +	if (!add_addr)
> 		return false;
>
> -	list_add(&add_entry->list, &msk->pm.anno_list);
> +	list_add(&add_addr->list, &msk->pm.anno_list);
>
> -	add_entry->addr = *addr;
> -	add_entry->sock = msk;
> -	add_entry->retrans_times = 0;
> +	add_addr->addr = *addr;
> +	add_addr->sock = msk;
> +	add_addr->retrans_times = 0;
>
> -	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
> +	timer_setup(&add_addr->timer, mptcp_pm_add_addr_timer, 0);
> reset_timer:
> -	add_entry->timer_done = false;
> +	add_addr->timer_done = false;
> 	timeout = mptcp_adjust_add_addr_timeout(msk);
> 	if (timeout)
> -		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
> +		sk_reset_timer(sk, &add_addr->timer, jiffies + timeout);
>
> 	return true;
> }
>
> -static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
> +static void mptcp_pm_free_add_addr_list(struct mptcp_sock *msk)
> {
> -	struct mptcp_pm_add_entry *entry, *tmp;
> +	struct mptcp_pm_add_addr *add_addr, *tmp;
> 	struct sock *sk = (struct sock *)msk;
> 	LIST_HEAD(free_list);
>
> @@ -468,10 +468,10 @@ static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
> 	list_splice_init(&msk->pm.anno_list, &free_list);
> 	spin_unlock_bh(&msk->pm.lock);
>
> -	list_for_each_entry_safe(entry, tmp, &free_list, list) {
> -		if (!entry->timer_done)
> -			sk_stop_timer_sync(sk, &entry->add_timer);
> -		kfree_rcu(entry, rcu);
> +	list_for_each_entry_safe(add_addr, tmp, &free_list, list) {
> +		if (!add_addr->timer_done)
> +			sk_stop_timer_sync(sk, &add_addr->timer);
> +		kfree_rcu(add_addr, rcu);
> 	}
> }
>
> @@ -725,7 +725,8 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
>
> 	spin_lock_bh(&pm->lock);
>
> -	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
> +	if (mptcp_pm_add_addr_lookup_by_addr(msk, addr) &&
> +	    READ_ONCE(pm->work_pending))
> 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
>
> 	spin_unlock_bh(&pm->lock);
> @@ -1094,7 +1095,7 @@ static void mptcp_pm_ops_release(struct mptcp_sock *msk)
>
> void mptcp_pm_destroy(struct mptcp_sock *msk)
> {
> -	mptcp_pm_free_anno_list(msk);
> +	mptcp_pm_free_add_addr_list(msk);
> 	mptcp_pm_ops_release(msk);
> }
>
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index c75a2c29bcf2..174a760e7a23 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -374,7 +374,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> 		/* If the alloc fails, we are on memory pressure, not worth
> 		 * continuing, and trying to create subflows.
> 		 */
> -		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
> +		if (!mptcp_pm_add_addr_alloc(msk, &local.addr))
> 			return;
>
> 		__clear_bit(endp_id, msk->pm.id_avail_bitmap);
> @@ -1054,16 +1054,16 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
> 	return ret;
> }
>
> -static void mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
> -				      const struct mptcp_addr_info *addr,
> -				      bool force)
> +static void mptcp_pm_remove_add_addr(struct mptcp_sock *msk,
> +				     const struct mptcp_addr_info *addr,
> +				     bool force)
> {
> 	struct mptcp_rm_list list = { .nr = 0 };
> 	bool announced;
>
> 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
>
> -	announced = mptcp_remove_anno_list_by_saddr(msk, addr);
> +	announced = mptcp_pm_add_addr_remove(msk, addr);
> 	if (announced || force) {
> 		spin_lock_bh(&msk->pm.lock);
> 		if (announced)
> @@ -1099,9 +1099,9 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
> 			goto next;
>
> 		lock_sock(sk);
> -		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
> -		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
> -					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
> +		remove_subflow = mptcp_pm_subflow_lookup_by_saddr(msk, addr);
> +		mptcp_pm_remove_add_addr(msk, addr, remove_subflow &&
> +					 !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
>
> 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
>
> @@ -1237,10 +1237,10 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
>
> 	entry = list_prepare_entry(entry, rm_list, list);
> 	list_for_each_entry_continue(entry, rm_list, list) {
> -		if (mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
> +		if (mptcp_pm_subflow_lookup_by_saddr(msk, &entry->addr))
> 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
>
> -		if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
> +		if (mptcp_pm_add_addr_remove(msk, &entry->addr))
> 			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
>
> 		if (slist.nr == MPTCP_RM_IDS_MAX ||
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index d838e8ea65fd..704154de85ca 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -228,7 +228,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
> 	lock_sock(sk);
> 	spin_lock_bh(&msk->pm.lock);
>
> -	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
> +	if (mptcp_pm_add_addr_alloc(msk, &addr_val.addr)) {
> 		msk->pm.add_addr_signaled++;
> 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
> 		mptcp_pm_addr_send_ack(msk);
> @@ -281,9 +281,9 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
> 	int anno_nr = 0;
>
> 	/* only delete if either announced or matching a subflow */
> -	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
> +	if (mptcp_pm_add_addr_remove(msk, &entry->addr))
> 		anno_nr++;
> -	else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
> +	else if (!mptcp_pm_subflow_lookup_by_saddr(msk, &entry->addr))
> 		return;
>
> 	alist.ids[alist.nr++] = entry->addr.id;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 661600f8b573..8ad60edf3419 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1132,16 +1132,17 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
> 			      struct mptcp_addr_info *addr,
> 			      struct mptcp_addr_info *rem,
> 			      u8 bkup);
> -bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
> +bool mptcp_pm_add_addr_alloc(struct mptcp_sock *msk,
> +			     const struct mptcp_addr_info *addr);
> +struct mptcp_pm_add_addr *
> +mptcp_pm_add_addr_del_timer(struct mptcp_sock *msk,
> +			    const struct mptcp_addr_info *addr, bool check_id);
> +bool mptcp_pm_add_addr_remove(struct mptcp_sock *msk,
> 			      const struct mptcp_addr_info *addr);
> -bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
> -struct mptcp_pm_add_entry *
> -mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> -		       const struct mptcp_addr_info *addr, bool check_id);
> -bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
> -				   const struct mptcp_addr_info *saddr);
> -bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
> -				     const struct mptcp_addr_info *addr);
> +bool mptcp_pm_add_addr_lookup_by_sk(struct mptcp_sock *msk,
> +				    const struct sock *sk);
> +bool mptcp_pm_subflow_lookup_by_saddr(struct mptcp_sock *msk,
> +				      const struct mptcp_addr_info *saddr);
> int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
> 			  struct genl_info *info);
> int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e2cb9d23e4a0..836dcdc3a620 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -235,7 +235,7 @@ static int subflow_check_req(struct request_sock *req,
> 			pr_debug("syn inet_sport=%d %d\n",
> 				 ntohs(inet_sk(sk_listener)->inet_sport),
> 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
> -			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
> +			if (!mptcp_pm_add_addr_lookup_by_sk(subflow_req->msk, sk_listener)) {
> 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
> 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
> 				return -EPERM;
> @@ -926,7 +926,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 				pr_debug("ack inet_sport=%d %d\n",
> 					 ntohs(inet_sk(sk)->inet_sport),
> 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
> -				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
> +				if (!mptcp_pm_add_addr_lookup_by_sk(owner, sk)) {
> 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
> 					subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
> 					goto dispose_child;
>
> -- 
> 2.53.0
>
>
>
