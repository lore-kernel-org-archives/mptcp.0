Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C01DE3CE
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742553966; cv=none; b=lafrimaRgMWOuRg1hKb1DVoieQjn0rbW2XtVSrnUg5pAfQ8dEnYG1yj5c+E4uyPx0nd+T0bKSQN6cQBMtBAmP1G2L18kvg/asDFh8oWt4QrJqflVrWamZRTT6w14TdQYJTkkwVcXaOEhPzcM2HNNgl9Zrnra9xLg3lI4QeYdkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742553966; c=relaxed/simple;
	bh=YJLcd9kchn0C9es0oPb9g43wkgDZ+muWWjgJIlpYwtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFjHP97dUA1AJav33TmF9p+DnZjMnxPpqqj4eIpdc3cYowhhxS5e99xoyMyWREhFEmI7I8GBO3a6PfRAD5bd4iKsFovDJaXWDG+LMLYW3aKOMrZNbQBMK1QrloGnysLzvR9uzELdpWym9t/I8mm5vUQE9vZ0MuU1UZPN37sP7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMFN/zBM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMFN/zBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370C5C4CEE3;
	Fri, 21 Mar 2025 10:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742553965;
	bh=YJLcd9kchn0C9es0oPb9g43wkgDZ+muWWjgJIlpYwtw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tMFN/zBMqjqGNOKy70okJ3Np8pp1RmpI3rZT1sY97cYFWav8rG9M59ZmIpwHGeJmO
	 FNeLg78lBh1VsXvKIqDrciZBAMsi2UCk35v9AUhbifkSxPLES9zvlG56p9rPEDaExF
	 l356yKRYjALcrC+ZJFW6Ath8ob9sxn5Ae5Sg0puGpK/xVEyWPZEYNO5JRAs8ln9Pgb
	 unPzaM0/UHXm5ImLBUy7DeCVgV4atco2XUCWrbFfjOKKgOIX9wnH9ffUX7fkMSJPXf
	 SfZyMk+Sa/zxFCak3z992VL+OZn0BFJHCrmuckWOJUFNozKYByspqZ4II4TTEldyK3
	 2fJm5+HVNKOfA==
Message-ID: <6f1f1d70-fc1f-4d64-abe9-5bfb9e85cbcc@kernel.org>
Date: Fri, 21 Mar 2025 11:46:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 10/10] mptcp: pm: drop is_userspace in
 subflow_check_next
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
 <7d236597235768dcf1885f317acb767840cb9e42.1742521397.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7d236597235768dcf1885f317acb767840cb9e42.1742521397.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/03/2025 02:45, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In mptcp_pm_subflow_check_next(), instead of reducing "pm->subflows"
> for the in-kernel PM in __mptcp_pm_close_subflow(), this patch moves
> "pm->subflows--;" forward to let it be used by both the userspace PM
> and the in-kernel PM. Then mptcp_pm_is_userspace() here can be dropped.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index bb456e203665..a3fcb335c717 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -531,13 +531,10 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
>  	bool update_subflows;
>  
>  	update_subflows = subflow->request_join || subflow->mp_join;
> -	if (mptcp_pm_is_userspace(msk)) {
> -		if (update_subflows) {
> -			spin_lock_bh(&pm->lock);
> -			pm->subflows--;
> -			spin_unlock_bh(&pm->lock);
> -		}
> -		return;
> +	if (update_subflows) {
> +		spin_lock_bh(&pm->lock);
> +		pm->subflows--;
> +		spin_unlock_bh(&pm->lock);

Should we not simply call mptcp_pm_close_subflow() instead? It should be
fine to call it for the userspace or BPF PMs as well, no?

>  	}
>  
>  	if (!pm->ops->subflow_established)
> @@ -547,8 +544,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
>  		return;
>  
>  	spin_lock_bh(&pm->lock);
> -	if (update_subflows)
> -		__mptcp_pm_close_subflow(msk);
> +	if (update_subflows && msk->pm.subflows < mptcp_pm_get_subflows_max(msk))
> +		WRITE_ONCE(msk->pm.accept_subflow, true);
>  
>  	/* Even if this subflow is not really established, tell the PM to try
>  	 * to pick the next ones, if possible.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

