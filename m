Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764CA22371C
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734878; cv=none; b=fzsCre5ScOIEfG4kFtQ9VA4TejiOJzzIxFkv+DE60OLyLciFSd6+Dgsb/NUlU3m+S/MBsdvn3VrO5/2EZba999uRZj3jOoW0HKMeOqntX1uUxH/WqXfDmVvoFKI/IUw/kPSyYkXb09ZVFHsmPAy93adBwS9qvQwGqWtrSPsVzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734878; c=relaxed/simple;
	bh=Vq13FsiOpbAwRFmM70vaAe6+vu5ZrxS7baEvpMhXOgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZwG2ebF1ZzJyutEByFClK8O1HpWbw9i8TxYGBVpn2hSJgrSJvSs6fIERu6pKiasslhwyz9/HkQ0jrGq14NM/aJC3OAv6dBZCGf4zcyDNv993jjlqYuezERTGX2S7zxERollz4LQheXR0sN+exQcyHiogz6P2P0NOduvvMtfMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2sDNHtp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2sDNHtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65526C4CEE9;
	Tue, 11 Mar 2025 23:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741734878;
	bh=Vq13FsiOpbAwRFmM70vaAe6+vu5ZrxS7baEvpMhXOgU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W2sDNHtpAym66AMhA0shhdPkSxyKBBguHMKVCE4Lc18IVOC1monIyYNtX1GQLDZJR
	 QxUkhByepyH/WRCJb0P9kNLOgcVs41kVZOMB3c105COmBcrCsPZRwUBoAIo1uN/gWg
	 1SpWm/apBsf9Rcw0QSoRdcuR9ps6jwkDLnUJl9BIBoL164S7l13VPrPH3kEnuppgBc
	 85bWZiW8MxmJm4AlU527c7PPAbkcVJ6yQF1aWIGm5zNSHYOZVwJWPcYLvivgZ1O5Zl
	 QPG4jD9OPK5oZzljwacvoYazgX52wLz+cbOyPI78G7DSmzCLqhfn2SU+GpwF5X3h8N
	 eIiP/iLcP5d/w==
Message-ID: <21d50dd6-230c-4cbd-af2e-b971c7945c62@kernel.org>
Date: Wed, 12 Mar 2025 00:14:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 1/6] mptcp: pm: add allow_new_subflow()
 interface
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741685260.git.tanggeliang@kylinos.cn>
 <afd03e1f1f0972d695c6fbd603699fbbe6cda3ff.1741685260.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <afd03e1f1f0972d695c6fbd603699fbbe6cda3ff.1741685260.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 11/03/2025 10:32, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The helper mptcp_pm_is_userspace() is used to distinguish userspace PM
> operations from in-kernel PM in mptcp_pm_allow_new_subflow(). It seems
> reasonable to add a mandatory .allow_new_subflow interface for struct
> mptcp_pm_ops.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h      |  2 ++
>  net/mptcp/pm.c           | 36 +++---------------------------------
>  net/mptcp/pm_kernel.c    | 27 +++++++++++++++++++++++++++
>  net/mptcp/pm_userspace.c | 14 ++++++++++++++
>  4 files changed, 46 insertions(+), 33 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 6a08ac862bbe..af995387248b 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -123,6 +123,8 @@ struct mptcp_pm_ops {
>  	bool (*get_priority)(struct mptcp_sock *msk,
>  			     struct mptcp_addr_info *skc);
>  
> +	bool (*allow_new_subflow)(struct mptcp_sock *msk);

(When looking at "struct tcp_congestion_ops", I wonder if we should not
add a comment here to know if it is required or optional.)

(...)

> +static bool mptcp_pm_userspace_allow_new_subflow(struct mptcp_sock *msk)
> +{
> +	struct mptcp_pm_data *pm = &msk->pm;
> +
> +	if (mptcp_userspace_pm_active(msk)) {
> +		spin_lock_bh(&pm->lock);
> +		pm->subflows++;
> +		spin_unlock_bh(&pm->lock);

I wonder if it still makes sense to let each PM updating pm->subflows.
It sounds like it would be better to do that from pm.c, e.g. if this
callback returns true.

(Same when creating a new subflow, maybe something could be done there
with a new helper, but maybe not because different locks are needed...
Anyway, we can look at that later I suppose)

> +		return true;
> +	}
> +	return false;
> +}
> +
>  static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
>  {
>  	mptcp_userspace_pm_free_local_addr_list(msk);
> @@ -691,6 +704,7 @@ static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
>  static struct mptcp_pm_ops mptcp_pm_userspace = {
>  	.get_local_id		= mptcp_pm_userspace_get_local_id,
>  	.get_priority		= mptcp_pm_userspace_get_priority,
> +	.allow_new_subflow	= mptcp_pm_userspace_allow_new_subflow,
>  	.release		= mptcp_pm_userspace_release,
>  	.name			= "userspace",
>  	.owner			= THIS_MODULE,

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

