Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB043F1654
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074499; cv=none; b=S+VQT/gaNSxFy095K1U9nP8CT/fGW11qh2lmmuara7OgzFnGxGXHPIBTGiAPH0emaGLS/28Gsh2NCNHaMnxtgTCvC8h0G9B8UK6d3jsk2XLIVf8qmLZ8xv7dKHO9X4yWuUshk+DLtHWYlzEPWLOiZ6g9wSueNKGfgXjSAV6Ca7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074499; c=relaxed/simple;
	bh=gO6ms/Mf6jb3mbPKGQ+2CiSOhmU62MTEwIapQXpu73Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsKoNOvM4XjAjfBKxFHZSe1nfxwcE+HkhdRB2bM6B/VXLsfbnHdNovxG1d8BJTVzJwf6FZcJrqZMHChEgJf3FXaGrVmE6LeQ9DJTTQz0hp//+TbMyBo3Wzh39Pc9N7hoMqwKME9JDbOQ8f3geufAZNODsQm7lWO1TCazegEnnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK1zb153; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK1zb153"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574E4C2BCB8;
	Wed,  6 May 2026 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778074498;
	bh=gO6ms/Mf6jb3mbPKGQ+2CiSOhmU62MTEwIapQXpu73Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eK1zb153rQLOGWYOpYUkCRaljVNBeuku9C3VzmR/PsdZ3F8U4skQRkrThZu5Uv1r6
	 c2P9ps7qwiTvjeL1PjNjrgHb7rST6e56IhOogMeIu9pZYHF9emiS68II6UARZqDlTs
	 m5iiIRKDX5+RlvnbiJ5/PLAOWOyCJ1Z5+wwm8D5SRh1WSZYSuZUdwLAVFQFX8+iU5P
	 d4nLnWA86mjlrdGLrXpLcNkjD9VPWXKD+G5AIbYbMQsE5zdUTzIz8vMG704n2/8iTC
	 0WmVP6lV03r9wnmdhWFq/BsK8ILypAOaFqwa3Qp349RMkLY3Lr/CvczfDPASu9F+GS
	 V8CGRQdDs1nUw==
Message-ID: <4c4fbc89-ecfd-4eaf-b939-50e2d95b1f2b@kernel.org>
Date: Wed, 6 May 2026 15:34:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: fix ADD_ADDR timer infinite
 retry on option space insufficient
Content-Language: fr
To: Li Xiasong <lixiasong1@huawei.com>
Cc: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
 "weiyongjun (A)" <weiyongjun1@huawei.com>, yuehaibing
 <yuehaibing@huawei.com>, zhangchangzhong <zhangchangzhong@huawei.com>,
 xiasong.lee@gmail.com
References: <20260430112026.343691-1-lixiasong1@huawei.com>
 <20260430112026.343691-2-lixiasong1@huawei.com>
 <177755524215.1566930.3209225574765644709.b4-review@b4>
 <0430cd33-4d2e-4659-be1e-fada67bb9c6d@gmail.com>
 <4792fa80-2485-47bc-9c50-0526c2f23484@kernel.org>
 <3245a905-81a8-46fb-8eac-8c42d259bb58@huawei.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3245a905-81a8-46fb-8eac-8c42d259bb58@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Li,

On 06/05/2026 15:27, Li Xiasong wrote:
> Hi Matt,
> 
> I’m currently preparing the v3 update for this fix.

Thanks!

> In mptcp_pm_add_addr_signal(), when TCP option space is insufficient, we
> cancel the ADD_ADDR retrans timer via mptcp_pm_del_add_timer(). During
> analysis, I found a race window that can lead to one extra ADD_ADDR send
> attempt, so I’d like to confirm the intended semantics before posting v3.
> 
> I see two race cases:
> 
> Case 1: cancel state applied first (handled by existing counter check)
> 
> CPU0 (cancel path)                          CPU1 (add_timer callback)
> --------------------------------------      -----------------------------------
> option space insufficient                   callback already running
> call mptcp_pm_del_add_timer()               ...
> acquire pm.lock                             ...
> set retrans_times = ADD_ADDR_RETRANS_MAX    ...
> release pm.lock                             ...
> stop timer                                  ...
>                                             acquire pm.lock
>                                             check retrans_times <
>                                               ADD_ADDR_RETRANS_MAX ?
>                                             false -> skip announce/send
>                                             release pm.lock
> 
> For this case, gating send by
> `retrans_times < ADD_ADDR_RETRANS_MAX` prevents stale send.
> 
> 
> Case 2: callback takes lock first and sends before cancel applies
> 
> CPU0 (cancel path)                          CPU1 (add_timer callback)
> --------------------------------------      -----------------------------------
> option space insufficient                   callback already running
> call mptcp_pm_del_add_timer()               acquire pm.lock
> try acquire pm.lock -> blocked              check send conditions
>                                             announce/send ADD_ADDR  <- send
>                                             retrans_times++
>                                             release pm.lock
> acquire pm.lock                             ...
> set retrans_times = ADD_ADDR_RETRANS_MAX    ...
> release pm.lock                             ...
> stop timer                                  ...
> 
> 
> I’d like to discuss which semantic target is better for v3:
> 
> A) best-effort cancel:
>    race may still allow at-most-one extra send attempt and `ADDADDRTXDROP`
> send-failure statistics may be incremented one extra time.

I think that's OK to send an extra attempt, especially here where it is
quite unlikely to get this race.

> B) strict cancel semantics:
>    once cancel is decided, no further ADD_ADDR send action
> 
> My current understanding:
> - Case 1 can be covered by the existing retrans_times gate.
> - Case 2 is the key trade-off between complexity and strictness.

Case 1 looks fine to me, but do you mind documenting the possible race
in the code and/or commit message depending on the patch, please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

