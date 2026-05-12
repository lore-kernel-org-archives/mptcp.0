Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68338735D
	for <mptcp@lists.linux.dev>; Tue, 12 May 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575598; cv=none; b=AuqRRwsuOxhB9XQUKbw5zT8zc5tjQOkdk7sPL+ly6VYGPNIAimnxKPARaVsOMrUnSIC+2D4bbbJ18Xk7eOWlMTfhXsV3/dCLbXtfZPZPbEd6QNuNdD2P4vaRouX5WCNnnGYZatL0NCpmNEMnvi7pTHl8543FyutEYfzMjnlYUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575598; c=relaxed/simple;
	bh=8kPfidwgc70FfY4o4fHamjH6lwkriRj+3wTzIJTIwFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUSW1tJ3PdzVqCSTAqH/yJODDY0m9R1xlouw9Jjd1yZaT7qazthD1PsWORBgRDuOymg3ZKfJ9FmekF222J2ProCT8k15VWBtKXh0STeKDjk/OZkz/weWJe0YnjQjxl297z03x33Xu/LgPF1nnqLQ93pq3M/gQt+bk1HuimjUVT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtpRC66A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtpRC66A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3261FC2BCB8;
	Tue, 12 May 2026 08:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778575595;
	bh=8kPfidwgc70FfY4o4fHamjH6lwkriRj+3wTzIJTIwFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BtpRC66AFOAZmZcT4o13vPuWIfR93kkaNkyh02Ozdyxe6K02mpJ9OCeFXAE4qyl44
	 sbznhqfFQX6FS6YswslXuZYzvfKXSQash3N62VcbjSiavF/zW4UKAgLFc2S7GRh01K
	 f6VM0OzjMDNAo7UNSsk0CPtYyjE9fhXapQtmnM4fCODygOLKELGcWGqg8OSLDEzRIm
	 JJBat2vvrCtShlaEW2+jzPZiZqC0x/xFOj1x525/tkF1eLeYUpl7GFzP6kNv3G7abB
	 N+3dMb67arxyjrr0U9Ek8yLS1e1KcDNcc7xiiwHZByf8qLv7wJ3Owclt+wH+qyMzqm
	 7O+pmzQHN9PgQ==
Message-ID: <685574e9-7937-47a0-b037-29f90b370354@kernel.org>
Date: Tue, 12 May 2026 10:46:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/3] selftests: mptcp: simult_flows: reduce
 bufferbloat
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
 <e4290c0e-6238-c7d7-b659-2e9f35b7f401@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e4290c0e-6238-c7d7-b659-2e9f35b7f401@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 11/05/2026 22:16, Mat Martineau wrote:
> On Fri, 8 May 2026, Matthieu Baerts (NGI0) wrote:
> 
>> Bufferbloat is baaaad, even in our selftests, let's kill it (or at least
>> reduce it). By doing that, the tests (seem to) have a more stable
>> transfer, and are then less unstable. But to be tested on CI sharing its
>> resources!
>>
>> The last patch is for -next, safer.

(...)

> Series LGTM, thanks for stabilizing these tests.
Thank you for the review! Now in our tree:

New patches for t/upstream-net and t/upstream:
- c63cea58b84b: selftests: mptcp: simult_flows: disable GSO
- 4331d54635fb: selftests: mptcp: simult_flows: adapt limits
- Results: d517676f86ac..412c23275fba (export-net)
- Results: c4353991ae52..a3548004f9ed (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/d3218264037efc171c3a4f63b4602cb3407ad024/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/f40e63356649b57b96b78acccc9d42c80220da16/checks

New patches for t/upstream:
- 4845dd70e328: selftests: mptcp: simult_flows: disable 'flaky' mark
- Results: a3548004f9ed..f02cf668b123 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/bf92df36c693c71c7d20a42c39492c1e3ad7ea03/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

