Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4DA235BF0
	for <mptcp@lists.linux.dev>; Tue, 18 Feb 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874935; cv=none; b=HDjGrPhSq7gxhIP2mGmRAWZBH67ZI0SACummVUqI9RFKmpxT2guslueVNQqwBjYh5ooavBXsUvIurQj0HMRnPnZXFUmpSy8onN3wILYsCm3n868Pw4ZpcphwHmHXz5WqASV6A+/guZzu6H4Tgs+/ZJtGOj2qjRf7PhhMRgQ7Jzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874935; c=relaxed/simple;
	bh=o3hjbKMwvEtAqxXJ82BMI4SO8kIxQeicC5snYo3xK9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pkdTqefMOQog4zVA2ObSco+6l0kAPTp88fLBGNdIJFMqmTLp+tZuH/oSi48DYN7OF30YkM/OOFYnCKd4Ct49YpSPylsj5Sty6Ru8okDtV9s4EfWWs+vOE8oncwu91iW+tRTK8mEPv0u7tEAdQpgGCoeqzKNND+bzcQNAgEP5b6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ/el6vt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ/el6vt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFC5C4CEE2;
	Tue, 18 Feb 2025 10:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739874934;
	bh=o3hjbKMwvEtAqxXJ82BMI4SO8kIxQeicC5snYo3xK9s=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aJ/el6vt1X7nw8VdWJNvVvfQ/yK637WpfKn5NVPPVvn6UOuoh3xIWdp0NI8sF3Yak
	 45/LH4sEQS3FVr5RS0wne2UTol5FqPH51twKWdN76xt7fp/bsXXCWmU0x5Zsy9Jgih
	 zWWCihprW2IXqqELvHYBuT29SA6JUb7aLcnahsVh7oEQJGkBJzzOkGPpBvNuLiQDwE
	 mnQLJ5QlI1FYTWxI6cYJ3/iSp9FUqKYs/OFbB8hS1DWHSFXJpDDeluhK/RlTM74P1A
	 KDdKHQIO9ezJn3SKFfSa5xQuwQIpRcmBn8cqHo7NVO4TDSHmULebEuPPRjuhhickug
	 YIbXgTj1KNXJg==
Message-ID: <e1a20bfd-d8ae-4e7b-9cf3-f8d6c3fc32e0@kernel.org>
Date: Tue, 18 Feb 2025 11:35:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 2/3] mptcp: only fallback due to inf mapping if
 allowed
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
 <20250217-mptcp-dss-drop-mpj-v1-2-d671d6b9a153@kernel.org>
 <ce88eac1-1ed9-4ffc-837e-fd5c9aae7b5d@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ce88eac1-1ed9-4ffc-837e-fd5c9aae7b5d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2025 19:21, Paolo Abeni wrote:
> 
> 
> On 2/17/25 9:37 AM, Matthieu Baerts (NGI0) wrote:
>> Any fallback should happen only if allowed, so only if this variable is
>> set: msk->allow_infinite_fallback. This boolean will be set to false
>> once MPTCP-specific operations acting on the whole MPTCP connection vs
>> the initial path have been done, e.g. a second path has been created, or
>> an MPTCP re-injection -- yes, possible even with a single subflow.
>>
>> In other words, the !msk->allow_infinite_fallback condition should be
>> placed first. If it is no longer possible to do a fallback, there should
>> not be any bypass, e.g. when receiving an infinite mapping.
>>
>> Now, regarding the conditions to do a fallback, the RFC mentions [1]
>> that if the checksum is used, a fallback is only possible when "it is
>> known that all unacknowledged data in flight is contiguous (which will
>> usually be the case with a single subflow)". In other words, if the
>> checksum is used, a fallback is possible when the other peer sent an
>> infinite mapping indicating the flow has been altered.
>>
>> Note that the issue is present since a merge commit, where both
>> subflow_can_fallback() and the previous extra condition with
>> 'subflow->map_data_len' got introduced.
>>
>> Fixes: d7e6f5836038 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
>> Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.7-11 [1]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> I have the feeling this patch could/should be squashed into the previous
> one.

When I created the commit, I struggled a bit to describe this change as
it was not directly related to my issue (subflow not reset when MPTCP
options are dropped on the second subflow), then when I saw the origin
(Fixes tags) were different, and I did the split. But I can squash them
if you prefer.

>> ---
>>  net/mptcp/subflow.c | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 6ec03580ccec12fb50fc3aacf3d22413647b32b5..a8ad16db1ecd08ef7155a38161555253e4c72399 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -1298,16 +1298,20 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
>>  		mptcp_schedule_work(sk);
>>  }
>>  
>> -static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
>> +static bool subflow_can_fallback(struct mptcp_subflow_context *subflow,
>> +				 enum mapping_status status)
>>  {
>>  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>  
>> -	if (subflow->mp_join)
>> +	/* If not allowed (additional paths, MPTCP reinjections): no fallback */
>> +	if (!READ_ONCE(msk->allow_infinite_fallback))
>>  		return false;
>> -	else if (READ_ONCE(msk->csum_enabled))
>> +
>> +	/* More strict with csum: fallback in 2 cases: inf map or never valid */
>> +	if (status != MAPPING_INFINITE && READ_ONCE(msk->csum_enabled))
>>  		return !subflow->valid_csum_seen;
> 
> Is the above branch (csum_enabled) still needed? AFAICS csum fallback is
> handled by the previous test:
> 
> 	if (status == MAPPING_BAD_CSUM &&
> 	    (subflow->mp_join || subflow->valid_csum_seen)) {

Good point. Then I guess we don't need the new status for infinite
mapping, and we can even drop subflow_can_fallback() and only use
msk->allow_infinite_fallback.

Thank you for the review, I will prepare a v2 squashing the two first
patches and simplifying them.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

