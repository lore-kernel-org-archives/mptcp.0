Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA9E3FA5F0;
	Mon, 14 Sep 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378308; cv=none; b=chTsE3CNtu00Dh6l5sGeA3MXCedfbCh1/+h5MJ2lWXGCLHEuSwZ7sgBo6IIb9y7dhdRag593aqQ7dhKHfewJ98/i1bEx5L9juq3bhTKdFmdQQ1qMB2Lxx7SwcwQwoeS2s7hHXQReHhNJhe6CuuLWLgdF+/cuexL6HwMlhyCbEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378308; c=relaxed/simple;
	bh=I+EDhI0xwbt4BddInR4C7S/SKT6iIa7cwtAp86MIyw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcFtIa11fdWWriWK0fGhKjWGiWrXzkM6caVuehlC8kkBCXL/gFMHGeqPLdbkzqia0uI9/+NUS6galAXeoR/tP9ZUdowDShiknCBMqtaAMpWBEfh80JTSLPYafwRHXz+xkCey3PnVd8bguwjgd289Sn16rzBTVr4DFqkPlKoLHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVUSx8j0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVUSx8j0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1695C1F000FF;
	Mon, 14 Sep 2026 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789378306;
	bh=HzuN3Sn26uY0pjBjYF8UUElxushwwDsrxBG7xQyIZIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LVUSx8j02axuwju3CRgbHafB4XgvSkLnh2FnTn9YVZv/NDU4lGjYxEdFtiNkjiCwG
	 uyGIdI0WjRgaTsE+9zBdc5iJN3lcqDWvFk8eRRcFLKnyIahHSr588D7SifKTKmlBVc
	 BElbydzVSp1PO7Dqp3ihtYyuUbAt55W5bPi1OjEvPoR63ccewLl7C3kbEFCZ0uLkRy
	 VtFoUZacHqMNmjsi0qs8RT0DU4MKFcq2lqe8PcsL9MEGbRp7FHnx52OTgbNsquyQBU
	 A0B7TK9PLB4uIjr1PLcAaXYzIBcukiC6cm52nWAW9ML2lLI71BF61E4yluh7jtM2PJ
	 YwJo0lPAZa9/Q==
Message-ID: <41529444-b4e1-4c93-bb70-e7c6a015800e@kernel.org>
Date: Mon, 14 Sep 2026 11:31:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf 1/2] bpf: drop duplicate check_app_limited in
 tcp_bpf_push
Content-Language: fr
To: gang.yan@linux.dev, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, mptcp@lists.linux.dev,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, David Howells <dhowells@redhat.com>,
 Mat Martineau <martineau@kernel.org>
References: <cover.1789368148.git.tanggeliang@kylinos.cn>
 <f12f1d886c8ff2b6f6e48f797ccc861037eda685.1789368148.git.tanggeliang@kylinos.cn>
 <da26d2f3-7283-4e9f-85b4-6c12b9beda99@linux.dev>
 <0b7ac0ea84f0dea0092aa84d4aff3db0b6dc0f93@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0b7ac0ea84f0dea0092aa84d4aff3db0b6dc0f93@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang, Jiayuan, Geliang,

On 14/09/2026 10:45, gang.yan@linux.dev wrote:
> September 14, 2026 at 4:24 PM, "Jiayuan Chen" <jiayuan.chen@linux.dev mailto:jiayuan.chen@linux.dev?to=%22Jiayuan%20Chen%22%20%3Cjiayuan.chen%40linux.dev%3E > wrote:
> 
>> Same as the tls one: this looks like a cleanup to me. Is there a real regression that affects kernel or user behavior?
>>
>> Do we really need a Fixes tag?
>>
> Hi Jiayuan,
> 
> It's a part of the thread in [1], just kindly remind that there had some comments from Matt:
> 
> '''
> Also, should this be seen as a fix? From what I understand, some
> behaviours have changed, and it is only recently that this call is no
> longer needed.
> '''
> 
> From my view, it seems like that there have some misses in the 'fixed' commit, so the fix tag
> should be kept, right?

When I first saw the modification, it fell like Geliang was fixing
something, hence my question. It is indeed fixing something, but if it
"just" avoids extra checks that are now useless, I agree that it doesn't
need to carry the fixes tag. (Except if it creates a noticeable perf
regression, but I don't think so here.)

If the Fixes tag is removed, it is always good to mention this commit to
help with the context (and just in case if this patch can help with the
backports). And also good to mention c5c37af6ecad9 ("tcp: Convert
do_tcp_sendpages() to use MSG_SPLICE_PAGES") in the commit message as well.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

