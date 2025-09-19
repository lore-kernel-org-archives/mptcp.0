Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA114A60C
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287474; cv=none; b=cwDrEyfug0vR03SNpzUkNgictrKmojaCGNYY9H3cHjVQpniTp/kCK0lv77iBl1gw/4EJRmDF8meuC2aBiwdfrgOFjOmFqSGYcsb+gCZaZWJyxctKX2HiNu45JDAmPLPSuQDtTA5Jup43GUYs0MAgt9mzwk8KH/qfQZdpIMZbLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287474; c=relaxed/simple;
	bh=KoaAh2ZLm6b6wTQ85cZXMb7HOZkdnx8M2DRTa0b8lKM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=nt9pzi8Nz5Va/FaNHRcQqtP2Cq+gHQI3+UtQD2s+fQJ7CU+J+ywkK8I50/Yq/czJIsChpk2mLzl50OCI02uD6gTmz+dPp2KUUXv8A8u/9f4id9eluHsO/51Gp2RsZFtQu+6W1E50IM+GO1++0u2nScZIi1O8096PK9KPmPnwVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjDDZCAr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjDDZCAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8CBC4CEF0;
	Fri, 19 Sep 2025 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758287473;
	bh=KoaAh2ZLm6b6wTQ85cZXMb7HOZkdnx8M2DRTa0b8lKM=;
	h=Date:Subject:From:To:References:Cc:In-Reply-To:From;
	b=hjDDZCArfFBAVCnskX7t9YsHS7XaLmrrbae4wvNB45HPa9hFpIOpTi9ip4xp/5y3H
	 CZdt3L3LWogblAR8FcrfIwHUQO+3Y5kDVwQFpNuRXstILHKDVkdIBsvU8rEvKkRmmb
	 LJPFbJu/HAsbJeoc1rNMNwaXszcjSqZ82vXR8IDZEhgDBK6qWNIuHGm2URPuLFZZZR
	 iwPPOmhqW+QP/FxsKOolvFYZC+COjQkHsBiuQQ3ZqpNkZZPX+KQ6hRuD+t9oqCfR1w
	 JNawn66pxZNBl5/gfsWQ2Klp0ulZBr/U7ADRwZdyW6A8L5B2kb5dLNqwaDbdR/w79f
	 2a4Bae/BcqPHA==
Message-ID: <e5962785-2ea0-42f4-9bda-b609b087730c@kernel.org>
Date: Fri, 19 Sep 2025 15:11:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 00/12] mptcp: receive path improvement
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
 <dd39e243-9ffe-86c0-9db7-6c108470b3b2@gmail.com>
 <0387885e84d41f14cf23914c85d2191f1cdfdae9.camel@kernel.org>
 <7da5cd03-b5ce-4062-a23f-7bd7ecbec38c@redhat.com>
 <79da8979-8a66-4473-8a7d-7cdd96ebc5b1@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <79da8979-8a66-4473-8a7d-7cdd96ebc5b1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/09/2025 10:14, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 19/09/2025 08:54, Paolo Abeni wrote:
>> On 9/19/25 4:22 AM, Geliang Tang wrote:
>>> On Thu, 2025-09-18 at 20:33 +0000, MPTCP CI wrote:
>>>> Hi Paolo,
>>>>
>>>> Thank you for your modifications, that's great!
>>>>
>>>> Our CI did some validations and here is its report:
>>>>
>>>> - KVM Validation: normal: Unstable: 5 failed test(s):
>>>> packetdrill_mp_capable selftest_mptcp_connect
>>>> selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap
>>>> selftest_mptcp_connect_sendfile 🔴
>>>> - KVM Validation: debug: Unstable: 5 failed test(s):
>>>> packetdrill_mp_capable selftest_mptcp_connect
>>>> selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap
>>>> selftest_mptcp_connect_sendfile 🔴
>>>> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
>>>> - KVM Validation: btf-debug (only bpftest_all): Success! ✅
>>>> - Task:
>>>> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17836736262
>>>
>>> CI reports that this series breaks the mptcp_connect.sh test:
>>>
>>> # INFO: disconnect
>>> # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration 
>>> 1348ms) [ OK ]
>>> # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       main_loop_s:
>>> timed out
>>> # (duration 61185ms) [FAIL] client exit code 124, server 2
>>> # 
>>> # netns ns1-HugJD9 (listener) socket stat for 20002:
>>> # Netid State     Recv-Q Send-Q Local Address:Port  Peer Address:Port 
>>> # tcp   TIME-WAIT 0      0           10.0.1.1:20002     10.0.1.1:47722
>>> timer:(timewait,,0) ino:0 sk:2066
>>> # ^I
>>> # TcpActiveOpens                  2                  0.0
>>> # TcpPassiveOpens                 2                  0.0
>>>
>>> I also tested it on my end and found that starting from patch 8 "mptcp:
>>> cleanup fallback data fin reception", the mptcp_connect.sh test has
>>> been failing.
>>>
>>> I apologize for not providing this feedback during the v1 review, but I
>>> was too busy yesterday to complete the testing.
>>
>> Thank you very much for bisecting. I did not observe the failures on v1,
>> but I see them on v2 (which is quite suprising, giving no big changes in
>> there). I submitted v2 anyway to give syzkaller/CI a chance to run more.
> 
> It looks like the CI had the same issues with the v1:
> 
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17795536153

Note that these issues were probably not visible on your side when you
developed the v1, with an older base. For mptcp_connect*.sh, it looks
like they are failing in the 'disconnect' part, due to a recent
modification in the selftests:

https://lore.kernel.org/20250912-net-mptcp-fix-sft-connect-v1-3-d40e77cbbf02@kernel.org

Now the TCP connections are listed, and one stays open. The packetdrill
failure looks strange: a RST is sent in reply to a FIN+ACK.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

