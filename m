Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CBE23B62B
	for <mptcp@lists.linux.dev>; Tue, 14 Oct 2025 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426415; cv=none; b=ZNoTZrMFfsWxAcT7UNUISAQQaCwRDorMz0X861nCXsG1Ka+78gR9Ibmne7bl1JV72U+tHYr4tTYFoEY0DitBCg1HwxSV/KONNh/QbRLjheFL7dNowUyOWCR17T6ic9HsEFnciRmIE2SyNsx0oWaqmRIEZxmv6+YNaZl0uU8HFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426415; c=relaxed/simple;
	bh=uz7lRyP8OXTlhQpQ86ExRYfb0YTgvM/w/VUQsP/QiAA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZFKQYR3zZmr5uuFiwYrFsAFoLk6R9dSiCadVzGwkZFp4AQzAZw6kmwZbdyWonWElteQ7SHcUU8DXeVkWjqCnd8Nl588O0Ux3Q9Th+vt6X8sd/2RSv2BspG7AU2AHx9jGUYqzXA0JEGG796wmn91iMGmAKxCRBSpXlx2i8aAs2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKsiOtFX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKsiOtFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D4AC4CEF9;
	Tue, 14 Oct 2025 07:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760426411;
	bh=uz7lRyP8OXTlhQpQ86ExRYfb0YTgvM/w/VUQsP/QiAA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=YKsiOtFXl52VDiSkm+JcPUWPE98s6EraEhjMCEkhRTrmFb8GN/VjpYXenguIl67Ss
	 Mnyr/0BKBuvllfDmEvxkbbc7k5QucPnsvZzvNSFyJc5F6kO0faqg42WXe8Sj+SnYRW
	 i8Il+miNw4o3X6f8sJSoJWgGvCHV5lwparfzzN2/07KzAm0+jRW0y1biOgzkYMt8IG
	 sIpf6dvojX/RTi83+zBcKryhHLpKttIP1HGsI4eW5d3bmQnauK4MLnRSOJcLeGqfIE
	 6d3bcYBIDfip4F7ze2Bt5agJJ5I9Y8rn73exPd3QXtHb9uWY02OH3ROg1B4fMZED0W
	 fN9SL4gL+QAWA==
Message-ID: <e7340af8302a2dc98c41580423c0663954db8523.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 6/7] mptcp: pm: in-kernel: record fullmesh
 endp nb
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Tue, 14 Oct 2025 15:20:08 +0800
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-6-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
	 <20251008-c-flag-add-addr-delay-v1-6-c624eb3bf10d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this patch.

On Wed, 2025-10-08 at 16:00 +0200, Matthieu Baerts (NGI0) wrote:
> Instead of iterating over all endpoints, under RCU read lock, just to
> check if one of them as the fullmesh flag, we can keep a counter of
> fullmesh endpoint, similar to what is done with the other flags.
> 
> This counter is now checked, before iterating over all endpoints.
> 
> Similar to the other counters, this new one is also exposed. A
> userspace
> app can then know when it is being used in a fullmesh mode, with
> potentially (too) many subflows.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  include/uapi/linux/mptcp.h |  3 ++-
>  net/mptcp/pm_kernel.c      | 38 +++++++++++++++++++++++++++++++++++-
> --
>  net/mptcp/protocol.h       |  1 +
>  net/mptcp/sockopt.c        |  2 ++
>  4 files changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 87cfab874e24..04eea6d1d0a9 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -70,7 +70,8 @@ struct mptcp_info {
>  	__u64	mptcpi_bytes_acked;
>  	__u8	mptcpi_subflows_total;
>  	__u8	mptcpi_endp_laminar_max;
> -	__u8	reserved[2];
> +	__u8	mptcpi_endp_fullmesh_max;
> +	__u8	reserved;
>  	__u32	mptcpi_last_data_sent;
>  	__u32	mptcpi_last_data_recv;
>  	__u32	mptcpi_last_ack_recv;
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index df2bc36593d0..054d85045381 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -22,6 +22,7 @@ struct pm_nl_pernet {
>  	u8			endp_signal_max;
>  	u8			endp_subflow_max;
>  	u8			endp_laminar_max;
> +	u8			endp_fullmesh_max;
>  	u8			limit_add_addr_accepted;
>  	u8			limit_extra_subflows;
>  	u8			next_id;
> @@ -70,6 +71,14 @@ u8 mptcp_pm_get_endp_laminar_max(const struct
> mptcp_sock *msk)
>  }
>  EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_laminar_max);
>  
> +u8 mptcp_pm_get_endp_fullmesh_max(const struct mptcp_sock *msk)
> +{
> +	struct pm_nl_pernet *pernet =
> pm_nl_get_pernet_from_msk(msk);
> +
> +	return READ_ONCE(pernet->endp_fullmesh_max);
> +}
> +EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_fullmesh_max);
> +
>  u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock
> *msk)
>  {
>  	struct pm_nl_pernet *pernet =
> pm_nl_get_pernet_from_msk(msk);
> @@ -603,9 +612,12 @@ fill_local_addresses_vec(struct mptcp_sock *msk,
> struct mptcp_addr_info *remote,
>  	int i;
>  
>  	/* If there is at least one MPTCP endpoint with a fullmesh
> flag */
> -	i = fill_local_addresses_vec_fullmesh(msk, remote, locals,
> c_flag_case);
> -	if (i)
> -		return i;
> +	if (mptcp_pm_get_endp_fullmesh_max(msk)) {
> +		i = fill_local_addresses_vec_fullmesh(msk, remote,
> locals,
> +						      c_flag_case);
> +		if (i)
> +			return i;
> +	}

I'm not sure if endp_fullmesh_max needs to be checked in
fill_remote_addresses_vec() too, something like:

   if (mptcp_pm_get_endp_fullmesh_max(msk))
           return fill_remote_addresses_fullmesh(msk, local, addrs);

Thanks,
-Geliang

>  
>  	/* If there is at least one MPTCP endpoint with a laminar
> flag */
>  	if (mptcp_pm_get_endp_laminar_max(msk))
> @@ -790,6 +802,10 @@ static int
> mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>  		addr_max = pernet->endp_laminar_max;
>  		WRITE_ONCE(pernet->endp_laminar_max, addr_max + 1);
>  	}
> +	if (entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
> +		addr_max = pernet->endp_fullmesh_max;
> +		WRITE_ONCE(pernet->endp_fullmesh_max, addr_max + 1);
> +	}
>  
>  	pernet->endpoints++;
>  	if (!entry->addr.port)
> @@ -1188,6 +1204,10 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff
> *skb, struct genl_info *info)
>  		addr_max = pernet->endp_laminar_max;
>  		WRITE_ONCE(pernet->endp_laminar_max, addr_max - 1);
>  	}
> +	if (entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
> +		addr_max = pernet->endp_fullmesh_max;
> +		WRITE_ONCE(pernet->endp_fullmesh_max, addr_max - 1);
> +	}
>  
>  	pernet->endpoints--;
>  	list_del_rcu(&entry->list);
> @@ -1503,6 +1523,18 @@ int mptcp_pm_nl_set_flags(struct
> mptcp_pm_addr_entry *local,
>  	changed = (local->flags ^ entry->flags) & mask;
>  	entry->flags = (entry->flags & ~mask) | (local->flags &
> mask);
>  	*local = *entry;
> +
> +	if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH) {
> +		u8 addr_max = pernet->endp_fullmesh_max;
> +
> +		if (entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH)
> +			addr_max++;
> +		else
> +			addr_max--;
> +
> +		WRITE_ONCE(pernet->endp_fullmesh_max, addr_max);
> +	}
> +
>  	spin_unlock_bh(&pernet->lock);
>  
>  	mptcp_pm_nl_set_flags_all(net, local, changed);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0545eab23125..1e8f40bb7870 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1180,6 +1180,7 @@ void __mptcp_pm_kernel_worker(struct mptcp_sock
> *msk);
>  u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
>  u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
>  u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
> +u8 mptcp_pm_get_endp_fullmesh_max(const struct mptcp_sock *msk);
>  u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock
> *msk);
>  u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
>  
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index a28a48385885..de90a2897d2d 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -982,6 +982,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk,
> struct mptcp_info *info)
>  			mptcp_pm_get_endp_subflow_max(msk);
>  		info->mptcpi_endp_laminar_max =
>  			mptcp_pm_get_endp_laminar_max(msk);
> +		info->mptcpi_endp_fullmesh_max =
> +			mptcp_pm_get_endp_fullmesh_max(msk);
>  	}
>  
>  	if (__mptcp_check_fallback(msk))
> 

