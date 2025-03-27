Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45A2116FD
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074860; cv=none; b=P5AhXCoouhIZLo7I82psOncPmu4k/BNrRrT8WvKUiGewWUgRqhpnQRDJsOdCVk5jtnC78iZdM/hM35kn5ua5q5yxLgloHzhFIXbBRVw6ZM442xuhOoUYYtUegl3sRtV4XA1ATxY3nuXBV5jPDJ1f4WEWWyD/GxaD4Yq02awXENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074860; c=relaxed/simple;
	bh=tQOn+LPBjv3oEF0jXdJjlxmvba/jrZqooypAFvtjtJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeizZTQ4X64VrtpJfJEE8xvyfMvrgalyhc7olCgzGJpnRk/RmZYmMdm/G0S69u9a7hwIz1ObTu4ODtO2Rzz3aocb3jVC1sG3G5RVEkafvkc980SEu5veSCuo9sVx4aqNDbFtGSiCVRwXKNVK7JFhREUqHyHjv611saHiukBwOn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLwKtrk0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLwKtrk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19B0C4CEDD;
	Thu, 27 Mar 2025 11:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743074859;
	bh=tQOn+LPBjv3oEF0jXdJjlxmvba/jrZqooypAFvtjtJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CLwKtrk0E0Mg5k4NFVfJSsgBADmEqe9EEzt0SXl7MOD4A1WDXzFk2qDGvKTdv7T9a
	 vcXrCGIwXkWKctx9Thp4XRn2Hbhu+MEkrGhqRqHnVno2TL3aEXcI98800+VkIx442C
	 I28H6PlAy5zjBEwvjIfQlfcpPBguiImDyYF/MfpIme55xtgckaZkB/aCLyR6biOWa5
	 7AVnlePsJaFZq9jZkOALjYhOWHMeMGdVv+B7aeORqb5dgGD8Aj0fytgRlSPhIB62C+
	 vV1PYY5JwH0dpKP+t4RVu9haK6WdDkfBom4S/VyRnREws4z88Ar2oVxYObbGpq07Gr
	 Hy075U0jSd60A==
Message-ID: <a00e1e7a-ad34-4b91-86b5-c585b88de6e6@kernel.org>
Date: Thu, 27 Mar 2025 12:27:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 3/7] mptcp: pm: use accept_new_subflow in
 allow_new_subflow
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
 <4de819beea2e553b61718a3b4c9b6180979961e0.1743054942.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <4de819beea2e553b61718a3b4c9b6180979961e0.1743054942.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 27/03/2025 07:04, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch reduces the dependency on mptcp_pm_is_userspace() to identify
> userspace PM from in-kernel PM by using mptcp_pm_accept_new_subflow()
> helper in mptcp_pm_allow_new_subflow().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c        | 27 ++++-----------------------
>  net/mptcp/pm_kernel.c | 10 ++++++++++
>  2 files changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 1c8395d3baa9..c72d2fade555 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -461,34 +461,15 @@ bool mptcp_pm_accept_new_subflow(struct mptcp_sock *msk, bool allow)
>  bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
>  {
>  	struct mptcp_pm_data *pm = &msk->pm;
> -	unsigned int subflows_max;
>  	int ret = 0;
>  
> -	if (mptcp_pm_is_userspace(msk)) {
> -		if (mptcp_userspace_pm_active(msk)) {
> -			spin_lock_bh(&pm->lock);
> -			pm->subflows++;
> -			spin_unlock_bh(&pm->lock);
> -			return true;
> -		}
> -		return false;
> -	}
> -
> -	subflows_max = mptcp_pm_get_subflows_max(msk);
> -
> -	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
> -		 subflows_max, READ_ONCE(pm->accept_subflow));
> -
> -	/* try to avoid acquiring the lock below */
> -	if (!READ_ONCE(pm->accept_subflow))
> +	if (!mptcp_pm_accept_new_subflow(msk, true))
>  		return false;
>  
>  	spin_lock_bh(&pm->lock);
> -	if (READ_ONCE(pm->accept_subflow)) {
> -		ret = pm->subflows < subflows_max;
> -		if (ret && ++pm->subflows == subflows_max)
> -			WRITE_ONCE(pm->accept_subflow, false);
> -	}
> +	ret = mptcp_pm_accept_new_subflow(msk, false);

I think it would make more sense **not** to call pm->ops callback under
the PM lock.

I think a BPF PM should not modify this structure directly. If something
needs to be changed, it should be done via a kfunc that will
automatically take the PM spin lock if needed, and release it at the
end. Only the "PM core" (pm.c) should modify it and the in-kernel and
userspace PM because they require a way to store data. A BPF PM can
store data in a map elsewhere.

> +	if (ret)
> +		pm->subflows++;
>  	spin_unlock_bh(&pm->lock);
>  
>  	return ret;
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index ee3915d33e04..5cc35ee122ff 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1403,11 +1403,21 @@ static bool mptcp_pm_kernel_accept_new_subflow(struct mptcp_sock *msk,
>  					       bool allow)
>  {
>  	struct mptcp_pm_data *pm = &msk->pm;
> +	unsigned int subflows_max;
>  	bool ret = false;
>  
> +	subflows_max = mptcp_pm_get_subflows_max(msk);

this variable is only needed for pm->accept_subflow && !allow, maybe we
should declare it there, and assign it only when needed?
> +	pr_debug("msk=%p subflows=%d max=%d allow=%d\n", msk, pm->subflows,
> +		 subflows_max, READ_ONCE(pm->accept_subflow));

Perhaps we can drop this pr_debug, or remove subflows_max: easy to get
the info from userspace.

> +
>  	if (READ_ONCE(pm->accept_subflow)) {
>  		if (allow)
>  			return true;
> +
> +		ret = pm->subflows < subflows_max;
> +		if (ret && pm->subflows == subflows_max - 1)

detail, I think it makes more sense to use "+ 1":

  if (ret && (pm->subflows + 1) == subflows_max)


> +			WRITE_ONCE(pm->accept_subflow, false);
>  	}
>  
>  	return ret;
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

