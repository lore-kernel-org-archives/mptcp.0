Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374B3C5525
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175176; cv=none; b=pmYlNkzpfPDTJ/7/guUeLGDz+rJWlQFS89N6AI5y2Wjea/NBeSDcgfmN1EccFxsD96B7QdJUQl2Wd8CKYNTSSJdXCTW031xt0nwGf/vmKrezUY7bwsffTUSWiabAtd/PdQdi3aVNzwm4NVV2cbwTIwFONLV1646A5mUT2nZW3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175176; c=relaxed/simple;
	bh=KO5d39OD0vVLdxyJzq+MuW6bHmD9/oeT/Q+wnA6jKbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+INhjXZhf/vOfPYKw8UyNJ/nxIJjf36Q9za5FAtiLPHBQv1H5gTfzgMmZlKTCSVPZxJUGkeaijE3A8DIvgUNEjeikcsmiLDG0bD7J6JjGltgTCooySYAEOQ/vIALIbfXSUzxdALtv3eJvOHWaBc7v41S9loG1sju1WHpcMo1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2ZTRKRb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2ZTRKRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9EEC2BCB3;
	Tue, 19 May 2026 07:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779175176;
	bh=KO5d39OD0vVLdxyJzq+MuW6bHmD9/oeT/Q+wnA6jKbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u2ZTRKRbUw5eJVXGjiqHcr0NtnKPPOUPU06tAZjy0c65xDXi8Gqc6vnhTYCLU1NWJ
	 Wbr1kzjLrZZHaqe/c/QxZoz+f0FKYB6nfeOACttAe7dnR3IBqETW0oTDN0lyWoRecy
	 0dGP6QlwH+1+mvy03DuNdHEnLRTmaYfF9/8qmZ4azfDzM4jUTevto9E5qrl04d+Uhf
	 T02rQdNNpiQPie6ftpdprvw3mkM0V9wXKMx0GOcja+7OIf2eZUNkcFUJwCceC6ZWJL
	 p78jNl5H8st3N9+YG1MF1g4QIoX0TfgrHhgbAU98lQomj0hVpPklP4j6IyKxmwDheV
	 mtEK2S1I91iPg==
Message-ID: <969cf245-ce26-40d5-9b5f-15c9b3e725aa@kernel.org>
Date: Tue, 19 May 2026 17:19:32 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 03/12] mptcp: pm: drop TCP TS with ADD_ADDRv6 +
 port
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
 <20260518-mptcp-add-addr6-port-ts-v1-3-f1ca26977fcd@kernel.org>
 <9878b113-59e9-4100-92b8-fed412466097@redhat.com>
 <e8eab089-38a9-4786-9052-b2d0a4d2aab4@kernel.org>
 <d86df020-4976-4a34-9f27-6ef09fa9b2d5@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d86df020-4976-4a34-9f27-6ef09fa9b2d5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thank you for your reply!

On 19/05/2026 17:10, Paolo Abeni wrote:
> On 5/18/26 7:17 PM, Matthieu Baerts wrote:
>> 19 May 2026 01:19:36 Paolo Abeni <pabeni@redhat.com>:
>>> On 5/18/26 2:59 PM, Matthieu Baerts (NGI0) wrote:
>>>>         if (mptcp_established_options(sk, skb, &optsize, remaining,
>>>> -                         &opts->mptcp)) {
>>>> +                         &drop_ts, &opts->mptcp)) {
>>>
>>> What about passing `opts` instead of both `drop_ts` and `opts->mptcp` ?
>>
>> I didn't do that because "struct tcp_out_options" is defined only in
>> tcp_output.c. Do you think it would be worth it to export it?
> 
> I did not consider the above. I think it would make sense to move
> `struct tcp_out_options` definition to an header file, possibly even in
> net/ipv4/. I admit I'm not sure Eric will agree. Possibly an early check
> could help.

OK, I can ask. But before, and just to be sure: if I pass "opts", that
means the removal of the TCP TS option will be done on MPTCP side, and
not here on TCP side:

  opts->options &= ~OPTION_TS;

Would it be OK? I mean: it feels like hiding the fact we are mangling
TCP options, and it might be better to keep doing that here.

An alternative is to pass the size, and suggest dropping all other
options, similar to what is done with ADD_ADDR where other MPTCP
suboptions are dropped.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

