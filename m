Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E753E009B
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886517; cv=none; b=QQxYEzaNxpsJZLSeMqbsOtrUSiPiyVrRwPoOKenMU3nBGn5oRzyUTficAqVd3K8rgTvz6b/D2hV2ah8GsSmUx4UAUNM1GaluPEGamRfskNqofcm/fNyA83HZJoqcR5c69T6DfB74/nc4tzdjkzENg63jz16RI/2bBtohI5DDDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886517; c=relaxed/simple;
	bh=6218iP0hqqqMNuz+dJvDZn2Jdo0yvUuQbNb/R866b/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8+MDTvCjADnOfCk+NCLKCVXTT/Gj84KIv4/zmEJxSwyWhHqWgA+WSS1r3D+IPY8VQCW/l7Clj9RPIYxZFRuCkjI/wAEzaPSgrpalVhSZMxVihX8ueuaHgoPNGaCeCt6TVqUAz6DZsJ+rMmlPw4EUxQ2/PmVpSl5RjwgSVx5PtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2gWTO0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2gWTO0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C121F000E9;
	Fri, 24 Jul 2026 09:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784886514;
	bh=pEwRj50r727usTcajAb64QS0fiVAhOLZgNXk4uvtvKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f2gWTO0zVJw3EF/xDNmqebz2Oy0r4k+nVn9aWmPuewTrPiz7RwZKv5AX77lglVNBV
	 RusCLRh40kdWllsEeAxBYTT1wKFXJdmVxxzTfK4D0VR2q9mEj22EKU0J2GElRadJFG
	 NamDL8TChZQCheij5QxcDZwpzbWU34RJSLAiE9UAWbnlqRGhaR1RoxDrFPGg6JRbqc
	 cLyID9XCjtWH4RTnze52LmY18LxmBBOKMR2ehHlj6gfdJU1jXGhyn4yVI5+dcFU+qZ
	 8kz8MQ2PJcbWyB0orHLQj6YTkHNdBIQQryF/mDu3In7lMPCJA7u44/jOWCK2BUhSZT
	 LbpvwmKBzWMKQ==
Message-ID: <eb6d7e10-8631-41ff-9c66-80362193897f@kernel.org>
Date: Fri, 24 Jul 2026 11:48:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] selftests: mptcp: run fail_test in main
 shell during join test
Content-Language: fr
To: gang.yan@linux.dev, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260724065229.36736-1-gang.yan@linux.dev>
 <20260724065229.36736-2-gang.yan@linux.dev>
 <560844d2-60e5-4d43-b039-071125fc9f08@kernel.org>
 <a3076ab0e3303b7d893c1988d20bc83572043dc0@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a3076ab0e3303b7d893c1988d20bc83572043dc0@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2026 11:39, gang.yan@linux.dev wrote:
> July 24, 2026 at 5:28 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrote:
> 
> 
>>
>> Hi Gang,
>>
>> On 24/07/2026 08:52, Gang Yan wrote:
>>
>>>
>>> From: Gang Yan <yangang@kylinos.cn>
>>>  
>>>  check_transfer() compares the input and output files byte-by-byte using
>>>  `cmp -l "$in" "$out" | while read ...`. Because the while-loop body runs
>>>  in a subshell (the script sets neither lastpipe nor pipefail), the
>>>  fail_test call inside it -- which sets the global ret/last_test_failed --
>>>  and the `return 1` both act on the subshell, not on check_transfer().
>>>  check_transfer() thus always falls through to `return 0`, and any data
>>>  corruption affecting only the payload (leaving the subflow/PM counters
>>>  untouched) is silently reported as PASS.
>>>
>> Good catch!
>>
>> This looks like a fix that should be backported. Do you have a Fixes tag
>> to add here?
> 
> Hi Matt,
> 
> Sorry for that, I originally thought only commits touching ./net/mptcp needed
> a Fixes tag. This fix should be:

"Important" selftests fixes don't need to wait by going to the next
version. If they fix something that can help users and/or CI, they are
as essential as fixes in net/mptcp.

We should just avoid fixes that don't affect results, e.g. the second
patch of this series. But that's also valid for fixes in net/mptcp, e.g.
a fix for a condition that can never happen with the current code, but
will be the case with pending new features.

> Fixes: 8117dac3e7c3 ("selftests: mptcp: add invert check in check_transfer")

Thanks!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

