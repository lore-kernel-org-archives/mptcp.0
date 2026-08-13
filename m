Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2252F39C2
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612808; cv=none; b=hRGRD97LpdC9lAjkhqEcnrYNxeIOxyyDKl1gtSe8/Ek6pclgcT+aJ6lJ+xihJRszR0eUxY5yGWY7NgKrdqg+Y51l6bDABY2vWpi1GXgfWcj3fSPbxcmEeuifu/chVL49Chvf29hoawcSfx/+pzCRayVNI0TlonNMLyejBUCFC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612808; c=relaxed/simple;
	bh=bif14L1QA11yZ/XtbHCmNW3Xbbyxu227v8NhnWVDDmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQDcOUg5b28AZf+0y46a0d4DcQ6tw3+9wFvxVtpd5vKZr6fRZ6lD02XAh0luawDRdV22gZaMvkXv3rYXL/xyV3phA9DszijM3xRIbGq4OuX7rEuFSqS9yn620vyjeQRFebcMf1KgybNptt4jNqAlfPsVjBOiPJvdf4dTcG/u4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ch+OqxLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch+OqxLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ADA1F00A3A;
	Thu, 13 Aug 2026 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786612806;
	bh=7HagUwVEKJ2eYFP6BjDmaFXsO4FKaQpTUpaZ+HZIxF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ch+OqxLppVLlEI2ic/6yYTpw9e1QlIseO/+dlim6dCD0hLhk54+7zUfuUcxNZ35aS
	 D5LVVtIRvEl2v9BKeUrHfyxzbfatcFRR0oqGgVh/A1q0AaPasw9UfAYNRsDCLI6tqC
	 DNPIvsfPOXw9GGNqguIsApnBcnS+1ecO2IcAYm/dZqmeQqIzmfNv/4NKMHmMdGTWxj
	 O5/KN9Wht7F2Z8I0WHfxCVFU3XfMHaNHT3pruHSDDRHZnodRV8cMjYeQueVqSWHcb6
	 HAjsBlMwP7GzT1ZcDiiBruOr1WO0y61SoV1vfGuzSgnTVzfBceQi4x2w1VYbpsBnaY
	 YM4a6Oe3p/N3g==
Message-ID: <be3d9d4d-2a4c-4ed6-a341-f184d85cc664@kernel.org>
Date: Thu, 13 Aug 2026 11:20:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: CI failures on nipa
Content-Language: fr
To: gang.yan@linux.dev, Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <02830f64-bb5f-41fc-8211-5f7aa36b828e@redhat.com>
 <9db96388a1c72d264d0576e0a58f4944560e93a7@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9db96388a1c72d264d0576e0a58f4944560e93a7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 13/08/2026 10:59, gang.yan@linux.dev wrote:
> August 13, 2026 at 3:57 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:

(...)

>> Judging on the final status, I *think*/*guess* the (re)connect is
>> hanged, possibly due to bad remote address?!? It could be useful to
>> print out on stderr the reconnect destination address.
> 
> Hi Paolo,
> 
> That reminds me of an issue when I was reading mptcp_connect.c a long
> time ago:
> 
> At the end of 'sock_connect_mptcp()', it calls 'freeaddrinfo(addr)',
> the 'peer' pointer (which points into 'addr') remains. Later, the main loop
> uses this peer pointer for reconnection attempts. If the memory has been freed
> and reused, the address data could be overwritten, resulting in an invalid
> remote address.
> 
> That might cause the hangs or failures you are seeing, right?

Good catch!

Are you working on a fix for that? I guess we should copy the content,
not just the pointer. Or maybe we don't need to do this copy:
getaddrinfo() should return the same thing, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

