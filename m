Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54288221FB4
	for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323492; cv=none; b=X7anjiGJXk0gPdhMgwO0JJEL+wEUB7g4q5r5cmKW9aZTAkqTcGSj+VsbiVIoA8H3ODTeIoVWZ2faWRo+W+WhZWi5kSHS9hmwuhL/+ZwrTp+TInSs7zn6woB54EuhsdkJZfloEjSZBD/kZnQ91LybuzrI+bj7Jp+WVZr9rdDnhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323492; c=relaxed/simple;
	bh=uKBh60/GqNkJteSjJShNXKTpemOyTAekTu0swAmL3JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YR/E+8lcz8hJoNZVebpyJ9BDjd7Ps6UO692XvCUz1vwzgLpbS93IwfEEQp+zBPy0Q2ODrmBzi0gknEWzARRiKY9wG24T9BM6kq2ue0Df9QGMEcukMHjU8GEGocrmLR5Mc/pW0fg1coeMvXesvCRnACLzrdbOWVNquSs3GB+ZJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXJsSA8V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXJsSA8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1845AC4CEF1;
	Fri, 28 Nov 2025 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764323491;
	bh=uKBh60/GqNkJteSjJShNXKTpemOyTAekTu0swAmL3JM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dXJsSA8VnhRb5oENApyPSMeKls2Us2VXH/h2Df+esZXJYKn2EuFpdOHUmLqpWbR/0
	 F1uMbJ+BPqJ14Fp6llDMoz8VwkW7HVZZlbDu6weviio0cNi9OpzDDXD1yb5huJrBp+
	 dt6Ai0Zm/VaOnsGP3Zp5SBWMt7Jb5HzM0IWUR9c5ZWj/hd18LG5ifZQX40Ma9jhDaK
	 2ZWGtEX2Td9zMg9qYJm8OsF/v1wj0x53pa4QvMTo5GR6d+qHyEHBAUC0m4l1GSLjUb
	 znQMwkPyDDIfigrNpJ39aZS1TjjMS55MG3Sbnv8WX6g45l00vGFuznkfC0OJFeMofE
	 Qdi2X5iZW74vA==
Message-ID: <cdd003da-c4e4-4b37-b27d-254633e2b2ec@kernel.org>
Date: Fri, 28 Nov 2025 10:51:28 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 mptcp-next 5/6] mptcp: better mptcp-level RTT estimator
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, martineau@kernel.org
Cc: mptcp@lists.linux.dev
References: <cover.1763625391.git.pabeni@redhat.com>
 <6ffc28b03d35f1b5698ff9ed6b22bd3e82fc81be.1763625391.git.pabeni@redhat.com>
 <08ca5b33-8592-4060-9211-ecbef30cda0e@kernel.org>
 <7e85ed1a-3072-4230-a14f-b7eecdf2d4d2@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7e85ed1a-3072-4230-a14f-b7eecdf2d4d2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 28/11/2025 09:47, Paolo Abeni wrote:
> On 11/27/25 7:13 PM, Matthieu Baerts wrote:
>> On 20/11/2025 09:39, Paolo Abeni wrote:
>>> The current MPTCP-level RTT estimator has several issues. On high speed
>>> links, the MPTCP-level receive buffer auto-tuning happens with a frequency
>>> well above the TCP-level's one. That in turn can cause excessive/unneeded
>>> receive buffer increase.
>>>
>>> On such links, the initial rtt_us value is considerably higher
>>> than the actual delay, and the current mptcp_rcv_space_adjust() updates
>>> msk->rcvq_space.rtt_us with a period equal to the such field previous
>>> value. If the initial rtt_us is 40ms, its first update will happen after
>>> 40ms, even if the subflows see actual RTT orders of magnitude lower.
>>>
>>> Additionally:
>>> - setting the msk rtt to the maximum among all the subflows RTTs makes DRS
>>> constantly overshooting the rcvbuf size when a subflow has considerable
>>> higher latency than the other(s).
>>>
>>> - during unidirectional bulk transfers with multiple active subflows, the
>>> TCP-level RTT estimator occasionally sees considerably higher value than
>>> the real link delay, i.e. when the packet scheduler reacts to an incoming
>>> ack on given subflow pushing data on a different subflow.
>>>
>>> - currently inactive but still open subflows (i.e. switched to backup mode)
>>> are always considered when computing the msk-level rtt.
>>>
>>> Address the all the issues above with a more accurate RTT estimation
>>> strategy: the MPTCP-level RTT is set to the minimum of all the subflows
>>> actually feeding data into the MPTCP receive buffer, using a small sliding
>>> window.
>>
>> (...)
>>
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index ee0dbd6dbacf..b392d7855928 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -269,6 +269,13 @@ struct mptcp_data_frag {
>>>  	struct page *page;
>>>  };
>>>  
>>> +/* Arbitrary compromise between as low as possible to react timely to subflow
>>> + * close event and as big as possible to avoid being fouled by biased large
>>> + * samples due to peer sending data on a different subflow WRT to the incoming
>>> + * ack.
>>> + */
>>> +#define MPTCP_RTT_SAMPLES	5
>>> +
>>>  /* MPTCP connection sock */
>>>  struct mptcp_sock {
>>>  	/* inet_connection_sock must be the first member */
>>> @@ -340,11 +347,17 @@ struct mptcp_sock {
>>>  				 */
>>>  	struct mptcp_pm_data	pm;
>>>  	struct mptcp_sched_ops	*sched;
>>> +
>>> +	/* Most recent rtt_us observed by in use incoming subflows. */
>>> +	struct {
>>> +		u32	samples[MPTCP_RTT_SAMPLES];
>>> +		u32	next_sample;
>>> +	} rcv_rtt_est;
>>
>> I'm sorry to react only now, I didn't manage to follow this in details,
>> but I have one question: why not using a smooth RTT [1]? Is it because
>> the goal is to mix data from the active/recently used subflows and only
>> to take the minimum, and not "combining" RTT from different subflows?
>>
>> [1] https://datatracker.ietf.org/doc/rfc6298/
>>     srtt = old * (1-alpha) + new * alpha   # alpha is 1/8 in RFC6298
> 
> TCP already use EWMA for rtt; the values seen by MPTCP on each subflow
> went already into such processing.
> 
> If there is a single subflow, doing again EWMA should only cause slower
> reactions.
> 
> If there are multiple subflows, we really want the min() not the
> smoothed average, because:
> 
> - there are high spikes caused by the mptcp packet scheduler: we want to
> entirely filter them out, while EWMA will make them contributing the the
> estimate and results are very visible (negatively) in my experiments.
> 
> - different subflows can have very different rtt (say 1ms vs 100ms). We
> really want the minimum, otherwise DRS will be fouled/the rcvbuf will
> "explode"

Thank you for having taken the time to explain me all this. That's much
clearer, and I just realised I was mixing up acronyms! :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

