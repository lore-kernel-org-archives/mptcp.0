Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122231922F5
	for <mptcp@lists.linux.dev>; Mon, 20 Jan 2025 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737361511; cv=none; b=bMxd+FEX2SbWk551vphgSFE862DiUUO+ZxWx338GJbfb5KawkDzKLP3cgYF7Y4r4bTr1niS/nu5Vu1FWDu8LLbCZ1AjRPP3bkdNGY+3NdxVcNyI9ntIi6YDLQaRSCfeoVi/aX2Lyo6i+Cpz8WzQcZMYp5s4ikMB3KLxobKzotpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737361511; c=relaxed/simple;
	bh=u6ns5xJNqxYowkVYayL/v1jr2KlK3rBLhBz1qyKSIao=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=YQUWKccrQjpo1SSKFMiGMlrAnBBUitFmp4GbCoIpBkOzlA81TQwj+4gsm3kIpLG7y9nCcUJmpUiUB3Z5FSwpvgPIVbABAfWjH3adkiiPJeTTJTp+YrPtZCdKA9xaPsuSAlVthjOUSN8DtxvMAZAOLR26AkapiFrmr9PGuHj+dT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJcnX53F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJcnX53F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4C3C4CEE2;
	Mon, 20 Jan 2025 08:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737361510;
	bh=u6ns5xJNqxYowkVYayL/v1jr2KlK3rBLhBz1qyKSIao=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=VJcnX53FCRhqCFcWlhw6xrt4Hopq6fuU0qIgPk2DokwpiTwb1OQ63q1lW5xclKvVN
	 lDfRy5H6oNJiZYVruXzpg3KNDv+D1DCAoXXzQSNtZfxE17hI0Zybs/Kj1mOw4Ot7aY
	 Zu4czj244AXgu+tzeJH/HEjNd7Hwpl6byT3zfnMmhcwn0hTeXoVRP6D6CMkh+Fwe+Q
	 V23tXHQVLAqXZqobU7qXG1aBR5S+qjmHfFdr9wGf0dcknnRxSUZaFtQavlEzjCSSqg
	 +CccDRwiclbQ9/Ayo5hLd5zaPt+eZXC8GR/dCeM8j1qxe2rTHPvTsTDGKRhlH+Y1EI
	 TPfgWtvtaIOoQ==
Message-ID: <511974ed-3c75-425e-bd6a-af393fb09344@kernel.org>
Date: Mon, 20 Jan 2025 09:24:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: handle fastopen disconnect correctly
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <e8371ec8065e09317dcf7d7aabc6c54e63634bbb.1737222305.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e8371ec8065e09317dcf7d7aabc6c54e63634bbb.1737222305.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 18/01/2025 18:46, Paolo Abeni wrote:
> Syzbot was able to trigger a data stream corruption:

(...)

> The root cause is the bad handling of disconnect() generated
> internally by the MPTCP protocol in case of connect FASTOPEN
> errors.
> 
> Address the issue increasing the socket disconnect counter even
> on such a case, to allow other threads waiting on the same socket
> lock to properly error out.

Thank you for having looked and fixed this!

> Reported-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/537
> Fixes: c2b2ae3925b6 ("mptcp: handle correctly disconnect() failures")
> Tested-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1b2e7cbb577f..f910e840aa8f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1767,8 +1767,10 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  		 * see mptcp_disconnect().
>  		 * Attempt it again outside the problematic scope.
>  		 */
> -		if (!mptcp_disconnect(sk, 0))
> +		if (!mptcp_disconnect(sk, 0)) {
> +			sk->sk_disconnects++;

I guess it makes sense to have something similar to what is done in:

  net/ipv4/af_inet.c:__inet_stream_connect()

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

>  			sk->sk_socket->state = SS_UNCONNECTED;
> +		}
>  	}
>  	inet_clear_bit(DEFER_CONNECT, sk);
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

