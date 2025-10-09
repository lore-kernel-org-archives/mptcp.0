Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A057298CD5
	for <mptcp@lists.linux.dev>; Thu,  9 Oct 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020234; cv=none; b=Kji4uIwbCXbpuGRpFGAy6Nxs4vpM2j58qS1cyDHn5aEZs/zbZhzz1V6NQZUuZBsP4eeeGlNU2sGl27D9Fv0A3t4WHe3ZiwoCxdlp8I+5locVwecVSBt+EpdVBEBr2PFg9ey6NU6IVoN3rFNFWJXyAFOoWgeQhhyxdIwd4Iifamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020234; c=relaxed/simple;
	bh=ujIBICi5lxiWFIOERWgtT/AZJvtCDmtbcjpTO5Yqldg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uB5da3wC7ReYZwgMHP4QYQB1Gj11RPEICsufE0ekGKlRYfY8ATcb6m1QyDnArsujvo7dvXH4tGBMvqfXTvAtCGFNjGLddNi6w0oG9fhQW+5nGVJO7+YY5ih+1PyPpjSs+1xw7+gNnPhElN3BNzA2orCZ7bbsDFlnDu5TLOX9BuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaeqVDpv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaeqVDpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C70C4CEE7;
	Thu,  9 Oct 2025 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760020233;
	bh=ujIBICi5lxiWFIOERWgtT/AZJvtCDmtbcjpTO5Yqldg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=MaeqVDpveGxUaPeniQhP/a9kc8eu4DpIqAewBU8cbi7j9nukFxb8NVvgD0YhAbMcs
	 slKs7kk945XY45+7uTSF8jGD94J9HWjScsG/wfEaV2ry0B9kIH3QoVe2KIETlZ9sR3
	 mkjRPjVFAQTaY5uRh5jUUB6zxwTuuugjA2S3Kb5gW+iAwVN8TwYE/SIfXl/4ZVPA7Y
	 n3J0nxVFulSs/XkJCx4n6PFlW6UuIk4tKt04Iqvp3WDuNzteTGVKxBG2Zy/CTSA03+
	 13SQCl3yNN+aNW1znHLZJxE5/KtqJq6tKOP1XieRTIQ+l7XFozRYCM8UGpn5BJu7SZ
	 HJcI6TLNMNAKA==
Message-ID: <f4aca085-7f33-402d-a0b4-2d36321f6dbe@kernel.org>
Date: Thu, 9 Oct 2025 16:30:30 +0200
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
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <092fc76415deb1b45da5bb691ef6069fbab7dd09.1758591744.git.tanggeliang@kylinos.cn>
 <20765ed6-3164-4df7-b125-2ee04e90bb23@kernel.org>
 <8ab7f8a1452b6660e97b757286cfe2d6a7faafd4.camel@kernel.org>
 <4cb3a2d4-1f6b-4188-ad2e-065bbf9f3640@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <4cb3a2d4-1f6b-4188-ad2e-065bbf9f3640@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 23/09/2025 10:16, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 23/09/2025 09:03, Geliang Tang wrote:
>> Hi Matt,
>>
>> On Tue, 2025-09-23 at 08:53 +0100, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> On 23/09/2025 02:42, Geliang Tang wrote:
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> Compiling pm_nl_ctl on older versions of glibc will report the
>>>> following
>>>> errors:
>>>>
>>>> '''
>>>>   CC       pm_nl_ctl
>>>> pm_nl_ctl.c: In function 'capture_events':
>>>> pm_nl_ctl.c:204:53: error: 'MPTCP_PM_EV_FLAG_DENY_JOIN_ID0'
>>>> undeclared (first use in this function)
>>>>   204 |                                         if (flags &
>>>> MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
>>>>       |                                                    
>>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> pm_nl_ctl.c:204:53: note: each undeclared identifier is reported
>>>> only once for each function it appears in
>>>> pm_nl_ctl.c:206:53: error: 'MPTCP_PM_EV_FLAG_SERVER_SIDE'
>>>> undeclared (first use in this function); did you mean
>>>> 'MPTCP_ATTR_SERVER_SIDE'?
>>>>   206 |                                         if (flags &
>>>> MPTCP_PM_EV_FLAG_SERVER_SIDE)
>>>>       |                                                    
>>>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>       |                                                    
>>>> MPTCP_ATTR_SERVER_SIDE
>>>> '''
>>>>
>>>> To fix this, this patch redefines MPTCP_PM_EV_FLAG_DENY_JOIN_ID0
>>>> and
>>>> MPTCP_PM_EV_FLAG_SERVER_SIDE in pm_nl_ctl.c.
>>>
>>> You shouldn't get this error, because this file is supposed to be
>>> compiled from the kernel source directory, or at least using the
>>> kernel
>>> headers built from there
>>>
>>> How do you compile this file? Are you not using the Makefile in the
>>
>> I got these errors when compiling the bpf selftests with the commit
>> "selftests/bpf: Add mptcp pm_nl_ctl link" using mptcp-upstream-virtme-
>> docker:
>>
>> https://patchwork.kernel.org/project/mptcp/patch/8cdb0df7316a6baa93df88b0fe78aaa710f3bb72.1738924354.git.tanggeliang@kylinos.cn/
> 
> Mmh, we already had this issue with pm_nl_ctl in BPF selftests in the
> past, and Alexei didn't want to support KHDR_INCLUDES, because these
> selftests are not "proper" KSelftests :-/
> 
> Did you not add "pm_nl_ctl" because the BPF CI was using a tool old
> version of IPRoute? They updated it. So maybe we don't need this patch
> anymore?

If we can use 'ip' instead of 'pm_nl_ctl', we can drop this patch from
Patchwork. Can we do that?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

