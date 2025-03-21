Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27821E0A2
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553319; cv=none; b=SsRT35nLFSdv0R6dXaALbYcWNxXw5ijk3sY89g5sg2P8yaaH9BL35gXsabbMCI/bZR5X+Tjhjkmz4wcbUsT9PeEAQPiH4yKlb3jL9NBYjTaX8rp6gJf2O3DQJrrQJKdeg4slU9X0y7PwoJdcE0GIA8UtgwZuzha4a2SS1+OR8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553319; c=relaxed/simple;
	bh=HwcjjwOUa22/05Ie2crSEv+NEEeE0XZARNxQalALL6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAKU/iNKyW8XvEvRj9gaucR9dHWv+lnC4MrXGozO4s8QYqjXjuegFVQayFsQteJGGjov0wALfH6s4q0WydLidc2lTv/V6FEP4Fp0yvRGi4Tdtt0wmyhfBEGrGjMJfPAM7HDbFD9KH51bmjKQxyfKT0IiKE9Tv+NUDiEdpSDRswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABqMdaf1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABqMdaf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E40C4CEE3;
	Fri, 21 Mar 2025 10:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742553318;
	bh=HwcjjwOUa22/05Ie2crSEv+NEEeE0XZARNxQalALL6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ABqMdaf1JzwiLQbe1fSFHd3gK/7hatZKkD2QqEpz/t9h0F39Fx7ctQK3Fe/N27Cyd
	 H8xmf0DGhH8OQaXHz90PDLJvvA4orKIfVJ9uXxYZsHnjP7Uf1XUmkySZKmvqhHk7L8
	 z9wz0BNrQ7iSkcdXlSXwxwE/aKR6E2hCmKh7Lo71flzLc0ycwGdtfAWX6RUHVhPG8s
	 44Ht7fnegxs8mC1Ws3kcQ/gqDe9pnLs01F9VTQ2Lheti8eXWgu4fNetL/2EHXWBsPG
	 Ce2r2xJ5iObmg09whDMUT1L/zSXzrI7KtRugbrDop7Nipa8XLxpL+FcrWCZKbdzZ0i
	 0ln4U+bIxuFIw==
Message-ID: <0fcce422-d1e7-49c4-b05d-c6627c1f39cf@kernel.org>
Date: Fri, 21 Mar 2025 11:35:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 09/10] mptcp: pm: add rm_addr_received()
 interface
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
 <e14151bf63b9ae2fa6f75061e1d0d2de069ec6b1.1742521397.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e14151bf63b9ae2fa6f75061e1d0d2de069ec6b1.1742521397.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/03/2025 02:45, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds an optional .rm_addr_received interface for struct
> mptcp_pm_ops and invokes it in mptcp_pm_worker() without PM lock.
> Since mptcp_subflow_shutdown() and mptcp_close_ssk() are sleepable
> kfuncs, .rm_addr_received interface of BPF PM should be invoked by
> __bpf_prog_enter_sleepable(), which can't be invoked under a lock.
> This patch unlocks the pm lock before invoking this interface in
> mptcp_pm_worker(), while holding this lock in mptcp_pm_rm_addr_recv().
> 
> Export mptcp_pm_rm_addr_recv() is to allow the MPTCP_PM_RM_ADDR_RECEIVED
> worker can be invoke from the in-kernel PM.
> 
> With this, mptcp_pm_is_kernel() in mptcp_pm_rm_addr_or_subflow() can be
> dropped.

From what I understand, you are changing the behaviour for the userspace
PM, no?

When a RM_ADDR is received, for the moment, both the in-kernel and
userspace PM removes the corresponding subflow(s). Now it is only the
case with the in-kernel PM.

Technically, it would be fine to let the userspace daemon reacting to
the RM_ADDR event, but that's changing the behaviour.

(...)

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 7b34a59977cf..bb456e203665 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -677,15 +677,17 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
>  
>  		if (rm_type == MPTCP_MIB_RMADDR) {
>  			__MPTCP_INC_STATS(sock_net(sk), rm_type);
> -			if (removed && mptcp_pm_is_kernel(msk))
> +			if (removed)
>  				mptcp_pm_nl_rm_addr(msk, rm_id);

As an alternative not to break the behaviour, you could add the hook here:

  if (removed && pm->ops->rm_addr_received)
      pm->ops->rm_addr_received(msk, rm_id);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

