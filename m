Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76201A83F9
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615371; cv=none; b=EFA5/DghRgZ1jj9FAHMizlfjLKtcrM1zTX5bSYzVIxDGbvtvWfkBpmFU5Qlfb23dlQJMVZ+qEj7YJcpZGJqR8wB0IX8ERn3rCbT4uooPEqr3fzXtKrlQNckR513luKZcu7urLsO1OlUAiReIb5tJ1MRn7SRlRUwftqan9tVTxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615371; c=relaxed/simple;
	bh=HwZEARQP5FaweXlZ7RXWZa18qZdr2hlJTEHtC4TVKjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtzsifxGdZEHVUpgLJ2sniPrXNOAbmFSNSt6HqN454jUdlj7+3dgTHp4JgTxQVrzus9jhqL+aftNWQoZsYjvALAb0kI39//LgRQtDjM332yPK0R/7HUQ0V2ysV5lphkNKofq1MTS4B9vDefGymH0sN0fKBGAKL2ZYg7g+MVOHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irE7yVJv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irE7yVJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B07C4CEF5;
	Tue, 23 Sep 2025 08:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758615371;
	bh=HwZEARQP5FaweXlZ7RXWZa18qZdr2hlJTEHtC4TVKjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=irE7yVJvzdiKnpzPu1lI5yE0IeryKdp7HUIC3JJdhluxtn+uChWF/+kq2sVnrH9bJ
	 DrfWjIDUO/RHJiYjzx7Eb7VyjXCbgN/5zzn/WRf0x29eVOTfB/PyiajGYjL2g9+wQ3
	 emWdWt9AB/nhXaSrv9hMGvF43TlmTQKd8w5UTpxmC7M2GiyxUCUFTAL5qqQ/6t1qh1
	 7MJUCpSHh5fkdkRuE4Pm/wrA23L+XQ05RoFhRVowQ3lAYX1qQwC2Sc/qMOD+ux3HIm
	 8UsgaQN/hXwz4PMdRrgYHvWN9ncTk85i9/1YbTZhom9A4Jdoskd2YtA7JP2l9T4CLF
	 nTk0udT6MCNag==
Message-ID: <4cb3a2d4-1f6b-4188-ad2e-065bbf9f3640@kernel.org>
Date: Tue, 23 Sep 2025 09:16:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] selftests: mptcp: pm: fix pm_nl_ctl build
 errors with old glibc
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <092fc76415deb1b45da5bb691ef6069fbab7dd09.1758591744.git.tanggeliang@kylinos.cn>
 <20765ed6-3164-4df7-b125-2ee04e90bb23@kernel.org>
 <8ab7f8a1452b6660e97b757286cfe2d6a7faafd4.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8ab7f8a1452b6660e97b757286cfe2d6a7faafd4.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 23/09/2025 09:03, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2025-09-23 at 08:53 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 23/09/2025 02:42, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> Compiling pm_nl_ctl on older versions of glibc will report the
>>> following
>>> errors:
>>>
>>> '''
>>>   CC       pm_nl_ctl
>>> pm_nl_ctl.c: In function 'capture_events':
>>> pm_nl_ctl.c:204:53: error: 'MPTCP_PM_EV_FLAG_DENY_JOIN_ID0'
>>> undeclared (first use in this function)
>>>   204 |                                         if (flags &
>>> MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
>>>       |                                                    
>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> pm_nl_ctl.c:204:53: note: each undeclared identifier is reported
>>> only once for each function it appears in
>>> pm_nl_ctl.c:206:53: error: 'MPTCP_PM_EV_FLAG_SERVER_SIDE'
>>> undeclared (first use in this function); did you mean
>>> 'MPTCP_ATTR_SERVER_SIDE'?
>>>   206 |                                         if (flags &
>>> MPTCP_PM_EV_FLAG_SERVER_SIDE)
>>>       |                                                    
>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>       |                                                    
>>> MPTCP_ATTR_SERVER_SIDE
>>> '''
>>>
>>> To fix this, this patch redefines MPTCP_PM_EV_FLAG_DENY_JOIN_ID0
>>> and
>>> MPTCP_PM_EV_FLAG_SERVER_SIDE in pm_nl_ctl.c.
>>
>> You shouldn't get this error, because this file is supposed to be
>> compiled from the kernel source directory, or at least using the
>> kernel
>> headers built from there
>>
>> How do you compile this file? Are you not using the Makefile in the
> 
> I got these errors when compiling the bpf selftests with the commit
> "selftests/bpf: Add mptcp pm_nl_ctl link" using mptcp-upstream-virtme-
> docker:
> 
> https://patchwork.kernel.org/project/mptcp/patch/8cdb0df7316a6baa93df88b0fe78aaa710f3bb72.1738924354.git.tanggeliang@kylinos.cn/

Mmh, we already had this issue with pm_nl_ctl in BPF selftests in the
past, and Alexei didn't want to support KHDR_INCLUDES, because these
selftests are not "proper" KSelftests :-/

Did you not add "pm_nl_ctl" because the BPF CI was using a tool old
version of IPRoute? They updated it. So maybe we don't need this patch
anymore?

> 
> Thanks,
> -Geliang
> 
>> same
>> folder? Or do you have a separate build dir and you didn't specify
>> KHDR_INCLUDES?
>>
>>   make headers_install INSTALL_HDR_PATH="${HEADERS}"
>>   make KHDR_INCLUDES="-I${HEADERS}/include" \
>>        -C tools/testing/selftests/net/mptcp
>>
>> Or use the kselftests scripts:
>>
>>   make -C tools/testing/selftests TARGETS=net/mptcp install \
>>        INSTALL_PATH=${INSTALL}
>>   cd ${INSTALL}
>>   ./run_kselftest.sh -c net/mptcp
>>
>>
>> Cheers,
>> Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

