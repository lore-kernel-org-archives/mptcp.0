Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663957;
	b=W4OJHUHlmtTBun069ms+m5M8ALKS1G/SKO0KQh2EI2SFNWR29BfZJx51O6CvTkR4ghHc
	 9d2bgKsTlyIJObXjSIqwpZip77FWO4TU3+71sqQX3o9FCEMszcF2XcP6xqbgiD6B6J7o+
	 zhfreIYcsYd5x3HujkSqHOY0SAohrazMz+luf5HVCNMYfsYnbhSVafu9w3sdFBWfWHibv
	 A8mQ07cK0fZIEUXyjDQWqoSdTgssQcpTWhtrP4uUI2VctQtoxEyPRJmgHsZD7KDpvdVrM
	 HGhHMGWf641JdFDy/f4do5ibMD4RFQHDGN0y9vNxDpUz3jlGToYgm6H+Q1jRN1IvnaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663957;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=h3Tv8eGqKzhP1CEPap2Iu9fF2t0Jb4HznSVB2lmmadY=;
	b=gDS7WVi2v12DQRiCBq8I0rw1eQQkOWdrHrbyMCYX8ygnbvUPY2jj2NR9b+V5Zrizf4jX
	 FCdbxashRdv7hQfaPIJbcngCfZpTi+39JtJqlfexsAiZDciCmT1wZPGprmhXycaqizT0M
	 wlHJ7uQ+UKnOgwa97vGoR5jBobXp7KLF6arX9rMISBWX8HW0Np7qZBxN0+N1PYIOpcN37
	 VTFvArzBSTBHxEl3KmAItdFParzZ4l9deiwBhxUKni+XRBrJPmDopr+Af0PaJ+qNPSzac
	 0n2ycVx7QBeE262iFY8CtXKPt/nFdagAkUZPKzmHqN3OQZZvXL8LftTXSdM6yn88Dog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEpPhBPt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F4606A319;
	Thu, 22 Oct 2026 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEpPhBPt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF371F000C1;
	Thu, 22 Oct 2026 10:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663957;
	bh=h3Tv8eGqKzhP1CEPap2Iu9fF2t0Jb4HznSVB2lmmadY=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=lEpPhBPtLouFLN+TDsA/nbx3dlNVfjiClnDK2LlEScS20NGUR165PRwb9tyDWhbSk
	 Q0DFV8h1wqb0oRaNjyyxlaRIhiR7S0IjOH4Ac3Z/H3glpISFHPha+NF/hBGavtShoq
	 +ZSViyEK9uGxZ9AupLnjqSaORBWHLOAWw/UbWzHVmwjsEX9XM32J0QOSfmeSuL0qsj
	 776695iE5zfVCN7CBSW3BFjECOHcDs0qriG5TZdvc3P14/ultWgOcYi/kL1N233nwD
	 xmgWRa1MjIx/zHLWYIHAeXajfAaZ1b3VCEs5d97Q/oi8k9vEh3LotubDFfR4AwWzr1
	 5sZiBU7F3Z6vQ==
Message-ID: <5ecb8462-3071-4f90-a0b7-614417337cf1@kernel.org>
Date: Thu, 22 Oct 2026 12:12:34 +0200
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: pm: kernel: c-flag: mark as used only
 when it is
Content-Language: fr
To: sashiko-reviews@lists.linux.dev, MPTCP Linux <mptcp@lists.linux.dev>
References: <20261022-mptcp-pm-cflag-clear-when-used-v1-1-516c09b4ee65@kernel.org>
 <sashiko-outbox-181256@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <sashiko-outbox-181256@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2026 11:24, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] mptcp: infinite loop in fill_local_addresses_vec_c_flag() on skipped endpoint
> --
> 
> commit 13a1b915ae070fcc7bed06cf022912abbebad663
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> mptcp: pm: kernel: c-flag: mark as used only when it is
> 
> This commit moves the clearing of local->addr.id in msk->pm.id_avail_bitmap
> in fill_local_addresses_vec_c_flag() until after checking that the address
> families match and the local endpoint is not msk->mpc_endpoint_id.
> 
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index d3014bf57bf3c..3e473a81389d3 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -582,14 +582,14 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
>>  		if (!select_local_address(pernet, msk, local))
>>  			break;
>>  
>> -		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
>> -
>>  		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
>>  			continue;
>>  
>>  		if (local->addr.id == msk->mpc_endpoint_id)
>>  			continue;
>>  
>> +		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> 
> [Severity: Critical]
> Could moving __clear_bit() after the continue statements cause an infinite
> loop in fill_local_addresses_vec_c_flag()?

Mmh, yes, now I remember why __clear_bit was there...

Because this's "urgent", I will send a v2 soon with what the original
author did + a few fixes.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

