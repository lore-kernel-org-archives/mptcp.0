Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8EB75801;
	Fri, 14 Aug 2026 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719977; cv=none; b=XUvCyuLWDLtwdJQAbQpxz5Oz5d3AcliiUckBuV4CkeH2GVRt50oRgwZyu8hdmMxSQHn4WWX9aBw1YBRwJtLqCAuFZL/qZ80nhUOORPGRQ5NSTUK/rW5WA68FT7YGDCOcsoe9XQ2IDuxfR6q4B65hUQbEaA1X9O62HNOsWP7j4wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719977; c=relaxed/simple;
	bh=y66QjIu9+k2WYa3fHNxpAULLU4r+jYbLL7bLMxopSsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrYm87xac3mwDzwf4d5QT1qQxnVtkbXrgpEcOmIMB5moKuTVXCRlV1btbfNwc7pRdODs0Em9BMvIch0xCglvs7Mp9VfDYHRlEU548l0PTfuYa5EpgqLV+UJmW79/cYBfREFF9RV6gV/WfRluxMkqDE5v1a9KSp7P2Me/kUkh+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFmBts8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFmBts8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1168D1F000E9;
	Fri, 14 Aug 2026 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719975;
	bh=eTDoNCijpffwsuhfYUfjss8g3pWyUHGeLWGc9ix7oEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GFmBts8Lo3uqBhoWNTpM7ULQRPOUKo0OQPpzxHCAUg9syPhkt3uFgjZZuK2L88g4a
	 kHK2jO/1DUoT4qhsOZfvlFFCMhfK7YC85z1mIVd0qMV8xk6sWVXzY/TOqNNvaCcjwf
	 IIA2sxYtbssQF9BpmDHBvumTtzYcMFxa42YQ+iZVxqcQNQ2UAWreWuszJ1w84bYZ9L
	 s7HL70FEgAnOXCCJDD3CR2pqpi1xZim4SDwlgnl7X9QvxX2PZE05xMVI26yN/G1ERR
	 qVFRfwZ4M0bMv95A1Rv9V5RS3bv5+hcEqkzffvwujzMUFCXrbgru1JQ58YQSA5P03b
	 j3+8BThcHNMmg==
Message-ID: <e224943f-abc4-410f-83ad-7238c89dd49d@kernel.org>
Date: Fri, 14 Aug 2026 17:06:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] selftests: mptcp: print stats before socket
 closure
Content-Language: fr
To: sashiko-reviews@lists.linux.dev
Cc: mptcp@lists.linux.dev
References: <20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org>
 <20260814141500.A19A11F000E9@smtp.kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260814141500.A19A11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2026 16:15, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Invalid iproute2 command `ip netns id` causes an error message and incorrect NSTAT_HISTORY file path.
> --
> 
> --- Patch [1]: [PATCH mptcp-next] selftests: mptcp: print stats before socket closure ---
> commit 0e02bc2b403cc7ef4929da44802ea29557081b60
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> selftests: mptcp: print stats before socket closure
> 
> This commit adds a mechanism to dump socket statistics via ss and nstat
> just before socket closure when a poll timeout occurs. This helps debug
> timeout issues in the mptcp_connect test.
> 
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> [ ... ]
>> @@ -210,6 +210,19 @@ static void xgetaddrinfo(const char *node, const char *service,
>>  	}
>>  }
>>  
>> +static void print_err_stats(void)
>> +{
>> +	char cmd[128];
>> +
>> +	snprintf(cmd, sizeof(cmd), "ss -Menitam -o '%cport = :%s' >&2",
>> +		 listen_mode ? 's' : 'd', cfg_port);
>> +
>> +	fprintf(stderr, "socket stats before socket closure:\n");
>> +	(void)!system(cmd);
>> +	(void)!system("NSTAT_HISTORY='/tmp/$(ip netns id).nstat' nstat -s | "
> [Severity: Medium]
> Will this ip netns id command fail and cause an iproute2 error during the
> test?
> 
> It appears ip netns id is an invalid command, and should likely be
> ip netns identify.

No, 'ip netns id' is valid and is the same as 'ip netns identify'.

I used the short version initially to fit on 80 chars, but I guess I
should still use 'identify' to avoid this warning when sending the patch
upstream...

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

