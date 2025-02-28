Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DE13213E
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707885; cv=none; b=izk5ybJEB6Nchni5PaWYVfQlQdbSkb9kWUqe7q0oquZBgoZpFoXtw6Zoxg2YJmj+nha7IW6w3Pw8i+puvBBgz9n2E6dHBceZDSyOay13BSN1rWKuUEt7Dw5TyDT9KrDVqTriN0I7bSMhvLeXzQq8M+7CzuddytBjwtoN8UT2g0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707885; c=relaxed/simple;
	bh=vaV0vpN47C9JcFkawcZgMv8FurzhnG/FPK3I+SAxWZ8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gJeKfBAmi3UXILSN7isppJg66R9rhK5Gvtl+hqwCsJgrrCICNEhZbA4HnX+LByevZDa3WDseGwRWsqjr66abpWdIlf1MskG3GaFBR5mA96NrYT5RQXTiCAXcynbRl7Nk013ijVnfAGWNzP2YFniKHEdBFlOW8cHp4O0sGKOJhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJET7eij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJET7eij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECC5C4CEDD;
	Fri, 28 Feb 2025 01:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740707885;
	bh=vaV0vpN47C9JcFkawcZgMv8FurzhnG/FPK3I+SAxWZ8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=XJET7eijiMg5PWeS8KUY4/6F8mUJYV+pvsgWPAyGfncRce9FlrYBiFF6Ufo77MZAv
	 hoWONOb6htCMun5VRrWftAP5t8fCnBeBo+UdLjrVR2JLiKrL3XcdIgeWQnadxxuK99
	 khQS00I+gNMPNgt12nRarjguhfO9x51aYbYivSux3TtSMwvsnVGZTdKQZe1MlFPsMe
	 5kz7eIMag2g2PKsjyU7dBvUy3AzJUPOdGf4Zswua0LxXoCFPj0KkvdApAPrQrvLG8/
	 l5t98ovtxBXsPla2cNG26DqDIYslTjHtUZnVOzeuc2/NTcgn8xXRlYffClNbXCjB/u
	 L37QjETOIvLjA==
Message-ID: <2e5177ce0ff3337374397d1e4b7d54ab5b1b8d4c.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 6/7] mptcp: pm: worker: split in-kernel and
 common tasks
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 28 Feb 2025 09:58:01 +0800
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-6-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
	 <20250227-mptcp-pm-reorg-code-v1-6-cb4677096709@kernel.org>
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

On Thu, 2025-02-27 at 21:08 +0100, Matthieu Baerts (NGI0) wrote:
> To make it clear what actions are in-kernel PM specific and which
> ones
> are not and done for all PMs, e.g. sending ADD_ADDR and close
> associated
> subflows when a RM_ADDR is received.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm.c         | 25 +++++++++++++++++++++++++
>  net/mptcp/pm_netlink.c | 21 ++-------------------
>  net/mptcp/protocol.h   |  1 +
>  3 files changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index
> e1ca90701fd92abbf6d8b92d461ddb18d2652391..c17828981dd6400b2ed74dd28a9
> 5e21f76ed37b9 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -599,6 +599,31 @@ bool mptcp_pm_addr_families_match(const struct
> sock *sk,
>  #endif
>  }
>  
> +void mptcp_pm_worker(struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_data *pm = &msk->pm;
> +
> +	msk_owned_by_me(msk);
> +
> +	if (!(pm->status & MPTCP_PM_WORK_MASK))
> +		return;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +
> +	pr_debug("msk=%p status=%x\n", msk, pm->status);
> +	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
> +		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
> +		mptcp_pm_addr_send_ack(msk);
> +	}
> +	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
> +		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
> +		mptcp_pm_rm_addr_recv(msk);

CI made the following complaint:

  net/mptcp/pm.c: In function 'mptcp_pm_worker':
  net/mptcp/pm.c:620:17: error: implicit declaration of function
'mptcp_pm_rm_addr_recv'; did you mean 'mptcp_pm_rm_addr_received'? [-
Wimplicit-function-declaration]
    620 |                 mptcp_pm_rm_addr_recv(msk);
        |                 ^~~~~~~~~~~~~~~~~~~~~
        |                 mptcp_pm_rm_addr_received

> +	}
> +	__mptcp_pm_kernel_worker(msk);
> +
> +	spin_unlock_bh(&msk->pm.lock);
> +}
> +
>  void mptcp_pm_destroy(struct mptcp_sock *msk)
>  {
>  	mptcp_pm_free_anno_list(msk);
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index
> 44362b0f7ee4f131482705439eb96c0374177c1d..2a8652886fce6ba9743d0efba57
> 6ac57f35a0077 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -924,30 +924,15 @@ static void
> mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
>  	mptcp_pm_rm_addr_or_subflow(msk, rm_list,
> MPTCP_MIB_RMSUBFLOW);
>  }
>  
> -void mptcp_pm_worker(struct mptcp_sock *msk)
> +/* Called under PM lock */
> +void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
>  {
>  	struct mptcp_pm_data *pm = &msk->pm;
>  
> -	msk_owned_by_me(msk);
> -
> -	if (!(pm->status & MPTCP_PM_WORK_MASK))
> -		return;
> -
> -	spin_lock_bh(&msk->pm.lock);
> -
> -	pr_debug("msk=%p status=%x\n", msk, pm->status);
>  	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
>  		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
>  		mptcp_pm_nl_add_addr_received(msk);
>  	}
> -	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
> -		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
> -		mptcp_pm_addr_send_ack(msk);
> -	}
> -	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
> -		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
> -		mptcp_pm_rm_addr_recv(msk);
> -	}
>  	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
>  		pm->status &= ~BIT(MPTCP_PM_ESTABLISHED);
>  		mptcp_pm_nl_fully_established(msk);
> @@ -956,8 +941,6 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
>  		mptcp_pm_nl_subflow_established(msk);
>  	}
> -
> -	spin_unlock_bh(&msk->pm.lock);
>  }
>  
>  static bool address_use_port(struct mptcp_pm_addr_entry *entry)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index
> 93faf203d987100f22e507c7f443d937284881e4..8742527196887598eb242c82f06
> 004107d29ef92 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1154,6 +1154,7 @@ static inline u8 subflow_get_local_id(const
> struct mptcp_subflow_context *subflo
>  
>  void __init mptcp_pm_nl_init(void);
>  void mptcp_pm_worker(struct mptcp_sock *msk);
> +void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_add_addr_signal_max(const struct
> mptcp_sock *msk);
>  unsigned int mptcp_pm_get_add_addr_accept_max(const struct
> mptcp_sock *msk);
>  unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock
> *msk);
> 

