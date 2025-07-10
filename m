Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B632F0C69
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169267; cv=none; b=hqysUQ1D0HWJfOG6DA6Sm6wJJoFWCYQ48bUYjcycmJth+niyisnKjqre+O8ufECQRHAOZDSdV6Ivo8xjckhrC3VRC3SX++k5ItzScpMNhs0veuL33DnLBEr7NfnTzIi8QvI7V52vgNs1JGmJ2EXjABXVhYBXmVc2CCATupjEhIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169267; c=relaxed/simple;
	bh=DU/8cCiAoy6NNwwEpARrxq+mWERWbXYzsigUker0jTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fjLKLgOB1BO+bMzR7swQLeNWuEGZgAvLi515LIVUozPmfDw3eb81+w+Y5Q0VNmrrXd7uzgdyvzS1ktJB74OTZtOKW4rtjJx13teHY3Lr0SvRc2t/CubiBIh3Q8dMxYkVmO+7lcVH24UDzEFG03eipndMpVS6YoaOrfIQVw/Mb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHUGPlKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHUGPlKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F42EC4CEE3;
	Thu, 10 Jul 2025 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752169267;
	bh=DU/8cCiAoy6NNwwEpARrxq+mWERWbXYzsigUker0jTQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=IHUGPlKCO40eFK7giseZBp01yoS6gnXilV6wQyKk7l8uh5TsWEfgJzPxnZbO+42aP
	 3xOaGC1O8CDhfPx2nL/fKtYwDWgXdvLlCarp87hSpt+3SdewqZ6mQNWvPiDiTPXUS5
	 Lz+7toAfry3XKftlA9c6JwgulXXvDoZK2O1zYw7xI2403KaKtSOpbfJwrJaZIoOKL4
	 y7xBemETtlptlRozZwhumU7qiGd6f0amRryNUJ43F8MCaL5rE2Il5YZmlMVHx33kJ7
	 Gxo8kCtcIw2lsKONGHm5qAHmF6n+37yFtZZdZsZ4qkIoT7FhVZbzhMtn9ec+8j3/5L
	 9Rr/+cW/ZWfdw==
Message-ID: <c3f79dba-dcaa-45b4-9ee2-5145c32db16e@kernel.org>
Date: Thu, 10 Jul 2025 19:41:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 mptcp-net 0/5] mptcp: fix fallback-related races
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1752073685.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1752073685.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/07/2025 17:12, Paolo Abeni wrote:
> This series contains 3 fixes somewhat related to various races we have
> while handling fallback and 2 small follow-up likely more suited for
> net-next.
> 
> The root cause of the issues addressed here is that the check for
> "we can fallback to tcp now" and the related action are not atomic. That
> also applies to fallback due to MP_FAIL - where the window race is even
> wider.
> 
> Address the issue introducing an additional spinlock to bundle together
> all the relevant events, as per patch 1 and 2.
> 
> Note that mptcp_disconnect() unconditionally
> clears the fallback status (zeroing msk->flags) but don't tuch the
> `allows_infinite_fallback` flag. Such issue is addressed in patch 3.
> 
> Patch 4 cleans up a bit the fallback code, introducing specific MIB for
> each FB reason, and patch 5 drops the, hopefully now redundant
> pr_fallback().
> ---
> v2 -> v3:
>  - mptcp_do_fallback  -> mptcp_try_fallback
>  - refactored patch 3/5
>  - changed mibs names, increment fail only when the protocol mandate it
>  - fix W=1 warn in patch 5/5

Thank you for the new version!

It looks good to me, I just a few small questions, not really blocking
the series, and I can eventually do the small modifications when
applying the patches if you prefer.

> 
> Paolo Abeni (5):
>   mptcp: make fallback action and fallback decision atomic
>   mptcp: plug races between subflow fail and subflow creation
>   mptcp: reset fallback status gracefully at disconnect() time
>   mptcp: track fallbacks accurately via mibs
>   mptcp: remove pr_fallback()
> 
>  net/mptcp/ctrl.c     |  4 +-
>  net/mptcp/mib.c      |  5 +++
>  net/mptcp/mib.h      |  7 ++++
>  net/mptcp/options.c  |  6 ++-
>  net/mptcp/pm.c       |  8 +++-
>  net/mptcp/protocol.c | 97 ++++++++++++++++++++++++++++++++++----------
>  net/mptcp/protocol.h | 35 ++++++++--------
>  net/mptcp/subflow.c  | 40 ++++++++++--------
>  8 files changed, 140 insertions(+), 62 deletions(-)
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

