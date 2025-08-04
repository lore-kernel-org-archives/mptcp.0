Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6C19882B
	for <mptcp@lists.linux.dev>; Mon,  4 Aug 2025 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296367; cv=none; b=TijATstJhosSscui707zsWLFfAEY4zehVyuP51aIDWMdGtDyshmRTfg965HyJrDvUL3pE5UsCie8co2Fa/1KaVZvFqTBAOILLKpiwZrDY19aj+M6pARI01CQ+I+9Rcu64eFCKDkd5oQl+kvx1uqEBP7Mer3RgYi2BbY2br/fr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296367; c=relaxed/simple;
	bh=qMo3cbBFN3TTkxTN64KgjoVDkkfdMBj8ZBTkK4VAYJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rwCF/Yki4iGLF92b7jAknqKlpSn6svV0MsacP8vERcr3DHU+EIxbsApAUep9pUmc+atTFeGuE4uEZ0poo6WPgdN06J8BUTkxhtVPmCMQ2j0WMSINU3myRG3HnjXaBr0yvdimIG266k83rZiHiZTBNOSEWPQdo9en/tI3T4VUZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjboIXR1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjboIXR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9189BC4CEE7;
	Mon,  4 Aug 2025 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754296367;
	bh=qMo3cbBFN3TTkxTN64KgjoVDkkfdMBj8ZBTkK4VAYJU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=FjboIXR17tWUPiurCGAKt5jkIikZEufpUHUKxm7ZAFHeFWhaSSJNpserOOOPUYCwF
	 1OilzsxvvoI1CkVHfnpKj41KdQKXaPN6Q/cDh5mjv109NZYWYo5brfUVB5xicrfCGw
	 MEVenk2Vq8ltOB+4fc+LrImYpABHHpbP0N00kl3L6x+iuNV/YLKswgrwhUMvg9IM5R
	 Stt25u9dO9YobNrD12/+9OjeNhAXPr4DHCtldonMVPlO6aJNf87o4OiofLPQyXozXx
	 KTvE9KgkNUq/oOUpNhag/si3L2SCE0lm7jRpnPqktQN2wmR2HCz1cfXdpcKsfLt+F8
	 AWp6PYdpe//6g==
Message-ID: <be7aef88-fd39-4dd2-856f-b0d96a2764a9@kernel.org>
Date: Mon, 4 Aug 2025 10:32:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/2] selftests: mptcp: connect: fix C23
 extension warning
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250803-sft-mptcp-warn-gcc-v1-0-6d87808721ea@kernel.org>
 <7bc26a32ca9ce941ddc0040be77dab18c8b55256.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7bc26a32ca9ce941ddc0040be77dab18c8b55256.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 03/08/2025 16:08, Geliang Tang wrote:
> Hi Matt,
> 
> On Sun, 2025-08-03 at 14:13 +0200, Matthieu Baerts (NGI0) wrote:
>> GCC was complaining about the new label:
>>
>>   mptcp_connect.c:187:2: warning: label followed by a declaration is
>> a C23 extension [-Wc23-extensions]
>>     187 |         int err = getaddrinfo(node, service, hints, res);
>>         |         ^
>>
>>   mptcp_inq.c:79:2: warning: label followed by a declaration is a C23
>> extension [-Wc23-extensions]
>>      79 |         int err = getaddrinfo(node, service, hints, res);
>>         |         ^
>>
>>   mptcp_sockopt.c:166:2: warning: label followed by a declaration is
>> a C23 extension [-Wc23-extensions]
>>     166 |         int err = getaddrinfo(node, service, hints, res);
>>         |         ^
>>
>> Simply declare 'err' before the label to avoid this warning.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> LGTM!
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>

Thank you for the review!

Now in our tree:

New patches for t/upstream-net and t/upstream:
- 9486cb4888a5: selftests: mptcp: connect: fix C23 extension warning
- 6a17fdde8884: selftests: mptcp: sockopt: fix C23 extension warning
- Results: 9380c91e86eb..82cf743daa3e (export-net)
- Results: c6e4c6478b19..58528cde3023 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/3ce0a4201191ee78fa4fbc3bcbe199f4409aa9ce/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/673139156ef681c8c71abad4cd97db0ee2f7f6d0/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

