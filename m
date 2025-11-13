Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1B328B57
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055897; cv=none; b=IWmm4QwSE26pn3LxIc1gbiMCdyor4cQhzTH2F42igqTlbkFo/AbqrOAEk4bcMzmkd7Q5hCqftpIdUKJ6ckxiD0I5h/ajXBf5VyAftzqxz0hVJRYw/p561vKBC//eE44kndSKVS8NpWchI+6VWyqwUmyeqAnMEJ1v/Cf6pY0/lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055897; c=relaxed/simple;
	bh=fMBKMUoixRMOIy4QVzBkJa2d/k4ZcJCtnwziDJgR9nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A0AshGURHgEOZHug5YohkVV6OJ75/SQy2W2PPH4fvnyfW/q1GAyWdZBDvPViyK56RKze6kLoYTZR8jNj6Yuup1+r4rBzaT80UI/MBINDpuFwCw9uoPdikR95x4Y5LN/PLeYypiEQyCiFi2J+7kK5tojoWbocyEEvXqDNWy3LKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKMmgWLR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKMmgWLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2E0C4CEF7;
	Thu, 13 Nov 2025 17:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763055896;
	bh=fMBKMUoixRMOIy4QVzBkJa2d/k4ZcJCtnwziDJgR9nQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cKMmgWLRlUtY3LI1fl7IpPKXQDGydPlfq6kN7OwnI3zowf+Uii71MB1ru6ai2vXoI
	 OKOc0W+b8EZoKocs/yUmHggJ893Wz52xEcqjx2TBachMvFYwRLAKi+bsjPlaFu3Pdw
	 Gne1HRpqIXhLRvhquTE//uMh1SuCi1bpXwyL09c6jvYKAQIamapn/J2bPBC9eC3U+A
	 filQYRHM1fuii2BnZbU/7odx752AvEj+GeEiR9akp46kKVLS4IxCJAzLxL0vlSEpe/
	 3+xXlKNjKJcOdhFh5oODKZeCxB4eYIEoteWUM2vgyrRmSCHPtl9VYL/hPjcrRbwQas
	 BQb37pt+Ltm+Q==
Message-ID: <6d5b889c-47c2-421e-bb3d-0dcc7da21650@kernel.org>
Date: Thu, 13 Nov 2025 18:44:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-net 1/2] mptcp: do not fallback when OoO is
 present
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1762845791.git.pabeni@redhat.com>
 <fec239b14fa74d96fee25928de089de45f2c99ef.1762845791.git.pabeni@redhat.com>
 <1929f39e-b3e5-437d-b8da-71e3c7e6f36b@kernel.org>
 <686e7b33-00c5-47dd-af4a-8ac3014869b4@redhat.com>
 <3990718e-e4a8-4eb2-965e-02847bb339c0@kernel.org>
 <6e8bb6a1-0c96-4fa5-b8bf-cd0253e4450e@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6e8bb6a1-0c96-4fa5-b8bf-cd0253e4450e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2025 18:32, Paolo Abeni wrote:
> On 11/13/25 10:08 AM, Matthieu Baerts wrote:
>> On 13/11/2025 01:02, Paolo Abeni wrote:
>>> On 11/11/25 6:50 PM, Matthieu Baerts wrote:
>>>> On 11/11/2025 08:24, Paolo Abeni wrote:
>>>>> In case of DSS corruption, the MPTCP protocol tries to avoid the
>>>>> subflow reset if fallback is possible. Such corruptions happen in
>>>>> the receive path; to ensure fallback is possible the stack additionally
>>>>> need to check for OoO data, otherwise the fallback will break the data
>>>>> stream.
>>>>
>>>> Thank you for the fix!
>>>>> Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
>>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/598
>>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>>> ---
>>>>> Note: this does not avoid the WARN(), but fixes the inconsistend
>>>>> read() behavior; the ingress data is OoO, we should not ack it
>>>>> ---
>>>>>  net/mptcp/protocol.c | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>>> index d6b08e1de358..7b966f105f89 100644
>>>>> --- a/net/mptcp/protocol.c
>>>>> +++ b/net/mptcp/protocol.c
>>>>> @@ -646,7 +646,8 @@ static void mptcp_check_data_fin(struct sock *sk)
>>>>>  
>>>>>  static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
>>>>>  {
>>>>> -	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
>>>>> +	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue) ||
>>>>> +	    !mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
>>>>
>>>> Does it mean we should check the OoO queue each time mptcp_try_fallback
>>>> is called?
>>>>
>>>> Should we not eventually set msk->allow_infinite_fallback to false in
>>>> mptcp_data_queue_ofo()?
>>>
>>> Good question. According to the RFC here we should unconditionally reset
>>> the subflow. "historically" we try hard to fallback - even because in
>>> early releases fallback was a bit to easy to obtain.
>>>
>>> Setting msk->allow_infinite_fallback = false in mptcp_data_queue_ofo()
>>> could possibly hit performances. queue_ofo is basically fastpath with
>>> multiple streams and we will likely need to acquire the fallback lock to
>>> to the thing race free.
>>>
>>> I'm tempted to just do a plain reset here. WDYT?
>>
>> Can mptcp_dss_corruption() not be called before being in fully
>> established mode? In this case, should we not fallback instead? e.g. if
>> a middlebox start to alter MPTCP options after the 3WHS?
> 
> Even if we would be before reaching fully established status, the DSS
> corruption caused by the pktdrill test causes MPTCP-level OoO with data
> already acked at the TCP level. We can't drop it nor we can safely
> fallback, we have do reset (if ofo queue) is not empty.

Yes, OK to reset in this case.

>> Or maybe moving this RB_EMPTY_ROOT(&msk->out_of_order_queue) check to
>> mptcp_try_fallback()? (mmh, we don't have the msk)
>>
>> Or maybe just a plain reset is OK here?
>
> I think the main question is if constraining such resets to OoO cases
> (in the attempt to do fallback in other scenarios) or always reset here.
> 
> I propose to keep it simple, minimize the difference from current status
> and always check OoO.

Just to be sure I understand this correctly: your prefer keeping the
patch as it is, and there is no need to move the OoO check to the
__mptcp_try_fallback() help to check it in other cases?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

