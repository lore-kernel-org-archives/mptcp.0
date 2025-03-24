Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08A518FC80
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814188; cv=none; b=d4zFfydpsBSf55Ji6hFMubkSf8o3D8m8MgSn+7M8EbgvVTd6fl/a/bVDUbDiHpLRsNHw0vUgVYRK3cWV44qlFCK7BZ673Gfkza2QB++Ok12AP5QEPg++vVI3dTuZAzjMUx2l7WcPhcycGJlhPVq4EtzjJn+hC9poTSWc7rHBDpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814188; c=relaxed/simple;
	bh=vi7p3QlPew59ek8Aq94aGVbEB/hYXymU+ZAAlufSQgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2DeTnCXqrAdqEpCBoHPqeMzThFsBEvOnR0NlU42YtN2OL/kdxMiIiCJnCqvsaEn6rdC7QpY3NdwH29JY8+9FBpt7ERHMRdv1XPWM8wNOI/xQ3Ceokhx0+PJ5HZgUg0lrg+c9iFs36YVfFtV7LPYUshkFMnL8T4HQgeQWCQh2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO1+Ilmx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO1+Ilmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAE8C4CEDD;
	Mon, 24 Mar 2025 11:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742814187;
	bh=vi7p3QlPew59ek8Aq94aGVbEB/hYXymU+ZAAlufSQgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NO1+IlmxCeRaRGGhMtpCIfN1Cz6XfaYb+gIbH1whWwCWwtkON/ql+alcg8sUypOfg
	 4bAPTIq7l0jNfHXAuE5a1CyU17OuLSmmaA/LqfC8qx5xtsjXVt1ZbdeVJAuWnsKSST
	 cdWT+sMRzILkO4c8KaOB3t7WkBseLSqwlYkVRqLR2zQRvGVoGC+ghtPU+FW5jZrDme
	 AckQcOowbvi+9mJ6V+jpdFnwczqgS1payxCslFpBtkQbn3iYs9PWOp00rad/XgXwsJ
	 g4Ya44cGFFg7ZedTnBsHbGZd+wVtP/3a2FIjQJqdTdm0COzfjb/Vpp/GCZyjsLJiBZ
	 vw2YAACnInXzQ==
Message-ID: <9fd7f856-9e59-459d-9cef-903479e3d72a@kernel.org>
Date: Mon, 24 Mar 2025 12:03:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 9/9] mptcp: pm: add allow_new_subflow()
 interface
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1742804266.git.tanggeliang@kylinos.cn>
 <cd3f073e7d78588fa5ece014ff4f929946223aa8.1742804266.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cd3f073e7d78588fa5ece014ff4f929946223aa8.1742804266.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 24/03/2025 09:19, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The helper mptcp_pm_is_userspace() is used to distinguish userspace PM
> operations from in-kernel PM in mptcp_pm_allow_new_subflow(). It seems
> reasonable to add a mandatory .allow_new_subflow interface for struct
> mptcp_pm_ops.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h   |  3 +++
>  net/mptcp/pm.c        | 13 ++-----------
>  net/mptcp/pm_kernel.c | 21 +++++++++++++++++++++
>  3 files changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 8c1ac7368693..aedabc7f4190 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -135,6 +135,9 @@ struct mptcp_pm_ops {
>  			      const struct mptcp_addr_info *addr);
>  	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
>  
> +	/* optional */
> +	bool (*allow_new_subflow)(struct mptcp_sock *msk);

Maybe not needed, see my comment in patch 8/9.

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index ca105bbd03ea..215b3a4d24be 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -453,23 +453,14 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
>  bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
>  {
>  	struct mptcp_pm_data *pm = &msk->pm;
> -	unsigned int subflows_max;
>  	bool ret = true;
>  
>  	if (!pm->ops->accept_new_subflow(msk))
>  		return false;
>  
>  	spin_lock_bh(&pm->lock);
> -	if (!mptcp_pm_is_userspace(msk) && READ_ONCE(pm->accept_subflow)) {
> -		subflows_max = mptcp_pm_get_subflows_max(msk);
> -
> -		pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
> -			 subflows_max, READ_ONCE(pm->accept_subflow));
> -
> -		ret = pm->subflows < subflows_max;
> -		if (ret && pm->subflows == subflows_max - 1)
> -			WRITE_ONCE(pm->accept_subflow, false);
> -	}
> +	if (pm->ops->allow_new_subflow)
> +		ret = pm->ops->allow_new_subflow(msk);

From what I understood, callbacks should not be called under a lock. But
maybe this new callback is not needed, see my comment on patch 8/9.

>  	if (ret)
>  		pm->subflows++;
>  	spin_unlock_bh(&pm->lock);

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

