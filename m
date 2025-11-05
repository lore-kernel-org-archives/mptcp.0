Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC12F90DB
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335741; cv=none; b=jOYaMcgJt7itCBhvnHlO2Ti8xZ1Qjhdava71CG/pgS5N2HWVNGdpSIgSuZmQ8oRfqwyKPKWvek1nWWc3XNVzh+Fa894vJtLZdJgqJPwHwgQx8gibpD5uX4Iq2lcvyrQvfRB3qdyWlalYe7ZRx83+JP/L51yceThbr5t8aBFeLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335741; c=relaxed/simple;
	bh=sNFq5tpKc9uRfs6rSdf24puv1qoUeFhADjmlQCvafYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKe3fYM3uiv3MzJ7AxBjIkiVOfKW1dxbHMwl0NRCv+NIm0GnPyJP3/64TRG6NdAEeRt9wKpjG33fSaYyA+6HyJL0oiGnC3mVH6kNBFb4nJR1zTCMvODGWSDDCPDXH2RshZrT510egbjmctXg279v3pnwDcbVkljVORP0Vz/mfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOh7X0VX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOh7X0VX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71384C4CEF8;
	Wed,  5 Nov 2025 09:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762335741;
	bh=sNFq5tpKc9uRfs6rSdf24puv1qoUeFhADjmlQCvafYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mOh7X0VXu8bStwuTl5KqBrcSMh5LRAgmuiYSUCf/09XzUXH8BuaySFByDg06QV4AM
	 YJZrTvgr4IPGXCNumJzw4GHc6C2QgC5segicK4nFP+OD1AmgsitV3bv8NPsWbux95j
	 lPJ1+mLAjMFRlG1usTvs4DlVqp/EvYgdea+QHRs3ozm6kydBypiSD1LyFoWWMY7zx+
	 NJJBHATPYmeo4M8ShMSNhovRiTACPdXsb2vv3G/Movy/znghRkGM4anlfWzbj2EmZe
	 vr7cUlj8DSx7ixDhQnYtzQhsdCViiIHlG5llQNBqNgcN5Kq6guqU0+UYftALaMvl/D
	 vREacmyQJjjjw==
Message-ID: <2d681554-51de-4cad-a81c-789cc32ac406@kernel.org>
Date: Wed, 5 Nov 2025 10:42:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v8 0/4] mptcp: introduce backlog processing
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
References: <cover.1762271864.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1762271864.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 04/11/2025 16:59, Paolo Abeni wrote:
> This series includes RX path improvement built around backlog processing
> 
> The main goals are improving the RX performances _and_ increase the
> long term maintainability.
> 
> Patch 1 and 2 refactor the memory account logic in the RX path, so that
> the msk don't need anymore to do fwd allocation, removing possible drop
> sources.
> 
> Patch 3 and 4 cope with backlog processing. Patch 3 introduces the
> helpers needed to manipulate the msk-level backlog, and the data struct
> itself, without any actual functional change. Patch 4 finally use the
> backlog for RX skb processing. Note that MPTCP can't use the sk_backlog,
> as the mptcp release callback can also release and re-acquire the
> msk-level spinlock and core backlog processing works under the
> assumption that such event is not possible.
> 
> A relevant point is memory accounts for skbs in the backlog.
> 
> It's somewhat "original" due to MPTCP constraints. Such skbs use space
> from the incoming subflow receive buffer, but are fwd memory accounted
> on the msk, using memory borrowed by the subflow.
> 
> Instead the msk borrows memory from the subflow and reserve it for
> the backlog - see patch 2 and 4 for the gory details.
> ---
> v7 -> v8:
>   - only minor changes: typos, added warn_on().
>   - notably no BL loop limiting, as discussed on previous iteration
> 
> Paolo Abeni (4):
>   mptcp: handle first subflow closing consistently
>   mptcp: borrow forward memory from subflow
>   mptcp: introduce mptcp-level backlog
>   mptcp: leverage the backlog for RX packet processing

Thank you for the patches and the reviews!

Now in our tree:

New patches for t/upstream:
- acccba36fa8b: mptcp: handle first subflow closing consistently
- 858caff062de: mptcp: borrow forward memory from subflow
- 4a9aeb444ecf: mptcp: introduce mptcp-level backlog
- d09fc4521e3a: mptcp: leverage the backlog for RX packet processing
- Results: 24301f878352..c0bd85030030 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/288a453d00d9ed545fa108e32485f407a07a6d32/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

