Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52635A121
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482017; cv=none; b=DkU0dnxvRQmNE+jUgIuS/3jfu1Ohi+xJ/BG+6bCd/+y2oskMVnk8vjc/+I3RQSn9VCPiXhlqIfYsHY8gYaXZdGBP62aqn0lAPbBJuSAKVtmscVW+//KkF/O3BoRYP9X/f5hi+CskNR9g7cFX6Q4bMokxAX45J1lX9AIaWmrGyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482017; c=relaxed/simple;
	bh=ZLcTEG9vcp0SWTgBXJ/sk+GpoyJUyHgCuUuXuoSXRRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Mea2/HG+vU8sGOJUCqRuh4Gq0hLk/QBmfp0FmIztYr1Rfbp2TQj/EWGuDyXZNTFGT7cxZjyktnTHms/Sl2BU4QyHc4jVglx77BGxcOKb/vSA7wEFOEn0pFg/g85CNXd6rZtffDieQGiAf7F2Rn6E69YXHlEinURUt2Tk69b/s3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG8HAQoO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG8HAQoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0940CC2BCB4;
	Tue, 18 Nov 2025 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763482016;
	bh=ZLcTEG9vcp0SWTgBXJ/sk+GpoyJUyHgCuUuXuoSXRRQ=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=LG8HAQoO9f6So2G/Xc4L7X7FMNDz4FGJPbAQHvwZgUXJcCFJv8Ubr347/cVqr7uoH
	 ry5Ikh5cVkMBYVrhWbw+3OFl0cMwKpa6FYmy6vukci/1Kh1Qb2cCaLocKpqMqXKWDs
	 z5s7bFCvbRcbSi9c4icpy6Y9FlgUm2E4RoaqdeJ9awyWeGoU+E5QkB2e8nZ5cheSQ8
	 uB7Zh3Gfr1FPv7TZNc+IE2W0ywvM+e+gHuGX6U+Duxrb/7MtNgdWoJeHo28gjhRJci
	 /dahRPoF4deqs2LO9Gs0slMcVw7Kvf3zHb9lqWII4C81u6KAMjCCNY7ZkOv7ecW6Eg
	 IxcFJre3bjSTQ==
Message-ID: <ac2cc150-6bda-4a2a-b884-8aea1d850396@kernel.org>
Date: Tue, 18 Nov 2025 17:06:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 0/2] selftests: mptcp: join: longer timeout
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
References: <20251112-slft-longer-timeout-v1-0-97aab145a062@kernel.org>
 <8aeea045-c68d-493a-8f83-4a9187480428@kernel.org>
 <899b64e9d595ac0a2b256041bf91dba0010fcd9c.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <899b64e9d595ac0a2b256041bf91dba0010fcd9c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 18/11/2025 09:43, Geliang Tang wrote:
> On Mon, 2025-11-17 at 12:08 +0100, Matthieu Baerts wrote:
>> On 12/11/2025 10:45, Matthieu Baerts (NGI0) wrote:
>>> A previous attempt was helping, but not enough as the background
>>> connections were still stopped after the timeout. That's what the
>>> MPTCP
>>> CI recently reported with the "delete and re-add" subtest taking a
>>> bit
>>> more than one minute in a debug environment.
>>>
>>> To play it safe, and because increasing the timeout for the
>>> background
>>> connections doesn't change anything to the end result (the transfer
>>> is
>>> not checked in this case), all subtests with a background
>>> connection not
>>> waiting for it to end now have a longer timeout.
>>
>> I hope it is OK if I apply these patches now: they are simple, linked
>> to
>> recent patches, and we still have quite a few patches in the queue.
>>
>> I'm planning to send them with other patches we have in the queue for
>> net ideally today.
> 
> Sorry for the delay. I just replied my RB tags to them for -net.

No problem, I'm sure that kind of simple patch in the selftests would
have been accepted without additional tags. Thank you for having sent them!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

