Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3330496C
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272151; cv=none; b=qXnmoPm8cqRGX3r6ybly5Jk68nlkH+Z8TFsCZdwk27KrztUpCqyO7+fQVG7xhYJC0FZ/YpOGMbIvrPViX85WQxyMI9oUJfms/F2k3GTR0FQfTRaBMv8MfT3mGFVEdHgbjJLKPRNIHu4snzObYyGH6RYcCM3mqX5ZELBwUKa6s8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272151; c=relaxed/simple;
	bh=ATmNg6ufUJ9C6McAnbQUBKIH32ABla8Sh/kn0MOZHyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZCDTeyD7N9990qk6eEOO2jBmk0zS59VAxVYBY3H6G7q9ammoHogwXzKOwuV1zWADvO48CuHozfWPrSnutUtfe0d1Pfyh+9LYyFPIkcPXgTpdw1pM+267HKjh1zfST2/2C3aj95jxO8SuJe3vMR7dD1Zjz6aqhlwabnYYOvBsb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDp+nd9X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDp+nd9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71105C4CEEB;
	Fri, 15 Aug 2025 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755272151;
	bh=ATmNg6ufUJ9C6McAnbQUBKIH32ABla8Sh/kn0MOZHyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mDp+nd9Xcm+lU0AhuFwc9+kWdJypH+42HT8wCq3VT9AmqDgN/OSNlumTx2h+kEWjE
	 3WIVp0EYNCPW8tMHe58OpKvPLg1flXqliqXEnmMAuQWnatsanF6Sx+CWQxfTVb+4Ks
	 KOiFjJxMAb0+W9MiaUj5D7lSM/1kNdHd4M0RXBm4zmuw2WQNG4Mphp5xNWoUPVl6wJ
	 u+dk4OJ86p6yJ5U629FSxCYjfSmeJDLyobGQHa9wlEgp4PaG2gDgiJp8SQHBdqREkq
	 3pJh737Xpt8A6NNcPBhigl9n3hCuCh25TbLypTtMK9gdUlRrUdYizz6BKzxpxsMwB8
	 SPpvhHoX60nEw==
Message-ID: <56bf2171-2aed-4c65-a421-6f539ae1040a@kernel.org>
Date: Fri, 15 Aug 2025 17:35:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: set ADD_ADDR retrans timeout to 1sec
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20250718-mptcp-add_addr_timeout_1-v1-1-58749cbe8b87@kernel.org>
 <46d54c22-17b6-ce11-df8f-89add3c607d6@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <46d54c22-17b6-ce11-df8f-89add3c607d6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for your review!

On 14/08/2025 02:20, Mat Martineau wrote:
> On Fri, 18 Jul 2025, Matthieu Baerts (NGI0) wrote:
> 
>> It doesn't really make sense to wait 2 minutes -- the previous default
>> value -- to retransmit the ADD_ADDR if the echo has not been received in
>> between: that's way too long to react.
>>
>> Switching to 1 second by default, which seems like a good default value,
>> and can be increased for particular cases.
>>
>> Later on, we could eventually use a timeout based on the sRTT, with an
>> exponential backoff, which would be more reactive [1].
>>
>> Note: the documentation has been updated accordingly, and the selftests
>> are keeping the previous timeout when using a broadcast IP not to have
>> retransmissions in this case, which would cause troubles with the
>> different counters depending on how fast the test will run.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/576 [1]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Documentation/networking/mptcp-sysctl.rst       | 5 ++---
>> net/mptcp/ctrl.c                                | 2 +-
>> tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 +++
>> 3 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/networking/mptcp-sysctl.rst b/
>> Documentation/networking/mptcp-sysctl.rst
>> index
>> 5bfab01eff5a9db89e1484787953241c16e147cf..14059d2cac1b3467d6a8c9c4362f5a0b427b726d 100644
>> --- a/Documentation/networking/mptcp-sysctl.rst
>> +++ b/Documentation/networking/mptcp-sysctl.rst
>> @@ -12,10 +12,9 @@ add_addr_timeout - INTEGER (seconds)
>>     resent to an MPTCP peer that has not acknowledged a previous
>>     ADD_ADDR message.
>>
>> -    The default value matches TCP_RTO_MAX. This is a per-namespace
>> -    sysctl.
>> +    This is a per-namespace sysctl.
>>
>> -    Default: 120
>> +    Default: 1
> 
> Hi Matthieu -
> 
> I definitely agree that TCP_RTO_MAX is too large. After reading Paolo's
> feedback, I'm thinking 1 second might be a little aggressive. It seems
> like satellite links and heavily loaded mobile networks (plus a little
> buffer bloat) can lead to round trip latencies that can be hundreds of
> milliseconds. With exponential backoff, I think a slightly higher number
> would work. I noticed TCP_TIMEOUT_FALLBACK is 3 seconds, that might be a
> good starting point?
Indeed, probably setting 3 seconds seems better. But I think this
modification is no longer needed now that we have Geliang's series:
"mptcp: improve ADD_ADDR timeout handling". So I'm going to archive this
patch.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

