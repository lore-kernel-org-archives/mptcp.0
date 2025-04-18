Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9B8836
	for <mptcp@lists.linux.dev>; Fri, 18 Apr 2025 00:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744937676; cv=none; b=rT3U4Qh5OFCJvA3jgLT4exXf26l4I2kPqem1fLQbFsmIZjIUEIpM6G4koufJKMPIrZ6BwMOAWfdotzCVh7Md3OU5D7Bl8en7pXVoWIYYjAlfYK5lgAT2jZN0jLcJXzoDbB9syiioSlQ3xWW4te2YjdCw8wrk7BR2J8m1smI1A0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744937676; c=relaxed/simple;
	bh=J3U/E0JllzsK2DQn4g4UKKe7HIuPWAGjmM0MbL/Fjok=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hTHOa3HFZ3QCLB+yWsVpMcWlMaab4tFgK/TdzZqLKAs/bgy5AcZTMK1pRCgFD59FJrreSX9KDZprWYLRaBXTMqaDtD/F/ObYujGh6LLxhOlqO1J2j6expOca8nMk1W4safkj3O0K133QffYmRpNSLcV+5HSMHzCxvzLAMMTU8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6RLrQ7X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6RLrQ7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A268DC4CEE4;
	Fri, 18 Apr 2025 00:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744937675;
	bh=J3U/E0JllzsK2DQn4g4UKKe7HIuPWAGjmM0MbL/Fjok=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=O6RLrQ7Xm1ONVmET6Mj5f0Lzlyziob0JczROdHH+i8eCsDzoiUCahU2SG9PLNHNMy
	 n5Hb+5s4tBSa9W3Kq3EsgoV5z3WntoguF9cPB/nl9JuOW/dr6RGIUSyvVmL4RiK1Oi
	 UW6cfILn4tSIDwezvCHeEP6zz3F22Bq59Y/LTHPEDXGZ3NmmChSIdeJdP8/HWQ5gv3
	 MMIIdIb6w7xt6tw7GycBuM2ZWZnc7mmf9hxvbmjGZhTs1RL9X85f+zoR/z8iuB8CC4
	 7fommqsRNg7sTcy+2Dxz3qxI1b1A/SD9i0gubXyTJDIOhNb0qTJzGtYWyoH6TQ4KR0
	 cnXpVaIN1BUTw==
Date: Thu, 17 Apr 2025 17:54:34 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev, 
    Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: pm: userspace: drop delete_local_addr
 helper
In-Reply-To: <e3873d83fe93adc6519a67a20c87f90a8d543157.camel@kernel.org>
Message-ID: <2602bf9b-1ffd-b38d-d608-2956711739f2@kernel.org>
References: <cover.1744257362.git.tanggeliang@kylinos.cn> <2b140a3cefd7d5766a79e8c55b73cf2d38c710d0.1744257362.git.tanggeliang@kylinos.cn> <ebdb4b2d-19fe-29ef-65df-d201b201b151@kernel.org> <0caab1005d589bbda1e4e9224757ccc258ab37d4.camel@kernel.org>
 <66f456226a68cc9e5458bb49eae348fadbe8649a.camel@kernel.org> <100ce0ca-d6e3-4ea5-8227-909e671a1ead@kernel.org> <e3873d83fe93adc6519a67a20c87f90a8d543157.camel@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Apr 2025, Geliang Tang wrote:

> Hi Matt,
>
> On Tue, 2025-04-15 at 13:00 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 15/04/2025 11:18, Geliang Tang wrote:
>>> On Tue, 2025-04-15 at 11:09 +0800, Geliang Tang wrote:
>>>> On Fri, 2025-04-11 at 17:26 -0700, Mat Martineau wrote:
>>>>> On Thu, 10 Apr 2025, Geliang Tang wrote:
>>>>>
>>>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>>>
>>>>>> Address entries should not be removed from local_addr_list
>>>>>> when a
>>>>>> subflow
>>>>>> is deleted by the userspace PM, should only be removed when
>>>>>> sending
>>>>>> a
>>>>>> REMOVE_ADDR.
>>>>>>
>>>>>> So mptcp_userspace_pm_delete_local_addr() helper shouldn't be
>>>>>> called in
>>>>>> mptcp_pm_nl_subflow_create_doit() and
>>>>>> mptcp_pm_nl_subflow_destroy_doit().
>>>>>>
>>>>>> Since this helper is open-coding in
>>>>>> mptcp_pm_nl_remove_doit(), it
>>>>>> can be
>>>>>> dropped now.
>>>>>>
>>>>>> Address entries are removed from local_addr_list when sending
>>>>>> a
>>>>>> REMOVE_ADDR
>>>>>> by the userspace PM, the local_addr_used counter of PM should
>>>>>> also
>>>>>> be
>>>>>> decremented accordingly.
>>>>>>
>>>>>
>>>>> Hi Geliang -
>>>>>
>>>>> Have you tried this patch with mptcpd? Does it affect any tests
>>>>> there?
>>>>
>>>> I haven't tested it. To be honest, I don't know how to run the
>>>> test
>>>> items of mptcpd. Can you give me some guidance?
>>
>> 'make check' should execute all the tests. Do you mind trying this
>> with
>> and without your modifications?
>
> This is the output with and without my modifications:
>
> make  check-TESTS
> make[3]: Entering directory '/home/tgl/mptcpd/tests'
> make[4]: Entering directory '/home/tgl/mptcpd/tests'
> PASS: test-plugin
> PASS: test-network-monitor
> PASS: test-path-manager
> PASS: test-commands
> PASS: test-configuration
> PASS: test-id-manager
> PASS: test-listener-manager
> PASS: test-sockaddr
> PASS: test-addr-info
> PASS: test-murmur-hash
> PASS: test-cxx-build
> PASS: test-bad-log-empty
> PASS: test-bad-log-long
> PASS: test-bad-log-short
> PASS: test-bad-option
> PASS: test-bad-path-manager
> PASS: test-bad-plugin-dir
> SKIP: test-start-stop
> PASS: test-mptcpwrap
> =======================================================================
> =====
> Testsuite summary for mptcpd 0.13
> =======================================================================
> =====
> # TOTAL: 19
> # PASS:  18
> # SKIP:  1
> # XFAIL: 0
> # FAIL:  0
> # XPASS: 0
> # ERROR: 0
> =======================================================================
> =====
> make[4]: Leaving directory '/home/tgl/mptcpd/tests'
> make[3]: Leaving directory '/home/tgl/mptcpd/tests'
> make[2]: Leaving directory '/home/tgl/mptcpd/tests'
> make[1]: Leaving directory '/home/tgl/mptcpd/tests'
> Making check in scripts
> make[1]: Entering directory '/home/tgl/mptcpd/scripts'
> make[1]: Nothing to be done for 'check'.
> make[1]: Leaving directory '/home/tgl/mptcpd/scripts'
> make[1]: Entering directory '/home/tgl/mptcpd'
> make[1]: Nothing to be done for 'check-am'.
> make[1]: Leaving directory '/home/tgl/mptcpd'
>

Hi Geliang -

Thanks for running these tests. There is some coverage of the affected 
functionality by the 'test-commands' program, where the "remove_addr - 
user" subtest does send the netlink command. It only checks for whether 
the command worked or wasn't supported though, so not any verification of 
behavior. The only use of the userspace PM "remove subflow" command in the 
existing path manager plugins is in the SSPI plugin where new subflows are 
closed if there's already an existing subflow on a network interface. It 
doesn't look like mptcpd is very sensitive to specific kernel behavior 
here.

>>
>> Please make sure relevant ones are not skipped because of missing
>> dependences or tools.
>>
>>> I just tested it this way, and here are the test results:
>>
>> (...)
>>
>>> These results appear to be unchanged from before. And in fact these
>>> tests do not test userspace pm.
>>
>> I don't remember what is being tested, but I guess some parts of the
>> userspace PM are tested somewhere, no?
>>
>> Coveralls [1] seems to indicate it is tested, but I don't see the
>> details.
>>
>> [1] https://coveralls.io/github/multipath-tcp/mptcpd
>>
>>> So it seems that this patch will not affect the tests of mptcpd.
>>
>> Regarding your patch 2/2 of this series: did you have to modify the
>> selftests to make the tests passing again due to a changed behaviour,
>> or
>> did you modify them to extend the behaviour.
>
> The first one, I tried to make the tests passing again. I updated these
> userspace selftests in v3 to make sure does not change the behaviour of
> these tests.
>
> Thanks,
> -Geliang
>
>>
>> It looks like the behaviour has changed, but it is unclear to me if it 
>> is to fix something or add a new feature.

I do think the behavior is changed to fix a problem - with the existing 
kernel code, mptcpd with the SSPI plugin would un-advertise an address if 
the peer attempted to create a second subflow on that address. This would 
prevent any additional connection attempts by a well-behaved peer, but a 
well-behaved peer would also disconnect its existing subflow in response 
to the remove_addr, right?

The main risk here is that an existing MPTCP user with custom plugin code 
might be assuming the old buggy behavior, and they would have to adjust 
their plugin to handle the new "mptcpd_pm_remove_subflow doesn't 
un-advertise addresses" behavior.


- Mat
