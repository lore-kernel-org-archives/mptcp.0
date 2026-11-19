Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114461;
	b=lmxBedDslIs32pa/QSe8XSMmSUq+VI0sdWKwtaYJFOXcWdOS7ZgFJBSurvkYpKfYHMYQ
	 uQbI9A9UokcZZ27tgI2gaY1NLGjhISkYXydbpfVKnLsiIksLZIuQSS/O59GtDMn5ToIo9
	 1WPiew4YINgHpxcY6E2/fVlPK3jpGyFsdEHvMcQ0/AwrTh9Ehhq2na4j/rTA8eNXn2x5h
	 LFNxUfU3+IXWdIERthv8PHnKhnaTtugJ/RVpJXdguERifR3+Rjxy1g7gg88/nEYm+s6Kh
	 80Ka3PmqImWp9KUBk9+2rk5uRNUlUAbw4OAdbyCgHV54vsI+3L74l09NehoYLFf3cxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114461;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Cc:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xfET0PvzLjOAM5dHUXPtRtzrhbf3bMMeKErauiT+dZ8=;
	b=jApH6L1aDUdkE/1UqcUSjjdkIQ+KP7MfZAgBwg//RgDN5OmqdWNQXTNRK5Zf9lENMzkr
	 KI2tHAw7v4iQIg5fyvzE3yEX2KARIQsR5NT5KEyw6/vcfpqVpFLSwlRLsPT7iwu3hiITG
	 8aHqnh5lh1Uysmn5MLU8OXCaTyJlXXCi9wyt5shoB2NL6yH2xsSLbLwEwzoQ4gR/qg8Fz
	 IHbUKSWJIaZmHC0kYC5Kibv5Dj9RiaY8aN0GlbMuvLdrjvGOuliyb/ECb8pFJ5FwPUrYv
	 6KzQozjKoQBPKcvJ5OyCOSVNDor7UhWeXqSjST2gWsgHfuKOTXb4UdV9wueIlwxgkTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+L1Z5Eq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27005606AAAD
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+L1Z5Eq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351E41F00937;
	Thu, 19 Nov 2026 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114460;
	bh=xfET0PvzLjOAM5dHUXPtRtzrhbf3bMMeKErauiT+dZ8=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=W+L1Z5EqNOyMCcDFkmeO7kW5yGV01vpE9BX4UokQlHjfH1MwoWgw0jpGvKhfdX766
	 l+Q9eJEy+fabepkoPXu2F7V/xN3X71HN+OtiRElcwjPlfXXvd/i41P2guwPAG/JGsd
	 I/gE3cMK05EzRJMRrctz+lClDlRJQ/8EyVgjThJBsIUZtnw0alH6m/LR+fqj49rNBU
	 WGbbHhjWOcO796Un6KHOfQR5hk76n+YryIFvPeKFXW4rqg9V8QJAy4dDWxtoBz4Azo
	 ETgV/fYH9jot8e9I4uldQTKccUBPbtjXtyCKDT8in4QFcrbFqCQrO/sVN2zg3HQyeE
	 z2Szjq/uRpBgA==
Message-ID: <b943c883-cff2-42ca-9299-729d8423f99e@kernel.org>
Date: Thu, 19 Nov 2026 19:54:18 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH iproute2-next 0/2] mptcp: limits: add subflow_retries
Content-Language: fr
To: Anil Kaushik <anilkaushikwireless@gmail.com>
References: <20261119184507.1954726-1-anilkaushikwireless@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261119184507.1954726-1-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Anil,

On 19/11/2026 19:45, Anil Kaushik wrote:
> This adds the new subflow-retries limit of the in-kernel path manager to
> "ip mptcp limits", as Matt suggested on the kernel series:
> 
> https://lore.kernel.org/mptcp/20261103085244.23064-1-anilkaushikwireless@gmail.com/
> 
> Patch 1 adds the new attribute to the copied uapi header. It is only
> needed until the iproute2 maintainers update the headers, once the
> kernel part is merged.
> 
> Patch 2 adds "subflow_retries" to "ip mptcp limits set" and "show", and
> to the man page.

I didn't review this in details, but I'm just thinking that you might
also want to expose the new limit_subflow_retries counter in ss.

Just note that ss.c is probably going to be split, see:

https://lore.kernel.org/20261119024049.3109143-1-stephen@networkplumber.org

(if you send a v2, please use [iproute2-mptcp] prefix, just not to
confuse with the ones that will be sent upstream)

> With this ip, "pm_netlink.sh -i" from the v15 kernel series fails the
> "set limits" check, because ip now shows the new limit. I have a fix for
> the selftest, which also runs the subflow-retries checks with ip. I can
> squash it in the pm_netlink.sh patch of the next version of the series.
Ah yes, good point. Yes, we will need it. I didn't review v15 yet, it
can wait or feel free to send a v16 if you already have it.

Note that the selftests ideally need to support older kernel version (so
without recent features) and older tools, e.g. IPRoute2 without your
patch. (except if thing get unreadable)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

