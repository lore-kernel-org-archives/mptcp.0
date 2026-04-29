Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68938758E
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777461038; cv=none; b=V8gI2bvYuahyAiEQMDvooMjGKfi0dxl0Esdvti8YU5ykU+hntXe9kQyVP7O//St0cgOSt0hPOxxebZKkGR2lM2SIr2jgm62C1LOkX3KNkr/ITt0B1wji7FX831SpfeQH3GMHyQH/+vRkvw7rkSgoFhQ/sRxDiDeudyLhH2QaSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777461038; c=relaxed/simple;
	bh=Mc2U2y041yqREjFKbQdAI6J+sHX12ltnFRLlLl74iBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNJR1tdmwn1Q+UKZTX4LQ0QH2Mes3UFpJvuUbHKy9TWJUFJ86mrJCkbHX0Q+kVGbqnkn0CBhIdgBt8jnUwwdxG3VG3k8DJ9fBW9HInuUKFJZqqJ1vFaJXmAR0VQzbf7dBOqxcjekLNfDWesdzt5p7fBewdiTnNxkVq0jMgttS4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGhthkO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGhthkO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E56C19425;
	Wed, 29 Apr 2026 11:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777461037;
	bh=Mc2U2y041yqREjFKbQdAI6J+sHX12ltnFRLlLl74iBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YGhthkO09mVmJvtoJNJE4HVexLqotPo5KFrLxOTaRxJdCOmA2X34adWf4op3R0yiC
	 c77bBIU0Xu08/rCqortaBatxW+KjZUAVw97n2VLqgPodKes5MU42LY9GFIafAFykKm
	 DJI98t3/NQpbR3QPyNv6+2i8dRDmyruk7ZzJCkYD6dxaAcXQPWzI6O111F218s0O5o
	 +Qj4dT5M/gg79dpfhc5ur7JlZmBro6laWvClxsFmNUjgy1BBJkz2KxojNVpguzoH+k
	 jxUWwPtUt+AdxWXuK3GInHWRIuksg9ykkMza4vrz3B6xzKjeq8BZ9cfpHuGxkG+XOT
	 dAgNiUxWUQ7Aw==
Message-ID: <07f99920-e145-431d-94f0-707c28d02f5f@kernel.org>
Date: Wed, 29 Apr 2026 13:10:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: sockopt: increase seq in
 mptcp_setsockopt_all_sf
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>
References: <20260424-mptcp-pm-sockopt-set-all-sf-v1-1-38e7023822f8@kernel.org>
 <2d2f2e75-761c-2075-41cd-7e4b4da4962c@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2d2f2e75-761c-2075-41cd-7e4b4da4962c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 29/04/2026 02:26, Mat Martineau wrote:
> On Fri, 24 Apr 2026, Matthieu Baerts (NGI0) wrote:
> 
>> mptcp_setsockopt_all_sf() was missing a call to sockopt_seq_inc(). This
>> is required not to cause missing synchronization for newer subflows
>> created later on.
>>
>> This helper is called each time a socket option is set on subflows, and
>> future ones will need to inherit this option after their creation.
>>
>> Fixes: 51c5fd09e1b4 ("mptcp: add TCP_MAXSEG sockopt support")
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> net/mptcp/sockopt.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index 79db15903e7a..30b45d2ab38c 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
>> @@ -812,6 +812,10 @@ static int mptcp_setsockopt_all_sf(struct
>> mptcp_sock *msk, int level,
>>         if (ret)
>>             break;
>>     }
>> +
>> +    if (!ret)
>> +        sockopt_seq_inc(msk);
>> +
> 
> This only appears to be used for TCP_MAXSEG, and the limits checked for
> that sockopt are the same for every TCP socket - so there's currently no
> risk of having the setting applied to some subflows but not others and
> skipping the increment here seems like the right thing to do.
> 
> Not sure if that's true for all possible socket options!

Thank you for the review! Indeed, it is safe for the moment for this option.

Maybe the value could be copied, but on the other hand, I don't know if
we need to prevent that: if the buffer is written concurrently when
calling setsockopt with TCP, that's a strange behaviour from the
userspace, and the end-result will depend on when the kernel reads the
value...

Anyway, no need to worry about that now! :)

New patches for t/upstream-net and t/upstream:
- bbfb75da3b4f: mptcp: sockopt: increase seq in mptcp_setsockopt_all_sf
- Results: 8b78db730d79..581441b9adeb (export-net)
- Results: 3455e15b8193..d1636d717db9 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/008c005a9ad82212f63b7f9afd0aa01417d53b38/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/2f2a495d6dd05fffde5489f73dfd318f66c5d5a8/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

