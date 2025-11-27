Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9562773DE
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764268937; cv=none; b=qKWkqvZfDAOsLZC+Et6l1L42LK2K1ZEoko2JDRpw/juekQYYLVRBu3mzMYPpYq3okcioLVnx2g/h2hZrBOs1IEy+7srjOkV40QnHFaw7tabYw2IXbyc7Ntj2IpjZ5GmenfxhgOjO5U1lK0TebwpWhBHfEfaYC/6lp+Mky+Sc9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764268937; c=relaxed/simple;
	bh=LQvjaWsT6tZXRpS1TDwucVs2d5S+6TXtpGc8ptKEfXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uP2+5fVEd9mK5veopL8YNseUaKfy69EDrQYjpfazSH0XOMaFVGFJXvJlIgVDV3o27Wio/XgEQnKmiZp+D9jY/PYT7/S3m9wPBxJP+WxHyJvOUZgj9MEc+w9mQvPFgmQS4+0gnxjZe1/BYEdt2MWcxPrvUkzdfCzr+Smslo2Kms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5llv/2y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5llv/2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D442DC4CEF8;
	Thu, 27 Nov 2025 18:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764268935;
	bh=LQvjaWsT6tZXRpS1TDwucVs2d5S+6TXtpGc8ptKEfXk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e5llv/2y9P0CHP9/iNgjX22bZRQMdpxwFqLJ1taZ+y9Q5t2DMWwYnYB5t90tdKim1
	 Q2+Cmn5lzsWzPrfYp5WtE+9vK0Oi+HSzG1LKGx3HXe31Mcs0/IMYYaQHaQJKUwpbxu
	 o01jW/A6K/cDsbvWMFAQlVhGOwqk8pEDS3AbokyClpueR1JyJxk3zD5ZHcxjxkctnO
	 3CYgd7vjSzTQIwwkaYB4HjvRipmxg0+mus8BLrGAfhmARxyTQDaYYPF0vbho+g7/kS
	 Ob+IifpuDcJFF7Wi6l1m32GiCiwMXg84selrXqWp/m0GSxe8l9cAH+2KMxtanuWBk0
	 QQgJXpsV41pug==
Message-ID: <7d90c4f3-1897-4aa7-83d2-c525c01f5717@kernel.org>
Date: Thu, 27 Nov 2025 19:42:13 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 mptcp-next 0/6] mptcp: autotune related improvement
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org
References: <cover.1763625391.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1763625391.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 20/11/2025 09:39, Paolo Abeni wrote:
> This series collects a few follow-up for the backlog refactor, with some
> of them posing as fixes just to confuse the enemy.
> 
> Targeting net-next as the issues addressed are very old, the change
> is quite invasive and, as mentioned, based on the BL refactor.
> 
> Overall this:
> - introduces a tracepoint similar to tcp useful to track down the issues
>   addressed here
> - avoid rx drop in corner case scenarios, improving tput stability and
>   peak tput over fast link
> - refactor the rcv space and rtt estimator, overall making DRS more
>   correct and avoiding rcv buffer drifting to tcp_rmem[2], which in
>   turn makes the tput more stable and less bursty

Thank you for the new improvements and reviews!

I guess the answer to my question in patch 5/6 will be that nothing
needs to be changed, so I decided to apply this series (hopefully) to
ease things. Worst case, I can easily amend/revert patches!

> Note that after this upstream series will be merged:
> 
> https://patchwork.kernel.org/user/todo/netdevbpf/?series=1025209
> 
> we want to introduce similar changes in mptcp, too.

(ah, that's where I saw that message, and just noticed that was no urgency!)


Now in our tree (feat. for net-next):

New patches for t/upstream:
- 1ac40c258962: trace: mptcp: add mptcp_rcvbuf_grow tracepoint
- 744ffd37f43a: mptcp: do not account for OoO in mptcp_rcvbuf_grow()
- 2c093fc5ab1b: mptcp: fix receive space timestamp initialization
- f2a2ee211112: mptcp: consolidate rcv space init
- 436eef292ce0: mptcp: better mptcp-level RTT estimator
- 4d83ab6b697c: mptcp: add receive queue awareness in tcp_rcv_space_adjust()
- Results: 1fea9a6bd10f..36ddaf26cab4 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/51795655931ed517a9362868f07690f569417880/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

