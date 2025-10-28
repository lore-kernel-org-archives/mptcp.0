Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130C834BA20
	for <mptcp@lists.linux.dev>; Tue, 28 Oct 2025 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672671; cv=none; b=JA0tcEeg7WN3sjTCTBCOYEw58KFShENMeaS+8F3dOZftr5TXPIpTK0UQf3UGIBHC5BHNfv5nUn1lXAv+2YPYg6RFsCtGT5LYogHDfZabrNoSP5PPxdwR6/NyvD9vHeYr67ymwoF2cXaC4ugl6wNw5FichUzXjPlI/FBuPEsCtR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672671; c=relaxed/simple;
	bh=4Pg18Mo48hzXqQiQXxloyoxvntcyHmrdTHlH98qptK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O3oCTrIpuRGcaKeryRZOx7UmlecbxhtxmQkpQenvmwH9KMW63hrcjitER+y4tDKThv0xVSK/eMAl+jyCW11RmnnoHM03dorQRuKTy1j9eCa6XuChBgALT85moGYBFDHW0eczCOCA0iuHatGPqLmA2+9PUaQcSLrBCCCq/8rwk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og0rL7Es; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og0rL7Es"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66ED0C19421;
	Tue, 28 Oct 2025 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761672670;
	bh=4Pg18Mo48hzXqQiQXxloyoxvntcyHmrdTHlH98qptK0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=og0rL7EspBTN3GkC5Tic1pFStd01eJx+XGA7X7/+erKGunda8vCc8v6Esw1D2H70F
	 mz/I6yP2e3/01lW0v8H5BwjswhS7h/Ek6lZBNKgj7pDQejC8peodhouDNIFjX3lqbp
	 2P+taSKU8rVxV2hiNUL0GCZASc49OIQAR0SwKxWn0Ie05/effK3yiLNJy1ODAYXcer
	 UgrEay6tPPFPqSD1t6xcHPkzpdCjXcD4C6tlmYVaWw8axJA9ypCoIZFk3nNhIcjkPe
	 iZEQ+/hQyHSBGYI7aUtErSMsIsuwJzIQNrLSsok3/dYvJSnblOO2xGq0jqFgH5rGNV
	 u9YOCgmzHkF1A==
Message-ID: <a8e6e66b-ca88-4888-87c3-4b1b4b906782@kernel.org>
Date: Tue, 28 Oct 2025 18:31:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: join: validate
 extra bind cases"
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251024-sft-fix-bind-timeout-v1-1-cb81a67b222c@kernel.org>
 <95fdc88fbeba58db5976f97f117b1579a873c051.camel@kernel.org>
 <17404b24-dbed-4f16-9ff6-5822bffc3c1b@kernel.org>
 <074a8c2a99f102b2452570814c9700ef0225b145.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <074a8c2a99f102b2452570814c9700ef0225b145.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 28/10/2025 02:34, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2025-10-27 at 13:21 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 24/10/2025 14:56, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> Thanks for this fix.
>>>
>>> On Fri, 2025-10-24 at 12:02 +0200, Matthieu Baerts (NGI0) wrote:
>>>> I was going to send the related commit upstream, but then I
>>>> realised
>>>> in
>>>> a slow environment (e.g. public CI), with a debug kernel, the
>>>> default
>>>> 10 seconds timeout can be too short:
>>>>
>>>>   086 multiple bind to allow joins v4
>>>>         join Rx                             [ OK ]
>>>>         join Tx                             [ OK ]
>>>>   main_loop_s: timed out
>>>>         add addr rx                         [ OK ]
>>>>         add addr echo rx                    [ OK ]
>>>>   ./mptcp_join.sh: line 3305: kill: (2032) - No such process
>>>>
>>>> This doesn't affect the results, because it happens after the
>>>> test,
>>>> when
>>>> checking the counters. Still, better to fix that by using an
>>>> infinite
>>>> timeout: the process will be killed at the end.
>>>>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> index 05faacefb719..e0cdb9c662aa 100755
>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> @@ -3293,7 +3293,7 @@ bind_tests()
>>>>  
>>>>  		# Launching another app listening on a different
>>>> address
>>>>  		# Note: it could be a totally different app,
>>>> e.g.
>>>> nc, socat, ...
>>>> -		ip netns exec ${ns1} ./mptcp_connect -l -p
>>>> "$(get_port)" \
>>>> +		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p
>>>> "$(get_port)" \
>>>
>>> A timeout of -1 means block indefinitely, right? Do you think using
>>> the
>>> default 30 seconds (-t ${timeout_poll}) is sufficient?
>>
>> No need to use the same default timeout: this process is executed in
>> the
>> background, and we explicitly kill it at the end. Worst case, the
>> other
>> process timeout after 30 seconds, and we will still kill this one.
>>
>> So it looks easier/better to use -1, no?
> 
> If that's the case, could we set a value that is, for example, twice or
> ten times the value of ${timeout_poll}? But it's up to you.

I don't think that's needed: here, we don't wait for any events related
to this process executed in the background. So we don't need a timeout.
If really there is an issue to reach the kill part at the end, the
process will be killed when cleaning the netns.

New patches for t/upstream:
- 284511309756: "squashed" in "selftests: mptcp: join: validate extra
bind cases"
- Results: cfb47c65c4ba..2ae62d17b961 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/ef9e74921bb057425352352ee9e9e69df0d0c705/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

