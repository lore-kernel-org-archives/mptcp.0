Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675EE2EB10
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 04:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778818509; cv=none; b=D7NOL8vh9y0b7dXMRrKsgXmRDiwT9fMz7/9Phhabk7reHEGipGNv48DMC6LME/goOFmwkF2NWoEynpzTPNv1HT4XyxUQvrENtnBRMnRja7Q8ObI4e0GhpoR13RIFGORZWdhAhtoVPG3Q31bEP2EjP+E27ousONPybMrKLt7a1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778818509; c=relaxed/simple;
	bh=HGAh7OBbeMEYjE56YF1SEMrmhEhHJZ7Te7cSRNUI0EU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=YL+7MaIFioC9O4quSiRV4GALr0hXxCri5iqnL1wZnkfKJTEf5O1gTH1EfOVCBD2Lro4TNeXJFje8P4MmkQPNvXGciy887rm1fOQfHlz2q1wWKI6FEWt+Ox5OnLv3/bEowFxOGaujCUNYvDIhyWoV2pUgmVzMbM0X1jL27+jLdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S86Vqftt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S86Vqftt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588D2C2BCB0
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 04:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778818508;
	bh=HGAh7OBbeMEYjE56YF1SEMrmhEhHJZ7Te7cSRNUI0EU=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=S86VqfttYdSIJzamW7ParRcryTgnDN4dGFsBl6N9TZZ2/xxeDw8S+URz0kW6kXz1v
	 bQgXmT8GBIiSAztZo4LISkh96lAyLrcC0aKDzo+PT/+CtG4W5ZSVfFSKZpml2zXVww
	 ekJXR+Ho84Eo9SPfiX0Ui3zfnkp+rNPX15iqqMh3HplLjLsse5FxXG41zQqHzaR8a8
	 Y/7pg9jW+ITYiPoxJe8baJ1cAxifzlCShfrKYXeLu51QuXfTytvsHksxg/vw95G9M0
	 Bw5Rcrs0da8lYm51jjd4oeRFhEEyZlwvzzWmMNjOUgiA5rjJWmo+lTI9T2lm2cNXjd
	 31jetwYl68yoQ==
Message-ID: <596161e3-031e-47e1-a6ad-a9bf96abb119@kernel.org>
Date: Fri, 15 May 2026 06:15:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] selftests: mptcp: drop nanoseconds width
 specifier
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260515-mptcp-sft-uutils-0-8-0-v1-1-4801c8e16485@kernel.org>
 <822ad467-2d97-4c2f-8e5b-78be0bd0acf2@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <822ad467-2d97-4c2f-8e5b-78be0bd0acf2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2026 05:59, Matthieu Baerts wrote:
> Hello,
> 
> On 15/05/2026 04:11, Matthieu Baerts (NGI0) wrote:
>> Using the format specifier +%s%3N with GNU date is honoured, and only
>> prints 3 digits of the nanoseconds portion of the seconds since epoch,
>> which corresponds to the milliseconds.
>>
>> The uutils implementation of date currently does not honour this, and
>> always prints all 9 digits. This is a known issue [1], but can be worked
>> around by adapting this test to use nanoseconds instead of microseconds,
>> and then divide it by 1e6.
>>
>> This fix is similar to what has been done on systemd side [2].
> 
> I suggest applying this patch, and sending to netdev-net, not to block
> those using uutils, e.g. on Ubuntu 26.04.
> 
> I will apply a small change, see below.

Now in our tree:

New patches for t/upstream-net and t/upstream:
- ddfbd0a8f455: selftests: mptcp: drop nanoseconds width specifier
- Results: abcff95a440d..c6403a142d47 (export-net)
- Results: 564a2979a856..17d8ed7a3a1c (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/91d16c37e15ffff4ea145b5b7c897f2f4e5cfd3d/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/bae8b1e40c2d814e5d571dfa0885a59722911bb6/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

