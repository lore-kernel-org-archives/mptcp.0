Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785A3987D
	for <mptcp@lists.linux.dev>; Tue,  5 Aug 2025 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383820; cv=none; b=Llls9j/V5CFui7aWqMhSoS0W+Z1ZI4T9anERs5IOQ71Pkom6O5QmyzWsd0v8dS1vPlf3UjOerGUDDq/yOkEX+UqBwURcjciXA12F/fhmh5UAQgCNxCP1kKMlcWFG4aUyXTHpuwKBKgR0Mddx+vN4gKeRqxafNXkxy0GbDUHhlSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383820; c=relaxed/simple;
	bh=HAYPTLx14ryyXnqv5Z0StfRk1HDwkfHj4hL5nVtOhAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaVy51e6Z6EmlIFvgIIzsLm7na4hFqCnB+1l27ypI/YV/pXEMnVO4jvzN9hWv3Kglz+UzDRVbBdwVJw1zG0tnVq0KTmx+ymZbWHyB4E0XyYleOFFT3efY4erHgdg29zUH0nwmVzOpxRzoB7DFaxy5RhDkVp3haMi6oJ9IwTI/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/lyGC0q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/lyGC0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A79DC4CEF0;
	Tue,  5 Aug 2025 08:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754383818;
	bh=HAYPTLx14ryyXnqv5Z0StfRk1HDwkfHj4hL5nVtOhAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r/lyGC0qfIqMIjMG1af4IbmL+ytLRfnm263SBc1pP4TJ7Jtx5zFAZNrYgUcrBst2S
	 o1ctyjVW8YpbuaSe3TA7Lzv3zlwb3fmTiPuSS7CvFwtZbH6y8xBV1W1SagVsAX/PNq
	 BlTxdT4LJc0PYhp7ZfGBmgjH1aNnQD8vdywbARMyLwjWqPE9iTsuS/zJwOlD7lGmlP
	 FInKaCtxPioS6KdzsnAXLIScyPO11RHDh+E74nv+bzDCWfiSEQjzyuQPyxcPt1KQ2g
	 nLP9yQzJx1vYRVi384q4ArXZD1ASwW5TWOiEgkG6x9PswaVjxY04PBTAShAdnYhO9y
	 fWUIpqaCo4zKw==
Message-ID: <030bc349-4c8d-468a-900d-cba0a927c3b9@kernel.org>
Date: Tue, 5 Aug 2025 10:50:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2] mptcp: adapt ADD_ADDR timeout to maximum
 subflow RTO
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <40706ad511220729207ccd7cf48e320e4d0d7dea.1754028199.git.tanggeliang@kylinos.cn>
 <79652ff2-96ce-4c11-a955-59ef59300abc@kernel.org>
 <84a8cc576ad125c12daea8d409121e3165f30c83.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <84a8cc576ad125c12daea8d409121e3165f30c83.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 05/08/2025 10:17, Geliang Tang wrote:
> Hi Matt,
> 
> On Sun, 2025-08-03 at 14:10 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 01/08/2025 08:07, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> Currently the ADD_ADDR option is retransmitted with a fixed
>>> timeout. This
>>> patch makes the retransmission timeout adaptive by using the
>>> maximum RTO
>>> among all the subflows, while still capping it at the configured
>>> maximum
>>> value (add_addr_timeout_max). This improves responsiveness when
>>> establishing new subflows.
>>>
>>> Specifically:
>>> 1. Adds mptcp_adjust_add_addr_timeout() helper to compute the
>>> adaptive
>>> timeout.
>>> 2. Uses maximum subflow RTO (icsk_rto) when available.
>>
>> "when available": this worries me and is linked to my question from
>> v1:
>> I don't know if ["icsk->icsk_rto"] will be set to a correct value
>> when
>> we will look, no?
> 
> Can we ensure this by adding a check whether icsk->icsk_rto is between
> icsk->icsk_rto_min and icsk->icsk_rto_max?

I don't know, that's why I was asking (sorry, I didn't check).

My point is more that the RTT constantly varies, and variables like
tp->srtt_us and tp->rttvar_us are regularly updated. But I don't think
icsk_rto is frequently updated. If I remember well, it is updated when
needed, no? Here, you are using it, but potentially when it is outdated, no?

> I have also used srtt_us and rttvar_us to calculate rto, and the value
> obtained is similar to icsk->icsk_rto:
> 
>     rto = usecs_to_jiffies((tp->srtt_us >> 3) + (tp->rttvar_us >> 2))

Then, I guess you could use the following, no?

  u32 subflow_rto = __tcp_set_rto(tcp_sk(ssk));

>> I guess it will be set by TCP only when retransmissions will be
>> needed,
>> no? So maybe not set when sending an ADD_ADDR? Or set at the wrong
>> value, no?
>>
>> some mptcp_join.sh subtests are failing, maybe because the
>> retransmissions are done too frequently, no? Also, it is suspicious
>> that
> 
> Yes, "delete re-add signal" test failed. It needs to be updated:
> 
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3938,14 +3938,14 @@ endpoint_tests()
>  
>                 chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
>                 chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
> -               chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 6
> +               chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 8
>                 chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 4
>                 chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
>                 chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3
>  
>                 join_connect_err=1 \
>                         chk_join_nr 5 5 5 
> -               chk_add_nr 6 6
> +               chk_add_nr 8 8
>                 chk_rm_nr 4 3 invert
>         fi
> 
> This test does indeed cause add_addr retransmissions, but the original
> retransmission timeout is too long (120s), so the test does not detect
> the retransmissions.

My fear is that the test might be unstable: if the environment is slow,
there might be more ADD_ADDR retransmissions, no? If yes, can we not set:

  sysctl net.mptcp.add_addr_timeout=0

for this test?

BTW, do we correctly handle this case where this timeout is set to 0? I
guess we should not retransmit when it is set to 0, but I bet we would
retransmit the ADD_ADDR without delay, which seems wrong. If we do that,
I think we first need a fix for that for net. WDYT?

>> the ADD_ADDR packetdrill tests are still passing: are they not
>> checking
>> for retransmissions done once every second? (or maybe the tolerance
>> is
>> too high → best to check with a packet trace)
> 
> In both add_addr_retry_errors.pkt and add_addr_retry_plain.pkt, we set
> net.mptcp.add_addr_timeout to 1 second. With this new timeout
> adjustment, the timeout value is adjusted to several hundred
> microseconds, which is similar to the original value, so the tests all
> passed.

Does it pass because the tolerance is quite high?

I think it would be best to print the RTO set by the kernel when running
these tests, and adapt the expected values in the packetdrill tests to
be as much precise as possible to avoid unstable tests. Could you check
that as well please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

