Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604895;
	b=C9KZnkN5DdLoCDbvNnihPhaNgpKJLb0CiYp7MxiNQtIhDhNiffkC8kpHu2BvHhgVCXof
	 CJsktUSxwktbXb3SW98fH8AehhXCHwILgS9TA3uGl9A2zX7tLysaEVxPrImT3+czk4nMw
	 2JR80NluBcgP3YVJc7qvDeeI8HTtU//UwcYtficg+h1eOyB2gmCHAl6XtfVyAJYn/5PDX
	 d/E20PTVa1KnL9R0vhC1Q+VjyLOTfprMcbwwuP3s9w3wV3+5ujIv9uMv8dLM/rHnYfMo/
	 M4u8Fsr391BoDpAWYa7AePkDB2PC6kqAaDRTIfCJtnXNN1sVOqPfP/cZENd3eQ8pvgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604895;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=DuPpVbv4x+TRB5giJk3jfBa+yYlJuSeNCoX6o12p+VI=;
	b=Qfk3AiGfF872jZWi3P5OAS/8ML0dc4WMBZnXxLJT0/JGcsY2Aw2EdD6uVFTE+W0ZvwfE
	 l4jFHdT+X9B7yOPbELDyTYuQIIPgvbw/lMp5AM7Y8GV+1HCdjmMk/ZxWhtMpyqPgYT2CN
	 GAUfJ1U8Mclnrukfx0o4wEYxQG5joUB/hAxX+yTl2Y7SjvfGrdLfZc825HmINzpm8IS5J
	 8ruFZokECvoy9WfXLP1T7cWMU1yTDXY3sxP32n1mAg8HfqCWS1qffUTJ3RTXYb0GLgTCa
	 qWon6qbZK5BnCbRQmrl97zTVnq44LC4J/U1ncPgfevDWMyyIdVxPnKG2x4ZpgtVNCjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTC16q7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC2D606A319
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTC16q7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C771F000C1;
	Wed, 21 Oct 2026 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792604894;
	bh=DuPpVbv4x+TRB5giJk3jfBa+yYlJuSeNCoX6o12p+VI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=nTC16q7Hpr5cYWxI3eRBcSHvUWYNNHC2Uy13DzPpXbMHQDJ8u1UVBcgogjK/852Wp
	 QPsPfqw9C3AaEjSqrZ2TPDxw9Ug3SXkUxH/QAVdMIN1K8UpCkG3TnGu0Id5dsu0oxI
	 dRwKah28YkN6JWT9OccRdegK2bvwPmqi8TkRKNBIJ/UKbGFzoZkwexxl2WCxf0nbYF
	 mT7HKgkAS+eGmAOlbvdTefrPj7BTDZ6lkc+ZmlVtYC/uAJRI6qWNHKeS/ov7pZwquo
	 nGcPzTZSM/Jb9XRwb6DUTaJNLIQbSHpp3YhKSE4LaFhqLZ2lfHoDW0Nl6VACORN6Dk
	 i+mdgXkWBnRbA==
Message-ID: <ffc98c40-09d5-4299-8128-72cc0ed6beae@kernel.org>
Date: Wed, 21 Oct 2026 19:48:12 +0200
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
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
From: Matthieu Baerts <matttbe@kernel.org>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
 <20261014143349.768138-3-anilkaushikwireless@gmail.com>
 <b150dde6-05f1-4e7b-9440-360b7ce17eff@kernel.org>
 <CAG0Mgm_uj70o=R5HnEb0GkTy4FTQK6cy6GHWuO7y2FitzwnucA@mail.gmail.com>
 <7c7308c5-c150-41a1-9d84-9981acfb5962@kernel.org>
Content-Language: fr
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7c7308c5-c150-41a1-9d84-9981acfb5962@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Anil,

I noticed new versions, but I don't know if you saw my reply here. Do
you mind replying to my previous questions / comments here below, please?

On 16/10/2026 10:43, Matthieu Baerts wrote:
> Hi Anil,
> 
> Thank you for your reply.
> 
> On 16/10/2026 07:49, Anil Kaushik wrote:
>>> Add a sensible default value (what do you recommend?)
>>
>> 15 SYN retries: about 20 minutes with the 120s max RTO.
> 
> I guess it could even be longer, no? With an exponential backoff, it's
> not spamming the network too much.
> 
> I wonder if we shouldn't get something similar to tcp_retries2. But
> here, with the syn, we also need to tcp_syn_linear_timeouts into
> account. Either we keep it to 15 by default and, (if not 0), we add
> tcp_syn_linear_timeouts, or we initialise it to 19.
> 
>>> modify icsk_syn_retries instead [...] WDYT?
>>
>> Good idea, I will do that: one new subflow per failure, with its SYN
>> retries set from the new netlink limit, 0 = disabled. It also removes
>> the socket reuse, the retries counter and the 60s check.
>>
>> One point to think though, If ICMP unreachable stops the SYN at once.
>> I would not retry
>> again then. Is that OK?
> 
> Good point. In your specific case, what do you observe?
> 
> To me, the best is to have the network manager (something from
> userspace) removing the MPTCP endpoints when they are not "usable", but
> here it can be specific to the destination. I would then say to look at
> this case later. In this case, we could eventually disconnect the
> subflow, and add a timer to retry later. But that's also more prone to
> bugs, so if we can avoid that, probably better to!
> 
>>> Do we have other similar ones? [...] ss -Mte, would that work?
>>
>> I will drop the MIB counter. The test can use the MPJ counters and the
>> netlink events.
> 
> Thanks! You can expose the new limit in "struct mptcp_info", instead of
> "reserved".
> 
>>> Is it specific for your case?
>>
>> No, it came from a Sashiko review: a dead subflow waiting to be closed
>> could be re-created after its endpoint or the peer's address was
>> removed. I will try to move it to pm_kernel.c.
> 
> What did you end-up doing for this?
> 
>>> can we not check why it failed instead?
>>
>> With your idea it is not needed: only one retry, nothing to count.
> 
> Good
> 
>>> what error do you get when the issue is detected via TCP Keepalive?
>>
>> ETIMEDOUT, so it is retried.
> 
> Thanks!
> 
>>> Why can we not always re-used?
>>
>> A subflow that carried data needs the full close cleanup. With your
>> idea we always create a new subflow, so there is only one path.
>>
>> For the rest: OK. I will go through pm.c, avoid struct holes and
>> duplicated connect code, drop the RFC tag, add a changelog per patch,
>> and test closing the connection while retrying plus the netlink events.
>> I will wait for the netdev Sashiko review before sending.
> 
> Thanks! BTW, it is easier if you reply inline here below, to keep the
> context:
> 
> https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying
> 
>> On Wed, Oct 14, 2026 at 11:43 PM Matthieu Baerts <matttbe@kernel.org> wrote:
> (...)
> 
> Cheers,
> Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

