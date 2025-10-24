Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F392FCBED
	for <mptcp@lists.linux.dev>; Fri, 24 Oct 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293230; cv=none; b=mOY2cdFVe/ANyrKIwTjn339S2pPV434OrOAIs/J27y22fbqGwIfLBxdXCI9EVl7opLfxk0arkWSzd5CDfxQ9d2vPrGNwGUDlL5kveM4JzGiYSK2G876dkL/nO55oDDOnTK+3kVhIDQc/T6eGf1EgPX3MOeqVVasP4MstoG5T/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293230; c=relaxed/simple;
	bh=omH4ebCoDNSPMs6ZZK/HWOoAN9QwX/BtfWYsFfRaIXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rb8f4/cCWGBd2wyvycAJAWJtJKf8kBgVmgDS0fP5V76WIGJ5tnvWSKzYqOnmW97xLqaeqMkpuov8S+OA1cfR1t6p8t9FgZl6M+JgNNa9NmZuKB+RevEbIB2/JODyIpYrSd6n2Nta1orasHfVySv/0nwcaHCD2jHZXl2cN0cGezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0PIWFyW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0PIWFyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBECC4CEF1;
	Fri, 24 Oct 2025 08:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761293229;
	bh=omH4ebCoDNSPMs6ZZK/HWOoAN9QwX/BtfWYsFfRaIXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m0PIWFyWw8xINpmh4bk8p+sQ2VOVtBb6yuzEExLU7fA7qxTv3UqO0vs9CYYQzf5Xh
	 S6TOMkjI016sjmnpgpzZovEjijE2kv6Jsaiqof3Jel9hdtKn2+6SQhXcRFdgw45ynU
	 TX2HKguQcZNAfmnvsrMiTI3mCO2awuxRDSbGWgh93q5bXTGkP9K9zgXTFeiDG1Cg1n
	 opoD8YxY0MA42kMkhU++iJ1TgKE1Em43GXyF8kdejxD7VDFOkXowPJw0fWdmc5WG3C
	 PPV1IBTnu7vKRYFTt5huvjzHgYmFZxK2pKClpUP66lG04W7IKzp7bWv0KLFzpyYCvr
	 /zOFsoPt/rdCg==
Message-ID: <fa1320f8-9512-46b3-9196-62e3404ae30c@kernel.org>
Date: Fri, 24 Oct 2025 10:07:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: zero window probe mib
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
Cc: geliang@kernel.org, Mat Martineau <martineau@kernel.org>,
 mptcp@lists.linux.dev
References: <cover.1761118636.git.pabeni@redhat.com>
 <9c935ea98196be13949542dcfe787e5bc799ae23.1761118636.git.pabeni@redhat.com>
 <be149ae2-74f3-4655-a03f-08cda8a15c44@kernel.org>
 <14084e3b-2ee1-49bd-b04f-8281d4f9c3be@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <14084e3b-2ee1-49bd-b04f-8281d4f9c3be@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 24/10/2025 09:30, Paolo Abeni wrote:
> On 10/23/25 6:26 PM, Matthieu Baerts wrote:
>> On 22/10/2025 09:39, Paolo Abeni wrote:
>>> Explicitly account for MPTCP-level zero windows probe, to catch
>>> hopefully earlier issues alike the one addressed by the previous
>>> patch.
>>>
>>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>>  net/mptcp/mib.c      | 1 +
>>>  net/mptcp/mib.h      | 1 +
>>>  net/mptcp/protocol.c | 1 +
>>>  3 files changed, 3 insertions(+)
>>>
>>> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
>>> index 6003e47c770a7c..eb4645a9c5ac07 100644
>>> --- a/net/mptcp/mib.c
>>> +++ b/net/mptcp/mib.c
>>> @@ -85,6 +85,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>>>  	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
>>>  	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
>>>  	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
>>> +	SNMP_MIB_ITEM("MPTcpWinProbe", MPTCP_MIB_MPTCPWINPROBE),
>>
>> Detail: I just noticed that after having applied the patch: Do we need
>> to double the 'MPTCP' keyword here? The full MIB counter name is:
>>
>>   MPTcpExtMPTcpWinProbe
>>
>> Maybe just WinProbe is enough? → MPTcpExtWinProbe
> 
> I'm sorry for the late reply. Yes WinProbe -> MPTcpExtWinProbe is the
> correct/intended name, if you could fix that in the tree would be great,
> thanks!

Thanks! Just did! I also renamed the enum

  MPTCP_MIB_MPTCPWINPROBE → MPTCP_MIB_WINPROBE:

New patches for t/upstream-net and t/upstream:
- 9525948cb5cc: Squash to "mptcp: zero window probe mib"
- Results: f6c0967d41d1..628a66ff3d17 (export-net)
- Results: 8416614a1e27..6354d0b32825 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/60ce52cf453b5182b993d2420d01422355ebbd67/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/a76c4725014b6c51385d301f1027a7891714a6bb/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

