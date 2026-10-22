Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654328;
	b=gHi/PUcfCNu+J2mx1VBW0CaXRkyj676Nq4YGNV7hnMQaT8+FW6oW/UTONakTCh/aSlxb
	 tiJgvWdEdw8E1Xjk8AqGWraVTNhoTp9jrXtOfCXS/R0xgVSYFpsj+ososgK4gi900sTft
	 qh14/vu7r3v+raGsQq97Vks1dnvPiwqugjk4XbrYJdFYvYb4xHDEQU5TJATNKk5q4lTxb
	 F22dgkey0a42eUZAmCpxTS++Gvkcr7cxiUSQfsPbp4YwPjdOJua4zO2RE5cjo5bJU6irp
	 bej0+LOssrNdLctYFmQi8i0smqxTw8cl+bJAvdWuhTEERA891KYcYVaO7eD8kQ/bJ5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654328;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ek2I6lhzKLVpKhWrHC8CkaiwKfM46N88Eca0M8TIyXY=;
	b=XUFxvjLET53sGtprYtoj3bN0FnD2tXAUbd6glM0ASaI6TigTk249T1lPNSylN77vlPn5
	 1bDL45+aSZxjbxXPkaBC5HKl3KIZ/HE56vs4VrI+ylUeLmPcLdtdk0426djuNwwK9bkrf
	 XkYxUSr+HcKSLDypWFU7b0zvhHYFJfYSAIviLTrEOu4QjkYCo4BvnyyXj8hEUi6zxMk3P
	 1kmXkWdu+ekwFOCacKLfcZZ37NRd7M6N+ujQIbRgSGOg5s9LrLQdBL5TPPAf54kUcs/bv
	 d5eMjpGHr+uBvpaHiGEKDMpbXo0Nf1T/gX38eYdsaXIaUO6EtugebzOLncQSvJEGQEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nTIAaSo/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D4606A31F
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTIAaSo/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AD11F000C1;
	Thu, 22 Oct 2026 07:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792654327;
	bh=Ek2I6lhzKLVpKhWrHC8CkaiwKfM46N88Eca0M8TIyXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nTIAaSo/T7sQpzx93OCbE9fCmyNV1MCDWZ1PFUoh6toBJ/Y3myUzrdb0qG6PvGnFw
	 ofSUTgysmj6QKikZagr/cEf/8vhBAhBRHd9M8S7rkKYa6wK/Q412ujJZN/oQflY5oN
	 W7MEMN+jXq8F96Jfi167WRor+UiNpS7xV+wdEhadJ8OrVYvm1Z8DvgzoFM7UxVvqbg
	 qTESRMY/iVIHswG+O+bAXyVLdt6+DnMdyeK5SvnmAPvANhrkBYrkxPH5ZAQBdn1R4w
	 9l/Kknm/8uLboo/bo/6nB4rp9NcLSKJxBZ9NyxT5hm8j19aL9cUCAafI4+4ACi27eh
	 4xNIJH/XGuFUQ==
Message-ID: <4180b794-8877-4516-9400-afb0894e8f49@kernel.org>
Date: Thu, 22 Oct 2026 09:32:04 +0200
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
Content-Language: fr
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
 <20261014143349.768138-3-anilkaushikwireless@gmail.com>
 <b150dde6-05f1-4e7b-9440-360b7ce17eff@kernel.org>
 <CAG0Mgm_uj70o=R5HnEb0GkTy4FTQK6cy6GHWuO7y2FitzwnucA@mail.gmail.com>
 <7c7308c5-c150-41a1-9d84-9981acfb5962@kernel.org>
 <ffc98c40-09d5-4299-8128-72cc0ed6beae@kernel.org>
 <CAG0Mgm9ShHdApcKAUj_PgGdm_A+w--FKpSpJq=nTJ=DkRcuACA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAG0Mgm9ShHdApcKAUj_PgGdm_A+w--FKpSpJq=nTJ=DkRcuACA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Anil,

Thank you for your reply.

On 21/10/2026 20:20, Anil Kaushik wrote:
> On Wed, Oct 21, 2026 at 11:18 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>> On 16/10/2026 10:43, Matthieu Baerts wrote:
>>> On 16/10/2026 07:49, Anil Kaushik wrote:
>>>>> Add a sensible default value (what do you recommend?)
>>>>
>>>> 15 SYN retries: about 20 minutes with the 120s max RTO.
>>>
>>> I guess it could even be longer, no? With an exponential backoff, it's
>>> not spamming the network too much.
>>>
>>> I wonder if we shouldn't get something similar to tcp_retries2. But
>>> here, with the syn, we also need to tcp_syn_linear_timeouts into
>>> account. Either we keep it to 15 by default and, (if not 0), we add
>>> tcp_syn_linear_timeouts, or we initialise it to 19.
>>>
> 
> tcp_write_timeout() already adds tcp_syn_linear_timeouts on top of
> icsk_syn_retries for SYN_SENT sockets. With the defaults, 15 gives 4
> linear + 15 exponential retries, about 20 minutes, close to
> tcp_retries2. I can make it longer if you prefer. Let me know please?

It is always tricky to find a good default value. I guess 15-20 minutes
is fine for most people. Connections are usually not that long, but some
can be, e.g. ssh. But then, what do we loose to put it higher by default
to support more cases? Maybe environments with low memory could not like
that, but either they don't manage that many connections, or they don't
use MPTCP.

When I look at nf_conntrack_tcp_timeout_established, it is set to 5 days
by default, so we shouldn't go higher than that. But maybe we should
target a few hours by default? e.g. using 20 (~10.5h?) or maybe better
to use 21 (~21h) or 22 to cover a WE (~42.5h?)?

>>>>> modify icsk_syn_retries instead [...] WDYT?
>>>>
>>>> Good idea, I will do that: one new subflow per failure, with its SYN
>>>> retries set from the new netlink limit, 0 = disabled. It also removes
>>>> the socket reuse, the retries counter and the 60s check.
>>>>
>>>> One point to think though, If ICMP unreachable stops the SYN at once.
>>>> I would not retry
>>>> again then. Is that OK?
>>>
>>> Good point. In your specific case, what do you observe?
> 
> In my tests, the fiber outage is a silent drop: the SYNs just time
> out, and the subflow comes back once the path is up again.

Interesting. Out of curiosity, how long are these outages typically?
Less than ~20 minutes I suppose?

>>> To me, the best is to have the network manager (something from
>>> userspace) removing the MPTCP endpoints when they are not "usable", but
>>> here it can be specific to the destination. I would then say to look at
>>> this case later. In this case, we could eventually disconnect the
>>> subflow, and add a timer to retry later. But that's also more prone to
>>> bugs, so if we can avoid that, probably better to!
>>>
> 
> Sure, lets take up this case later
> 
>>>>> Do we have other similar ones? [...] ss -Mte, would that work?
>>>>
>>>> I will drop the MIB counter. The test can use the MPJ counters and the
>>>> netlink events.
>>>
>>> Thanks! You can expose the new limit in "struct mptcp_info", instead of
>>> "reserved".
>>>
> 
> Done since v5.

Thanks.

>>>>> Is it specific for your case?
>>>>
>>>> No, it came from a Sashiko review: a dead subflow waiting to be closed
>>>> could be re-created after its endpoint or the peer's address was
>>>> removed. I will try to move it to pm_kernel.c.
>>>
>>> What did you end-up doing for this?
>>>
> 
> When an address is removed, mptcp_pm_rm_addr_or_subflow() now marks the
> subflows using it, so they are not re-created.

Good, simpler.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

