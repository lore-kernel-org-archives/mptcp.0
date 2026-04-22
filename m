Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CB1DF248
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872131; cv=none; b=P0Ok7s/j0WpwrC86coWei1VmA4TvMUu63tVZsPoYgf+EmZdkk2EObovoIH8A0UlY2iHhC94d9PqfvX4uX6jA7lCBO9Nd3cgByGS7DXrWu9IogXwBSWcqBgXLvjfHHAop+fphpImJpP/cfIZ5Tj5YEx6feBOhFzQDDHdUGRgImds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872131; c=relaxed/simple;
	bh=jiLmiZrB62X7c5NczhyFMsjYvTBF3E3c0rvov2JS57w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J+rI2hZ8hjS5z3j+C68z7KIldpHnzw0R3Co2ZwuGZA7UfImB2tAFecNWnu3BmLTZ7+I7pl5T2ZFjzFuCfYIzJq41TCBBFXNJBUH+oTvwWgJIqS2wl0GoGUWqNuLYIs+RtZhOzXqQMRfuxC45YWPxB7CgIfI4b0OUUMlfN7VScMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW0dqhli; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW0dqhli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5A5C19425;
	Wed, 22 Apr 2026 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776872131;
	bh=jiLmiZrB62X7c5NczhyFMsjYvTBF3E3c0rvov2JS57w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UW0dqhli7z2jxYdvaHAvxviJ0EWS36jrR/wAdDPi3EHILDUB284my0Paro9xoN289
	 KvTt7k7sudUs1WeNV3FbouNfcenWResiNQi9NdmWS+eOp2RnZE1YThK+vD9PRmrn6f
	 761K/QTICZo19c8ypvtF2JPcAi8g8KZaATRs5PcVtiyoqCDq7fKcH4TBdp+IV6pUQM
	 aJK7WBPG5+dr/CfXSKjAsF0Pyyk9WLbxti10FdjYFm4X+7zoihQFzEqzBuIPtaiX1b
	 haYwrzx4Wjfmk9wQ0N6kQEDTGOD6ItPoFTb9WpnHiO5b+lC8j3ubOA4mkvenZXbOr7
	 yn9qJpTmk0G5g==
Date: Wed, 22 Apr 2026 08:35:30 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>, Lance Tuller <lance@lance0.com>
Subject: Re: [PATCH mptcp-net] mptcp: fastclose msk when linger time is 0
In-Reply-To: <20260421-mptcp-fastclose-linger-v1-1-de94d7bffc0a@kernel.org>
Message-ID: <0aebb36a-fabb-d189-255b-d6c630c08c3e@kernel.org>
References: <20260421-mptcp-fastclose-linger-v1-1-de94d7bffc0a@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 21 Apr 2026, Matthieu Baerts (NGI0) wrote:

> The SO_LINGER socket option has been supported for a while with MPTCP
> sockets [1], but it didn't cause the equivalent of a TCP reset as
> expected when enabled and its time was set to 0. This was causing some
> behavioural differences with TCP where some connections were not
> promptly stopped as expected.
>
> To fix that, an extra condition is checked at close() time before
> sending an MP_FASTCLOSE, the MPTCP equivalent of a TCP reset.
>
> Note that backporting up to [1] will be difficult as more changes are
> needed to be able to send MP_FASTCLOSE. It seems better to stop at [2],
> which was supposed to already imitate TCP.
>
> Validated with MPTCP packetdrill tests [3].
>
> Fixes: 268b12387460 ("mptcp: setsockopt: support SO_LINGER") [1]
> Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios") [2]
> Reported-by: Lance Tuller <lance@lance0.com>
> Closes: https://github.com/lance0/xfr/pull/67
> Link: https://github.com/multipath-tcp/packetdrill/pull/196 [3]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/protocol.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

LGTM, thanks Matthieu!

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6b486fc94c16..0db50e3715c3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3302,7 +3302,8 @@ bool __mptcp_close(struct sock *sk, long timeout)
> 		goto cleanup;
> 	}
>
> -	if (mptcp_data_avail(msk) || timeout < 0) {
> +	if (mptcp_data_avail(msk) || timeout < 0 ||
> +	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
> 		/* If the msk has read data, or the caller explicitly ask it,
> 		 * do the MPTCP equivalent of TCP reset, aka MPTCP fastclose
> 		 */
>
> ---
> base-commit: 3662f0d0a0b4cdc50193718dd64af57d671ebd59
> change-id: 20260421-mptcp-fastclose-linger-f041352cd5e5
>
> Best regards,
> --
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
