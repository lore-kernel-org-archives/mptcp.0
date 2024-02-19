Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B323775
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335852; cv=none; b=PcGLLG/o1mcSqsHlXkNyXeMaJagf7jJtYxinEGhMxNwf1fGK7RTTP0aEVgae7sd1yP8+l5422AijXCSCBg+y6O8vcGVBtrkRIXUQpsWvmjbfUPNdS95gcSmLAfFuT7+kHRElqbW00/aJdYkImmdlauRIBs5Jp2b88tucxLqRp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335852; c=relaxed/simple;
	bh=VEhy19/wcpSsCp937fCoCnmrVRFEOwo2rekbY244/to=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=UFqJroJTY874EnDVYBy9ogYSgVNCU+2PScCOp0rY0pOcVdKcV5EhlZHoEBfIc2JV/MuUtTG+wAl58TMz7sWFQYYzDSXxguCEKUrRq6ZPRqZvkX/lZBmX0Cdi6s6NBxQq1gJLGql/XzhKIBn3gkU6gpQdaCRN5EB+V0cZjZvD3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdHCUjgf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdHCUjgf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABDEC43394;
	Mon, 19 Feb 2024 09:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708335852;
	bh=VEhy19/wcpSsCp937fCoCnmrVRFEOwo2rekbY244/to=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=VdHCUjgfAOz6zSwmy6XcpwotkGkiJKBjOUNHVIwiZdd0jTWHnqzvwIgvhu6FwXKgF
	 FTUv0tHMKZEyT9EhqEQPG9oE7Ta8OaK16ePyvwllDyAT7iE0kXN974YtlYTmmt5/dn
	 EBa7AfDom84jl627N4Lx4Gb8/GtmXvMbk7v3LJIZiSENuWb42UZnSnypfD/QoM9yEC
	 uL9WWksETr6rIHUatX4LL5OEe8LKetuiTBFU1XXRwtejm3y2nXHVxH46RYzkpopBdr
	 ve6RAkrnZUFnALWQrKl6YUzmQ9KHWIbxjO1jH+njCyDNpbOcshG+x4XHjD8Mccx4c4
	 3fLckh36m+50Q==
Message-ID: <ea009366-506b-4b78-8293-aacb666488a7@kernel.org>
Date: Mon, 19 Feb 2024 10:44:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 0/7] mptcp: implement TCP_NOTSENT_LOWAT
 support
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
References: <cover.1708082765.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1708082765.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 16/02/2024 12:28, Paolo Abeni wrote:
> Patch 6/7 does the magic, all the others are minor cleanup and fix of
> buglet exposed by such feature. I'll push a paired pktdrill test.
> 
> Note that this relies on the existing accounting for snd_nxt. As I
> stated such accounting is not 110% accurate as it tracks the most recent
> sequence number queued to any subflow, and not the actual sequence
> number sent on the wire.
> 
> I experimented a lot trying to implement the latter and in the end it
> proved to be both "too complex" and "not necessary".
> 
> The complexity raises from the need for additional lock and a lot of
> refactory to introduce such protection without adding significant
> overhead. Additionally, snd_nxt is currenly used and exposed with the
> current semantic both eBPF and the internal packet scheduling.
> Introducing a different tracking will still require us to keep the old
> one.
> 
> More interesting, a more accurate tracking could be not strictly
> necessary: as the MPTCP protocol enqueues data to the subflows only up
> the available send window, any enqueue data is sent on the wire
> instantly, without any blocking operation short of a drop in the tx path
> at the nft or TC layer.
> 
> The individual patches changelog carry the gory details.
> 
> Still sending a single series to outline the functional requirements,
> even if the first 3 patches could land on mptcp-net directly.

Thank you for the patches, and the reviews!

Now in our tree (fixes for -net, and feat. for net-next):


New patches for t/upstream-net and t/upstream:
- d9b01cb9adc7: mptcp: push at DSS boundaries
- 1ea124e2ca57: mptcp: fix snd_wnd initialization for passive socket
- c64351cfe29e: mptcp: fix potential wake-up event loss
- Results: 086d253b7038..9dcf86462a59 (export-net)

- efe1cf277159: conflict in top-bases/t/DO-NOT-MERGE-git-markup-net-next
- Results: 8de48203098c..4f7ce06a0f9e (export)

New patches for t/upstream (only):
- 232c91fcaf38: mptcp: cleanup writer wake-up
- 1e762225d9b2: mptcp: avoid some duplicate code in socket option handling
- 51913f3f330f: mptcp: implement TCP_NOTSENT_LOWAT support
- eb5db737fdac: mptcp: cleanup SOL_TCP handling
- Results: 4f7ce06a0f9e..f2fb9bec2195 (export)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
