Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D8189
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014303; cv=none; b=U+gkCWJqwhIChyFu64ZTsEEOGg0no3fgLXL/dctPzTAdcx0T4DXzvpRC10aEt7OjJ04qRh/eLioMX84dMpfm37X5+w/ftuwchnd4L3gAXxABufXdw6dhStzwSaXWaKVbMWYMCXzjX4j3k347zBW/y5woZvDprnytK3vHgyGZCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014303; c=relaxed/simple;
	bh=RWHkE4IlV6jfTU5wxbUOQvAZXsWbbDB1HNXNaXqe2Cg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2ZMfMyCofiPHOFRG+fdZGZ14vszwpYHRd3ynC41/SZqntYE+lLokcbljD6KAryTbDMs0knRbg+gU9vqL9APor4HRgyegyMlQ8O+Wmeaf2SYO3blTSuOTquiloz0l7Wlvj4sFRWkJZiuDNwkBRVqJTkcCiWetRCEiQcXOovHKVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTBaUTkW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTBaUTkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AEEC4CEEB;
	Tue, 16 Sep 2025 09:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758014302;
	bh=RWHkE4IlV6jfTU5wxbUOQvAZXsWbbDB1HNXNaXqe2Cg=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=JTBaUTkWz7B7bW8ewyqAchbsr4U7EalJ5qCcKV7C6lOmZlPFt2MfPJ2T/8etuYeUR
	 R8lKrkCK2ZSf5m4Sga58Ik3PXK320t+F/n0XcSHs83sXAYbAvjbcunGOcz40HJc/h4
	 OlA2/UbhJN1tXSOjI1YE9rvwZPdQ+GMSzw9zKCSFJyzY/28gme3vLTf6P9uIa4GVKr
	 cj5cIbDF/emntnwq5QYkL1bGxvFU/wB5jU/soxVnKk2Vu++qdlSjoSoqZiiV7i6BTz
	 hpQCHj6G+Nr6oAKtCDJqW4KXd+ii4mmVVVu3yweI47gQSAgzw286d9MxYcITzS0gfP
	 ODrAa8QKEAR8g==
Message-ID: <7a28297cc4739cba02ee0ea1ba265e8d1b080b68.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 1/2] mptcp: pm: in-kernel: usable client side
 with C-flag
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Tue, 16 Sep 2025 17:18:18 +0800
In-Reply-To: <20250915-pm-c-flag-client-default-v1-1-6bb241e4d991@kernel.org>
References: <20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org>
	 <20250915-pm-c-flag-client-default-v1-1-6bb241e4d991@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this set. I have some comments below.

On Mon, 2025-09-15 at 20:11 +0200, Matthieu Baerts (NGI0) wrote:
> When servers set the C-flag in their MP_CAPABLE to tell clients not
> to
> create subflows to the initial address and port, clients will likely
> not
> use their other endpoints. That's because the in-kernel path-manager
> uses the 'subflow' endpoints to create subflows only to the initial
> address and port.
> 
> If the limits have not been modified to accept ADD_ADDR, the client
> doesn't try to establish new subflows. If the limits accept ADD_ADDR,
> the routing routes will be used to select the source IP.
> 
> The C-flag is typically set when the server is operating behind a
> legacy
> Layer 4 load balancer, or using anycast IP address. Clients having
> their
> different 'subflow' endpoints setup, don't end up creating multiple
> subflows as expected, and causing some deployment issues.
> 
> A special case is then added here: when servers set the C-flag in the
> MPC and directly sends an ADD_ADDR, this single ADD_ADDR is accepted.
> The 'subflows' endpoints will then be used with this new remote IP
> and
> port. This exception is only allowed when the ADD_ADDR is sent
> immediately after the 3WHS, and makes the client switching to the
> 'fully
> established' mode. After that, 'select_local_address()' will not be
> able
> to find any subflows, because 'id_avail_bitmap' will be filled in
> mptcp_pm_create_subflow_or_signal_addr(), when switching to 'fully
> established' mode.
> 
> Fixes: df377be38725 ("mptcp: add deny_join_id0 in
> mptcp_options_received")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/536
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
> - I tried to find a simple solution that can hopefully be backported
> to
>   cover the 'CDN' use-case.
> - I tried to find a solution respecting the 'accepted add addr'
> limit,
>   but I don't see how to... That's why here I limit the exception a
>   maximum: when this limit is 0 (default case), only the first
> ADD_ADDR,
>   etc. Feel free to share what you think about that.
> - I have some additional code doing some cleanup, and I started to
> look
>   at #503, which is a bit linked to that.
> ---
>  net/mptcp/pm.c        |  7 +++++--
>  net/mptcp/pm_kernel.c | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index
> 02dfb379417e2843301f121039ec0d370b040ef7..fda8d1880224dedbbfb20954f93
> a04da435346df 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -637,9 +637,12 @@ void mptcp_pm_add_addr_received(const struct
> sock *ssk,
>  		} else {
>  			__MPTCP_INC_STATS(sock_net((struct sock
> *)msk), MPTCP_MIB_ADDADDRDROP);
>  		}
> -	/* id0 should not have a different address */
> +	/* id0 should not have a different address ; special case
> for C-flag */
>  	} else if ((addr->id == 0 &&
> !mptcp_pm_is_init_remote_addr(msk, addr)) ||
> -		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
> +		   (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
> +		    (!READ_ONCE(msk->pm.remote_deny_join_id0) ||
> +		     msk->pm.local_addr_used != 0 ||
> +		     mptcp_pm_get_add_addr_accept_max(msk) != 0))) {

I think we can define an mptcp_pm_deny_join_id0(struct mptcp_sock *msk)
helper, then use !mptcp_pm_deny_join_id0(msk) here, and use
mptcp_pm_deny_join_id0(msk) in fill_local_addresses_vec().

For example:

static inline bool mptcp_pm_deny_join_id0(struct mptcp_sock *msk)
{
       return (READ_ONCE(msk->pm.remote_deny_join_id0) &&
               msk->pm.local_addr_used == 0 &&
               mptcp_pm_get_add_addr_accept_max(msk) == 0);
}

>  		mptcp_pm_announce_addr(msk, addr, true);
>  		mptcp_pm_add_addr_send_ack(msk);
>  	} else if (mptcp_pm_schedule_work(msk,
> MPTCP_PM_ADD_ADDR_RECEIVED)) {
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index
> f30df8e884a0b3de9fb092e5774cafe08f6350ce..408801e20ed6e874b80ccbf38af
> 76abc13615a3a 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -389,10 +389,15 @@ static unsigned int
> fill_local_addresses_vec(struct mptcp_sock *msk,
>  	struct mptcp_addr_info mpc_addr;
>  	struct pm_nl_pernet *pernet;
>  	unsigned int subflows_max;
> +	bool deny_join_id0;
>  	int i = 0;
>  
>  	pernet = pm_nl_get_pernet_from_msk(msk);
>  	subflows_max = mptcp_pm_get_subflows_max(msk);
> +	deny_join_id0 = remote->id && READ_ONCE(msk-
> >pm.remote_deny_join_id0) &&
> +			!READ_ONCE(msk->pm.accept_addr) &&
> +			msk->pm.local_addr_used == 0 &&
> +			mptcp_pm_get_add_addr_accept_max(msk) == 0;

I think it's unnecessary to check msk->pm.accept_addr again here, as it
has already been verified in mptcp_pm_add_addr_received, which should
be sufficient:

deny_join_id0 = remote->id && mptcp_pm_deny_join_id0(msk);

>  
>  	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
>  
> @@ -409,6 +414,9 @@ static unsigned int
> fill_local_addresses_vec(struct mptcp_sock *msk,
>  			locals[i].flags = entry->flags;
>  			locals[i].ifindex = entry->ifindex;
>  
> +			if (deny_join_id0)
> +				__clear_bit(locals[i].addr.id, msk-
> >pm.id_avail_bitmap);
> +
>  			/* Special case for ID0: set the correct ID
> */
>  			if (mptcp_addresses_equal(&locals[i].addr,
> &mpc_addr, locals[i].addr.port))
>  				locals[i].addr.id = 0;
> @@ -419,6 +427,37 @@ static unsigned int
> fill_local_addresses_vec(struct mptcp_sock *msk,
>  	}
>  	rcu_read_unlock();
>  
> +	/* Special case: peer sets the C flag, accept one ADD_ADDR
> if default
> +	 * limits are used -- accepting no ADD_ADDR -- and use
> subflow endpoints
> +	 */
> +	if (!i && deny_join_id0) {
> +		unsigned int local_addr_max =
> mptcp_pm_get_local_addr_max(msk);

How about moving this line to after

	subflows_max = mptcp_pm_get_subflows_max(msk);?

They are similar and can be grouped together.

> +
> +		while (msk->pm.local_addr_used < local_addr_max &&
> +		       msk->pm.subflows < subflows_max) {
> +			struct mptcp_pm_local *local = &locals[i];
> +
> +			if (!select_local_address(pernet, msk,
> local))
> +				break;
> +
> +			__clear_bit(local->addr.id, msk-
> >pm.id_avail_bitmap);
> +
> +			if (!mptcp_pm_addr_families_match(sk,
> &local->addr,
> +							  remote))
> +				continue;
> +
> +			if (mptcp_addresses_equal(&local->addr,
> &mpc_addr,
> +						  local->addr.port))
> +				continue;
> +
> +			msk->pm.local_addr_used++;
> +			msk->pm.subflows++;
> +			i++;
> +		}
> +
> +		return i;

Here, we can avoid using a return statement to allow the subsequent
array empty check to proceed.

> +	}
> +
>  	/* If the array is empty, fill in the single
>  	 * 'IPADDRANY' local address
>  	 */
