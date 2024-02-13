Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51A55C39
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837694; cv=none; b=ZB5zir7LG+LaEabqxZXh24AKE9yC7sBRPkGvtYh9rrSfee9m5U+7ZMdcsFQBcqEFw59gwo3MPJ+P8p7kbQhG59CkpL+F8BOEG623BwNIl89m1SenB4m7idF2aoPzxZx+35lt/xsAsLrqnGFdN4h6O6kSYn4b+X99pvT98P2BoY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837694; c=relaxed/simple;
	bh=Ho3x+JpBmdkQpdYa9my8A88/dnzMCoLSK+B3zNIHuvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsYcpcnOXIwUhqB+o2We/Fsjns23oPZIoCVIdvs4itWPVHqB/TK5EvGnXvlzoX2udtcy+i1XeK5v+oEQACAriCx+NB3vNYeUD7ar0PeBt8S5prggr2uIGZNGGfC22YeFe743vpV7EpxE7k2kQGw+2lgic0Hrnj2WQ9y9XUfyK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls8GhJ0q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls8GhJ0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DDAC433C7;
	Tue, 13 Feb 2024 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707837693;
	bh=Ho3x+JpBmdkQpdYa9my8A88/dnzMCoLSK+B3zNIHuvY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ls8GhJ0qQsfJHKkBcTHziaKuZH7UbGpuSdqJZZG/urt0E1fx7vqVmgKCGR9I9nqoL
	 wSoJXHyOMPxAqTG3pJnvDnYHBgH9/ti8Gmzo+E+X/LVcIFwqxgziQrT26BHWNpAKVB
	 agUpzqaF4E/fUDS9SmWcWAW8/7ijJorQLmpBv6ZSRzKNh6gpK/k0wqjcY7heUQZyU4
	 WueOz+KaOYHnaGpzsrb6TbX21+cFojEE09j36NaX0hAbmFGCadiJSCec1qeSMPgrEF
	 nLkvaxK6fo3jg+6cgTEVo/5hXyy0pdgT35Z1Rkl2+XDX4dvR+MqKk6qurSDddyc9eo
	 PJAE61yjHQrpw==
Message-ID: <5af5e1b2-52db-4c3e-a856-abd097533fb2@kernel.org>
Date: Tue, 13 Feb 2024 16:21:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 1/5] selftests: mptcp: simult flows: fix some
 subtest names
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
 <20240209-selftests-mptcp-uniq-title-v1-1-e4fb3a3b5f66@kernel.org>
 <ZctT4/w/nH6+4Ocz@t480> <3668c451-c2e8-4654-8ab2-42c7eabc099e@kernel.org>
 <ZctzJ8qc2RhpZDlC@t480>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZctzJ8qc2RhpZDlC@t480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for your reply!

On 13/02/2024 14:48, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, Feb 13, 2024 at 01:06:40PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for the review!
>>
>> On 13/02/2024 12:34, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> On Fri, Feb 09, 2024 at 06:28:39PM +0100, Matthieu Baerts (NGI0) wrote:
>>>> The selftest was correctly recording all the results, but the 'reverse
>>>> direction' part was missing in the name when needed.
>>>>
>>>> It is important to have a unique (sub)test name in TAP, because some CI
>>>> environments drop tests with duplicated name.
>>>>
>>>> Fixes: 675d99338e7a ("selftests: mptcp: simult flows: format subtests results in TAP")
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>>  tools/testing/selftests/net/mptcp/simult_flows.sh | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
>>>> index 619be0e1acf5..f377ef01970b 100755
>>>> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
>>>> @@ -250,7 +250,8 @@ run_test()
>>>>  		[ $bail -eq 0 ] || exit $ret
>>>>  	fi
>>>>  
>>>> -	printf "%-60s" "$msg - reverse direction"
>>>> +	msg="${msg} - reverse direction"
>>>
>>> How about using '+=' operator to append a string like:
>>>
>>> 	msg+=" - reverse direction"
>>>
>>> The same in patch 3 and patch 4:
>>>
>>> 	msg+=" after flush"
>>>
>>> WDYT?
>>
>> I usually prefer not to do that, because that's Bash specific, and it
>> doesn't work with 'sh'.
>>
>> Here, we explicitly use '/bin/bash', so nothing is blocking me, just an
>> habit when often switching between "bash" and "sh" :)
>> I can do the modification if you prefer.
> 
> Both are fine to me. You can modify them or not when merging them. All
> tests passed on my side.

I noticed we were using the '+=' operator with strings in different
places in our selftests, so good to continue! I did the modification you
suggested in patches 1, 3 and 4.

I just applied the series in our tree (patches 1-4 in 'fixes for -net'
and patch 5 in 'features for net-next'), with your RvB tag.

New patches for t/upstream-net and t/upstream:
- 44927e6860b0: selftests: mptcp: simult flows: fix some subtest names
- 87e468d41e57: selftests: mptcp: userspace_pm: unique subtest names
- 177281100c09: selftests: mptcp: diag: unique 'in use' subtest names
- 766166e63987: selftests: mptcp: diag: unique 'cestab' subtest names
- Results: 4a5e7bd9b1b6..0675fccde951 (export-net)
- Results: 5051f12eb83c..0d848ef42dd7 (export)

New patches for t/upstream only:
- c5f0aa0fe0a0: selftests: mptcp: lib: catch duplicated subtest entries
- Results: 0d848ef42dd7..f63a9c1dbbaa (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20240213T151258
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20240213T151856

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
