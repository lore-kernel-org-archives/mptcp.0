Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D6E2206A7
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843112; cv=none; b=WXqIAjhT1xBi2VHXYdFZiVfUdw0bpVJZociZ3u2NvqdK+sMS5daHOO6u698P7H6rz2UyvvxT4SaWmDuCol8jcr+mALAaVaAkTvnbRyfAu+V2pn8h+lXDY/AZ8PRO4MD0Ia0mBnAQOQCuMSMRKASmYNC9+gnEeSxELOW8yzzzXqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843112; c=relaxed/simple;
	bh=771CJBShlajB4y1TVr0o7ez3+p5o3+9lki4lJh5MsbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZJMtiecr2QWEcRoTw70XZL5LvWdpi7PCxh7GJOAsiMRCd0Xn1zxrFIPaIyY7tsBv2ZIup+0eMjg7V16HOz3TVhf3zFxCxkgIQ/H/F/KYEfPEIzICNarGsnyeQxn2NcajFfE5SxzRlmHDI6QSJHUQn1tAm3FnMCnrF0V8XM/6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8iljoy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8iljoy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1857D1F00A3A;
	Wed, 27 May 2026 00:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779843110;
	bh=txqIXcSaV/gSIKM46DdTZh0tZTY6E6P+eJYJo96eqGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f8iljoy8NG13nZj6TQP6/STkORB9clWk+3z5PjF+xPaV8oBRTYkdT2s5xgtVxvmjm
	 rJKXnyzNHfuH5Hl03SFEKDawrajuKUkXxbC06kgEfa4pxWS4cBB1vrdVINzRnB5Qkr
	 PZU9FzDxCbz2cWYhsqTL2tFdvnDrulvQXg8Qsu9mA1ASmG74wWBru3sd5RtJ7luOLU
	 //Gt+dP7GBKJE7mQtFVcetqFU7i8/ZbKaaK69ILIzf2QfSOL124PhwW8burVkLzgH/
	 6YbvC6Uqd6ojzXr5n7uDTySE+rvu9n9U/fmBZbkbVx0tWqB2Zg5cAVgkxI/aom7ywM
	 YOGzJvIzMoBNg==
Message-ID: <8fb85b98-f677-48de-a9d1-72ac82c25c50@kernel.org>
Date: Wed, 27 May 2026 10:51:46 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 mptcp-next 4/9] mptcp: allow subflow rcv wnd to shrink
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev,
 mptcp@lists.linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <661603fa10737a624bba854fb2515c7abb129a80.1779485511.git.pabeni@redhat.com>
 <a017ffa9-1dbe-4094-ae85-7c17e7b48b0d@redhat.com>
 <085ebc3e-0d49-4a82-aea9-a8b05a02c7ae@kernel.org>
 <0624d85c-1992-4b4f-bbdb-32c454ac7765@kernel.org>
 <eede8443-e2d9-4bf4-8e66-76e4302706ad@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <eede8443-e2d9-4bf4-8e66-76e4302706ad@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 27/05/2026 01:17, Paolo Abeni wrote:
> On 5/26/26 9:49 AM, Matthieu Baerts wrote:
>> On 26/05/2026 17:02, Matthieu Baerts wrote:
>>> On 24/05/2026 18:34, Paolo Abeni wrote:
>>>> On 5/22/26 11:43 PM, Paolo Abeni wrote:
>>>>> In MPTCP connection, the `window` field in the TCP header refers to the
>>>>> MPTCP-level rcv_nxt and it's right edge should not move backward. Such
>>>>> constraint is enforced at DSS option generation time.
>>>>>
>>>>> At the same time, the TCP stack ensures independently that the TCP-level
>>>>> rcv wnd right's edge does not move backward. That in turn causes artificial
>>>>> inflating of the MPTCP rcv window when the incoming data is acked at the
>>>>> TCP level and is OoO in the MPTCP sequence space (or lands in the backlog).
>>>>>
>>>>> As a consequence, the incoming traffic can exceed the receiver rcvbuf size
>>>>> even when the sender is not misbehaving.
>>>>>
>>>>> Prevent such scenario forcibly allowing the TCP subflow to shrink the
>>>>> TCP-level rcv wnd regardless of the current netns setting.
>>>>>
>>>>> Fixes: f3589be0c420 ("mptcp: never shrink offered window")
>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>>
>>>> Sashiko failed to review this series from this patch included onward:
>>>>
>>>> https://sashiko.dev/#/patchset/cover.1779485511.git.pabeni%40redhat.com
>>>>
>>>> and it's not clear to me why.
>>>
>>> It is not the first time I see failures. I guess it is not linked to
>>> your series.
>>>
>>>> I think patch 1/3 are quite uncontroversial and reasonably even this one.
>>>>
>>>> WRT the stall addressing patches, this iteration survives mptcp_data
>>>> testing without timeout tuning, hopefully should be fine for Geliang and
>>>> Gang usage.
>>>>
>>>> @Matttbe: please LMK if you prefer a complete repost or if you could
>>>> apply patch 1-3 (or more).
>>> Sorry for the delay. Yes, on it. I guess patches 1-4 can already be
>>> applied to -net.
>> Just reviewed them. Please tell me if you are OK with the suggested
>> modifications, or if you prefer to send a new version.
> 
> I think patch 4 does not need modifications. On the flip side that one
> is a little delicate and has not gone through sashiko yet due to the
> mentioned issue. I think you could apply patch 1-3 and I'll repost the
> following ones.
Fine by me. I just applied the 3 first patches with the 2 small fixes:

New patches for t/upstream-net and t/upstream:
- fc8fb422aae7: mptcp: fix missing wakeups in edge scenarios
- 6219a0efdede: Squash to "mptcp: fix missing wakeups in edge scenarios"
- 2950e9d2932a: mptcp: fix retransmission loop when csum is enabled
- fcee762a0dc5: Squash to "mptcp: fix retransmission loop when csum is enabled"
- 0f17b1705eee: mptcp: close TOCTOU race while computing rcv_wnd
- Results: 1685899b9752..7865561e04f3 (export-net)
- Results: 599cb099e01e..19d4169d0689 (export)

Tests are now in progress:

- export-net: https://github.com/multipath-tcp/mptcp_net-next/commit/32c8161bff373b91be456498bcb8463c146460fe/checks
- export: https://github.com/multipath-tcp/mptcp_net-next/commit/b41d3d0c1a32a4a80618b5898cf6f993ee9e8511/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

