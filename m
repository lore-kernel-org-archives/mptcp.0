Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828F4EB4C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115631; cv=none; b=M1ubuVJZKfwRXzCh8M1m85hj3EewXrFjYoepFBpKybscpvCTD5abHCYMIum16sDWoL3/EUm5ex21VvdduQ0aPm1jGmrmeXXnvZGCq/tFR9A4JOfx5KQeKGhe93Xa5oD90pF7401KwgkxCfgQ85hvFls0IyPOKWnK8yNn/Jn4qFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115631; c=relaxed/simple;
	bh=eFGq6dEnBiWLv5ck7Fj7IKoCylVKVyaLpZiF/1e502s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riJyJAB8NW63yAlrnLBnzVpWPvLg3aYXHV/JC9nNcPvVm0Tee34+8jTBfBQ1M2pXKpqEGWN3mum1FV+4X0Y4zIAcl2B/l7/2z3TxiQ5KqIto4YAP9s+lsNK0+gubuRb+L3lhTSSvwOzCQSzKfwqSLJQjN+Emu7EmhmEScTMCluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwksVTpw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwksVTpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40B1C433C7;
	Wed, 28 Feb 2024 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709115630;
	bh=eFGq6dEnBiWLv5ck7Fj7IKoCylVKVyaLpZiF/1e502s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BwksVTpw7BiYde1X8J+U5xWtGBAoaWm00U8shnF38+ngAZEUeXWQuhvkYRbOdGe9N
	 0p84hQDDXV2qjWrXseNWpSMReWfUqsC5Ri6UVTyrWq69T0lW7CYKIrM8PZmozf1v6K
	 4zoSRAbq04lnhYRhABhEq1DMOOmN5sctVVkOK1zdgvMbSRyG7SdL31/nXV4p1vVayy
	 ZZsJN5a3oz9EoxDGUkSF1ppI8Ej0ecPULajJK7HDGZGxB8cjdZYqx23e9ICR2oJlr7
	 n1Wtq47c4ceEZG6dCmr9uiZD9wozADtow8CkXVIo99FhHjX9xepNUwnwYjGspdqNBm
	 VMvb5A7QgOMHg==
Message-ID: <2044e24a-598f-485d-9854-b6bda4e2cec1@kernel.org>
Date: Wed, 28 Feb 2024 11:20:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 07/12] selftests: mptcp: print test results
 with counters
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
 <ceb85fa70bc1c314fc7bab4e29b4e1b30e38dae4.1708939962.git.tanggeliang@kylinos.cn>
 <e898766d-8116-4d04-9d9f-56245ef0f56d@kernel.org>
 <444c3f8a7dfcda7f8f9afdd6d8af09f2e10ff323.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <444c3f8a7dfcda7f8f9afdd6d8af09f2e10ff323.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 28/02/2024 09:23, Geliang Tang wrote:
> On Mon, 2024-02-26 at 13:41 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 26/02/2024 10:43, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> This patch adds a new helper mptcp_lib_print_test_counter() to
>>> print
>>> out test counter in each test result and increase the counter. Use
>>> this helper to print out test counters for every tests in diag.sh,
>>> mptcp_connect.sh, mptcp_sockopt.sh, pm_netlink.sh, simult_flows.sh,
>>> and userspace_pm.sh.

(...)

>>> diff --git a/tools/testing/selftests/net/mptcp/diag.sh
>>> b/tools/testing/selftests/net/mptcp/diag.sh
>>> index f9f62a8f41e3..01e9f11f1f47 100755
>>> --- a/tools/testing/selftests/net/mptcp/diag.sh
>>> +++ b/tools/testing/selftests/net/mptcp/diag.sh
>>> @@ -9,7 +9,7 @@
>>>  . "$(dirname "${0}")/mptcp_lib.sh"
>>>  
>>>  ns=""
>>> -test_cnt=1
>>> +test_cnt=0
>>
>> Is it normal shellcheck doesn't complain about it not being used?
> 
> test_cnt still be used in this script in another place:
> 
> 	ret=$test_cnt

Oh, I remember I saw that when fixing other thing and apparently I
forgot about that: we should stop doing that! e.g. what if only the 4th
test fail? → We will do 'exit 4' which is 'exit ${KSFT_SKIP}' → the
whole test will be marked as skipped instead of 'failed'!

So we should do ret=${KSFT_FAIL} (or ret=1).

Do you mind sending a patch fixing that for mptcp-net please? (with a
Fixes tag: I guess it is there from the beginning or almost).

>>>  timeout_poll=30
>>>  timeout_test=$((timeout_poll * 2 + 1))
>>>  ret=0

(...)

>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> index 7e309493eda2..df495658f043 100644
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> @@ -411,3 +411,11 @@ mptcp_lib_events() {
>>>  	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1
>>> &
>>>  	pid=$!
>>>  }
>>> +
>>> +mptcp_lib_print_test_counter() {
>>
>> Maybe more "mptcp_lib_print_test_title" or "_name": it doesn't just
>> print the counter, mostly the "title" (including the counter, part of
>> the title)
> 
> Rename to mptcp_lib_print_title.
> 
>>
>>> +	declare -n counter="${1}"
>>> +	local fmt="${2}"
>>> +	local msg="${3}"
>>> +
>>> +	printf "%02u ${fmt}" "$((++counter))" "${msg}"
>>
>> Maybe having this:
>>
>>   : "${MPTCP_LIB_PRINT_TEST_FORMAT:="%02u %-50s"}"
>>   MPTCP_LIB_TEST_COUNTER=0
>>
>>   (...)
>>
>>   # $1: test name
>>   mptcp_lib_print_test_counter() {
>>       printf "${MPTCP_LIB_PRINT_TEST_FORMAT}" \
>>              "$((++MPTCP_LIB_TEST_COUNTER))" "${1}"
>>   }
>>
>> Would simplify stuff?
> 
> Do you mean to define TEST_COUNT in mptcp_lib.sh? That means we need to
> rename test_cnt to TEST_COUNT. I remember you objected to move vars
> into mptcp_lib.sh like in "selftests: mptcp: add mptcp_lib_ns_init/exit
> helpers". So I pass TEST_COUNT or test_cnt as an argument to
> mptcp_lib_print_test_counter().

Here it is different I think: here I suggest moving TEST_COUNT to
mptcp_lib.sh (renamed MPTCP_LIB_TEST_COUNTER), use it for all tests, and
only use it in mptcp_lib.sh. For the netns vars, they were use in many
places, with different names, and not the same number → we didn't want
to rename them everywhere. Here, it is a basic counter, just a single
variable that can be used in all tests, in very specific places (only to
read it, not to modify it).

I don't know, it looks different to me. If we can use it the same way
everywhere (when printing test title), that looks like a good modification.

> I think this can keep continuity with other functions in mptcp_lib,
> like mptcp_lib_ns_init/exit.
> 
>>
>> So tests can specify the format by setting
>> MPTCP_LIB_PRINT_TEST_FORMAT,
>> e.g. to support more than 99 entries. And you don't need to define
>> TEST_COUNT and disable SC2034.
>>
>> Would that work?
>>
>> You could even use it in mptcp_join.sh: print_title() would call this
>> new helper.
>>
>>> +}
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
