Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8E1B6CF5
	for <mptcp@lists.linux.dev>; Wed, 19 Feb 2025 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990562; cv=none; b=TOS/k8c1EPu8WeozWtr3C7UQTyOhyNwQJRgePE2nvzEuN0NfJkEfrVFgNTWU0S6awnU+DujYLbHsLyvPtW2OoNXXkopGG/j8rsYsC9osTfgO8eJ7IVftvmHTSCXonvIc3WFmivmoa9uxrVPcAb2BpOyJq7pknG8lP3KVatDTmOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990562; c=relaxed/simple;
	bh=9mtdtEvAb9jA8we/D882fxmOAkbK1iAVqFkdb6f7NY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQAgmJKk10V3AUrffQR+oRmCGPapkiED1QQQpEgaTA52LipqcyQ1G+twmDaVkDNEJo1/Hd4KCWOmL6FbTuD9YrnCMXae1kgE316QOYL1ubzxliPZUiFJmuDpK4leGdg1m3UheINX67SbjM50sBfdMHIIc3m2DzxElRkxKP+gb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJR+DnhK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJR+DnhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01021C4CED1;
	Wed, 19 Feb 2025 18:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739990561;
	bh=9mtdtEvAb9jA8we/D882fxmOAkbK1iAVqFkdb6f7NY0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MJR+DnhK60IgXf6YZiY95gGrqllrzvtmzDlzoxAyjJU7elBvafE+QW35kNpR1ylan
	 JIf7HY5x/qpyTN1pfTRsfMW6uWRrqbI1Kg2gDjcxEf5/gf+ysn7rZXojaTOzlp9EOp
	 WYt5HRZAOH7YqxU2m75TyrsYm/80h1yPR2/W8J5maAq9+SR69Pngw3UcxwmDEZEFqY
	 v58p3wpL77JsVSj9yye1MlIhJjXQhWPj8GnGlTQa6GokHGtBOzKGO/UOF4f29TAV1W
	 6xKmNfGEq9z+aHBlQgXcucc4BudSkgqL43NOU5sG2J6fgg93dDV2H5fp6JLfO5OEhf
	 ByvxPbpD3OHTQ==
Message-ID: <3e0b0512-b924-46c5-81a6-fa5cc83929b4@kernel.org>
Date: Wed, 19 Feb 2025 19:42:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: reset when MPTCP opts are dropped
 after MPJ
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: "Chester A. Unal" <chester.a.unal@xpedite-tech.com>
References: <20250218-mptcp-dss-drop-mpj-v2-0-0c6caa10ec52@kernel.org>
 <9e83a37d-993a-4766-a1c7-e19aedfa072b@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9e83a37d-993a-4766-a1c7-e19aedfa072b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 18/02/2025 17:24, Paolo Abeni wrote:
> On 2/18/25 12:24 PM, Matthieu Baerts (NGI0) wrote:
>> - Patch 1: fix issue #544 where a middlebox drops MPTCP options after a
>>   3WHS on the additional subflow.
>>
>> - Patch 2: a safety check is added when asking to do a fallback to do so
>>   only when allowed. If not, a new warning will be emitted.
>>
>> Note that two new packetdrill tests have been added in a PR to cover
>> this case:
>>
>>   https://github.com/multipath-tcp/packetdrill/pull/160
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Thank you for this review!

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 1babdda71364: mptcp: reset when MPTCP opts are dropped after join
- 1e4711c4b02c: mptcp: safety check before fallback
- Results: 54ac5bb2f077..aba580cd4fc8 (export-net)
- Results: 4ba9db964049..3ee8e45b1642 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/2ea4756918f65f22b82d3134485d4c2842e3400f/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/4f345f49f9f36636d9f8408b4a30b70f602b50ae/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

