Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E63CF1F2
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784881529; cv=none; b=JwLufdHtpWo+VP6OArcksVbImGI1TGIGokrLmZ5iQxpjEH0GFjfLybdlruN0ughZnHytnVPS/u3oBukq+daYmF/dYkjWAmAltcfhinVCRHqxiZdePZg/GpCgn5Ift3I26dbigi9TCorINVSPU/SUsrxCtY34UIfupGCla6kbzzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784881529; c=relaxed/simple;
	bh=cvaKfz1tiMP+bydu3JotQGF+12Mp5mgHJOnj1wU1+mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FM99qjEvQ2ycjB3hXgWg/MHD+IkL/WvQ3w/xmWoMLS8Shijrfbdht0cb1K6mfsLWtS0k9AbvURdTdwAJ+FcrqEZkDaXP8SCIYJPRTge09UB4QLGUKl/hIqNzcbFKOuaNm1yL+b7UpD0vU8GB8MKTX6skXADzmS9flHaHV7CYvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8mDFtPb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8mDFtPb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48CB1F000E9;
	Fri, 24 Jul 2026 08:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784881527;
	bh=MCJENH9rSHxHEKXCDdpDdt/OT3irv+fmaBAEqNFWg9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J8mDFtPb4y5dUJ3FA7CxpbQ7RV7CsCI6kLncJtO5iqbgafg5jfIBO82Xz1yN8qPm4
	 1OKwA3BRwX+aZcwZs369DEe1+0ToEHunAo1/e0AJfrP9e7wRHpaGqorr00ghbD50wO
	 XjFpMF3l9Mi24tuAqV2gcQuwV7Fq/FRCIMvyqtANgQaXZrsEIrYeZMesI6YH5DWpLu
	 K6yDTDg1aVs4AGXre2EEus/GQpXacarXhwX9uKU3E/4lvn6B2JWmPl7A6iC1tUuk4C
	 hMs58tSWPwdOhsWxzTORwTRyPHLO/s/NS6WJXlVUIevEHnD0meC260ljKKA+E52nLz
	 9kLmciQTmaaOA==
Message-ID: <9ff166c8-d045-4922-ad9a-c658a71e842d@kernel.org>
Date: Fri, 24 Jul 2026 10:25:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: fix BUILD_BUG_ON on legacy ARM config
Content-Language: fr
To: Arnd Bergmann <arnd@arndb.de>, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Frank Ranner <frank.ranner@intel.com>, kernel test robot <lkp@intel.com>
References: <20260707-mptcp-opt-fix-config_aeabi-v1-1-f428d0aa0318@kernel.org>
 <ceb3b719-0a4c-4998-9a14-1eac1d574bb2@app.fastmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ceb3b719-0a4c-4998-9a14-1eac1d574bb2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Arnd,

Thank you for your review!

On 24/07/2026 09:57, Arnd Bergmann wrote:
> On Tue, Jul 7, 2026, at 18:48, Matthieu Baerts (NGI0) wrote:
>> The 0-day bot managed to find kernel configs that cause build failures,
>> e.g. when using the StrongARM SA1100 target (ARMv4).
>>
>> On such legacy ARM architecture, all structures are apparently aligned
>> to 32 bits, causing build issue here. Indeed, on such architecture,
>> 'flags' size is not equivalent to sizeof(u16) as expected, but to
>> sizeof(u32).
> 
> I just saw the patch get merged upstream and wanted to clarify that
> this is ARM OABI (CONFIG_AEABI=n), which is technically unrelated
> to the CPU type. It has a lot of problems and should hopefully
> go away soon.

Fingers crossed!

> While I'm testing randconfig builds on Arm all the time, I specifically
> don't test OABI kernels.
> 
> I had to check that this isn't actually ABI or wire protocol though,
> otherwise dropping the BUILD_BUG_ON() would be hiding bigger problems.

Thank you for having checked!

>> Instead, use memset(). It was not used before to ensure a simple clear
>> operation was used by the compiler. But at the end, it shouldn't matter,
>> and the compiler should optimise this to the same operation with or
>> without memset() when -O above 0 is used. So let's switch to memset() to
>> fix this issue, and reduce this complexity.
> 
> The optimization will not be used on architectures that build
> with -ffreestanding (apparently m68k, mips, sh, i386). We probably
> don't care about performance on those or we would have changed
> that already.
Good point, I didn't know about that. Indeed, I don't think we need to
care about them in this case here.
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

