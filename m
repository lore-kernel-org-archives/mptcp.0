Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5638B12B
	for <mptcp@lists.linux.dev>; Wed,  3 Jun 2026 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479097; cv=none; b=BmQUM4qsp6y4xQAC6K6A6WhEz2TWEEys1GNrToTo8cUmdZwTGQ1b1MI3vzE2953oCn7Nx/sPKy/xaurZ4faxhIoPQP52xp/fbvDOy1tUSPrs86WtRXK4oxSPZ9aUFM0ENGy7DNN4jlxmupyqHx3Y+2eGp1r9+VdS2jiO9uw4xto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479097; c=relaxed/simple;
	bh=jevog7ZgwMMpBDzzgJuh3C+LP4pOtBz8enJvt5TI1x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KsmR2Fo0/j+Pl2RNpqrjHsYfz7FKJs7O8zDndqZWaomwk2UHDuBDVltFPvDZCghF3wMPTidgNhJunp5XbXwzcR6T3qvmZe9/fXLfSgK8a2m1P9LiJchRJP7Ho6DP/G2otdFKIuw+9yXJ81GZrDd8QDohBVo+rB44BoqWTfswnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od9mlgxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od9mlgxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E361F00893;
	Wed,  3 Jun 2026 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780479095;
	bh=eBpJEmY6W7riGnSXWIIMJ1UlmZkZa995Kn19zos7LUc=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Od9mlgxW42YC9kVvorAZkjeSqF3kvOSpi5i423oFKN1WmKVXcEwHSrqBfXDHi4FKF
	 mOi6xoHRVLVx3nwAZygmCX0lGp1cVKgDUb7RKFJkOHqSvrS9uKXsTtpXgwiY8wssqS
	 zYHxjQLU0wgjAGLtjt6av7gxX6VbiCIVP6ddu9uzYN0TY/4xBZrV8qAOHudiqlWOuD
	 iXccW3mRuOrcI+2QmcvOem8JOIZzk/5NNI+WXPQwsvFNzweCljqarzLNj3kMIW6Cee
	 peX1RYUUp6rf0XK9ZOlheTUdA1sO34LHSDODFuxxSfZKlIePmbNMorxmAR9US/FY8A
	 HpoCe/UgQZZ6Q==
Message-ID: <c3780b5e-0086-4338-aad4-b09e097d67c9@kernel.org>
Date: Wed, 3 Jun 2026 19:31:32 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: implemented OoO queue
 pruning"
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <406ff2a2ec71581f6ea6e7882a8ea631c20e23c7.1780153732.git.pabeni@redhat.com>
 <94176982-9a7c-472e-9328-3e95fc586e73@kernel.org>
 <c6d3caeb-ebfe-4acf-9482-41f7309a86a8@redhat.com>
 <1d5cc4f8-399f-451b-a92a-02834408d11c@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1d5cc4f8-399f-451b-a92a-02834408d11c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 03/06/2026 17:27, Paolo Abeni wrote:
> 
> 
> On 6/3/26 9:14 AM, Paolo Abeni wrote:
>> On 6/2/26 1:21 PM, Matthieu Baerts wrote:
>>> On 31/05/2026 01:08, Paolo Abeni wrote:
>>>> Sashiko noted that mptcp_prune_ofo_queue() is 1 byte too restrictive with
>>>> the bound check compared to the pre-existing code.
>>>
>>> The CI is reporting that mptcp_connect.sh is now flaky:
>>>
>>>  - normal:
>>> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/26704613812/attempts/1#summary-78703396420
>>>
>>>   - debug:
>>> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/26706355990/attempts/1#summary-78708269694
>>>
>>> When it happens, MPTcpExtRcvPruned is not 0.
>>>
>>> I can reproduce the issue locally (~5% of the time), so I started a
>>> quick bisect running mptcp_connect.sh, but only MPTFO and disconnect
>>> subtests, in a loop, 25 times (maybe that was not enough). Apparently,
>>> the issue seems to come from:
>>>
>>>   mptcp: implemented OoO queue pruning
>>
>> Of course :(
>>
>>> I didn't check the intermediate versions without the squash-to patches,
>>> but I can run more tests if that helps. Do you have a rough idea what
>>> can cause this?
>>
>> Pruning drops OoO packets and relies on good mptcp-level retrans to make
>> forward progresses. In the to samples above I see quite a lot of
>> NoDSSInWindow events - presumably happening _after_ the prune event.
>>
>> My wild guess is that MPTCP-level is not yet good enough/trip into some
>> corner cases. Possibly paired with pruning being too aggressive.
>>
>> I'll try to investigate this.
> 
> I dashed the above reply before actually looking at the PW status. 
> `mptcp: implemented OoO queue pruning` relies on 
> `mptcp: let the retrans scheduler do its job.`.

Detail: can we apply the second one before the first one?

> The latter is still rightfully on PW, and sashiko has a comment on it.
> 
> The (incremental) fix for sashiko comment should be, I'll test that and send
> a v12 (or you could apply it :).

I'm happy to apply it when you finish the testing, if you prefer not to
send a v12 :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

