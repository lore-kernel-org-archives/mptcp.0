Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485DE146A64
	for <mptcp@lists.linux.dev>; Tue, 25 Jun 2024 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357375; cv=none; b=ePOxQ9Xuy1wLXA9/r9VfVaNpi7Xe9dfagMVrj1e/FVL1ASQgbI6kmV1xDhnXLe0a0GIK8XLVwPdiVlAMXo8kTx1vIKGEmQyMseAyf7MQ7M6Vjlam5F5f7/97OhW/POMJZpNxkxkrrAifXnLr64rw3sg5vZZX9u1EzZyeqqGzq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357375; c=relaxed/simple;
	bh=qzA9W3Nb1tSapIJl03b1vzBE5U7aSEY7MQUBjTfslKM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jgMg9LZhGJhu/XrFYWIv1FxvJD3bikCzVGBDBX13dmvGJoNoQazwb7lwTodUgAgZTVsITTeJVFSGE5r779rCwoDiAybo/77cLjlPELXwd0RxgHk9O9ClmaLRxTLJftT/bZyw4hAQi3fiSp/tDg8XYD73z1JTpjwHm+7isEoeqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPUWqbI7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPUWqbI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F3FC32781;
	Tue, 25 Jun 2024 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719357374;
	bh=qzA9W3Nb1tSapIJl03b1vzBE5U7aSEY7MQUBjTfslKM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kPUWqbI7HoKtFLQtLUiBPSoi4VZe/HqSUUa8Roct9oPHyLv3g3Df9jOqubpWN68QM
	 0+Vsjjhl/s4j3IgwLtLRdtgvVk8s0ekXBXicY9sAp90CrDqd06uvIjBVoUwS4XkA6h
	 YMxcHNW3lWumbfqxyZMgwehmC1rOv7xQxyCYDoD9Q5skmfAFOSE5cpqLwbtmvMqdyR
	 Ku/2FslrLEjghPhBt6WgX6/o3YihpWOetBAw4sc4nZdsC9ANijh2FijAHmbgzuGR0S
	 oP1QJYhOrdNDhvWY/ais3f3kYn2gvYrf6JvKJdbN68QXT/XyT7FnDtJSvtMGFt6tnm
	 IQzVzIbA9wi7Q==
Date: Tue, 25 Jun 2024 16:16:14 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next 2/4] mptcp: split id_avail_bitmap per target
In-Reply-To: <20240621-mptcp-pm-avail-v1-2-b692d5eb89b5@kernel.org>
Message-ID: <e1d59bcb-3baa-c432-31ab-139428ef7cde@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org> <20240621-mptcp-pm-avail-v1-2-b692d5eb89b5@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 21 Jun 2024, Matthieu Baerts (NGI0) wrote:

> Up to the 'Fixes' commit, having an endpoint with both the 'signal' and
> 'subflow' flags, resulted in the creation of a subflow and an address
> announcement using the address linked to this endpoint. After this
> commit, only the address announcement was done, ignoring the 'subflow'
> flag.
>
> That's because the same bitmap was used for the two flags. It is easy to
> split it in two: one for 'signal', and one for 'subflow'.
>
> It is unusual to set the two flags together: creating a new subflow
> using a new local address will implicitly advertise it to the other
> peer. So in theory, no need to advertise it explicitly as well. Maybe
> there are use-cases -- the subflow might not reach the other peer that
> way, we can ask the other peer to try initiating the new subflow without
> delay -- or very likely the user is confused, and put both flags "just
> to be sure at least the right one is set". Still, the kernel should do
> what has been asked: using this endpoint to announce the address and to
> create a new subflow from it.
>
> An alternative is to forbid the use of the two flags together, but
> that's probably too late, and there are maybe use-cases. This patch will
> avoid people complaining subflows are not created using the endpoint
> they added with the 'subflow' and 'signal' flag.
>
> Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/pm.c         |  3 ++-
> net/mptcp/pm_netlink.c | 20 ++++++++++++--------
> net/mptcp/protocol.h   |  5 +++--
> 3 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 55406720c607..d29fb35bb927 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -543,7 +543,8 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
> 	WRITE_ONCE(pm->addr_signal, 0);
> 	WRITE_ONCE(pm->remote_deny_join_id0, false);
> 	pm->status = 0;
> -	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> +	bitmap_fill(msk->pm.id_avail_signals_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> +	bitmap_fill(msk->pm.id_avail_subflows_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> }
>
> void mptcp_pm_data_init(struct mptcp_sock *msk)
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ea9e5817b9e9..4805452d05a2 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -156,7 +156,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
> 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
> 			continue;
>
> -		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
> +		if (!test_bit(entry->addr.id, msk->pm.id_avail_subflows_bitmap))
> 			continue;
>
> 		ret = entry;
> @@ -178,10 +178,10 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
> 	 * can lead to additional addresses not being announced.
> 	 */
> 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> -		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
> +		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> 			continue;
>
> -		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
> +		if (!test_bit(entry->addr.id, msk->pm.id_avail_signals_bitmap))
> 			continue;
>
> 		ret = entry;
> @@ -228,7 +228,9 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
> 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
>
> 	if (msk->pm.subflows == mptcp_pm_get_subflows_max(msk) ||
> -	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
> +	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_signals_bitmap,
> +			       MPTCP_PM_MAX_ADDR_ID + 1, 0) == MPTCP_PM_MAX_ADDR_ID + 1) ||
> +	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_subflows_bitmap,
> 			       MPTCP_PM_MAX_ADDR_ID + 1, 0) == MPTCP_PM_MAX_ADDR_ID + 1)) {
> 		WRITE_ONCE(msk->pm.work_pending, false);
> 		return false;
> @@ -537,7 +539,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> 		rcu_read_lock();
> 		entry = __lookup_addr(pernet, &mpc_addr);
> 		if (entry) {
> -			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
> +			__clear_bit(entry->addr.id, msk->pm.id_avail_signals_bitmap);
> +			__clear_bit(entry->addr.id, msk->pm.id_avail_subflows_bitmap);
> 			msk->mpc_endpoint_id = entry->addr.id;
> 			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
> 		}
> @@ -570,7 +573,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>
> 		if (local) {
> 			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
> -				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> +				__clear_bit(local->addr.id, msk->pm.id_avail_signals_bitmap);

Hi Matthieu -

I don't see anywhere that __set_bit(id, msk->pm.id_avail_signals_bitmap) 
is ever called, so it looks like once an id is announced it is never 
available to announce again.

I think it would work to set that bit whenever an announce list entry is 
removed using remove_anno_list_by_saddr()? The idea would be to keep 
id_avail_signals_bitmap consistent with the anno_list, and 
id_avail_subflows_bitmap consistent with the connected subflows.

- Mat

> 				msk->pm.add_addr_signaled++;
> 				mptcp_pm_announce_addr(msk, &local->addr, false);
> 				mptcp_pm_nl_addr_send_ack(msk);
> @@ -592,7 +595,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
>
> 		msk->pm.local_addr_used++;
> -		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> +		__clear_bit(local->addr.id, msk->pm.id_avail_subflows_bitmap);
> 		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
> 		if (nr == 0)
> 			continue;
> @@ -822,7 +825,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
> 		}
> 		if (rm_type == MPTCP_MIB_RMSUBFLOW)
> -			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
> +			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id,
> +				  msk->pm.id_avail_subflows_bitmap);
> 		else if (rm_type == MPTCP_MIB_RMADDR)
> 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
> 		if (!removed)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 19d60b6d5b45..cbb430108823 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -187,7 +187,7 @@ enum mptcp_pm_status {
> 	MPTCP_PM_SUBFLOW_ESTABLISHED,
> 	MPTCP_PM_ALREADY_ESTABLISHED,	/* persistent status, set after ESTABLISHED event */
> 	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED /* persistent status, set after MPC local address is
> -					 * accounted int id_avail_bitmap
> +					 * accounted in id_avail_*_bitmap
> 					 */
> };
>
> @@ -231,7 +231,8 @@ struct mptcp_pm_data {
> 	u8		pm_type;
> 	u8		subflows;
> 	u8		status;
> -	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> +	DECLARE_BITMAP(id_avail_signals_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> +	DECLARE_BITMAP(id_avail_subflows_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> 	struct mptcp_rm_list rm_list_tx;
> 	struct mptcp_rm_list rm_list_rx;
> };
>
> -- 
> 2.43.0
>
>
>
