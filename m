Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D45588B
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954657; cv=none; b=IGHX4YxOaxIBd7p2NyYGYXQpNenct6nwh93YDJSeVTKnNvFkvfKt/ybgJ4DtOe6ya6UpQdFD9RBOfo1Q9/HGyvoy1hTX7ejhEsaB612pd5L64LhnYOiyc2YCmGyT0lMBpqBG1b8XQr3b8ynnFsjsuufgrEuhebxcKMkC1j3WMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954657; c=relaxed/simple;
	bh=WN6K4c1CjB2LfXCoTg630kzflO0s0JhdQ1PvkJIK+lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQiGicOLakAcIQ3HSdC++CMLtR5bOp1HOxnIzemFvAV97PHFbDHR511xszhQWN2/LFMAa753frIja3gjOjXArGIdMmFlYNVimvJfa/xU7nkGU4r758z4AAPn9WFLDGKsXCr5/2w5IevoOovlXZjmIwuKdJ7AuGo81IDIu+P5Ll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aED1IfoU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aED1IfoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4CCC4CEC3;
	Tue, 10 Sep 2024 07:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725954656;
	bh=WN6K4c1CjB2LfXCoTg630kzflO0s0JhdQ1PvkJIK+lY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aED1IfoUV/Iu3CWGXy56710hLqnr1lkMjl+Q9QQei8c0lL8zwf0ACuGG2Bl1fSd22
	 VDKj3WyNSeyhyx+/+BpZQOOB0XYZCcMGa4GVkM+V/8Xgh13CrFQtpfyIuSBOc1eHIs
	 K+FfL6g8lM9i0t+FvWg3DbvbStRyowR8+hcll8d+Wg8sQhqphVJXsHhAuubhlWK+gx
	 WBQxW9dDGqfXQTVhGIUtJsdTLT6IKxTRBqZuVqFS6jrPK+SrDaTfnOKiswMI1nsTCf
	 u9Ybi3ByGmK3eymkLmQM2kVrhUc+Z8tOWh5TApodRmxRBMhvZRevlOfHkOXl/aSdnN
	 xy6H7IGzQEkWA==
Message-ID: <d55dc439-25ce-4a37-a34b-0ac369f51262@kernel.org>
Date: Tue, 10 Sep 2024 09:50:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next] mptcp: Add data race when accessing the
 fully_established of subflow
Content-Language: en-GB
To: Gang Yan <gang_yan@foxmail.com>
Cc: mptcp <mptcp@lists.linux.dev>
References: <tencent_604F30643CD92D084CEB0AA3BE951B30C009@qq.com>
 <d9f3f461-b1dd-4410-977e-2dc34d0d485a@kernel.org>
 <tencent_D1213243EC4704D175815109CA4A18FD2708@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_D1213243EC4704D175815109CA4A18FD2708@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang Yan,

On 10/09/2024 03:26, Gang Yan wrote:
> Hi Matt,
> 
> On Mon, Sep 09, 2024 at 05:39:45PM +0200, Matthieu Baerts wrote:
>> Hi Gang Yan,
>>
>> On 09/09/2024 03:14, gang_yan@foxmail.com wrote:
>>> From: YANGANG <yangang@kylinos.cn>
>>>
>>> We introduce the same handling for potential data races with the
>>> 'fully_established' flag in subflow as previously done for
>>> msk->fully_established.
>> Thank you for this patch!
>>
>> Now in our tree (feat. for net-next) with the suggested modifications
>> from my previous review, but also a different subject, I hope that's OK:
> 
> Thanks for applying this patch for me. I have an extra request. Please update
> my email address as 'Gang Yan <yangang@kylinos.cn>', both after 'From:' and 
> 'Signed-off-by:'. 

Sure, done!

New patches for t/upstream:
- 3556880e322e: tg:msg: fix Gang Yan's name
- Results: 7b4520aa7386..5d7105311119 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/81759bc01d332f97adaf46f8de6ed7afa8a3b3c4/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

