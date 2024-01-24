Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E510E6
	for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058893; cv=none; b=c7FzYnv5qGJgPpIinydidveJDUilH0/PKkJu8odFyKzO2TzCtaRFcvVihyIg36WXKMIU0MoPQTUvSpgkxpQLN11TRsDHREBH8e9L4Qaf/XG2QpvhfirUeXNdSzc8ms1dRiqF7otqbsDuN1tZnYRNfEKIMSJlOV8khvVHUNtVSY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058893; c=relaxed/simple;
	bh=6m5YiyeyWSjXdOlk5hJ15C+Q5L6NA77axKKcPtJyLJU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qzgMHFvrqjokfVT38TiqD0mguJZAF70RfKawk6lYD10o69wLrARtNG1D/S8c4VWhUmcQLp4/2Yw7GsxWUTeLGs0HAQpS2YoXCwY41Efw+tHbUorP2eCKd9nl0b4I4SRaeka4lsfNKp13Rlo8SB/RsVPJQkjQiZ6NkgPdAQqqBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCT60E16; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCT60E16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8D0C433C7;
	Wed, 24 Jan 2024 01:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706058892;
	bh=6m5YiyeyWSjXdOlk5hJ15C+Q5L6NA77axKKcPtJyLJU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OCT60E16ySgqzRcXd7QZjdhK0MdbNeawCx+s1EytBT6uDOY4ld1peeePzyE1uMB/q
	 9Pw+Rjd5Ii0P9tVjX9rxhsZlo8l8hybVJRvTzG9v1WzsA3sC3Dg+zIZCJKg002cx71
	 1KEcZmaMtZ+HcY6sual22mcQ5Fny5E4Kd8vtSBywbgNHhNNzMJMlZWKBfXBB7xb6vg
	 2/+NWypZSsggDHoJ9vOJMmMZ7yOEQkZlr3y4Cf2WlZ2K/ADP3uRJlt6w2rPhK7WZnr
	 yfbSa7SQTgnRiwox4yItNTt7FkEQ97I403snqi9F/lHqV9G4239FOCkXVFTzq3P2Zv
	 tdOg3V8ieWxaw==
Date: Tue, 23 Jan 2024 17:14:52 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: fix data re-injection from stale
 subflow
In-Reply-To: <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
Message-ID: <043ea620-cf44-e68c-ef4d-7d5986ec1b12@kernel.org>
References: <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 23 Jan 2024, Paolo Abeni wrote:

> When the MPTCP PM detects that a subflow is stale, all the packet
> scheduler must re-inject all the mptcp-level unacked data. To avoid
> acquiring unneeded locks, it first try to check if any unacked data
> is present at all in the RTX queue, but such check is currently
> broken, as it uses TCP-specific helper on an MPTCP socket.
>
> Funnily enough fuzzers and static checkers are happy, as the accessed
> memory still belongs to the mptcp_sock struct, and even from a
> functional perspective the recovery completed successfully, as
> the short-cut test always failed.
>
> A recent unrelated TCP change - commit d5fed5addb2b ("tcp: reorganize
> tcp_sock fast path variables") - exposed the issue, as the tcp field
> reorganization makes the mptcp code always skip the re-inection.
>
> Fix the issue dropping the bogus call: we are on a slow path, the early
> optimization proved once again to be evil.
>

Thanks for tracking this down, Paolo. Fix LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> Fixes: 1e1d9d6f119c ("mptcp: handle pending data on closed subflow")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/468
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 3 ---
> 1 file changed, 3 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 53d6c5544900..a8a94b34a51e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2339,9 +2339,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
> 	if (__mptcp_check_fallback(msk))
> 		return false;
>
> -	if (tcp_rtx_and_write_queues_empty(sk))
> -		return false;
> -
> 	/* the closing socket has some data untransmitted and/or unacked:
> 	 * some data in the mptcp rtx queue has not really xmitted yet.
> 	 * keep it simple and re-inject the whole mptcp level rtx queue
> -- 
> 2.43.0
>
>
>
