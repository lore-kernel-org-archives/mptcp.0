Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747707;
	b=c6OtUTYG4T9nDcEQSwRIzBezgl9qiuQcQ+EoGUILTssL/c/9/OM217XMJWq4aNXHY4n/
	 qUhP9vb2uRo0KU9/m802kSX7I9avXMtuGnkj1MIekGbuhLc+J2yzN9Vj8oJWT9QQjMmJL
	 BIJwjqEaoFGDYzWv0sJxVw4mNExYXhHc0iwMevzbq4scUcYb5WjXBqWfm6YmcZJtiImyB
	 nFGDVTa7/4xzyYdO8rPMJzosaef6JiEiRxdWMwlhzB+5BNSoi3ZJQcer8gW8uAQLFhfqa
	 YGvjkSu3IKnR2pyN629JfLHYKBVIb+sHL6f9S7TBogtH8c3YGXytRQWSfHQViq5JO9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747707;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=f24oR8NTC6UYP/jKJJP8EwjAfpA3oqXmerVNPnCbo98=;
	b=5Z3hVZSLXzeynZoEb1gScoVIhrvUNYaJzjvR+umZUSFOCyFjRZNJ0IwBl9OeEc0J12GM
	 C+APo8UqXUdRbmMN8k1klmyA4nwOYwqs15hEfgoivuEWZ1Ua/6N2oPgWhEJriihLdq/Ot
	 9D/D+Zufb2Nn/9rEu+x+2bK0Sa39aIDSDzKWeua3LA2Sc4L5+JnvhwttLRcG+mU50kOvc
	 7ynRlmjt35Nmz7N+Tjgqulm0duSfLZukntEYUDiJHWxc5SK9SIeMDa62yGOTMnsNNo9jN
	 phwYMdX/q5jEo2RYkZvXJhaCRE8LDTxmA+BRWnT83ymFCa+8oAILt9Jeh54Oj6SP2nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYrnRNvN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E30606A32D
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYrnRNvN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760181F031E1;
	Fri, 23 Oct 2026 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747707;
	bh=f24oR8NTC6UYP/jKJJP8EwjAfpA3oqXmerVNPnCbo98=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=TYrnRNvNm6mKZ9RioR4GOiBcfQU05Y18fipibdP5aAvLUJqfUp6mwXXq4ylbubOos
	 Baul5mjEXzJFl+W8OuinVgABaDkyzarD5vUuiIkRRd/O1Ykvypp3Q7JqKr+JQFVy5m
	 eGkV2ayqjqiY/uRFAWKBH7ZCZnGGWcWwaRauF3arHhbn3yiR6WGuirT8fUdWSzI6Qq
	 O/zDgebOD5kFaRIC1argcjYsvJCavlY6lJYGU4T7oNO4Q/QfGdY224G8cq6zejpU2/
	 MiE6n+0RkEv4+vomt2bp1aoUsfQbslCTPXeV3ze9y6/2HHSwwBvFIfJ/R3RR+sXOQQ
	 Ur0oZmBv0+TEQ==
Message-ID: <6b4005d8-850f-438d-a692-ebda1608d13d@kernel.org>
Date: Fri, 23 Oct 2026 11:28:24 +0200
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
Subject: Re: [PATCH mptcp-net v2] selftests: mptcp: sockopt: pass total bytes
 to do_getsockopts
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, quanyeyang@proton.me,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20261016-fix-mptcp-issue-638-v2-1-cc32774a8b0c@proton.me>
 <d16ffc4a-d8af-4b8d-b112-ce83736b9c3b@kernel.org>
 <758fc944eb96407a0d761ff84679ee5066cf836e.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <758fc944eb96407a0d761ff84679ee5066cf836e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2026 03:05, Geliang Tang wrote:
> Hi Matt, Quanye,
> 
> On Thu, 2026-10-22 at 13:06 +0200, Matthieu Baerts wrote:
>> Hi Quanye,
>>
>> On 17/10/2026 07:33, Quanye Yang via B4 Relay wrote:
>>> From: Quanye Yang <quanyeyang@proton.me>
>>>
>>> connect_one_server() reads the echoed payload in a loop because
>>> read()
>>> on a stream socket can return a partial chunk. After the loop, it
>>> still
>>> passed the last read() return value to do_getsockopts() instead of
>>> the
>>> accumulated byte count.
>>>
>>> do_getsockopts() checks MPTCP_INFO first. The client samples
>>> mptcpi_write_seq before write(), and write() has already advanced
>>> msk->write_seq by the full length, so a partial last read() makes
>>> the write_seq assert fail. Pass the total instead.
>>
>> Thank you for the patch, it looks good to me.
>>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>> I just applied it in our tree, but for net-next because I don't think
>> I
>> saw the issue in our and the netdev CI. So I added this in the commit
>> message:
>>
>> This issue has been reported by Sashiko and not seen in CI
>> environments.
>> Yet, it could be visible, especially when the test is launched
>> manually.
> 
> Sorry for the late reply - I just saw this patch. Glad the issue has
> been fixed. But actually, I had already fixed this issue earlier: my
> patch titled "selftests: mptcp: sockopt: use exact length in
> connect_one_server" [1] is still waiting for review on the MPTCP
> mailing list. But it's no big deal - I should have replied with an
> Acked-by for this patch.

My bad, I forgot about that patch when I opened a bunch of issues
reported by Sashiko.

I will add your co-dev-by on that one.

Do we need the other modification you did on the 'read' to silence a GCC
warning? Because the current "sizeof(buf2) - total" seems correct to me.

> Anyway, I'm wondering - does it look like my pending series "selftests:
> consolidate TCP_INQ testing into sockopt" [2] is still useful after
> all? Should I rebase it and send a v15?

It is still useful, but sorry, I need to go through it (and many others
:( ). I will try to do that in November/December after some deadlines.
No need to rebase before.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

