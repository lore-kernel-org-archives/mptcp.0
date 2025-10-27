Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9502F3B2A0
	for <mptcp@lists.linux.dev>; Mon, 27 Oct 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567474; cv=none; b=rPsaevceMIwBzrD0aUbWoiV8Ivm1ZFgcm+u4dM5/4qLhsD0kRwoRCteHSeV8v+Eseixd0otQTkQBzEoTTP8QseuWePFx7LNx9ICCoz9T3K5cZHYH0z/v8GcdshrDBAACyn5Clv+p/diCivL3eh/eGysSCM0TZb2V9EuQyWkdIxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567474; c=relaxed/simple;
	bh=zNQ08WTwtJw9sIv5R2cLFzJ1npBmiavxkcLNs1oJlcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZHu+Er76ErfcOrLu29dOVKei8Pbm8G8dg2bc+AtnaHPIyjtJ6xY34aOOaNMEefiU/sNg3ToxALZQfGjCPnbCciAc9WbzGh3g/HFyyaXqc3PwQiUED2whB7FfIi4IvC+w5WLSkqYPkg6RfWHrg0tY0htC3E1zmKxvx8vx2Ow1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3abM8Wh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3abM8Wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0954C4CEF1;
	Mon, 27 Oct 2025 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761567474;
	bh=zNQ08WTwtJw9sIv5R2cLFzJ1npBmiavxkcLNs1oJlcM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U3abM8WhFz4hPYCgVCwhR61+pfr0tCb/S+8+HMpzH450aQU7rodeHpUBCUMoORbFy
	 rR7A8X1WAVF+bQciqN8DGBZoj1MzKZPmsiWAm78jRHuqkqnKT+JXay0Ul0OBTjunF2
	 IMawDRRl0+bnIVXR7RH+9Ljny+Nmi/sxfJ6kf6WGTf7Lp4HYE7U9YCrdcX3ydC8Drm
	 j8sTmtQsT+GknJvYniZDZ3y8qGDSQkbqk55cBo6+t8BizWH7eBA6gD7NFsi4qtuxjb
	 CuVxWGCeo/miJbqcSOuuYNi3xQ883jWJLPzcsfUxVT8EpLUjxPm5stKgfd8qixckKD
	 FBh1c6xSWbEBw==
Message-ID: <938a5c96-baf2-46b6-ab3e-cd25d898009e@kernel.org>
Date: Mon, 27 Oct 2025 13:17:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 mptcp-next 00/11] mptcp: introduce backlog processing
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <cover.1761142784.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 22/10/2025 16:31, Paolo Abeni wrote:
> This series includes RX path improvement built around backlog processing
> 
> The main goals are improving the RX performances _and_ increase the
> long term maintainability.
> 
> Patches 2-4 prepare the stack for backlog processing, removing
> assumptions that will not hold true anymore after backlog introduction.
> 
> Patches 1 and 5 fixes long standing issues which are quite hard to
> reproduce with the current implementation but the 2nd one will become
> very apparent with backlog usage.
> 
> Patches 6, 7 and 9 are more cleanups that will make the backlog patch a
> little less huge.
> 
> Patch 8 is a somewhat unrelated cleanup, included here before I forgot
> about it.
> 
> The real work is done by patch 10 and 11. Patch 10 introduces the helpers
> needed to manipulate the msk-level backlog, and the data struct itself,
> without any actual functional change. Patch 11 finally use the backlog
> for RX skb processing. Note that MPTCP can't uset the sk_backlog, as
> the mptcp release callback can also release and re-acquire the msk-level
> spinlock and core backlog processing works under the assumption that
> such event is not possible.
> 
> A relevant point is memory accounts for skbs in the backlog.
> 
> It's somewhat "original" due to MPTCP constraints. Such skbs use space
> from the incoming subflow receive buffer, do not use explicitly any
> forward allocated memory, as we can't update the msk fwd mem while
> enqueuing, nor we want to acquire again the ssk socket lock while
> processing the skbs.
> 
> Instead the msk borrows memory from the subflow and reserve it for
> the backlog - see patch 3 and 11 for the gory details.
> 
> Note that even if the skbs can sit in the backlog for an unbounded time,
> 
> ---
> v5 -> v6:
>  - added patch 1/11
>  - reworked widely patch 10 && 11 to avoid double accounts for backlog
>    skb and to address the fwd allocated memory criticality mentioned
>    in previous iterations.
> 
> Paolo Abeni (11):
>   mptcp: drop bogus optimization in __mptcp_check_push()
>   mptcp: borrow forward memory from subflow
>   mptcp: cleanup fallback data fin reception
>   mptcp: cleanup fallback dummy mapping generation
>   mptcp: fix MSG_PEEK stream corruption
>   mptcp: ensure the kernel PM does not take action too late
>   mptcp: do not miss early first subflow close event notification.
>   mptcp: make mptcp_destroy_common() static
>   mptcp: drop the __mptcp_data_ready() helper
>   mptcp: introduce mptcp-level backlog
>   mptcp: leverage the backlog for RX packet processing

Sorry for the delay to apply the patches. Now in our tree:

New patches for t/upstream-net and t/upstream:
- 3a771ce1a023: mptcp: drop bogus optimization in __mptcp_check_push()
- b7ad5d80dff9: mptcp: fix MSG_PEEK stream corruption
- Results: 2a626f21446a..1ce735a9c1d6 (export-net)
- Results: 0d7b92893723..f23a9744c467 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/294a632909acc62a7656edc52770f9f59332af39/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/1035c9b6c98cf0d15998eb7ce53e5f81621e5116/checks


New patches for t/upstream:
- f0025b89c22c: mptcp: cleanup fallback data fin reception
- 905fec8ceabc: mptcp: cleanup fallback dummy mapping generation
- 8b29c30e82d2: mptcp: ensure the kernel PM does not take action too late
- 439f10b1648b: mptcp: do not miss early first subflow close event
notification
- 00804e3abc8d: mptcp: make mptcp_destroy_common() static
- 25c9415c554d: mptcp: drop the __mptcp_data_ready() helper
- Results: f23a9744c467..eb31e166f63e (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/54c37fb023bf32f10f60fb90d27a8fa800de426f/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

