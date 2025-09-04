Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152C2FE56E
	for <mptcp@lists.linux.dev>; Thu,  4 Sep 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985240; cv=none; b=aYAz99ojwF4tRrG9g4HrOG+RqC9xa08eSd79C25KPeE+qOsek2yw7Od5geKYc8nsg8BW3cn/UdHC68eXxSFvnIBbjnfGWWhYWxm6qN9vurY8FSEj1GDl4FpPf8QCx1FkrJcJJCyv73DRnchSecahU3xun1wQqLvqMdeQclSKWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985240; c=relaxed/simple;
	bh=W1zvHEXApC6Y60Ia4KIAyL5opkfAaGM2SJiz60oRPfQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=bkqjLINsRjGAx+RP2stNm4be8SfHVrQfY5/LfR14jwCTCzQHIxdpnw6ebQeJ9EaqgtyBhCBlfo9zp1dQPUplMi2DivJAfcPjM1bYvM1BS9AfyFRnMHo9idNacvckDEbXC8fZ/eE91tWR8tFI0MzEBiKh2To0vTHYhlrvdaB818M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE6i6XiZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE6i6XiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED14C4CEF0;
	Thu,  4 Sep 2025 11:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756985240;
	bh=W1zvHEXApC6Y60Ia4KIAyL5opkfAaGM2SJiz60oRPfQ=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=aE6i6XiZtSPLasX0KYeHUlzjcLHftYOu4LWh+p2ro3jKjUI9amF8qQ6eBFDIDzfdk
	 YLD3RtIsvTeH7Mgmi7W9MTZzDgzdejWdItU9DllAGJP+A/6876UJi7WafjbgHMRi9C
	 k4eKnayzWZQRtTxXXzEMdms+Ze6w/jNrj5Z4Fq/6wjxrTb0M1A4PMsKoG8zjJzUDcx
	 NR26rNFr9m4bsteZYivJJrcdbhjowf5bYyWtOJT18bdpEnr63VDHamxSncjBCvJTz7
	 zs1h16DY6iHKwbnt7JD+S6K+kcJRGAQhoIFiY7XsF95WAyD3N84A25Z0ZBY+RjZyuI
	 x/aocZCrj07KA==
Message-ID: <e9879f8d-399c-433f-bba1-3332a35bee37@kernel.org>
Date: Thu, 4 Sep 2025 13:27:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/3] selftests: mptcp: join: tolerate more
 ADD_ADDR
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
 <20250902-sft-mptcp-join-add_addr-no-retrans-v1-2-956a315d6a5a@kernel.org>
 <c598db197820b4452342d913f9cfc1554ab128ab.camel@kernel.org>
 <b1d91845-934a-4064-a048-a95ea1472504@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b1d91845-934a-4064-a048-a95ea1472504@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/09/2025 12:47, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 04/09/2025 11:26, Geliang Tang wrote:
>> Hi Matt,
>>
>> On Tue, 2025-09-02 at 21:01 +0200, Matthieu Baerts (NGI0) wrote:
>>> ADD_ADDR can be retransmitted, and with, the parent commit, these
>>> retransmissions can be sent quicker: from 2 minutes to less than one
>>> second.
>>>
>>> To avoid false positives where retransmitted ADD_ADDR causes higher
>>> counters than expected, it is required to be more tolerant. Errors
>>> are
>>> now only reported when fewer ADD_ADDRs have been sent/received.
>>>
>>> An alternative could be to disable the ADD_ADDR retransmissions by
>>> default, but that's changing the default kernel behaviour. Plus,
>>> ADD_ADDR retransmissions can be required for some tests. To avoid
>>> adding
>>> exceptions to a few tests, it seems better to increase the tolerance.
>>
>> I think adding "tolerate more ADD_ADDR" to the two general helpers
>> chk_add_nr() and chk_add_tx_nr() is not very accurate, because we don't
>> know which test sends/receives more ADD_ADDR. Because chk_add_nr() and
>> chk_add_tx_nr() of most tests are normal, only a few tests will be
>> affected and need to add "tolerate".
>>
>> I think it can be handled like chk_csum_nr(), accepting a number with
>> "+", such as "+2" to allow more than two ADD_ADDR. In this way, we only
>> need to add this "+" to a few failed tests, so the control is more
>> accurate. What do you think?
> 
> I initially did something similar: marking the tests where we can be
> more tolerant, but the modifications were quite important. But that was
> not it: before, there were no retransmissions (only after 2 minutes, so
> after the end of each subtest), and we had the tolerance only when
> setting the timeout to 1 second. Now, we always have retransmissions
> (and we don't control the timeout any more), so to be aligned with what
> we had before, we should probably always have this tolerance. We might
> have unexpected retransmissions because suddenly, the host got busy, and
> the ADD_ADDR retransmission timer fires. We don't want to be impacted by
> these unexpected events. I think that's valid for all tests were we
> check the ADD_ADDR.
> 
> Maybe what is missing is an exception for the expected counter 0: if we
> expect no ADD_ADDR, we should fail if some are seen. But this issue was
> already there, we would need another patch for that, probably. (I can look).

To be more correct here: the issue was already there before, but we
couldn't hit it because "net.mptcp.add_addr_timeout" was only set to 1
(check with tolerance) when we expected to see ADD_ADDR. In other words,
no need to have an exception for 0 before this patch. I will then modify
this one.
> Also, what would be certainly better here, is to add a new MIB counters
> for the retransmissions, so we can check the actual number instead of
> having the tolerance. Again, that's orthogonal to this fix I think, so
> this can be done later on.

(Note that this might be nice, but I'm currently not planning to add this)

> 
> So in short:
> - this patch simply align with what was already there
> - we should add an exception: no tolerance when expecting no ADD_ADDR
> - we might add a new MIB counter (sent retransmitted ADD_ADDR) to avoid
> the tolerance (on newer kernels only: when this counter is available)
> 
> WDYT?
> 
> Cheers,
> Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

