Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20581A23B0
	for <mptcp@lists.linux.dev>; Sat, 11 Jan 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736599962; cv=none; b=ZD+lBbhs6NtyAqqZlr00VZbXE0m1HIyj0k0OTN+DCd2E3GW0HkOVi8B42iHO7czAR+W1AVQaHIT0MkmbFHuFiKo/Z69621vZGe+aAkZWuyjLqPNvxNFcXce5n0zwX61vhak9mF4G9x1l+YEsAtElwW0SQ50zMDslFcjWcoH1HbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736599962; c=relaxed/simple;
	bh=62ykbvEkDt/GZMlVUk22n5LC/3clF0OjO11NpbxJwQc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=i70NrVlktbO3WT/NSoZDoJwEUo5vod71oxqrtyycuo5D2HmcydJYS8opctxsJno7g6LpxCXzfPuDvFLoa4rTBEjSb3VRHFoqTt5WL74999UbxhQ2r9WQhw0HfcORq6lheZm3Hb+8z8LFFe7fI5PbzZGifsgV6R79A8axr0dwT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nue/T0oo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nue/T0oo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57ECC4CEDF;
	Sat, 11 Jan 2025 12:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736599962;
	bh=62ykbvEkDt/GZMlVUk22n5LC/3clF0OjO11NpbxJwQc=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=Nue/T0ooWG9uq6A/LEVTxpuWPLCctjYLsCPn9VnhpIOTLTJANKTzOB/sfIgwMiIHP
	 jnP6rjTLz8+IlyvX1aruvfAEV0O8ETzcheJ5cuXhzw0QDrouZMWKqqXDVEyAahBf1/
	 pcwPiwGgk0hM6p4r4SZBFqJ+bd3rBEoR00Tktb0trQQd1Pc3iYPSHgoVulLW2qu84Q
	 JA7BGnjcxATsCwXp5tN/cJHvZ9wc2O7dljKy6ICRxVgsJGf6LQIyqFWXZaqJ0OaC2I
	 T+ZvGnpsYiN8FaZOQFKO0rtmo+hMHdnJULEPRkv8t4JUmGDTVx0J+E+gCb2gQXGFPZ
	 mspzV2o9A0Hnw==
Message-ID: <86565c4f-9308-4738-acfe-3fab8c9defad@kernel.org>
Date: Sat, 11 Jan 2025 13:52:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/3] mptcp: a bunch of fixes for ST flakes
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1736527092.git.pabeni@redhat.com>
 <76550d25-1422-41a1-af00-f65a6ba24505@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <76550d25-1422-41a1-af00-f65a6ba24505@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 11/01/2025 12:39, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 10/01/2025 17:43, Paolo Abeni wrote:
>> still under test locally. Sharing early for larger coverage.
>> Among other things, still to evaluate if patch 1/3 increases the ack
>> frequency "too much".
>>
>> Paolo Abeni (3):
>>   mptcp: be sure to send ack when mptcp-level window re-opens
>>   mptcp: fix spurious wake-up on under memory pressure.
>>   selftests: mptcp: avoid spurious errors on disconnect
> 
> Thank you very much for these fixes!
> 
> They look good to me and the CI, and the mptcp_connect.sh has
> successfully run 1250 times on my side:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Now in our tree (fixes for -net) with the small modification I suggested:

New patches for t/upstream-net and t/upstream:
- 6c4d6102b5d2: mptcp: be sure to send ack when mptcp-level window re-opens
- 7114896353d0: mptcp: fix spurious wake-up on under memory pressure
- f1255ad62bbd: selftests: mptcp: avoid spurious errors on disconnect
- Results: 33abddb5214c..17f91cba3085 (export-net)
- Results: dcd1bfd53763..17aabfa75062 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/ce2b29666dcb17454f9c500eb2aa2c61889f4b01/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/b1747a5cf769c578348f5371b105ddb41d4f8b6f/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

