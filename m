Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC864AA1C3
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367174; cv=none; b=G73ECvr4U3+ClpqV96Xsp4MRNFk+pSEbQwEa+dsPDB4H6zeVJ2jMdZ/MgJjOsqG1Bl9/fWSPQaFpIaluWFyonYTLiFlZVOxJ3FEhLsoRckoLJV7kl1w1x2VWQzhHm+3ibjgvSq/3jpLtWYFs0+KvjfvvHLEbvzqXU1Jq6kZlqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367174; c=relaxed/simple;
	bh=IxH+TcPFr9sHL+530fEBm6z5qUloI3xUMLjzxQ/REZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXdzanSp72hxSpZIIOdVbfFW/F70LEghNSz+ia9MMqA5nWErosAO13hkILpu5/RuCETUZ7zKhzhBx8vAVOMsS1rkay9jnivZ6ec5jjQc/nUZiw2mlSAf12wKsgfbMqwtCezArfTKVzbqECQTJdwzfgzLZsEsWyO/hioDFn0lv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otjR0lMt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otjR0lMt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A407B1F000E9;
	Wed,  2 Sep 2026 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788367171;
	bh=7UF9//x9ZInEFdxEVRUB4TF7+NOCSl/CF1dEkXjiuZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=otjR0lMt7do8vvOOekPt80z/mV7g4owGxRwx0D4Tr9DHofu0FuwW+Jy4M/aO6CNff
	 T9LCjWy50k2Di3mVxQ5QjbqeaN+Qz5F2dPuhm+up0oAAQokASrcUvZrSUQG1W+wGGI
	 XIHuV6o3cooNOviplhHwar/R8fh4YPSX3HqX5czyoncC4QJsKyfLY80ldCYtxfUa1b
	 4n3TTOJEn7SJtPVEKKV4Abwn6tttWxm7aH6o8cKQVSylgSxxXuWSMz3gVjcrGbqfME
	 FdrD4hgauKILetJmFhtPkLWj5DMTErt5EsAfM4rJcWXL+wrmeEHdERqpLHkgc/P+2D
	 v5RFxSB1NSTjQ==
Message-ID: <c8c4f667-5d25-4d94-8627-387d4091c8c4@kernel.org>
Date: Wed, 2 Sep 2026 18:39:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] mptcp: pm: bound extra_subflows admission
 on userspace PM
Content-Language: fr
To: Tao Cui <cui.tao@linux.dev>, mptcp@lists.linux.dev
Cc: geliang@kernel.org, cuitao@kylinos.cn, Quanye Yang <quanyeyang@proton.me>
References: <20260831093206.689827-1-cui.tao@linux.dev>
 <20260831093206.689827-2-cui.tao@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260831093206.689827-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tao,

+ cc Quanye

On 31/08/2026 11:32, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> mptcp_pm_allow_new_subflow() increments the u8 extra_subflows counter
> for every accepted MP_JOIN on sockets using the userspace PM, without
> any limit. A peer establishing more than 255 live subflows wraps the
> counter back to 0, which then makes the underflow guards warn on the
> next subflow close, and permanently corrupts mptcpi_subflows_total
> reported to userspace.
> 
> Refuse new MP_JOINs once the counter has reached U8_MAX, so that it
> cannot wrap anymore.
> 
> Fixes: e99c1ca89071 ("mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/629

Do you have a GitHub account? Just to know if we can assign this task to
you (or just leave a message in the comment section).

> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  net/mptcp/pm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 8b68868255c5..3990f6775723 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -562,10 +562,17 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
>  
>  	if (mptcp_pm_is_userspace(msk)) {
>  		if (mptcp_userspace_pm_active(msk)) {
> +			bool allow;

"ret" could be re-used here.

> +
> +			/* extra_subflows is a u8: don't let a peer wrap it
> +			 * with more than U8_MAX accepted MP_JOINs
> +			 */

I don't think this comment is needed, "< U8_MAX" is probably clear enough.

>  			spin_lock_bh(&pm->lock);
> -			pm->extra_subflows++;
> +			allow = pm->extra_subflows < U8_MAX;
> +			if (allow)
> +				pm->extra_subflows++;
>  			spin_unlock_bh(&pm->lock);
> -			return true;
> +			return allow;
>  		}
>  		return false;
>  	}

So, at the end, we can re-used the same version as Quanye. Would it be
OK for both of you to have a Co-developed-by tag here?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

