Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF68305058
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269685; cv=none; b=sabK6FUUar3H24SDZf0yXEaZFG1JQTbEtRraAZW99br2vmtWips3EtzUhwGk7cm4F20GVqICn7k/rSK5D9tCU8fO+M/nNjmZfCsu4a9HjSGsdQgmVAswn7VZCh/DedD2iEGAZKX8aslyBCVmqKduClT22Q78qYInjy+xMyk1H+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269685; c=relaxed/simple;
	bh=9vQxYuNIkfSh/pKSCGyXd9IqGp2q04D6dKTvgnF85ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KuQMr+fTde4vJ6m9qz9/8GUOiJbTQg6aZxbjXzOAUuyZLVxd8qIpf35USewDj88Jrg76z6+9gnmA+uZC6BcJoOGcUNXyvOQIyrpmYHOZZBeZyJTXlRiMAVU63WzBH/F8x9M2JHgGTS6lYAHOHIILsvSPNMqr/o75X6VDNQJr8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvNDbOAY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvNDbOAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D537C4CEF0;
	Fri, 19 Sep 2025 08:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758269685;
	bh=9vQxYuNIkfSh/pKSCGyXd9IqGp2q04D6dKTvgnF85ac=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UvNDbOAYDVWw5buihiEqy/Ngx3vxbvOI4dnirSIb6AuI+EpLRBskjXyDr0uvKkfDc
	 sdWh8kw4U088gEpHp77gWADN0LkwLlGn4W+Rk8rI1qeSgVh0ru/WCZhtE01HM06Axr
	 pa2hvgUANsLCR+iC6UbelWFeNSc2MLjwPGMbO2+fO0mSqHP/CO8DdKbntJkJvfE8Oh
	 Zyn9VzE0E6/Pu+ns6q6yDJQPfbmWYF+G5WnOi7EZSK5T6LO0vC0P4si64mZuXuuKOt
	 cPLL6S5r458Sk0VkU5qDN/HaQ07ZO/r1pZRDHb/N/NDX8W/v3XFRksdGm+ry/+9d9Y
	 AulA66Ai52Qjw==
Message-ID: <79da8979-8a66-4473-8a7d-7cdd96ebc5b1@kernel.org>
Date: Fri, 19 Sep 2025 10:14:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 00/12] mptcp: receive path improvement
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <cover.1758214563.git.pabeni@redhat.com>
 <dd39e243-9ffe-86c0-9db7-6c108470b3b2@gmail.com>
 <0387885e84d41f14cf23914c85d2191f1cdfdae9.camel@kernel.org>
 <7da5cd03-b5ce-4062-a23f-7bd7ecbec38c@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7da5cd03-b5ce-4062-a23f-7bd7ecbec38c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 19/09/2025 08:54, Paolo Abeni wrote:
> On 9/19/25 4:22 AM, Geliang Tang wrote:
>> On Thu, 2025-09-18 at 20:33 +0000, MPTCP CI wrote:
>>> Hi Paolo,
>>>
>>> Thank you for your modifications, that's great!
>>>
>>> Our CI did some validations and here is its report:
>>>
>>> - KVM Validation: normal: Unstable: 5 failed test(s):
>>> packetdrill_mp_capable selftest_mptcp_connect
>>> selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap
>>> selftest_mptcp_connect_sendfile 🔴
>>> - KVM Validation: debug: Unstable: 5 failed test(s):
>>> packetdrill_mp_capable selftest_mptcp_connect
>>> selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap
>>> selftest_mptcp_connect_sendfile 🔴
>>> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
>>> - KVM Validation: btf-debug (only bpftest_all): Success! ✅
>>> - Task:
>>> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17836736262
>>
>> CI reports that this series breaks the mptcp_connect.sh test:
>>
>> # INFO: disconnect
>> # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration 
>> 1348ms) [ OK ]
>> # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       main_loop_s:
>> timed out
>> # (duration 61185ms) [FAIL] client exit code 124, server 2
>> # 
>> # netns ns1-HugJD9 (listener) socket stat for 20002:
>> # Netid State     Recv-Q Send-Q Local Address:Port  Peer Address:Port 
>> # tcp   TIME-WAIT 0      0           10.0.1.1:20002     10.0.1.1:47722
>> timer:(timewait,,0) ino:0 sk:2066
>> # ^I
>> # TcpActiveOpens                  2                  0.0
>> # TcpPassiveOpens                 2                  0.0
>>
>> I also tested it on my end and found that starting from patch 8 "mptcp:
>> cleanup fallback data fin reception", the mptcp_connect.sh test has
>> been failing.
>>
>> I apologize for not providing this feedback during the v1 review, but I
>> was too busy yesterday to complete the testing.
> 
> Thank you very much for bisecting. I did not observe the failures on v1,
> but I see them on v2 (which is quite suprising, giving no big changes in
> there). I submitted v2 anyway to give syzkaller/CI a chance to run more.

It looks like the CI had the same issues with the v1:

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17795536153

> I think patch 1-3 should be sane and effective, we can probably merge them.

Thank you for that!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

