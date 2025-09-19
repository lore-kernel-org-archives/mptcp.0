Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F92EC55B
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276723; cv=none; b=GzdGMwRntB0VqsYihwbpQMN75qdAFU3mLZPtA2wNDgwudCFEbs9LM7frFvF068Eu74aFrmJ4gV/sjXTcNSk9ENQYnBSKIDoZdwfLrLZ8dV9oFK3gVS5XaCzbhxYOGjOfEPQhEItTFmY9OvtV/35xp6RIfsIZBdrhygGwYlloEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276723; c=relaxed/simple;
	bh=ei+EZWfc4zDzA6tZrf+bRaLFJ/+zfmQaHhg74Tgu2pM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jj1E7fWDS5flM9VuTo/AWPUgxjYDS+vzWdFhL3ceC9dxxd1vUA3BUBae3Nxx6kLoL5GWTlkOwEX+o1I0xQKwd3h3xoOcQLu6mlHaZJobz8096rKIaMzERlZsL9BHOtkbadAl6ZITQZMsQdL5sU/VXyIpftUaNXyPnGXp3NfonIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYjrIB87; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYjrIB87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668DBC4CEF0;
	Fri, 19 Sep 2025 10:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758276721;
	bh=ei+EZWfc4zDzA6tZrf+bRaLFJ/+zfmQaHhg74Tgu2pM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=XYjrIB87ECZG0q+l+6OaNsygSlmhwWeS8bWX8zdi+SXdjQJs9NDB6zpjFnfVllxNp
	 qj1s+gWkZXjBMkDtf3y+LuaeintKKGy3YsMe1+hgWm8OdpPGczBmTDC9Kc2S/Kad9+
	 PlRiPWsCEYqp7+oNbHJ44RegBZcRduQEOuMWjw7MQMz0ja5T6LdeqG+OZq6dlrbjCa
	 E63umr9vkRQdvY0hj1uypVWhHKAOPZ4sgQ/8jkp1DX7wpSz13aBSYjwXd0bQluRfSm
	 Jj35xqHJ7eWrz47nJKdyDtRSg0BK1rjYRKkH8/E8RHoDs2b4RrrmhDlxKp/8dfvrCX
	 G1ukb7udekjiA==
Message-ID: <c702e2fc35fdbea872ac01eb49c9f7f7be0262a9.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 01/10] Squash to "mptcp: pm: in-kernel:
 usable client side with C-flag"
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 19 Sep 2025 18:11:54 +0800
In-Reply-To: <20250919-pm-kern-endp-add_addr-v2-1-1f8f04f01914@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
	 <20250919-pm-kern-endp-add_addr-v2-1-1f8f04f01914@kernel.org>
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

Thanks for this set. It looks good to me overall. Only one comment
below.

On Fri, 2025-09-19 at 11:08 +0200, Matthieu Baerts (NGI0) wrote:
> The id_avail_bitmap is only used when either the 'subflow' or
> 'signal'
> flag is used, but not with 'fullmesh' only. Here, it is replacing the
> 'subflow' action, so check if this flag is set.
> 
> Also, add the check for the max subflows upfront, so we avoid
> scheduling
> the worker with MPTCP_PM_ADD_ADDR_RECEIVED if it is not needed.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2: modify protocol.h here too (Geliang)
> ---
>  net/mptcp/pm_kernel.c | 3 ++-
>  net/mptcp/protocol.h  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index
> d7cd89fa6a11a1ea7703edbfbdf2bbe86a6a3054..277f81f38134d07918143331746
> a50bc316d81ca 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -411,7 +411,8 @@ static unsigned int
> fill_local_addresses_vec(struct mptcp_sock *msk,
>  			locals[i].flags = entry->flags;
>  			locals[i].ifindex = entry->ifindex;
>  
> -			if (c_flag_case)
> +			if (c_flag_case &&
> +			    (entry->flags &
> MPTCP_PM_ADDR_FLAG_SUBFLOW))
>  				__clear_bit(locals[i].addr.id,
>  					    msk-
> >pm.id_avail_bitmap);
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index
> dd0662defd41c84474e44c559c571e3594b85d9e..0d6dae37c9daf4ec8990b9a8703
> 6aa393add585c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1200,7 +1200,8 @@ static inline bool
> mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
>  {
>  	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
>  	       msk->pm.local_addr_used == 0 &&
> -	       mptcp_pm_get_add_addr_accept_max(msk) == 0;
> +	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
> +	       msk->pm.subflows < mptcp_pm_get_subflows_max(msk);

If this line is added here, no need to change it again in
fill_local_addresses_vec() in "mptcp: pm: in-kernel: usable client side
with C-flag", right? I mean we can drop "msk->pm.subflows <
subflows_max" in this while statement:

  while (msk->pm.local_addr_used < local_addr_max &&
         msk->pm.subflows < subflows_max) {

No need to send a v3, please update it when merging it if you agree.

>  }
>  
>  void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock
> *ssk);
