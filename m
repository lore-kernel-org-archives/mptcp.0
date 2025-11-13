Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1DA29E0E5
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025961; cv=none; b=hnwxeuYUanZKIbWc5JOLfpOp6bRM1YujYUJwl3UHqACpovemXjFP1pc92hEPYevBSoW+i6jcPUC9pqd7pfa8C/bE/Rkx9350Gv9P1WtTJwm8eHRoRU2Ia7zF8HhiHLahGVVG28T70dP7gktA/6BuuvRqv+qe4wNF7TkmBo8XGCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025961; c=relaxed/simple;
	bh=2zVeQAXF4chJ67Iak1d0DpECeU4V/X5x8yUpatJWhA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lsmt20QMv50SYMDGG9whyOFLPLvE/vvEwj3Q4+G5zmwmgR5qRGIG589uXsG0f9q6w7VDDcF/8jzkY0vlvS/KtciIj/rUVl8+/lvwc/unHSZ5Qofbfi1L1W0qCmeH3yA75zt3Op7FGl3aq/OVEDOIGlCsxMK4hYXMzbrzEOuy5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6MGkzXI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6MGkzXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211B4C4CEF5;
	Thu, 13 Nov 2025 09:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763025958;
	bh=2zVeQAXF4chJ67Iak1d0DpECeU4V/X5x8yUpatJWhA4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=G6MGkzXIjWU/8P9G5DJgOw8CpmwuItyoH1rYxikHvf4KphEuYBuR2pp7Hty3ECZuh
	 VsDi/3Zevamg8zwg2piRWhSaUDAkYDvg4sO9H1AWPrDt/nhOC/bxFrPYWFCdcq2hPI
	 yUh9FJ/vV0RRYxboh4OKiSqjZ1HTmHzxMEILYpAcVUyw+ZeYfNz5JPL8wy2VvZyg2j
	 ze6C2J4E+d3aSx3gZE4LpJoHubi53pnXBKluxQC+tLk0WhKDCm2xH1OfnjUJ5FAnLT
	 Sp83QVNtvNMbdeGO+aBmBbu3vBJGHVdHfqKRU8W7Y+kWKJ6cQBgupXp7BuOp+WLwpp
	 KKflzanUetgfQ==
Message-ID: <79e4c200-738e-46d8-bbd4-63647d3b1f71@kernel.org>
Date: Thu, 13 Nov 2025 10:25:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 4/4] selftests: mptcp: get stats just before
 timing out
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
 <20251108-slft-timeout-stats-v1-4-c2234d277318@kernel.org>
 <2a6869ca39bda7ddf8b486cd03e0867b30e0d565.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2a6869ca39bda7ddf8b486cd03e0867b30e0d565.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 13/11/2025 08:15, Geliang Tang wrote:
> Hi Matt,
> 
> On Sat, 2025-11-08 at 15:20 +0100, Matthieu Baerts (NGI0) wrote:
>> Recently, some debugging happened around a test that was timing out.
>> The
>> stats were showing connections being closed which was confusing
>> because
>> the closing state was caused by the timeout stopping the transfer.
>>
>> To avoid such confusion, the timeout is no longer done per
>> mptcp_connect
>> process, but separately. In case of timeout, the stats are now
>> printed,
>> then the apps are killed.
>>
>> The stats will still be printed after the kill, but that's fine, and
>> this might even be useful, just in case. Timeout should be
>> exceptional.
> 
> Today I found that this patch has increased the runtime of the
> selftests, for example:
> 
> # 66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration  
> 390ms) [ OK ]
> # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration  
> 415ms) [ OK ]
> # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration  
> 380ms) [ OK ]
> # Time: 38 seconds
> ok 1 test: selftest_mptcp_connect
> # time=99
> 
> The mptcp_connect test ended after 38 seconds, but it waited an
> additional 61 seconds before finally stopping at 99 seconds.

Good catch, indeed, thanks, I will check that!

I guess I should use mptcp_lib_kill_group_wait() to kill the "sleep"
command as well.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

