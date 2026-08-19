Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C4480DCD
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155617; cv=none; b=PcwqjO9bmn+acqBVXTqmxEPBFw8x5kPimHPdI+EhJn0QJ2W5ghFXyH7pvad1SMgRsCcMRL4zx9aZeLwooqyn7lb6I0MNq55NTD29loaBaLDCaF/TAtOpGAqx/QvhMYG3mzIIGcbdwLB94InhY2nik01O2SEWl1cDkoWDjFVPraI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155617; c=relaxed/simple;
	bh=PKxzqKmnGi+MXtj0o7ndnz+h/V+Tcld+JysvEIeiCek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZ3waVQnDilI1TnkJ1jDJDP8WUB/8pHScC7zuQms9p1rk2Eey3MIhpXRW9ji1O8nBv3PNFPd1LC92rvF27P/Er/Had+V41DARe3dFuyGAyYhqzPUBYJySrOgKo5I4ZbvkPnI+6BDr7agQOT9vZj2IuBkp+obUm6e3W0VwNJYMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfzlACgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfzlACgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772DD1F000E9;
	Wed, 19 Aug 2026 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787155615;
	bh=FQKuV/0fj7wsBu2AIFN0JhIYGOC+geZxZA6/edM2GMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SfzlACgMFlfDhKB9DNpkMfNspxXVJ4Kcuvt6NVDHOSGQsw4NzN3WMLVdwCXP8eefl
	 pJ6WzxrsDUfLkecdC7zCXcSBw2ad9jgLPttiGr7qEhWaBgX+a8mNlpCJ7d+HnYRg6f
	 5WNj+bzwC72Bh8iggsZYZDH8+NevDvoSSkf356kIuYd3ogkB6+4Qq70y6A8/m10l2J
	 2HBfOrxvK/1wAmBFqMnyd0dD6J4W4Hul1dbyrvsERHZv8vgBsJ61uOdcR9MtyGrLuP
	 vv3F4tarvS/OpsW7GU314TShRTR3NpxGo6BCHOJDz5Rv4TdkTU0zTKvjGmopvRegJL
	 upX0atjMHvsKg==
Message-ID: <2ab65503-c388-43f8-90f2-ef676205043b@kernel.org>
Date: Wed, 19 Aug 2026 18:06:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next RFC v4 2/2] mptcp: send MP_FAIL and infinite
 mapping on the same ACK
Content-Language: fr
To: Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
 <20260818091417.2200986-3-chenguang.zhao@linux.dev>
 <68791a9e-9310-4368-854e-d379ce0b416c@kernel.org>
 <691b982a-7825-490c-b516-ac23b601c64a@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <691b982a-7825-490c-b516-ac23b601c64a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chenguang,

On 19/08/2026 13:16, Chenguang Zhao wrote:
> 
> 在 2026/8/19 00:19, Matthieu Baerts 写道:
>> Hi Chenguang,
>>
>> On 18/08/2026 11:14, Chenguang Zhao wrote:
>>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>>
>>> On a single subflow, accepting MP_FAIL must leave MPTCP mode at once
>>> (RFC8684 §3.7). Emit the infinite mapping on the MP_FAIL reply ACK,
>>> then call mptcp_try_fallback() immediately after.
>> I think Sashiko is right about the issue of lacking option space to have
>> both the MP_FAIL and the infinite mapping sent together.
> Yes, Sashiko is right, I did not consider all the aspects.
>> Please also note this from RFC 8684 §3.7.11 [1]:
>>
>>> This infinite mapping will be a DSS option (Section 3.3) on the first
>>> new packet, containing a Data Sequence Mapping that acts retroactively
>> The "on the first new packet" seems to suggest the infinite mapping
>> shouldn't be attached to the MP_FAIL.
>>
>> [1] https://datatracker.ietf.org/doc/html/rfc8684#section-3.7-11
>>
>>
>> Maybe a fallback for the single subflow without csum is enough? Or maybe
>> nothing needs to be done? Or maybe this fallback is just an
>> optimisation, and can be done in net-next (and both commits can be
>> combined)? WDYT?
> 
> Hi Matthieu
> 
> I am getting a bit confused, so let me summarize my current understanding to verify if I got this right.
> In the existing kernel code, fallback will be triggered upon receiving MP_FAIL. However, the FALLBACK_DONE
> flag is currently set inside mptcp_update_infinite_map(), which only gets invoked when transmitting a data packet.
> This creates a timing window between receiving MP_FAIL and sending the first subsequent packet, resulting in this minor bug.
> Our goal is to close this timing window: set the FALLBACK_DONE flag immediately after MP_FAIL is received.
> Besides, add a __mptcp_check_fallback() check within mptcp_can_accept_new_subflow() to reject MP_JOIN requests ahead of time.
> 
> Is my understanding correct? I will send out a v5 RFC based on the above ideas.      

I'm not sure that it can work: if there is a fallback, no MPTCP options
are supposed to be sent after that point. That's why the fallback should
be done after having sent the infinite mapping.

I didn't check in the details: *maybe* the fully_established bit could
be reset earlier in some cases, but it feels like it can only be done
when a fallback can be done, so never had extra subflows or reinjection,
and no checksum. But then again, in this case, we are not supposed to
receive an MP_FAIL. Then why bother and not simply fallback, and that's
it, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

