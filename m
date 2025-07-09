Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2B283FE6
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052684; cv=none; b=Tfr7nCrpcaHPRnGlwzZFZaC5XKJdbxY+Dqz839Da6porwyBsiWwRlxP6YxR/VAbOGou1GOlLJhjIrUSWSL9BcbcMyGVSu3bgN9KALxXoobXE79V6+3ieABrrOCgxwkoa+JQILS3YBmWZZ1OEQBTmaRvFFvK9heq9vhPMsU4OisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052684; c=relaxed/simple;
	bh=Q4llImqfl4mIUqshTfnOve+vDMcxL1JziewYhHaH3/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t8TeAIVPS3MN6EqshPNn8/nBNZatdZCmh34/MDSbzOv5J8GhaRzoItJLa40QYiqT4JRneqcwmY52kLx6UgpOT8rbJc9dgrxrcigXY/IMZ/8Wznd3ECr/I3kM0d+NjXNpl53xCE5bwVv8uYAFSEfBtV7h/mNzOfcKkm/pc5NMwfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pK1tYYC3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pK1tYYC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD56C4CEEF;
	Wed,  9 Jul 2025 09:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752052684;
	bh=Q4llImqfl4mIUqshTfnOve+vDMcxL1JziewYhHaH3/I=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=pK1tYYC3ASTaJL5dTLip2F9ZenORTp3TS1DSlmjCxGuDrg0MRvwU1f6VHVsv+654j
	 SwsUDp2xgP1Qd8BlzKkyrs+IAqCyVILL4dNBJpO4QF0IKQaeR3tzjOQ+s0MEbYLiwP
	 oboAdPBPaF7/mX9UPtWCgfbDsVVocrI3/HU+EzToze1TdevhI84RKectmfRLAS5j8p
	 18WkUnO6bAEyzP15RNtdW2gbINSVde3vzYURcHhYrqftx8h5jFWxgqqXzPGBksDtbf
	 PS9nnciBxyxvw+SN2JE2YwlWWP+TEPf2n1nYPl05JBX4UCrH70L3Ret54TYyC+V94T
	 YSRBEY66z2XpA==
Message-ID: <a5cb87c7-18a9-4105-85d6-baa68be6a673@kernel.org>
Date: Wed, 9 Jul 2025 11:18:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 2/5] mptcp: plug races between subflow fail
 and subflow creation
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1751699999.git.pabeni@redhat.com>
 <ef3a8b7c681bcd78846f047509928bfffff96057.1751700000.git.pabeni@redhat.com>
 <766cdd27-eb1d-493c-ba47-bb8c8467fbe8@kernel.org>
 <0a59dfb9-7bb5-46cb-ae97-b98eba820848@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0a59dfb9-7bb5-46cb-ae97-b98eba820848@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/07/2025 11:14, Paolo Abeni wrote:
> On 7/8/25 5:42 PM, Matthieu Baerts wrote:
>> On 05/07/2025 09:24, Paolo Abeni wrote:
>>> We have races similar to the one addressed by the previous patch
>>> between subflow failing and additional subflow creation. They are
>>> just harder to trigger.
>>>
>>> The solution is similar. Use a separate flag to track the condition
>>> 'socket state prevent any additional subflow creation' protected by
>>> the fallback lock.
>>>
>>> The socket fallback makes such flag true, and also receiving or sending
>>> a MPTCP fail option.
>>
>> Just to be sure, can we not rely on the MPTCP_FALLBACK_DONE flag for the
>> two cases?
>>
>> In other words, do we not already have something set when
>> sending/receiving an MP_FAIL instead of adding a new field? It feels
>> like we already store this info, no?
> 
> mp fail is not an alias for the new field, as the latter will be true if
> e.g mp fail has been received or has been sent or sent or in case of
> fallback.
> 
> We could check all the above conditions in an helper, but I found
> simpler adding a new field
> 
>> Can we not continue to use __mptcp_check_fallback(msk) and
>> mptcp_check_infinite_map()?
> 
> Yes and no ;)
> 
> Meaning such checks outside the fallback lock are racy, so they are
> possibly useful in the fastpath/datapath, but for fallback related
> decision we need to acquire the lock first.

OK, I see, thank you.

Hopefully this new field will not be too complex to backport.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

