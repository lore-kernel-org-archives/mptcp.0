Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58C138490
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300408; cv=none; b=PiTNlBluDww+5IvtMrekXj5w70i5ACsqZFysDzq7m7bP1x2uNy31SF5btJ7Qxm4hjm3bn40rX/AP2vEjfFm9C8kasrXFfAOPZcstaQRQU3pJwJVLMD3gMuufoA5MycfXTc7SsCpJtEr54rbHviW9DKvV/dsTtPEzxrEaFgu6e4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300408; c=relaxed/simple;
	bh=FVE63RB200CkrpD/dnBq8dMi879xoABNXluRmlET22Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nl7QC8TDfOZCBx6+cch0rAuby2pFxW9EKI1RX23qQP+5a/zPR9X9MFZ6vZGUsnzpedC5o26hklBr39TibioZ0gLWNPCkRw0jsAhL0VCv+rv1PD389+Jyc85nDEg98ZejhOwCfUUIZuSUxZXk7vNZxOkw5vqDIaVYQ7pt+4RnC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q50FSZRj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q50FSZRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58707C4AF0D;
	Thu, 18 Jul 2024 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721300408;
	bh=FVE63RB200CkrpD/dnBq8dMi879xoABNXluRmlET22Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=q50FSZRj28r5zDJ4b4h8pe9yUK5Ivt9l5pTM/H+7Fi58bD8b+z9ggsAXNc50zQTiO
	 ejDXXcfF//N5EfmTH98774e1a7ykQ+0XFoYftUiQStSyi96J0PtIyMRFUZ6PeiEyof
	 TAo+ZxpOMYVG2jqPZpKxbfT74Gn56h/qeGeQa6b5WuDHvD9CtbFiRchpWBt7+iozOP
	 wNHUPSFNc7oThSrXzKByycMIBUvc8AIfbtvlu3qUOyFWa8wd2PZID9PwIXJP5kenD/
	 +CThT/+8Th2+LbD1lxqs5J1Cp9XBMMuwMeAmaQDnOQc1qYJjmKygZXGzJSqWWj6pc8
	 JhCTOP4+ZbBIA==
Message-ID: <563e51df-9ded-4d5e-8e0b-589503547c3b@kernel.org>
Date: Thu, 18 Jul 2024 13:00:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 1/9] mptcp: sched: check both directions for
 backup
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
 <20240716-mptcp-backup-mpj-v2-1-4d50247405fb@kernel.org>
 <b1e4da8f4c7ed9179e4e6730f8b18f8661ace772.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b1e4da8f4c7ed9179e4e6730f8b18f8661ace772.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for the review!

On 17/07/2024 06:25, Geliang Tang wrote:
> On Tue, 2024-07-16 at 22:53 +0200, Matthieu Baerts (NGI0) wrote:
>> The 'mptcp_subflow_context' structure has two items related to the
>> backup flags:
>>
>>  - 'backup': the subflow has been marked as backup by the other peer
>>
>> - 'request_bkup': the backup flag has been set by the host
> 
> The two lines are not aligned.

Good catch!

>> Before this patch, the scheduler was only looking at the 'backup'
>> flag.
>> That can make sense in some cases, but it looks like that's not what
>> we
>> wanted for the general use, because either the path-manager was
>> setting
>> both of them when sending an MP_PRIO, or the receiver was duplicating
>> the 'backup' flag in the subflow request.
>>
>> Note that the use of these two flags in the path-manager are going to
>> be
>> fixed in the next commits, but this change here is needed not to
>> modify
>> the behaviour.
>>
>> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN
>> requests")
> 
> Patch 3 can be squashed into this one, with two "Fixes" tags here.

I think we should avoid putting two Fixes tags, because it makes the
backports harder. Also, the issue is really there since MP_JOIN got
supported: at the beginning, the extra subflows were flagged as backup,
and since the beginning, the backup flag in the SYN+MPJ is reflected in
the SYN+ACK+MPJ (patch 2). The scheduler was then always looking at both
side by accident since the beginning. By fixing use of the two flags
internally, we should also modify the scheduler to keep the same
behaviour (looking at both sides is what we should have done from the
beginning to me). No?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

