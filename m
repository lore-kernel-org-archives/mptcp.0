Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433FD3A0EB3
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786642971; cv=none; b=iLyojJ9ei7GcTk0uy5EgDp9ZDrl8rymYAFn9rd01y4WOBFo/PSz0Z0ptt58V5u0Z5WTrgVTwesqjT0PHIun1Sn1T0SMXBw4nqKfTjuB5G4kD5TKJY9/rPB88BQK/IHDpBP/GPaj/U2aLfl/gySJBbfSD1BBmhoFFtiQChNYp1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786642971; c=relaxed/simple;
	bh=CHcilhNjuaMcjdKomSjRcEIvJJ3qwhcxwr5TsbHPpEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcvgIImCfr3uX6Cv9X7TwDOVSZQpaub8aH42Gp6a8yPG8P1zC8J+0DV/va2bZE71YE53grNYqm1ShKD4jyUd6m8WxvPHyuGpojQTRNKbQiXvP8z1ai/SaU4h8z2Y42VnLbtPYY4AZ2R514hcbcUYkZ9Uzi6vUQZk8XcEFCme0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JioHiYsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JioHiYsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227821F000E9;
	Thu, 13 Aug 2026 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786642970;
	bh=A/oTGEjWDQTkgvIkvJJj2W5bv5b/WCvIA/hHPCkgv10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JioHiYscDfqzJGH3olSWB0cn4UL/VXDdd9ldN1Xq7XPcZ5yRsaThPViD0/eKhJDMo
	 978EqqkijsB/Mt8PuHEBEZFwRCiB6mbMO0VUshfUEb1WozW5c3uOjQ7O3JjebaU+Kj
	 tUSY1IimM8HhYuFHEg/UosX9r5G5tC/mxez/0iQDsCfR/4x/J5/jr5o3KOref3wye9
	 0pnUUQdfv9NG1+W1gKX7YINxghR8E/U3c17g4WwWyxPlyhJ8DWUst8N6YnF+/SkcnL
	 GFtSLlfWCtmOTuFe5b7Lv487nfzG7q78WTV68STPcSXkezZlbWSbddpuvgpNZgnClr
	 Z6iiK4IN1m0GQ==
Message-ID: <db6bd87f-f7cd-4b02-a471-db549cbca384@kernel.org>
Date: Thu, 13 Aug 2026 19:42:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH export v3 2/4] mptcp: reject joins after fallback in
 mptcp_is_fully_established
Content-Language: fr
To: gang.yan@linux.dev, Paolo Abeni <pabeni@redhat.com>,
 Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-3-chenguang.zhao@linux.dev>
 <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com>
 <41078a8c-00c7-4cb1-8e57-237b4ea6c2f0@kernel.org>
 <564cb027be5e7972fc8f6f976707628ee32f38aa@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <564cb027be5e7972fc8f6f976707628ee32f38aa@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang,

On 13/08/2026 11:32, gang.yan@linux.dev wrote:
> August 12, 2026 at 11:32 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrote:
> 
> 
>>
>> Note: Chenguang is looking at a bug where, when an MP_FAIL is received
>> before being in fully_established, the kernel accept going to fully
>> established, and creating new subflows, then reject them once done.
>>
>> Same when receiving a 4th packet without MPTCP options.
>>
>> I think the MP_FAIL should do a fallback if possible, but it is probably
>> also required to check the fallback status or something similar when
>> receiving an MPJ.
> 
> Hi, Matt
> 
> Sorry, I'm not very familiar with the details of this patch.
> 
> No offense intended, I just have a question I'd like to ask based on my
> understanding and the RFC documentation: Should MP_FAIL trigger a fallback?
> 
> For the multiple‑subflow case, if one subflow encounters an MP_FAIL, it should
> be closed with a RST, and the data will be retransmitted over the other healthy
> subflows. This should not cause the entire MPTCP connection to fallback to regular
> TCP, right?
> RFC8684's contents:
> '''
> The receiver of this option MUST discard all data following the data sequence number
> specified. Failed data MUST NOT be DATA_ACKed and so will be retransmitted on other subflows.
> '''

Correct, in this case it shouldn't fallback.

> For the single‑subflow case, according to the RFC, MP_FAIL should subsequently
> lead to a fallback under the infinite mapping (INFINITEMAP) situation, shouldn't it?
> RFC 8684's contents:
> '''
> A special case is when there is a single subflow and it fails with a checksum error.
> If it is known that all unacknowledged data in flight is contiguous (which will usually
> be the case with a single subflow), an infinite mapping can be applied to the subflow
> without the need to close it first, essentially turning off all further MPTCP signaling.
> '''

Correct.

Please note that when I said "the MP_FAIL should [cause] a fallback if
possible", I'm referring to what is done in mptcp_try_fallback() → a
fallback is only possible in the single subflow situation, without
reordering at the MPTCP level.

In addition, in the case we are trying to fix here, the MP_FAIL is
received before switching to fully established: the RFC doesn't explain
this particular case, but it sounds like there is no need to send the
infinite mapping, and a fallback can be done directly *I think*. The
thing is this situation shouldn't happen: we are not supposed to receive
an MP_FAIL at that stage, no data has been exchanged at the MPTCP level,
so let's do the minimal -- i.e. just a fallback -- to avoid issues and
reduce the complexity, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

