Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CFD1531E6
	for <mptcp@lists.linux.dev>; Wed, 21 Aug 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724236747; cv=none; b=ozziaoecTdGV06y5lo8gVLBIvZ0oE2UeePfb0pfiMsES4x7xoEoEtwaCyQYFMYAy5PpIxZaH0LLszmiHUXHslsZqwO70xuQoYaijEvwcTF37qtIDsdKvJJ4hoHMQ/avfb5U1EsWaswrXHwfUTVhPIJD06IgrSURCV4veulD5IYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724236747; c=relaxed/simple;
	bh=xxH0LuNsB+DyKoGDFDWxXj1peRI4e4bojJNDlG3uPjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RrM83J2HYrFbu6x9ejAdt3M8RpvEpOo5sPaePO3f0mruZ4DjtBHUHDGh7YSwqmXhp96i2/8UFHZvx52+DhXvamXXXuzynuzYuUzAG8LQf7BYaF9muNMSbvp9LaICfE/IXh2so0tIdEJvwDQ/NxIPO+TnqGPQUI1g5e4NEjJming=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2sDajcX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2sDajcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71EEC32782;
	Wed, 21 Aug 2024 10:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724236747;
	bh=xxH0LuNsB+DyKoGDFDWxXj1peRI4e4bojJNDlG3uPjo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=W2sDajcXFEZfiTF8ucQO0GjqaGN90/kyF99IyuaM9wHV+jwBqMGTmpi+JnkOIwsxJ
	 YykPlmf2n+x1q2Rx9iz793DfYAbq2V3YRPNrtJXs8el1f4+9Zme7o5MXT/XQyMqhGC
	 3SluJgXqKz7jYErSJfWfqiG/7yaeJcXij1oYT9VAd1+4sZ1QYeVpTbTedvqsT4jnGy
	 wWDxQcMUw+PzcnDLl46KsfaAbZfjupROv8b1b1fYf/ze5C/T7c+kkEQimChJpEZWX/
	 HzY3EWhzr+PJ7nqDIOFjbhH51aYMRvDcYeL0RGH9/5Gbtz1gO4pd3O74m/U+ZO577k
	 ms5CTpYiOUl0Q==
Message-ID: <d6e10c7e-2ff1-4fcb-bae8-294d3d203882@kernel.org>
Date: Wed, 21 Aug 2024 12:39:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: pr_debug: add missing \n at the end
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240819-mptcp-pr_debug_n-v2-1-97cbe3f7d975@kernel.org>
 <ec12d8bb1e760327228fe9a08573ea0428daf8b2.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ec12d8bb1e760327228fe9a08573ea0428daf8b2.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 21/08/2024 08:46, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2024-08-19 at 10:01 +0200, Matthieu Baerts (NGI0) wrote:
>> pr_debug() have been added in various places in MPTCP code to help
>> developers to debug some situations. With the dynamic debug feature,
>> it
>> is easy to enable all or some of them, and asks users to reproduce
>> issues with extra debug.
>>
>> Many of these pr_debug() don't end with a new line, while no
>> 'pr_cont()'
>> are used in MPTCP code. So the goal was not to display multiple debug
>> messages on one line: they were then not missing the '\n' on purpose.
>> Not having the new line at the end causes these messages to be
>> printed
>> with a delay, when something else needs to be printed. This issue is
>> not
>> visible when many messages need to be printed, but it is annoying and
>> confusing when only specific messages are expected, e.g.
>>
>>   # echo "func mptcp_pm_add_addr_echoed +fmp" >
>> /sys/kernel/debug/dynamic_debug/control
>>   # ./mptcp_join.sh "signal address"; \
>>         echo "$(awk '{print $1}' /proc/uptime) - end"; \
>>         sleep 5s; \
>>         echo "$(awk '{print $1}' /proc/uptime) - restart"; \
>>         ./mptcp_join.sh "signal address"
>>   013 signal address
>>       (...)
>>   551.75 - end
>>   556.76 - restart
>>   013 signal address
>>   [  551.367935] mptcp:mptcp_pm_add_addr_echoed: MPTCP:
>> msk=000000000740d23c
>>       (...)
>>
>>   ## => a delay of 5 seconds.
>>
>> The 'Fixes' tag here below points to the first pr_debug() used
>> without
>> '\n' in net/mptcp. This patch could be split in many small ones, with
>> different Fixes tag, but it doesn't seem worth it, because it is easy
>> to
>> re-generate this patch with this simple 'sed' command:
>>
>>   git grep -l pr_debug -- net/mptcp |
>>     xargs sed -i "s/\(pr_debug(\".*[^n]\)\(\"[,)]\)/\1\\\n\2/g"
>>
>> So in case of conflicts, simply drop the modifications, and launch
>> this
>> command.
>>
>> Fixes: f870fa0b5768 ("mptcp: Add MPTCP socket stubs")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Thanks for this v2. LGTM!
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>

Thank you for the review!

New patches for t/upstream-net and t/upstream:
- adcccec8d800: mptcp: pr_debug: add missing \n at the end
- Results: 76f6fba9ef6b..ab5c53816256 (export-net)
- Results: 80d8c6b850fb..624d90dc5dca (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/d0a1f54fb2f9a9a0e2b6ea85fae9670ac4818469/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/f81bdeae843224cb42ef2613e833d46675d9e8c9/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

