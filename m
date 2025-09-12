Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCB265CC9
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720087; cv=none; b=isWasaWWrl+88JIs7Nw3y4AGP05O+LTzWH7st1LtFTsZW+YYNGifSbXyXK3ssLD0OrSvFiLPnc5E7HmMxGoUVCKa0/FEWia3n2y2VJW4nMvH6sST133LlY6Bx2NSRWk4PSNXELdfdXBMQiqwFZK8DFsnQoEAShy7HrJzEzU8ND0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720087; c=relaxed/simple;
	bh=58L1wEL453AqYQL3dhJjWox2AgRKbiC+dHF1JYAVKxg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gu5HGb0/k1u+skgXHaj7JXmQqabeGoDOQSyicGypl51PHifFVJ9nisQnehYioV8gSIhMV0XUEGjFwlesw9Exsv5uPysKsTSpre2myaBBy1nMbrWrjHcXJsbz7Cy7S96U9EuBI4lKpE23NFMsjsFfi2ZRO+5l+6F037qRiuX3+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuMy3fOP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuMy3fOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53897C4CEF1;
	Fri, 12 Sep 2025 23:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757720086;
	bh=58L1wEL453AqYQL3dhJjWox2AgRKbiC+dHF1JYAVKxg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CuMy3fOPZMo0mbRcsBBA2pkvcJGAH2NL+o6cSpeIgh0Tk+8IRDSIjL/Aje0LVAZz7
	 tS/FxsZK2X6rVs7yVJjOS4bwuwXip0Va+C0dFE0XnIZ61rNl39Jvd5RfjDkOkTjy0M
	 0OiSsUJQFNCoH2LxdvBQ9qaIOP+GeYVCs5Mrp99IYu5PxHiIi5WtAb50ESIQbXIUyJ
	 uoExD4txsF5MknE6Ku8ABjCw3L9yP0Dpd38NiShJDjqzC/n89qgdpomU0ohuex5SW4
	 kCxYH0LXSLu03CBch0ECcFVbCl3PJxVeCcXa6IokrzQKUWhfQsEyQGhrnqstda4VgP
	 16MDqtmVrKOgg==
Date: Fri, 12 Sep 2025 16:34:45 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 3/9] tcp: drop release and lock again in
 splice_read
In-Reply-To: <89fd2ab6630a8aceceef58273faae8db195ef2e6.1756780274.git.tanggeliang@kylinos.cn>
Message-ID: <397811f8-3684-0457-eb02-6fd16cb42876@kernel.org>
References: <cover.1756780274.git.tanggeliang@kylinos.cn> <89fd2ab6630a8aceceef58273faae8db195ef2e6.1756780274.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 2 Sep 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> In the main loop of tcp_splice_read(), release_sock() is invoked to release
> the socket lock, and then lock_sock() is immediately invoked to hold the
> socket lock again.
>
> It looks like these two calls are useless, so let's drop them.

Hi Geliang -

I think the intent here is to allow incoming packets to be processed from 
the backlog before __tcp_splice_read() is called on the next loop 
iteration, so there's a chance that more data can be processed in a single 
call to tcp_splice_read().

Was this lock reacquisition causing any issues?

Thanks,

Mat


>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/ipv4/tcp.c | 2 --
> 1 file changed, 2 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index c9eb94a6c41a..c6425f13afd0 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -866,8 +866,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
>
> 		if (!tss.len || !timeo)
> 			break;
> -		release_sock(sk);
> -		lock_sock(sk);
>
> 		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
> 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
> -- 
> 2.48.1
>
>
>
