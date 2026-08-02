Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CC1171B1
	for <mptcp@lists.linux.dev>; Sun,  2 Aug 2026 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693490; cv=none; b=Xn1IHoXAN4hzAjojshbWrdd2JqvI/ugUmHwKkTV1C2gzqa5R1ymaWWMYLVUkSyn7Fp6HqYCRAhCUN9zjTk4kaTxNYRj9omxUUy5qIqNQQmYdaGO0nBVRGclNnKieb4kWPeQX5FimPKx/kadN2G+Ep5rqM01tUYRgXdZ5qP7iX0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693490; c=relaxed/simple;
	bh=9g4tOkuszD4ndT0mAkzbeOA9XQYmfJkM+o6x7cY3gMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfxzicrS6MacOdfvowLLX5YmXbFuaKhqhwHeS8NG4zxab/2GKXHuB5+zJWRT9+iiYUxilraM/3R0/v5pIwBo7mR1tsAiyK4eplRKPxufwCdpT7eY0JbnSw5eOMLwjU0SY5OP4rzACUwZgpfNO4UOZmCL7DqsbcKDUG0ZvKLFo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnwm9gOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnwm9gOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9CE1F000E9;
	Sun,  2 Aug 2026 17:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785693489;
	bh=KKxrZrzay78YeA5Nto68eIh8BV4BMx1RSDfyJGJoB+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fnwm9gOYVtnW6NY+64CD57jqX8obk+1a04zjZxN4bLu0w//TdoK1snKRPnDzrl3uR
	 fSZaJRAIWC0nyMGm4Gbm7D7ihqodcw3DIBPO9ZqSGG+5nQhvYzX02Cb2APBZ7NzSnJ
	 HU7NUY2c0LJZWhP+wYER+u+LNcMC5h2R2C9cCCxu0GlTB4loFKCjZ+ZEBZjXRcYxO4
	 qEbBRm4M9Kkid3nQvfIToXpuSzAvYf8njiTRNRBPUMhmNyfw43jfmwDCF9jOLJTLkA
	 aR3nhteomcqKtidMaLQlxRTyRSeVvw/Nr4U1RYgjsdp1APW+NicUPxH4q841oJPBHb
	 TR0qRWFX7yBKQ==
Message-ID: <32c52936-a10f-4167-a158-593950c290ac@kernel.org>
Date: Sun, 2 Aug 2026 19:58:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: cover IP_RECVERR
 sockopt propagation"
Content-Language: fr
To: David CARLIER <devnexen@gmail.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260802-mptcp-squash-sft-recverr-v1-1-df5f5e366e7a@kernel.org>
 <6bc62a92-766c-4551-8d7e-a6b3fd37f5a9@kernel.org>
 <CA+XhMqwdpHqketdoTM9Xu5=WjftssO27PUXDKrDPyNCyog67LA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CA+XhMqwdpHqketdoTM9Xu5=WjftssO27PUXDKrDPyNCyog67LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On 02/08/2026 19:56, David CARLIER wrote:
> Hi,
> 
> On Sun, 2 Aug 2026 at 18:51, Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hello,
>>
>> On 02/08/2026 19:46, Matthieu Baerts (NGI0) wrote:
>>> The CI validating the latest sefltests on stable kernels reported an
>>> issue with the MPTCP Sockopt selftest:
>>>
>>>   04 Mark v6                                           [ OK ]
>>>   setsockopt recverr on: Operation not supported
>>>   client exited, status=1
>>>   05 SOL_MPTCP sockopt v4                              [FAIL]
>>>
>>> That's normal, because this feature is not supported by these kernels.
>>>
>>> Skip the new test when the feature is not supported by a kernel, but
>>> keep failing if SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set
>>> to 1.
>>>
>>> While at it, also set the socket option name in the error message, to
>>> quicker understand it is linked to the IP(V6)_RECVERR option, and not
>>> a "receive error" type.
>> If there is no objection, I suggest applying the patch in our tree, to
>> stop the CI to complain. Extra fixes can be added later.
> 
> No objections at all !

Good, thank you for having checked, just did:

New patches for t/upstream:
- 5fede501cf07: "squashed" in "selftests: mptcp: cover IP_RECVERR
sockopt propagation"
- Results: 4cc6862c4795..39f1e342c901 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/ff8e53068f03a934be5192cdcad821833c10136a/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

