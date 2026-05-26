Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96C3911B2
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781767; cv=none; b=Nv/t5HmVjgUmekFTtILCZ411LDOe7SGXJeAXsbJ0euPf5FZGBMRTK96KGFwHEXsT57bLzpF8rSUOfTkG4UC3nQH65WUqRvoggkEUm//AcAvpoo8ZhLyqmWaxgq1I52h5yEGHjKxIE7oscOJz46RWxJfpR7vHtQbhOV5zTy5886o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781767; c=relaxed/simple;
	bh=jimEk3PHdeVkyBk+NDZHodd/0uy73YFsrTuChjXVx1o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rYPBJ5bt29CBVYiKPoPH7zEeMWppWweqlo2zcqXJAMi5nugX8FILFiMgLPTl+NfKFguJ0WxqG5rosTfl+QHWbbhmEZMKPg+mkYZGLIhdg3Y/hlSX8CN3pnII1/O5PYGcsj0eZU8MVVnZh2apP8+m3U8tdnZd/Go3W51sN/DFErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFU7Omqo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFU7Omqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893BA1F00A3A;
	Tue, 26 May 2026 07:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779781765;
	bh=nc75XnsntX1EHfjU8/6ffBwgBJ1+U0OyWBkzXDcOMt0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=hFU7Omqo2eclN2dYKFUhNAhqbEflCSz70WIFthvvQZqH9eDhbycR500UUhznNhM8G
	 pSE5Ri5A2AakVXDMP8hFJGlEFKCD86qz5vy1BXAfNOJwuEHDaOPZqXPAbMy6Mqu44/
	 A4ywzu13STy6euuDxkq7OvMruk7TXW5GAus+nqVV3rrpve0Zf3hf8fzXEb1Je6PK4W
	 VU0yDAAqyCF8lz4lUiRIxKoxbiJ52YvGdVnD6z4KoG2hlm+15GfJ097gNMENh44UIJ
	 nu1/5G6tRkHZXdoWsmp3mL/FQBAAkKHdHb4z34dVHH7c+BVGppycdYYAUK+GWRZHUJ
	 cyz7JlzLoH6hw==
Message-ID: <0624d85c-1992-4b4f-bbdb-32c454ac7765@kernel.org>
Date: Tue, 26 May 2026 17:49:20 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 mptcp-next 4/9] mptcp: allow subflow rcv wnd to shrink
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev,
 mptcp@lists.linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <661603fa10737a624bba854fb2515c7abb129a80.1779485511.git.pabeni@redhat.com>
 <a017ffa9-1dbe-4094-ae85-7c17e7b48b0d@redhat.com>
 <085ebc3e-0d49-4a82-aea9-a8b05a02c7ae@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <085ebc3e-0d49-4a82-aea9-a8b05a02c7ae@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 26/05/2026 17:02, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 24/05/2026 18:34, Paolo Abeni wrote:
>> On 5/22/26 11:43 PM, Paolo Abeni wrote:
>>> In MPTCP connection, the `window` field in the TCP header refers to the
>>> MPTCP-level rcv_nxt and it's right edge should not move backward. Such
>>> constraint is enforced at DSS option generation time.
>>>
>>> At the same time, the TCP stack ensures independently that the TCP-level
>>> rcv wnd right's edge does not move backward. That in turn causes artificial
>>> inflating of the MPTCP rcv window when the incoming data is acked at the
>>> TCP level and is OoO in the MPTCP sequence space (or lands in the backlog).
>>>
>>> As a consequence, the incoming traffic can exceed the receiver rcvbuf size
>>> even when the sender is not misbehaving.
>>>
>>> Prevent such scenario forcibly allowing the TCP subflow to shrink the
>>> TCP-level rcv wnd regardless of the current netns setting.
>>>
>>> Fixes: f3589be0c420 ("mptcp: never shrink offered window")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>
>> Sashiko failed to review this series from this patch included onward:
>>
>> https://sashiko.dev/#/patchset/cover.1779485511.git.pabeni%40redhat.com
>>
>> and it's not clear to me why.
> 
> It is not the first time I see failures. I guess it is not linked to
> your series.
> 
>> I think patch 1/3 are quite uncontroversial and reasonably even this one.
>>
>> WRT the stall addressing patches, this iteration survives mptcp_data
>> testing without timeout tuning, hopefully should be fine for Geliang and
>> Gang usage.
>>
>> @Matttbe: please LMK if you prefer a complete repost or if you could
>> apply patch 1-3 (or more).
> Sorry for the delay. Yes, on it. I guess patches 1-4 can already be
> applied to -net.
Just reviewed them. Please tell me if you are OK with the suggested
modifications, or if you prefer to send a new version.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

