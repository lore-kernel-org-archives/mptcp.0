Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EA13AA46
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112924; cv=none; b=sj1gmLx8edEzOqdABCIOr5tEMFz6nyuog+9HXyn78E8cfR7GHgTiKcFiDZdgmIvOJPthL7ZXBDVwP5l+CY93vB0ZhlQYytNS4UW4I3+xpQGsAM6Lo/zI/h0MsSin59aaFxvBSWJU5fvRPdJNslWF1DmoRNHnTQYB9N1/RO4moQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112924; c=relaxed/simple;
	bh=KWNQgcUNu9K6byZab9271hwqo1ywNhVflAsCOs4d5HY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I2AeVAzyyAqKKaMhIdAjWjUUwjShjgFo9U3T/eWI2rxjCctRNSohK1UbAh3qg46tvBGYYIvhyeGyEJnRzpZKBMs97MAsHxKDvKn/o3k0YRlIVXD+FG1kMEJWYrKgAzGUW+5R5djDR1lSsvBj4uhzZv+6imflF+iRfoVy5y4uDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxvpJ2Wc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxvpJ2Wc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F7CC433F1;
	Fri, 16 Feb 2024 19:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708112924;
	bh=KWNQgcUNu9K6byZab9271hwqo1ywNhVflAsCOs4d5HY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=SxvpJ2WcxTvHcXmJVc/HFmEBp+69TbniHYn/IgrM+n/BRCxqRIsRpOGf79GaknRUi
	 1hIxeZr5WE7qd9FVV4urjIZHiWBxgxjFIMskHLVUrvhwnONrlhdDTnvw/mKvCnOiHI
	 z+4ZpfC5bmP4cvLaLA97X9z5QHbuuytSFME8KN/y7jE/eokui9L9KRvLUt0L/LKVq5
	 lvqQsCYLcJ6ZXYVd5oJoqKksO9S/tcG2tuXGMn24ZvtPfjwpnnnlKi4KkD/O8Wdpko
	 4zmYkcSyL/FnMx1wKTflB3crg9JAURNT1YxLMH3JX+AWnafe56wgmlJ+OgladCOIvY
	 A14s6uMoBd+nA==
Date: Fri, 16 Feb 2024 11:48:43 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 net-next 0/7] mptcp: implement TCP_NOTSENT_LOWAT
 support
In-Reply-To: <cover.1708082765.git.pabeni@redhat.com>
Message-ID: <042c077b-848d-1642-08ff-9428018ac5fd@kernel.org>
References: <cover.1708082765.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 16 Feb 2024, Paolo Abeni wrote:

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

v3 of the series LGTM, thanks Paolo.

Matthieu note that this series is split between mptcp-net and mptcp-next:

> Still sending a single series to outline the functional requirements,
> even if the first 3 patches could land on mptcp-net directly.
>

Reviewed-by: Mat Martineau <martineau@kernel.org>


> v2 -> v3:
>  - typo in patch 1/7
>  - dropped unused code in patch 3/7
>  - dropped duplicate code in patch 6/7
>
> v1 -> v2:
>  - clarifiy commit message in patch 1/7
>  - fix possible wake-up bug in patch 6/7
>
> *** BLURB HERE ***
>
> Paolo Abeni (7):
>  mptcp: push at DSS boundaries
>  mptcp: fix snd_wnd initialization for passive socket
>  mptcp: fix potential wake-up event loss
>  mptcp: cleanup writer wake-up
>  mptcp: avoid some duplicate code in socket option handling
>  mptcp: implement TCP_NOTSENT_LOWAT support.
>  mptcp: cleanup SOL_TCP handling
>
> net/mptcp/protocol.c | 57 ++++++++++++++++++++++++-----------
> net/mptcp/protocol.h | 51 ++++++++++++++++++++++---------
> net/mptcp/sockopt.c  | 71 ++++++++++++++++++++------------------------
> 3 files changed, 108 insertions(+), 71 deletions(-)
>
> -- 
> 2.43.0
>
>
>
