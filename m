Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298081D86DC
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999187; cv=none; b=jk4rogy1LMWoPFJMBeFtU6U0ehfGS1FoO/bbMbgq+Ikr8+iPgvf+MlHRhQA2CGGknlecu3kYPpfrqN2qj2GD1mrSgpMR2SU2Olj1W6Bj5r0ysOc1/hBcxMTYzrikj3wOioWc08WQh2EwhfyDgJonHVH4ExSJEv6K7UPuNxhZbGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999187; c=relaxed/simple;
	bh=JsBU+YaNYGwOwmgaRcC6Rtf6/vjqiy6YGu3q599bOWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UY+NkapLDoacRqkS5i0YsNd+EDen9wo3LNL/OX4WVDsv+cUOvCBoXa7yykolGkozBDON0Vg638Oq+Mwbhby67JK9OpZDI90njnVVQOoyB1h3MOV7tYGTKiFztmvO2NTUZd3FXw/0/zvY/Ke7Opb6ORF1AoYdWww9LeJgyVJ/t+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foddfgMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foddfgMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E234EC4CED6;
	Mon,  3 Mar 2025 10:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740999186;
	bh=JsBU+YaNYGwOwmgaRcC6Rtf6/vjqiy6YGu3q599bOWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=foddfgMJPew3Z0krsdRhG9uGlYcrnES8AiwkeWYPtZFCkyTaMXskwnvPcD3ipBBQX
	 ei/YoaKm8pxtGDaXzgt6WkqTaJSy3uO2Fx+qVd1r3c3gBLVFjhod3zFsKKjqXzTbh2
	 TSjhK3b4PIUPMUBYwifa9Uht2K+wzSgkONIzlNqUAiMmAd7OxUPng5l+ujVz0Z8HVB
	 zsg5C8saMjYNs28xxBByZDp3DOGGyAe+NUJfNs9LStj/jz0MVXkiskFLOPKTkz5MBe
	 A3V2GRc+4+dh4LSKLJLLss5Ui/MqBm1NJvfozkIrSZA9HRz4DhdEZvgqGN48ExD9yZ
	 rTWdVOXPJ/M8Q==
Message-ID: <038d7f67-b235-4010-a75f-1ef5651bbb4b@kernel.org>
Date: Mon, 3 Mar 2025 11:53:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 07/11] mptcp: pm: initialize and release
 mptcp_pm_ops
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
 <7c65de17fee4c36d003684e730c1459542eedca8.1740975633.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7c65de17fee4c36d003684e730c1459542eedca8.1740975633.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/03/2025 05:22, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Add a struct mptcp_pm_ops pointer "ops" in struct mptcp_pm_data, and two
> functions mptcp_pm_initialize() and mptcp_pm_release(), to set and release
> this pointer. mptcp_pm_initialize() is invoked in mptcp_pm_data_reset(),
> while mptcp_pm_release() is invoked in mptcp_pm_destroy().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c       | 42 +++++++++++++++++++++++++++++++++++++++---
>  net/mptcp/protocol.h |  3 +++
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 98f81221786f..e8b34f2ecb35 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -973,15 +973,15 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  void mptcp_pm_destroy(struct mptcp_sock *msk)
>  {
>  	mptcp_pm_free_anno_list(msk);
> -
> -	if (mptcp_pm_is_userspace(msk))
> -		mptcp_userspace_pm_free_local_addr_list(msk);
> +	mptcp_pm_release(msk);
>  }
>  
>  void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  {
> +	const char *path_manager = mptcp_get_path_manager(sock_net((struct sock *)msk));
>  	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
>  	struct mptcp_pm_data *pm = &msk->pm;
> +	int ret;
>  
>  	pm->add_addr_signaled = 0;
>  	pm->add_addr_accepted = 0;
> @@ -991,6 +991,12 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  	pm->rm_list_rx.nr = 0;
>  	WRITE_ONCE(pm->pm_type, pm_type);
>  
> +	rcu_read_lock();
> +	ret = mptcp_pm_initialize(msk, mptcp_pm_find(path_manager));
> +	rcu_read_unlock();
> +	if (ret)
> +		return;

Mmh, that's annoying if pm->ops has not been set here! I don't think
mptcp_pm_initialize() can fail and if it does, it should stop the
connection.

> +
>  	if (pm_type == MPTCP_PM_TYPE_KERNEL) {>  		bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
>  
> @@ -1102,3 +1108,33 @@ void mptcp_pm_get_available(char *buf, size_t maxlen)
>  	}
>  	rcu_read_unlock();
>  }
> +
> +int mptcp_pm_initialize(struct mptcp_sock *msk, struct mptcp_pm_ops *pm)
> +{
> +	if (!pm)

I guess this should never happen, right? Or maybe yes if a BPF PM has
been unloaded?

> +		pm = &mptcp_kernel_pm;
> +
> +	if (!bpf_try_module_get(pm, pm->owner))
> +		return -EBUSY;

Should it not fallback to the kernel PM + print a warning (once?)?

pr_warn_once("%pm %s couldn't be initialized, falling back to 'kernel'",
             pm->name);
pm = &mptcp_kernel_pm;

> +
> +	msk->pm.ops = pm;
> +	if (msk->pm.ops->init)
> +		msk->pm.ops->init(msk);
> +
> +	pr_debug("pm %s initialized\n", pm->name);
> +	return 0;
> +}
> +
> +void mptcp_pm_release(struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_ops *pm = msk->pm.ops;
> +
> +	if (!pm)
> +		return;
> +
> +	msk->pm.ops = NULL;
> +	if (pm->release)
> +		pm->release(msk);
> +
> +	bpf_module_put(pm, pm->owner);
> +}

Can you not declare mptcp_pm_release() and mptcp_pm_initialize() as
static and move them above mptcp_pm_destroy() and mptcp_pm_data_reset()?
It would make more sense, and no need to export them in protocol.h.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

