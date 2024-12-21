Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938C1F0E32
	for <mptcp@lists.linux.dev>; Sat, 21 Dec 2024 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734779872; cv=none; b=lhVZ3CORU/jFIQBR5/GKSp5UQo8VLgNKblJrk1Brj6Klgd2T3McJoK1sHEfkL7eE6B+HSNLxWNwhet/jOoddJ6vNNlpOP5Rm8toy+k5bLrZnO9fKIfNKVqqYhvldoqyvluMh2fRJz/MYZH5XjNYZfLW2CBwGAg9iRaHkMjhJMkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734779872; c=relaxed/simple;
	bh=MeLPySeVmdZSnZGj1arKfPsV64UYOwL8JIOOz1AwxB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p5BgLTix7Q/jam31auWUXoh5ulXVd70fWOYV/d0hLn5FC5kop+4Jw5AsibQK5wg8vcwh/Mh+9uHDr9LzRAmUdU9vH89MAhBT9KjQZ9TAr61Rk2U/2Hngqz+L43GdP4ZvCBK5cJjaU9wp8FVL9cvCTgO4M3yg3E6iFu9MoHZcbpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuHkKXvr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuHkKXvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D906C4CECE;
	Sat, 21 Dec 2024 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734779872;
	bh=MeLPySeVmdZSnZGj1arKfPsV64UYOwL8JIOOz1AwxB4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=XuHkKXvrS/DSqcZLIHKdbeQ8XP8c7JUFiXhuDwePncTrtAsKiG1gj+pS2N1+24C9s
	 YEsM79NchEf9kIj5yMjEJbM1IQ6mGZpg48Iafs2fiCyrYLsuW2QWhtsNwTRbNMTPDu
	 sv3uSUpWHo1iR6sFbuM1VYxGAJXy2bpb/Ox/42L9+XeHh/0pJv9dxuLGCgzThLvHCG
	 LrD2FC2I4Yj+e4f0b3SW2YkmVJXUhNUHIGkIVxK1KB6hPUbm7XaLXsf9+sN78j38ET
	 KXyQwGnd0AYj3daNNAcqA3MtRxr18+/BIGFZ/iWRLo38Nsf7i+tPsA6Myh0VKtwVAx
	 jP4JeQ4z9ochA==
Message-ID: <f9cbdb1d-07f3-4a60-b6bf-78ac4cba4650@kernel.org>
Date: Sat, 21 Dec 2024 12:17:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 0/7] mptcp: rx path refactor
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1733486870.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1733486870.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 06/12/2024 13:09, Paolo Abeni wrote:
> This is a batch of changes I had sitting in my local tree for a while.
> Why another refactor you may ask? Two main resons:
> 
> - currently the mptcp RX path introduces quite a bit of 'exceptional'
>  accounting/locking processing WRT to plain TCP, adding up to the
>  implementation complexity in a misurable way
> - the performance gap WRT plain TCP for single subflow connections is
>  quite measurable.
> 
> The present refactor addresses both the above items: most of the
> additional complexity is dropped, and single stream performances
> increase measurably - from 55Gbps to 71Gbps in my loopback test. As a
> reference, plain TCP is around 84Gps on the same host.
> 
> The above comes to a price: the patch are invasive, even in subtle ways:
> the chance of destabilizing the implementation is real (ence the
> additional, intentional '-next' into the subj).
> 
> In any case keeping the patch hidden for longer was not going to do any
> good, so here we are.

Thank you for the patches and the reviews!

Patches 2 and 3 are now in the "fixes for net", while the others are in
"feat. for next". I think patch 1 can go to "Fixes for net", any objections?

New patches for t/upstream-net and t/upstream:
- d443f83de23d: mptcp: fix recvbuffer adjust on sleeping rcvmsg
- 11d4943d66ee: mptcp: don't always assume copied data in
mptcp_cleanup_rbuf()
- Results: 3a0f411ba1c5..2116e71814b7 (export-net)
- Results: df3193ae83eb..953b0d388720 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/047c2f99575350d9971b6257f96ce5f734f0186a/checks

New patches for t/upstream:
- 972d8a5b7f20: mptcp: prevent excessive coalescing on receive
- 0b0a25a24d21: mptcp: consolidate subflow cleanup
- 533bb69f1b0d: mptcp: move the whole rx path under msk socket lock
protection
- c5d13b230497: mptcp: cleanup mem accounting
- a564b9923a94: net: dismiss sk_forward_alloc_get()
- Results: 953b0d388720..9213903d77ba (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/6aae9c8bd8361dd90a7def87459ca0173915c56c/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

