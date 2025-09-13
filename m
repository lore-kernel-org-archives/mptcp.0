Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ECB6BB5B
	for <mptcp@lists.linux.dev>; Sat, 13 Sep 2025 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724680; cv=none; b=r67vnqdcrZfxUvZ+WhYknPWGsw8ggzG+g8LvAfq0zuhsDEMAEavVxVueZ5Wf9Ut9iUUv7navCqrfyhOSRckwFbgquZhTAJDst0qtt6PimBFK/1V3qTBY7pdaNh7KQc13LwmoiLtFkohGGaIq1qKmk8XyK8nRvU3n3i8onBnTOGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724680; c=relaxed/simple;
	bh=wsCMWK9O0Z/PM63c7I2uDIrzDne20DMQ6CeX9RZe4po=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHS/BbT+gAbK/xh8kijSc9wH7k5P1i+2y1t8RpiPkH8ocS1/aVqS41ecgW2p6RdkfsK9PZehSkpd2MKFlnKk5/7TQ6rdd7KzVR1Bv1+CSN306s4lT2WkSR8CXks2U9yUQD1x429de3T04y3Ue8Nwc+17bhq6Oq8vLfZ9SSI7g/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtMp5n5B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtMp5n5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2A4C4CEF1;
	Sat, 13 Sep 2025 00:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757724679;
	bh=wsCMWK9O0Z/PM63c7I2uDIrzDne20DMQ6CeX9RZe4po=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MtMp5n5BGBChgXbQWOyWLGP6NAUcIv0FoLQN8kqJ9XMovtrNxOtty6ir0z6zMNNQo
	 eDFfg2jRLiwiXCaH9PBFYoDasw09UR6zFax64T/mnVL9xludSgzXHOlP/aIm8nMvLS
	 AQOMUf5Zb/qWxmDK7WBVUTJP8KffJ6o+PFd3u5POAgP42jRJh/WH/is+VjsWYIWMJK
	 LVJ7R6ZpYseyvXM0fc50SoQUBJnQFrCUWjfUyGFHxsvrNjlHpUvL7L8jKQjuWcZYrM
	 qCOby0jG5kc666wLCNUqAfB6g/Ny/Yfg/835UiqYZ0fVkUHcEcAwlFUiPm9jbG504h
	 +HBn9/VJOJywQ==
Message-ID: <3bd3df90d2e4009b4e566c0e6360b84514bb4c70.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v10 3/9] tcp: drop release and lock again in
 splice_read
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Sat, 13 Sep 2025 08:51:16 +0800
In-Reply-To: <397811f8-3684-0457-eb02-6fd16cb42876@kernel.org>
References: <cover.1756780274.git.tanggeliang@kylinos.cn>
	 <89fd2ab6630a8aceceef58273faae8db195ef2e6.1756780274.git.tanggeliang@kylinos.cn>
	 <397811f8-3684-0457-eb02-6fd16cb42876@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-09-12 at 16:34 -0700, Mat Martineau wrote:
> On Tue, 2 Sep 2025, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > In the main loop of tcp_splice_read(), release_sock() is invoked to
> > release
> > the socket lock, and then lock_sock() is immediately invoked to
> > hold the
> > socket lock again.
> > 
> > It looks like these two calls are useless, so let's drop them.
> 
> Hi Geliang -
> 
> I think the intent here is to allow incoming packets to be processed
> from 
> the backlog before __tcp_splice_read() is called on the next loop 
> iteration, so there's a chance that more data can be processed in a
> single 
> call to tcp_splice_read().

Thanks Mat, I didn't understand the intent of this code before.

> 
> Was this lock reacquisition causing any issues?

No, I just dropped this patch in v11, and add this 'release and lock
again' code in mptcp_splice_read() too.

-Geliang

> 
> Thanks,
> 
> Mat
> 
> 
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > net/ipv4/tcp.c | 2 --
> > 1 file changed, 2 deletions(-)
> > 
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index c9eb94a6c41a..c6425f13afd0 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -866,8 +866,6 @@ ssize_t tcp_splice_read(struct socket *sock,
> > loff_t *ppos,
> > 
> > 		if (!tss.len || !timeo)
> > 			break;
> > -		release_sock(sk);
> > -		lock_sock(sk);
> > 
> > 		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
> > 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
> > -- 
> > 2.48.1
> > 
> > 
> > 
