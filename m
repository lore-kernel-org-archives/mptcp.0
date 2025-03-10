Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD241DE3A6
	for <mptcp@lists.linux.dev>; Mon, 10 Mar 2025 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648726; cv=none; b=pZxgrjjXmgAS3LiAYzJEd1RbcpNJoEEpPRxCxxnmipfONhyb94FaKwWVhtRej12SuUkWt1mV6FeQS95oXrp16UATkApSuB7VKsTKWbG7cgmFiveej0L4V39flwk6sSOtTYtxS3ARFW3piuFNClMickl21nGQKlcp9g77FTWnVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648726; c=relaxed/simple;
	bh=eqgooHrbEiT7xe21Xsn+acwE3vRFhxCtXjsE0/1MqIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qk0Hww34HgE14iAx7w4qz8E9fGeIFDtSR/vI68su9UlXb522OZeBgqPlk9FB7UfyOUuGbXA6fHxwsFXGoROjZiEuWIFZWkWZOjD0VLWU9ryt2J6quhhLn6Cwq/qvmWnGLiof5RYXSJhq8KGjbH30hhDJ3MJ4zjYriPoYaO9g+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH5JlUQU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH5JlUQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1149C4CEE5;
	Mon, 10 Mar 2025 23:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741648725;
	bh=eqgooHrbEiT7xe21Xsn+acwE3vRFhxCtXjsE0/1MqIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dH5JlUQUZ3vbXWUuPX6cePBxx6Zipb0vnr7ZmLhaXxYC76ihCee9Ycv6vyJoCn9MF
	 XL6kXX5wDrvYKqyoAJfPHs0aNdVZuovC9PhvqpKhlSe4U0jc/boyhAuP73BHeZQPxX
	 0GlfpvYtgqq4hx1IT01466ZIE50W9xRjRnnPw9kFs81xTr8ANnoN4ldkqZYEE5/wXd
	 pyQSHiQ+nD0A8hbcXsyJ+aWJlP1TE3Qyt6juwRxKSB5UJcleDVYbQsbquO6yVSxMfx
	 V9B1SyKLl8OPw2XRtmMdy4HQ676f3Q3bpyaMbf79GLU7J2/KcD28qLe4qWhX/uxAMe
	 Tyd37C0BTxLuw==
Message-ID: <c1168a97-3604-4aaf-aebe-2ca5b2ebe44b@kernel.org>
Date: Tue, 11 Mar 2025 00:18:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v10 05/12] mptcp: pm: init and release
 mptcp_pm_ops
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
 <e1a69a1ee9ca25f12a244e5470341c23364de424.1741258415.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e1a69a1ee9ca25f12a244e5470341c23364de424.1741258415.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 06/03/2025 12:01, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Add a struct mptcp_pm_ops pointer "ops" in struct mptcp_pm_data, and two
> helpers mptcp_pm_ops_init() and mptcp_pm_ops_release(), to set and release
> this pointer. mptcp_pm_ops_init() is invoked in mptcp_pm_data_reset(),
> while mptcp_pm_ops_release() is invoked in mptcp_pm_destroy().
> 
> mptcp_pm_kernel_init() is defined as init() interface of the in-kernel PM,
> which sets work_pending, accept_addr and accept_subflow.
> 
> mptcp_pm_userspace_is_release() is defined as release() interface of the
> userspace PM, which is a wrapper of userspace_pm_free_local_addr_list().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c           | 55 ++++++++++++++++++++++++++--------------
>  net/mptcp/pm_kernel.c    | 19 ++++++++++++++
>  net/mptcp/pm_userspace.c |  6 +++++
>  net/mptcp/protocol.h     |  1 +
>  4 files changed, 62 insertions(+), 19 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 1400bfed4b0d..1a2f1715871c 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c

(...)

>  void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  {
> -	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
> +	const struct net *net = sock_net((struct sock *)msk);
> +	const char *pm_name = mptcp_get_path_manager(net);
> +	u8 pm_type = mptcp_get_pm_type(net);
>  	struct mptcp_pm_data *pm = &msk->pm;
>  
>  	memset(&pm->reset, 0, sizeof(pm->reset));
>  	WRITE_ONCE(pm->pm_type, pm_type);
>  
> -	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
> -		bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
> -
> -		/* pm->work_pending must be only be set to 'true' when
> -		 * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
> -		 */
> -		WRITE_ONCE(pm->work_pending,
> -			   (!!mptcp_pm_get_local_addr_max(msk) &&
> -			    subflows_allowed) ||
> -			   !!mptcp_pm_get_add_addr_signal_max(msk));
> -		WRITE_ONCE(pm->accept_addr,
> -			   !!mptcp_pm_get_add_addr_accept_max(msk) &&
> -			   subflows_allowed);
> -		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
> -	}
> +	rcu_read_lock();
> +	mptcp_pm_ops_init(msk, mptcp_pm_find(pm_name));
> +	rcu_read_unlock();
>  
>  	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);

I just noticed that this bitmap is currently only used by the in-kernel
PM, so this could be moved to mptcp_pm_kernel_init() as well, no?

I guess we will not need this bitmap for the future BPF PM, because
future BPF PM can use a BPF map instead if they need that I suppose, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

