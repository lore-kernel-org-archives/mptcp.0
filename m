Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1D18D642
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746089; cv=none; b=hbXnDwnZCSIdBCU9Px2ewY0SShSl0AX4v/aV9ZmskEXqpb31xxUVabl9M6lDZy8mLHg3Xl4TPEb/xoKNPqq4jAk2tYySX9mXUs7ltW0OkZv83RIihEIL08AIVo13mI7+ylicaetpAAE+4gXvv8jBz3vrJeIEfI26nVht6PtU+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746089; c=relaxed/simple;
	bh=BAvSgNyWsgGhQc8Hm+bYNrjIOdez6vPMU+m4h9E2QTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csAG7O/hd8U7ZeZ7LSQwQ4U6GJZ4z7W2husUqelN47AHDna9trInt9zbuzE/qrCmRIXfa2B/k1j1c64kaUWlbokMrM3vkOTQg3QhOyr81yhFllkP0ZvGeVKf7n3o1mBb3nt9EorJcqtf2W9aIcnJlHXMFGSo1/MHqbwSHtP0ths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7fSf1ws; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7fSf1ws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2B1C4CECE;
	Mon,  4 Nov 2024 18:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730746088;
	bh=BAvSgNyWsgGhQc8Hm+bYNrjIOdez6vPMU+m4h9E2QTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V7fSf1ws3CyKJ8inKeNfPtKRxPPfdEsY9DounJsj7tGsbdqtUmimH/KtE0ez6pUni
	 qV46eA5uj+2ryFEx2wOQudYoQ0OH7xzxGM3fRWvSU+B83crZ8dPmnde9ZQIqpcbtLo
	 hLcsViDPoeFsaRtXStATFT7U20v6DwPFPOgjfEri88fsWE5beSaQ7BQabhWeHSJ8OW
	 BC9Drh1HbPW0yQG+MwsaRUPSG7PNW+7GfPh0hF55Wr6IgDZ0wSerJxNZSFUQma3EVT
	 3INotUu3YtCpEYFIw3E2lfALMdEkUivwXqCnQir7pmqEcvgUgmzV0Fuv5JlAE8HpLv
	 Ul1uVDzImgHeg==
Message-ID: <8c422b14-719a-447d-a24e-61ef40dbd72e@kernel.org>
Date: Mon, 4 Nov 2024 19:48:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 21/36] mptcp: update address type of
 get_local_id
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <697ad8ffc8987b12a232b3855e6960b49c186d4b.1729588019.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <697ad8ffc8987b12a232b3855e6960b49c186d4b.1729588019.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/10/2024 11:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The following code in mptcp_userspace_pm_get_local_id() that assigns "skc"
> to "new_entry" is not allowed in BPF if we use the same code to implement
> the get_local_id() interface of a BFP path manager:

Can you give more details about the fact it is not allowed please?

Do you mean you cannot do the following code in BPF? Why?

> 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
> 	new_entry.addr = *skc;
> 	new_entry.addr.id = 0;
> 	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> 
> To solve the issue, this patch moves this assignment to "new_entry" forward
> to mptcp_pm_get_local_id(), and then passing "new_entry" as a parameter to
> both mptcp_pm_nl_get_local_id() and mptcp_userspace_pm_get_local_id().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c           | 10 ++++++++--
>  net/mptcp/pm_netlink.c   | 11 +++--------
>  net/mptcp/pm_userspace.c | 17 ++++++-----------
>  net/mptcp/protocol.h     |  4 ++--
>  4 files changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index b6e6859903ef..d28e844eba2d 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -404,6 +404,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  {
>  	struct mptcp_addr_info skc_local;
>  	struct mptcp_addr_info msk_local;
> +	struct mptcp_pm_addr_entry local;
>  
>  	if (WARN_ON_ONCE(!msk))
>  		return -1;
> @@ -416,9 +417,14 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
>  		return 0;
>  
> +	memset(&local, 0, sizeof(struct mptcp_pm_addr_entry));

Out of curiosity: do you need to call memset() here? Can you not init
"local" when you declare it?

  struct mptcp_pm_addr_entry local = { 0 };

(Or maybe that's not working with C99 with inner structures? I thought
it was, but not sure).

> +	local.addr = skc_local;

Do you still need skc_local? Can you not use 'local.addr' directly
instead above?

> +	local.addr.id = 0;

In pm_netlink.c, 'addr.port' is also reset. Should you not do that here
too? I guess that's fine for the userspace pm, no?

> +	local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> +
>  	if (mptcp_pm_is_userspace(msk))
> -		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
> -	return mptcp_pm_nl_get_local_id(msk, &skc_local);
> +		return mptcp_userspace_pm_get_local_id(msk, &local);
> +	return mptcp_pm_nl_get_local_id(msk, &local);
>  }
>  
>  bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

