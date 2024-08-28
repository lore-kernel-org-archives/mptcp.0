Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32113210D
	for <mptcp@lists.linux.dev>; Wed, 28 Aug 2024 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827032; cv=none; b=OtRBmgZ7agKSi+WZ+0aIwaKQZ3+a/I0cxC+9Sjx0H1ZtohdkMZys2Snc7i0+qlbEVoeAm1FnUbLeVHzSCpL1CvTnk1j7XlpNfo6k5c5Bd5whsc2l1ZoDcRgZw0oT9L2tkFriBfoedHh9ma6Rv1ifruNTlevY2Z3/ZegCWMfNGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827032; c=relaxed/simple;
	bh=WzC4j3qEKaIAXiGjpxZ9ckZ/K4GPle4XkGHIjHznOcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhiQ/Fccmd9OjpdKL4mCYVK0czC2LW9XVH5WZ5AM0szPFYe6CVT1yBvv9Z0Ul5+tOFfKotpff2fw3y92kEFqpjFvzcnSBFd4vEzVpIflVNZu5SfaIcNWYMtv/hB0QPbyRd4jQOWxnoOvWye6pX1GoNCLdi3BdLImtybgUUjTQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKqY3YIH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKqY3YIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628EFC4AF0C;
	Wed, 28 Aug 2024 06:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724827031;
	bh=WzC4j3qEKaIAXiGjpxZ9ckZ/K4GPle4XkGHIjHznOcU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nKqY3YIHS2SQ3fKvythfgMLXhoAfbeMzRXSwR02QVdm7jqojtuKzxtMx8FiNTrLsx
	 G4QTXIfUYRgV4wWJ4ZnypdL4pj4tTvFCNIGGxHtPoNDh+yt2bTicMWY8X/Kt9E8AW+
	 uTIDDsdMtjETwTbvj9ixxwy4BTfVXHDRicptUZQ9XziemA33HXuvqK1Seu9esb/2b6
	 kGGp8HpXiHBjXGs8puU8HKf6Y+YrWM48afYGWBqKlJUbeCztkbpsWbJt+5jlL0F3/6
	 gG4nI9qKmpncvn6LBQ/3YTlIq24JBdHCIZwIFUmSGAbyZy3i2GEnTrH0SQ756/SB+i
	 SQMUbdIDTUeCg==
Message-ID: <1732071c-afe4-4ff9-bc54-63b2a1275eb3@kernel.org>
Date: Wed, 28 Aug 2024 08:37:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/2] mptcp: Squash-to patches for "mptcp: more
 fixes for the in-kernel PM"
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240827-selftests-mptcp-longer-tests-v1-0-ec11c05fe980@kernel.org>
 <41e9e465-c8dd-fa13-a7d9-93a865f2159f@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <41e9e465-c8dd-fa13-a7d9-93a865f2159f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 27/08/2024 22:09, Mat Martineau wrote:
> On Tue, 27 Aug 2024, Matthieu Baerts (NGI0) wrote:
> 
>> These two small squash-to patches would avoid issues recently seen on
>> the Netdev CI when this series has been sent upstream.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Matthieu Baerts (NGI0) (2):
>>      Squash to "selftests: mptcp: join: check re-re-adding ID 0 endp"
>>      Squash to "selftests: mptcp: join: check re-re-adding ID 0 signal"
> 
> Both of these LGTM.

Thank you for the quick review!

Now in our tree:

New patches for t/upstream-net and t/upstream:
- a3be3c7a08d5: "squashed" (with conflicts) in "selftests: mptcp: join:
check re-re-adding ID 0 endp"
- 59a371c37841: "squashed" (with conflicts) in "selftests: mptcp: join:
check re-re-adding ID 0 signal"
- 3e07a3bd7bfd: conflict in
t/selftests-mptcp-join-mute-errors-when-ran-in-the-background

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/a57f02c478c04a53ffd285d01d70908424ee4c3f/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/c075d02b144c693f688166d40bbf4e087a094010/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

