Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3D51D5CCD
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973644; cv=none; b=pzDeNRqDj/DWw0TkqnfBcnnwFjxSbQEyc3hMLgnprttkynhEeXw6ykw+KhWUhUuFpjFM+HSvkDTOxQ3t6WEwhqI2db8iU/usuxHpvtDhD+F++iPA6fWy3Zg3/L7n7w2ZTGC9l6U0r7Zbg51eEUXxj+Aho4yLUdPGMc58fHso3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973644; c=relaxed/simple;
	bh=kstKyXexeqL3kbr3H/DKVkLIy3GgaCLfPGdMGfvUBRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHCZY+z6eJ/mYH+AAUn6RXKUnvvpl5soDEzREBZLl9zqHqq4H9MnK4bReh+iHbSbOk280d6OJhO3NSS4fA+6Bl2Il6gChThbGxKd9OOJrfn/NgGO3BSQyD2ZuuwKGfk5uKt8HL/fouJ0V/8HPwiAWrn4MYDByh8OoelXBDSvmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqGLeNUH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqGLeNUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05E2C4CECC;
	Thu,  7 Nov 2024 10:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730973643;
	bh=kstKyXexeqL3kbr3H/DKVkLIy3GgaCLfPGdMGfvUBRM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MqGLeNUHCK6DiaZjGE2sLIAoMtkwyjKYo5SEYT/EmMvWRAUeGJ/NHRjulQdreyksR
	 U97b+SgZDKrDddXbm3PXfS2nHnR7hCkgpFbxajoPS+aNn8UU/U1pC+etMIQZSOlr5I
	 zt8ppqFJf5NOph2foysBojBOI6VJrgknnRAMywWe/cyYgaHIxLP0FVPBDxL9LyoWRk
	 Xfm9mQvlfuuEPLlcfsA6dmQ1rqTPnbtsOcc830upxHVmh14i6uLe9eFZj8zmZ9SD9r
	 w0EnfaOuayrMTOb4hGs9/LDfnI66b171qUzlZYAjARWXIudC6VFuKG/a5OmnQ5kk2E
	 wpn0T4ioF4LWg==
Message-ID: <f1e9d825-189f-4a86-91be-59492ef80ce0@kernel.org>
Date: Thu, 7 Nov 2024 11:00:40 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 23/36] mptcp: drop struct mptcp_pm_local
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <5b8a8e318c9d661f495b6d0be2b7a776de7da7a1.1729588019.git.tanggeliang@kylinos.cn>
 <4661b240-9a9c-47c2-9dc0-362d22baad83@kernel.org>
 <a77c02db831525e2e1ec5371aaea4b9869441c0b.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a77c02db831525e2e1ec5371aaea4b9869441c0b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/11/2024 08:29, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2024-11-04 at 20:08 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 22/10/2024 11:14, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> The following code in mptcp_pm_nl_subflow_create_doit() that
>>> assigns struct
>>> mptcp_pm_addr_entry "entry" to the local struct mptcp_pm_local
>>> variable
>>> "local" is not allowed in BPF if we use the same code to implement
>>> the
>>> subflow_create() interface of a BFP path manager:
>>>
>>> 	struct mptcp_pm_local local;
>>>
>>> 	local.addr = entry.addr;
>>> 	local.flags = entry.flags;
>>> 	local.ifindex = entry.ifindex;
>>
>> Here as well, I'm not sure to understand the issue. Is it because you
>> cannot allocate this structure locally with BPF? No alternatives?
> 
> Here "struct mptcp_pm_local local" is a "scalar", when passing it to
> __mptcp_subflow_connect(), this error occurs:
> 
> # ; err = __mptcp_subflow_connect(sk, &local, remote); @
> mptcp_bpf_userspace_pm.c:242
> # 53: (bf) r1 = r6                      ; R1_w=trusted_ptr_mptcp_sock()
> R6=trusted_ptr_mptcp_sock()
> # 54: (bf) r3 = r8                      ;
> R3_w=trusted_ptr_mptcp_addr_info() R8=trusted_ptr_mptcp_addr_info()
> # 55: (85) call __mptcp_subflow_connect#34404
> # max struct nesting depth exceeded
> # arg#1 pointer type STRUCT mptcp_pm_local must point to scalar, or
> struct with scalar
> 
> Also, assigning an address to an address like this is not allowed in
> BPF:
> 
> 	local.addr = entry.addr;

OK, thank you, that's a bit clearer (even if it is not clear what BPF
code was causing that). For this kind of issue, would it work to add a
BPF-specific kfunc, eventually with additional annotations or arguments,
or taking a "struct mptcp_pm_addr_entry" in argument, and "simply"
calling __mptcp_subflow_connect() with a "struct mptcp_pm_local"?

So something specific to BPF, without impacting the rest?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

