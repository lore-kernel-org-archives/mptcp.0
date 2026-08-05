Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB93FADE8
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922225; cv=none; b=YBqCVv14J+LFEJqkh+2OmawbZqYjHkAli60GWbK5gPRxf0XmNez6gJAzqQ7Ee5dd40L3O+YuAnllEYB44lPgqiFo2cN/WWDjBznPOHob7hC/E5JJ0dGhSJ58TMlIGLF5HqAbidCaNUHvlgTsQTzN4Rk9GFDphFxYMst4NKDZ35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922225; c=relaxed/simple;
	bh=/GHXZHmMj9igSj5M9Ege/5AKl5mWut9pCaDAWsudgLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mP7SIhi4gu1BwYwT5wtIDAVW6gB4tx6cjxrEHuWqEgnWoZ9BhrX0FubfG4ag9k5OXtUAQBkTXUFKCMvaPtQ3/BQ7yZqgbRI+WIVywN2g/BZZZm3KuGG//nDjlUmyhslCOsQ0KwSggIxre9RueQdF7OFc7103iOfK96NLPFgsmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otmALQ70; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otmALQ70"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755DC1F000E9;
	Wed,  5 Aug 2026 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922223;
	bh=Qzt4zyw6L6OBGKq3RQVBrJ3tcrK6gO04O8aXZCE3dXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=otmALQ70UgQi/fonnuMGDFrv9QxPTHBGjcS6loK+80/z0qMcB2Jxm/x/SW6r9wY6f
	 IrAAgDdbU5y9/T2m5WQWHe0kenj2F0FwEdozZ3F4FboMCq4C+3kL9tEDz7NMt/bfhB
	 Ekda3Y6IKhI+vh6Tp/jNaNKiwpMLhAeFKLqVYmRqnq703w1u+zqrfQoVEijiKhF7in
	 J1qjNAEUutdUFfVr9MSvlJq6k/fiShSkkloroSWas4j/qEYMa3B4DGub9n70cZM4Gu
	 0qVeG6PHNVjmdbJ4D7Ei6lFGyaPL10enNjiou1WPYT2GNiW6JVBHGfhT/P0PL/uS02
	 HABuZkwop9PCg==
Message-ID: <6c00d0c3-8c93-445f-9c6e-c55401dac93f@kernel.org>
Date: Wed, 5 Aug 2026 11:30:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH packetdrill] mptcp: dss: validate tcp_rto_max_ms on
 DATA_FIN retransmissions
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com, janak@mpiric.us, kalpanjani009@gmail.com
References: <20260805064739.3087314-1-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260805064739.3087314-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

(Note: no need to add Mat, Paolo and myself in cc: only the MPTCP ML is
enough)

On 05/08/2026 08:47, Kalpan Jani wrote:
> The kernel patch "mptcp: honour configured min/max RTO in retransmit
> paths" makes the MPTCP-level DATA_FIN retransmission backoff follow
> the tcp_rto_min_us / tcp_rto_max_ms sysctls instead of the hard-coded
> TCP_RTO_MIN / TCP_RTO_MAX constants.
> 
> Validate it in dss_fin_retrans_established.pkt: set tcp_rto_max_ms to
> its minimum (1000ms). With the default 200ms rto_min, the backoff
> shift is then capped at ilog2(1000 / 200) = 2, so the retransmission
> intervals stop doubling at 200ms << 2 = 800ms. Add two more expected
> DATA_FIN retransmissions at that capped interval.
> 
> Without the kernel change, the backoff keeps doubling and the 5th
> retransmission arrives after ~1.6s instead of ~800ms, making the test
> fail.
> 
> Link: https://lore.kernel.org/all/20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com/
> Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
> ---
> Notes:
> - This depends on the kernel patch linked above: the test fails on
>   kernels without it (5th DATA_FIN retransmission at ~1.6s instead
>   of ~800ms).
> - Validated with the mptcp-upstream-virtme-docker environment:
>   passes on a patched kernel (ipv4/ipv6/ipv4-mapped-v6), fails
>   without the patch as described.
Thank you, it looks good to me!

Do you mind opening a PR instead, please?

https://github.com/multipath-tcp/packetdrill/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

