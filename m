Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83124239085
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452023; cv=none; b=gQqq64RyKnATzH5V4h9YCwrHJyKc6Kd65tPFJlaLyDJg9aAvipWu13x3DwQHNFxSA1fRXnLYWWKqRJYKBIsqZbCzXfJzIyGL68Qer5efCxmVon36UR7NWlu39wLYyGKPlAY6f6zq/CwzT9PNWeX9bp2fM8q9glwm+cCkAJW64zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452023; c=relaxed/simple;
	bh=GpPGMmbjfnc/oWU9mFgyaEKbUDena8G9dHjE79pEj4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDYIzwvJKjAyJi1YsK0bL8zmsDf1fxT9kD/9h5MRINg0HEEqUtVlC4ybiwBB5QFx8LIpbEZDu+tp05RXh371P09yVZc1fmutJYNM2t66FQzRy8OZ9GqFJEg4u43f0QrbUF0dupTUG4+WS8adyPmPciMsdexv8Ejg0u9txb3EuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4C0w+mV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4C0w+mV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF78C116C6;
	Mon, 26 Jan 2026 18:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769452023;
	bh=GpPGMmbjfnc/oWU9mFgyaEKbUDena8G9dHjE79pEj4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q4C0w+mVvvakIq3hCq17te+CRgyvUu8tevUcLJ7hVa8e6IDRzHQwRMgaV4BjO2XT2
	 xXoxwWZnUcGEgwBRKwwBGvVmV3CuDp2zL+ROIaKwq3DpVzUdH37+EIICH5SVWy94HI
	 U4iZCNlqIlT3FN3fiQIucVjEBqOemy4/BqNImbIplqpQgG6TMI8xBihQYF5JdVB8ki
	 55Z90Hm3JVMxjbkONNvyLr4Pj3+7yXmS9wAPSO1DxHeF/qQgBFV4bxeAxEgqSA3GSJ
	 VGF2BBhPBdsYLTgKC7J8rhc8Cue18R1HpFfgG6y9qtfKWwLxiWourxk0+LMooLlTaj
	 rbf7f+bSSao9Q==
Message-ID: <d0e6f49a-1ee3-4cfd-8e46-ceb657f7a8dc@kernel.org>
Date: Mon, 26 Jan 2026 19:27:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] selftests: mptcp: join: fix local endp not
 being tracked
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251222-sft-5-15-signal-race-test-v1-1-a9b67c49af15@kernel.org>
 <d75df364-38c3-b9b3-b978-dcba2b9fb96b@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d75df364-38c3-b9b3-b978-dcba2b9fb96b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 14/01/2026 17:50, Mat Martineau wrote:
> On Mon, 22 Dec 2025, Matthieu Baerts (NGI0) wrote:
> 
>> When running this mptcp_join.sh selftest on older kernel versions not
>> supporting local endpoints tracking, this test fails because 3 MP_JOIN
>> ACKs have been received, while only 2 were expected.
>>
>> It is not clear why only 2 MP_JOIN ACKs were expected on old kernel
>> versions, while 3 MP_JOIN SYN and SYN+ACK were expected. When testing on
>> the v5.15.197 kernel, 3 MP_JOIN ACKs are seen, which is also what is
>> expected in the selftests included in this kernel version, see commit
>> f4480eaad489 ("selftests: mptcp: add missing join check").
>>
>> Switch the expected MP_JOIN ACKs to 3. While at it, move this
>> chk_join_nr helper out of the special condition for older kernel
>> versions as it is now the same as with more recent ones. Also, invert
>> the condition to be more logical: what's expected on newer kernel
>> versions having such helper first.
>>
>> Fixes: d4c81bbb8600 ("selftests: mptcp: join: support local endpoint
>> being tracked or not")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Looks good to me, thanks Matthieu.
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree:

New patches for t/upstream-net and t/upstream:
- b799002f1f8e: selftests: mptcp: join: fix local endp not being tracked
- Results: fb96b304d88a..af4181f61c9c (export-net)
- Results: ba44c0dbd2e9..b8bb952910af (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/7ad24eb2a484fcd7d6e9d6d8d3285c917abc6354/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/fce2d92251d9288da07c20f381ec436d24b0e2ee/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

