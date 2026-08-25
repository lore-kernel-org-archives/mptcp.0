Received: from mta0.migadu.com (out-88.mta0.migadu.com [91.218.175.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06A2DB7BF
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639584; cv=none; b=CTGfTlsG5FzGLJawTqmBvEbWjJAtbCwi1gXSSg8NUEK89IjUV5JN1Mxm9Aw1AApRmHCMBWpnSJKRw3mcrfJKbW9+rYuLcZV38MP8kpUsymaSaGzmcOnwlIyvfEEnr9U5/Nwnd4vC7GwCDxB8MUeto/5M+2FTMlxZO6SaC5sbSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639584; c=relaxed/simple;
	bh=NepQZFMEkgbKW2Td+KNj9BmwtHLEWh/pfV1gTvPmN8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnPABiv9OAUSv2Hx9JK+25tV4MpBQXJILgJhdbBQSP5/Xtzk9muGHRL4rjnhd0M/0wnSIbfHhQVrcJYUUzYxGBUSX8K8IJ6pi14kjJ8HabucxfE7b08wBBhz5yW8hgAUFgNlBEqRwBdOXInCfqXGe0+zLJaAUKbeCPffLYf6IDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cVvpXfa6; arc=none smtp.client-ip=91.218.175.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cVvpXfa6"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=NepQZFMEkgbKW2Td+KNj9BmwtHLEWh/pfV1gTvPmN8o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787639580; v=1; x=1788244380;
 b=cVvpXfa63kIZrFK5hZOohhJgr1tCMh4IxvfJTveewogj5waXa+MOAj0Lcd+7HjvJ1WF4SUss
 /Q8geL9KJ8KUMBhsgDvhjTkE7HVY03DrXEUViXzD/0cGS289OE41hMwekCk0hQvE0tjkT1oxAke
 AvPmLPucUCKXmyr5byL5VW9Q=
X-Envelope-To: mptcp@lists.linux.dev
Received: from [192.168.109.30] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id a4f40c3faa83ce25;
	Tue, 25 Aug 2026 06:32:59 +0000
X-Mizu-Trace-ID: a4f40c3faa83ce25
X-Migadu-Flow: FLOW_OUT
Message-ID: <8223f1d4-5050-439e-8c00-707ac6b51c5f@linux.dev>
Date: Tue, 25 Aug 2026 14:33:20 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next RFC v4 2/2] mptcp: send MP_FAIL and infinite
 mapping on the same ACK
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
 <20260818091417.2200986-3-chenguang.zhao@linux.dev>
 <68791a9e-9310-4368-854e-d379ce0b416c@kernel.org>
 <691b982a-7825-490c-b516-ac23b601c64a@linux.dev>
 <2ab65503-c388-43f8-90f2-ef676205043b@kernel.org>
Content-Language: en-US
From: Chenguang Zhao <chenguang.zhao@linux.dev>
In-Reply-To: <2ab65503-c388-43f8-90f2-ef676205043b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/8/20 00:06, Matthieu Baerts 写道:
> Hi Chenguang,
>
> On 19/08/2026 13:16, Chenguang Zhao wrote:
>> 在 2026/8/19 00:19, Matthieu Baerts 写道:
>>> Hi Chenguang,
>>>
>>> On 18/08/2026 11:14, Chenguang Zhao wrote:
>>>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>>>
>>>> On a single subflow, accepting MP_FAIL must leave MPTCP mode at once
>>>> (RFC8684 §3.7). Emit the infinite mapping on the MP_FAIL reply ACK,
>>>> then call mptcp_try_fallback() immediately after.
>>> I think Sashiko is right about the issue of lacking option space to have
>>> both the MP_FAIL and the infinite mapping sent together.
>> Yes, Sashiko is right, I did not consider all the aspects.
>>> Please also note this from RFC 8684 §3.7.11 [1]:
>>>
>>>> This infinite mapping will be a DSS option (Section 3.3) on the first
>>>> new packet, containing a Data Sequence Mapping that acts retroactively
>>> The "on the first new packet" seems to suggest the infinite mapping
>>> shouldn't be attached to the MP_FAIL.
>>>
>>> [1] https://datatracker.ietf.org/doc/html/rfc8684#section-3.7-11
>>>
>>>
>>> Maybe a fallback for the single subflow without csum is enough? Or maybe
>>> nothing needs to be done? Or maybe this fallback is just an
>>> optimisation, and can be done in net-next (and both commits can be
>>> combined)? WDYT?
>> Hi Matthieu
>>
>> I am getting a bit confused, so let me summarize my current understanding to verify if I got this right.
>> In the existing kernel code, fallback will be triggered upon receiving MP_FAIL. However, the FALLBACK_DONE
>> flag is currently set inside mptcp_update_infinite_map(), which only gets invoked when transmitting a data packet.
>> This creates a timing window between receiving MP_FAIL and sending the first subsequent packet, resulting in this minor bug.
>> Our goal is to close this timing window: set the FALLBACK_DONE flag immediately after MP_FAIL is received.
>> Besides, add a __mptcp_check_fallback() check within mptcp_can_accept_new_subflow() to reject MP_JOIN requests ahead of time.
>>
>> Is my understanding correct? I will send out a v5 RFC based on the above ideas.      
> I'm not sure that it can work: if there is a fallback, no MPTCP options
> are supposed to be sent after that point. That's why the fallback should
> be done after having sent the infinite mapping.
>
> I didn't check in the details: *maybe* the fully_established bit could
> be reset earlier in some cases, but it feels like it can only be done
> when a fallback can be done, so never had extra subflows or reinjection,
> and no checksum. But then again, in this case, we are not supposed to
> receive an MP_FAIL. Then why bother and not simply fallback, and that's
> it, no?
>
> Cheers,
> Matt

Hi Matt,

Thanks for your feedback. I'd like to share some thoughts on the

practical impact of the extra_subflow window.While looking into this, 

I realized that the window where the leak can occur is actually quite

narrow in practice:

	1. MP_FAIL itself is rare — it requires a checksum validation failure,

	   which typically only happens when a middlebox corrupts in-flight

	   data.

	2. It only applies to single-subflow connections — for multi-subflow

	   connections, allow_infinite_fallback is cleared by

	   mptcp_subflow_joined() when the second subflow joins, so the

	   fallback path in mptcp_pm_mp_fail_received() is never reached.

	3. The window is very short — it spans from the MP_FAIL ACK to the

	   first data packet carrying the infinite mapping, which is on the

	   order of microseconds under normal conditions.
	
	4. Even deferring the fallback to the first data packet (as the
	   original code does) does not appear to cause issues in practice,
	   since the infinite mapping is still sent correctly and the
	   connection eventually transitions to TCP.

Given the above, I'm inclined to put this issue on hold for now and

revisit it if a concrete need arises. I'd appreciate your thoughts on

whether that makes sense.

Best regards,

Chenguang

