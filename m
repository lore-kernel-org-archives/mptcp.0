Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C3418454D
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509476; cv=none; b=BhNN413RN7cQQNocr0acn/TRdx5DgDvE3pRA3A4SD+7dbMZnGk8n3Erxdoxi84Am3rVhN5BlmUPRH64NARWAnkuoHqGn8n13vAtWZTumPFL+zBYf8VZmsgEH1e7n8eLutm39O5wBd+nYVeS7AT4D3uxN8cmHiHQgi20ASJJ3uAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509476; c=relaxed/simple;
	bh=0MT2CYiOw3/J+nmk/IwqB6cKRbD7HRsVJ7Lu9New5yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COhGd0fiRTcOJ+qysNI44SJ1BNy+5oxy2nMq6NFG4rFsN6UYIcrxK2Rj96w0tPT0iErEfIaQ+UXwYD1ataxp44XB3QmNoILLLAm/FUBWBpmmaFDX65MY19n6FSk756KRiDT9yupe7sIBK9cb4dElnomlq92hKcmgIma0WevMWw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf6Y4g7Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf6Y4g7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD7DC32786;
	Thu,  1 Aug 2024 10:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722509476;
	bh=0MT2CYiOw3/J+nmk/IwqB6cKRbD7HRsVJ7Lu9New5yA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rf6Y4g7YZk4fg0bswFjm8mXMskhdLdeaT2KZ42bOMtUBw2Qr0/xIVKV1YcLEXhePG
	 WQBJUd3Tf7i7VRbgNqtHGVwoKgYqVcL5zRwseRvl849bw4IYHO//JYvHvPHUBl/eOx
	 dSwolFJyRiylEDcMq6Wj2H2G9uKFiTjXiJ+yn/kEj4/SkCHg87DlqK0S3KLhr+0PC8
	 Jto3u1Cf5yqNmyH3C8th5NJqqJv8jCNpSDxoeLJCr6gNkzwB7qceNPT80tW0Evpqj/
	 s4Oh3luHj8grfIH83ZZY7+TfGN5QcnjHIAdkKV40O8ohMzPVxZUdAcZO1eiGoiuHk7
	 OwsW2R/RVLQ4Q==
Message-ID: <4fe88a4e-f767-4fd7-b168-5eadde1ca3ab@kernel.org>
Date: Thu, 1 Aug 2024 12:51:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow
 subtest"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <fccaccd2e7a1ce8518782c85965a6e26d37a87f9.1721872694.git.tanggeliang@kylinos.cn>
 <39a825a6-ddf4-4ba4-97f1-9ac72d9ac811@kernel.org>
 <86e407fd9b45d662515693a742fea144be16e837.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <86e407fd9b45d662515693a742fea144be16e837.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 27/07/2024 03:12, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, 2024-07-26 at 11:18 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for the patch!
>>
>> On 25/07/2024 03:58, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> Skip the test with test__skip() for systems that do not
>>> support "ip mptcp", so that CI can also pass.
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> index 00f63f3f19f4..ddef8c61360f 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> @@ -357,10 +357,11 @@ static int endpoint_init(char *flags)
>>>  	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
>>>  	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST,
>>> ADDR_2);
>>>  	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
>>> -	/* It would be better to use  "ip -net %s mptcp endpoint
>>> add %s %s",
>>> -	 * but the BPF CI is using an old version of IPRoute
>>> (5.5.0).
>>> -	 */
>>> -	SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl add %s flags
>>> %s", NS_TEST, ADDR_2, flags);
>>> +	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s",
>>> NS_TEST, ADDR_2, flags)) {
>>
>> This will silently mark the test as skipped, because stderr will be
>> muted.
>>
>>> +		/* "ip mptcp" not support, skip this test. */
>>
>> Could it be possible to at least print this comment? I can add:
>>
>>   fprintf(stderr, "'ip mptcp' not supported, skip this test.\n");
>>
>> when applying the patch. WDYT?
> 
> Martin, BPF maintainer, replied on "[v3 2/3] selftests/bpf: Add mptcp
> pm_nl_ctl link" recently to suggest us to send a v4 of it, if then, no
> need to apply this squash-to patch at this moment. Please send a v4 to
> continue using mptcp pm_nl_ctl.

Thank you for this note. The modifications I suggested might require
some changes of their CI. I think it should not, but I need to check. In
other words, it might take some time.

Would it be OK to apply your patch (with the fprintf()) to remove the
dependency on mptcp_pm_nl_ctl, and send this first? After or in
parallel, I can check what I suggested before. If this modification is
accepted, and their CI is still using an old IPRoute version, then we
can (re-)add mptcp_pm_nl_ctl. WDYT?

> 
> Sorry for the confusion caused.
> 
> Thanks,
> -Geliang
> 
>>
>>> +		test__skip();
>>> +		goto fail;
>>> +	}
>>>  
>>>  	return 0;
>>>  fail:
>>> @@ -435,7 +436,7 @@ static void test_subflow(void)
>>>  	if (!ASSERT_OK_PTR(nstoken, "create_netns:
>>> mptcp_subflow"))
>>>  		goto skel_destroy;
>>>  
>>> -	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
>>> +	if (endpoint_init("subflow"))
>>>  		goto close_netns;
>>>  
>>>  	run_subflow(skel->data->cc);
>>
>> Cheers,
>> Matt
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

